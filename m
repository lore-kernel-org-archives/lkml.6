Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753658AbeBUKqs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:46:48 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56043 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932789AbeBUKqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:46:46 -0500
Date: Wed, 21 Feb 2018 02:46:08 -0800
From: tip-bot for Dominik Brodowski <tipbot@zytor.com>
Message-ID: <tip-484689299ece526dd75088946c2307c3a74d9d67@git.kernel.org>
Cc: dwmw2@infradead.org, tglx@linutronix.de, hpa@zytor.com,
        torvalds@linux-foundation.org, brgerst@gmail.com, bp@alien8.de,
        dvlasenk@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, linux@dominikbrodowski.net, luto@kernel.org,
        jpoimboe@redhat.com
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de,
        dvlasenk@redhat.com, luto@kernel.org, jpoimboe@redhat.com,
        linux@dominikbrodowski.net, peterz@infradead.org, tglx@linutronix.de,
        dwmw2@infradead.org, brgerst@gmail.com, torvalds@linux-foundation.org,
        hpa@zytor.com
In-Reply-To: <20180220210113.6725-3-linux@dominikbrodowski.net>
References: <20180220210113.6725-3-linux@dominikbrodowski.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/64: Move ENTER_IRQ_STACK from interrupt
 macro to interrupt_entry
Git-Commit-ID: 484689299ece526dd75088946c2307c3a74d9d67
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

Commit-ID:  484689299ece526dd75088946c2307c3a74d9d67
Gitweb:     https://git.kernel.org/tip/484689299ece526dd75088946c2307c3a74d9d67
Author:     Dominik Brodowski <linux@dominikbrodowski.net>
AuthorDate: Tue, 20 Feb 2018 22:01:09 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 10:04:46 +0100

x86/entry/64: Move ENTER_IRQ_STACK from interrupt macro to interrupt_entry

Moving the switch to IRQ stack from the interrupt macro to the helper
function requires some trickery: All ENTER_IRQ_STACK really cares about
is where the "original" stack -- meaning the GP registers etc. -- is
stored. Therefore, we need to offset the stored RSP value by 8 whenever
ENTER_IRQ_STACK is called from within a function. In such cases, and
after switching to the IRQ stack, we need to push the "original" return
address (i.e. the return address from the call to the interrupt entry
function) to the IRQ stack.

This trickery allows us to carve another .85k from the text size (it
would be more except for the additional unwind hints):

   text	   data	    bss	    dec	    hex	filename
  18006	      0	      0	  18006	   4656	entry_64.o-orig
  17158	      0	      0	  17158	   4306	entry_64.o

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
Link: http://lkml.kernel.org/r/20180220210113.6725-3-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/entry_64.S | 56 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index b0ae0c3..7a6ae19 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -448,9 +448,19 @@ END(irq_entries_start)
  *
  * The invariant is that, if irq_count != -1, then the IRQ stack is in use.
  */
-.macro ENTER_IRQ_STACK regs=1 old_rsp
+.macro ENTER_IRQ_STACK regs=1 old_rsp save_ret=0
 	DEBUG_ENTRY_ASSERT_IRQS_OFF
+
+	.if \save_ret
+	/*
+	 * If save_ret is set, the original stack contains one additional
+	 * entry -- the return address. Therefore, move the address one
+	 * entry below %rsp to \old_rsp.
+	 */
+	leaq	8(%rsp), \old_rsp
+	.else
 	movq	%rsp, \old_rsp
+	.endif
 
 	.if \regs
 	UNWIND_HINT_REGS base=\old_rsp
@@ -496,6 +506,15 @@ END(irq_entries_start)
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
@@ -531,22 +550,7 @@ ENTRY(interrupt_entry)
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
 
-	ret
-END(interrupt_entry)
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
-	call	interrupt_entry
-
-	testb	$3, CS(%rsp)
+	testb	$3, CS+8(%rsp)
 	jz	1f
 
 	/*
@@ -564,10 +568,26 @@ END(interrupt_entry)
 	CALL_enter_from_user_mode
 
 1:
-	ENTER_IRQ_STACK old_rsp=%rdi
+	ENTER_IRQ_STACK old_rsp=%rdi save_ret=1
 	/* We entered an interrupt context - irqs are off: */
 	TRACE_IRQS_OFF
 
+	ret
+END(interrupt_entry)
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
+	call	interrupt_entry
+
+	UNWIND_HINT_REGS indirect=1
 	call	\func	/* rdi points to pt_regs */
 	.endm
 
