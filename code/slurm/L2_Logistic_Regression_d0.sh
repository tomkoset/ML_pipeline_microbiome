#!/bin/bash

###############################
#                             #
#  1) Job Submission Options  #
#                             #
###############################

# Name
#SBATCH --job-name=L2_logit-d0

# Resources
# For MPI, increase ntasks-per-node
# For multithreading, increase cpus-per-task
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4GB
#SBATCH --time=5:00:00

# Account
#SBATCH --account=pschloss1
#SBATCH --partition=standard

# Logs
#SBATCH --mail-user=tomkoset@umich.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output=%x-%j.out

# Environment
#SBATCH --export=ALL

# Array
#SBATCH --array=1-100

# vector index starts at 0 so shift array by one

seed=$(($SLURM_ARRAY_TASK_ID - 1))

#####################
#                   #
#  2) Job Commands  #
#                   #
#####################

# Making output dir for snakemake cluster logs
mkdir -p logs/slurm/

Rscript code/R/main.R --seed $seed --model L2_Logistic_Regression --data  test/data/classification_input_day0_data.csv --hyperparams test/data/hyperparams.csv --outcome dx

