Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC92FECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F9A20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F9A20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbeGTALe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:11:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39689 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbeGTALe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:11:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JNPBt52453092
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 16:25:11 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JNPAVD2453089;
        Thu, 19 Jul 2018 16:25:10 -0700
Date:   Thu, 19 Jul 2018 16:25:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-b65bef400689ceee7108c2d47fb97ae91f4d1440@git.kernel.org>
Cc:     torvalds@linux-foundation.org, llong@redhat.com,
        dave.hansen@intel.com, jpoimboe@redhat.com, luto@kernel.org,
        mingo@kernel.org, jgross@suse.com, tglx@linutronix.de,
        jkosina@suse.cz, linux-kernel@vger.kernel.org, will.deacon@arm.com,
        David.Laight@aculab.com, boris.ostrovsky@oracle.com, bp@alien8.de,
        hpa@zytor.com, eduval@amazon.com, dhgutteridge@sympatico.ca,
        dvlasenk@redhat.com, brgerst@gmail.com, jroedel@suse.de,
        gregkh@linuxfoundation.org, pavel@ucw.cz, aarcange@redhat.com,
        peterz@infradead.org
Reply-To: dvlasenk@redhat.com, bp@alien8.de, eduval@amazon.com,
          hpa@zytor.com, dhgutteridge@sympatico.ca, pavel@ucw.cz,
          peterz@infradead.org, aarcange@redhat.com, jroedel@suse.de,
          brgerst@gmail.com, gregkh@linuxfoundation.org, mingo@kernel.org,
          torvalds@linux-foundation.org, dave.hansen@intel.com,
          llong@redhat.com, jpoimboe@redhat.com, luto@kernel.org,
          linux-kernel@vger.kernel.org, David.Laight@aculab.com,
          will.deacon@arm.com, boris.ostrovsky@oracle.com, jgross@suse.com,
          tglx@linutronix.de, jkosina@suse.cz
In-Reply-To: <1531906876-13451-14-git-send-email-joro@8bytes.org>
References: <1531906876-13451-14-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/32: Add PTI CR3 switches to NMI handler
 code
Git-Commit-ID: b65bef400689ceee7108c2d47fb97ae91f4d1440
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

Commit-ID:  b65bef400689ceee7108c2d47fb97ae91f4d1440
Gitweb:     https://git.kernel.org/tip/b65bef400689ceee7108c2d47fb97ae91f4d1440
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 18 Jul 2018 11:40:50 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 01:11:39 +0200

x86/entry/32: Add PTI CR3 switches to NMI handler code

The NMI handler is special, as it needs to leave with the same CR3 as it
was entered with. This is required because the NMI can happen within kernel
context but with user CR3 already loaded, i.e. after switching to user CR3
but before returning to user space.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Pavel Machek <pavel@ucw.cz>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: linux-mm@kvack.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Laight <David.Laight@aculab.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Eduardo Valentin <eduval@amazon.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: aliguori@amazon.com
Cc: daniel.gruss@iaik.tugraz.at
Cc: hughd@google.com
Cc: keescook@google.com
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Waiman Long <llong@redhat.com>
Cc: "David H . Gutteridge" <dhgutteridge@sympatico.ca>
Cc: joro@8bytes.org
Link: https://lkml.kernel.org/r/1531906876-13451-14-git-send-email-joro@8bytes.org

---
 arch/x86/entry/entry_32.S | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 60b28dfa00dc..b1541c74c71a 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -210,8 +210,19 @@
 
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
@@ -259,7 +270,23 @@
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
 
@@ -1331,7 +1358,7 @@ ENTRY(nmi)
 #endif
 
 	pushl	%eax				# pt_regs->orig_ax
-	SAVE_ALL_NMI
+	SAVE_ALL_NMI cr3_reg=%edi
 	ENCODE_FRAME_POINTER
 	xorl	%edx, %edx			# zero error code
 	movl	%esp, %eax			# pt_regs pointer
@@ -1359,7 +1386,7 @@ ENTRY(nmi)
 
 .Lnmi_return:
 	CHECK_AND_APPLY_ESPFIX
-	RESTORE_ALL_NMI pop=4
+	RESTORE_ALL_NMI cr3_reg=%edi pop=4
 	jmp	.Lirq_return
 
 #ifdef CONFIG_X86_ESPFIX32
@@ -1375,12 +1402,12 @@ ENTRY(nmi)
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
