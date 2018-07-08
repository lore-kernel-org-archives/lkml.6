Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E74C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 09:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5042086E
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 09:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC5042086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754171AbeGHJzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 05:55:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58230 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754063AbeGHJzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 05:55:09 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fc6PM-0003lI-0d; Sun, 08 Jul 2018 11:55:08 +0200
Date:   Sun, 8 Jul 2018 11:55:07 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] scheduler updates for 4.18
Message-ID: <alpine.DEB.2.21.1807081143160.1589@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

A set of fixes for the scheduler:

  - The hopefully final fix for the reported race problems in
    kthread_parkme(). The previous attempt still left a hole and was
    partially wrong.

  - Plug a race in the remote tick mechanism which triggers a warning about
    updates not being done correctly. That's a false positive if the race
    condition is hit as the remote CPU is idle. Plug it by checking the
    condition again when holding run queue lock.

  - Fix a bug in the utilization estimation of a run queue which causes the
    estimation to be 0 when a run queue is throttled.

  - Advance the global expiration of the period timer when the timer is
    restarted after a idle period. Otherwise the expiry time is stale and
    the timer fires prematurely.

  - Cure the drift between the bandwidth timer and the runqueue accounting,
    which leads to bogus throttling of runqueues

  - Place the call to cpufreq_update_util() correctly so the function will
    observe the correct number of running RT tasks and not a stale one.

Thanks,

	tglx

------------------>
Frederic Weisbecker (1):
      sched/nohz: Skip remote tick on idle task entirely

Peter Zijlstra (1):
      kthread, sched/core: Fix kthread_parkme() (again...)

Vincent Guittot (2):
      sched/rt: Fix call to cpufreq_update_util()
      sched/util_est: Fix util_est_dequeue() for throttled cfs_rq

Xunlei Pang (2):
      sched/fair: Fix bandwidth timer clock drift condition
      sched/fair: Advance global expiration when period timer is restarted


 include/linux/kthread.h          |  1 -
 include/linux/sched.h            |  2 +-
 kernel/kthread.c                 | 30 ++++++++++++++----
 kernel/sched/core.c              | 67 +++++++++++++++++++---------------------
 kernel/sched/cpufreq_schedutil.c |  2 +-
 kernel/sched/fair.c              | 45 +++++++++++++--------------
 kernel/sched/rt.c                | 16 ++++++----
 kernel/sched/sched.h             | 11 +++++--
 8 files changed, 99 insertions(+), 75 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 2803264c512f..c1961761311d 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -62,7 +62,6 @@ void *kthread_probe_data(struct task_struct *k);
 int kthread_park(struct task_struct *k);
 void kthread_unpark(struct task_struct *k);
 void kthread_parkme(void);
-void kthread_park_complete(struct task_struct *k);
 
 int kthreadd(void *unused);
 extern struct task_struct *kthreadd_task;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9256118bd40c..43731fe51c97 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -118,7 +118,7 @@ struct task_group;
  * the comment with set_special_state().
  */
 #define is_special_task_state(state)				\
