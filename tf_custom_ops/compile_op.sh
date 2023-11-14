#!/bin/bash

# Get TF variables
TF_INC=$(python3 -c 'import tensorflow as tf; print(tf.sysconfig.get_include())')
TF_LIB=$(python3 -c 'import tensorflow as tf; print(tf.sysconfig.get_lib())')

# C++17に変更してTF_LIBにあるso.2ファイルを.soとしてシンボリックリンク
# https://stackoverflow.com/questions/47906589/tensorflow-op-how-to-include-libtensorflow-framework-so
echo $TF_INC
echo $TF_LIB

# Neighbors op
g++ -std=c++14 -shared tf_neighbors/tf_neighbors.cpp tf_neighbors/neighbors/neighbors.cpp cpp_utils/cloud/cloud.cpp -o tf_neighbors.so -fPIC -I$TF_INC -I$TF_INC/external/nsync/public -L$TF_LIB -ltensorflow_framework -O2 -D_GLIBCXX_USE_CXX11_ABI=0
g++ -std=c++14 -shared tf_neighbors/tf_batch_neighbors.cpp tf_neighbors/neighbors/neighbors.cpp cpp_utils/cloud/cloud.cpp -o tf_batch_neighbors.so -fPIC -I$TF_INC -I$TF_INC/external/nsync/public -L$TF_LIB -ltensorflow_framework -O2 -D_GLIBCXX_USE_CXX11_ABI=0

# Subsampling op
g++ -std=c++14 -shared tf_subsampling/tf_subsampling.cpp tf_subsampling/grid_subsampling/grid_subsampling.cpp cpp_utils/cloud/cloud.cpp -o tf_subsampling.so -fPIC -I$TF_INC -I$TF_INC/external/nsync/public -L$TF_LIB -ltensorflow_framework -O2 -D_GLIBCXX_USE_CXX11_ABI=0
g++ -std=c++14 -shared tf_subsampling/tf_batch_subsampling.cpp tf_subsampling/grid_subsampling/grid_subsampling.cpp cpp_utils/cloud/cloud.cpp -o tf_batch_subsampling.so -fPIC -I$TF_INC -I$TF_INC/external/nsync/public -L$TF_LIB -ltensorflow_framework -O2 -D_GLIBCXX_USE_CXX11_ABI=0
