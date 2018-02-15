Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032374AbeBOBBF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 20:01:05 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37963 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752602AbeBOBBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 20:01:04 -0500
X-Google-Smtp-Source: AH8x225GuyT/5/ZfGzIngBGWVF8ywR9haZLLEOIxjHRrwa5rUDff4fyW19B782wNJ8o/2mRqbkfFdQ==
Date: Thu, 15 Feb 2018 02:00:59 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler fixes
Message-ID: <20180215010059.asvm5rhlv75keof4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

   # HEAD: 43d1b29b27c76e7454cd6c85bec4d0e9cbb039f3 sched/cpufreq: Remove unused SUGOV_KTHREAD_PRIORITY macro

Misc fixes:

 - fix rq->lock lockdep annotation bug
 - fix/improve update_curr_rt() and update_curr_dl() accounting
 - update documentation
 - remove unused macro

 Thanks,

	Ingo

------------------>
Leo Yan (1):
      sched/cpufreq: Remove unused SUGOV_KTHREAD_PRIORITY macro

Mathieu Desnoyers (1):
      membarrier-sync-core: Document architecture support

Peter Zijlstra (1):
      sched/core: Fix DEBUG_SPINLOCK annotation for rq->lock

Wen Yang (2):
      sched/deadline: Make update_curr_dl() more accurate
      sched/rt: Make update_curr_rt() more accurate


 .../sched/membarrier-sync-core/arch-support.txt    | 62 ++++++++++++++++++++++
 kernel/sched/core.c                                | 27 ++++++----
 kernel/sched/cpufreq_schedutil.c                   |  2 -
 kernel/sched/deadline.c                            |  6 ++-
 kernel/sched/rt.c                                  |  3 +-
 5 files changed, 84 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/features/sched/membarrier-sync-core/arch-support.txt

diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
new file mode 100644
index 000000000000..2c815a7f1ba7
--- /dev/null
+++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
@@ -0,0 +1,62 @@
+#
+# Feature name:          membarrier-sync-core
+#         Kconfig:       ARCH_HAS_MEMBARRIER_SYNC_CORE
+#         description:   arch supports core serializing membarrier
+#
+# Architecture requirements
+#
+# * arm64
+#
+# Rely on eret context synchronization when returning from IPI handler, and
+# when returning to user-space.
+#
+# * x86
+#
+# x86-32 uses IRET as return from interrupt, which takes care of the IPI.
+# However, it uses both IRET and SYSEXIT to go back to user-space. The IRET
+# instruction is core serializing, but not SYSEXIT.
+#
+# x86-64 uses IRET as return from interrupt, which takes care of the IPI.
+# However, it can return to user-space through either SYSRETL (compat code),
+# SYSRETQ, or IRET.
+#
+# Given that neither SYSRET{L,Q}, nor SYSEXIT, are core serializing, we rely
+# instead on write_cr3() performed by switch_mm() to provide core serialization
+# after changing the current mm, and deal with the special case of kthread ->
+# uthread (temporarily keeping current mm into active_mm) by issuing a
+# sync_core_before_usermode() in that specific case.
+#
+    -----------------------
+    |         arch |status|
+    -----------------------
+    |       alpha: | TODO |
+    |         arc: | TODO |
+    |         arm: | TODO |
+    |       arm64: |  ok  |
+    |    blackfin: | TODO |
+    |         c6x: | TODO |
+    |        cris: | TODO |
+    |         frv: | TODO |
+    |       h8300: | TODO |
+    |     hexagon: | TODO |
+    |        ia64: | TODO |
+    |        m32r: | TODO |
+    |        m68k: | TODO |
+    |       metag: | TODO |
+    |  microblaze: | TODO |
+    |        mips: | TODO |
+    |     mn10300: | TODO |
+    |       nios2: | TODO |
+    |    openrisc: | TODO |
+    |      parisc: | TODO |
+    |     powerpc: | TODO |
+    |        s390: | TODO |
+    |       score: | TODO |
+    |          sh: | TODO |
+    |       sparc: | TODO |
+    |        tile: | TODO |
+    |          um: | TODO |
+    |   unicore32: | TODO |
+    |         x86: |  ok  |
+    |      xtensa: | TODO |
+    -----------------------
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bf724c1952ea..e7c535eee0a6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2601,19 +2601,31 @@ static inline void finish_task(struct task_struct *prev)
 #endif
 }
 
