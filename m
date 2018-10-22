Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D20AC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D29B20645
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IuL98/sy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D29B20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbeJVX2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 19:28:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58536 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbeJVX2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 19:28:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9MF4HsB151125;
        Mon, 22 Oct 2018 15:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=bieIWvbDOVTgJZqn2FMpD1LM637uSPgdDTNpV+3syoU=;
 b=IuL98/sy0kh8uaeTzFWkPdtjzdrF14ENceXCqoVOw+59Dt8UCsCmmD8wLhWBh8NMxDY8
 VJoMvNZ/9kJKRNl91vF2tTkrp7sjBvytX+AMb70xA5UYq6VvrpaLJjSIDLxlWZJHTvO8
 iWmA6cF8d2qstC4y3G2+IAcFXpImsy/xDhMSIljf4BFEYaCD6QTHOUGXJN7ZiTPRKRWF
 7HMGk9bRUrb0cBR8FtVlZhA47dyXNrGzgdg0OAQpt5bl5aL4Nf7RRLpQ7nZhnMp/M+lk
 OqqY7ZOVaSjokY7IKeoITEeeEHNcpvhXIMLGGYVDHi9ljgEKBkamXOv5sy3O/Uuw5d7W gg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2n7usty8fd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 15:09:06 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9MF96wb008773
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 15:09:06 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9MF95Qw020718;
        Mon, 22 Oct 2018 15:09:05 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Oct 2018 08:09:05 -0700
From:   Steve Sistare <steven.sistare@oracle.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        rohit.k.jain@oracle.com, daniel.m.jordan@oracle.com,
        pavel.tatashin@microsoft.com, matt@codeblueprint.co.uk,
        umgwanakikbuti@gmail.com, riel@redhat.com, jbacik@fb.com,
        juri.lelli@redhat.com, steven.sistare@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] steal tasks to improve CPU utilization
Date:   Mon, 22 Oct 2018 07:59:31 -0700
Message-Id: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9053 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810220129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a CPU has no more CFS tasks to run, and idle_balance() fails to
find a task, then attempt to steal a task from an overloaded CPU in the
same LLC. Maintain and use a bitmap of overloaded CPUs to efficiently
identify candidates.  To minimize search time, steal the first migratable
task that is found when the bitmap is traversed.  For fairness, search
for migratable tasks on an overloaded CPU in order of next to run.

This simple stealing yields a higher CPU utilization than idle_balance()
alone, because the search is cheap, so it may be called every time the CPU
is about to go idle.  idle_balance() does more work because it searches
widely for the busiest queue, so to limit its CPU consumption, it declines
to search if the system is too busy.  Simple stealing does not offload the
globally busiest queue, but it is much better than running nothing at all.

The bitmap of overloaded CPUs is a new type of sparse bitmap, designed to
reduce cache contention vs the usual bitmap when many threads concurrently
set, clear, and visit elements.

Patch 1 defines the sparsemask type and its operations.

Patches 2, 3, and 4 implement the bitmap of overloaded CPUs.

Patches 5 and 6 refactor existing code for a cleaner merge of later
  patches.

Patches 7 and 8 implement task stealing using the overloaded CPUs bitmap.

Patch 9 disables stealing on systems with more than 2 NUMA nodes for the
time being because of performance regressions that are not due to stealing
per-se.  See the patch description for details.

Patch 10 adds schedstats for comparing the new behavior to the old, and
  provided as a convenience for developers only, not for integration.

The patch series is based on kernel 4.19.0-rc7.  It compiles, boots, and
runs with/without each of CONFIG_SCHED_SMT, CONFIG_SMP, CONFIG_SCHED_DEBUG,
and CONFIG_PREEMPT.  It runs without error with CONFIG_DEBUG_PREEMPT +
CONFIG_SLUB_DEBUG + CONFIG_DEBUG_PAGEALLOC + CONFIG_DEBUG_MUTEXES +
CONFIG_DEBUG_SPINLOCK + CONFIG_DEBUG_ATOMIC_SLEEP.  CPU hot plug and CPU
bandwidth control were tested.

Stealing imprroves utilization with only a modest CPU overhead in scheduler
code.  In the following experiment, hackbench is run with varying numbers
of groups (40 tasks per group), and the delta in /proc/schedstat is shown
for each run, averaged per CPU, augmented with these non-standard stats:

  %find - percent of time spent in old and new functions that search for
    idle CPUs and tasks to steal and set the overloaded CPUs bitmap.

  steal - number of times a task is stolen from another CPU.

