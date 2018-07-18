Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346E9C468C6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E428320858
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="UhySdUdQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E428320858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731902AbeGRKSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:18:47 -0400
Received: from 8bytes.org ([81.169.241.247]:54462 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731770AbeGRKSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:18:47 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id DFB7C3C8E; Wed, 18 Jul 2018 11:41:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531906887; bh=MhPUX6wbhHnJzTrKEUtYXPXwMU2vHuBPvNMwNILcEDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UhySdUdQ2DChsDZW8vGhmCTg4ARPdWi49apEk0GbA/5LLVe/RFKEyBlYQ/KjvE1YV
         wkUZ2minFAJXTYIKeUL5gxHF7H2bTvP/CCT8kaENLLNfe1t9sZdq12yvQoNTYz4lud
         v1lshAG5es1GOc1iFEnUzLvUodFKjg9RfdJHwklTwVT9LxDUNTlag3yuYBBtrsSj8r
         ZulJQCoVM5HikyLRSglAAXjEg1ECJGiUSQha3BzO69VrzJESTXnwB3Gh7JDfyMnqqI
         9FNJJj/Z6Tftf3yX8O4uSQAie47ZT3E33+Ib2Rs9WlF95RtZ2s9a/ufyBo0TUvXkZl
         PavcP+yNyRP4g==
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
Subject: [PATCH 39/39] x86/entry/32: Add debug code to check entry/exit cr3
Date:   Wed, 18 Jul 2018 11:41:16 +0200
Message-Id: <1531906876-13451-40-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531906876-13451-1-git-send-email-joro@8bytes.org>
References: <1531906876-13451-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Add code to check whether we enter and leave the kernel with
the correct cr3 and make it depend on CONFIG_DEBUG_ENTRY.
This is needed because we have no NX protection of
user-addresses in the kernel-cr3 on x86-32 and wouldn't
notice that type of bug otherwise.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/entry/entry_32.S | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index b1541c7..010cdb4 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -166,6 +166,24 @@
 .Lend_\@:
 .endm
 
+.macro BUG_IF_WRONG_CR3 no_user_check=0
+#ifdef CONFIG_DEBUG_ENTRY
+	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
+	.if \no_user_check == 0
+	/* coming from usermode? */
+	testl	$SEGMENT_RPL_MASK, PT_CS(%esp)
+	jz	.Lend_\@
+	.endif
+	/* On user-cr3? */
+	movl	%cr3, %eax
+	testl	$PTI_SWITCH_MASK, %eax
+	jnz	.Lend_\@
+	/* From userspace with kernel cr3 - BUG */
+	ud2
+.Lend_\@:
+#endif
+.endm
+
 /*
  * Switch to kernel cr3 if not already loaded and return current cr3 in
  * \scratch_reg
@@ -213,6 +231,8 @@
 .macro SAVE_ALL_NMI cr3_reg:req
 	SAVE_ALL
 
+	BUG_IF_WRONG_CR3
+
 	/*
 	 * Now switch the CR3 when PTI is enabled.
 	 *
@@ -224,6 +244,7 @@
 
 .Lend_\@:
 .endm
+
 /*
  * This is a sneaky trick to help the unwinder find pt_regs on the stack.  The
  * frame pointer is replaced with an encoded pointer to pt_regs.  The encoding
@@ -287,6 +308,8 @@
 
 .Lswitched_\@:
 
+	BUG_IF_WRONG_CR3
+
 	RESTORE_REGS pop=\pop
 .endm
 
@@ -357,6 +380,8 @@
 
 	ALTERNATIVE     "", "jmp .Lend_\@", X86_FEATURE_XENPV
 
+	BUG_IF_WRONG_CR3
+
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%eax
 
 	/*
@@ -799,6 +824,7 @@ ENTRY(entry_SYSENTER_32)
 	 */
 	pushfl
 	pushl	%eax
+	BUG_IF_WRONG_CR3 no_user_check=1
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%eax
 	popl	%eax
 	popfl
@@ -893,6 +919,7 @@ ENTRY(entry_SYSENTER_32)
 	 * whereas POPF does not.)
 	 */
 	btrl	$X86_EFLAGS_IF_BIT, (%esp)
+	BUG_IF_WRONG_CR3 no_user_check=1
 	popfl
 	popl	%eax
 
@@ -970,6 +997,8 @@ restore_all:
 	/* Switch back to user CR3 */
 	SWITCH_TO_USER_CR3 scratch_reg=%eax
 
+	BUG_IF_WRONG_CR3
+
 	/* Restore user state */
 	RESTORE_REGS pop=4			# skip orig_eax/error_code
 .Lirq_return:
@@ -983,6 +1012,7 @@ restore_all:
 restore_all_kernel:
 	TRACE_IRQS_IRET
 	PARANOID_EXIT_TO_KERNEL_MODE
+	BUG_IF_WRONG_CR3
 	RESTORE_REGS 4
 	jmp	.Lirq_return
 
@@ -990,6 +1020,19 @@ restore_all_kernel:
 ENTRY(iret_exc	)
 	pushl	$0				# no error code
 	pushl	$do_iret_error
+
+#ifdef CONFIG_DEBUG_ENTRY
+	/*
+	 * The stack-frame here is the one that iret faulted on, so its a
+	 * return-to-user frame. We are on kernel-cr3 because we come here from
+	 * the fixup code. This confuses the CR3 checker, so switch to user-cr3
+	 * as the checker expects it.
+	 */
+	pushl	%eax
+	SWITCH_TO_USER_CR3 scratch_reg=%eax
+	popl	%eax
+#endif
+
 	jmp	common_exception
 .previous
 	_ASM_EXTABLE(.Lirq_return, iret_exc)
-- 
2.7.4

