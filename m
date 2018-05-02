Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751568AbeEBRrN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:47:13 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46392 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbeEBRrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:47:10 -0400
X-Google-Smtp-Source: AB8JxZr7Ft1gAUcWnzZcSgtylYkMmVdnGUNSKJvOFIcYR0/JeXBOs35YB9dAOBnoEnHM2Ns3qJAw+g==
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Subject: [Patch v2] sched/fair: make CFS bandwidth slice per cpu group
Date: Wed,  2 May 2018 10:46:58 -0700
Message-Id: <20180502174658.13013-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.9.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We saw tasks in a CPU cgroup got throttled for many times even
when they don't apparently over-burn the CPU's. I tried to trace
the cause and noticed that one of the problems here is that the
local CPU which got the last chunk of quota doesn't use all of
them and prevents other CPUs to reuse the unused CPU time. So
reducing sched_cfs_bandwidth_slice_us from the default 5ms to 1ms
mostly solves the problem, at least no tasks got throttled after
this change in my test case.

However, the sched_cfs_bandwidth_slice_us is a global setting which
affects all cgroups. Different cgroups may want different values based
on their own workload, 5ms or 1ms is not suitable for all the cgroups.
A smaller slice distributes CPU time more fairly at a cost of slightly
higher overhead. We have to minimize the impact of the slice change.
On the other hand, the global pool filled periodically is per cgroup,
each cgroup should have the right to distribute its own quota to the
local CPUs with its own preferred frequency.

This patch intrdouces cpu.cfs_slice_us which allows each cgroup to
specify its own slice length without any global impact. And the
global sysctl sched_cfs_bandwidth_slice_us now becomes the default
value of each cpu.cfs_slice_us. Note, updating this sysctl does not
automatically update existing cgroups using a default value, users
will have to update each existing cgroup accordingly to make a global
change.

Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 Documentation/scheduler/sched-bwc.txt | 14 +++++++----
 kernel/sched/core.c                   | 44 +++++++++++++++++++++++++++++++++++
 kernel/sched/fair.c                   | 22 +++++++++++-------
 kernel/sched/sched.h                  |  1 +
 4 files changed, 69 insertions(+), 12 deletions(-)

diff --git a/Documentation/scheduler/sched-bwc.txt b/Documentation/scheduler/sched-bwc.txt
index f6b1873f68ab..b2d6ff02e5b3 100644
--- a/Documentation/scheduler/sched-bwc.txt
+++ b/Documentation/scheduler/sched-bwc.txt
@@ -48,19 +48,25 @@ and return the group to an unconstrained state once more.
 Any updates to a group's bandwidth specification will result in it becoming
 unthrottled if it is in a constrained state.
 
-System wide settings
+Slice
 --------------------
 For efficiency run-time is transferred between the global pool and CPU local
 "silos" in a batch fashion.  This greatly reduces global accounting pressure
 on large systems.  The amount transferred each time such an update is required
 is described as the "slice".
 
-This is tunable via procfs:
-	/proc/sys/kernel/sched_cfs_bandwidth_slice_us (default=5ms)
-
 Larger slice values will reduce transfer overheads, while smaller values allow
 for more fine-grained consumption.
 
+The per-group file cpu.cfs_slice_us controls the slice length within each CPU
+group, different groups could set different values for their own preference.
+Its default value is tunable via procfs:
+
+	/proc/sys/kernel/sched_cfs_bandwidth_slice_us (default=5ms)
+
+Note, updating this file does not automatically update existing groups using
+a default slice.
+
 Statistics
 ----------
 A group's bandwidth statistics are exported via 3 fields in cpu.stat.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5e10aaeebfcc..48a7547b6744 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6670,6 +6670,33 @@ long tg_get_cfs_period(struct task_group *tg)
 	return cfs_period_us;
 }
 
