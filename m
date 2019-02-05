Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998E4C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4F42080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbfBEQnv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:43:51 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:60884 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbfBEQnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 11:43:50 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gr3p1-00022A-KX; Tue, 05 Feb 2019 17:43:43 +0100
Date:   Tue, 5 Feb 2019 17:43:43 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 06/22 v2] x86/fpu: Don't save fxregs for ia32 frames in
Message-ID: <20190205164343.6gdllvtgmw45mpdk@linutronix.de>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-7-bigeasy@linutronix.de>
 <20190124111714.GA11554@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190124111714.GA11554@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 

  72a671ced66db ("x86, fpu: Unify signal handling code paths for x86 and x86_64 kernels")

the 32bit and 64bit path of the signal delivery code were merged. The 32bit version:
|int save_i387_xstate_ia32(void __user *buf)
|…
|       if (cpu_has_xsave)
|               return save_i387_xsave(fp);
|       if (cpu_has_fxsr)
|               return save_i387_fxsave(fp);

The 64bit version:
|int save_i387_xstate(void __user *buf)
|…
|       if (user_has_fpu()) {
|               if (use_xsave())
|                       err = xsave_user(buf);
|               else
|                       err = fxsave_user(buf);
|
|               if (unlikely(err)) {
|                       __clear_user(buf, xstate_size);
|                       return err;

The merge:
|int save_xstate_sig(void __user *buf, void __user *buf_fx, int size)
|…
|       if (user_has_fpu()) {
|               /* Save the live register state to the user directly. */
|               if (save_user_xstate(buf_fx))
|                       return -1;
|               /* Update the thread's fxstate to save the fsave header. */
|               if (ia32_fxstate)
|                       fpu_fxsave(&tsk->thread.fpu);

I don't think that we needed to save the FPU registers to ->thread.fpu because
the registers were stored in `buf_fx'. Today the state will be restored from
`buf_fx' after the signal was handled (I assume that this was also the case
with lazy-FPU). Since commit

  66463db4fc560 ("x86, fpu: shift drop_init_fpu() from save_xstate_sig() to handle_signal()")

it is ensured that the signal handler starts with clear/fresh set of FPU
registers which means that the previous store is futile.

Remove copy_fxregs_to_kernel() because task's FPU state is cleared later in
handle_signal() via fpu__clear().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1…v2:
 - reworte description. Replaced the "I don't know why it is like it is
   makes no sense buh" part with some pointer which might explain why
   copy_fxregs_to_kernel() ended there and since when it definitely is a
   nop.
 - removed `fpu' since it unused after that change.

 arch/x86/kernel/fpu/signal.c | 3 ---
 1 file changed, 3 deletions(-)

Index: staging/arch/x86/kernel/fpu/signal.c
===================================================================
--- staging.orig/arch/x86/kernel/fpu/signal.c
+++ staging/arch/x86/kernel/fpu/signal.c
@@ -155,7 +155,6 @@ static inline int copy_fpregs_to_sigfram
  */
 int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 {
-	struct fpu *fpu = &current->thread.fpu;
 	struct task_struct *tsk = current;
 	int ia32_fxstate = (buf != buf_fx);
 
@@ -173,9 +172,6 @@ int copy_fpstate_to_sigframe(void __user
 	/* Save the live register state to the user directly. */
 	if (copy_fpregs_to_sigframe(buf_fx))
 		return -1;
-	/* Update the thread's fxstate to save the fsave header. */
-	if (ia32_fxstate)
-		copy_fxregs_to_kernel(fpu);
 
 	/* Save the fsave header for the 32-bit frames. */
 	if ((ia32_fxstate || !use_fxsr()) && save_fsave_header(tsk, buf))
