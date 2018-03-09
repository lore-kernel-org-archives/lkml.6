Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751223AbeCIJw6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 04:52:58 -0500
Received: from foss.arm.com ([217.140.101.70]:49298 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751146AbeCIJwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 04:52:54 -0500
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
Subject: [PATCH v6 0/4] Utilization estimation (util_est) for FAIR tasks
Date: Fri,  9 Mar 2018 09:52:41 +0000
Message-Id: <20180309095245.11071-1-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, here is an update of [1], based on today's tip/sched/core [2], which mainly
adds some code cleanups suggested by Peter as well as fixes compilation for
!CONFIG_SMP systems.

Most notably:
a) The util_est's update flag has been renamed into UTIL_AVG_UNCHANGED, which
   seems to better match its usages.
b) The cpu_util_est() function has been removed to reduce cluttering by folding
   its code directly into cpu_util(). This last function is thus now always
   returning the estimated utilization of a CPU, unless this sched feature is
   disabled.
c) Not necessary READ_ONCE() have been removed from rq-lock protected code
   paths. For util_est variable, that we read/modify/write only from rq-lock
   protected, code we keep just the WRITE_ONCE() barriers, which are still
   required for synchronization with lockless readers.
   The READ_ONCE() have been instead maintained in all the getter functions,
   like for example task_util() and cpu_util(), which can potentially be used
   by lockless code. e.g. schedutil or load-balancer.

Results on both x86_64 and ARM (Android) targets, which have been collected and
reported in previous postings [1,3], show negligible overheads, especially
compared to the corresponding power/performance benefits on mobile platforms,
where this feature helps to reduce the performance gap between PELT and another
other out-of-tree load tracking solution.

Best,
Patrick


.:: Changelog
=============

Changes in v6:
 - remove READ_ONCE from rq-lock protected code paths
 - folds cpu_util_est code into cpu_util and update its documentation
 - change util_est's update flag name to better match its usage
 - slightly clean up cpu_util_wake code
 - add other small code cleanups as suggested by Peter
 - fix compilation for !CONFIG_SMP systems
 - fix documentation to match sphinx syntax
 - update changelogs to better match code concepts

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


.:: References
==============
[1] https://lkml.org/lkml/2018/2/22/639
    20180222170153.673-1-patrick.bellasi@arm.com
[2] git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
    sched/core (commit 083c6eeab2cc)
[3] https://lkml.org/lkml/2018/1/23/645
    20180123180847.4477-1-patrick.bellasi@arm.com

Patrick Bellasi (4):
  sched/fair: add util_est on top of PELT
  sched/fair: use util_est in LB and WU paths
  sched/cpufreq_schedutil: use util_est for OPP selection
  sched/fair: update util_est only on util_avg updates

 include/linux/sched.h   |  29 ++++++
 kernel/sched/debug.c    |   4 +
 kernel/sched/fair.c     | 237 ++++++++++++++++++++++++++++++++++++++++++++----
 kernel/sched/features.h |   5 +
 kernel/sched/sched.h    |   9 +-
 5 files changed, 264 insertions(+), 20 deletions(-)

-- 
2.15.1
