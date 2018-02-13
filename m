Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934055AbeBMJIv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:08:51 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35107 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933824AbeBMJIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:08:46 -0500
Date: Tue, 13 Feb 2018 01:01:55 -0800
From: tip-bot for Dominik Brodowski <tipbot@zytor.com>
Message-ID: <tip-3f01daecd545e818098d84fd1ad43e19a508d705@git.kernel.org>
Cc: peterz@infradead.org, torvalds@linux-foundation.org,
        jpoimboe@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux@dominikbrodowski.net, bp@alien8.de, brgerst@gmail.com,
        dvlasenk@redhat.com, mingo@kernel.org, luto@kernel.org, hpa@zytor.com
Reply-To: dvlasenk@redhat.com, brgerst@gmail.com, bp@alien8.de, hpa@zytor.com,
        luto@kernel.org, mingo@kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, torvalds@linux-foundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
In-Reply-To: <20180211104949.12992-5-linux@dominikbrodowski.net>
References: <20180211104949.12992-5-linux@dominikbrodowski.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/64: Introduce the PUSH_AND_CLEAN_REGS macro
Git-Commit-ID: 3f01daecd545e818098d84fd1ad43e19a508d705
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

Commit-ID:  3f01daecd545e818098d84fd1ad43e19a508d705
Gitweb:     https://git.kernel.org/tip/3f01daecd545e818098d84fd1ad43e19a508d705
Author:     Dominik Brodowski <linux@dominikbrodowski.net>
AuthorDate: Sun, 11 Feb 2018 11:49:45 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 09:04:53 +0100

x86/entry/64: Introduce the PUSH_AND_CLEAN_REGS macro

Those instances where ALLOC_PT_GPREGS_ON_STACK is called just before
SAVE_AND_CLEAR_REGS can trivially be replaced by PUSH_AND_CLEAN_REGS.
This macro uses PUSH instead of MOV and should therefore be faster, at
least on newer CPUs.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dan.j.williams@intel.com
Link: http://lkml.kernel.org/r/20180211104949.12992-5-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/calling.h  | 36 ++++++++++++++++++++++++++++++++++++
 arch/x86/entry/entry_64.S |  6 ++----
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index a05cbb8..57b1b87 100644
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
index 07692b4..cf4a9ae 100644
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
