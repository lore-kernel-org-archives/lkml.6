Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45719C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0232920856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0232920856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388399AbeGXQLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:11:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59375 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388308AbeGXQLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:11:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6OF321B032444
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 24 Jul 2018 08:03:02 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6OF31Fg032312;
        Tue, 24 Jul 2018 08:03:01 -0700
Date:   Tue, 24 Jul 2018 08:03:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-b3681dd548d06deb2e1573890829dff4b15abf46@git.kernel.org>
Cc:     gregkh@linuxfoundation.org, jgross@suse.com, mingo@kernel.org,
        luto@kernel.org, tglx@linutronix.de, linux@dominikbrodowski.net,
        torvalds@linux-foundation.org, jpoimboe@redhat.com,
        boris.ostrovsky@oracle.com, peterz@infradead.org, hpa@zytor.com,
        bp@alien8.de, linux-kernel@vger.kernel.org,
        dave.hansen@linux.intel.com, brgerst@gmail.com,
        dvlasenk@redhat.com, m.v.b@runbox.com
Reply-To: tglx@linutronix.de, luto@kernel.org, linux@dominikbrodowski.net,
          torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
          jgross@suse.com, mingo@kernel.org, dave.hansen@linux.intel.com,
          linux-kernel@vger.kernel.org, brgerst@gmail.com,
          dvlasenk@redhat.com, m.v.b@runbox.com,
          boris.ostrovsky@oracle.com, jpoimboe@redhat.com,
          peterz@infradead.org, bp@alien8.de, hpa@zytor.com
In-Reply-To: <b5010a090d3586b2d6e06c7ad3ec5542d1241c45.1532282627.git.luto@kernel.org>
References: <b5010a090d3586b2d6e06c7ad3ec5542d1241c45.1532282627.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/entry/64: Remove %ebx handling from
 error_entry/exit
Git-Commit-ID: b3681dd548d06deb2e1573890829dff4b15abf46
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

Commit-ID:  b3681dd548d06deb2e1573890829dff4b15abf46
Gitweb:     https://git.kernel.org/tip/b3681dd548d06deb2e1573890829dff4b15abf46
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Sun, 22 Jul 2018 11:05:09 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 24 Jul 2018 10:07:36 +0200

x86/entry/64: Remove %ebx handling from error_entry/exit

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
---
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
 
