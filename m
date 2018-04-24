Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932706AbeDXAjC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 20:39:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54672 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932611AbeDXAi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 20:38:59 -0400
From: subhra mazumdar <subhra.mazumdar@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, daniel.lezcano@linaro.org,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        rohit.k.jain@oracle.com, subhra.mazumdar@oracle.com
Subject: [RFC/RFT PATCH 0/3] Improve scheduler scalability for fast path
Date: Mon, 23 Apr 2018 17:41:13 -0700
Message-Id: <20180424004116.28151-1-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8872 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=298
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804240003
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current select_idle_sibling first tries to find a fully idle core using
select_idle_core which can potentially search all cores and if it fails it
finds any idle cpu using select_idle_cpu. select_idle_cpu can potentially
search all cpus in the llc domain. This doesn't scale for large llc domains
and will only get worse with more cores in future.

This patch solves the scalability problem by:
-Removing select_idle_core() as it can potentially scan the full LLC domain
 even if there is only one idle core which doesn't scale
-Lowering the lower limit of nr variable in select_idle_cpu() and also
 setting an upper limit to restrict search time

Additionally it also introduces a new per-cpu variable next_cpu to track
the limit of search so that every time search starts from where it ended.
This rotating search window over cpus in LLC domain ensures that idle
cpus are eventually found in case of high load.

Following are the performance numbers with various benchmarks.

Hackbench process on 2 socket, 44 core and 88 threads Intel x86 machine
(lower is better):
groups  baseline           %stdev  patch      	   %stdev
1      	0.5742		   21.13   0.5334 (7.10%)  5.2 
2       0.5776 		   7.87    0.5393 (6.63%)  6.39
4       0.9578             1.12    0.9537 (0.43%)  1.08
8       1.7018             1.35    1.682 (1.16%)   1.33
16      2.9955 		   1.36    2.9849 (0.35%)  0.96
32      5.4354 		   0.59    5.3308 (1.92%)  0.60

Sysbench MySQL on 1 socket, 6 core and 12 threads Intel x86 machine
(higher is better):
threads baseline    	  patch
2       49.53             49.83 (0.61%)
4       89.07		  90 (1.05%)
8	149		  154 (3.31%) 
16	240		  246 (2.56%)
32	357		  351 (-1.69%)
64	428		  428 (-0.03%)
128	473		  469 (-0.92%)

Sysbench PostgresSQL on 1 socket, 6 core and 12 threads Intel x86 machine
(higher is better):
threads baseline	  patch
2	68.35 		  70.07 (2.51%)
4	93.53		  92.54 (-1.05%)
8	125		  127 (1.16%)
16	145		  146 (0.92%)
32	158		  156 (-1.24%)
64	160		  160 (0.47%)

Oracle DB on 2 socket, 44 core and 88 threads Intel x86 machine
(normalized, higher is better):
users   baseline	%stdev  patch   	 %stdev
20	1		1.35	1.0075 (0.75%)	 0.71
40	1		0.42	0.9971 (-0.29%)	 0.26
60	1		1.54	0.9955 (-0.45%)	 0.83
80	1		0.58	1.0059 (0.59%)	 0.59
100	1		0.77	1.0201 (2.01%)	 0.39
120	1		0.35	1.0145 (1.45%)	 1.41
140	1		0.19	1.0325 (3.25%)	 0.77
160	1		0.09	1.0277 (2.77%)	 0.57
180	1		0.99	1.0249 (2.49%)	 0.79
200	1		1.03	1.0133 (1.33%)	 0.77
220	1		1.69	1.0317 (3.17%)	 1.41

Uperf pingpong on 2 socket, 44 core and 88 threads Intel x86 machine with
message size = 8k (higher is better):
threads baseline	%stdev  patch   	 %stdev
8	49.47		0.35	50.96 (3.02%)	 0.12
16	95.28		0.77	99.01 (3.92%)	 0.14
32	156.77		1.17	180.64 (15.23%)	 1.05
48	193.24		0.22	214.7 (11.1%)	 1
64	216.21		9.33	252.81 (16.93%)	 1.68
128	379.62		10.29	397.47 (4.75)	 0.41

Dbench on 2 socket, 44 core and 88 threads Intel x86 machine
(higher is better):
clients baseline	patch
1	627.62		629.14 (0.24%)
2	1153.45		1179.9 (2.29%)
4	2060.29		2051.62 (-0.42%)
8	2724.41		2609.4 (-4.22%)
16	2987.56		2891.54 (-3.21%)
32	2375.82		2345.29 (-1.29%)
64	1963.31		1903.61 (-3.04%)
128	1546.01		1513.17 (-2.12%)

