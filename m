Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81278C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6B5206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dDBhy3SB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfANQ4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:56:21 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50826 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfANQ4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:56:20 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0EGs7Vs041424;
        Mon, 14 Jan 2019 16:55:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Tj39X0LfHgA2eqlbwabADDzke62N7CiS3We/voOLOqc=;
 b=dDBhy3SBoScHPasPty1xEw4wT8S8N9e1D7pYct8doegc2RmDHP8bmSlhOtv54JELxzw9
 XCC9l+rORVNSxIUyIRewBU57If13F0gTb08SHKFezQQOLr77YF461ntYotkqQYWbEDs+
 dKkwjECg2dN2va4XkWuGPx/0zKZzWFIhN+1CAVNVGyGHrimBJpiPcw9f4PqcyceNHwjg
 Z7SD1OLjCz5wRvkpmI62RoGUZBAIM2KCjeyfQAZscASOm9lgp36m/pYr8zjtZoMaVaKk
 SvSwwgI+laolgZQPKrnp8thcULyiDtvGsvDaAcfENR8SeJPbfCHhPJk5qeldyfZUVCC7 Gw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2pybjneppb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jan 2019 16:55:54 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0EGtsaP001368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jan 2019 16:55:54 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0EGtrjP022435;
        Mon, 14 Jan 2019 16:55:53 GMT
Received: from [10.152.35.100] (/10.152.35.100)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Jan 2019 08:55:53 -0800
Subject: Re: [PATCH v4 00/10] steal tasks to improve CPU utilization
To:     mingo@redhat.com, peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        quentin.perret@arm.com, linux-kernel@vger.kernel.org
References: <1544131696-2888-1-git-send-email-steven.sistare@oracle.com>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <7375c70a-913f-a002-820b-495a1eaeb20b@oracle.com>
Date:   Mon, 14 Jan 2019 11:55:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1544131696-2888-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9136 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901140139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter and Ingo,
  I am waiting for one of you to review, ack, or reject this series.  I
have addressed all known issues.  I have a reviewed-by from Valentin and a 
tested-by from Vincent which I will add to v5 if you approve the patch.

- Steve

