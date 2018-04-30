Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932561AbeD3T3v (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 15:29:51 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40279 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755281AbeD3T3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 15:29:49 -0400
X-Google-Smtp-Source: AB8JxZoKMRVy0P7qqZMDRH3Zs36cBIXYfy9kQv4WjFQeuykQCF4cllYSBHdDpuMmakjhLZ5BGi8OEg==
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] sched/fair: make CFS bandwidth slice per cpu group
Date: Mon, 30 Apr 2018 12:29:25 -0700
Message-Id: <20180430192925.12589-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.9.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value of sched_cfs_bandwidth_slice_us plays an important role
in distributing CPU time to each local CPU from the global pool,
a smaller slice is more fair to distribute CPU time to each parallel
tasks running on different CPUs.

Currently, the sched_cfs_bandwidth_slice_us is a global setting which
affects all cgroups. Different groups may want different values based
on their own workload, one size doesn't fit all. The global pool filled
periodically is per cgroup too, they should have the right to distribute
their own quota to each local CPU with their own frequency.

This patch intrdouces cpu.cfs_slice_us which allows each cgroup to
specify their own slice length without any global impact. And, the
global sysctl sched_cfs_bandwidth_slice_us now becomes the default
value of each cpu.cfs_slice_us. However, updating this sysctl does not
automatically update existing cgroups using a default value, people
will have to update each cgroup accordingly to make a global update.

Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 Documentation/scheduler/sched-bwc.txt | 14 +++++++----
 kernel/sched/core.c                   | 45 +++++++++++++++++++++++++++++++++++
 kernel/sched/fair.c                   | 17 ++++++-------
 kernel/sched/sched.h                  |  6 +++++
 4 files changed, 70 insertions(+), 12 deletions(-)

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
index 5e10aaeebfcc..cafdfd18be36 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6670,6 +6670,34 @@ long tg_get_cfs_period(struct task_group *tg)
 	return cfs_period_us;
 }
 
+int tg_set_cfs_slice(struct task_group *tg, long cfs_slice_us)
+{
+	u64 quota, slice;
+
+	quota = tg->cfs_bandwidth.quota;
+	if (quota == RUNTIME_INF)
+		return -EINVAL;
+	if (cfs_slice_us <= 0)
+		return -ERANGE;
+
+	slice = (u64)cfs_slice_us * NSEC_PER_USEC;
+	if (slice > quota)
+		return -EINVAL;
+
+	tg->cfs_bandwidth.slice = slice;
+	return 0;
+}
+
+long tg_get_cfs_slice(struct task_group *tg)
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
@@ -6694,6 +6722,18 @@ static int cpu_cfs_period_write_u64(struct cgroup_subsys_state *css,
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
@@ -6837,6 +6877,11 @@ static struct cftype cpu_legacy_files[] = {
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
index 54dc31e7ab9b..44b21e70a9b1 100644
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
@@ -5157,6 +5157,7 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 	cfs_b->runtime = 0;
 	cfs_b->quota = RUNTIME_INF;
 	cfs_b->period = ns_to_ktime(default_cfs_period());
+	cfs_b->slice = sched_default_cfs_bandwidth_slice();
 
 	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
 	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 15750c222ca2..204377652edb 100644
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
@@ -432,6 +433,11 @@ extern void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 			struct sched_entity *parent);
 extern void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
 
+static inline u64 sched_default_cfs_bandwidth_slice(void)
+{
+	return (u64)sysctl_sched_cfs_bandwidth_slice * NSEC_PER_USEC;
+}
+
 extern void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b);
 extern void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
 extern void unthrottle_cfs_rq(struct cfs_rq *cfs_rq);
-- 
2.13.0
