Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C70C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC65220855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfAQXnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:43:09 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45241 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfAQXnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:43:08 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0HNgu0C946463
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 17 Jan 2019 15:42:56 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0HNguGG946460;
        Thu, 17 Jan 2019 15:42:56 -0800
Date:   Thu, 17 Jan 2019 15:42:56 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jan Beulich <tipbot@zytor.com>
Message-ID: <tip-fc24d75a7f91837d7918e40719575951820b2b8f@git.kernel.org>
Cc:     luto@kernel.org, linux-kernel@vger.kernel.org, jbeulich@suse.com,
        mingo@kernel.org, boris.ostrovsky@oracle.com, hpa@zytor.com,
        JBeulich@suse.com, tglx@linutronix.de, jgross@suse.com
Reply-To: jbeulich@suse.com, linux-kernel@vger.kernel.org, luto@kernel.org,
          mingo@kernel.org, hpa@zytor.com, boris.ostrovsky@oracle.com,
          jgross@suse.com, tglx@linutronix.de, JBeulich@suse.com
In-Reply-To: <5C3E1128020000780020DFAD@prv1-mh.provo.novell.com>
References: <5C3E1128020000780020DFAD@prv1-mh.provo.novell.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/entry/64/compat: Fix stack switching for XEN
 PV
Git-Commit-ID: fc24d75a7f91837d7918e40719575951820b2b8f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  fc24d75a7f91837d7918e40719575951820b2b8f
Gitweb:     https://git.kernel.org/tip/fc24d75a7f91837d7918e40719575951820b2b8f
Author:     Jan Beulich <JBeulich@suse.com>
AuthorDate: Tue, 15 Jan 2019 09:58:16 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 18 Jan 2019 00:39:33 +0100

x86/entry/64/compat: Fix stack switching for XEN PV

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

---
 arch/x86/entry/entry_64_compat.S | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 8eaf8952c408..39913770a44d 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
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
