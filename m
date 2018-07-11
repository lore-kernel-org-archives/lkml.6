Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44363C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8025F2120B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="LgiJZBxZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8025F2120B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732949AbeGKLeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:34:05 -0400
Received: from 8bytes.org ([81.169.241.247]:37318 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732871AbeGKLeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:34:04 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D57C28EB; Wed, 11 Jul 2018 13:30:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531308602; bh=JKbLaug3RNyDfvH2yfAePqSaHIh069+G0E3eJSS/Rlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LgiJZBxZMlHKvRElzT/5InVNkummgbuCYIvdGwWxmqxI2NRc7WmbFPkyx9u4HvfLt
         gwh5woopcKx4TyQhwdINvfeLO7+Z/Vs9Y4r+XNvhmtgGINo5iSqgmrv3LPC+QvcLW5
         NPsh5CxiKv3MWlDkd+wFGguOV9EvIYH1R4wEQfho1WfjpglKy3IO6gnmXI/DVyJM1V
         f1ocq3qs/sai+snh3NP/G2zD0riq24KbMFgbyasP92CVIbkHdBFbv+y5VJIiYJAALx
         fdxB0QisG9VADs581T3cxlPxfYvkyU75Glhf18DynPTreBl4IvqGV7zoBj4Nip0FPh
         DyRtsL4xQ570w==
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
Subject: [PATCH 14/39] x86/entry/32: Add PTI cr3 switches to NMI handler code
Date:   Wed, 11 Jul 2018 13:29:21 +0200
Message-Id: <1531308586-29340-15-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531308586-29340-1-git-send-email-joro@8bytes.org>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The NMI handler is special, as it needs to leave with the
same cr3 as it was entered with. We need to do this because
we could enter the NMI handler from kernel code with
user-cr3 already loaded.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/entry/entry_32.S | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 311aefa..a368583 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -77,6 +77,8 @@
 #endif
 .endm
 
+#define PTI_SWITCH_MASK         (1 << PAGE_SHIFT)
+
 /*
  * User gs save/restore
  *
@@ -213,8 +215,19 @@
 
 .endm
 
-.macro SAVE_ALL_NMI
+.macro SAVE_ALL_NMI cr3_reg:req
 	SAVE_ALL
+
+	/*
+	 * Now switch the CR3 when PTI is enabled.
+	 *
+	 * We can enter with either user or kernel cr3, the code will
+	 * store the old cr3 in \cr3_reg and switches to the kernel cr3
+	 * if necessary.
+	 */
+	SWITCH_TO_KERNEL_CR3 scratch_reg=\cr3_reg
+
+.Lend_\@:
 .endm
 /*
  * This is a sneaky trick to help the unwinder find pt_regs on the stack.  The
@@ -262,7 +275,23 @@
 	POP_GS_EX
 .endm
 
-.macro RESTORE_ALL_NMI pop=0
+.macro RESTORE_ALL_NMI cr3_reg:req pop=0
+	/*
+	 * Now switch the CR3 when PTI is enabled.
+	 *
+	 * We enter with kernel cr3 and switch the cr3 to the value
+	 * stored on \cr3_reg, which is either a user or a kernel cr3.
+	 */
+	ALTERNATIVE "jmp .Lswitched_\@", "", X86_FEATURE_PTI
+
+	testl	$PTI_SWITCH_MASK, \cr3_reg
+	jz	.Lswitched_\@
+
+	/* User cr3 in \cr3_reg - write it to hardware cr3 */
+	movl	\cr3_reg, %cr3
+
+.Lswitched_\@:
+
 	RESTORE_REGS pop=\pop
 .endm
 
@@ -1333,7 +1362,7 @@ ENTRY(nmi)
 #endif
 
 	pushl	%eax				# pt_regs->orig_ax
-	SAVE_ALL_NMI
+	SAVE_ALL_NMI cr3_reg=%edi
 	ENCODE_FRAME_POINTER
 	xorl	%edx, %edx			# zero error code
 	movl	%esp, %eax			# pt_regs pointer
@@ -1361,7 +1390,7 @@ ENTRY(nmi)
 
 .Lnmi_return:
 	CHECK_AND_APPLY_ESPFIX
-	RESTORE_ALL_NMI pop=4
+	RESTORE_ALL_NMI cr3_reg=%edi pop=4
 	jmp	.Lirq_return
 
 #ifdef CONFIG_X86_ESPFIX32
@@ -1377,12 +1406,12 @@ ENTRY(nmi)
 	pushl	16(%esp)
 	.endr
 	pushl	%eax
-	SAVE_ALL_NMI
+	SAVE_ALL_NMI cr3_reg=%edi
 	ENCODE_FRAME_POINTER
 	FIXUP_ESPFIX_STACK			# %eax == %esp
 	xorl	%edx, %edx			# zero error code
 	call	do_nmi
-	RESTORE_ALL_NMI
+	RESTORE_ALL_NMI cr3_reg=%edi
 	lss	12+4(%esp), %esp		# back to espfix stack
 	jmp	.Lirq_return
 #endif
-- 
2.7.4

