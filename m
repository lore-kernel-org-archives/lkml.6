Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752433AbeBEVjy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 16:39:54 -0500
Received: from terminus.zytor.com ([65.50.211.136]:50489 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752319AbeBEVjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 16:39:04 -0500
Date: Mon, 5 Feb 2018 13:26:24 -0800
From: tip-bot for Mathieu Desnoyers <tipbot@zytor.com>
Message-ID: <tip-3ccfebedd8cf54e291c809c838d8ad5cc00f5688@git.kernel.org>
Cc: npiggin@gmail.com, tglx@linutronix.de, linux@armlinux.org.uk,
        peterz@infradead.org, viro@zeniv.linux.org.uk, mpe@ellerman.id.au,
        sehr@google.com, paulus@samba.org, boqun.feng@gmail.com, hpa@zytor.com,
        mingo@kernel.org, torvalds@linux-foundation.org, davejwatson@fb.com,
        mathieu.desnoyers@efficios.com, avi@scylladb.com,
        stern@rowland.harvard.edu, parri.andrea@gmail.com,
        linux-kernel@vger.kernel.org, will.deacon@arm.com, ahh@google.com,
        paulmck@linux.vnet.ibm.com, luto@kernel.org, benh@kernel.crashing.org,
        maged.michael@gmail.com, ghackmann@google.com
Reply-To: ghackmann@google.com, maged.michael@gmail.com,
        benh@kernel.crashing.org, luto@kernel.org, paulmck@linux.vnet.ibm.com,
        ahh@google.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
        parri.andrea@gmail.com, avi@scylladb.com, stern@rowland.harvard.edu,
        mathieu.desnoyers@efficios.com, davejwatson@fb.com,
        torvalds@linux-foundation.org, mingo@kernel.org, hpa@zytor.com,
        boqun.feng@gmail.com, paulus@samba.org, mpe@ellerman.id.au,
        viro@zeniv.linux.org.uk, sehr@google.com, peterz@infradead.org,
        linux@armlinux.org.uk, tglx@linutronix.de, npiggin@gmail.com
In-Reply-To: <20180129202020.8515-3-mathieu.desnoyers@efficios.com>
References: <20180129202020.8515-3-mathieu.desnoyers@efficios.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] powerpc, membarrier: Skip memory barrier in
 switch_mm()
Git-Commit-ID: 3ccfebedd8cf54e291c809c838d8ad5cc00f5688
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

Commit-ID:  3ccfebedd8cf54e291c809c838d8ad5cc00f5688
Gitweb:     https://git.kernel.org/tip/3ccfebedd8cf54e291c809c838d8ad5cc00f5688
Author:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate: Mon, 29 Jan 2018 15:20:11 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 5 Feb 2018 21:34:02 +0100

powerpc, membarrier: Skip memory barrier in switch_mm()

Allow PowerPC to skip the full memory barrier in switch_mm(), and
only issue the barrier when scheduling into a task belonging to a
process that has registered to use expedited private.

Threads targeting the same VM but which belong to different thread
groups is a tricky case. It has a few consequences:

It turns out that we cannot rely on get_nr_threads(p) to count the
number of threads using a VM. We can use
(atomic_read(&mm->mm_users) == 1 && get_nr_threads(p) == 1)
instead to skip the synchronize_sched() for cases where the VM only has
a single user, and that user only has a single thread.

It also turns out that we cannot use for_each_thread() to set
thread flags in all threads using a VM, as it only iterates on the
thread group.

Therefore, test the membarrier state variable directly rather than
relying on thread flags. This means
membarrier_register_private_expedited() needs to set the
MEMBARRIER_STATE_PRIVATE_EXPEDITED flag, issue synchronize_sched(), and
only then set MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY which allows
private expedited membarrier commands to succeed.
membarrier_arch_switch_mm() now tests for the
MEMBARRIER_STATE_PRIVATE_EXPEDITED flag.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Andrew Hunter <ahh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Avi Kivity <avi@scylladb.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Dave Watson <davejwatson@fb.com>
Cc: David Sehr <sehr@google.com>
Cc: Greg Hackmann <ghackmann@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Maged Michael <maged.michael@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-api@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/20180129202020.8515-3-mathieu.desnoyers@efficios.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 MAINTAINERS                           |  1 +
 arch/powerpc/Kconfig                  |  1 +
 arch/powerpc/include/asm/membarrier.h | 26 ++++++++++++++++++++++++++
 arch/powerpc/mm/mmu_context.c         |  7 +++++++
 include/linux/sched/mm.h              | 13 ++++++++++++-
 init/Kconfig                          |  3 +++
 kernel/sched/core.c                   | 10 ----------
 kernel/sched/membarrier.c             |  8 ++++++++
 8 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 217a875..8e96d4e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8944,6 +8944,7 @@ L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	kernel/sched/membarrier.c
 F:	include/uapi/linux/membarrier.h
+F:	arch/powerpc/include/asm/membarrier.h
 
 MEMORY MANAGEMENT
 L:	linux-mm@kvack.org
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2ed525a..a2380de 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -140,6 +140,7 @@ config PPC
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_PMEM_API                if PPC64
+	select ARCH_HAS_MEMBARRIER_CALLBACKS
 	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
