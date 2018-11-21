Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F7FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918F720989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 918F720989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbeKUUoR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:44:17 -0500
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:36036 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbeKUUoR (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:7:1>);
        Wed, 21 Nov 2018 15:44:17 -0500
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Wed, 21 Nov 2018 03:10:27 -0700
Message-Id: <5BF52F0E02000078001FE5BE@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.1.0 
Date:   Wed, 21 Nov 2018 03:10:22 -0700
From:   "Jan Beulich" <JBeulich@suse.com>
To:     <mingo@elte.hu>, <tglx@linutronix.de>, <hpa@zytor.com>
Cc:     "Andrew Lutomirski" <luto@kernel.org>,
        "xen-devel" <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] x86-64/Xen: fix stack switching
References: <5AF03EBD02000078001C1303@prv1-mh.provo.novell.com>
 <5AF03EBD02000000000F91D6@prv1-mh.provo.novell.com>
 <5AF03EBD02000078001FE590@prv1-mh.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While in the native case entry into the kernel happens on the trampoline
stack, PV Xen kernels get entered with the current thread stack right
away. Hence source and destination stacks are identical in that case,
and special care is needed.

Other than in sync_regs() the copying done on the INT80 path as well as
on the NMI path itself isn't NMI / #MC safe, as either of these events
occurring in the middle of the stack copying would clobber data on the
(source) stack. (Of course, in the NMI case only #MC could break
things.)

I'm not altering the similar code in interrupt_entry(), as that code
path is unreachable afaict when running PV Xen guests.

Fixes: 7f2590a110b837af5679d08fc25c6227c5a8c497
Signed-off-by: Jan Beulich <jbeulich@suse.com>
Cc: stable@kernel.org 
---
v2: Correct placement of .Lint80_keep_stack label.
---
 arch/x86/entry/entry_64.S        |    8 ++++++++
 arch/x86/entry/entry_64_compat.S |   10 ++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

--- 4.20-rc3/arch/x86/entry/entry_64.S
+++ 4.20-rc3-x86_64-stack-switch-Xen/arch/x86/entry/entry_64.S
@@ -1380,6 +1380,12 @@ ENTRY(nmi)
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
@@ -1389,6 +1395,8 @@ ENTRY(nmi)
 	pushq	2*8(%rdx)	/* pt_regs->cs */
 	pushq	1*8(%rdx)	/* pt_regs->rip */
 	UNWIND_HINT_IRET_REGS
+.Lnmi_keep_stack:
+
 	pushq   $-1		/* pt_regs->orig_ax */
 	PUSH_AND_CLEAR_REGS rdx=(%rdx)
 	ENCODE_FRAME_POINTER
--- 4.20-rc3/arch/x86/entry/entry_64_compat.S
+++ 4.20-rc3-x86_64-stack-switch-Xen/arch/x86/entry/entry_64_compat.S
@@ -361,17 +361,23 @@ ENTRY(entry_INT80_compat)
 
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
-
 	pushq	(%rdi)			/* pt_regs->di */
+.Lint80_keep_stack:
+
 	pushq	%rsi			/* pt_regs->si */
 	xorl	%esi, %esi		/* nospec   si */
 	pushq	%rdx			/* pt_regs->dx */




