Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161891AbeBNSWh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:22:37 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:48090 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161764AbeBNSWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:22:34 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, x86@kernel.org
Cc: torvalds@linux-foundation.org, luto@kernel.org, ak@linux.intel.com,
        tglx@linutronix.de, dan.j.williams@intel.com
Subject: [RFC PATCH 3/4] x86/entry/64: move switch_to_thread_stack to interrupt helper function
Date: Wed, 14 Feb 2018 19:21:12 +0100
Message-Id: <20180214182113.27247-4-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180214182113.27247-1-linux@dominikbrodowski.net>
References: <20180214182113.27247-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can also move the SWAPGS and the switch_to_thread_stack to the
interrupt helper function. As we do not want call depths of two,
convert switch_to_thread_stack to a macro. However, as entry_64_compat.S
expects switch_to_thread_stack to be a function, provide a wrapper for
that, which leads to some code duplication if CONFIG_IA32_EMULATION is
enabled. Therefore, the size reduction differs slightly:

With CONFIG_IA32_EMULATION enabled (-0.13k):
   text	   data	    bss	    dec	    hex	filename
  16897	      0	      0	  16897	   4201	entry_64.o-orig
  16767	      0	      0	  16767	   417f	entry_64.o

With CONFIG_IA32_EMULATION disabled (-0.27k):
   text	   data	    bss	    dec	    hex	filename
  16897	      0	      0	  16897	   4201	entry_64.o-orig
  16622	      0	      0	  16622	   40ee	entry_64.o

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/entry/entry_64.S | 65 ++++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 29 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 3046b12a1acb..b60a3b692ca9 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -536,6 +536,31 @@ END(irq_entries_start)
 	decl	PER_CPU_VAR(irq_count)
 .endm
 
+/*
+ * Switch to the thread stack.  This is called with the IRET frame and
+ * orig_ax on the stack.  (That is, RDI..R12 are not on the stack and
+ * space has not been allocated for them.)
+ */
+.macro DO_SWITCH_TO_THREAD_STACK
+	pushq	%rdi
+	/* Need to switch before accessing the thread stack. */
+	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi
+	movq	%rsp, %rdi
+	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
+	UNWIND_HINT sp_offset=16 sp_reg=ORC_REG_DI
+
+	pushq	7*8(%rdi)		/* regs->ss */
+	pushq	6*8(%rdi)		/* regs->rsp */
+	pushq	5*8(%rdi)		/* regs->eflags */
+	pushq	4*8(%rdi)		/* regs->cs */
+	pushq	3*8(%rdi)		/* regs->ip */
+	pushq	2*8(%rdi)		/* regs->orig_ax */
+	pushq	8(%rdi)			/* return address */
+	UNWIND_HINT_FUNC
+
+	movq	(%rdi), %rdi
+.endm
+
 /*
  * Interrupt entry/exit.
  *
@@ -543,10 +568,17 @@ END(irq_entries_start)
  *
  * Entry runs with interrupts off.
  */
+/* 8(%rsp): ~(interrupt number) */
 ENTRY(interrupt_helper)
 	UNWIND_HINT_FUNC
 	cld
 
+	testb	$3, CS-ORIG_RAX+8(%rsp)
+	jz	1f
+	SWAPGS
+	DO_SWITCH_TO_THREAD_STACK
+1:
+
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
 
@@ -579,12 +611,6 @@ END(interrupt_helper)
 	.macro interrupt func
 	cld
 
-	testb	$3, CS-ORIG_RAX(%rsp)
-	jz	1f
-	SWAPGS
-	call	switch_to_thread_stack
-1:
-
 	call	interrupt_helper
 
 	call	\func	/* rdi points to pt_regs */
@@ -853,33 +879,14 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
  */
 #define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + ((x) - 1) * 8)
 
-/*
- * Switch to the thread stack.  This is called with the IRET frame and
- * orig_ax on the stack.  (That is, RDI..R12 are not on the stack and
- * space has not been allocated for them.)
- */
+#if defined(CONFIG_IA32_EMULATION)
+/* entry_64_compat.S::entry_INT80_compat expects this to be an ASM function */
 ENTRY(switch_to_thread_stack)
 	UNWIND_HINT_FUNC
-
-	pushq	%rdi
-	/* Need to switch before accessing the thread stack. */
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi
-	movq	%rsp, %rdi
-	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
-	UNWIND_HINT sp_offset=16 sp_reg=ORC_REG_DI
-
-	pushq	7*8(%rdi)		/* regs->ss */
-	pushq	6*8(%rdi)		/* regs->rsp */
-	pushq	5*8(%rdi)		/* regs->eflags */
-	pushq	4*8(%rdi)		/* regs->cs */
-	pushq	3*8(%rdi)		/* regs->ip */
-	pushq	2*8(%rdi)		/* regs->orig_ax */
-	pushq	8(%rdi)			/* return address */
-	UNWIND_HINT_FUNC
-
-	movq	(%rdi), %rdi
+	DO_SWITCH_TO_THREAD_STACK
 	ret
 END(switch_to_thread_stack)
+#endif
 
 .macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1
 ENTRY(\sym)
-- 
2.16.1