-	((state) & (__TASK_STOPPED | __TASK_TRACED | TASK_DEAD))
+	((state) & (__TASK_STOPPED | __TASK_TRACED | TASK_PARKED | TASK_DEAD))
 
 #define __set_current_state(state_value)			\
 	do {							\
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 481951bf091d..750cb8082694 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -177,9 +177,20 @@ void *kthread_probe_data(struct task_struct *task)
 static void __kthread_parkme(struct kthread *self)
 {
 	for (;;) {
-		set_current_state(TASK_PARKED);
+		/*
+		 * TASK_PARKED is a special state; we must serialize against
+		 * possible pending wakeups to avoid store-store collisions on
+		 * task->state.
+		 *
+		 * Such a collision might possibly result in the task state
+		 * changin from TASK_PARKED and us failing the
+		 * wait_task_inactive() in kthread_park().
+		 */
+		set_special_state(TASK_PARKED);
 		if (!test_bit(KTHREAD_SHOULD_PARK, &self->flags))
 			break;
+
+		complete_all(&self->parked);
 		schedule();
 	}
 	__set_current_state(TASK_RUNNING);
@@ -191,11 +202,6 @@ void kthread_parkme(void)
 }
 EXPORT_SYMBOL_GPL(kthread_parkme);
 
-void kthread_park_complete(struct task_struct *k)
-{
-	complete_all(&to_kthread(k)->parked);
-}
-
 static int kthread(void *_create)
 {
 	/* Copy data: it's on kthread's stack */
@@ -461,6 +467,9 @@ void kthread_unpark(struct task_struct *k)
 
 	reinit_completion(&kthread->parked);
 	clear_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
+	/*
+	 * __kthread_parkme() will either see !SHOULD_PARK or get the wakeup.
+	 */
 	wake_up_state(k, TASK_PARKED);
 }
 EXPORT_SYMBOL_GPL(kthread_unpark);
@@ -487,7 +496,16 @@ int kthread_park(struct task_struct *k)
 	set_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
 	if (k != current) {
 		wake_up_process(k);
+		/*
+		 * Wait for __kthread_parkme() to complete(), this means we
+		 * _will_ have TASK_PARKED and are about to call schedule().
+		 */
 		wait_for_completion(&kthread->parked);
+		/*
+		 * Now wait for that schedule() to complete and the task to
+		 * get scheduled out.
+		 */
+		WARN_ON_ONCE(!wait_task_inactive(k, TASK_PARKED));
 	}
 
 	return 0;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 78d8facba456..fe365c9a08e9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7,7 +7,6 @@
  */
 #include "sched.h"
 
-#include <linux/kthread.h>
 #include <linux/nospec.h>
 
 #include <linux/kcov.h>
@@ -2724,28 +2723,20 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 		membarrier_mm_sync_core_before_usermode(mm);
 		mmdrop(mm);
 	}
