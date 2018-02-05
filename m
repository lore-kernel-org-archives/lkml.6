Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbeBEVno (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 16:43:44 -0500
Received: from terminus.zytor.com ([65.50.211.136]:41731 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752021AbeBEVnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 16:43:37 -0500
Date: Mon, 5 Feb 2018 13:29:34 -0800
From: tip-bot for Mathieu Desnoyers <tipbot@zytor.com>
Message-ID: <tip-10bcc80e9dbced128e3b4aa86e4737e5486a45d0@git.kernel.org>
Cc: paulmck@linux.vnet.ibm.com, ahh@google.com, paulus@samba.org,
        sehr@google.com, davejwatson@fb.com, ghackmann@google.com,
        mathieu.desnoyers@efficios.com, hpa@zytor.com, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, mpe@ellerman.id.au, avi@scylladb.com,
        tglx@linutronix.de, parri.andrea@gmail.com, luto@kernel.org,
        benh@kernel.crashing.org, linux@armlinux.org.uk, will.deacon@arm.com,
        torvalds@linux-foundation.org, mingo@kernel.org,
        maged.michael@gmail.com, peterz@infradead.org
Reply-To: davejwatson@fb.com, ghackmann@google.com,
        mathieu.desnoyers@efficios.com, hpa@zytor.com, tglx@linutronix.de,
        avi@scylladb.com, mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
        boqun.feng@gmail.com, ahh@google.com, paulmck@linux.vnet.ibm.com,
        paulus@samba.org, sehr@google.com, linux@armlinux.org.uk,
        benh@kernel.crashing.org, will.deacon@arm.com, mingo@kernel.org,
        torvalds@linux-foundation.org, maged.michael@gmail.com,
        peterz@infradead.org, parri.andrea@gmail.com, luto@kernel.org
In-Reply-To: <20180129202020.8515-10-mathieu.desnoyers@efficios.com>
References: <20180129202020.8515-10-mathieu.desnoyers@efficios.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] membarrier/x86: Provide core serializing command
Git-Commit-ID: 10bcc80e9dbced128e3b4aa86e4737e5486a45d0
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

Commit-ID:  10bcc80e9dbced128e3b4aa86e4737e5486a45d0
Gitweb:     https://git.kernel.org/tip/10bcc80e9dbced128e3b4aa86e4737e5486a45d0
Author:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate: Mon, 29 Jan 2018 15:20:18 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 5 Feb 2018 21:35:11 +0100

membarrier/x86: Provide core serializing command

There are two places where core serialization is needed by membarrier:

1) When returning from the membarrier IPI,
2) After scheduler updates curr to a thread with a different mm, before
   going back to user-space, since the curr->mm is used by membarrier to
   check whether it needs to send an IPI to that CPU.

x86-32 uses IRET as return from interrupt, and both IRET and SYSEXIT to go
back to user-space. The IRET instruction is core serializing, but not
SYSEXIT.

x86-64 uses IRET as return from interrupt, which takes care of the IPI.
However, it can return to user-space through either SYSRETL (compat
code), SYSRETQ, or IRET. Given that SYSRET{L,Q} is not core serializing,
we rely instead on write_cr3() performed by switch_mm() to provide core
serialization after changing the current mm, and deal with the special
case of kthread -> uthread (temporarily keeping current mm into
active_mm) by adding a sync_core() in that specific case.

Use the new sync_core_before_usermode() to guarantee this.

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
Cc: linux-arch@vger.kernel.org
Link: http://lkml.kernel.org/r/20180129202020.8515-10-mathieu.desnoyers@efficios.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Kconfig          | 1 +
 arch/x86/entry/entry_32.S | 5 +++++
 arch/x86/entry/entry_64.S | 4 ++++
 arch/x86/mm/tlb.c         | 7 ++++---
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 31030ad..e095bdb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -54,6 +54,7 @@ config X86
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV			if X86_64
+	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_REFCOUNT
 	select ARCH_HAS_UACCESS_FLUSHCACHE	if X86_64
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 2a35b1e..abee6d2 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -566,6 +566,11 @@ restore_all:
 .Lrestore_nocheck:
 	RESTORE_REGS 4				# skip orig_eax/error_code
 .Lirq_return:
+	/*
+	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
+	 * when returning from IPI handler and when returning from
+	 * scheduler to user-space.
+	 */
 	INTERRUPT_RETURN
 
 .section .fixup, "ax"
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index a835704..5816858 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -804,6 +804,10 @@ GLOBAL(restore_regs_and_return_to_kernel)
 	POP_EXTRA_REGS
 	POP_C_REGS
 	addq	$8, %rsp	/* skip regs->orig_ax */
+	/*
+	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
+	 * when returning from IPI handler.
+	 */
 	INTERRUPT_RETURN
 
 ENTRY(native_iret)
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 9fa7d2e..9b34121 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -229,9 +229,10 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	this_cpu_write(cpu_tlbstate.is_lazy, false);
 
 	/*
-	 * The membarrier system call requires a full memory barrier
-	 * before returning to user-space, after storing to rq->curr.
-	 * Writing to CR3 provides that full memory barrier.
+	 * The membarrier system call requires a full memory barrier and
+	 * core serialization before returning to user-space, after
+	 * storing to rq->curr. Writing to CR3 provides that full
+	 * memory barrier and core serializing instruction.
 	 */
 	if (real_prev == next) {
 		VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
