Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B356EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0A121473
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F0A121473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbeHWL3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:29:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44414 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbeHWL3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:29:47 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 55B74C9D;
        Thu, 23 Aug 2018 08:01:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        xen-devel@lists.xenproject.org, Ingo Molnar <mingo@kernel.org>,
        Sarah Newman <srn@prgmr.com>
Subject: [PATCH 4.9 001/130] x86/entry/64: Remove %ebx handling from error_entry/exit
Date:   Thu, 23 Aug 2018 09:51:57 +0200
Message-Id: <20180823074927.264026477@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074927.161454870@linuxfoundation.org>
References: <20180823074927.161454870@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

commit b3681dd548d06deb2e1573890829dff4b15abf46 upstream.

error_entry and error_exit communicate the user vs. kernel status of
the frame using %ebx.  This is unnecessary -- the information is in
regs->cs.  Just use regs->cs.

This makes error_entry simpler and makes error_exit more robust.

It also fixes a nasty bug.  Before all the Spectre nonsense, the
xen_failsafe_callback entry point returned like this:

        ALLOC_PT_GPREGS_ON_STACK
        SAVE_C_REGS
        SAVE_EXTRA_REGS
        ENCODE_FRAME_POINTER
        jmp     error_exit

And it did not go through error_entry.  This was bogus: RBX
contained garbage, and error_exit expected a flag in RBX.

Fortunately, it generally contained *nonzero* garbage, so the
correct code path was used.  As part of the Spectre fixes, code was
added to clear RBX to mitigate certain speculation attacks.  Now,
depending on kernel configuration, RBX got zeroed and, when running
some Wine workloads, the kernel crashes.  This was introduced by:

    commit 3ac6d8c787b8 ("x86/entry/64: Clear registers for exceptions/interrupts, to reduce speculation attack surface")

With this patch applied, RBX is no longer needed as a flag, and the
problem goes away.

I suspect that malicious userspace could use this bug to crash the
kernel even without the offending patch applied, though.

[ Historical note: I wrote this patch as a cleanup before I was aware
  of the bug it fixed. ]

[ Note to stable maintainers: this should probably get applied to all
  kernels.  If you're nervous about that, a more conservative fix to
  add xorl %ebx,%ebx; incl %ebx before the jump to error_exit should
  also fix the problem. ]

Reported-and-tested-by: M. Vefa Bicakci <m.v.b@runbox.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Cc: xen-devel@lists.xenproject.org
Fixes: 3ac6d8c787b8 ("x86/entry/64: Clear registers for exceptions/interrupts, to reduce speculation attack surface")
Link: http://lkml.kernel.org/r/b5010a090d3586b2d6e06c7ad3ec5542d1241c45.1532282627.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sarah Newman <srn@prgmr.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/entry/entry_64.S |   20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -774,7 +774,7 @@ ENTRY(\sym)
 
 	call	\do_sym
 
-	jmp	error_exit			/* %ebx: no swapgs flag */
+	jmp	error_exit
 	.endif
 END(\sym)
 .endm
@@ -1043,7 +1043,6 @@ END(paranoid_exit)
 
 /*
  * Save all registers in pt_regs, and switch gs if needed.
- * Return: EBX=0: came from user mode; EBX=1: otherwise
  */
 ENTRY(error_entry)
 	cld
@@ -1056,7 +1055,6 @@ ENTRY(error_entry)
 	 * the kernel CR3 here.
 	 */
 	SWITCH_KERNEL_CR3
-	xorl	%ebx, %ebx
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
@@ -1087,7 +1085,6 @@ ENTRY(error_entry)
 	 * for these here too.
 	 */
 .Lerror_kernelspace:
-	incl	%ebx
 	leaq	native_irq_return_iret(%rip), %rcx
 	cmpq	%rcx, RIP+8(%rsp)
 	je	.Lerror_bad_iret
@@ -1119,28 +1116,19 @@ ENTRY(error_entry)
 
 	/*
 	 * Pretend that the exception came from user mode: set up pt_regs
-	 * as if we faulted immediately after IRET and clear EBX so that
-	 * error_exit knows that we will be returning to user mode.
+	 * as if we faulted immediately after IRET.
 	 */
 	mov	%rsp, %rdi
 	call	fixup_bad_iret
 	mov	%rax, %rsp
-	decl	%ebx
 	jmp	.Lerror_entry_from_usermode_after_swapgs
 END(error_entry)
 
-
-/*
- * On entry, EBX is a "return to kernel mode" flag:
- *   1: already in kernel mode, don't need SWAPGS
- *   0: user gsbase is loaded, we need SWAPGS and standard preparation for return to usermode
- */
 ENTRY(error_exit)
-	movl	%ebx, %eax
 	DISABLE_INTERRUPTS(CLBR_NONE)
 	TRACE_IRQS_OFF
-	testl	%eax, %eax
-	jnz	retint_kernel
+	testb	$3, CS(%rsp)
+	jz	retint_kernel
 	jmp	retint_user
 END(error_exit)
 


