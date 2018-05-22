Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751340AbeEVGVC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 02:21:02 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44663 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751124AbeEVGUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 02:20:39 -0400
X-Google-Smtp-Source: AB8JxZrlXx7X5VfJ09KiWm6R//ID35t2uF1WYkYrg6k3IyhI3Hpb1ztzHjHp7XzV7J7QOOry5Ggo4A==
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: ibobrik@gmail.com, Cong Wang <xiyou.wangcong@gmail.com>,
        Paul Turner <pjt@google.com>, Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <efault@gmx.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 2/3] sched/fair: accumulate unused cpu time for CFS throttle
Date: Mon, 21 May 2018 23:20:16 -0700
Message-Id: <20180522062017.5193-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20180522062017.5193-1-xiyou.wangcong@gmail.com>
References: <20180522062017.5193-1-xiyou.wangcong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With current implementation of CFS CPU throttle, the unused CPU
time in a period is not carried over to the next one. And when
the CFS periodical timer is deactivated after detecting idle,
these idle periods are not counted either. This causes some
apparently counterintuitive CPU throttles when the job in a cpu
cgroup mostly sleeps during each period.

This can be reproduced with the reproducer from Ivan Babrou:
https://gist.github.com/bobrik/2030ff040fad360327a5fab7a09c4ff1
(I need to run the binary directly rather using golang to run,
otherwise the CPU used by golang itself is also accounted.)

We also observed a similar issue in production where QPS has
an interesting anti-correlation with nr_throttled/nr_periods.

This patch addresses it by always accumulating unused CPU time
in the global pool, and when the CFS periodical timer is
deactivated calculating the number of idle periods and
replenishing the missing quotas to the cpu cgroup. To avoid
burst, a cap could be specified by user so that quotas won't
exceed this cap.

This patch significantly reduces the nr_throttled/nr_periods
percentage and throttled time:

Without any patch (quota = 20000, period = 100000):
  nr_periods 56
  nr_throttled 14
  throttled_time 1496288690

With this patch (burst = 10 * quota):
  nr_periods 43
  nr_throttled 1
  throttled_time 74789584

This patch first folds __refill_cfs_bandwidth_runtime() into
tg_set_cfs_bandwidth(), then renames and reuses it for
do_sched_cfs_period_timer(), where I use cfs_rq->last_active
to record the last time when this timer is activated, so that
we can calculate how many periods we miss during this.

Reported-by: Ivan Babrou <ibobrik@gmail.com>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 Documentation/scheduler/sched-bwc.txt |  9 +++++
 kernel/sched/core.c                   | 62 ++++++++++++++++++++++++++++++++---
 kernel/sched/fair.c                   | 52 +++++++++++++++++------------
 kernel/sched/sched.h                  |  3 +-
 4 files changed, 99 insertions(+), 27 deletions(-)

diff --git a/Documentation/scheduler/sched-bwc.txt b/Documentation/scheduler/sched-bwc.txt
index d853e5cb5553..2c88a4afea9a 100644
--- a/Documentation/scheduler/sched-bwc.txt
+++ b/Documentation/scheduler/sched-bwc.txt
@@ -67,6 +67,15 @@ group, different groups could set different values for their own preference.
 Note, updating this file does not automatically update existing groups using
 a default slice.
 
+Burst
+-----
+When a local run queue has no task to run, its unused CPU time is returned
+back to the global pool. If the whole group becomes idle, its periodical
+timer is halted, unused CPU time during this time is accumulated too.
+To avoid burst, a cap should be set by user via cpu.cfs_burst_us, with it
+the accumulated CPU time won't exceed this cap. Its default value allows
+a group to burn all CPU's with the given quota for a whole period.
+
 Statistics
 ----------
 A group's bandwidth statistics are exported via 3 fields in cpu.stat.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7015a6143151..917f76d9d44c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6589,12 +6589,17 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
 	raw_spin_lock_irq(&cfs_b->lock);
 	cfs_b->period = ns_to_ktime(period);
 	cfs_b->quota = quota;
-
-	__refill_cfs_bandwidth_runtime(cfs_b);
-
-	/* Restart the period timer (if active) to handle new period expiry: */
-	if (runtime_enabled)
+	if (runtime_enabled) {
+		u64 now;
+
+		cfs_b->runtime = cfs_b->quota;
+		cfs_b->burst = nr_cpu_ids * quota;
+		now = sched_clock_cpu(smp_processor_id());
+		cfs_b->last_active = now;
+		cfs_b->runtime_expires = now + ktime_to_ns(cfs_b->period);
+		/* Restart the period timer (if active) to handle new period expiry: */
 		start_cfs_bandwidth(cfs_b);
+	}
 
 	raw_spin_unlock_irq(&cfs_b->lock);
 
@@ -6666,6 +6671,36 @@ long tg_get_cfs_period(struct task_group *tg)
 	return cfs_period_us;
 }
 
