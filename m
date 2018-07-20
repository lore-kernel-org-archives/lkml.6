Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED84CECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE3820652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="De52EfsT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE3820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388016AbeGTRLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:11:42 -0400
Received: from 8bytes.org ([81.169.241.247]:35872 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387907AbeGTRLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:11:41 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8DC184DC; Fri, 20 Jul 2018 18:22:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1532103759; bh=93K1zGGfsATlPDUeMY+jMYCQoGo2+oe6yojp67mYLac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=De52EfsTCLFLjZSDZWBQr4Yrl0JilstATSNZB/7acPb1kGI+GQPixdt9uM4REWWPK
         8OKYzQCmfXeYNZiNBDWH+/cTGq34D1C0T9I9fe9byqJjvdVI3XytEQiGkmNN7ZXuug
         KKEo9jc694cVt8UO9KxL+9Kzarjk8B7VsFCN1/DOnmcsFoeRBs1Mh6J41pKq04/eXO
         DDNAjiddluj4oQSqz4785sXAzdqTCZqCmdMZHYpBlqTWau4kbfji5N3n6l53vPWoid
         yXQpVS63sNP401MgagUOoTO4rQSYAvOGTjVOIAUtLuxYOm28kpmxvjpB0o7JjuUW+a
         va75PEEV06NGg==
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
        jroedel@suse.de, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, joro@8bytes.org
Subject: [PATCH 3/3] x86/entry/32: Copy only ptregs on paranoid entry/exit path
Date:   Fri, 20 Jul 2018 18:22:24 +0200
Message-Id: <1532103744-31902-4-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532103744-31902-1-git-send-email-joro@8bytes.org>
References: <1532103744-31902-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The code that switches from entry- to task-stack when we
enter from kernel-mode copies the full entry-stack contents
to the task-stack.

That is because we don't trust that the entry-stack
contents. But actually we can trust its contents if we are
not scheduled between entry and exit.

So do less copying and move only the ptregs over to the
task-stack in this code-path.

Suggested-by: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/entry/entry_32.S | 70 +++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 32 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 2767c62..90166b2 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -469,33 +469,48 @@
 	 * segment registers on the way back to user-space or when the
 	 * sysenter handler runs with eflags.tf set.
 	 *
-	 * When we switch to the task-stack here, we can't trust the
-	 * contents of the entry-stack anymore, as the exception handler
-	 * might be scheduled out or moved to another CPU. Therefore we
-	 * copy the complete entry-stack to the task-stack and set a
-	 * marker in the iret-frame (bit 31 of the CS dword) to detect
-	 * what we've done on the iret path.
+	 * When we switch to the task-stack here, we extend the
+	 * stack-frame we copy to include the entry-stack %esp and a
+	 * pseudo %ss value so that we have a full ptregs struct on the
+	 * stack. We set a marker in the frame (bit 31 of the CS dword).
 	 *
-	 * On the iret path we copy everything back and switch to the
-	 * entry-stack, so that the interrupted kernel code-path
-	 * continues on the same stack it was interrupted with.
+	 * On the iret path we read %esp from the PT_OLDESP slot on the
+	 * stack and copy ptregs (except oldesp and oldss) to it, when
+	 * we find the marker set. Then we switch to the %esp we read,
+	 * so that the interrupted kernel code-path continues on the
+	 * same stack it was interrupted with.
 	 *
 	 * Be aware that an NMI can happen anytime in this code.
 	 *
+	 * Register values here are:
+	 *
 	 * %esi: Entry-Stack pointer (same as %esp)
 	 * %edi: Top of the task stack
 	 * %eax: CR3 on kernel entry
 	 */
 
-	/* Calculate number of bytes on the entry stack in %ecx */
-	movl	%esi, %ecx
+	/* Allocate full pt_regs on task-stack */
+	subl	$PTREGS_SIZE, %edi
+
+	/* Switch to task-stack */
+	movl	%edi, %esp
 
-	/* %ecx to the top of entry-stack */
-	andl	$(MASK_entry_stack), %ecx
-	addl	$(SIZEOF_entry_stack), %ecx
+	/* Populate pt_regs on task-stack */
+	movl	$__KERNEL_DS, PT_OLDSS(%esp)	/* Check: Is this needed? */
 
-	/* Number of bytes on the entry stack to %ecx */
-	sub	%esi, %ecx
+	/*
+	 * Save entry-stack pointer on task-stack so that we can switch back to
+	 * it on the the iret path.
+	 */
+	movl	%esi, PT_OLDESP(%esp)
+
+	/* sizeof(pt_regs) minus space for %esp and %ss to %ecx */
+	movl	$(PTREGS_SIZE - 8), %ecx
+
+	/* Copy rest */
+	shrl	$2, %ecx
+	cld
+	rep movsl
 
 	/* Mark stackframe as coming from entry stack */
 	orl	$CS_FROM_ENTRY_STACK, PT_CS(%esp)
@@ -505,16 +520,9 @@
 	 * so that we can switch back to it before iret.
 	 */
 	testl	$PTI_SWITCH_MASK, %eax
-	jz	.Lcopy_pt_regs_\@
+	jz	.Lend_\@
 	orl	$CS_FROM_USER_CR3, PT_CS(%esp)
 
-	/*
-	 * %esi and %edi are unchanged, %ecx contains the number of
-	 * bytes to copy. The code at .Lcopy_pt_regs_\@ will allocate
-	 * the stack-frame on task-stack and copy everything over
-	 */
-	jmp .Lcopy_pt_regs_\@
-
 .Lend_\@:
 .endm
 
@@ -594,16 +602,14 @@
 	/* Clear marker from stack-frame */
 	andl	$(~CS_FROM_ENTRY_STACK), PT_CS(%esp)
 
-	/* Copy the remaining task-stack contents to entry-stack */
+	/*
+	 * Copy the remaining 'struct ptregs' to entry-stack. Leave out
+	 * OLDESP and OLDSS as we didn't copy that over on entry.
+	 */
 	movl	%esp, %esi
-	movl	PER_CPU_VAR(cpu_tss_rw + TSS_sp0), %edi
+	movl	PT_OLDESP(%esp), %edi
 
-	/* Bytes on the task-stack to ecx */
-	movl	PER_CPU_VAR(cpu_tss_rw + TSS_sp1), %ecx
-	subl	%esi, %ecx
-
-	/* Allocate stack-frame on entry-stack */
-	subl	%ecx, %edi
+	movl	$(PTREGS_SIZE - 8), %ecx
 
 	/*
 	 * Save future stack-pointer, we must not switch until the
-- 
2.7.4