On 12/6/2018 4:28 PM, Steve Sistare wrote:
> When a CPU has no more CFS tasks to run, and idle_balance() fails to
> find a task, then attempt to steal a task from an overloaded CPU in the
> same LLC. Maintain and use a bitmap of overloaded CPUs to efficiently
> identify candidates.  To minimize search time, steal the first migratable
> task that is found when the bitmap is traversed.  For fairness, search
> for migratable tasks on an overloaded CPU in order of next to run.
> 
> This simple stealing yields a higher CPU utilization than idle_balance()
> alone, because the search is cheap, so it may be called every time the CPU
> is about to go idle.  idle_balance() does more work because it searches
> widely for the busiest queue, so to limit its CPU consumption, it declines
> to search if the system is too busy.  Simple stealing does not offload the
> globally busiest queue, but it is much better than running nothing at all.
> 
> The bitmap of overloaded CPUs is a new type of sparse bitmap, designed to
> reduce cache contention vs the usual bitmap when many threads concurrently
> set, clear, and visit elements.
> 
> Patch 1 defines the sparsemask type and its operations.
> 
> Patches 2, 3, and 4 implement the bitmap of overloaded CPUs.
> 
> Patches 5 and 6 refactor existing code for a cleaner merge of later
>   patches.
> 
> Patches 7 and 8 implement task stealing using the overloaded CPUs bitmap.
> 
> Patch 9 disables stealing on systems with more than 2 NUMA nodes for the
> time being because of performance regressions that are not due to stealing
> per-se.  See the patch description for details.
> 
> Patch 10 adds schedstats for comparing the new behavior to the old, and
>   provided as a convenience for developers only, not for integration.
> 
> The patch series is based on kernel 4.20.0-rc1.  It compiles, boots, and
> runs with/without each of CONFIG_SCHED_SMT, CONFIG_SMP, CONFIG_SCHED_DEBUG,
> and CONFIG_PREEMPT.  It runs without error with CONFIG_DEBUG_PREEMPT +
> CONFIG_SLUB_DEBUG + CONFIG_DEBUG_PAGEALLOC + CONFIG_DEBUG_MUTEXES +
> CONFIG_DEBUG_SPINLOCK + CONFIG_DEBUG_ATOMIC_SLEEP.  CPU hot plug and CPU
> bandwidth control were tested.
> 
> Stealing improves utilization with only a modest CPU overhead in scheduler
> code.  In the following experiment, hackbench is run with varying numbers
> of groups (40 tasks per group), and the delta in /proc/schedstat is shown
> for each run, averaged per CPU, augmented with these non-standard stats:
> 
>   %find - percent of time spent in old and new functions that search for
>     idle CPUs and tasks to steal and set the overloaded CPUs bitmap.
> 
>   steal - number of times a task is stolen from another CPU.
> 
> X6-2: 1 socket * 10 cores * 2 hyperthreads = 20 CPUs
> Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz
> hackbench <grps> process 100000
> sched_wakeup_granularity_ns=15000000
> 
>   baseline
>   grps  time  %busy  slice   sched   idle     wake %find  steal
>   1    8.084  75.02   0.10  105476  46291    59183  0.31      0
>   2   13.892  85.33   0.10  190225  70958   119264  0.45      0
>   3   19.668  89.04   0.10  263896  87047   176850  0.49      0
>   4   25.279  91.28   0.10  322171  94691   227474  0.51      0
>   8   47.832  94.86   0.09  630636 144141   486322  0.56      0
> 
>   new
>   grps  time  %busy  slice   sched   idle     wake %find  steal  %speedup
>   1    5.938  96.80   0.24   31255   7190    24061  0.63   7433  36.1
>   2   11.491  99.23   0.16   74097   4578    69512  0.84  19463  20.9
>   3   16.987  99.66   0.15  115824   1985   113826  0.77  24707  15.8
>   4   22.504  99.80   0.14  167188   2385   164786  0.75  29353  12.3
>   8   44.441  99.86   0.11  389153   1616   387401  0.67  38190   7.6
> 
> Elapsed time improves by 8 to 36%, and CPU busy utilization is up
> by 5 to 22% hitting 99% for 2 or more groups (80 or more tasks).
> The cost is at most 0.4% more find time.
> 
> Additional performance results follow.  A negative "speedup" is a
> regression.  Note: for all hackbench runs, sched_wakeup_granularity_ns
> is set to 15 msec.  Otherwise, preemptions increase at higher loads and
> distort the comparison between baseline and new.
> 
> ------------------ 1 Socket Results ------------------
> 
> X6-2: 1 socket * 10 cores * 2 hyperthreads = 20 CPUs
> Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz
> Average of 10 runs of: hackbench <groups> process 100000
> 
>             --- base --    --- new ---
>   groups    time %stdev    time %stdev  %speedup
>        1   8.008    0.1   5.905    0.2      35.6
>        2  13.814    0.2  11.438    0.1      20.7
>        3  19.488    0.2  16.919    0.1      15.1
>        4  25.059    0.1  22.409    0.1      11.8
>        8  47.478    0.1  44.221    0.1       7.3
> 
> X6-2: 1 socket * 22 cores * 2 hyperthreads = 44 CPUs
> Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
> Average of 10 runs of: hackbench <groups> process 100000
> 
>             --- base --    --- new ---
>   groups    time %stdev    time %stdev  %speedup
>        1   4.586    0.8   4.596    0.6      -0.3
>        2   7.693    0.2   5.775    1.3      33.2
>        3  10.442    0.3   8.288    0.3      25.9
>        4  13.087    0.2  11.057    0.1      18.3
>        8  24.145    0.2  22.076    0.3       9.3
>       16  43.779    0.1  41.741    0.2       4.8
> 
> KVM 4-cpu
> Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz
> tbench, average of 11 runs.
> 
>   clients    %speedup
>         1        16.2
>         2        11.7
>         4         9.9
>         8        12.8
>        16        13.7
> 
> KVM 2-cpu
> Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz
> 
>   Benchmark                     %speedup
>   specjbb2015_critical_jops          5.7
>   mysql_sysb1.0.14_mutex_2          40.6
>   mysql_sysb1.0.14_oltp_2            3.9
> 
> ------------------ 2 Socket Results ------------------
> 
> X6-2: 2 sockets * 10 cores * 2 hyperthreads = 40 CPUs
> Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz
> Average of 10 runs of: hackbench <groups> process 100000
> 
>             --- base --    --- new ---
>   groups    time %stdev    time %stdev  %speedup
>        1   7.945    0.2   7.219    8.7      10.0
>        2   8.444    0.4   6.689    1.5      26.2
>        3  12.100    1.1   9.962    2.0      21.4
>        4  15.001    0.4  13.109    1.1      14.4
>        8  27.960    0.2  26.127    0.3       7.0
> 
> X6-2: 2 sockets * 22 cores * 2 hyperthreads = 88 CPUs
> Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
> Average of 10 runs of: hackbench <groups> process 100000
> 
>             --- base --    --- new ---
>   groups    time %stdev    time %stdev  %speedup
>        1   5.826    5.4   5.840    5.0      -0.3
>        2   5.041    5.3   6.171   23.4     -18.4
>        3   6.839    2.1   6.324    3.8       8.1
>        4   8.177    0.6   7.318    3.6      11.7
>        8  14.429    0.7  13.966    1.3       3.3
>       16  26.401    0.3  25.149    1.5       4.9
> 
> 
> X6-2: 2 sockets * 22 cores * 2 hyperthreads = 88 CPUs
> Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
> Oracle database OLTP, logging disabled, NVRAM storage
> 
>   Customers   Users   %speedup
>     1200000      40       -1.2
>     2400000      80        2.7
>     3600000     120        8.9
>     4800000     160        4.4
>     6000000     200        3.0
> 
> X6-2: 2 sockets * 14 cores * 2 hyperthreads = 56 CPUs
> Intel(R) Xeon(R) CPU E5-2690 v4 @ 2.60GHz
> Results from the Oracle "Performance PIT".
> 
>   Benchmark                                           %speedup
> 
>   mysql_sysb1.0.14_fileio_56_rndrd                        19.6
>   mysql_sysb1.0.14_fileio_56_seqrd                        12.1
>   mysql_sysb1.0.14_fileio_56_rndwr                         0.4
>   mysql_sysb1.0.14_fileio_56_seqrewr                      -0.3
> 
>   pgsql_sysb1.0.14_fileio_56_rndrd                        19.5
>   pgsql_sysb1.0.14_fileio_56_seqrd                         8.6
>   pgsql_sysb1.0.14_fileio_56_rndwr                         1.0
>   pgsql_sysb1.0.14_fileio_56_seqrewr                       0.5
> 
>   opatch_time_ASM_12.2.0.1.0_HP2M                          7.5
>   select-1_users-warm_asmm_ASM_12.2.0.1.0_HP2M             5.1
>   select-1_users_asmm_ASM_12.2.0.1.0_HP2M                  4.4
>   swingbenchv3_asmm_soebench_ASM_12.2.0.1.0_HP2M           5.8
> 
>   lm3_memlat_L2                                            4.8
>   lm3_memlat_L1                                            0.0
> 
>   ub_gcc_56CPUs-56copies_Pipe-based_Context_Switching     60.1
>   ub_gcc_56CPUs-56copies_Shell_Scripts_1_concurrent        5.2
>   ub_gcc_56CPUs-56copies_Shell_Scripts_8_concurrent       -3.0
>   ub_gcc_56CPUs-56copies_File_Copy_1024_bufsize_2000_maxblocks 2.4
> 
> X5-2: 2 sockets * 18 cores * 2 hyperthreads = 72 CPUs
> Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz
> 
>   NAS_OMP
>   bench class   ncpu    %improved(Mops)
>   dc    B       72      1.3
>   is    C       72      0.9
>   is    D       72      0.7
> 
>   sysbench mysql, average of 24 runs
>           --- base ---     --- new ---
>   nthr   events  %stdev   events  %stdev %speedup
>      1    331.0    0.25    331.0    0.24     -0.1
>      2    661.3    0.22    661.8    0.22      0.0
>      4   1297.0    0.88   1300.5    0.82      0.2
>      8   2420.8    0.04   2420.5    0.04     -0.1
>     16   4826.3    0.07   4825.4    0.05     -0.1
>     32   8815.3    0.27   8830.2    0.18      0.1
>     64  12823.0    0.24  12823.6    0.26      0.0
> 
> --------------------------------------------------------------
> 
> Changes from v1 to v2:
>   - Remove stray find_time hunk from patch 5
>   - Fix "warning: label out defined but not used" for !CONFIG_SCHED_SMT
>   - Set SCHED_STEAL_NODE_LIMIT_DEFAULT to 2
>   - Steal iff avg_idle exceeds the cost of stealing
> 
> Changes from v2 to v3:
>   - Update series for kernel 4.20.  Context changes only.
> 
> Changes from v3 to v4:
>   - Avoid 64-bit division on 32-bit processors in compute_skid()
>   - Replace IF_SMP with inline functions to set idle_stamp
>   - Push ZALLOC_MASK body into calling function
>   - Set rq->cfs_overload_cpus in update_top_cache_domain instead of
>     cpu_attach_domain
>   - Rewrite sparsemask iterator for complete inlining
>   - Cull and clean up sparsemask functions and moved all into
>     sched/sparsemask.h
> 
> Steve Sistare (10):
>   sched: Provide sparsemask, a reduced contention bitmap
>   sched/topology: Provide hooks to allocate data shared per LLC
>   sched/topology: Provide cfs_overload_cpus bitmap
>   sched/fair: Dynamically update cfs_overload_cpus
>   sched/fair: Hoist idle_stamp up from idle_balance
>   sched/fair: Generalize the detach_task interface
>   sched/fair: Provide can_migrate_task_llc
>   sched/fair: Steal work from an overloaded CPU when CPU goes idle
>   sched/fair: disable stealing if too many NUMA nodes
>   sched/fair: Provide idle search schedstats
> 
>  include/linux/sched/topology.h |   1 +
>  kernel/sched/core.c            |  31 +++-
>  kernel/sched/fair.c            | 354 +++++++++++++++++++++++++++++++++++++----
>  kernel/sched/features.h        |   6 +
>  kernel/sched/sched.h           |  13 +-
>  kernel/sched/sparsemask.h      | 210 ++++++++++++++++++++++++
>  kernel/sched/stats.c           |  11 +-
>  kernel/sched/stats.h           |  13 ++
>  kernel/sched/topology.c        | 121 +++++++++++++-
>  9 files changed, 726 insertions(+), 34 deletions(-)
>  create mode 100644 kernel/sched/sparsemask.h
> 
