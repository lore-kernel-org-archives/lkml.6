Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752282AbeFDKAy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:00:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33718 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752116AbeFDKAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:00:52 -0400
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 00/19]  Fixes for sched/numa_balancing
Date: Mon,  4 Jun 2018 15:30:09 +0530
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18060410-0020-0000-0000-0000029672F0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060410-0021-0000-0000-000020E206A4
Message-Id: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806040123
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset based on v4.17-rc5, provides few simple cleanups and fixes in
the sched/numa_balancing code. Some of these fixes are specific to systems
having more than 2 nodes. Few patches add per-rq and per-node complexities
to solve what I feel are a fairness/correctness issues.


Here are the scripts used to benchmark this series
They are based on Andrea Arcangeli and Petr Holasek's
https://github.com/pholasek/autonuma-benchmark.git

# cat numa01.sh
#! /bin/bash
# numa01.sh corresponds to 2 perf bench processes each having ncpus/2 threads
# 50 loops of 3G process memory.

THREADS=${THREADS:-$(($(getconf _NPROCESSORS_ONLN)/2))}
perf bench numa mem --no-data_rand_walk $CPUS -p 2 -t $THREADS -G 0 -P 3072 -T 0 -l 50 -c -s 2000 $@


# cat numa02.sh
#! /bin/bash
# numa02.sh corresponds to  1 perf bench process having ncpus threads
# 800 loops of 32 MB thread specific memory.
THREADS=$(getconf _NPROCESSORS_ONLN)
perf bench numa mem --no-data_rand_walk -p 1 -t $THREADS -G 0 -P 0 -T 32 -l 800 -c -s 2000 $@



# cat numa03.sh
#! /bin/bash
# numa03.sh corresponds to 1 perf bench process having ncpus threads
# 50 loops of 3G process memory.

THREADS=$(getconf _NPROCESSORS_ONLN)
perf bench numa mem --no-data_rand_walk -p 1 -t $THREADS -G 0 -P 3072 -T 0 -l 50 -c -s 2000 $@


# cat numa04.sh
#! /bin/bash
# numa04.sh corresponds to nrnodes perf bench processes each having
# ncpus/nrnodes threads 50 loops of 3G process memory.

NODES=$(numactl -H |awk /available/'{print $2}')
INST=$NODES
THREADS=$(($(getconf _NPROCESSORS_ONLN)/$INST))
perf bench numa mem --no-data_rand_walk -p $INST -t $THREADS -G 0 -P 3072 -T 0 -l 50 -c -s 2000 $@


# cat numa05.sh
#! /bin/bash
# numa05.sh corresponds to nrnodes *2  perf bench processes each having
# ncpus/(nrnodes *2 ) threads 50 loops of 3G process memory.


NODES=$(numactl -H |awk /available/'{print $2}')
INST=$((2*NODES))
THREADS=$(($(getconf _NPROCESSORS_ONLN)/$INST))
perf bench numa mem --no-data_rand_walk -p $INST -t $THREADS -G 0 -P 3072 -T 0 -l 50 -c -s 2000 $@

Stats were collected on a 4 node/96 cpu machine.

# numactl -H
available: 4 nodes (0-3)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
node 0 size: 32431 MB
node 0 free: 30759 MB
node 1 cpus: 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47
node 1 size: 31961 MB
node 1 free: 30502 MB
node 2 cpus: 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71
node 2 size: 30425 MB
node 2 free: 30189 MB
node 3 cpus: 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95
node 3 size: 32200 MB
node 3 free: 31346 MB
node distances:
node   0   1   2   3
  0:  10  20  40  40
  1:  20  10  40  40
  2:  40  40  10  20
  3:  40  40  20  10

Since we are looking for time as a metric, smaller numbers are better.

v4.17-rc5
Testcase       Time:         Min         Max         Avg      StdDev
numa01.sh      Real:      440.65      941.32      758.98      189.17
numa01.sh       Sys:      183.48      320.07      258.42       50.09
numa01.sh      User:    37384.65    71818.14    60302.51    13798.96
numa02.sh      Real:       61.24       65.35       62.49        1.49
numa02.sh       Sys:       16.83       24.18       21.40        2.60
numa02.sh      User:     5219.59     5356.34     5264.03       49.07
numa03.sh      Real:      822.04      912.40      873.55       37.35
numa03.sh       Sys:      118.80      140.94      132.90        7.60
numa03.sh      User:    62485.19    70025.01    67208.33     2967.10
numa04.sh      Real:      690.66      872.12      778.49       65.44
numa04.sh       Sys:      459.26      563.03      494.03       42.39
numa04.sh      User:    51116.44    70527.20    58849.44     8461.28
numa05.sh      Real:      418.37      562.28      525.77       54.27
numa05.sh       Sys:      299.45      481.00      392.49       64.27
numa05.sh      User:    34115.09    41324.02    39105.30     2627.68


