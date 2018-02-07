Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932107AbeBGUTs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 15:19:48 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:59478 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754421AbeBGUTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 15:19:43 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, x86@kernel.org
Cc: dan.j.williams@intel.com, tglx@linutronix.de, ak@linux.intel.com,
        torvalds@linux-foundation.org, luto@kernel.org
Subject: [RFC v2 PATCH 4/7] x86/entry: introduce PUSH_AND_CLEAN_REGS
Date: Wed,  7 Feb 2018 21:15:14 +0100
Message-Id: <20180207201517.6518-5-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180207201517.6518-1-linux@dominikbrodowski.net>
References: <20180207201517.6518-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those instances where ALLOC_PT_GPREGS_ON_STACK is called just before
SAVE_AND_CLEAR_REGS can trivially be replaced by PUSH_AND_CLEAN_REGS.
This macro uses PUSH instead of MOV and should therefore be faster, at
least on newer CPUs.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/entry/calling.h  | 36 ++++++++++++++++++++++++++++++++++++
 arch/x86/entry/entry_64.S |  6 ++----
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index a05cbb81268d..57b1b87a04f0 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -137,6 +137,42 @@ For 32-bit we have the following conventions - kernel is built with
 	UNWIND_HINT_REGS offset=\offset
 	.endm
 
+	.macro PUSH_AND_CLEAR_REGS
+	/*
+	 * Push registers and sanitize registers of values that a
+	 * speculation attack might otherwise want to exploit. The
+	 * lower registers are likely clobbered well before they
+	 * could be put to use in a speculative execution gadget.
+	 * Interleave XOR with PUSH for better uop scheduling:
+	 */
+	pushq   %rdi		/* pt_regs->di */
+	pushq   %rsi		/* pt_regs->si */
+	pushq   %rdx		/* pt_regs->dx */
+	pushq   %rcx		/* pt_regs->cx */
+	pushq   %rax		/* pt_regs->ax */
+	pushq   %r8		/* pt_regs->r8 */
+	xorq    %r8, %r8	/* nospec   r8 */
+	pushq   %r9		/* pt_regs->r9 */
+	xorq    %r9, %r9	/* nospec   r9 */
+	pushq   %r10		/* pt_regs->r10 */
+	xorq    %r10, %r10	/* nospec   r10 */
+	pushq   %r11		/* pt_regs->r11 */
+	xorq    %r11, %r11	/* nospec   r11*/
+	pushq	%rbx		/* pt_regs->rbx */
+	xorl    %ebx, %ebx	/* nospec   rbx*/
+	pushq	%rbp		/* pt_regs->rbp */
+	xorl    %ebp, %ebp	/* nospec   rbp*/
+	pushq	%r12		/* pt_regs->r12 */
+	xorq    %r12, %r12	/* nospec   r12*/
+	pushq	%r13		/* pt_regs->r13 */
+	xorq    %r13, %r13	/* nospec   r13*/
+	pushq	%r14		/* pt_regs->r14 */
+	xorq    %r14, %r14	/* nospec   r14*/
+	pushq	%r15		/* pt_regs->r15 */
+	xorq    %r15, %r15	/* nospec   r15*/
+	UNWIND_HINT_REGS
+	.endm
+
 	.macro POP_REGS pop_rdi=1 skip_r11rcx=0
 	popq %r15
 	popq %r14
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1194814ee12b..9dd3fbfdc75d 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -564,8 +564,7 @@ END(irq_entries_start)
 	call	switch_to_thread_stack
 1:
 
-	ALLOC_PT_GPREGS_ON_STACK
-	SAVE_AND_CLEAR_REGS
+	PUSH_AND_CLEAR_REGS
 	ENCODE_FRAME_POINTER
 
 	testb	$3, CS(%rsp)
@@ -1112,8 +1111,7 @@ ENTRY(xen_failsafe_callback)
 	addq	$0x30, %rsp
 	UNWIND_HINT_IRET_REGS
 	pushq	$-1 /* orig_ax = -1 => not a system call */
-	ALLOC_PT_GPREGS_ON_STACK
-	SAVE_AND_CLEAR_REGS
+	PUSH_AND_CLEAR_REGS
 	ENCODE_FRAME_POINTER
 	jmp	error_exit
 END(xen_failsafe_callback)
-- 
2.16.1
