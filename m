Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AH8x226OZ0CRoFf4azGj+056EHgR4h8tkF6j0JpLvZSMziGWT8eY/tkl26rvUMoAAuyOwYQJpch1
ARC-Seal: i=1; a=rsa-sha256; t=1518868271; cv=none;
        d=google.com; s=arc-20160816;
        b=a+jFCUab8P24ZVim5TMnMrn8aJnQC5Uud8S0rLvG9NJd/vvG/OU/jRCjGopzplfqqd
         xFpc/ZKlIIGkkf9lnRGVfJk37s/9OlLrXq6UnOtJgLZc3dJFb+BePWWfvjHGtueXHH7R
         wxymCJgw+lYNHXJf1Ll8e0I3fK26dwDvQ7KELDHIjWRFF2U0JNgrNaGHVTmgIB22EjVW
         3YaxHVrLfuAe6EOV65Vw+0jVsW+R3vQXUm+ZDLWMT1GmdMPYY0szrWXy/gDLsxAdC22x
         RZTKcWBAM1miZJTWEenYCKky5FKVPL5CRNsxU8Qe7F63H6bzKyHDPz+uOL0VYDIqL7tq
         rpJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=5lgnVpyzhOYavrMODMBCiXg7j43m1etvtNrgAPmm2Uo=;
        b=VV+sDbMWKYFojPA1b8iq7ebKSSb02StUwKyK9mNiJ4u0WJXY1VGgRjC0vmEJhc9fX1
         T2Odzlx1rQ2InECI5fEFb6f6e4C2ioe/xeIRdtBLxlWw1maVv2sOxiB+kZjACyCjIb+I
         FG/pFr38nrL2aNNrbGaJ0epT44+GHNQy6F2kpBw1rRvkzcrCY/zk1kOKzevkZAbFyRts
         ja+RyTUu5rr79wUTYho6LMBwCuzMhrRpIAmO8uoLjrxTzdlrwqpZQTTnHCqrlKDhSiAW
         2Og0A960M85lOD0NH3Hhabo8Cq+JLEklouLpCc9fFifxQy/mpwuhZoZsa69lmYU/YJ+j
         B2Ew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Sat, 17 Feb 2018 03:40:42 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Dominik Brodowski <tipbot@zytor.com>
Message-ID: <tip-ced5d0bf603fa0baee8ea889e1d70971fd210894@git.kernel.org>
Cc: torvalds@linux-foundation.org, dvlasenk@redhat.com, arjan@linux.intel.com,
        luto@kernel.org, bp@alien8.de, peterz@infradead.org,
        dave.hansen@linux.intel.com, dan.j.williams@intel.com,
        mingo@kernel.org, jpoimboe@redhat.com, hpa@zytor.com,
        dwmw2@infradead.org, linux-kernel@vger.kernel.org,
        linux@dominikbrodowski.net, tglx@linutronix.de,
        gregkh@linuxfoundation.org
Reply-To: jpoimboe@redhat.com, mingo@kernel.org, dave.hansen@linux.intel.com,
        dan.j.williams@intel.com, peterz@infradead.org, bp@alien8.de,
        luto@kernel.org, dvlasenk@redhat.com, arjan@linux.intel.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        tglx@linutronix.de, linux@dominikbrodowski.net,
        linux-kernel@vger.kernel.org, dwmw2@infradead.org, hpa@zytor.com
In-Reply-To: <20180214175924.23065-3-linux@dominikbrodowski.net>
References: <20180214175924.23065-3-linux@dominikbrodowski.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/64: Use 'xorl' for faster register clearing
Git-Commit-ID: ced5d0bf603fa0baee8ea889e1d70971fd210894
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592648816679521654?=
X-GMAIL-MSGID: =?utf-8?q?1592648816679521654?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  ced5d0bf603fa0baee8ea889e1d70971fd210894
Gitweb:     https://git.kernel.org/tip/ced5d0bf603fa0baee8ea889e1d70971fd210894
Author:     Dominik Brodowski <linux@dominikbrodowski.net>
AuthorDate: Wed, 14 Feb 2018 18:59:24 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 17 Feb 2018 11:14:33 +0100

x86/entry/64: Use 'xorl' for faster register clearing

On some x86 CPU microarchitectures using 'xorq' to clear general-purpose
registers is slower than 'xorl'. As 'xorl' is sufficient to clear all
64 bits of these registers due to zero-extension [*], switch the x86
64-bit entry code to use 'xorl'.

No change in functionality and no change in code size.

[*] According to Intel 64 and IA-32 Architecture Software Developer's
    Manual, section 3.4.1.1, the result of 32-bit operands are "zero-
    extended to a 64-bit result in the destination general-purpose
    register." The AMD64 Architecture Programmer’s Manual Volume 3,
    Appendix B.1, describes the same behaviour.

Suggested-by: Denys Vlasenko <dvlasenk@redhat.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180214175924.23065-3-linux@dominikbrodowski.net
[ Improved on the changelog a bit. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/calling.h         | 16 ++++++------
 arch/x86/entry/entry_64_compat.S | 54 ++++++++++++++++++++--------------------
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 196b610..5d10b7a 100644
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
index fd65e01..364ea4a 100644
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
