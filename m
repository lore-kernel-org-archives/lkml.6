Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1393AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5EC206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbfBEOhT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 09:37:19 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:59670 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfBEOhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 09:37:17 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gr1qY-0007HX-Ve; Tue, 05 Feb 2019 15:37:11 +0100
Date:   Tue, 5 Feb 2019 15:37:10 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 05/22 v2] x86/fpu: Remove fpu->initialized usage in
 copy_fpstate_to_sigframe()
Message-ID: <20190205143710.ss555mymzgvt7oo2@linutronix.de>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-6-bigeasy@linutronix.de>
 <20190116193603.GK15409@zn.tnic>
 <20190116224037.xkfnevzkwrck5dtt@linutronix.de>
 <20190117122253.GC5023@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190117122253.GC5023@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With lazy-FPU support the (now named variable) ->initialized was set to true if
the CPU's FPU registers were holding the a valid state of the FPU registers for
the active process. If it was set to false then the FPU state was saved in
fpu->state and the FPU was deactivated.
With lazy-FPU gone, ->initialized is always true for user threads and kernel
threads never this function so ->initialized is always true in
copy_fpstate_to_sigframe().
The using_compacted_format() check is also a leftover from the lazy-FPU time.
In the `->initialized == false' case copy_to_user() would copy the compacted
buffer while userland would expect the non-compacted format instead. So in
order to save the FPU state in the non-compacted form it issues the xsave
opcode to save the *current* FPU state.
The FPU is not enabled so the attempt raises the FPU trap, the trap restores
the FPU content and re-enables the FPU and the xsave opcode is invoked again and
succeeds. *This* does not longer work since commit

  bef8b6da9522 ("x86/fpu: Handle #NM without FPU emulation as an error")

Remove check for ->initialized because it is always true and remove the
false condition. Update the comment to reflect that the "state is always live".

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1…v2: rewrite the patch description.

 arch/x86/kernel/fpu/signal.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

Index: staging/arch/x86/kernel/fpu/signal.c
===================================================================
--- staging.orig/arch/x86/kernel/fpu/signal.c
+++ staging/arch/x86/kernel/fpu/signal.c
@@ -144,9 +144,8 @@ static inline int copy_fpregs_to_sigfram
  *	buf == buf_fx for 64-bit frames and 32-bit fsave frame.
  *	buf != buf_fx for 32-bit frames with fxstate.
  *
- * If the fpu, extended register state is live, save the state directly
- * to the user frame pointed by the aligned pointer 'buf_fx'. Otherwise,
- * copy the thread's fpu state to the user frame starting at 'buf_fx'.
+ * Save the state directly to the user frame pointed by the aligned pointer
+ * 'buf_fx'.
  *
  * If this is a 32-bit frame with fxstate, put a fsave header before
  * the aligned state at 'buf_fx'.
@@ -157,7 +156,6 @@ static inline int copy_fpregs_to_sigfram
 int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 {
 	struct fpu *fpu = &current->thread.fpu;
-	struct xregs_state *xsave = &fpu->state.xsave;
 	struct task_struct *tsk = current;
 	int ia32_fxstate = (buf != buf_fx);
 
@@ -172,29 +170,12 @@ int copy_fpstate_to_sigframe(void __user
 			sizeof(struct user_i387_ia32_struct), NULL,
 			(struct _fpstate_32 __user *) buf) ? -1 : 1;
 
-	if (fpu->initialized || using_compacted_format()) {
-		/* Save the live register state to the user directly. */
-		if (copy_fpregs_to_sigframe(buf_fx))
-			return -1;
-		/* Update the thread's fxstate to save the fsave header. */
-		if (ia32_fxstate)
-			copy_fxregs_to_kernel(fpu);
-	} else {
-		/*
-		 * It is a *bug* if kernel uses compacted-format for xsave
-		 * area and we copy it out directly to a signal frame. It
-		 * should have been handled above by saving the registers
-		 * directly.
-		 */
-		if (boot_cpu_has(X86_FEATURE_XSAVES)) {
-			WARN_ONCE(1, "x86/fpu: saving compacted-format xsave area to a signal frame!\n");
-			return -1;
-		}
-
-		fpstate_sanitize_xstate(fpu);
-		if (__copy_to_user(buf_fx, xsave, fpu_user_xstate_size))
-			return -1;
-	}
+	/* Save the live register state to the user directly. */
+	if (copy_fpregs_to_sigframe(buf_fx))
+		return -1;
+	/* Update the thread's fxstate to save the fsave header. */
+	if (ia32_fxstate)
+		copy_fxregs_to_kernel(fpu);
 
 	/* Save the fsave header for the 32-bit frames. */
 	if ((ia32_fxstate || !use_fxsr()) && save_fsave_header(tsk, buf))
