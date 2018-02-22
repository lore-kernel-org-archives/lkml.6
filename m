Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933306AbeBVRCR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 12:02:17 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45216 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933193AbeBVRCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 12:02:15 -0500
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>,
        Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
Subject: [PATCH v5 0/4] Utilization estimation (util_est) for FAIR tasks
Date: Thu, 22 Feb 2018 17:01:49 +0000
Message-Id: <20180222170153.673-1-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, here is an update of [1], based on today's tip/sched/core [2], which
targets two main things:

1) Add the required/missing {READ,WRITE}_ONCE compiler barriers

   AFAIU, we wanted those barriers for lock-less synchronization between:
   - enqueue/dequeue calls: which are serialized by the RQ lock but where we
     read/modify util_est signals which can be _read concurrently_ from other
     code paths.
   - load balancer related functions: which are not serialized by the RQ lock
     but read util_est signals updated by the enqueue/dequeue calls.

   However, after noticing this commit:

      7bd3e239d6c6 locking: Remove atomicy checks from {READ,WRITE}_ONCE

   I'm still a bit confused on the real need of these calls mainly because:
   a) they are not the proper mechanism to grant atomic load/stores, for
      example when we need to access u64 values while running on a 32bit
      target.
   b) apart from possible load/store tearing issues, I was not able to see
      other scenarios, among the ones described in [3] which potentially
      apply to the code of these patches.

   Thus, to avoid load/store tearing, in principle I would have used:
   - WRITE_ONCE only on RQ-locked serialized code.
     Where we read/modify util_est signals, in order to properly publish it to
     concurrently running load balancer code.
   - READ_ONCE only from _non_ RQ-lock serialized code.
     Where we read only util_est signals.

   To my understanding this should be just good enough also to document the
   concurrent access to some shared variables while still allowing the compiler
   to optimize some load from the RQ-lock serialized code.

   All that considered, my last question on this point is: can we remove the
   READ_ONCE()s from RQ-lock serialized code?

2) Ensure the feature can be safely turned on by default

   Estimated utilization of Tasks and RQs is a feature which can benefit mainly
   lightly utilized systems, where you can have tasks which sleep for
   relatively long time but we still want to be fast on ramping-up the OPPs
   once they wake up.

   However, since Peter proposed to have this scheduler feature turned on by
   default, we did spent a bit more time focusing on hackbench to verify it
   will not hurt server/HPC classes of workloads.

   The main discovery has been that, if we properly configure hackbench
   to have an high rate of enqueue/dequeue events, despite the few instructions
   util_est adds, the overheads starts to become more noticeable.
   That's the reason of the last patch we added to this series, which changelog
   should be good enough to describe the issue and the proposed solution.

   Experiments including this patch have been run on a dual socket
   Intel(R) Xeon(R) CPU E5-2690 v2 @ 3.00GHz, using precisely this
   configuration:

   - cpusets to isolate one single socket for the execution of hackbench on
     just 10 of the available 20 cores.
     This allows to avoid NUMA load balancer side effects which we noticed
     affect quite a lot the variance across multiple experiments.

   - CPUFreq powersave policy, with the intel_pstate driver configured in
     passive mode and the scaling_max_freq set to the scaling_min_freq.
     This allows to rule out thermal and/or turbo boost side effects.

   - hackbench configured to run 120 iterations of:

        perf bench sched messaging --pipe --thread --group 8 --loop 5000

   which, in the above setup, corresponds to ~11s completion time for each
   iteration using 320 tasks.

   In the above setup, this configuration seems to maximize the rate of
   wakeup/sleep events thus better stressing the enqueue/dequeue code paths.
   Here are the stats we collected for the completion times:

        	count mean	std	 min	50%    95%	99%	 max
    before	120.0 11.010342 0.375753 10.104 11.046 11.54155 11.69629 11.751
    after	120.0 11.041117 0.375429 10.015 11.072 11.59070 11.67720 11.692

    after vs before: +0.3%  on mean
    after vs before: -0.2%  on 99% percentile

Results on ARM (Android) devices have been collected and reported in a previous
posting [4] and they showed negligible overhead compared to the corresponding
power/performance benefits.

Changes in v5:
 - rebased on today's tip/sched/core (commit 083c6eeab2cc, based on v4.16-rc2)
 - update util_est only on util_avg updates
 - add documentation for "struct util_est"
 - always use int instead of long whenever possible (Peter)
 - pass cfs_rq to util_est_{en,de}queue (Peter)
 - pass task_sleep to util_est_dequeue
 - use singe WRITE_ONCE at dequeue time
 - add some missing {READ,WRITE}_ONCE
 - add task_util_est() for code consistency

Changes in v4:
 - rebased on today's tip/sched/core (commit 460e8c3340a2)
 - renamed util_est's "last" into "enqueued"
 - using util_est's "enqueued" for both se and cfs_rqs (Joel)
 - update margin check to use more ASM friendly code (Peter)
 - optimize EWMA updates (Peter)
 - ensure cpu_util_wake() is cpu_capacity_orig()'s clamped (Pavan)
 - simplify cpu_util_cfs() integration (Dietmar)

Changes in v3:
 - rebased on today's tip/sched/core (commit 07881166a892)
 - moved util_est into sched_avg (Peter)
 - use {READ,WRITE}_ONCE() for EWMA updates (Peter)
 - using unsigned int to fit all sched_avg into a single 64B cache line
 - schedutil integration using Juri's cpu_util_cfs()
 - first patch dropped since it's already queued in tip/sched/core

Changes in v2:
 - rebased on top of v4.15-rc2
 - tested that overhauled PELT code does not affect the util_est

Cheers Patrick

.:: References
==============
[1] https://lkml.org/lkml/2018/2/6/356
    20180206144131.31233-1-patrick.bellasi@arm.com
[2] git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
    sched/core (commit 083c6eeab2cc)
[3] Documentation/memory-barriers.txt (Line 1508)
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/memory-barriers.txt?h=v4.16-rc2#n1508
[4] https://lkml.org/lkml/2018/1/23/645
    20180123180847.4477-1-patrick.bellasi@arm.com

Patrick Bellasi (4):
  sched/fair: add util_est on top of PELT
  sched/fair: use util_est in LB and WU paths
  sched/cpufreq_schedutil: use util_est for OPP selection
  sched/fair: update util_est only on util_avg updates

 include/linux/sched.h   |  29 +++++++
 kernel/sched/debug.c    |   4 +
 kernel/sched/fair.c     | 221 ++++++++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/features.h |   5 ++
 kernel/sched/sched.h    |   7 +-
 5 files changed, 259 insertions(+), 7 deletions(-)

-- 
2.15.1