+static int tg_set_cfs_burst(struct task_group *tg, long cfs_burst_us)
+{
+	struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
+	u64 quota, burst;
+
+	if (cfs_burst_us <= 0)
+		return -ERANGE;
+	quota = tg->cfs_bandwidth.quota;
+	if (quota == RUNTIME_INF)
+		return -EINVAL;
+	burst = (u64)cfs_burst_us * NSEC_PER_USEC;
+	if (burst < quota)
+		return -EINVAL;
+
+	raw_spin_lock_irq(&cfs_b->lock);
+	cfs_b->burst = burst;
+	raw_spin_unlock_irq(&cfs_b->lock);
+	return 0;
+}
+
+static long tg_get_cfs_burst(struct task_group *tg)
+{
+	u64 burst_us;
+
+	burst_us = tg->cfs_bandwidth.burst;
+	do_div(burst_us, NSEC_PER_USEC);
+
+	return burst_us;
+}
+
 static int tg_set_cfs_slice(struct task_group *tg, long cfs_slice_us)
 {
 	struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
@@ -6720,6 +6755,18 @@ static int cpu_cfs_period_write_u64(struct cgroup_subsys_state *css,
 	return tg_set_cfs_period(css_tg(css), cfs_period_us);
 }
 
+static s64 cpu_cfs_burst_read_s64(struct cgroup_subsys_state *css,
+				  struct cftype *cft)
+{
+	return tg_get_cfs_burst(css_tg(css));
+}
+
+static int cpu_cfs_burst_write_s64(struct cgroup_subsys_state *css,
+				   struct cftype *cftype, s64 cfs_quota_us)
+{
+	return tg_set_cfs_burst(css_tg(css), cfs_quota_us);
+}
+
 static s64 cpu_cfs_slice_read_s64(struct cgroup_subsys_state *css,
 				  struct cftype *cft)
 {
@@ -6875,6 +6922,11 @@ static struct cftype cpu_legacy_files[] = {
 		.write_u64 = cpu_cfs_period_write_u64,
 	},
 	{
+		.name = "cfs_burst_us",
+		.read_s64 = cpu_cfs_burst_read_s64,
+		.write_s64 = cpu_cfs_burst_write_s64,
+	},
+	{
 		.name = "cfs_slice_us",
 		.read_s64 = cpu_cfs_slice_read_s64,
 		.write_s64 = cpu_cfs_slice_write_s64,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5d72961d89eb..8a13ee006f39 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4527,25 +4527,6 @@ static inline u64 default_cfs_period(void)
 	return 100000000ULL;
 }
 
-/*
- * Replenish runtime according to assigned quota and update expiration time.
- * We use sched_clock_cpu directly instead of rq->clock to avoid adding
- * additional synchronization around rq->lock.
- *
- * requires cfs_b->lock
- */
-void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
-{
-	u64 now;
-
-	if (cfs_b->quota == RUNTIME_INF)
-		return;
-
-	now = sched_clock_cpu(smp_processor_id());
-	cfs_b->runtime = cfs_b->quota;
-	cfs_b->runtime_expires = now + ktime_to_ns(cfs_b->period);
-}
-
 static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
 {
 	return &tg->cfs_bandwidth;
@@ -4862,6 +4843,31 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
 }
 
 /*
+ * Replenish runtime according to assigned quota and update expiration time.
+ * We use sched_clock_cpu directly instead of rq->clock to avoid adding
+ * additional synchronization around rq->lock.
+ *
+ * requires cfs_b->lock
+ */
+static void refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
+{
+	u64 now, idle;
+
+	now = sched_clock_cpu(smp_processor_id());
+	idle = now - cfs_b->last_active;
+	if (idle > cfs_b->period)
+		do_div(idle, cfs_b->period);
+	else
+		idle = 1;
+	cfs_b->runtime += idle * cfs_b->quota;
+	if (cfs_b->runtime > cfs_b->burst)
+		cfs_b->runtime = cfs_b->burst;
+	now = sched_clock_cpu(smp_processor_id());
+	cfs_b->last_active = now;
+	cfs_b->runtime_expires = now + ktime_to_ns(cfs_b->period);
+}
+
+/*
  * Responsible for refilling a task_group's bandwidth and unthrottling its
  * cfs_rqs as appropriate. If there has been no activity within the last
  * period the timer is deactivated until scheduling resumes; cfs_b->idle is
@@ -4886,7 +4892,7 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun)
 	if (cfs_b->idle && !throttled)
 		goto out_deactivate;
 
-	__refill_cfs_bandwidth_runtime(cfs_b);
+	refill_cfs_bandwidth_runtime(cfs_b);
 
 	if (!throttled) {
 		/* mark as potentially idle for the upcoming period */
@@ -5132,8 +5138,10 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 
 		idle = do_sched_cfs_period_timer(cfs_b, overrun);
 	}
-	if (idle)
+	if (idle) {
 		cfs_b->period_active = 0;
+		cfs_b->last_active = sched_clock_cpu(smp_processor_id());
+	}
 	raw_spin_unlock(&cfs_b->lock);
 
 	return idle ? HRTIMER_NORESTART : HRTIMER_RESTART;
@@ -5151,6 +5159,8 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 	cfs_b->quota = RUNTIME_INF;
 	cfs_b->period = ns_to_ktime(default_cfs_period());
 	cfs_b->slice = cfs_default_bandwidth_slice();
+	cfs_b->burst = nr_cpu_ids * cfs_b->period;
+	cfs_b->last_active = 0;
 
 	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
 	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a15c0458f4d1..9a717f82bbe3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -333,8 +333,10 @@ struct cfs_bandwidth {
 	u64			quota;
 	u64			slice;
 	u64			runtime;
+	u64			burst;
 	s64			hierarchical_quota;
 	u64			runtime_expires;
+	u64			last_active;
 
 	int			idle;
 	int			period_active;
@@ -433,7 +435,6 @@ extern void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 			struct sched_entity *parent);
 extern void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
 
-extern void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b);
 extern void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
 extern void unthrottle_cfs_rq(struct cfs_rq *cfs_rq);
 
-- 
2.13.0
