Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694A2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D0720645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387850AbfAOQ6V convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:58:21 -0500
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:45621 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbfAOQ6R (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:7:1>);
        Tue, 15 Jan 2019 11:58:17 -0500
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Tue, 15 Jan 2019 09:58:16 -0700
Message-Id: <5C3E1128020000780020DFAD@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.1.0 
Date:   Tue, 15 Jan 2019 09:58:16 -0700
From:   "Jan Beulich" <JBeulich@suse.com>
To:     <mingo@elte.hu>, <tglx@linutronix.de>, <hpa@zytor.com>
Cc:     "Andrew Lutomirski" <luto@kernel.org>,
        "xen-devel" <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] x86-64/Xen: fix stack switching
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

Other than in sync_regs() the copying done on the INT80 path isn't
NMI / #MC safe, as either of these events occurring in the middle of the
stack copying would clobber data on the (source) stack.

I'm not altering the similar code in interrupt_entry() and nmi(), as
those code paths are unreachable afaict when running PV Xen guests.

Fixes: 7f2590a110b837af5679d08fc25c6227c5a8c497
Signed-off-by: Jan Beulich <jbeulich@suse.com>
Cc: stable@kernel.org 
---
v3: Drop NMI path change. Use ALTERNATIVE.
v2: Correct placement of .Lint80_keep_stack label.
---
 arch/x86/entry/entry_64_compat.S |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- 5.0-rc2/arch/x86/entry/entry_64_compat.S
+++ 5.0-rc2-x86_64-stack-switch-Xen/arch/x86/entry/entry_64_compat.S
@@ -361,7 +361,8 @@ ENTRY(entry_INT80_compat)
 
 	/* Need to switch before accessing the thread stack. */
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi
-	movq	%rsp, %rdi
+	/* In the Xen PV case we already run on the thread stack. */
+	ALTERNATIVE "movq %rsp, %rdi", "jmp .Lint80_keep_stack", X86_FEATURE_XENPV
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
 	pushq	6*8(%rdi)		/* regs->ss */
@@ -370,8 +371,9 @@ ENTRY(entry_INT80_compat)
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




