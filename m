Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032550AbeBOAtT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 19:49:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:59104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032403AbeBOAsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 19:48:38 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E9D217C0
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
Subject: [PATCH 5/6] sched/nohz: Remove the 1 Hz tick code
Date: Thu, 15 Feb 2018 01:48:13 +0100
Message-Id: <1518655694-8057-6-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518655694-8057-1-git-send-email-frederic@kernel.org>
References: <1518655694-8057-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the 1Hz tick is offloaded to workqueues, we can safely remove
the residual code that used to handle it locally.

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
 include/linux/sched/nohz.h |  4 ----
 kernel/sched/core.c        | 29 -----------------------------
 kernel/sched/idle_task.c   |  1 -
 kernel/sched/sched.h       | 11 +----------
 kernel/time/tick-sched.c   |  6 ------
 5 files changed, 1 insertion(+), 50 deletions(-)

diff --git a/include/linux/sched/nohz.h b/include/linux/sched/nohz.h
index 3d3a97d..0942172 100644
--- a/include/linux/sched/nohz.h
+++ b/include/linux/sched/nohz.h
@@ -37,8 +37,4 @@ extern void wake_up_nohz_cpu(int cpu);
 static inline void wake_up_nohz_cpu(int cpu) { }
 #endif
 
-#ifdef CONFIG_NO_HZ_FULL
-extern u64 scheduler_tick_max_deferment(void);
-#endif
-
 #endif /* _LINUX_SCHED_NOHZ_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 86eefc4..099c9cb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3091,35 +3091,9 @@ void scheduler_tick(void)
 	rq->idle_balance = idle_cpu(cpu);
 	trigger_load_balance(rq);
 #endif
-	rq_last_tick_reset(rq);
 }
 
 #ifdef CONFIG_NO_HZ_FULL
-/**
- * scheduler_tick_max_deferment
- *
- * Keep at least one tick per second when a single
- * active task is running because the scheduler doesn't
- * yet completely support full dynticks environment.
- *
- * This makes sure that uptime, CFS vruntime, load
- * balancing, etc... continue to move forward, even
- * with a very low granularity.
- *
- * Return: Maximum deferment in nanoseconds.
- */
-u64 scheduler_tick_max_deferment(void)
-{
-	struct rq *rq = this_rq();
-	unsigned long next, now = READ_ONCE(jiffies);
-
-	next = rq->last_sched_tick + HZ;
-
-	if (time_before_eq(next, now))
-		return 0;
-
-	return jiffies_to_nsecs(next - now);
-}
 
 struct tick_work {
 	int			cpu;
@@ -6111,9 +6085,6 @@ void __init sched_init(void)
 		rq->last_load_update_tick = jiffies;
 		rq->nohz_flags = 0;
 #endif
-#ifdef CONFIG_NO_HZ_FULL
-		rq->last_sched_tick = 0;
-#endif
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
diff --git a/kernel/sched/idle_task.c b/kernel/sched/idle_task.c
index d518664..a64fc92 100644
--- a/kernel/sched/idle_task.c
+++ b/kernel/sched/idle_task.c
@@ -48,7 +48,6 @@ dequeue_task_idle(struct rq *rq, struct task_struct *p, int flags)
 
 static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
 {
-	rq_last_tick_reset(rq);
 }
 
 static void task_tick_idle(struct rq *rq, struct task_struct *curr, int queued)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c1c7c78..dc6c8b5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -727,9 +727,7 @@ struct rq {
 #endif /* CONFIG_SMP */
 	unsigned long nohz_flags;
 #endif /* CONFIG_NO_HZ_COMMON */
-#ifdef CONFIG_NO_HZ_FULL
-	unsigned long last_sched_tick;
-#endif
+
 	/* capture load from *all* tasks on this cpu: */
 	struct load_weight load;
 	unsigned long nr_load_updates;
@@ -1626,13 +1624,6 @@ static inline void sub_nr_running(struct rq *rq, unsigned count)
 	sched_update_tick_dependency(rq);
 }
 
-static inline void rq_last_tick_reset(struct rq *rq)
-{
-#ifdef CONFIG_NO_HZ_FULL
-	rq->last_sched_tick = jiffies;
-#endif
-}
-
 extern void update_rq_clock(struct rq *rq);
 
 extern void activate_task(struct rq *rq, struct task_struct *p, int flags);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index b517485..0c615a0 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -748,12 +748,6 @@ static ktime_t tick_nohz_stop_sched_tick(struct tick_sched *ts,
 		delta = KTIME_MAX;
 	}
 
-#ifdef CONFIG_NO_HZ_FULL
-	/* Limit the tick delta to the maximum scheduler deferment */
-	if (!ts->inidle)
-		delta = min(delta, scheduler_tick_max_deferment());
-#endif
-
 	/* Calculate the next expiry time */
 	if (delta < (KTIME_MAX - basemono))
 		expires = basemono + delta;
-- 
2.7.4
