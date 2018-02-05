Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752227AbeBEVjk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 16:39:40 -0500
Received: from terminus.zytor.com ([65.50.211.136]:59545 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752408AbeBEVj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 16:39:27 -0500
Date: Mon, 5 Feb 2018 13:26:51 -0800
From: tip-bot for Mathieu Desnoyers <tipbot@zytor.com>
Message-ID: <tip-306e060435d7a3aef8f6f033e43b0f581638adce@git.kernel.org>
Cc: mathieu.desnoyers@efficios.com, parri.andrea@gmail.com,
        linux@armlinux.org.uk, maged.michael@gmail.com,
        linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
        will.deacon@arm.com, davejwatson@fb.com, avi@scylladb.com,
        ahh@google.com, tglx@linutronix.de, ghackmann@google.com,
        mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        torvalds@linux-foundation.org, boqun.feng@gmail.com,
        mpe@ellerman.id.au, sehr@google.com, paulus@samba.org, hpa@zytor.com,
        luto@kernel.org, peterz@infradead.org
Reply-To: peterz@infradead.org, luto@kernel.org, sehr@google.com,
        hpa@zytor.com, paulus@samba.org, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org,
        boqun.feng@gmail.com, mpe@ellerman.id.au, tglx@linutronix.de,
        ghackmann@google.com, davejwatson@fb.com, avi@scylladb.com,
        ahh@google.com, linux@armlinux.org.uk, maged.michael@gmail.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        benh@kernel.crashing.org, mathieu.desnoyers@efficios.com,
        parri.andrea@gmail.com
In-Reply-To: <20180129202020.8515-4-mathieu.desnoyers@efficios.com>
References: <20180129202020.8515-4-mathieu.desnoyers@efficios.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] membarrier: Document scheduler barrier
 requirements
Git-Commit-ID: 306e060435d7a3aef8f6f033e43b0f581638adce
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

Commit-ID:  306e060435d7a3aef8f6f033e43b0f581638adce
Gitweb:     https://git.kernel.org/tip/306e060435d7a3aef8f6f033e43b0f581638adce
Author:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate: Mon, 29 Jan 2018 15:20:12 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 5 Feb 2018 21:34:21 +0100

membarrier: Document scheduler barrier requirements

Document the membarrier requirement on having a full memory barrier in
__schedule() after coming from user-space, before storing to rq->curr.
It is provided by smp_mb__after_spinlock() in __schedule().

Document that membarrier requires a full barrier on transition from
kernel thread to userspace thread. We currently have an implicit barrier
from atomic_dec_and_test() in mmdrop() that ensures this.

The x86 switch_mm_irqs_off() full barrier is currently provided by many
cpumask update operations as well as write_cr3(). Document that
write_cr3() provides this barrier.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Andrew Hunter <ahh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Avi Kivity <avi@scylladb.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Dave Watson <davejwatson@fb.com>
Cc: David Sehr <sehr@google.com>
Cc: Greg Hackmann <ghackmann@google.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Maged Michael <maged.michael@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-api@vger.kernel.org
Link: http://lkml.kernel.org/r/20180129202020.8515-4-mathieu.desnoyers@efficios.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/tlb.c        |  5 +++++
 include/linux/sched/mm.h |  5 +++++
 kernel/sched/core.c      | 37 ++++++++++++++++++++++++++-----------
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 5bfe61a..9fa7d2e 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -228,6 +228,11 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 #endif
 	this_cpu_write(cpu_tlbstate.is_lazy, false);
 
+	/*
+	 * The membarrier system call requires a full memory barrier
+	 * before returning to user-space, after storing to rq->curr.
+	 * Writing to CR3 provides that full memory barrier.
+	 */
 	if (real_prev == next) {
 		VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
 			   next->context.ctx_id);
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 26307cd..b84e0fd 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -39,6 +39,11 @@ static inline void mmgrab(struct mm_struct *mm)
 extern void __mmdrop(struct mm_struct *);
 static inline void mmdrop(struct mm_struct *mm)
 {
+	/*
+	 * The implicit full barrier implied by atomic_dec_and_test() is
+	 * required by the membarrier system call before returning to
+	 * user-space, after storing to rq->curr.
+	 */
 	if (unlikely(atomic_dec_and_test(&mm->mm_count)))
 		__mmdrop(mm);
 }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ead0c21..11bf4d4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2703,6 +2703,12 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	finish_arch_post_lock_switch();
 
 	fire_sched_in_preempt_notifiers(current);
+	/*
+	 * When transitioning from a kernel thread to a userspace
+	 * thread, mmdrop()'s implicit full barrier is required by the
+	 * membarrier system call, because the current ->active_mm can
+	 * become the current mm without going through switch_mm().
+	 */
 	if (mm)
 		mmdrop(mm);
 	if (unlikely(prev_state == TASK_DEAD)) {
@@ -2808,6 +2814,13 @@ context_switch(struct rq *rq, struct task_struct *prev,
 	 */
 	arch_start_context_switch(prev);
 
+	/*
+	 * If mm is non-NULL, we pass through switch_mm(). If mm is
+	 * NULL, we will pass through mmdrop() in finish_task_switch().
+	 * Both of these contain the full memory barrier required by
+	 * membarrier after storing to rq->curr, before returning to
+	 * user-space.
+	 */
 	if (!mm) {
 		next->active_mm = oldmm;
 		mmgrab(oldmm);
@@ -3344,6 +3357,9 @@ static void __sched notrace __schedule(bool preempt)
 	 * Make sure that signal_pending_state()->signal_pending() below
 	 * can't be reordered with __set_current_state(TASK_INTERRUPTIBLE)
 	 * done by the caller to avoid the race with signal_wake_up().
+	 *
+	 * The membarrier system call requires a full memory barrier
+	 * after coming from user-space, before storing to rq->curr.
 	 */
 	rq_lock(rq, &rf);
 	smp_mb__after_spinlock();
@@ -3391,17 +3407,16 @@ static void __sched notrace __schedule(bool preempt)
 		/*
 		 * The membarrier system call requires each architecture
 		 * to have a full memory barrier after updating
-		 * rq->curr, before returning to user-space. For TSO
-		 * (e.g. x86), the architecture must provide its own
-		 * barrier in switch_mm(). For weakly ordered machines
-		 * for which spin_unlock() acts as a full memory
-		 * barrier, finish_lock_switch() in common code takes
-		 * care of this barrier. For weakly ordered machines for
-		 * which spin_unlock() acts as a RELEASE barrier (only
-		 * arm64 and PowerPC), arm64 has a full barrier in
-		 * switch_to(), and PowerPC has
-		 * smp_mb__after_unlock_lock() before
-		 * finish_lock_switch().
+		 * rq->curr, before returning to user-space.
+		 *
+		 * Here are the schemes providing that barrier on the
+		 * various architectures:
+		 * - mm ? switch_mm() : mmdrop() for x86, s390, sparc, PowerPC.
+		 *   switch_mm() rely on membarrier_arch_switch_mm() on PowerPC.
+		 * - finish_lock_switch() for weakly-ordered
+		 *   architectures where spin_unlock is a full barrier,
+		 * - switch_to() for arm64 (weakly-ordered, spin_unlock
+		 *   is a RELEASE barrier),
 		 */
 		++*switch_count;
 