Tbench on 2 socket, 44 core and 88 threads Intel x86 machine
(higher is better):                                  
clients baseline	patch
1	279.33		285.154 (2.08%)
2	545.961		572.538 (4.87%)
4	1081.06		1126.51 (4.2%)
8	2158.47		2234.78 (3.53%)
16	4223.78		4358.11 (3.18%)
32	7117.08		8022.19 (12.72%)
64	8947.28		10719.7 (19.81%)
128	15976.7		17531.2 (9.73%)

Iperf on 2 socket, 24 core and 48 threads Intel x86 machine with message
size = 256 (higher is better):
clients  baseline 	 %stdev  patch		%stdev
1	 2699		 4.86	 2697 (-0.1%)	3.74
10	 18832		 0 	 18830 (0%)	0.01
100	 18830           0.05    18827 (0%)     0.08

Iperf on 2 socket, 24 core and 48 threads Intel x86 machine with message
size = 1K (higher is better):
clients	 baseline	 %stdev  patch 	        %stdev
1	 9414		 0.02	 9414 (0%)	0.01
10	 18832		 0	 18832 (0%)	0
100	 18830		 0.05	 18829 (0%)	0.04

Iperf on 2 socket, 24 core and 48 threads Intel x86 machine with message
size = 4K (higher is better):
clients  baseline	 %stdev  patch    	 %stdev
1	 9414		 0.01	 9414 (0%)	 0
10	 18832		 0	 18832 (0%)	 0
100	 18829		 0.04	 18833 (0%)	 0

Iperf on 2 socket, 24 core and 48 threads Intel x86 machine with message
size = 64K (higher is better):
clients  baseline	 %stdev  patch  	 %stdev
1	 9415		 0.01	 9415 (0%)	 0
10	 18832		 0	 18832 (0%)	 0
100	 18830		 0.04	 18833 (0%)	 0

Iperf on 2 socket, 24 core and 48 threads Intel x86 machine with message
size = 1M (higher is better):
clients  baseline  	 %stdev  patch 		 %stdev
1	 9415		 0.01	 9415 (0%)	 0.01
10	 18832		 0	 18832 (0%)	 0
100	 18830		 0.04	 18819 (-0.1%)	 0.13

JBB on 2 socket, 28 core and 56 threads Intel x86 machine
(higher is better):
		baseline	%stdev	 patch		%stdev
jops		60049		0.65	 60191 (0.2%)	0.99
critical jops	29689		0.76	 29044 (-2.2%)	1.46

Schbench on 2 socket, 24 core and 48 threads Intel x86 machine with 24
tasks (lower is better):
percentile	baseline        %stdev   patch          %stdev
50		5007		0.16	 5003 (0.1%)	0.12
75		10000		0	 10000 (0%)	0
90		16992		0	 16998 (0%)	0.12
95		21984		0	 22043 (-0.3%)	0.83
99		34229		1.2	 34069 (0.5%)	0.87
99.5		39147		1.1	 38741 (1%)	1.1
99.9		49568		1.59	 49579 (0%)	1.78

Ebizzy on 2 socket, 44 core and 88 threads Intel x86 machine
(higher is better):
threads		baseline        %stdev   patch          %stdev
1		26477		2.66	 26646 (0.6%)	2.81
2		52303		1.72	 52987 (1.3%)	1.59
4		100854		2.48	 101824 (1%)	2.42
8		188059		6.91	 189149 (0.6%)	1.75
16		328055		3.42	 333963 (1.8%)	2.03
32		504419		2.23	 492650 (-2.3%)	1.76
88		534999		5.35	 569326 (6.4%)	3.07
156		541703		2.42	 544463 (0.5%)	2.17

NAS: A whole suite of NAS benchmarks were run on 2 socket, 36 core and 72
threads Intel x86 machine with no statistically significant regressions
while giving improvements in some cases. I am not listing the results due
to too many data points.

subhra mazumdar (3):
  sched: remove select_idle_core() for scalability
  sched: introduce per-cpu var next_cpu to track search limit
  sched: limit cpu search and rotate search window for scalability

 include/linux/sched/topology.h |   1 -
 kernel/sched/core.c            |   2 +
 kernel/sched/fair.c            | 116 +++++------------------------------------
 kernel/sched/idle.c            |   1 -
 kernel/sched/sched.h           |  11 +---
 5 files changed, 17 insertions(+), 114 deletions(-)

-- 
2.9.3
