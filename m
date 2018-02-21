Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933313AbeBUKi0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:38:26 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52133 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932790AbeBUKiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:38:25 -0500
Date: Wed, 21 Feb 2018 02:37:50 -0800
From: tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-dcdedb24159be3487e3dbbe1faa79ae7d00c92ac@git.kernel.org>
Cc: peterz@infradead.org, mingo@kernel.org, kernellwp@gmail.com,
        riel@redhat.com, lcapitulino@redhat.com, efault@gmx.de,
        tglx@linutronix.de, cl@linux.com, torvalds@linux-foundation.org,
        hpa@zytor.com, paulmck@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, frederic@kernel.org,
        cmetcalf@mellanox.com
Reply-To: linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com,
        cmetcalf@mellanox.com, frederic@kernel.org,
        torvalds@linux-foundation.org, hpa@zytor.com, tglx@linutronix.de,
        cl@linux.com, kernellwp@gmail.com, mingo@kernel.org,
        peterz@infradead.org, efault@gmx.de, lcapitulino@redhat.com,
        riel@redhat.com
In-Reply-To: <1519186649-3242-7-git-send-email-frederic@kernel.org>
References: <1519186649-3242-7-git-send-email-frederic@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/nohz: Remove the 1 Hz tick code
Git-Commit-ID: dcdedb24159be3487e3dbbe1faa79ae7d00c92ac
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

Commit-ID:  dcdedb24159be3487e3dbbe1faa79ae7d00c92ac
Gitweb:     https://git.kernel.org/tip/dcdedb24159be3487e3dbbe1faa79ae7d00c92ac
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Wed, 21 Feb 2018 05:17:28 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 09:49:09 +0100

sched/nohz: Remove the 1 Hz tick code

Now that the 1Hz tick is offloaded to workqueues, we can safely remove
the residual code that used to handle it locally.

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
Link: http://lkml.kernel.org/r/1519186649-3242-7-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
index 5dfef45..8fff4f1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3096,35 +3096,9 @@ void scheduler_tick(void)
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
@@ -6116,9 +6090,6 @@ void __init sched_init(void)
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
index e1b46e0..48b8a83 100644
--- a/kernel/sched/idle_task.c
+++ b/kernel/sched/idle_task.c
@@ -48,7 +48,6 @@ dequeue_task_idle(struct rq *rq, struct task_struct *p, int flags)
 
 static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
 {
-	rq_last_tick_reset(rq);
 }
 
 /*
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
index d479b21..f2fa2e9 100644
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
