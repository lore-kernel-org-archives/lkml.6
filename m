Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032379AbeEZUG2 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 16:06:28 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60281 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032327AbeEZUG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 16:06:27 -0400
Date: Sat, 26 May 2018 22:06:25 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] scheduler fixes for 4.17
Message-ID: <alpine.DEB.2.21.1805262157520.1585@nanos.tec.linutronix.de>
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

Three fixes for scheduler and kthread code:

 - Allow calling kthread_park() on an already parked thread

 - Restore the sched_pi_setprio() tracepoint behaviour

 - Clarify the unclear string for the scheduling domain debug output

Thanks,

	tglx

------------------>
Juri Lelli (1):
      sched/topology: Clarify root domain(s) debug string

Peter Zijlstra (1):
      kthread: Allow kthread_park() on a parked kthread

Sebastian Andrzej Siewior (1):
      sched, tracing: Fix trace_sched_pi_setprio() for deboosting


 include/trace/events/sched.h | 4 +++-
 kernel/kthread.c             | 6 ++----
 kernel/sched/topology.c      | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index bc01e06bc716..0be866c91f62 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -435,7 +435,9 @@ TRACE_EVENT(sched_pi_setprio,
 		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
 		__entry->pid		= tsk->pid;
 		__entry->oldprio	= tsk->prio;
-		__entry->newprio	= pi_task ? pi_task->prio : tsk->prio;
+		__entry->newprio	= pi_task ?
+				min(tsk->normal_prio, pi_task->prio) :
+				tsk->normal_prio;
 		/* XXX SCHED_DEADLINE bits missing */
 	),
 
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 2017a39ab490..481951bf091d 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -193,7 +193,7 @@ EXPORT_SYMBOL_GPL(kthread_parkme);
 
 void kthread_park_complete(struct task_struct *k)
 {
-	complete(&to_kthread(k)->parked);
+	complete_all(&to_kthread(k)->parked);
 }
 
 static int kthread(void *_create)
@@ -459,6 +459,7 @@ void kthread_unpark(struct task_struct *k)
 	if (test_bit(KTHREAD_IS_PER_CPU, &kthread->flags))
 		__kthread_bind(k, kthread->cpu, TASK_PARKED);
 
+	reinit_completion(&kthread->parked);
 	clear_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
 	wake_up_state(k, TASK_PARKED);
 }
@@ -483,9 +484,6 @@ int kthread_park(struct task_struct *k)
 	if (WARN_ON(k->flags & PF_EXITING))
 		return -ENOSYS;
 
-	if (WARN_ON_ONCE(test_bit(KTHREAD_SHOULD_PARK, &kthread->flags)))
-		return -EBUSY;
-
 	set_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
 	if (k != current) {
 		wake_up_process(k);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 64cc564f5255..61a1125c1ae4 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1708,7 +1708,7 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	rcu_read_unlock();
 
 	if (rq && sched_debug_enabled) {
-		pr_info("span: %*pbl (max cpu_capacity = %lu)\n",
+		pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
 			cpumask_pr_args(cpu_map), rq->rd->max_cpu_capacity);
 	}
 
