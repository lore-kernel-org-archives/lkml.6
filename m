Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754075AbeBFVdJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 16:33:09 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:34896 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752852AbeBFVdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 16:33:06 -0500
Date: Tue, 6 Feb 2018 22:32:02 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Ingo Molnar <mingo@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, tglx@linutronix.de,
        Andi Kleen <ak@linux.intel.com>, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, x86@kernel.org
Subject: [PATCH tip-pti 2/2] x86/entry: interleave XOR register clearing with
 PUSH/MOV instructions
Message-ID: <20180206213202.GB2026@light.dominikbrodowski.net>
References: <151787988045.7847.11830748914544718151.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151787989146.7847.15749181712358213254.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180206091727.GB15925@isilmar-4.linta.de>
 <20180206105139.nwlg3fwdxyhhrtc4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206105139.nwlg3fwdxyhhrtc4@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same as is done for syscalls, interleave XOR with PUSH or MOV
instructions for exceptions/interrupts, in order to minimize
the cost of the additional instructions required for register
clearing.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 75a237c95ff7..89a906c868d8 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -102,10 +102,21 @@ For 32-bit we have the following conventions - kernel is built with
 	.endm
 
 	.macro SAVE_C_REGS offset=0
+	/*
+	 * Save registers and sanitize registers of values that a
+	 * speculation attack might otherwise want to exploit. The
+	 * lower registers are likely clobbered well before they
+	 * could be put to use in a speculative execution gadget.
+	 * Interleave XOR with MOV for better uop scheduling:
+	 */
 	movq %r11, 6*8+\offset(%rsp)
+	xorq %r11, %r11				/* nospec r11 */
 	movq %r10, 7*8+\offset(%rsp)
+	xorq %r10, %r10				/* nospec r10 */
 	movq %r9,  8*8+\offset(%rsp)
+	xorq %r9, %r9				/* nospec r9 */
 	movq %r8,  9*8+\offset(%rsp)
+	xorq %r8, %r8				/* nospec r8 */
 	movq %rax, 10*8+\offset(%rsp)
 	movq %rcx, 11*8+\offset(%rsp)
 	movq %rdx, 12*8+\offset(%rsp)
@@ -115,34 +126,28 @@ For 32-bit we have the following conventions - kernel is built with
 	.endm
 
 	.macro SAVE_EXTRA_REGS offset=0
+	/*
+	 * Save registers and sanitize registers of values that a
+	 * speculation attack might otherwise want to exploit. The
+	 * lower registers are likely clobbered well before they
+	 * could be put to use in a speculative execution gadget.
+	 * Interleave XOR with MOV for better uop scheduling:
+	 */
 	movq %r15, 0*8+\offset(%rsp)
+	xorq %r15, %r15				/* nospec r15 */
 	movq %r14, 1*8+\offset(%rsp)
+	xorq %r14, %r14				/* nospec r14 */
 	movq %r13, 2*8+\offset(%rsp)
+	xorq %r13, %r13				/* nospec r13 */
 	movq %r12, 3*8+\offset(%rsp)
+	xorq %r12, %r12				/* nospec r12 */
 	movq %rbp, 4*8+\offset(%rsp)
+	xorl %ebp, %ebp				/* nospec rbp */
 	movq %rbx, 5*8+\offset(%rsp)
+	xorl %ebx, %ebx				/* nospec rbx */
 	UNWIND_HINT_REGS offset=\offset
 	.endm
 
-	/*
-	 * Sanitize registers of values that a speculation attack
-	 * might otherwise want to exploit. The lower registers are
-	 * likely clobbered well before they could be put to use in
-	 * a speculative execution gadget:
-	 */
-	.macro CLEAR_REGS_NOSPEC
-	xorl %ebp, %ebp
-	xorl %ebx, %ebx
-	xorq %r8, %r8
-	xorq %r9, %r9
-	xorq %r10, %r10
-	xorq %r11, %r11
-	xorq %r12, %r12
-	xorq %r13, %r13
-	xorq %r14, %r14
-	xorq %r15, %r15
-	.endm
-
 	.macro POP_EXTRA_REGS
 	popq %r15
 	popq %r14
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9e48002b953b..903d9088bdb3 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -575,7 +575,6 @@ END(irq_entries_start)
 	ALLOC_PT_GPREGS_ON_STACK
 	SAVE_C_REGS
 	SAVE_EXTRA_REGS
-	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER
 
 	testb	$3, CS(%rsp)
@@ -1134,7 +1133,6 @@ ENTRY(xen_failsafe_callback)
 	ALLOC_PT_GPREGS_ON_STACK
 	SAVE_C_REGS
 	SAVE_EXTRA_REGS
-	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER
 	jmp	error_exit
 END(xen_failsafe_callback)
@@ -1180,7 +1178,6 @@ ENTRY(paranoid_entry)
 	cld
 	SAVE_C_REGS 8
 	SAVE_EXTRA_REGS 8
-	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER 8
 	movl	$1, %ebx
 	movl	$MSR_GS_BASE, %ecx
@@ -1233,7 +1230,6 @@ ENTRY(error_entry)
 	cld
 	SAVE_C_REGS 8
 	SAVE_EXTRA_REGS 8
-	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER 8
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
@@ -1420,18 +1416,34 @@ ENTRY(nmi)
 	pushq   (%rdx)		/* pt_regs->dx */
 	pushq   %rcx		/* pt_regs->cx */
 	pushq   %rax		/* pt_regs->ax */
+	/*
+	 * Sanitize registers of values that a speculation attack
+	 * might otherwise want to exploit. The lower registers are
+	 * likely clobbered well before they could be put to use in
+	 * a speculative execution gadget. Interleave XOR with PUSH
+	 * for better uop scheduling:
+	 */
 	pushq   %r8		/* pt_regs->r8 */
+	xorq    %r8, %r8	/* nospec   r8 */
 	pushq   %r9		/* pt_regs->r9 */
+	xorq    %r9, %r9	/* nospec   r9 */
 	pushq   %r10		/* pt_regs->r10 */
+	xorq    %r10, %r10	/* nospec   r10 */
 	pushq   %r11		/* pt_regs->r11 */
+	xorq    %r11, %r11	/* nospec   r11*/
 	pushq	%rbx		/* pt_regs->rbx */
+	xorl    %ebx, %ebx	/* nospec   rbx*/
 	pushq	%rbp		/* pt_regs->rbp */
+	xorl    %ebp, %ebp	/* nospec   rbp*/
 	pushq	%r12		/* pt_regs->r12 */
+	xorq    %r12, %r12	/* nospec   r12*/
 	pushq	%r13		/* pt_regs->r13 */
+	xorq    %r13, %r13	/* nospec   r13*/
 	pushq	%r14		/* pt_regs->r14 */
+	xorq    %r14, %r14	/* nospec   r14*/
 	pushq	%r15		/* pt_regs->r15 */
+	xorq    %r15, %r15	/* nospec   r15*/
 	UNWIND_HINT_REGS
-	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER
 
 	/*
