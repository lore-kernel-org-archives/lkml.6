Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C093AC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90606214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762345;
	bh=CoOyLPvBlziB3oKmes/Vo0P0Rd/a5U6nQeucAkUPW5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LevMNqQ4jCVUNEi0dkeS4HvGf28isCEaBLGsXpGc+T0tOTqYZrTf27Tourd12/vza
	 NapsZwT0I55RVUMQLj6KMiVl1L2CUcKcsP1JLKVP3KHFkvVby/dVoOq1b4jS/8/hlN
	 1cErgUk7mQs/C5ekCwKKzSFKGZ0DjTJXSVDkgAXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbfA2Lpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:45:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:36202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730814AbfA2Lpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:45:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CC5C20882;
        Tue, 29 Jan 2019 11:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762341;
        bh=CoOyLPvBlziB3oKmes/Vo0P0Rd/a5U6nQeucAkUPW5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HzZUq271l5fpOh4lt4p+uzQJWk5Bd8t52TiclVu/kCb5xSp0dsGGlvzWR1fVqPu2V
         Y8/LW9WSGJHIoMrtAtyxbZAcwg6jl8oXFPVG94W/ak3wUSMPxMvbC+ZITR78jQPptl
         1BrRkOXwn45B0GgLZWctHUwH5nuCTsQsHqq6Afek=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Beulich <jbeulich@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org
Subject: [PATCH 4.19 075/103] x86/entry/64/compat: Fix stack switching for XEN PV
Date:   Tue, 29 Jan 2019 12:35:52 +0100
Message-Id: <20190129113205.301971958@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Beulich <JBeulich@suse.com>

commit fc24d75a7f91837d7918e40719575951820b2b8f upstream.

While in the native case entry into the kernel happens on the trampoline
stack, PV Xen kernels get entered with the current thread stack right
away. Hence source and destination stacks are identical in that case,
and special care is needed.

Other than in sync_regs() the copying done on the INT80 path isn't
NMI / #MC safe, as either of these events occurring in the middle of the
stack copying would clobber data on the (source) stack.

There is similar code in interrupt_entry() and nmi(), but there is no fixup
required because those code paths are unreachable in XEN PV guests.

[ tglx: Sanitized subject, changelog, Fixes tag and stable mail address. Sigh ]

Fixes: 7f2590a110b8 ("x86/entry/64: Use a per-CPU trampoline stack for IDT entries")
Signed-off-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
Cc: Peter Anvin <hpa@zytor.com>
Cc: xen-devel@lists.xenproject.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/5C3E1128020000780020DFAD@prv1-mh.provo.novell.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/entry_64_compat.S |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -356,7 +356,8 @@ ENTRY(entry_INT80_compat)
 
 	/* Need to switch before accessing the thread stack. */
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi
-	movq	%rsp, %rdi
+	/* In the Xen PV case we already run on the thread stack. */
+	ALTERNATIVE "movq %rsp, %rdi", "jmp .Lint80_keep_stack", X86_FEATURE_XENPV
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
 	pushq	6*8(%rdi)		/* regs->ss */
@@ -365,8 +366,9 @@ ENTRY(entry_INT80_compat)
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


