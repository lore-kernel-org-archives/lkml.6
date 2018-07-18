Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CDCECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A28620850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="IZoRGrgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A28620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731296AbeGRKS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:18:27 -0400
Received: from 8bytes.org ([81.169.241.247]:53544 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbeGRKS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:18:26 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E3C451CF; Wed, 18 Jul 2018 11:41:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531906878; bh=QlE8MZLewD3R1oAeDLNK4aQRy8X1hW4H3O+KcJhJiz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IZoRGrgVkTgjISKKhmP2jBgCvQIqVRTPWV8N/V752Lp8rD6XABYdtq2I91fpbdNLv
         Jgp4SO5Tymwfmcd26aPOspu/7462W2e1LgRWtNJ5niaQiRcjE8jJrNnVN3QOmDQqj+
         y2rRVowo56E9s+SSfUnw0MJsrGmF0P3oYtXOoEBxpwmz3apVGe80wVFDqam1MN/8Oq
         8jVT5b5EAYUNHVHV8YrNxqhmy/eyQGeCKa0TzCd7L8QyguN0XxtcdFFNQlZSPffEPI
         o4vlItX4PjDheWaeNTc9kyNZtHyS0HOIKJQOIPpaKYDDH2pGxxit9/4Q0+l9TmVBl1
         5Zkwk8epzEnLA==
From:   Joerg Roedel <joro@8bytes.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
        daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        jroedel@suse.de, joro@8bytes.org
Subject: [PATCH 02/39] x86/entry/32: Rename TSS_sysenter_sp0 to TSS_entry2task_stack
Date:   Wed, 18 Jul 2018 11:40:39 +0200
Message-Id: <1531906876-13451-3-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531906876-13451-1-git-send-email-joro@8bytes.org>
References: <1531906876-13451-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The stack address doesn't need to be stored in tss.sp0 if
we switch manually like on sysenter. Rename the offset so
that it still makes sense when we change its location.

We will also use this stack for all kernel-entry points, not
just sysenter. Reflect that and the fact that it is the
offset to the task-stack location in the name as well.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/entry/entry_32.S        | 2 +-
 arch/x86/kernel/asm-offsets_32.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index c371bfe..39f711a 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -412,7 +412,7 @@ ENTRY(xen_sysenter_target)
  * 0(%ebp) arg6
  */
 ENTRY(entry_SYSENTER_32)
-	movl	TSS_sysenter_sp0(%esp), %esp
+	movl	TSS_entry2task_stack(%esp), %esp
 .Lsysenter_past_esp:
 	pushl	$__USER_DS		/* pt_regs->ss */
 	pushl	%ebp			/* pt_regs->sp (stashed in bp) */
diff --git a/arch/x86/kernel/asm-offsets_32.c b/arch/x86/kernel/asm-offsets_32.c
index a4a3be3..15b3f45 100644
--- a/arch/x86/kernel/asm-offsets_32.c
+++ b/arch/x86/kernel/asm-offsets_32.c
@@ -46,8 +46,9 @@ void foo(void)
 	OFFSET(saved_context_gdt_desc, saved_context, gdt_desc);
 	BLANK();
 
-	/* Offset from the sysenter stack to tss.sp0 */
-	DEFINE(TSS_sysenter_sp0, offsetof(struct cpu_entry_area, tss.x86_tss.sp0) -
+	/* Offset from the entry stack to task stack stored in TSS */
+	DEFINE(TSS_entry2task_stack,
+	       offsetof(struct cpu_entry_area, tss.x86_tss.sp0) -
 	       offsetofend(struct cpu_entry_area, entry_stack_page.stack));
 
 #ifdef CONFIG_STACKPROTECTOR
-- 
2.7.4

