Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0E8ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4182920874
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="KN7NnniG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4182920874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731625AbeGRKSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:18:34 -0400
Received: from 8bytes.org ([81.169.241.247]:53840 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731494AbeGRKSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:18:33 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 303EF40B; Wed, 18 Jul 2018 11:41:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531906881; bh=/MdQ5kJSDfPjbQqp11z2s21NtYC9zMQ2QYnfF6G7Qvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KN7NnniGjvJQkHdImnfypzsPmHZVswQsIm/gzU9Zw7M2cNzsWi/aOVZCJ+SnPjxyI
         HLjUQiXU95zRmzeqSgU0r/Ndhi8dSJ1fpu8eEAk+GTIHpR1oFzvaQztcEhOaHquI9r
         zBN0/dknwlXwjO5MIxIbVuyGKofjKoiESLyJ5IWX1lenEnriTAZd7QF60i4wEwXG1e
         Wgr//PZtFv/ElA5xvlIE52l54IB3hMlFij1c3/pZtvq2GUSTL/1zj6uoe0KFl+u/ha
         fWTgR0it5/mpGWYzn9zSXQA6oK7I6MYa/GFIJdDnOr4pP7X6R14e56c/8j0JlNAWB5
         eFrxjMX44cekA==
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
Subject: [PATCH 12/39] x86/entry/32: Add PTI cr3 switch to non-NMI entry/exit points
Date:   Wed, 18 Jul 2018 11:40:49 +0200
Message-Id: <1531906876-13451-13-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531906876-13451-1-git-send-email-joro@8bytes.org>
References: <1531906876-13451-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Add unconditional cr3 switches between user and kernel cr3
to all non-NMI entry and exit points.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/entry/entry_32.S | 86 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 82 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index dbf7d61..60b28df 100644
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
@@ -154,6 +156,33 @@
 
 #endif /* CONFIG_X86_32_LAZY_GS */
 
+/* Unconditionally switch to user cr3 */
+.macro SWITCH_TO_USER_CR3 scratch_reg:req
+	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
+
+	movl	%cr3, \scratch_reg
+	orl	$PTI_SWITCH_MASK, \scratch_reg
+	movl	\scratch_reg, %cr3
+.Lend_\@:
+.endm
+
+/*
+ * Switch to kernel cr3 if not already loaded and return current cr3 in
+ * \scratch_reg
+ */
+.macro SWITCH_TO_KERNEL_CR3 scratch_reg:req
+	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
+	movl	%cr3, \scratch_reg
+	/* Test if we are already on kernel CR3 */
+	testl	$PTI_SWITCH_MASK, \scratch_reg
+	jz	.Lend_\@
+	andl	$(~PTI_SWITCH_MASK), \scratch_reg
+	movl	\scratch_reg, %cr3
+	/* Return original CR3 in \scratch_reg */
+	orl	$PTI_SWITCH_MASK, \scratch_reg
+.Lend_\@:
+.endm
+
 .macro SAVE_ALL pt_regs_ax=%eax switch_stacks=0
 	cld
 	PUSH_GS
@@ -283,7 +312,6 @@
 #endif /* CONFIG_X86_ESPFIX32 */
 .endm
 
-
 /*
  * Called with pt_regs fully populated and kernel segments loaded,
  * so we can access PER_CPU and use the integer registers.
@@ -296,11 +324,19 @@
  */
 
 #define CS_FROM_ENTRY_STACK	(1 << 31)
+#define CS_FROM_USER_CR3	(1 << 30)
 
 .macro SWITCH_TO_KERNEL_STACK
 
 	ALTERNATIVE     "", "jmp .Lend_\@", X86_FEATURE_XENPV
 
+	SWITCH_TO_KERNEL_CR3 scratch_reg=%eax
+
+	/*
+	 * %eax now contains the entry cr3 and we carry it forward in
+	 * that register for the time this macro runs
+	 */
+
 	/* Are we on the entry stack? Bail out if not! */
 	movl	PER_CPU_VAR(cpu_entry_area), %ecx
 	addl	$CPU_ENTRY_AREA_entry_stack + SIZEOF_entry_stack, %ecx
@@ -370,7 +406,8 @@
 	 * but switch back to the entry-stack again when we approach
 	 * iret and return to the interrupted code-path. This usually
 	 * happens when we hit an exception while restoring user-space
-	 * segment registers on the way back to user-space.
+	 * segment registers on the way back to user-space or when the
+	 * sysenter handler runs with eflags.tf set.
 	 *
 	 * When we switch to the task-stack here, we can't trust the
 	 * contents of the entry-stack anymore, as the exception handler
@@ -387,6 +424,7 @@
 	 *
 	 * %esi: Entry-Stack pointer (same as %esp)
 	 * %edi: Top of the task stack
+	 * %eax: CR3 on kernel entry
 	 */
 
 	/* Calculate number of bytes on the entry stack in %ecx */
@@ -403,6 +441,14 @@
 	orl	$CS_FROM_ENTRY_STACK, PT_CS(%esp)
 
 	/*
+	 * Test the cr3 used to enter the kernel and add a marker
+	 * so that we can switch back to it before iret.
+	 */
+	testl	$PTI_SWITCH_MASK, %eax
+	jz	.Lcopy_pt_regs_\@
+	orl	$CS_FROM_USER_CR3, PT_CS(%esp)
+
+	/*
 	 * %esi and %edi are unchanged, %ecx contains the number of
 	 * bytes to copy. The code at .Lcopy_pt_regs_\@ will allocate
 	 * the stack-frame on task-stack and copy everything over
@@ -468,7 +514,7 @@
 
 /*
  * This macro handles the case when we return to kernel-mode on the iret
- * path and have to switch back to the entry stack.
+ * path and have to switch back to the entry stack and/or user-cr3
  *
  * See the comments below the .Lentry_from_kernel_\@ label in the
  * SWITCH_TO_KERNEL_STACK macro for more details.
@@ -514,6 +560,18 @@
 	/* Safe to switch to entry-stack now */
 	movl	%ebx, %esp
 
+	/*
+	 * We came from entry-stack and need to check if we also need to
+	 * switch back to user cr3.
+	 */
+	testl	$CS_FROM_USER_CR3, PT_CS(%esp)
+	jz	.Lend_\@
+
+	/* Clear marker from stack-frame */
+	andl	$(~CS_FROM_USER_CR3), PT_CS(%esp)
+
+	SWITCH_TO_USER_CR3 scratch_reg=%eax
+
 .Lend_\@:
 .endm
 /*
@@ -707,7 +765,20 @@ ENTRY(xen_sysenter_target)
  * 0(%ebp) arg6
  */
 ENTRY(entry_SYSENTER_32)
+	/*
+	 * On entry-stack with all userspace-regs live - save and
+	 * restore eflags and %eax to use it as scratch-reg for the cr3
+	 * switch.
+	 */
+	pushfl
+	pushl	%eax
+	SWITCH_TO_KERNEL_CR3 scratch_reg=%eax
+	popl	%eax
+	popfl
+
+	/* Stack empty again, switch to task stack */
 	movl	TSS_entry2task_stack(%esp), %esp
+
 .Lsysenter_past_esp:
 	pushl	$__USER_DS		/* pt_regs->ss */
 	pushl	%ebp			/* pt_regs->sp (stashed in bp) */
@@ -786,6 +857,9 @@ ENTRY(entry_SYSENTER_32)
 	/* Switch to entry stack */
 	movl	%eax, %esp
 
+	/* Now ready to switch the cr3 */
+	SWITCH_TO_USER_CR3 scratch_reg=%eax
+
 	/*
 	 * Restore all flags except IF. (We restore IF separately because
 	 * STI gives a one-instruction window in which we won't be interrupted,
@@ -866,7 +940,11 @@ restore_all:
 .Lrestore_all_notrace:
 	CHECK_AND_APPLY_ESPFIX
 .Lrestore_nocheck:
-	RESTORE_REGS 4				# skip orig_eax/error_code
+	/* Switch back to user CR3 */
+	SWITCH_TO_USER_CR3 scratch_reg=%eax
+
+	/* Restore user state */
+	RESTORE_REGS pop=4			# skip orig_eax/error_code
 .Lirq_return:
 	/*
 	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
-- 
2.7.4