X6-2: 1 socket * 10 cores * 2 hyperthreads = 20 CPUs
Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz
hackbench <grps> process 100000
sched_wakeup_granularity_ns=15000000

  baseline
  grps  time  %busy  slice   sched   idle     wake %find  steal
  1    8.084  75.02   0.10  105476  46291    59183  0.31      0
  2   13.892  85.33   0.10  190225  70958   119264  0.45      0
  3   19.668  89.04   0.10  263896  87047   176850  0.49      0
  4   25.279  91.28   0.10  322171  94691   227474  0.51      0
  8   47.832  94.86   0.09  630636 144141   486322  0.56      0

  new
  grps  time  %busy  slice   sched   idle     wake %find  steal  %speedup
  1    5.938  96.80   0.24   31255   7190    24061  0.63   7433  36.1
  2   11.491  99.23   0.16   74097   4578    69512  0.84  19463  20.9
  3   16.987  99.66   0.15  115824   1985   113826  0.77  24707  15.8
  4   22.504  99.80   0.14  167188   2385   164786  0.75  29353  12.3
  8   44.441  99.86   0.11  389153   1616   387401  0.67  38190   7.6

Elapsed time improves by 8 to 36%, and CPU busy utilization is up
by 5 to 22% hitting 99% for 2 or more groups (80 or more tasks).
The cost is at most 0.4% more find time.

Additional performance results follow.  A negative "speedup" is a
regression.  Note: for all hackbench runs, sched_wakeup_granularity_ns
is set to 15 msec.  Otherwise, preemptions increase at higher loads and
distort the comparison between baseline and new.

------------------ 1 Socket Results ------------------

X6-2: 1 socket * 10 cores * 2 hyperthreads = 20 CPUs
Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz
Average of 10 runs of: hackbench <groups> process 100000

            --- base --    --- new ---
  groups    time %stdev    time %stdev  %speedup
       1   8.008    0.1   5.905    0.2      35.6
       2  13.814    0.2  11.438    0.1      20.7
       3  19.488    0.2  16.919    0.1      15.1
       4  25.059    0.1  22.409    0.1      11.8
       8  47.478    0.1  44.221    0.1       7.3

X6-2: 1 socket * 22 cores * 2 hyperthreads = 44 CPUs
Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
Average of 10 runs of: hackbench <groups> process 100000

            --- base --    --- new ---
  groups    time %stdev    time %stdev  %speedup
       1   4.586    0.8   4.596    0.6      -0.3
       2   7.693    0.2   5.775    1.3      33.2
       3  10.442    0.3   8.288    0.3      25.9
       4  13.087    0.2  11.057    0.1      18.3
       8  24.145    0.2  22.076    0.3       9.3
      16  43.779    0.1  41.741    0.2       4.8

KVM 4-cpu
Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz
tbench, average of 11 runs.

  clients    %speedup
        1        16.2
        2        11.7
        4         9.9
        8        12.8
       16        13.7

KVM 2-cpu
Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz

  Benchmark                     %speedup
  specjbb2015_critical_jops          5.7
  mysql_sysb1.0.14_mutex_2          40.6
  mysql_sysb1.0.14_oltp_2            3.9

------------------ 2 Socket Results ------------------

X6-2: 2 sockets * 10 cores * 2 hyperthreads = 40 CPUs
Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz
Average of 10 runs of: hackbench <groups> process 100000

            --- base --    --- new ---
  groups    time %stdev    time %stdev  %speedup
       1   7.945    0.2   7.219    8.7      10.0
       2   8.444    0.4   6.689    1.5      26.2
       3  12.100    1.1   9.962    2.0      21.4
       4  15.001    0.4  13.109    1.1      14.4
       8  27.960    0.2  26.127    0.3       7.0

X6-2: 2 sockets * 22 cores * 2 hyperthreads = 88 CPUs
Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
Average of 10 runs of: hackbench <groups> process 100000

            --- base --    --- new ---
  groups    time %stdev    time %stdev  %speedup
       1   5.826    5.4   5.840    5.0      -0.3
       2   5.041    5.3   6.171   23.4     -18.4
       3   6.839    2.1   6.324    3.8       8.1
       4   8.177    0.6   7.318    3.6      11.7
       8  14.429    0.7  13.966    1.3       3.3
      16  26.401    0.3  25.149    1.5       4.9


