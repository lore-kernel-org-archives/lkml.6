Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D828CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9677F21104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBJ0HOhh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9677F21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbeK3BXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:23:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:45366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728439AbeK3BXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:23:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DB2321019;
        Thu, 29 Nov 2018 14:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501067;
        bh=Rk7smw6r4+/aDfWl0HxSZhmxkqkCbe3faj3iTDQ6ahg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TBJ0HOhh9CmztsyWMoekawSmluI+wBcCBGgYefVlWnj6JM/zx1a7pXsAHQF1SixxR
         yIAqbYx2yMm5QG8e4KQyVj8QPSJydorh6rWxpwn7WENi/ubpRiqDrw+izaVuE1jVf5
         dl+Pd8LGiY2orySWXT30Y1UgXmltUCYVjlg6g3Jw=
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
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 29/86] x86/entry/64: Remove %ebx handling from error_entry/exit
Date:   Thu, 29 Nov 2018 15:11:54 +0100
Message-Id: <20181129140112.380588333@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140109.832117862@linuxfoundation.org>
References: <20181129140109.832117862@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b3681dd548d06deb2e1573890829dff4b15abf46 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/entry/entry_64.S | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index b569b46660fc..375ed605c83d 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -856,7 +856,7 @@ ENTRY(\sym)
 
 	call	\do_sym
 
-	jmp	error_exit			/* %ebx: no swapgs flag */
+	jmp	error_exit
 	.endif
 END(\sym)
 .endm
@@ -1118,7 +1118,6 @@ END(paranoid_exit)
 
 /*
  * Save all registers in pt_regs, and switch gs if needed.
- * Return: EBX=0: came from user mode; EBX=1: otherwise
  */
 ENTRY(error_entry)
 	cld
@@ -1131,7 +1130,6 @@ ENTRY(error_entry)
 	 * the kernel CR3 here.
 	 */
 	SWITCH_KERNEL_CR3
-	xorl	%ebx, %ebx
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
@@ -1165,7 +1163,6 @@ ENTRY(error_entry)
 	 * for these here too.
 	 */
 .Lerror_kernelspace:
-	incl	%ebx
 	leaq	native_irq_return_iret(%rip), %rcx
 	cmpq	%rcx, RIP+8(%rsp)
 	je	.Lerror_bad_iret
@@ -1196,28 +1193,19 @@ ENTRY(error_entry)
 
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
 
-- 
2.17.1



