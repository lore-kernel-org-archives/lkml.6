Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbeBTVB2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 16:01:28 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:46872 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751460AbeBTVB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 16:01:26 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, x86@kernel.org,
        brgerst@gmail.com, luto@kernel.org, jpoimboe@redhat.com
Cc: torvalds@linux-foundation.org, ak@linux.intel.com, tglx@linutronix.de,
        dan.j.williams@intel.com
Subject: [RFC PATCH v3 6/6] x86/entry/64: open-code switch_to_thread_stack
Date: Tue, 20 Feb 2018 22:01:13 +0100
Message-Id: <20180220210113.6725-7-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180220210113.6725-1-linux@dominikbrodowski.net>
References: <20180220210113.6725-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Open-code the two instances which used switch_to_thread_stack. This
allows us to remove the wrapper around DO_SWITCH_TO_THREAD_STACK.

While at it, update the UNWIND hint to reflect where the IRET frame is,
and update the commentary to reflect what we are actually doing here.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/entry/entry_64.S        | 76 +++++++++++++++++++++-------------------
 arch/x86/entry/entry_64_compat.S | 17 +++++++--
 2 files changed, 55 insertions(+), 38 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 42a4b652469d..d5c7f18f79ac 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -538,17 +538,48 @@ END(irq_entries_start)
 .endm
 
 /*
- * Switch to the thread stack.  This is called with the IRET frame and
- * orig_ax on the stack.  (That is, RDI..R12 are not on the stack and
- * space has not been allocated for them.)
+ * Interrupt entry helper function.
+ *
+ * Entry runs with interrupts off. Stack layout at entry:
+ * +----------------------------------------------------+
+ * | regs->ss						|
+ * | regs->rsp						|
+ * | regs->eflags					|
+ * | regs->cs						|
+ * | regs->ip						|
+ * +----------------------------------------------------+
+ * | regs->orig_ax = ~(interrupt number)		|
+ * +----------------------------------------------------+
+ * | return address					|
+ * +----------------------------------------------------+
  */
-.macro DO_SWITCH_TO_THREAD_STACK
+ENTRY(interrupt_entry)
+	UNWIND_HINT_FUNC
+	ASM_CLAC
+	cld
+
+	testb	$3, CS-ORIG_RAX+8(%rsp)
+	jz	1f
+	SWAPGS
+
+	/*
+	 * Switch to the thread stack. The IRET frame and orig_ax are
+	 * on the stack, as well as the return address. RDI..R12 are
+	 * not (yet) on the stack and space has not (yet) been
+	 * allocated for them.
+	 */
 	pushq	%rdi
+
 	/* Need to switch before accessing the thread stack. */
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi
 	movq	%rsp, %rdi
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
-	UNWIND_HINT sp_offset=16 sp_reg=ORC_REG_DI
+
+	 /*
+	  * We have RDI, return address, and orig_ax on the stack on
+	  * top of the IRET frame. That means offset=24
+	  */
+	UNWIND_HINT_IRET_REGS base=%rdi offset=24
 
 	pushq	7*8(%rdi)		/* regs->ss */
 	pushq	6*8(%rdi)		/* regs->rsp */
@@ -560,25 +591,6 @@ END(irq_entries_start)
 	UNWIND_HINT_FUNC
 
 	movq	(%rdi), %rdi
-.endm
-
-/*
- * Interrupt entry/exit.
- *
- * Interrupt entry points save only callee clobbered registers in fast path.
- *
- * Entry runs with interrupts off.
- */
-/* 8(%rsp): ~(interrupt number) */
-ENTRY(interrupt_entry)
-	UNWIND_HINT_FUNC
-	ASM_CLAC
-	cld
-
-	testb	$3, CS-ORIG_RAX+8(%rsp)
-	jz	1f
-	SWAPGS
-	DO_SWITCH_TO_THREAD_STACK
 1:
 
 	PUSH_AND_CLEAR_REGS save_ret=1
@@ -592,7 +604,7 @@ ENTRY(interrupt_entry)
 	 *
 	 * We need to tell lockdep that IRQs are off.  We can't do this until
 	 * we fix gsbase, and we should do it before enter_from_user_mode
-	 * (which can take locks).  Since TRACE_IRQS_OFF idempotent,
+	 * (which can take locks).  Since TRACE_IRQS_OFF is idempotent,
 	 * the simplest way to handle it is to just call it twice if
 	 * we enter from user mode.  There's no reason to optimize this since
 	 * TRACE_IRQS_OFF is a no-op if lockdep is off.
@@ -609,6 +621,9 @@ ENTRY(interrupt_entry)
 	ret
 END(interrupt_entry)
 
+
+/* Interrupt entry/exit. */
+
 	/*
 	 * The interrupt stubs push (~vector+0x80) onto the stack and
 	 * then jump to common_interrupt.
@@ -878,17 +893,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
  */
 #define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + ((x) - 1) * 8)
 
-#if defined(CONFIG_IA32_EMULATION)
-/* entry_64_compat.S::entry_INT80_compat expects this to be an ASM function */
-ENTRY(switch_to_thread_stack)
-	UNWIND_HINT_FUNC
-
-	DO_SWITCH_TO_THREAD_STACK
-
-	ret
-END(switch_to_thread_stack)
-#endif
-
 .macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1
 ENTRY(\sym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 364ea4a207be..e811dd9c5e99 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -347,10 +347,23 @@ ENTRY(entry_INT80_compat)
 	 */
 	movl	%eax, %eax
 
+	/* switch to thread stack expects orig_ax and rdi to be pushed */
 	pushq	%rax			/* pt_regs->orig_ax */
+	pushq	%rdi			/* pt_regs->di */
+
+	/* Need to switch before accessing the thread stack. */
+	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi
+	movq	%rsp, %rdi
+	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
+
+	pushq	6*8(%rdi)		/* regs->ss */
+	pushq	5*8(%rdi)		/* regs->rsp */
+	pushq	4*8(%rdi)		/* regs->eflags */
+	pushq	3*8(%rdi)		/* regs->cs */
+	pushq	2*8(%rdi)		/* regs->ip */
+	pushq	1*8(%rdi)		/* regs->orig_ax */
 
-	/* switch to thread stack expects orig_ax to be pushed */
-	call	switch_to_thread_stack
+	movq	(%rdi), %rdi		/* restore %rdi */
 
 	pushq	%rdi			/* pt_regs->di */
 	pushq	%rsi			/* pt_regs->si */
-- 
2.16.2
