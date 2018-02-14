Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161640AbeBNSBD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:01:03 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:47278 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161578AbeBNSAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:00:37 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, x86@kernel.org,
        torvalds@linux-foundation.org
Cc: luto@kernel.org, ak@linux.intel.com, tglx@linutronix.de,
        dan.j.williams@intel.com
Subject: [PATCH 2/2] x86/entry/64: use xorl for register clearing
Date: Wed, 14 Feb 2018 18:59:24 +0100
Message-Id: <20180214175924.23065-3-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180214175924.23065-1-linux@dominikbrodowski.net>
References: <20180214175924.23065-1-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using xorq to clear general-purpose registers is slower than
xorl on some architectures. As xorl is sufficient to clear all
64bit of these registers,[*] switch the x86 64-bit entry code
to use xorl.

[*] According to Intel 64 and IA-32 Architecture Software Developer's
    Manual, section 3.4.1.1, the result of 32-bit operands are "zero-
    extended to a 64-bit result in the destination general-purpose
    register." The AMD64 Architecture Programmer’s Manual Volume 3,
    Appendix B.1, describes the same behaviour.

Suggested-by: Denys Vlasenko <dvlasenk@redhat.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/entry/calling.h         | 16 ++++++------
 arch/x86/entry/entry_64_compat.S | 54 ++++++++++++++++++++--------------------
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 79ead48e6fe1..adaf5fd9840d 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -117,25 +117,25 @@ For 32-bit we have the following conventions - kernel is built with
 	pushq   %rcx		/* pt_regs->cx */
 	pushq   \rax		/* pt_regs->ax */
 	pushq   %r8		/* pt_regs->r8 */
-	xorq    %r8, %r8	/* nospec   r8 */
+	xorl	%r8d, %r8d	/* nospec   r8 */
 	pushq   %r9		/* pt_regs->r9 */
-	xorq    %r9, %r9	/* nospec   r9 */
+	xorl	%r9d, %r9d	/* nospec   r9 */
 	pushq   %r10		/* pt_regs->r10 */
-	xorq    %r10, %r10	/* nospec   r10 */
+	xorl	%r10d, %r10d	/* nospec   r10 */
 	pushq   %r11		/* pt_regs->r11 */
-	xorq    %r11, %r11	/* nospec   r11*/
+	xorl	%r11d, %r11d	/* nospec   r11*/
 	pushq	%rbx		/* pt_regs->rbx */
 	xorl    %ebx, %ebx	/* nospec   rbx*/
 	pushq	%rbp		/* pt_regs->rbp */
 	xorl    %ebp, %ebp	/* nospec   rbp*/
 	pushq	%r12		/* pt_regs->r12 */
-	xorq    %r12, %r12	/* nospec   r12*/
+	xorl	%r12d, %r12d	/* nospec   r12*/
 	pushq	%r13		/* pt_regs->r13 */
-	xorq    %r13, %r13	/* nospec   r13*/
+	xorl	%r13d, %r13d	/* nospec   r13*/
 	pushq	%r14		/* pt_regs->r14 */
-	xorq    %r14, %r14	/* nospec   r14*/
+	xorl	%r14d, %r14d	/* nospec   r14*/
 	pushq	%r15		/* pt_regs->r15 */
-	xorq    %r15, %r15	/* nospec   r15*/
+	xorl	%r15d, %r15d	/* nospec   r15*/
 	UNWIND_HINT_REGS
 	.if \save_ret
 	pushq	%rsi		/* return address on top of stack */
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index fd65e016e413..364ea4a207be 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -85,25 +85,25 @@ ENTRY(entry_SYSENTER_compat)
 	pushq	%rcx			/* pt_regs->cx */
 	pushq	$-ENOSYS		/* pt_regs->ax */
 	pushq   $0			/* pt_regs->r8  = 0 */
-	xorq	%r8, %r8		/* nospec   r8 */
+	xorl	%r8d, %r8d		/* nospec   r8 */
 	pushq   $0			/* pt_regs->r9  = 0 */
-	xorq	%r9, %r9		/* nospec   r9 */
+	xorl	%r9d, %r9d		/* nospec   r9 */
 	pushq   $0			/* pt_regs->r10 = 0 */
-	xorq	%r10, %r10		/* nospec   r10 */
+	xorl	%r10d, %r10d		/* nospec   r10 */
 	pushq   $0			/* pt_regs->r11 = 0 */
-	xorq	%r11, %r11		/* nospec   r11 */
+	xorl	%r11d, %r11d		/* nospec   r11 */
 	pushq   %rbx                    /* pt_regs->rbx */
 	xorl	%ebx, %ebx		/* nospec   rbx */
 	pushq   %rbp                    /* pt_regs->rbp (will be overwritten) */
 	xorl	%ebp, %ebp		/* nospec   rbp */
 	pushq   $0			/* pt_regs->r12 = 0 */
-	xorq	%r12, %r12		/* nospec   r12 */
+	xorl	%r12d, %r12d		/* nospec   r12 */
 	pushq   $0			/* pt_regs->r13 = 0 */
-	xorq	%r13, %r13		/* nospec   r13 */
+	xorl	%r13d, %r13d		/* nospec   r13 */
 	pushq   $0			/* pt_regs->r14 = 0 */
