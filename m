Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161945AbeBNSYB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:24:01 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:48116 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161834AbeBNSWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:22:34 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, x86@kernel.org
Cc: torvalds@linux-foundation.org, luto@kernel.org, ak@linux.intel.com,
        tglx@linutronix.de, dan.j.williams@intel.com
Subject: [RFC PATCH 2/4] x86/entry/64: move ENTER_IRQ_STACK from interrupt macro to helper function
Date: Wed, 14 Feb 2018 19:21:11 +0100
Message-Id: <20180214182113.27247-3-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180214182113.27247-1-linux@dominikbrodowski.net>
References: <20180214182113.27247-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving the switch to IRQ stack from the interrupt macro to the helper
function requires some trickery: All ENTER_IRQ_STACK really cares about
is where the "original" stack -- meaning the GP registers etc. -- is
stored. Therefore, we need to offset the stored RSP value by 8 whenever
ENTER_IRQ_STACK is called from within a function. In such cases, and
after switching to the IRQ stack, we need to push the "original" return
address (i.e. the return address from the call to the interrupt entry
function) to the IRQ stack.

This trickery allows us to carve another 1k from the text size:

   text	   data	    bss	    dec	    hex	filename
  17905	      0	      0	  17905	   45f1	entry_64.o-orig
  16897	      0	      0	  16897	   4201	entry_64.o

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/entry/entry_64.S | 53 +++++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index de8a0da0d347..3046b12a1acb 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -449,10 +449,18 @@ END(irq_entries_start)
  *
  * The invariant is that, if irq_count != -1, then the IRQ stack is in use.
  */
-.macro ENTER_IRQ_STACK regs=1 old_rsp
+.macro ENTER_IRQ_STACK regs=1 old_rsp save_ret=0
 	DEBUG_ENTRY_ASSERT_IRQS_OFF
 	movq	%rsp, \old_rsp
 
+	.if \save_ret
+	/*
+	 * If save_ret is set, the original stack contains one additional
+	 * entry -- the return address.
+	 */
+	addq	$8, \old_rsp
+	.endif
+
 	.if \regs
 	UNWIND_HINT_REGS base=\old_rsp
 	.endif
@@ -497,6 +505,15 @@ END(irq_entries_start)
 	.if \regs
 	UNWIND_HINT_REGS indirect=1
 	.endif
+
+	.if \save_ret
+	/*
+	 * Push the return address to the stack. This return address can
+	 * be found at the "real" original RSP, which was offset by 8 at
+	 * the beginning of this macro.
+	 */
+	pushq	-8(\old_rsp)
+	.endif
 .endm
 
 /*
@@ -533,22 +550,7 @@ ENTRY(interrupt_helper)
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
 
-	ret
-END(interrupt_helper)
-
-/* 0(%rsp): ~(interrupt number) */
-	.macro interrupt func
-	cld
-
-	testb	$3, CS-ORIG_RAX(%rsp)
-	jz	1f
-	SWAPGS
-	call	switch_to_thread_stack
-1:
-
-	call	interrupt_helper
-
-	testb	$3, CS(%rsp)
+	testb	$3, CS+8(%rsp)
 	jz	1f
 
 	/*
@@ -566,10 +568,25 @@ END(interrupt_helper)
 	CALL_enter_from_user_mode
 
 1:
-	ENTER_IRQ_STACK old_rsp=%rdi
+	ENTER_IRQ_STACK old_rsp=%rdi save_ret=1
 	/* We entered an interrupt context - irqs are off: */
 	TRACE_IRQS_OFF
 
+	ret
+END(interrupt_helper)
+
+/* 0(%rsp): ~(interrupt number) */
+	.macro interrupt func
+	cld
+
+	testb	$3, CS-ORIG_RAX(%rsp)
+	jz	1f
+	SWAPGS
+	call	switch_to_thread_stack
+1:
+
+	call	interrupt_helper
+
 	call	\func	/* rdi points to pt_regs */
 	.endm
 
-- 
2.16.1
