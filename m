Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751295AbeFCJXD (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 05:23:03 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36106 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751254AbeFCJXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 05:23:02 -0400
Date: Sun, 3 Jun 2018 11:23:00 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] scheduler fixes for 4.17
Message-ID: <alpine.DEB.2.21.1806031113440.1603@nanos.tec.linutronix.de>
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

A set of scheduler fixes:

 - Two patches addressing the problem that the scheduler allows under
   certain conditions user space tasks to be scheduled on CPUs which are
   not yet fully booted which causes a few subtle and hard to debug issue.

 - Add a missing runqueue clock update in the deadline scheduler which
   triggers a warning under certain circumstances.

 - Fix a silly typo in the scheduler header file.

Thanks,

	tglx

------------------>
Davidlohr Bueso (1):
      sched/headers: Fix typo

Juri Lelli (1):
      sched/deadline: Fix missing clock update

Paul Burton (1):
      sched/core: Require cpu_active() in select_task_rq(), for user tasks

Peter Zijlstra (1):
      sched/core: Fix rules for running on online && !active CPUs


 kernel/sched/core.c     | 45 +++++++++++++++++++++++++++++++--------------
 kernel/sched/deadline.c |  6 +++---
 kernel/sched/sched.h    |  2 +-
 3 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 092f7c4de903..211890edf37e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -881,6 +881,33 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 }
 
 #ifdef CONFIG_SMP
+
+static inline bool is_per_cpu_kthread(struct task_struct *p)
+{
+	if (!(p->flags & PF_KTHREAD))
+		return false;
+
+	if (p->nr_cpus_allowed != 1)
+		return false;
+
+	return true;
+}
+
+/*
+ * Per-CPU kthreads are allowed to run on !actie && online CPUs, see
+ * __set_cpus_allowed_ptr() and select_fallback_rq().
+ */
+static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
+{
+	if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
+		return false;
+
+	if (is_per_cpu_kthread(p))
+		return cpu_online(cpu);
+
+	return cpu_active(cpu);
+}
+
 /*
  * This is how migration works:
  *
@@ -938,16 +965,8 @@ struct migration_arg {
 static struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
 				 struct task_struct *p, int dest_cpu)
 {
-	if (p->flags & PF_KTHREAD) {
-		if (unlikely(!cpu_online(dest_cpu)))
-			return rq;
-	} else {
-		if (unlikely(!cpu_active(dest_cpu)))
-			return rq;
-	}
-
 	/* Affinity changed (again). */
-	if (!cpumask_test_cpu(dest_cpu, &p->cpus_allowed))
+	if (!is_cpu_allowed(p, dest_cpu))
 		return rq;
 
 	update_rq_clock(rq);
@@ -1476,10 +1495,9 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
 	for (;;) {
 		/* Any allowed, online CPU? */
 		for_each_cpu(dest_cpu, &p->cpus_allowed) {
-			if (!(p->flags & PF_KTHREAD) && !cpu_active(dest_cpu))
-				continue;
-			if (!cpu_online(dest_cpu))
+			if (!is_cpu_allowed(p, dest_cpu))
 				continue;
+
 			goto out;
 		}
 
@@ -1542,8 +1560,7 @@ int select_task_rq(struct task_struct *p, int cpu, int sd_flags, int wake_flags)
 	 * [ this allows ->select_task() to simply return task_cpu(p) and
 	 *   not worry about this generic constraint ]
 	 */
-	if (unlikely(!cpumask_test_cpu(cpu, &p->cpus_allowed) ||
-		     !cpu_online(cpu)))
+	if (unlikely(!is_cpu_allowed(p, cpu)))
 		cpu = select_fallback_rq(task_cpu(p), p);
 
 	return cpu;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 1356afd1eeb6..fbfc3f1d368a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1259,6 +1259,9 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 
 	rq = task_rq_lock(p, &rf);
 
+	sched_clock_tick();
+	update_rq_clock(rq);
+
 	if (!dl_task(p) || p->state == TASK_DEAD) {
 		struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
 
@@ -1278,9 +1281,6 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 	if (dl_se->dl_non_contending == 0)
 		goto unlock;
 
-	sched_clock_tick();
-	update_rq_clock(rq);
-
 	sub_running_bw(dl_se, &rq->dl);
 	dl_se->dl_non_contending = 0;
 unlock:
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1f0a4bc6a39d..cb467c221b15 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -983,7 +983,7 @@ static inline void rq_clock_skip_update(struct rq *rq)
 }
 
 /*
- * See rt task throttoling, which is the only time a skip
+ * See rt task throttling, which is the only time a skip
  * request is cancelled.
  */
 static inline void rq_clock_cancel_skipupdate(struct rq *rq)
