Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbeEVGVH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 02:21:07 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37427 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751069AbeEVGUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 02:20:38 -0400
X-Google-Smtp-Source: AB8JxZpw0sllRftf5H6o0q4Lw6U3i0v1nh3BnWJlD0DgY8WMkM98GzxQJh4NfjPdaTqHVmUT1CvIlg==
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: ibobrik@gmail.com, Cong Wang <xiyou.wangcong@gmail.com>,
        Paul Turner <pjt@google.com>, Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <efault@gmx.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 1/3] sched/fair: make CFS bandwidth slice per cpu group
Date: Mon, 21 May 2018 23:20:15 -0700
Message-Id: <20180522062017.5193-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20180522062017.5193-1-xiyou.wangcong@gmail.com>
References: <20180522062017.5193-1-xiyou.wangcong@gmail.com>
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

This patch introduces cpu.cfs_slice_us which allows each cgroup to
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
 Documentation/scheduler/sched-bwc.txt | 16 ++++++++----
 kernel/sched/core.c                   | 47 +++++++++++++++++++++++++++++++++++
 kernel/sched/fair.c                   | 22 ++++++++++------
 kernel/sched/sched.h                  |  1 +
 4 files changed, 73 insertions(+), 13 deletions(-)

diff --git a/Documentation/scheduler/sched-bwc.txt b/Documentation/scheduler/sched-bwc.txt
index f6b1873f68ab..d853e5cb5553 100644
--- a/Documentation/scheduler/sched-bwc.txt
+++ b/Documentation/scheduler/sched-bwc.txt
@@ -48,19 +48,25 @@ and return the group to an unconstrained state once more.
 Any updates to a group's bandwidth specification will result in it becoming
 unthrottled if it is in a constrained state.
 
-System wide settings
---------------------
+Slice
+-----
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
index 092f7c4de903..7015a6143151 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6666,6 +6666,36 @@ long tg_get_cfs_period(struct task_group *tg)
 	return cfs_period_us;
 }
 
+static int tg_set_cfs_slice(struct task_group *tg, long cfs_slice_us)
+{
+	struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
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
+	raw_spin_lock_irq(&cfs_b->lock);
+	cfs_b->slice = slice;
+	raw_spin_unlock_irq(&cfs_b->lock);
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
@@ -6690,6 +6720,18 @@ static int cpu_cfs_period_write_u64(struct cgroup_subsys_state *css,
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
@@ -6833,6 +6875,11 @@ static struct cftype cpu_legacy_files[] = {
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
index 79f574dba096..5d72961d89eb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4527,11 +4527,6 @@ static inline u64 default_cfs_period(void)
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
@@ -4565,6 +4560,11 @@ static inline u64 cfs_rq_clock_task(struct cfs_rq *cfs_rq)
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
@@ -4573,7 +4573,7 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 	u64 amount = 0, min_amount, expires;
 
 	/* note: this is a positive sum as runtime_remaining <= 0 */
-	min_amount = sched_cfs_bandwidth_slice() - cfs_rq->runtime_remaining;
+	min_amount = cfs_bandwidth_slice(cfs_b) - cfs_rq->runtime_remaining;
 
 	raw_spin_lock(&cfs_b->lock);
 	if (cfs_b->quota == RUNTIME_INF)
@@ -4992,7 +4992,7 @@ static void __return_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 		cfs_b->runtime += slack_runtime;
 
 		/* we are under rq->lock, defer unthrottling using a timer */
-		if (cfs_b->runtime > sched_cfs_bandwidth_slice() &&
+		if (cfs_b->runtime > cfs_bandwidth_slice(cfs_b) &&
 		    !list_empty(&cfs_b->throttled_cfs_rq))
 			start_cfs_slack_bandwidth(cfs_b);
 	}
@@ -5019,7 +5019,7 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq)
  */
 static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 {
-	u64 runtime = 0, slice = sched_cfs_bandwidth_slice();
+	u64 runtime = 0, slice = cfs_bandwidth_slice(cfs_b);
 	u64 expires;
 
 	/* confirm we're still not at a refresh boundary */
@@ -5139,12 +5139,18 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
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
index 1f0a4bc6a39d..a15c0458f4d1 100644
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
