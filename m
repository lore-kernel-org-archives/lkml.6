Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A03C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07513208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Kqc+hg5D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07513208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732920AbeGKLeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:34:04 -0400
Received: from 8bytes.org ([81.169.241.247]:37666 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732848AbeGKLeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:34:02 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 66F09767; Wed, 11 Jul 2018 13:30:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531308601; bh=oYPgi3NksNzxfLZ6vmyXiBxDzFkNoDJf1JAzwjtUYjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kqc+hg5DiIjFzt8Y6OUZn1RtJE0T8OpBQaSwJm1BHW/eLT6KejO20Zre2tk0nQoKQ
         PKxIDiJZSzY7RrcQkCDWGk3yxZrnIgdArQddH7HXlZnzZhU3edmL2hGRK6bJyK/8CF
         Wt9PiAT6CQKXQcyo7vUbjLH0Ku8VDx3fz2MDFj+G80BoIZWc5UnXhyLe3l3lAFYjdU
         nYDb7hhcyn5gKZEb0szceUy/Qd+sJOpzB+2bXCeegT6fLSi/Tj+GHe6HNQa8jt87ng
         h6ZUflD3BHmp92F0fog8QMzoJMI7QSYsDhqHsW3/16NymRYbruQyC5Ms/XeRwt2Z3Z
         lmZFEvFhEMB1Q==
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
Subject: [PATCH 08/39] x86/entry/32: Leave the kernel via trampoline stack
Date:   Wed, 11 Jul 2018 13:29:15 +0200
Message-Id: <1531308586-29340-9-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531308586-29340-1-git-send-email-joro@8bytes.org>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Switch back to the trampoline stack before returning to
userspace.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/entry/entry_32.S | 79 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 528db7d..357b82b 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -347,6 +347,60 @@
 .endm
 
 /*
+ * Switch back from the kernel stack to the entry stack.
+ *
+ * The %esp register must point to pt_regs on the task stack. It will
+ * first calculate the size of the stack-frame to copy, depending on
+ * whether we return to VM86 mode or not. With that it uses 'rep movsl'
+ * to copy the contents of the stack over to the entry stack.
+ *
+ * We must be very careful here, as we can't trust the contents of the
+ * task-stack once we switched to the entry-stack. When an NMI happens
+ * while on the entry-stack, the NMI handler will switch back to the top
+ * of the task stack, overwriting our stack-frame we are about to copy.
+ * Therefore we switch the stack only after everything is copied over.
+ */
+.macro SWITCH_TO_ENTRY_STACK
+
+	ALTERNATIVE     "", "jmp .Lend_\@", X86_FEATURE_XENPV
+
+	/* Bytes to copy */
+	movl	$PTREGS_SIZE, %ecx
+
+#ifdef CONFIG_VM86
+	testl	$(X86_EFLAGS_VM), PT_EFLAGS(%esp)
+	jz	.Lcopy_pt_regs_\@
+
+	/* Additional 4 registers to copy when returning to VM86 mode */
+	addl    $(4 * 4), %ecx
+
+.Lcopy_pt_regs_\@:
+#endif
+
+	/* Initialize source and destination for movsl */
+	movl	PER_CPU_VAR(cpu_tss_rw + TSS_sp0), %edi
+	subl	%ecx, %edi
+	movl	%esp, %esi
+
+	/* Save future stack pointer in %ebx */
+	movl	%edi, %ebx
+
+	/* Copy over the stack-frame */
+	shrl	$2, %ecx
+	cld
+	rep movsl
+
+	/*
+	 * Switch to entry-stack - needs to happen after everything is
+	 * copied because the NMI handler will overwrite the task-stack
+	 * when on entry-stack
+	 */
+	movl	%ebx, %esp
+
+.Lend_\@:
+.endm
+
+/*
  * %eax: prev task
  * %edx: next task
  */
@@ -586,25 +640,45 @@ ENTRY(entry_SYSENTER_32)
 
 /* Opportunistic SYSEXIT */
 	TRACE_IRQS_ON			/* User mode traces as IRQs on. */
+
+	/*
+	 * Setup entry stack - we keep the pointer in %eax and do the
+	 * switch after almost all user-state is restored.
+	 */
+
+	/* Load entry stack pointer and allocate frame for eflags/eax */
+	movl	PER_CPU_VAR(cpu_tss_rw + TSS_sp0), %eax
+	subl	$(2*4), %eax
+
+	/* Copy eflags and eax to entry stack */
+	movl	PT_EFLAGS(%esp), %edi
+	movl	PT_EAX(%esp), %esi
+	movl	%edi, (%eax)
+	movl	%esi, 4(%eax)
+
+	/* Restore user registers and segments */
 	movl	PT_EIP(%esp), %edx	/* pt_regs->ip */
 	movl	PT_OLDESP(%esp), %ecx	/* pt_regs->sp */
 1:	mov	PT_FS(%esp), %fs
 	PTGS_TO_GS
+
 	popl	%ebx			/* pt_regs->bx */
 	addl	$2*4, %esp		/* skip pt_regs->cx and pt_regs->dx */
 	popl	%esi			/* pt_regs->si */
 	popl	%edi			/* pt_regs->di */
 	popl	%ebp			/* pt_regs->bp */
-	popl	%eax			/* pt_regs->ax */
+
+	/* Switch to entry stack */
+	movl	%eax, %esp
 
 	/*
 	 * Restore all flags except IF. (We restore IF separately because
 	 * STI gives a one-instruction window in which we won't be interrupted,
 	 * whereas POPF does not.)
 	 */
-	addl	$PT_EFLAGS-PT_DS, %esp	/* point esp at pt_regs->flags */
 	btrl	$X86_EFLAGS_IF_BIT, (%esp)
 	popfl
+	popl	%eax
 
 	/*
 	 * Return back to the vDSO, which will pop ecx and edx.
@@ -673,6 +747,7 @@ ENTRY(entry_INT80_32)
 
 restore_all:
 	TRACE_IRQS_IRET
+	SWITCH_TO_ENTRY_STACK
 .Lrestore_all_notrace:
 	CHECK_AND_APPLY_ESPFIX
 .Lrestore_nocheck:
-- 
2.7.4