-static inline void finish_lock_switch(struct rq *rq)
+static inline void
+prepare_lock_switch(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 {
+	/*
+	 * Since the runqueue lock will be released by the next
+	 * task (which is an invalid locking op but in the case
+	 * of the scheduler it's an obvious special-case), so we
+	 * do an early lockdep release here:
+	 */
+	rq_unpin_lock(rq, rf);
+	spin_release(&rq->lock.dep_map, 1, _THIS_IP_);
 #ifdef CONFIG_DEBUG_SPINLOCK
 	/* this is a valid case when another task releases the spinlock */
-	rq->lock.owner = current;
+	rq->lock.owner = next;
 #endif
+}
+
+static inline void finish_lock_switch(struct rq *rq)
+{
 	/*
 	 * If we are tracking spinlock dependencies then we have to
 	 * fix up the runqueue lock - which gets 'carried over' from
 	 * prev into current:
 	 */
 	spin_acquire(&rq->lock.dep_map, 0, 0, _THIS_IP_);
-
 	raw_spin_unlock_irq(&rq->lock);
 }
 
@@ -2844,14 +2856,7 @@ context_switch(struct rq *rq, struct task_struct *prev,
 
 	rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
 
-	/*
-	 * Since the runqueue lock will be released by the next
-	 * task (which is an invalid locking op but in the case
-	 * of the scheduler it's an obvious special-case), so we
-	 * do an early lockdep release here:
-	 */
-	rq_unpin_lock(rq, rf);
-	spin_release(&rq->lock.dep_map, 1, _THIS_IP_);
+	prepare_lock_switch(rq, next, rf);
 
 	/* Here we just switch the register state and the stack. */
 	switch_to(prev, next, prev);
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index dd062a1c8cf0..7936f548e071 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -19,8 +19,6 @@
 
 #include "sched.h"
 
-#define SUGOV_KTHREAD_PRIORITY	50
-
 struct sugov_tunables {
 	struct gov_attr_set attr_set;
 	unsigned int rate_limit_us;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 9bb0e0c412ec..9df09782025c 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1153,6 +1153,7 @@ static void update_curr_dl(struct rq *rq)
 	struct sched_dl_entity *dl_se = &curr->dl;
 	u64 delta_exec, scaled_delta_exec;
 	int cpu = cpu_of(rq);
+	u64 now;
 
 	if (!dl_task(curr) || !on_dl_rq(dl_se))
 		return;
@@ -1165,7 +1166,8 @@ static void update_curr_dl(struct rq *rq)
 	 * natural solution, but the full ramifications of this
 	 * approach need further study.
 	 */
-	delta_exec = rq_clock_task(rq) - curr->se.exec_start;
+	now = rq_clock_task(rq);
+	delta_exec = now - curr->se.exec_start;
 	if (unlikely((s64)delta_exec <= 0)) {
 		if (unlikely(dl_se->dl_yielded))
 			goto throttle;
@@ -1178,7 +1180,7 @@ static void update_curr_dl(struct rq *rq)
 	curr->se.sum_exec_runtime += delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
 
-	curr->se.exec_start = rq_clock_task(rq);
+	curr->se.exec_start = now;
 	cgroup_account_cputime(curr, delta_exec);
 
 	sched_rt_avg_update(rq, delta_exec);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 663b2355a3aa..aad49451584e 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -950,12 +950,13 @@ static void update_curr_rt(struct rq *rq)
 {
 	struct task_struct *curr = rq->curr;
 	struct sched_rt_entity *rt_se = &curr->rt;
-	u64 now = rq_clock_task(rq);
 	u64 delta_exec;
+	u64 now;
 
 	if (curr->sched_class != &rt_sched_class)
 		return;
 
+	now = rq_clock_task(rq);
 	delta_exec = now - curr->se.exec_start;
 	if (unlikely((s64)delta_exec <= 0))
 		return;