-	if (unlikely(prev_state & (TASK_DEAD|TASK_PARKED))) {
-		switch (prev_state) {
-		case TASK_DEAD:
-			if (prev->sched_class->task_dead)
-				prev->sched_class->task_dead(prev);
+	if (unlikely(prev_state == TASK_DEAD)) {
+		if (prev->sched_class->task_dead)
+			prev->sched_class->task_dead(prev);
 
-			/*
-			 * Remove function-return probe instances associated with this
-			 * task and put them back on the free list.
-			 */
-			kprobe_flush_task(prev);
-
-			/* Task is done with its stack. */
-			put_task_stack(prev);
+		/*
+		 * Remove function-return probe instances associated with this
+		 * task and put them back on the free list.
+		 */
+		kprobe_flush_task(prev);
 
-			put_task_struct(prev);
-			break;
+		/* Task is done with its stack. */
+		put_task_stack(prev);
 
-		case TASK_PARKED:
-			kthread_park_complete(prev);
-			break;
-		}
+		put_task_struct(prev);
 	}
 
 	tick_nohz_task_switch();
@@ -3113,7 +3104,9 @@ static void sched_tick_remote(struct work_struct *work)
 	struct tick_work *twork = container_of(dwork, struct tick_work, work);
 	int cpu = twork->cpu;
 	struct rq *rq = cpu_rq(cpu);
+	struct task_struct *curr;
 	struct rq_flags rf;
+	u64 delta;
 
 	/*
 	 * Handle the tick only if it appears the remote CPU is running in full
@@ -3122,24 +3115,28 @@ static void sched_tick_remote(struct work_struct *work)
 	 * statistics and checks timeslices in a time-independent way, regardless
 	 * of when exactly it is running.
 	 */
-	if (!idle_cpu(cpu) && tick_nohz_tick_stopped_cpu(cpu)) {
-		struct task_struct *curr;
-		u64 delta;
+	if (idle_cpu(cpu) || !tick_nohz_tick_stopped_cpu(cpu))
+		goto out_requeue;
 
-		rq_lock_irq(rq, &rf);
-		update_rq_clock(rq);
-		curr = rq->curr;
-		delta = rq_clock_task(rq) - curr->se.exec_start;
+	rq_lock_irq(rq, &rf);
+	curr = rq->curr;
+	if (is_idle_task(curr))
+		goto out_unlock;
 
-		/*
-		 * Make sure the next tick runs within a reasonable
-		 * amount of time.
-		 */
-		WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
-		curr->sched_class->task_tick(rq, curr, 0);
-		rq_unlock_irq(rq, &rf);
-	}
+	update_rq_clock(rq);
+	delta = rq_clock_task(rq) - curr->se.exec_start;
+
+	/*
+	 * Make sure the next tick runs within a reasonable
+	 * amount of time.
+	 */
+	WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
+	curr->sched_class->task_tick(rq, curr, 0);
+
+out_unlock:
+	rq_unlock_irq(rq, &rf);
 
+out_requeue:
 	/*
 	 * Run the remote tick once per second (1Hz). This arbitrary
 	 * frequency is large enough to avoid overload but short enough
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 3cde46483f0a..c907fde01eaa 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -192,7 +192,7 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
 
-	if (rq->rt.rt_nr_running)
+	if (rt_rq_is_runnable(&rq->rt))
 		return sg_cpu->max;
 
 	/*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1866e64792a7..2f0a0be4d344 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3982,18 +3982,10 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
 	if (!sched_feat(UTIL_EST))
 		return;
 
-	/*
-	 * Update root cfs_rq's estimated utilization
-	 *
-	 * If *p is the last task then the root cfs_rq's estimated utilization
-	 * of a CPU is 0 by definition.
-	 */
-	ue.enqueued = 0;
-	if (cfs_rq->nr_running) {
-		ue.enqueued  = cfs_rq->avg.util_est.enqueued;
-		ue.enqueued -= min_t(unsigned int, ue.enqueued,
-				     (_task_util_est(p) | UTIL_AVG_UNCHANGED));
-	}
+	/* Update root cfs_rq's estimated utilization */
+	ue.enqueued  = cfs_rq->avg.util_est.enqueued;
+	ue.enqueued -= min_t(unsigned int, ue.enqueued,
+			     (_task_util_est(p) | UTIL_AVG_UNCHANGED));
 	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, ue.enqueued);
 
 	/*
@@ -4590,6 +4582,7 @@ void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
 	now = sched_clock_cpu(smp_processor_id());
 	cfs_b->runtime = cfs_b->quota;
 	cfs_b->runtime_expires = now + ktime_to_ns(cfs_b->period);
+	cfs_b->expires_seq++;
 }
 
 static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
@@ -4612,6 +4605,7 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 	struct task_group *tg = cfs_rq->tg;
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(tg);
 	u64 amount = 0, min_amount, expires;
+	int expires_seq;
 
 	/* note: this is a positive sum as runtime_remaining <= 0 */
 	min_amount = sched_cfs_bandwidth_slice() - cfs_rq->runtime_remaining;
@@ -4628,6 +4622,7 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 			cfs_b->idle = 0;
 		}
 	}
+	expires_seq = cfs_b->expires_seq;
 	expires = cfs_b->runtime_expires;
 	raw_spin_unlock(&cfs_b->lock);
 
@@ -4637,8 +4632,10 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 	 * spread between our sched_clock and the one on which runtime was
 	 * issued.
 	 */
-	if ((s64)(expires - cfs_rq->runtime_expires) > 0)
+	if (cfs_rq->expires_seq != expires_seq) {
+		cfs_rq->expires_seq = expires_seq;
 		cfs_rq->runtime_expires = expires;
+	}
 
 	return cfs_rq->runtime_remaining > 0;
 }
