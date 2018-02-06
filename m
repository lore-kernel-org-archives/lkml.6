Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbeBFB1i (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 20:27:38 -0500
Received: from mga18.intel.com ([134.134.136.126]:22935 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752105AbeBFB1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 20:27:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,467,1511856000";
   d="scan'208";a="15550233"
Subject: [PATCH v3 3/3] x86/entry: Clear registers for compat syscalls
From: Dan Williams <dan.j.williams@intel.com>
To: tglx@linutronix.de, mingo@kernel.org
Cc: Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        luto@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        torvalds@linux-foundation.org
Date: Mon, 05 Feb 2018 17:18:17 -0800
Message-ID: <151787989697.7847.4083702787288600552.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151787988045.7847.11830748914544718151.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151787988045.7847.11830748914544718151.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

At entry userspace may have populated registers with values that could
be useful in a speculative execution attack. Clear them to minimize the
kernel's attack surface.

[djbw: interleave the clearing with setting up the stack ]
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/entry/entry_64_compat.S |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 98d5358e4041..fd65e016e413 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -85,15 +85,25 @@ ENTRY(entry_SYSENTER_compat)
 	pushq	%rcx			/* pt_regs->cx */
 	pushq	$-ENOSYS		/* pt_regs->ax */
 	pushq   $0			/* pt_regs->r8  = 0 */
+	xorq	%r8, %r8		/* nospec   r8 */
 	pushq   $0			/* pt_regs->r9  = 0 */
+	xorq	%r9, %r9		/* nospec   r9 */
 	pushq   $0			/* pt_regs->r10 = 0 */
+	xorq	%r10, %r10		/* nospec   r10 */
 	pushq   $0			/* pt_regs->r11 = 0 */
+	xorq	%r11, %r11		/* nospec   r11 */
 	pushq   %rbx                    /* pt_regs->rbx */
+	xorl	%ebx, %ebx		/* nospec   rbx */
 	pushq   %rbp                    /* pt_regs->rbp (will be overwritten) */
+	xorl	%ebp, %ebp		/* nospec   rbp */
 	pushq   $0			/* pt_regs->r12 = 0 */
+	xorq	%r12, %r12		/* nospec   r12 */
 	pushq   $0			/* pt_regs->r13 = 0 */
+	xorq	%r13, %r13		/* nospec   r13 */
 	pushq   $0			/* pt_regs->r14 = 0 */
+	xorq	%r14, %r14		/* nospec   r14 */
 	pushq   $0			/* pt_regs->r15 = 0 */
+	xorq	%r15, %r15		/* nospec   r15 */
 	cld
 
 	/*
@@ -214,15 +224,25 @@ GLOBAL(entry_SYSCALL_compat_after_hwframe)
 	pushq	%rbp			/* pt_regs->cx (stashed in bp) */
 	pushq	$-ENOSYS		/* pt_regs->ax */
 	pushq   $0			/* pt_regs->r8  = 0 */
+	xorq	%r8, %r8		/* nospec   r8 */
 	pushq   $0			/* pt_regs->r9  = 0 */
+	xorq	%r9, %r9		/* nospec   r9 */
 	pushq   $0			/* pt_regs->r10 = 0 */
+	xorq	%r10, %r10		/* nospec   r10 */
 	pushq   $0			/* pt_regs->r11 = 0 */
+	xorq	%r11, %r11		/* nospec   r11 */
 	pushq   %rbx                    /* pt_regs->rbx */
+	xorl	%ebx, %ebx		/* nospec   rbx */
 	pushq   %rbp                    /* pt_regs->rbp (will be overwritten) */
+	xorl	%ebp, %ebp		/* nospec   rbp */
 	pushq   $0			/* pt_regs->r12 = 0 */
+	xorq	%r12, %r12		/* nospec   r12 */
 	pushq   $0			/* pt_regs->r13 = 0 */
+	xorq	%r13, %r13		/* nospec   r13 */
 	pushq   $0			/* pt_regs->r14 = 0 */
+	xorq	%r14, %r14		/* nospec   r14 */
 	pushq   $0			/* pt_regs->r15 = 0 */
+	xorq	%r15, %r15		/* nospec   r15 */
 
 	/*
 	 * User mode is traced as though IRQs are on, and SYSENTER
@@ -338,15 +358,25 @@ ENTRY(entry_INT80_compat)
 	pushq	%rcx			/* pt_regs->cx */
 	pushq	$-ENOSYS		/* pt_regs->ax */
 	pushq   $0			/* pt_regs->r8  = 0 */
+	xorq	%r8, %r8		/* nospec   r8 */
 	pushq   $0			/* pt_regs->r9  = 0 */
+	xorq	%r9, %r9		/* nospec   r9 */
 	pushq   $0			/* pt_regs->r10 = 0 */
+	xorq	%r10, %r10		/* nospec   r10 */
 	pushq   $0			/* pt_regs->r11 = 0 */
+	xorq	%r11, %r11		/* nospec   r11 */
 	pushq   %rbx                    /* pt_regs->rbx */
+	xorl	%ebx, %ebx		/* nospec   rbx */
 	pushq   %rbp                    /* pt_regs->rbp */
+	xorl	%ebp, %ebp		/* nospec   rbp */
 	pushq   %r12                    /* pt_regs->r12 */
+	xorq	%r12, %r12		/* nospec   r12 */
 	pushq   %r13                    /* pt_regs->r13 */
+	xorq	%r13, %r13		/* nospec   r13 */
 	pushq   %r14                    /* pt_regs->r14 */
+	xorq	%r14, %r14		/* nospec   r14 */
 	pushq   %r15                    /* pt_regs->r15 */
+	xorq	%r15, %r15		/* nospec   r15 */
 	cld
 
 	/*