+static int tg_set_cfs_slice(struct task_group *tg, long cfs_slice_us)
+{
+	u64 quota, slice;
+
+	if (cfs_slice_us <= 0)
+		return -ERANGE;
+	quota = tg->cfs_bandwidth.quota;
+	if (quota == RUNTIME_INF)
+		return -EINVAL;
+	slice = (u64)cfs_slice_us * NSEC_PER_USEC;
+	if (slice > quota)
+		return -EINVAL;
+
+	tg->cfs_bandwidth.slice = slice;
+	return 0;
+}
+
+static long tg_get_cfs_slice(struct task_group *tg)
+{
+	u64 slice_us;
+
+	slice_us = tg->cfs_bandwidth.slice;
+	do_div(slice_us, NSEC_PER_USEC);
+
+	return slice_us;
+}
+
 static s64 cpu_cfs_quota_read_s64(struct cgroup_subsys_state *css,
 				  struct cftype *cft)
 {
@@ -6694,6 +6721,18 @@ static int cpu_cfs_period_write_u64(struct cgroup_subsys_state *css,
 	return tg_set_cfs_period(css_tg(css), cfs_period_us);
 }
 
+static s64 cpu_cfs_slice_read_s64(struct cgroup_subsys_state *css,
+				  struct cftype *cft)
+{
+	return tg_get_cfs_slice(css_tg(css));
+}
+
+static int cpu_cfs_slice_write_s64(struct cgroup_subsys_state *css,
+				   struct cftype *cftype, s64 cfs_quota_us)
+{
+	return tg_set_cfs_slice(css_tg(css), cfs_quota_us);
+}
+
 struct cfs_schedulable_data {
 	struct task_group *tg;
 	u64 period, quota;
@@ -6837,6 +6876,11 @@ static struct cftype cpu_legacy_files[] = {
 		.write_u64 = cpu_cfs_period_write_u64,
 	},
 	{
+		.name = "cfs_slice_us",
+		.read_s64 = cpu_cfs_slice_read_s64,
+		.write_s64 = cpu_cfs_slice_write_s64,
+	},
+	{
 		.name = "stat",
 		.seq_show = cpu_cfs_stat_show,
 	},
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 54dc31e7ab9b..b4f93a334566 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4539,11 +4539,6 @@ static inline u64 default_cfs_period(void)
 	return 100000000ULL;
 }
 
-static inline u64 sched_cfs_bandwidth_slice(void)
-{
-	return (u64)sysctl_sched_cfs_bandwidth_slice * NSEC_PER_USEC;
-}
-
 /*
  * Replenish runtime according to assigned quota and update expiration time.
  * We use sched_clock_cpu directly instead of rq->clock to avoid adding
@@ -4577,6 +4572,11 @@ static inline u64 cfs_rq_clock_task(struct cfs_rq *cfs_rq)
 	return rq_clock_task(rq_of(cfs_rq)) - cfs_rq->throttled_clock_task_time;
 }
 
+static inline u64 cfs_bandwidth_slice(struct cfs_bandwidth *cfs_b)
+{
+	return cfs_b->slice;
+}
+
 /* returns 0 on failure to allocate runtime */
 static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 {
@@ -4585,7 +4585,7 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 	u64 amount = 0, min_amount, expires;
 
 	/* note: this is a positive sum as runtime_remaining <= 0 */
-	min_amount = sched_cfs_bandwidth_slice() - cfs_rq->runtime_remaining;
+	min_amount = cfs_bandwidth_slice(cfs_b) - cfs_rq->runtime_remaining;
 
 	raw_spin_lock(&cfs_b->lock);
 	if (cfs_b->quota == RUNTIME_INF)
@@ -5004,7 +5004,7 @@ static void __return_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 		cfs_b->runtime += slack_runtime;
 
 		/* we are under rq->lock, defer unthrottling using a timer */
-		if (cfs_b->runtime > sched_cfs_bandwidth_slice() &&
+		if (cfs_b->runtime > cfs_bandwidth_slice(cfs_b) &&
 		    !list_empty(&cfs_b->throttled_cfs_rq))
 			start_cfs_slack_bandwidth(cfs_b);
 	}
@@ -5031,7 +5031,7 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq)
  */
 static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 {
-	u64 runtime = 0, slice = sched_cfs_bandwidth_slice();
+	u64 runtime = 0, slice = cfs_bandwidth_slice(cfs_b);
 	u64 expires;
 
 	/* confirm we're still not at a refresh boundary */
@@ -5151,12 +5151,18 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 	return idle ? HRTIMER_NORESTART : HRTIMER_RESTART;
 }
 
+static inline u64 cfs_default_bandwidth_slice(void)
+{
+	return (u64)sysctl_sched_cfs_bandwidth_slice * NSEC_PER_USEC;
+}
+
 void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 {
 	raw_spin_lock_init(&cfs_b->lock);
 	cfs_b->runtime = 0;
 	cfs_b->quota = RUNTIME_INF;
 	cfs_b->period = ns_to_ktime(default_cfs_period());
+	cfs_b->slice = cfs_default_bandwidth_slice();
 
 	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
 	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 15750c222ca2..35e8ca4e35a2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -331,6 +331,7 @@ struct cfs_bandwidth {
 	raw_spinlock_t		lock;
 	ktime_t			period;
 	u64			quota;
+	u64			slice;
 	u64			runtime;
 	s64			hierarchical_quota;
 	u64			runtime_expires;
-- 
2.13.0
