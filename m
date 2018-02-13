Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934058AbeBMJJP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:09:15 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43781 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933824AbeBMJJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:09:13 -0500
Date: Tue, 13 Feb 2018 01:02:19 -0800
From: tip-bot for Dominik Brodowski <tipbot@zytor.com>
Message-ID: <tip-30907fd13bb593202574bb20af58d67c70a1ee14@git.kernel.org>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org, luto@kernel.org,
        torvalds@linux-foundation.org, tglx@linutronix.de, bp@alien8.de,
        brgerst@gmail.com, linux@dominikbrodowski.net, mingo@kernel.org,
        jpoimboe@redhat.com, peterz@infradead.org, dvlasenk@redhat.com
Reply-To: jpoimboe@redhat.com, mingo@kernel.org, brgerst@gmail.com,
        linux@dominikbrodowski.net, dvlasenk@redhat.com, peterz@infradead.org,
        torvalds@linux-foundation.org, luto@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de
In-Reply-To: <20180211104949.12992-6-linux@dominikbrodowski.net>
References: <20180211104949.12992-6-linux@dominikbrodowski.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/64: Use PUSH_AND_CLEAN_REGS in more cases
Git-Commit-ID: 30907fd13bb593202574bb20af58d67c70a1ee14
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

Commit-ID:  30907fd13bb593202574bb20af58d67c70a1ee14
Gitweb:     https://git.kernel.org/tip/30907fd13bb593202574bb20af58d67c70a1ee14
Author:     Dominik Brodowski <linux@dominikbrodowski.net>
AuthorDate: Sun, 11 Feb 2018 11:49:46 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 09:04:53 +0100

x86/entry/64: Use PUSH_AND_CLEAN_REGS in more cases

entry_SYSCALL_64_after_hwframe() and nmi() can be converted to use
PUSH_AND_CLEAN_REGS instead of opencoded variants thereof. Due to
the interleaving, the additional XOR-based clearing of R8 and R9
in entry_SYSCALL_64_after_hwframe() should not have any noticeable
negative implications.

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
Link: http://lkml.kernel.org/r/20180211104949.12992-6-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/calling.h  |  6 ++---
 arch/x86/entry/entry_64.S | 65 +++--------------------------------------------
 2 files changed, 6 insertions(+), 65 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 57b1b87..d6a97e2 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -137,7 +137,7 @@ For 32-bit we have the following conventions - kernel is built with
 	UNWIND_HINT_REGS offset=\offset
 	.endm
 
-	.macro PUSH_AND_CLEAR_REGS
+	.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax
 	/*
 	 * Push registers and sanitize registers of values that a
 	 * speculation attack might otherwise want to exploit. The
@@ -147,9 +147,9 @@ For 32-bit we have the following conventions - kernel is built with
 	 */
 	pushq   %rdi		/* pt_regs->di */
 	pushq   %rsi		/* pt_regs->si */
-	pushq   %rdx		/* pt_regs->dx */
+	pushq	\rdx		/* pt_regs->dx */
 	pushq   %rcx		/* pt_regs->cx */
-	pushq   %rax		/* pt_regs->ax */
+	pushq   \rax		/* pt_regs->ax */
 	pushq   %r8		/* pt_regs->r8 */
 	xorq    %r8, %r8	/* nospec   r8 */
 	pushq   %r9		/* pt_regs->r9 */
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index cf4a9ae..b06a4b5 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -227,35 +227,8 @@ ENTRY(entry_SYSCALL_64)
 	pushq	%rcx				/* pt_regs->ip */
 GLOBAL(entry_SYSCALL_64_after_hwframe)
 	pushq	%rax				/* pt_regs->orig_ax */
-	pushq	%rdi				/* pt_regs->di */
-	pushq	%rsi				/* pt_regs->si */
-	pushq	%rdx				/* pt_regs->dx */
-	pushq	%rcx				/* pt_regs->cx */
-	pushq	$-ENOSYS			/* pt_regs->ax */
-	pushq	%r8				/* pt_regs->r8 */
-	pushq	%r9				/* pt_regs->r9 */
-	pushq	%r10				/* pt_regs->r10 */
-	/*
-	 * Clear extra registers that a speculation attack might
-	 * otherwise want to exploit. Interleave XOR with PUSH
-	 * for better uop scheduling:
-	 */
-	xorq	%r10, %r10			/* nospec   r10 */
-	pushq	%r11				/* pt_regs->r11 */
-	xorq	%r11, %r11			/* nospec   r11 */
-	pushq	%rbx				/* pt_regs->rbx */
-	xorl	%ebx, %ebx			/* nospec   rbx */
-	pushq	%rbp				/* pt_regs->rbp */
-	xorl	%ebp, %ebp			/* nospec   rbp */
-	pushq	%r12				/* pt_regs->r12 */
-	xorq	%r12, %r12			/* nospec   r12 */
-	pushq	%r13				/* pt_regs->r13 */
-	xorq	%r13, %r13			/* nospec   r13 */
-	pushq	%r14				/* pt_regs->r14 */
-	xorq	%r14, %r14			/* nospec   r14 */
-	pushq	%r15				/* pt_regs->r15 */
-	xorq	%r15, %r15			/* nospec   r15 */
-	UNWIND_HINT_REGS
+
+	PUSH_AND_CLEAR_REGS rax=$-ENOSYS
 
 	TRACE_IRQS_OFF
 
@@ -1388,39 +1361,7 @@ ENTRY(nmi)
 	pushq	1*8(%rdx)	/* pt_regs->rip */
 	UNWIND_HINT_IRET_REGS
 	pushq   $-1		/* pt_regs->orig_ax */
-	pushq   %rdi		/* pt_regs->di */
-	pushq   %rsi		/* pt_regs->si */
-	pushq   (%rdx)		/* pt_regs->dx */
-	pushq   %rcx		/* pt_regs->cx */
-	pushq   %rax		/* pt_regs->ax */
-	/*
-	 * Sanitize registers of values that a speculation attack
-	 * might otherwise want to exploit. The lower registers are
-	 * likely clobbered well before they could be put to use in
-	 * a speculative execution gadget. Interleave XOR with PUSH
-	 * for better uop scheduling:
-	 */
-	pushq   %r8		/* pt_regs->r8 */
-	xorq    %r8, %r8	/* nospec   r8 */
-	pushq   %r9		/* pt_regs->r9 */
-	xorq    %r9, %r9	/* nospec   r9 */
-	pushq   %r10		/* pt_regs->r10 */
-	xorq    %r10, %r10	/* nospec   r10 */
-	pushq   %r11		/* pt_regs->r11 */
-	xorq    %r11, %r11	/* nospec   r11*/
-	pushq	%rbx		/* pt_regs->rbx */
-	xorl    %ebx, %ebx	/* nospec   rbx*/
-	pushq	%rbp		/* pt_regs->rbp */
-	xorl    %ebp, %ebp	/* nospec   rbp*/
-	pushq	%r12		/* pt_regs->r12 */
-	xorq    %r12, %r12	/* nospec   r12*/
-	pushq	%r13		/* pt_regs->r13 */
-	xorq    %r13, %r13	/* nospec   r13*/
-	pushq	%r14		/* pt_regs->r14 */
-	xorq    %r14, %r14	/* nospec   r14*/
-	pushq	%r15		/* pt_regs->r15 */
-	xorq    %r15, %r15	/* nospec   r15*/
-	UNWIND_HINT_REGS
+	PUSH_AND_CLEAR_REGS rdx=(%rdx)
 	ENCODE_FRAME_POINTER
 
 	/*