diff --git a/arch/powerpc/include/asm/membarrier.h b/arch/powerpc/include/asm/membarrier.h
new file mode 100644
index 0000000..98ff4f1
--- /dev/null
+++ b/arch/powerpc/include/asm/membarrier.h
@@ -0,0 +1,26 @@
+#ifndef _ASM_POWERPC_MEMBARRIER_H
+#define _ASM_POWERPC_MEMBARRIER_H
+
+static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
+					     struct mm_struct *next,
+					     struct task_struct *tsk)
+{
+	/*
+	 * Only need the full barrier when switching between processes.
+	 * Barrier when switching from kernel to userspace is not
+	 * required here, given that it is implied by mmdrop(). Barrier
+	 * when switching from userspace to kernel is not needed after
+	 * store to rq->curr.
+	 */
+	if (likely(!(atomic_read(&next->membarrier_state) &
+		     MEMBARRIER_STATE_PRIVATE_EXPEDITED) || !prev))
+		return;
+
+	/*
+	 * The membarrier system call requires a full memory barrier
+	 * after storing to rq->curr, before going back to user-space.
+	 */
+	smp_mb();
+}
+
+#endif /* _ASM_POWERPC_MEMBARRIER_H */
diff --git a/arch/powerpc/mm/mmu_context.c b/arch/powerpc/mm/mmu_context.c
index d60a62b..0ab297c 100644
--- a/arch/powerpc/mm/mmu_context.c
+++ b/arch/powerpc/mm/mmu_context.c
@@ -12,6 +12,7 @@
 
 #include <linux/mm.h>
 #include <linux/cpu.h>
+#include <linux/sched/mm.h>
 
 #include <asm/mmu_context.h>
 
@@ -58,6 +59,10 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		 *
 		 * On the read side the barrier is in pte_xchg(), which orders
 		 * the store to the PTE vs the load of mm_cpumask.
+		 *
+		 * This full barrier is needed by membarrier when switching
+		 * between processes after store to rq->curr, before user-space
+		 * memory accesses.
 		 */
 		smp_mb();
 
@@ -80,6 +85,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 
 	if (new_on_cpu)
 		radix_kvm_prefetch_workaround(next);
+	else
+		membarrier_arch_switch_mm(prev, next, tsk);
 
 	/*
 	 * The actual HW switching method differs between the various
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 3d49b91..26307cd 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -215,14 +215,25 @@ static inline void memalloc_noreclaim_restore(unsigned int flags)
 #ifdef CONFIG_MEMBARRIER
 enum {
 	MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY	= (1U << 0),
-	MEMBARRIER_STATE_SWITCH_MM			= (1U << 1),
+	MEMBARRIER_STATE_PRIVATE_EXPEDITED		= (1U << 1),
 };
 
+#ifdef CONFIG_ARCH_HAS_MEMBARRIER_CALLBACKS
+#include <asm/membarrier.h>
+#endif
+
 static inline void membarrier_execve(struct task_struct *t)
 {
 	atomic_set(&t->mm->membarrier_state, 0);
 }
 #else
+#ifdef CONFIG_ARCH_HAS_MEMBARRIER_CALLBACKS
+static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
+					     struct mm_struct *next,
+					     struct task_struct *tsk)
+{
+}
+#endif
 static inline void membarrier_execve(struct task_struct *t)
 {
 }
diff --git a/init/Kconfig b/init/Kconfig
index a9a2e2c..837adcf 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1412,6 +1412,9 @@ config USERFAULTFD
 	  Enable the userfaultfd() system call that allows to intercept and
 	  handle page faults in userland.
 
+config ARCH_HAS_MEMBARRIER_CALLBACKS
+	bool
+
 config EMBEDDED
 	bool "Embedded system"
 	option allnoconfig_y
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3da7a24..ead0c21 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2698,16 +2698,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	prev_state = prev->state;
 	vtime_task_switch(prev);
 	perf_event_task_sched_in(prev, current);
-	/*
-	 * The membarrier system call requires a full memory barrier
-	 * after storing to rq->curr, before going back to user-space.
-	 *
-	 * TODO: This smp_mb__after_unlock_lock can go away if PPC end
-	 * up adding a full barrier to switch_mm(), or we should figure
-	 * out if a smp_mb__after_unlock_lock is really the proper API
-	 * to use.
-	 */
-	smp_mb__after_unlock_lock();
 	finish_task(prev);
 	finish_lock_switch(rq);
 	finish_arch_post_lock_switch();
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 9bcbacb..6785772 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -118,6 +118,14 @@ static void membarrier_register_private_expedited(void)
 	if (atomic_read(&mm->membarrier_state)
 			& MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY)
 		return;
+	atomic_or(MEMBARRIER_STATE_PRIVATE_EXPEDITED, &mm->membarrier_state);
+	if (!(atomic_read(&mm->mm_users) == 1 && get_nr_threads(p) == 1)) {
+		/*
+		 * Ensure all future scheduler executions will observe the
+		 * new thread flag state for this process.
+		 */
+		synchronize_sched();
+	}
 	atomic_or(MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY,
 			&mm->membarrier_state);
 }
