Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754493AbeBGUV3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 15:21:29 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:59496 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754422AbeBGUTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 15:19:43 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, x86@kernel.org
Cc: dan.j.williams@intel.com, tglx@linutronix.de, ak@linux.intel.com,
        torvalds@linux-foundation.org, luto@kernel.org
Subject: [RFC v2 PATCH 6/7] x86/entry: get rid of ALLOC_PT_GPREGS_ON_STACK and SAVE_AND_CLEAR_REGS
Date: Wed,  7 Feb 2018 21:15:16 +0100
Message-Id: <20180207201517.6518-7-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180207201517.6518-1-linux@dominikbrodowski.net>
References: <20180207201517.6518-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, error_entry() and paranoid_entry() saved the GP registers
onto stack space previously allocated by its callers. Combine these two
steps in the callers, and use the generic PUSH_AND_CLEAR_REGS macro
for that.

Note: The testb $3, CS(%rsp) instruction in idtentry() does not need
modification. Previously %rsp was manually decreased by 15*8; with
this patch, %rsp is decreased by 15 pushq instructions. Moreover,
error_entry did and does the exact same test (with offset=8) after
the registers have been moved/pushed and cleared.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/entry/calling.h  | 42 +-----------------------------------------
 arch/x86/entry/entry_64.S | 15 +++++++--------
 2 files changed, 8 insertions(+), 49 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index d6a97e2945ee..59675010c9a0 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -97,46 +97,6 @@ For 32-bit we have the following conventions - kernel is built with
 
 #define SIZEOF_PTREGS	21*8
 
-	.macro ALLOC_PT_GPREGS_ON_STACK
-	addq	$-(15*8), %rsp
-	.endm
-
-	.macro SAVE_AND_CLEAR_REGS offset=0
-	/*
-	 * Save registers and sanitize registers of values that a
-	 * speculation attack might otherwise want to exploit. The
-	 * lower registers are likely clobbered well before they
-	 * could be put to use in a speculative execution gadget.
-	 * Interleave XOR with PUSH for better uop scheduling:
-	 */
-	movq %rdi, 14*8+\offset(%rsp)
-	movq %rsi, 13*8+\offset(%rsp)
-	movq %rdx, 12*8+\offset(%rsp)
-	movq %rcx, 11*8+\offset(%rsp)
-	movq %rax, 10*8+\offset(%rsp)
-	movq %r8,  9*8+\offset(%rsp)
-	xorq %r8, %r8				/* nospec r8 */
-	movq %r9,  8*8+\offset(%rsp)
-	xorq %r9, %r9				/* nospec r9 */
-	movq %r10, 7*8+\offset(%rsp)
-	xorq %r10, %r10				/* nospec r10 */
-	movq %r11, 6*8+\offset(%rsp)
-	xorq %r11, %r11				/* nospec r11 */
-	movq %rbx, 5*8+\offset(%rsp)
-	xorl %ebx, %ebx				/* nospec rbx */
-	movq %rbp, 4*8+\offset(%rsp)
-	xorl %ebp, %ebp				/* nospec rbp */
-	movq %r12, 3*8+\offset(%rsp)
-	xorq %r12, %r12				/* nospec r12 */
-	movq %r13, 2*8+\offset(%rsp)
-	xorq %r13, %r13				/* nospec r13 */
-	movq %r14, 1*8+\offset(%rsp)
-	xorq %r14, %r14				/* nospec r14 */
-	movq %r15, 0*8+\offset(%rsp)
-	xorq %r15, %r15				/* nospec r15 */
-	UNWIND_HINT_REGS offset=\offset
-	.endm
-
 	.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax
 	/*
 	 * Push registers and sanitize registers of values that a
@@ -211,7 +171,7 @@ For 32-bit we have the following conventions - kernel is built with
  * is just setting the LSB, which makes it an invalid stack address and is also
  * a signal to the unwinder that it's a pt_regs pointer in disguise.
  *
- * NOTE: This macro must be used *after* SAVE_AND_CLEAR_REGS because it corrupts
+ * NOTE: This macro must be used *after* PUSH_AND_CLEAR_REGS because it corrupts
  * the original rbp.
  */
 .macro ENCODE_FRAME_POINTER ptregs_offset=0
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9c4fe360db42..fa56a974d1c1 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -871,7 +871,9 @@ ENTRY(\sym)
 	pushq	$-1				/* ORIG_RAX: no syscall to restart */
 	.endif
 
-	ALLOC_PT_GPREGS_ON_STACK
+	/* Save all registers in pt_regs */
+	PUSH_AND_CLEAR_REGS
+	ENCODE_FRAME_POINTER
 
 	.if \paranoid < 2
 	testb	$3, CS(%rsp)			/* If coming from userspace, switch stacks */
@@ -1121,15 +1123,13 @@ idtentry machine_check		do_mce			has_error_code=0	paranoid=1
 #endif
 
 /*
- * Save all registers in pt_regs, and switch gs if needed.
+ * Switch gs if needed.
  * Use slow, but surefire "are we in kernel?" check.
  * Return: ebx=0: need swapgs on exit, ebx=1: otherwise
  */
 ENTRY(paranoid_entry)
 	UNWIND_HINT_FUNC
 	cld
-	SAVE_AND_CLEAR_REGS 8
-	ENCODE_FRAME_POINTER 8
 	movl	$1, %ebx
 	movl	$MSR_GS_BASE, %ecx
 	rdmsr
@@ -1173,14 +1173,12 @@ ENTRY(paranoid_exit)
 END(paranoid_exit)
 
 /*
- * Save all registers in pt_regs, and switch gs if needed.
+ * Switch gs if needed.
  * Return: EBX=0: came from user mode; EBX=1: otherwise
  */
 ENTRY(error_entry)
 	UNWIND_HINT_FUNC
 	cld
-	SAVE_AND_CLEAR_REGS 8
-	ENCODE_FRAME_POINTER 8
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
@@ -1571,7 +1569,8 @@ end_repeat_nmi:
 	 * frame to point back to repeat_nmi.
 	 */
 	pushq	$-1				/* ORIG_RAX: no syscall to restart */
-	ALLOC_PT_GPREGS_ON_STACK
+	PUSH_AND_CLEAR_REGS
+	ENCODE_FRAME_POINTER
 
 	/*
 	 * Use paranoid_entry to handle SWAPGS, but no need to use paranoid_exit
-- 
2.16.1
