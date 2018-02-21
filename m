Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933346AbeBUKi6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:38:58 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59455 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932790AbeBUKi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:38:56 -0500
Date: Wed, 21 Feb 2018 02:37:22 -0800
From: tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-d84b31313ef8a8de55a2cbfb72f76f36d8c927fb@git.kernel.org>
Cc: tglx@linutronix.de, kernellwp@gmail.com, mingo@kernel.org,
        frederic@kernel.org, paulmck@linux.vnet.ibm.com,
        lcapitulino@redhat.com, torvalds@linux-foundation.org, cl@linux.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        cmetcalf@mellanox.com, riel@redhat.com, hpa@zytor.com, efault@gmx.de
Reply-To: kernellwp@gmail.com, tglx@linutronix.de, frederic@kernel.org,
        mingo@kernel.org, lcapitulino@redhat.com, paulmck@linux.vnet.ibm.com,
        hpa@zytor.com, efault@gmx.de, peterz@infradead.org, cl@linux.com,
        torvalds@linux-foundation.org, cmetcalf@mellanox.com, riel@redhat.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <1519186649-3242-6-git-send-email-frederic@kernel.org>
References: <1519186649-3242-6-git-send-email-frederic@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/isolation: Offload residual 1Hz scheduler
 tick
Git-Commit-ID: d84b31313ef8a8de55a2cbfb72f76f36d8c927fb
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d84b31313ef8a8de55a2cbfb72f76f36d8c927fb
Gitweb:     https://git.kernel.org/tip/d84b31313ef8a8de55a2cbfb72f76f36d8c927fb
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Wed, 21 Feb 2018 05:17:27 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 09:49:09 +0100

sched/isolation: Offload residual 1Hz scheduler tick

When a CPU runs in full dynticks mode, a 1Hz tick remains in order to
keep the scheduler stats alive. However this residual tick is a burden
for bare metal tasks that can't stand any interruption at all, or want
to minimize them.

The usual boot parameters "nohz_full=" or "isolcpus=nohz" will now
outsource these scheduler ticks to the global workqueue so that a
housekeeping CPU handles those remotely. The sched_class::task_tick()
implementations have been audited and look safe to be called remotely
as the target runqueue and its current task are passed in parameter
and don't seem to be accessed locally.

Note that in the case of using isolcpus, it's still up to the user to
affine the global workqueues to the housekeeping CPUs through
/sys/devices/virtual/workqueue/cpumask or domains isolation
"isolcpus=nohz,domain".

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luiz Capitulino <lcapitulino@redhat.com>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Wanpeng Li <kernellwp@gmail.com>
Link: http://lkml.kernel.org/r/1519186649-3242-6-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c      | 92 ++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/deadline.c  |  8 +++++
 kernel/sched/fair.c      |  7 +++-
 kernel/sched/idle_task.c |  8 +++++
 kernel/sched/isolation.c |  4 +++
 kernel/sched/rt.c        |  8 +++++
 kernel/sched/sched.h     |  2 ++
 kernel/sched/stop_task.c |  8 +++++
 8 files changed, 136 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e72ca3c..5dfef45 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3125,6 +3125,96 @@ u64 scheduler_tick_max_deferment(void)
 
 	return jiffies_to_nsecs(next - now);
 }