@@ -4664,12 +4661,9 @@ static void expire_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 	 * has not truly expired.
 	 *
 	 * Fortunately we can check determine whether this the case by checking
-	 * whether the global deadline has advanced. It is valid to compare
-	 * cfs_b->runtime_expires without any locks since we only care about
-	 * exact equality, so a partial write will still work.
+	 * whether the global deadline(cfs_b->expires_seq) has advanced.
 	 */
-
-	if (cfs_rq->runtime_expires != cfs_b->runtime_expires) {
+	if (cfs_rq->expires_seq == cfs_b->expires_seq) {
 		/* extend local deadline, drift is bounded above by 2 ticks */
 		cfs_rq->runtime_expires += TICK_NSEC;
 	} else {
@@ -5202,13 +5196,18 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 
 void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 {
+	u64 overrun;
+
 	lockdep_assert_held(&cfs_b->lock);
 
-	if (!cfs_b->period_active) {
-		cfs_b->period_active = 1;
-		hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
-		hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
-	}
+	if (cfs_b->period_active)
+		return;
+
+	cfs_b->period_active = 1;
+	overrun = hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
+	cfs_b->runtime_expires += (overrun + 1) * ktime_to_ns(cfs_b->period);
+	cfs_b->expires_seq++;
+	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
 }
 
 static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 47556b0c9a95..572567078b60 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -508,8 +508,11 @@ static void sched_rt_rq_dequeue(struct rt_rq *rt_rq)
 
 	rt_se = rt_rq->tg->rt_se[cpu];
 
-	if (!rt_se)
+	if (!rt_se) {
 		dequeue_top_rt_rq(rt_rq);
+		/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
+		cpufreq_update_util(rq_of_rt_rq(rt_rq), 0);
+	}
 	else if (on_rt_rq(rt_se))
 		dequeue_rt_entity(rt_se, 0);
 }
@@ -1001,8 +1004,6 @@ dequeue_top_rt_rq(struct rt_rq *rt_rq)
 	sub_nr_running(rq, rt_rq->rt_nr_running);
 	rt_rq->rt_queued = 0;
 
-	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
-	cpufreq_update_util(rq, 0);
 }
 
 static void
@@ -1014,11 +1015,14 @@ enqueue_top_rt_rq(struct rt_rq *rt_rq)
 
 	if (rt_rq->rt_queued)
 		return;
-	if (rt_rq_throttled(rt_rq) || !rt_rq->rt_nr_running)
+
+	if (rt_rq_throttled(rt_rq))
 		return;
 
-	add_nr_running(rq, rt_rq->rt_nr_running);
-	rt_rq->rt_queued = 1;
+	if (rt_rq->rt_nr_running) {
+		add_nr_running(rq, rt_rq->rt_nr_running);
+		rt_rq->rt_queued = 1;
+	}
 
 	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
 	cpufreq_update_util(rq, 0);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6601baf2361c..c7742dcc136c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -334,9 +334,10 @@ struct cfs_bandwidth {
 	u64			runtime;
 	s64			hierarchical_quota;
 	u64			runtime_expires;
+	int			expires_seq;
 
-	int			idle;
-	int			period_active;
+	short			idle;
+	short			period_active;
 	struct hrtimer		period_timer;
 	struct hrtimer		slack_timer;
 	struct list_head	throttled_cfs_rq;
@@ -551,6 +552,7 @@ struct cfs_rq {
 
 #ifdef CONFIG_CFS_BANDWIDTH
 	int			runtime_enabled;
+	int			expires_seq;
 	u64			runtime_expires;
 	s64			runtime_remaining;
 
@@ -609,6 +611,11 @@ struct rt_rq {
 #endif
 };
 
+static inline bool rt_rq_is_runnable(struct rt_rq *rt_rq)
+{
+	return rt_rq->rt_queued && rt_rq->rt_nr_running;
+}
+
 /* Deadline class' related fields in a runqueue */
 struct dl_rq {
 	/* runqueue is an rbtree, ordered by deadline */
