Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16229C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 18:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B626C20875
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 18:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhO4fZPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B626C20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbeGVTCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 15:02:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730164AbeGVTCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 15:02:44 -0400
Received: from localhost (c-71-202-137-17.hsd1.ca.comcast.net [71.202.137.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18FD920671;
        Sun, 22 Jul 2018 18:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532282713;
        bh=/WiZDDrXEWQrr+MSos8UXm3GbJjiKNTPjXJzELxV3dQ=;
        h=From:To:Cc:Subject:Date:From;
        b=HhO4fZPmK/xuuEkdcm90f4KJ1Q0Nre5nbWZw/I0lpnAPfhfvwr5kKG3FYpIG6QUpK
         b2qjs51zLe4vcv3YFnOpCJY2VjyUpppovkyVNVauARZ4zdyYEdVs28t6sNPjA8HCdk
         Ivpe3VjURpzAatrPTCb8sXlwz90LjpN2ciyRnQTw=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, stable@vger.kernel.org
Subject: [PATCH] x86/entry/64: Remove %ebx handling from error_entry/exit
Date:   Sun, 22 Jul 2018 11:05:09 -0700
Message-Id: <b5010a090d3586b2d6e06c7ad3ec5542d1241c45.1532282627.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

error_entry and error_exit communicate the user vs kernel status of
the frame using %ebx.  This is unnecessary -- the information is in
regs->cs.  Just use regs->cs.

This makes error_entry simpler and makes error_exit more robust.

It also fixes a nasty bug.  Before all the Spectre nonsense, The
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

    commit 3ac6d8c787b8 ("x86/entry/64: Clear registers for
    exceptions/interrupts, to reduce speculation attack surface")

With this patch applied, RBX is no longer needed as a flag, and the
problem goes away.

I suspect that malicious userspace could use this bug to crash the
kernel even without the offending patch applied, though.

[Historical note: I wrote this patch as a cleanup before I was aware
 of the bug it fixed.]

[Note to stable maintainers: this should probably get applied to all
 kernels.  If you're nervous about that, a more conservative fix to
 add xorl %ebx,%ebx; incl %ebx before the jump to error_exit should
 also fix the problem.]

Cc: Brian Gerst <brgerst@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: xen-devel@lists.xenproject.org
Cc: x86@kernel.org
Cc: stable@vger.kernel.org
Fixes: 3ac6d8c787b8 ("x86/entry/64: Clear registers for exceptions/interrupts, to reduce speculation attack surface")
Reported-and-tested-by: "M. Vefa Bicakci" <m.v.b@runbox.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---

I could also submit the conservative fix tagged for -stable and respin
this on top of it.  Ingo, Greg, what do you prefer?

 arch/x86/entry/entry_64.S | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 73a522d53b53..8ae7ffda8f98 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -981,7 +981,7 @@ ENTRY(\sym)
 
 	call	\do_sym
 
-	jmp	error_exit			/* %ebx: no swapgs flag */
+	jmp	error_exit
 	.endif
 END(\sym)
 .endm
@@ -1222,7 +1222,6 @@ END(paranoid_exit)
 
 /*
  * Save all registers in pt_regs, and switch GS if needed.
- * Return: EBX=0: came from user mode; EBX=1: otherwise
  */
 ENTRY(error_entry)
 	UNWIND_HINT_FUNC
@@ -1269,7 +1268,6 @@ ENTRY(error_entry)
 	 * for these here too.
 	 */
 .Lerror_kernelspace:
-	incl	%ebx
 	leaq	native_irq_return_iret(%rip), %rcx
 	cmpq	%rcx, RIP+8(%rsp)
 	je	.Lerror_bad_iret
@@ -1303,28 +1301,20 @@ ENTRY(error_entry)
 
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
 	UNWIND_HINT_REGS
 	DISABLE_INTERRUPTS(CLBR_ANY)
 	TRACE_IRQS_OFF
-	testl	%ebx, %ebx
-	jnz	retint_kernel
+	testb	$3, CS(%rsp)
+	jz	retint_kernel
 	jmp	retint_user
 END(error_exit)
 
-- 
2.17.1

