Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeDORoC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 13:44:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47405 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752460AbeDORoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 13:44:00 -0400
Date: Sun, 15 Apr 2018 19:43:58 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] scheduler updates for 4.17
Message-ID: <alpine.DEB.2.21.1804151936170.17929@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

A few scheduler fixes:

 - Prevent a bogus warning vs. runqueue clock update flags in
   do_sched_rt_period_timer()

 - Simplify the helper functions which handle requests for skipping the
   runqueue clock updat.

 - Do not unlock the tunables mutex in the error path of the cpu frequency
   scheduler utils. Its not held.

 - Enforce proper alignement for 'struct util_est' in sched_avg to prevent
   a misalignment fault on IA64

Thanks,

	tglx

------------------>
Davidlohr Bueso (2):
      sched/rt: Fix rq->clock_update_flags < RQCF_ACT_SKIP warning
      sched/core: Simplify helpers for rq clock update skip requests

Jules Maselbas (1):
      sched/cpufreq/schedutil: Fix error path mutex unlock

Peter Zijlstra (1):
      sched/core: Force proper alignment of 'struct util_est'


 include/linux/sched.h            |  6 +++---
 kernel/sched/core.c              |  2 +-
 kernel/sched/cpufreq_schedutil.c |  3 +--
 kernel/sched/deadline.c          |  2 +-
 kernel/sched/fair.c              |  2 +-
 kernel/sched/rt.c                |  4 +++-
 kernel/sched/sched.h             | 17 ++++++++++++-----
 7 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f228c6033832..b3d697f3b573 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -300,7 +300,7 @@ struct util_est {
 	unsigned int			enqueued;
 	unsigned int			ewma;
 #define UTIL_EST_WEIGHT_SHIFT		2
-};
+} __attribute__((__aligned__(sizeof(u64))));
 
 /*
  * The load_avg/util_avg accumulates an infinite geometric series
@@ -364,7 +364,7 @@ struct sched_avg {
 	unsigned long			runnable_load_avg;
 	unsigned long			util_avg;
 	struct util_est			util_est;
-};
+} ____cacheline_aligned;
 
 struct sched_statistics {
 #ifdef CONFIG_SCHEDSTATS
@@ -435,7 +435,7 @@ struct sched_entity {
 	 * Put into separate cache line so it does not
 	 * collide with read-mostly values above.
 	 */
-	struct sched_avg		avg ____cacheline_aligned_in_smp;
+	struct sched_avg		avg;
 #endif
 };
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 28b68995a417..550a07f648b6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -874,7 +874,7 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 	 * this case, we can save a useless back to back clock update.
 	 */
 	if (task_on_rq_queued(rq->curr) && test_tsk_need_resched(rq->curr))
-		rq_clock_skip_update(rq, true);
+		rq_clock_skip_update(rq);
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 2b124811947d..d2c6083304b4 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -631,10 +631,9 @@ static int sugov_init(struct cpufreq_policy *policy)
 
 stop_kthread:
 	sugov_kthread_stop(sg_policy);
-
-free_sg_policy:
 	mutex_unlock(&global_tunables_lock);
 
+free_sg_policy:
 	sugov_policy_free(sg_policy);
 
 disable_fast_switch:
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d1c7bf7c7e5b..e7b3008b85bb 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1560,7 +1560,7 @@ static void yield_task_dl(struct rq *rq)
 	 * so we don't do microscopic update in schedule()
 	 * and double the fastpath cost.
 	 */
-	rq_clock_skip_update(rq, true);
+	rq_clock_skip_update(rq);
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0951d1c58d2f..54dc31e7ab9b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7089,7 +7089,7 @@ static void yield_task_fair(struct rq *rq)
 		 * so we don't do microscopic update in schedule()
 		 * and double the fastpath cost.
 		 */
-		rq_clock_skip_update(rq, true);
+		rq_clock_skip_update(rq);
 	}
 
 	set_skip_buddy(se);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 86b77987435e..7aef6b4e885a 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -839,6 +839,8 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 			continue;
 
 		raw_spin_lock(&rq->lock);
+		update_rq_clock(rq);
+
 		if (rt_rq->rt_time) {
 			u64 runtime;
 
@@ -859,7 +861,7 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 				 * 'runtime'.
 				 */
 				if (rt_rq->rt_nr_running && rq->curr == rq->idle)
-					rq_clock_skip_update(rq, false);
+					rq_clock_cancel_skipupdate(rq);
 			}
 			if (rt_rq->rt_time || rt_rq->rt_nr_running)
 				idle = 0;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c3deaee7a7a2..15750c222ca2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -976,13 +976,20 @@ static inline u64 rq_clock_task(struct rq *rq)
 	return rq->clock_task;
 }
 
-static inline void rq_clock_skip_update(struct rq *rq, bool skip)
+static inline void rq_clock_skip_update(struct rq *rq)
 {
 	lockdep_assert_held(&rq->lock);
-	if (skip)
-		rq->clock_update_flags |= RQCF_REQ_SKIP;
-	else
-		rq->clock_update_flags &= ~RQCF_REQ_SKIP;
+	rq->clock_update_flags |= RQCF_REQ_SKIP;
+}
+
+/*
+ * See rt task throttoling, which is the only time a skip
+ * request is cancelled.
+ */
+static inline void rq_clock_cancel_skipupdate(struct rq *rq)
+{
+	lockdep_assert_held(&rq->lock);
+	rq->clock_update_flags &= ~RQCF_REQ_SKIP;
 }
 
 struct rq_flags {