-	xorq	%r14, %r14		/* nospec   r14 */
+	xorl	%r14d, %r14d		/* nospec   r14 */
 	pushq   $0			/* pt_regs->r15 = 0 */
-	xorq	%r15, %r15		/* nospec   r15 */
+	xorl	%r15d, %r15d		/* nospec   r15 */
 	cld
 
 	/*
@@ -224,25 +224,25 @@ GLOBAL(entry_SYSCALL_compat_after_hwframe)
 	pushq	%rbp			/* pt_regs->cx (stashed in bp) */
 	pushq	$-ENOSYS		/* pt_regs->ax */
 	pushq   $0			/* pt_regs->r8  = 0 */
-	xorq	%r8, %r8		/* nospec   r8 */
+	xorl	%r8d, %r8d		/* nospec   r8 */
 	pushq   $0			/* pt_regs->r9  = 0 */
-	xorq	%r9, %r9		/* nospec   r9 */
+	xorl	%r9d, %r9d		/* nospec   r9 */
 	pushq   $0			/* pt_regs->r10 = 0 */
-	xorq	%r10, %r10		/* nospec   r10 */
+	xorl	%r10d, %r10d		/* nospec   r10 */
 	pushq   $0			/* pt_regs->r11 = 0 */
-	xorq	%r11, %r11		/* nospec   r11 */
+	xorl	%r11d, %r11d		/* nospec   r11 */
 	pushq   %rbx                    /* pt_regs->rbx */
 	xorl	%ebx, %ebx		/* nospec   rbx */
 	pushq   %rbp                    /* pt_regs->rbp (will be overwritten) */
 	xorl	%ebp, %ebp		/* nospec   rbp */
 	pushq   $0			/* pt_regs->r12 = 0 */
-	xorq	%r12, %r12		/* nospec   r12 */
+	xorl	%r12d, %r12d		/* nospec   r12 */
 	pushq   $0			/* pt_regs->r13 = 0 */
-	xorq	%r13, %r13		/* nospec   r13 */
+	xorl	%r13d, %r13d		/* nospec   r13 */
 	pushq   $0			/* pt_regs->r14 = 0 */
-	xorq	%r14, %r14		/* nospec   r14 */
+	xorl	%r14d, %r14d		/* nospec   r14 */
 	pushq   $0			/* pt_regs->r15 = 0 */
-	xorq	%r15, %r15		/* nospec   r15 */
+	xorl	%r15d, %r15d		/* nospec   r15 */
 
 	/*
 	 * User mode is traced as though IRQs are on, and SYSENTER
@@ -298,9 +298,9 @@ sysret32_from_system_call:
 	 */
 	SWITCH_TO_USER_CR3_NOSTACK scratch_reg=%r8 scratch_reg2=%r9
 
-	xorq	%r8, %r8
-	xorq	%r9, %r9
-	xorq	%r10, %r10
+	xorl	%r8d, %r8d
+	xorl	%r9d, %r9d
+	xorl	%r10d, %r10d
 	swapgs
 	sysretl
 END(entry_SYSCALL_compat)
@@ -358,25 +358,25 @@ ENTRY(entry_INT80_compat)
 	pushq	%rcx			/* pt_regs->cx */
 	pushq	$-ENOSYS		/* pt_regs->ax */
 	pushq   $0			/* pt_regs->r8  = 0 */
-	xorq	%r8, %r8		/* nospec   r8 */
+	xorl	%r8d, %r8d		/* nospec   r8 */
 	pushq   $0			/* pt_regs->r9  = 0 */
-	xorq	%r9, %r9		/* nospec   r9 */
+	xorl	%r9d, %r9d		/* nospec   r9 */
 	pushq   $0			/* pt_regs->r10 = 0 */
-	xorq	%r10, %r10		/* nospec   r10 */
+	xorl	%r10d, %r10d		/* nospec   r10 */
 	pushq   $0			/* pt_regs->r11 = 0 */
-	xorq	%r11, %r11		/* nospec   r11 */
+	xorl	%r11d, %r11d		/* nospec   r11 */
 	pushq   %rbx                    /* pt_regs->rbx */
 	xorl	%ebx, %ebx		/* nospec   rbx */
 	pushq   %rbp                    /* pt_regs->rbp */
 	xorl	%ebp, %ebp		/* nospec   rbp */
 	pushq   %r12                    /* pt_regs->r12 */
-	xorq	%r12, %r12		/* nospec   r12 */
+	xorl	%r12d, %r12d		/* nospec   r12 */
 	pushq   %r13                    /* pt_regs->r13 */
-	xorq	%r13, %r13		/* nospec   r13 */
+	xorl	%r13d, %r13d		/* nospec   r13 */
 	pushq   %r14                    /* pt_regs->r14 */
-	xorq	%r14, %r14		/* nospec   r14 */
+	xorl	%r14d, %r14d		/* nospec   r14 */
 	pushq   %r15                    /* pt_regs->r15 */
-	xorq	%r15, %r15		/* nospec   r15 */
+	xorl	%r15d, %r15d		/* nospec   r15 */
 	cld
 
 	/*
-- 
2.16.1
