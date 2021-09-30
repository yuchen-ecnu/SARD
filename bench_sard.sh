#!/bin/bash

PENALTY=(2 5 20 30)
BATCH_TIME=(1 3 7 9)
DDL=(1.2 1.3 1.8 2.0)
CAPACITY=(2 3 5 6)
WORKERS=(1000 2000 3000 4000)
REQUESTS=(10000 50000 100000 150000 200000)

dataset=$1
algo=$2
opt=$3

nohup cmake-build-debug/SARD data/${dataset}/${dataset}.node data/${dataset}/${dataset}.edge data/${dataset}/${dataset}.label data/${dataset}/${dataset}.order data/${dataset}/${dataset}_taxi.txt data/${dataset}/${dataset}_order.txt 4 1.5 5000 250000 10 5 $opt ./${dataset}_${algo}-o${opt}_4_1.5x_10_5000_250000_5.txt &
echo "Varying PENALTY"
for penalty in ${PENALTY[@]}
    do
      echo $penalty
      nohup cmake-build-debug/SARD data/${dataset}/${dataset}.node data/${dataset}/${dataset}.edge data/${dataset}/${dataset}.label data/${dataset}/${dataset}.order data/${dataset}/${dataset}_taxi.txt data/${dataset}/${dataset}_order.txt 4 1.5 5000 250000 $penalty 5 $opt ./${dataset}_${algo}-o${opt}_4_1.5x_${penalty}_5000_250000_5.txt &
    done

echo "Varying DDL"
for ddl in ${DDL[@]}
    do
      echo $ddl
      nohup cmake-build-debug/SARD data/${dataset}/${dataset}.node data/${dataset}/${dataset}.edge data/${dataset}/${dataset}.label data/${dataset}/${dataset}.order data/${dataset}/${dataset}_taxi.txt data/${dataset}/${dataset}_order.txt 4 $ddl 5000 250000 10 5 $opt ./${dataset}_${algo}-o${opt}_4_${ddl}x_10_5000_250000_5.txt &
    done

echo "Varying CAPACITY"
for cap in ${CAPACITY[@]}
    do
      echo $cap
      nohup cmake-build-debug/SARD data/${dataset}/${dataset}.node data/${dataset}/${dataset}.edge data/${dataset}/${dataset}.label data/${dataset}/${dataset}.order data/${dataset}/${dataset}_taxi.txt data/${dataset}/${dataset}_order.txt $cap 1.5 5000 250000 10 5 $opt ./${dataset}_${algo}-o${opt}_${cap}_1.5x_10_5000_250000_5.txt &
    done

echo "Varying WORKERS"
for m in ${WORKERS[@]}
    do
      echo $m
      nohup cmake-build-debug/SARD data/${dataset}/${dataset}.node data/${dataset}/${dataset}.edge data/${dataset}/${dataset}.label data/${dataset}/${dataset}.order data/${dataset}/${dataset}_taxi.txt data/${dataset}/${dataset}_order.txt 4 1.5 $m 250000 10 5 $opt ./${dataset}_${algo}-o${opt}_4_1.5x_10_${m}_250000_5.txt &
    done

echo "Varying REQUESTS"
for n in ${REQUESTS[@]}
    do
      echo $n
      nohup cmake-build-debug/SARD data/${dataset}/${dataset}.node data/${dataset}/${dataset}.edge data/${dataset}/${dataset}.label data/${dataset}/${dataset}.order data/${dataset}/${dataset}_taxi.txt data/${dataset}/${dataset}_order.txt 4 1.5 5000 $n 10 5 $opt ./${dataset}_${algo}-o${opt}_4_1.5x_10_5000_${n}_5.txt &
    done

echo "Varying BATCH_TIME"
for n in ${BATCH_TIME[@]}
    do
      echo $n
      nohup cmake-build-debug/SARD data/${dataset}/${dataset}.node data/${dataset}/${dataset}.edge data/${dataset}/${dataset}.label data/${dataset}/${dataset}.order data/${dataset}/${dataset}_taxi.txt data/${dataset}/${dataset}_order.txt 4 1.5 5000 250000 10 $n $opt ./${dataset}_${algo}-o${opt}_4_1.5x_10_5000_250000_${n}.txt &
    done