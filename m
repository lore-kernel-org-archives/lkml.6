Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754669AbeBGUTo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 15:19:44 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:59468 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754303AbeBGUTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 15:19:43 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, x86@kernel.org
Cc: dan.j.williams@intel.com, tglx@linutronix.de, ak@linux.intel.com,
        torvalds@linux-foundation.org, luto@kernel.org
Subject: [RFC v2 PATCH 5/7] x86/entry: use PUSH_AND_CLEAN_REGS in more cases
Date: Wed,  7 Feb 2018 21:15:15 +0100
Message-Id: <20180207201517.6518-6-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180207201517.6518-1-linux@dominikbrodowski.net>
References: <20180207201517.6518-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

entry_SYSCALL_64_after_hwframe and nmi can be converted to use
PUSH_AND_CLEAN_REGS instead of opencoded variants thereof. Due to
the interleaving, the additional XOR-based clearing of r8 and r9
in entry_SYSCALL_64_after_hwframe should not have any noticeable
negative implications.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/entry/calling.h  |  6 ++---
 arch/x86/entry/entry_64.S | 65 +++--------------------------------------------
 2 files changed, 6 insertions(+), 65 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 57b1b87a04f0..d6a97e2945ee 100644
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
index 9dd3fbfdc75d..9c4fe360db42 100644
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
-- 
2.16.1
