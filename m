Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752064AbeEGLzr convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 07:55:47 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:46916 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbeEGLzq (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:7:1>);
        Mon, 7 May 2018 07:55:46 -0400
Message-Id: <5AF03EBD02000078001C1303@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Mon, 07 May 2018 05:55:41 -0600
From: "Jan Beulich" <JBeulich@suse.com>
To: <mingo@elte.hu>, <tglx@linutronix.de>, <hpa@zytor.com>
Cc: "Andy Lutomirski" <luto@kernel.org>,
        "xen-devel" <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86-64/Xen: fix stack switching
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While on native entry into the kernel happens on the trampoline stack,
PV Xen kernels are being entered with the current thread stack right
away. Hence source and destination stacks are identical in that case,
and special care is needed.

Other than in sync_regs() the copying done on the INT80 path as well as
on the NMI path itself isn't NMI / #MC safe, as either of these events
occurring in the middle of the stack copying would clobber data on the
(source) stack. (Of course, in the NMI case only #MC could break
things.)

I'm not altering the similar code in interrupt_entry(), as that code
path is unreachable when running an PV Xen guest afaict.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Cc: stable@kernel.org 
---
There would certainly have been the option of using alternatives
patching, but afaict the patching code isn't NMI / #MC safe, so I'd
rather stay away from patching the NMI path. And I thought it would be
better to use similar code in both cases.

Another option would be to make the Xen case match the native one, by
going through the trampoline stack, but to me this would look like extra
overhead for no gain.
---
 arch/x86/entry/entry_64.S        |    8 ++++++++
 arch/x86/entry/entry_64_compat.S |    8 +++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

--- 4.17-rc4/arch/x86/entry/entry_64.S
+++ 4.17-rc4-x86_64-stack-switch-Xen/arch/x86/entry/entry_64.S
@@ -1399,6 +1399,12 @@ ENTRY(nmi)
 	swapgs
 	cld
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdx
+
+	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rdx
+	subq	$8, %rdx
+	xorq	%rsp, %rdx
+	shrq	$PAGE_SHIFT, %rdx
+	jz	.Lnmi_keep_stack
 	movq	%rsp, %rdx
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 	UNWIND_HINT_IRET_REGS base=%rdx offset=8
@@ -1408,6 +1414,8 @@ ENTRY(nmi)
 	pushq	2*8(%rdx)	/* pt_regs->cs */
 	pushq	1*8(%rdx)	/* pt_regs->rip */
 	UNWIND_HINT_IRET_REGS
+.Lnmi_keep_stack:
+
 	pushq   $-1		/* pt_regs->orig_ax */
 	PUSH_AND_CLEAR_REGS rdx=(%rdx)
 	ENCODE_FRAME_POINTER
--- 4.17-rc4/arch/x86/entry/entry_64_compat.S
+++ 4.17-rc4-x86_64-stack-switch-Xen/arch/x86/entry/entry_64_compat.S
@@ -356,15 +356,21 @@ ENTRY(entry_INT80_compat)
 
 	/* Need to switch before accessing the thread stack. */
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi
+
+	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rdi
+	subq	$8, %rdi
+	xorq	%rsp, %rdi
+	shrq	$PAGE_SHIFT, %rdi
+	jz	.Lint80_keep_stack
 	movq	%rsp, %rdi
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
-
 	pushq	6*8(%rdi)		/* regs->ss */
 	pushq	5*8(%rdi)		/* regs->rsp */
 	pushq	4*8(%rdi)		/* regs->eflags */
 	pushq	3*8(%rdi)		/* regs->cs */
 	pushq	2*8(%rdi)		/* regs->ip */
 	pushq	1*8(%rdi)		/* regs->orig_ax */
+.Lint80_keep_stack:
 
 	pushq	(%rdi)			/* pt_regs->di */
 	pushq	%rsi			/* pt_regs->si */
