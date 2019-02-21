Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BACBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5706420880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfBULxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:53:30 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45611 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbfBULuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:50:40 -0500
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gwms5-0001RC-Px; Thu, 21 Feb 2019 12:50:33 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 06/22] x86/fpu: Don't save fxregs for ia32 frames in copy_fpstate_to_sigframe()
Date:   Thu, 21 Feb 2019 12:50:04 +0100
Message-Id: <20190221115020.12385-7-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221115020.12385-1-bigeasy@linutronix.de>
References: <20190221115020.12385-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
 arch/x86/kernel/fpu/signal.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index de83d0ed9e14e..2f044021fde2b 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -155,7 +155,6 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
  */
 int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 {
-	struct fpu *fpu = &current->thread.fpu;
 	struct task_struct *tsk = current;
 	int ia32_fxstate = (buf != buf_fx);
 
@@ -173,9 +172,6 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 	/* Save the live register state to the user directly. */
 	if (copy_fpregs_to_sigframe(buf_fx))
 		return -1;
-	/* Update the thread's fxstate to save the fsave header. */
-	if (ia32_fxstate)
-		copy_fxregs_to_kernel(fpu);
 
 	/* Save the fsave header for the 32-bit frames. */
 	if ((ia32_fxstate || !use_fxsr()) && save_fsave_header(tsk, buf))
-- 
2.20.1

