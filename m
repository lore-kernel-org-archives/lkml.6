Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933350AbeBLKRW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 05:17:22 -0500
Received: from [198.137.202.136] ([198.137.202.136]:43921 "EHLO
        terminus.zytor.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S932663AbeBLKRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 05:17:20 -0500
Date: Mon, 12 Feb 2018 02:16:25 -0800
From: tip-bot for Dominik Brodowski <tipbot@zytor.com>
Message-ID: <tip-a1490086a98e51e3358be8eaf2bc5743c73c6b6e@git.kernel.org>
Cc: linux@dominikbrodowski.net, luto@kernel.org,
        torvalds@linux-foundation.org, brgerst@gmail.com, tglx@linutronix.de,
        mingo@kernel.org, dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, jpoimboe@redhat.com, hpa@zytor.com, bp@alien8.de
Reply-To: luto@kernel.org, torvalds@linux-foundation.org, brgerst@gmail.com,
        tglx@linutronix.de, linux@dominikbrodowski.net, bp@alien8.de,
        hpa@zytor.com, dvlasenk@redhat.com, jpoimboe@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <20180211104949.12992-3-linux@dominikbrodowski.net>
References: <20180211104949.12992-3-linux@dominikbrodowski.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/64: Merge the POP_C_REGS and POP_EXTRA_REGS
 macros into a single POP_REGS macro
Git-Commit-ID: a1490086a98e51e3358be8eaf2bc5743c73c6b6e
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

Commit-ID:  a1490086a98e51e3358be8eaf2bc5743c73c6b6e
Gitweb:     https://git.kernel.org/tip/a1490086a98e51e3358be8eaf2bc5743c73c6b6e
Author:     Dominik Brodowski <linux@dominikbrodowski.net>
AuthorDate: Sun, 11 Feb 2018 11:49:43 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Feb 2018 08:06:35 +0100

x86/entry/64: Merge the POP_C_REGS and POP_EXTRA_REGS macros into a single POP_REGS macro

The two special, opencoded cases for POP_C_REGS can be handled by ASM
macros.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dan.j.williams@intel.com
Link: http://lkml.kernel.org/r/20180211104949.12992-3-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/calling.h  | 15 +++++++++++----
 arch/x86/entry/entry_64.S | 26 ++++----------------------
 2 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 8907a65..3bda317 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -139,25 +139,32 @@ For 32-bit we have the following conventions - kernel is built with
 	xorq %r15, %r15
 	.endm
 
-	.macro POP_EXTRA_REGS
+	.macro POP_REGS pop_rdi=1 skip_r11rcx=0
 	popq %r15
 	popq %r14
 	popq %r13
 	popq %r12
 	popq %rbp
 	popq %rbx
-	.endm
-
-	.macro POP_C_REGS
+	.if \skip_r11rcx
+	popq %rsi
+	.else
 	popq %r11
+	.endif
 	popq %r10
 	popq %r9
 	popq %r8
 	popq %rax
+	.if \skip_r11rcx
+	popq %rsi
+	.else
 	popq %rcx
+	.endif
 	popq %rdx
 	popq %rsi
+	.if \pop_rdi
 	popq %rdi
+	.endif
 	.endm
 
 	.macro icebp
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1a6fc01..7351c91 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -334,15 +334,7 @@ GLOBAL(entry_SYSCALL_64_after_hwframe)
 syscall_return_via_sysret:
 	/* rcx and r11 are already restored (see code above) */
 	UNWIND_HINT_EMPTY
-	POP_EXTRA_REGS
-	popq	%rsi	/* skip r11 */
-	popq	%r10
-	popq	%r9
-	popq	%r8
-	popq	%rax
-	popq	%rsi	/* skip rcx */
-	popq	%rdx
-	popq	%rsi
+	POP_REGS pop_rdi=0 skip_r11rcx=1
 
 	/*
 	 * Now all regs are restored except RSP and RDI.
@@ -635,15 +627,7 @@ GLOBAL(swapgs_restore_regs_and_return_to_usermode)
 	ud2
 1:
 #endif
-	POP_EXTRA_REGS
-	popq	%r11
-	popq	%r10
-	popq	%r9
-	popq	%r8
-	popq	%rax
-	popq	%rcx
-	popq	%rdx
-	popq	%rsi
+	POP_REGS pop_rdi=0
 
 	/*
 	 * The stack is now user RDI, orig_ax, RIP, CS, EFLAGS, RSP, SS.
@@ -701,8 +685,7 @@ GLOBAL(restore_regs_and_return_to_kernel)
 	ud2
 1:
 #endif
-	POP_EXTRA_REGS
-	POP_C_REGS
+	POP_REGS
 	addq	$8, %rsp	/* skip regs->orig_ax */
 	INTERRUPT_RETURN
 
@@ -1661,8 +1644,7 @@ end_repeat_nmi:
 nmi_swapgs:
 	SWAPGS_UNSAFE_STACK
 nmi_restore:
-	POP_EXTRA_REGS
-	POP_C_REGS
+	POP_REGS
 
 	/*
 	 * Skip orig_ax and the "outermost" frame to point RSP at the "iret"