X6-2: 2 sockets * 22 cores * 2 hyperthreads = 88 CPUs
Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
Oracle database OLTP, logging disabled, NVRAM storage

  Customers   Users   %speedup
    1200000      40       -1.2
    2400000      80        2.7
    3600000     120        8.9
    4800000     160        4.4
    6000000     200        3.0

X6-2: 2 sockets * 14 cores * 2 hyperthreads = 56 CPUs
Intel(R) Xeon(R) CPU E5-2690 v4 @ 2.60GHz
Results from the Oracle "Performance PIT".

  Benchmark                                           %speedup

  mysql_sysb1.0.14_fileio_56_rndrd                        19.6
  mysql_sysb1.0.14_fileio_56_seqrd                        12.1
  mysql_sysb1.0.14_fileio_56_rndwr                         0.4
  mysql_sysb1.0.14_fileio_56_seqrewr                      -0.3

  pgsql_sysb1.0.14_fileio_56_rndrd                        19.5
  pgsql_sysb1.0.14_fileio_56_seqrd                         8.6
  pgsql_sysb1.0.14_fileio_56_rndwr                         1.0
  pgsql_sysb1.0.14_fileio_56_seqrewr                       0.5

  opatch_time_ASM_12.2.0.1.0_HP2M                          7.5
  select-1_users-warm_asmm_ASM_12.2.0.1.0_HP2M             5.1
  select-1_users_asmm_ASM_12.2.0.1.0_HP2M                  4.4
  swingbenchv3_asmm_soebench_ASM_12.2.0.1.0_HP2M           5.8

  lm3_memlat_L2                                            4.8
  lm3_memlat_L1                                            0.0

  ub_gcc_56CPUs-56copies_Pipe-based_Context_Switching     60.1
  ub_gcc_56CPUs-56copies_Shell_Scripts_1_concurrent        5.2
  ub_gcc_56CPUs-56copies_Shell_Scripts_8_concurrent       -3.0
  ub_gcc_56CPUs-56copies_File_Copy_1024_bufsize_2000_maxblocks 2.4

X5-2: 2 sockets * 18 cores * 2 hyperthreads = 72 CPUs
Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz

  NAS_OMP
  bench class   ncpu    %improved(Mops)
  dc    B       72      1.3
  is    C       72      0.9
  is    D       72      0.7

  sysbench mysql, average of 24 runs
          --- base ---     --- new ---
  nthr   events  %stdev   events  %stdev %speedup
     1    331.0    0.25    331.0    0.24     -0.1
     2    661.3    0.22    661.8    0.22      0.0
     4   1297.0    0.88   1300.5    0.82      0.2
     8   2420.8    0.04   2420.5    0.04     -0.1
    16   4826.3    0.07   4825.4    0.05     -0.1
    32   8815.3    0.27   8830.2    0.18      0.1
    64  12823.0    0.24  12823.6    0.26      0.0

--------------------------------------------------------------

Steve Sistare (10):
  sched: Provide sparsemask, a reduced contention bitmap
  sched/topology: Provide hooks to allocate data shared per LLC
  sched/topology: Provide cfs_overload_cpus bitmap
  sched/fair: Dynamically update cfs_overload_cpus
  sched/fair: Hoist idle_stamp up from idle_balance
  sched/fair: Generalize the detach_task interface
  sched/fair: Provide can_migrate_task_llc
  sched/fair: Steal work from an overloaded CPU when CPU goes idle
  sched/fair: disable stealing if too many NUMA nodes
  sched/fair: Provide idle search schedstats

 include/linux/sched/topology.h |   1 +
 include/linux/sparsemask.h     | 260 +++++++++++++++++++++++++++++++
 kernel/sched/core.c            |  30 +++-
 kernel/sched/fair.c            | 338 +++++++++++++++++++++++++++++++++++++----
 kernel/sched/features.h        |   6 +
 kernel/sched/sched.h           |  13 +-
 kernel/sched/stats.c           |  11 +-
 kernel/sched/stats.h           |  13 ++
 kernel/sched/topology.c        | 117 +++++++++++++-
 lib/Makefile                   |   2 +-
 lib/sparsemask.c               | 142 +++++++++++++++++
 11 files changed, 898 insertions(+), 35 deletions(-)
 create mode 100644 include/linux/sparsemask.h
 create mode 100644 lib/sparsemask.c

-- 
1.8.3.1