+
+struct tick_work {
+	int			cpu;
+	struct delayed_work	work;
+};
+
+static struct tick_work __percpu *tick_work_cpu;
+
+static void sched_tick_remote(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct tick_work *twork = container_of(dwork, struct tick_work, work);
+	int cpu = twork->cpu;
+	struct rq *rq = cpu_rq(cpu);
+	struct rq_flags rf;
+
+	/*
+	 * Handle the tick only if it appears the remote CPU is running in full
+	 * dynticks mode. The check is racy by nature, but missing a tick or
+	 * having one too much is no big deal because the scheduler tick updates
+	 * statistics and checks timeslices in a time-independent way, regardless
+	 * of when exactly it is running.
+	 */
+	if (!idle_cpu(cpu) && tick_nohz_tick_stopped_cpu(cpu)) {
+		struct task_struct *curr;
+		u64 delta;
+
+		rq_lock_irq(rq, &rf);
+		update_rq_clock(rq);
+		curr = rq->curr;
+		delta = rq_clock_task(rq) - curr->se.exec_start;
+
+		/*
+		 * Make sure the next tick runs within a reasonable
+		 * amount of time.
+		 */
+		WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
+		curr->sched_class->task_tick(rq, curr, 0);
+		rq_unlock_irq(rq, &rf);
+	}
+
+	/*
+	 * Run the remote tick once per second (1Hz). This arbitrary
+	 * frequency is large enough to avoid overload but short enough
+	 * to keep scheduler internal stats reasonably up to date.
+	 */
+	queue_delayed_work(system_unbound_wq, dwork, HZ);
+}
+
+static void sched_tick_start(int cpu)
+{
+	struct tick_work *twork;
+
+	if (housekeeping_cpu(cpu, HK_FLAG_TICK))
+		return;
+
+	WARN_ON_ONCE(!tick_work_cpu);
+
+	twork = per_cpu_ptr(tick_work_cpu, cpu);
+	twork->cpu = cpu;
+	INIT_DELAYED_WORK(&twork->work, sched_tick_remote);
+	queue_delayed_work(system_unbound_wq, &twork->work, HZ);
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+static void sched_tick_stop(int cpu)
+{
+	struct tick_work *twork;
+
+	if (housekeeping_cpu(cpu, HK_FLAG_TICK))
+		return;
+
+	WARN_ON_ONCE(!tick_work_cpu);
+
+	twork = per_cpu_ptr(tick_work_cpu, cpu);
+	cancel_delayed_work_sync(&twork->work);
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
+int __init sched_tick_offload_init(void)
+{
+	tick_work_cpu = alloc_percpu(struct tick_work);
+	BUG_ON(!tick_work_cpu);
+
+	return 0;
+}
+
+#else /* !CONFIG_NO_HZ_FULL */
+static inline void sched_tick_start(int cpu) { }
+static inline void sched_tick_stop(int cpu) { }
 #endif
 
 #if defined(CONFIG_PREEMPT) && (defined(CONFIG_DEBUG_PREEMPT) || \
@@ -5786,6 +5876,7 @@ int sched_cpu_starting(unsigned int cpu)
 {
 	set_cpu_rq_start_time(cpu);
 	sched_rq_cpu_starting(cpu);
+	sched_tick_start(cpu);
 	return 0;
 }
 
@@ -5797,6 +5888,7 @@ int sched_cpu_dying(unsigned int cpu)
 
 	/* Handle pending wakeups and then migrate everything off */
 	sched_ttwu_pending();
+	sched_tick_stop(cpu);
 
 	rq_lock_irqsave(rq, &rf);
 	if (rq->rd) {
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 9df0978..65cd5ea 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1776,6 +1776,14 @@ static void put_prev_task_dl(struct rq *rq, struct task_struct *p)
 		enqueue_pushable_dl_task(rq, p);
 }
 
+/*
+ * scheduler tick hitting a task of our scheduling class.
+ *
+ * NOTE: This function can be called remotely by the tick offload that
+ * goes along full dynticks. Therefore no local assumption can be made
+ * and everything must be accessed through the @rq and @curr passed in
+ * parameters.
+ */
 static void task_tick_dl(struct rq *rq, struct task_struct *p, int queued)
 {
 	update_curr_dl(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 33662a3..e1febd2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9515,7 +9515,12 @@ static void rq_offline_fair(struct rq *rq)
 #endif /* CONFIG_SMP */
 
 /*
- * scheduler tick hitting a task of our scheduling class:
+ * scheduler tick hitting a task of our scheduling class.
+ *
+ * NOTE: This function can be called remotely by the tick offload that
+ * goes along full dynticks. Therefore no local assumption can be made
+ * and everything must be accessed through the @rq and @curr passed in
+ * parameters.
  */
 static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 {
diff --git a/kernel/sched/idle_task.c b/kernel/sched/idle_task.c
index d518664..e1b46e0 100644
--- a/kernel/sched/idle_task.c
+++ b/kernel/sched/idle_task.c
@@ -51,6 +51,14 @@ static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
 	rq_last_tick_reset(rq);
 }
 
+/*
+ * scheduler tick hitting a task of our scheduling class.
+ *
+ * NOTE: This function can be called remotely by the tick offload that
+ * goes along full dynticks. Therefore no local assumption can be made
+ * and everything must be accessed through the @rq and @curr passed in
+ * parameters.
+ */
 static void task_tick_idle(struct rq *rq, struct task_struct *curr, int queued)
 {
 }
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index a2500c4..39f340d 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/static_key.h>
 #include <linux/ctype.h>
+#include "sched.h"
 
 DEFINE_STATIC_KEY_FALSE(housekeeping_overriden);
 EXPORT_SYMBOL_GPL(housekeeping_overriden);
@@ -61,6 +62,9 @@ void __init housekeeping_init(void)
 
 	static_branch_enable(&housekeeping_overriden);
 
+	if (housekeeping_flags & HK_FLAG_TICK)
+		sched_tick_offload_init();
+
 	/* We need at least one CPU to handle housekeeping work */
 	WARN_ON_ONCE(cpumask_empty(housekeeping_mask));
 }
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index aad49451..c80563b 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2292,6 +2292,14 @@ static void watchdog(struct rq *rq, struct task_struct *p)
 static inline void watchdog(struct rq *rq, struct task_struct *p) { }
 #endif
 
+/*
+ * scheduler tick hitting a task of our scheduling class.
+ *
+ * NOTE: This function can be called remotely by the tick offload that
+ * goes along full dynticks. Therefore no local assumption can be made
+ * and everything must be accessed through the @rq and @curr passed in
+ * parameters.
+ */
 static void task_tick_rt(struct rq *rq, struct task_struct *p, int queued)
 {
 	struct sched_rt_entity *rt_se = &p->rt;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index fb5fc45..c1c7c78 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1574,6 +1574,7 @@ extern void post_init_entity_util_avg(struct sched_entity *se);
 
 #ifdef CONFIG_NO_HZ_FULL
 extern bool sched_can_stop_tick(struct rq *rq);
+extern int __init sched_tick_offload_init(void);
 
 /*
  * Tick may be needed by tasks in the runqueue depending on their policy and
@@ -1598,6 +1599,7 @@ static inline void sched_update_tick_dependency(struct rq *rq)
 		tick_nohz_dep_set_cpu(cpu, TICK_DEP_BIT_SCHED);
 }
 #else
+static inline int sched_tick_offload_init(void) { return 0; }
 static inline void sched_update_tick_dependency(struct rq *rq) { }
 #endif
 
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 210b1f2..ea8d2b6 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -75,6 +75,14 @@ static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
 	cgroup_account_cputime(curr, delta_exec);
 }
 
+/*
+ * scheduler tick hitting a task of our scheduling class.
+ *
+ * NOTE: This function can be called remotely by the tick offload that
+ * goes along full dynticks. Therefore no local assumption can be made
+ * and everything must be accessed through the @rq and @curr passed in
+ * parameters.
+ */
 static void task_tick_stop(struct rq *rq, struct task_struct *curr, int queued)
 {
 }