v4.17-rc5+patches
Testcase       Time:         Min         Max         Avg      StdDev    %Change
numa01.sh      Real:      424.63      566.18      498.12       59.26    34.36%
numa01.sh       Sys:      160.19      256.53      208.98       37.02    19.13%
numa01.sh      User:    37320.00    46225.58    42001.57     3482.45    30.34%
numa02.sh      Real:       60.17       62.47       60.91        0.85    2.528%
numa02.sh       Sys:       15.30       22.82       17.04        2.90    20.37%
numa02.sh      User:     5202.13     5255.51     5219.08       20.14    0.853%
numa03.sh      Real:      823.91      844.89      833.86        8.46    4.543%
numa03.sh       Sys:      130.69      148.29      140.47        6.21    -5.69%
numa03.sh      User:    62519.15    64262.20    63613.38      620.05    5.348%
numa04.sh      Real:      515.30      603.74      548.56       30.93    29.53%
numa04.sh       Sys:      459.73      525.48      489.18       21.63    0.981%
numa04.sh      User:    40561.96    44919.18    42047.87     1526.85    28.55%
numa05.sh      Real:      396.58      454.37      421.13       19.71    19.90%
numa05.sh       Sys:      208.72      422.02      348.90       73.60    11.10%
numa05.sh      User:    33124.08    36109.35    34846.47     1089.74    10.89%


Even the perf bench o/p (not included here because its pretty verbose)
points to a better consolidation. Attaching perf stat data instead.

Performance counter stats for 'system wide' (5 runs): numa01.sh
					               v4.17-rc5         v4.17-rc5+patches
cs                                          196,530 ( +- 13.22% )            117,524 ( +-  7.46% )
migrations                                   16,077 ( +- 16.98% )              6,602 ( +-  9.93% )
faults                                    1,698,631 ( +-  6.66% )          1,292,159 ( +-  3.99% )
cache-misses                         32,841,908,826 ( +-  5.33% )     27,059,597,808 ( +-  2.17% )
sched:sched_move_numa                           555 ( +- 25.92% )                  8 ( +- 38.45% )
sched:sched_stick_numa                           16 ( +- 20.73% )                  1 ( +- 31.18% )
sched:sched_swap_numa                           313 ( +- 23.21% )                278 ( +-  5.31% )
migrate:mm_migrate_pages                    138,981 ( +- 13.26% )            121,639 ( +-  8.75% )
migrate:mm_numa_migrate_ratelimit               439 ( +-100.00% )                138 ( +-100.00% )
seconds time elapsed     	      759.019898884 ( +- 12.46% )      498.158680658 ( +-  5.95% )

Numa Hinting and other vmstat info (Sum of 5 runs)

numa01.sh               v4.17-rc5         v4.17-rc5+patches
numa_foreign            0                 0
numa_hint_faults        7283263           5389142
numa_hint_faults_local  3689375           2209029
numa_hit                1401549           1264559
numa_huge_pte_updates   0                 0
numa_interleave         0                 0
numa_local              1401487           1264534
numa_miss               0                 0
numa_other              62                25
numa_pages_migrated     693724            608024
numa_pte_updates        7320797           5410463
pgfault                 8514248           6474639
pgmajfault              351               203
pgmigrate_fail          1181              171
pgmigrate_success       693724            608024

Faults and page migrations have decreased and that correlates with perf stat
numbers. We are achieving faster and better consolidation with lesser task
migrations. Esp number of failed numa task migrations have decreased.



Performance counter stats for 'system wide' (5 runs): numa02.sh
					               v4.17-rc5         v4.17-rc5+patches
