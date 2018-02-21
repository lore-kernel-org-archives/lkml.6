Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938808AbeBURAV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:00:21 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41591 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933341AbeBURAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:00:18 -0500
Date: Wed, 21 Feb 2018 08:59:41 -0800
From: tip-bot for Dominik Brodowski <tipbot@zytor.com>
Message-ID: <tip-90a6acc4e7ebafa8672a7a1a5b23fbad3dd04130@git.kernel.org>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org, dwmw2@infradead.org,
        brgerst@gmail.com, tglx@linutronix.de, luto@kernel.org,
        jpoimboe@redhat.com, linux@dominikbrodowski.net, peterz@infradead.org,
        dvlasenk@redhat.com, bp@alien8.de
Reply-To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        hpa@zytor.com, tglx@linutronix.de, brgerst@gmail.com, mingo@kernel.org,
        dwmw2@infradead.org, linux@dominikbrodowski.net, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, peterz@infradead.org,
        dvlasenk@redhat.com
In-Reply-To: <20180220210113.6725-4-linux@dominikbrodowski.net>
References: <20180220210113.6725-4-linux@dominikbrodowski.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/64: Move the switch_to_thread_stack() call
 to interrupt_entry()
Git-Commit-ID: 90a6acc4e7ebafa8672a7a1a5b23fbad3dd04130
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

Commit-ID:  90a6acc4e7ebafa8672a7a1a5b23fbad3dd04130
Gitweb:     https://git.kernel.org/tip/90a6acc4e7ebafa8672a7a1a5b23fbad3dd04130
Author:     Dominik Brodowski <linux@dominikbrodowski.net>
AuthorDate: Tue, 20 Feb 2018 22:01:10 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 16:54:04 +0100

x86/entry/64: Move the switch_to_thread_stack() call to interrupt_entry()

We can also move the CLD, SWAPGS, and the switch_to_thread_stack() call
to the interrupt_entry() helper function. As we do not want call depths
of two, convert switch_to_thread_stack() to a macro.

However, switch_to_thread_stack() has another user in entry_64_compat.S,
which currently expects it to be a function. To keep the code changes
in this patch minimal, create a wrapper function.

The switch to a macro means that there is some binary code duplication
if CONFIG_IA32_EMULATION=y is enabled. Therefore, the size reduction
differs whether CONFIG_IA32_EMULATION is enabled or not:

CONFIG_IA32_EMULATION=y (-0.13k):
   text	   data	    bss	    dec	    hex	filename
  17158	      0	      0	  17158	   4306	entry_64.o-orig
  17028	      0	      0	  17028	   4284	entry_64.o

CONFIG_IA32_EMULATION=n (-0.27k):
   text	   data	    bss	    dec	    hex	filename
  17158	      0	      0	  17158	   4306	entry_64.o-orig
  16882	      0	      0	  16882	   41f2	entry_64.o

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: dan.j.williams@intel.com
Link: http://lkml.kernel.org/r/20180220210113.6725-4-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/entry_64.S | 66 ++++++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 7a6ae19..b45d766 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -538,14 +538,47 @@ END(irq_entries_start)
 .endm
 
 /*
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
+/*
  * Interrupt entry/exit.
  *
  * Interrupt entry points save only callee clobbered registers in fast path.
  *
  * Entry runs with interrupts off.
  */
+/* 8(%rsp): ~(interrupt number) */
 ENTRY(interrupt_entry)
 	UNWIND_HINT_FUNC
+	cld
+
+	testb	$3, CS-ORIG_RAX+8(%rsp)
+	jz	1f
+	SWAPGS
+	DO_SWITCH_TO_THREAD_STACK
+1:
 
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
@@ -577,14 +610,6 @@ END(interrupt_entry)
 
 /* 0(%rsp): ~(interrupt number) */
 	.macro interrupt func
-	cld
-
-	testb	$3, CS-ORIG_RAX(%rsp)
-	jz	1f
-	SWAPGS
-	call	switch_to_thread_stack
-1:
-
 	call	interrupt_entry
 
 	UNWIND_HINT_REGS indirect=1
@@ -858,33 +883,16 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
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
+	DO_SWITCH_TO_THREAD_STACK
 
-	movq	(%rdi), %rdi
 	ret
 END(switch_to_thread_stack)
+#endif
 
 .macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1
 ENTRY(\sym)
