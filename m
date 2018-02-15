Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032487AbeBOAsk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 19:48:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:59000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032447AbeBOAsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 19:48:35 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6906B217BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
From: Frederic Weisbecker <frederic@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Wanpeng Li <kernellwp@gmail.com>, Mike Galbraith <efault@gmx.de>,
        Rik van Riel <riel@redhat.com>
Subject: [PATCH 4/6] sched/isolation: Offload residual 1Hz scheduler tick
Date: Thu, 15 Feb 2018 01:48:12 +0100
Message-Id: <1518655694-8057-5-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518655694-8057-1-git-send-email-frederic@kernel.org>
References: <1518655694-8057-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Luiz Capitulino <lcapitulino@redhat.com>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wanpeng Li <kernellwp@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c      | 92 ++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/isolation.c |  4 +++
 kernel/sched/sched.h     |  2 ++
 3 files changed, 98 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f09ec5c..86eefc4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3120,6 +3120,96 @@ u64 scheduler_tick_max_deferment(void)
 
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
@@ -5781,6 +5871,7 @@ int sched_cpu_starting(unsigned int cpu)
 {
 	set_cpu_rq_start_time(cpu);
 	sched_rq_cpu_starting(cpu);
+	sched_tick_start(cpu);
 	return 0;
 }
 
@@ -5792,6 +5883,7 @@ int sched_cpu_dying(unsigned int cpu)
 
 	/* Handle pending wakeups and then migrate everything off */
 	sched_ttwu_pending();
+	sched_tick_stop(cpu);
 
 	rq_lock_irqsave(rq, &rf);
 	if (rq->rd) {
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
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index fb5fc458..c1c7c78 100644
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
 
-- 
2.7.4