cs                                           33,541 ( +-  2.20% )             33,472 ( +-  2.58% )
migrations                                    2,022 ( +-  2.36% )              1,742 ( +-  4.36% )
faults                                      452,697 ( +-  6.29% )            400,244 ( +-  3.14% )
cache-misses                          4,559,889,977 ( +-  0.40% )      4,510,581,926 ( +-  0.17% )
sched:sched_move_numa                            27 ( +- 40.26% )                  2 ( +- 32.39% )
sched:sched_stick_numa                            0                                0
sched:sched_swap_numa                             9 ( +- 41.81% )                  8 ( +- 23.39% )
migrate:mm_migrate_pages                     23,428 ( +-  6.91% )             19,418 ( +-  9.28% )
migrate:mm_numa_migrate_ratelimit               238 ( +- 61.52% )                315 ( +- 66.65% )
seconds time elapsed      	       62.532524687 ( +-  1.20% )       60.943143605 ( +-  0.70% )

Numa Hinting and other vmstat info (Sum of 5 runs)

numa02.sh		v4.17-rc5         v4.17-rc5+patches
numa_foreign            0                 0
numa_hint_faults        1797406           1541180
numa_hint_faults_local  1652638           1423986
numa_hit                447642            427011
numa_huge_pte_updates   0                 0
numa_interleave         0                 0
numa_local              447639            427011
numa_miss               0                 0
numa_other              3                 0
numa_pages_migrated     117142            97088
numa_pte_updates        1812907           1557075
pgfault                 2273993           2011485
pgmajfault              112               119
pgmigrate_fail          0                 0
pgmigrate_success       117142            97088

Again, lesser page faults, lesser page migrations but hitting page
migrations ratelimits more often.




Performance counter stats for 'system wide' (5 runs): numa03.sh
					               v4.17-rc5         v4.17-rc5+patches
cs                                          184,615 ( +-  2.83% )           178,526 ( +-  2.66% )
migrations                                   14,010 ( +-  4.68% )             9,511 ( +-  4.20% )
faults                                      766,543 ( +-  2.55% )           835,876 ( +-  6.09% )
cache-misses                         34,905,163,767 ( +-  0.75% )    35,979,821,603 ( +-  0.30% )
sched:sched_move_numa                           562 ( +-  6.38% )                 4 ( +- 22.64% )
sched:sched_stick_numa                           16 ( +- 16.42% )                 1 ( +- 61.24% )
sched:sched_swap_numa                           268 ( +-  4.88% )               394 ( +-  6.05% )
migrate:mm_migrate_pages                     53,999 ( +-  5.89% )            51,520 ( +-  8.68% )
migrate:mm_numa_migrate_ratelimit                 0                             508 ( +- 76.69% )
seconds time elapsed     	      873.586758847 ( +-  2.14% )     833.910858522 ( +-  0.51% )

Numa Hinting and other vmstat info (Sum of 5 runs)

numa03.sh		v4.17-rc5         v4.17-rc5+patches
numa_foreign            0                 0
numa_hint_faults        2962951           3275731
numa_hint_faults_local  1159054           1215206
numa_hit                702071            693754
numa_huge_pte_updates   0                 0
numa_interleave         0                 0
numa_local              702042            693722
numa_miss               0                 0
numa_other              29                32
numa_pages_migrated     269918            256838
numa_pte_updates        2963554           3305006
pgfault                 3853016           4193700
pgmajfault              202               281
pgmigrate_fail          77                764
pgmigrate_success       269918            256838

Seeing more faults and cache misses but lesser task migrations. Increase in
migration ratelimits is a worry.




Performance counter stats for 'system wide' (5 runs): numa04.sh

					               v4.17-rc5         v4.17-rc5+patches
cs                                          203,184 ( +-  6.67% )            141,653 ( +-  3.26% )
migrations                                   17,852 ( +- 12.84% )              6,837 ( +-  5.14% )
faults                                    3,650,884 ( +-  3.15% )          2,910,839 ( +-  1.36% )
cache-misses                         34,362,104,705 ( +-  2.26% )     30,064,624,934 ( +-  1.18% )
sched:sched_move_numa                           923 ( +- 21.36% )                  8 ( +- 30.22% )
sched:sched_stick_numa                           10 ( +- 23.89% )                  1 ( +- 46.77% )
sched:sched_swap_numa                           350 ( +- 21.32% )                261 ( +-  7.80% )
migrate:mm_migrate_pages                    288,410 ( +-  4.10% )            296,726 ( +-  3.33% )
migrate:mm_numa_migrate_ratelimit                 0                              162 ( +-100.00% )
seconds time elapsed     	      778.519948731 ( +-  4.20% )      548.606652462 ( +-  2.82% )

