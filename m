Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16C3C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8699E21E1F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8699E21E1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732331AbeHIQXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 12:23:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54112 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730090AbeHIQXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 12:23:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D8CF7A9;
        Thu,  9 Aug 2018 06:58:19 -0700 (PDT)
Received: from e107985-lin.Emea.Arm.com (e107985-lin.emea.arm.com [10.4.12.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8E9AA3F5B3;
        Thu,  9 Aug 2018 06:58:18 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Fengguang Wu <fengguang.wu@intel.com>,
        Li Zhijian <zhijianx.li@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Disable LB_BIAS by default
Date:   Thu,  9 Aug 2018 14:57:53 +0100
Message-Id: <20180809135753.21077-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LB_BIAS allows the adjustment on how conservative load should be
balanced.

The rq->cpu_load[idx] array is used for this functionality. It contains
weighted CPU load decayed average values over different intervals
(idx = 1..4). Idx = 0 is the weighted CPU load itself.

The values are updated during scheduler_tick, before idle balance and at
nohz exit.

There are 5 different types of idx's per sched domain (sd). Each of them
is used to index into the rq->cpu_load[idx] array in a specific scenario
(busy, idle and newidle for load balancing, forkexec for wake-up
slow-path load balancing and wake for affine wakeup based on weight).
Only the sd idx's for busy and idle load balancing are set to 2,3 or 1,2
respectively. All the other sd idx's are set to 0.

Conservative load balancing is achieved for sd idx's >= 1 by using the
min/max (source_load()/target_load()) value between the current weighted
CPU load and the rq->cpu_load[sd idx -1] for the busiest(idlest)/local
CPU load in load balancing or vice versa in the wake-up slow-path load
balancing.
There is no conservative balancing for sd idx = 0 since only current
weighted CPU load is used in this case.

It is very likely that LB_BIAS' influence on load balancing can be
neglected (see test results below). This is further supported by:

(1) Weighted CPU load today is by itself a decayed average value (PELT)
    (cfs_rq->avg->runnable_load_avg) and not the instantaneous load
    (rq->load.weight) it was when LB_BIAS was introduced.

(2) Sd imbalance_pct is used for CPU_NEWLY_IDLE and CPU_NOT_IDLE (relate
    to sd's newidle and busy idx) in find_busiest_group() when comparing
    busiest and local avg load to make load balancing even more
    conservative.

(3) The sd forkexec and newidle idx are always set to 0 so there is no
    adjustment on how conservatively load balancing is done here.

(4) Affine wakeup based on weight (wake_affine_weight()) will not be
    impacted since the sd wake idx is always set to 0.

Let's disable LB_BIAS by default for a few kernel releases to make sure
that no workload and no scheduler topology is affected. The benefit of
being able to remove the LB_BIAS dependency from source_load() and
target_load() is that the entire rq->cpu_load[idx] code could be removed
in this case.

It is really hard to say if there is no regression w/o testing this with
a lot of different workloads on a lot of different platforms, especially
NUMA machines.
The following 104 LKP (Linux Kernel Performance) tests were run by the
0-Day guys mostly on multi-socket hosts with a larger number of logical
cpus (88, 192).
The base for the test was commit b3dae109fa89 ("sched/swait: Rename to
exclusive") (tip/sched/core v4.18-rc1).
Only 2 out of the 104 tests had a significant change in one of the
metrics (fsmark/1x-1t-1HDD-btrfs-nfsv4-4M-60G-NoSync-performance +7%
files_per_sec, unixbench/300s-100%-syscall-performance -11% score).
Tests which showed a change in one of the metrics are marked with a '*'
and this change is listed as well.

(a) lkp-bdw-ep3:
      88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz 64G

    dd-write/10m-1HDD-cfq-btrfs-100dd-performance
    fsmark/1x-1t-1HDD-xfs-nfsv4-4M-60G-NoSync-performance
  * fsmark/1x-1t-1HDD-btrfs-nfsv4-4M-60G-NoSync-performance
      7.50  7%  8.00  ±  6%  fsmark.files_per_sec
    fsmark/1x-1t-1HDD-btrfs-nfsv4-4M-60G-fsyncBeforeClose-performance
    fsmark/1x-1t-1HDD-btrfs-4M-60G-NoSync-performance
    fsmark/1x-1t-1HDD-btrfs-4M-60G-fsyncBeforeClose-performance
    kbuild/300s-50%-vmlinux_prereq-performance
    kbuild/300s-200%-vmlinux_prereq-performance
    kbuild/300s-50%-vmlinux_prereq-performance-1HDD-ext4
    kbuild/300s-200%-vmlinux_prereq-performance-1HDD-ext4

(b) lkp-skl-4sp1:
      192 threads Intel(R) Xeon(R) Platinum 8160 768G

    dbench/100%-performance
    ebizzy/200%-100x-10s-performance
    hackbench/1600%-process-pipe-performance
    iperf/300s-cs-localhost-tcp-performance
    iperf/300s-cs-localhost-udp-performance
    perf-bench-numa-mem/2t-300M-performance
    perf-bench-sched-pipe/10000000ops-process-performance
    perf-bench-sched-pipe/10000000ops-threads-performance
    schbench/2-16-300-30000-30000-performance
    tbench/100%-cs-localhost-performance

(c) lkp-bdw-ep6:
      88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz 128G

    stress-ng/100%-60s-pipe-performance
    unixbench/300s-1-whetstone-double-performance
    unixbench/300s-1-shell1-performance
    unixbench/300s-1-shell8-performance
    unixbench/300s-1-pipe-performance
  * unixbench/300s-1-context1-performance
      312  315  unixbench.score
    unixbench/300s-1-spawn-performance
    unixbench/300s-1-syscall-performance
    unixbench/300s-1-dhry2reg-performance
    unixbench/300s-1-fstime-performance
    unixbench/300s-1-fsbuffer-performance
    unixbench/300s-1-fsdisk-performance
    unixbench/300s-100%-whetstone-double-performance
    unixbench/300s-100%-shell1-performance
    unixbench/300s-100%-shell8-performance
    unixbench/300s-100%-pipe-performance
    unixbench/300s-100%-context1-performance
    unixbench/300s-100%-spawn-performance
  * unixbench/300s-100%-syscall-performance
      3571  ±  3%  -11%  3183  ±  4%  unixbench.score
    unixbench/300s-100%-dhry2reg-performance
    unixbench/300s-100%-fstime-performance
    unixbench/300s-100%-fsbuffer-performance
    unixbench/300s-100%-fsdisk-performance
    unixbench/300s-1-execl-performance
    unixbench/300s-100%-execl-performance
  * will-it-scale/brk1-performance
      365004  360387  will-it-scale.per_thread_ops
  * will-it-scale/dup1-performance
      432401  437596  will-it-scale.per_thread_ops
    will-it-scale/eventfd1-performance
    will-it-scale/futex1-performance
    will-it-scale/futex2-performance
    will-it-scale/futex3-performance
    will-it-scale/futex4-performance
    will-it-scale/getppid1-performance
    will-it-scale/lock1-performance
    will-it-scale/lseek1-performance
    will-it-scale/lseek2-performance
  * will-it-scale/malloc1-performance
      47025  45817  will-it-scale.per_thread_ops
      77499  76529  will-it-scale.per_process_ops
    will-it-scale/malloc2-performance
  * will-it-scale/mmap1-performance
      123399  120815  will-it-scale.per_thread_ops
      152219  149833  will-it-scale.per_process_ops
  * will-it-scale/mmap2-performance
      107327  104714  will-it-scale.per_thread_ops
      136405  133765  will-it-scale.per_process_ops
    will-it-scale/open1-performance
  * will-it-scale/open2-performance
      171570  168805  will-it-scale.per_thread_ops
      532644  526202  will-it-scale.per_process_ops
    will-it-scale/page_fault1-performance
    will-it-scale/page_fault2-performance
    will-it-scale/page_fault3-performance
    will-it-scale/pipe1-performance
    will-it-scale/poll1-performance
  * will-it-scale/poll2-performance
      176134  172848  will-it-scale.per_thread_ops
      281361  275053  will-it-scale.per_process_ops
    will-it-scale/posix_semaphore1-performance
    will-it-scale/pread1-performance
    will-it-scale/pread2-performance
    will-it-scale/pread3-performance
    will-it-scale/pthread_mutex1-performance
    will-it-scale/pthread_mutex2-performance
    will-it-scale/pwrite1-performance
    will-it-scale/pwrite2-performance
    will-it-scale/pwrite3-performance
  * will-it-scale/read1-performance
      1190563  1174833  will-it-scale.per_thread_ops
  * will-it-scale/read2-performance
      1105369  1080427  will-it-scale.per_thread_ops
    will-it-scale/readseek1-performance
  * will-it-scale/readseek2-performance
      261818  259040  will-it-scale.per_thread_ops
    will-it-scale/readseek3-performance
  * will-it-scale/sched_yield-performance
      2408059  2382034  will-it-scale.per_thread_ops
    will-it-scale/signal1-performance
    will-it-scale/unix1-performance
    will-it-scale/unlink1-performance
    will-it-scale/unlink2-performance
  * will-it-scale/write1-performance
      976701  961588  will-it-scale.per_thread_ops
  * will-it-scale/writeseek1-performance
      831898  822448  will-it-scale.per_thread_ops
  * will-it-scale/writeseek2-performance
      228248  225065  will-it-scale.per_thread_ops
  * will-it-scale/writeseek3-performance
      226670  224058  will-it-scale.per_thread_ops
    will-it-scale/context_switch1-performance
    aim7/performance-fork_test-2000
  * aim7/performance-brk_test-3000
      74869  76676  aim7.jobs-per-min
    aim7/performance-disk_cp-3000
    aim7/performance-disk_rd-3000
    aim7/performance-sieve-3000
    aim7/performance-page_test-3000
    aim7/performance-creat-clo-3000
    aim7/performance-mem_rtns_1-8000
    aim7/performance-disk_wrt-8000
    aim7/performance-pipe_cpy-8000
    aim7/performance-ram_copy-8000

(d) lkp-avoton3:
      8 threads Intel(R) Atom(TM) CPU C2750 @ 2.40GHz 16G

    netperf/ipv4-900s-200%-cs-localhost-TCP_STREAM-performance

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/features.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 85ae8488039c..858589b83377 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -39,7 +39,7 @@ SCHED_FEAT(WAKEUP_PREEMPTION, true)
 
 SCHED_FEAT(HRTICK, false)
 SCHED_FEAT(DOUBLE_TICK, false)
-SCHED_FEAT(LB_BIAS, true)
+SCHED_FEAT(LB_BIAS, false)
 
 /*
  * Decrement CPU capacity based on time not spent running tasks
-- 
2.11.0