Numa Hinting and other vmstat info (Sum of 5 runs)

numa04.sh		v4.17-rc5         v4.17-rc5+patches
numa_foreign            0                 0
numa_hint_faults        16506833          12815656
numa_hint_faults_local  10237480          7526798
numa_hit                2617983           2647923
numa_huge_pte_updates   0                 0
numa_interleave         0                 0
numa_local              2617962           2647914
numa_miss               0                 0
numa_other              21                9
numa_pages_migrated     1441453           1481743
numa_pte_updates        16519819          12844781
pgfault                 18274350          14567947
pgmajfault              264               180
pgmigrate_fail          595               1889
pgmigrate_success       1441453           1481743

Lesser faults, page migrations and task migrations but increasing hitting
migrate ratelimits.




Performance counter stats for 'system wide' (5 runs): numa05.sh
					               v4.17-rc5         v4.17-rc5+patches
cs                                          149,941 ( +-  5.30% )            119,881 ( +-  9.39% )
migrations                                   10,478 ( +- 13.01% )              4,901 ( +-  6.53% )
faults                                    6,457,542 ( +-  3.07% )          5,799,805 ( +-  1.62% )
cache-misses                         31,146,034,587 ( +-  1.40% )     29,894,482,788 ( +-  0.73% )
sched:sched_move_numa                           667 ( +- 27.46% )                  6 ( +- 21.28% )
sched:sched_stick_numa                            3 ( +- 27.28% )                  0
sched:sched_swap_numa                           173 ( +- 20.79% )                113 ( +- 17.60% )
migrate:mm_migrate_pages                    419,446 ( +-  4.94% )            325,522 ( +- 13.88% )
migrate:mm_numa_migrate_ratelimit             1,714 ( +- 66.17% )                338 ( +- 45.02% )
seconds time elapsed     	      525.801216597 ( +-  5.16% )      421.186302929 ( +-  2.34% )

Numa Hinting and other vmstat info (Sum of 5 runs)

numa05.sh		v4.17-rc5         v4.17-rc5+patches
numa_foreign            0                 0
numa_hint_faults        29575825          26294424
numa_hint_faults_local  21637356          21808958
numa_hit                4246286           3771867
numa_huge_pte_updates   0                 0
numa_interleave         0                 0
numa_local              4246270           3771854
numa_miss               0                 0
numa_other              16                13
numa_pages_migrated     2096896           1625671
numa_pte_updates        29620565          26399455
pgfault                 32309072          29013170
pgmajfault              285               255
pgmigrate_fail          334               1937
pgmigrate_success       2096896           1625671

Faults and page migrations have decreased . We are achieving faster and
better consolidation with lesser task migrations. Esp ratio of swap/move numa
task migrations has increased.

Srikar Dronamraju (19):
  sched/numa: Remove redundant field.
  sched/numa: Evaluate move once per node
  sched/numa: Simplify load_too_imbalanced
  sched/numa: Set preferred_node based on best_cpu
  sched/numa: Use task faults only if numa_group is not yet setup
  sched/debug: Reverse the order of printing faults
  sched/numa: Skip nodes that are at hoplimit
  sched/numa: Remove unused task_capacity from numa_stats
  sched/numa: Modify migrate_swap to accept additional params
  sched/numa: Stop multiple tasks from moving to the cpu at the same time
  sched/numa: Restrict migrating in parallel to the same node.
  sched:numa Remove numa_has_capacity
  mm/migrate: Use xchg instead of spinlock
  sched/numa: Updation of scan period need not be in lock
  sched/numa: Use group_weights to identify if migration degrades locality
  sched/numa: Detect if node actively handling migration
  sched/numa: Pass destination cpu as a parameter to migrate_task_rq
  sched/numa: Reset scan rate whenever task moves across nodes
  sched/numa: Move task_placement closer to numa_migrate_preferred

 include/linux/mmzone.h  |   4 +-
 include/linux/sched.h   |   1 -
 kernel/sched/core.c     |  11 +-
 kernel/sched/deadline.c |   2 +-
 kernel/sched/debug.c    |   4 +-
 kernel/sched/fair.c     | 328 +++++++++++++++++++++++-------------------------
 kernel/sched/sched.h    |   6 +-
 mm/migrate.c            |   8 +-
 mm/page_alloc.c         |   2 +-
 9 files changed, 178 insertions(+), 188 deletions(-)

--
1.8.3.1
