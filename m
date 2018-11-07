Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C67C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC7A20837
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC7A20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbeKHFVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:21:22 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:41964 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbeKHFVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:21:21 -0500
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gKTpN-00070Q-Jo; Wed, 07 Nov 2018 20:49:25 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 19/23] x86/fpu: Always store the registers in copy_fpstate_to_sigframe()
Date:   Wed,  7 Nov 2018 20:48:54 +0100
Message-Id: <20181107194858.9380-20-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181107194858.9380-1-bigeasy@linutronix.de>
References: <20181107194858.9380-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rik van Riel <riel@surriel.com>

copy_fpstate_to_sigframe() stores the registers directly to user space.
This is okay because the FPU register are valid and saving it directly
avoids saving it into kernel memory and making a copy.
However… We can't keep doing this if we are going to restore the FPU
registers on the return to userland. It is possible that the FPU
registers will be invalidated in the middle of the save operation and
this should be done with disabled preemption / BH.

Save the FPU registers to task's FPU struct and copy them to the user
memory.  later on.

This code is extracted from an earlier version of the patchset while
there still was lazy-FPU on x86.

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/include/asm/fpu/internal.h | 45 -----------------------------
 arch/x86/kernel/fpu/signal.c        | 30 +++++++------------
 2 files changed, 11 insertions(+), 64 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index ed65e0642a1e1..9e213a6703c84 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -123,22 +123,6 @@ extern void fpstate_sanitize_xstate(struct fpu *fpu);
 		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_fprestore)	\
 		     : output : input)
 
-static inline int copy_fregs_to_user(struct fregs_state __user *fx)
-{
-	return user_insn(fnsave %[fx]; fwait,  [fx] "=m" (*fx), "m" (*fx));
-}
-
-static inline int copy_fxregs_to_user(struct fxregs_state __user *fx)
-{
-	if (IS_ENABLED(CONFIG_X86_32))
-		return user_insn(fxsave %[fx], [fx] "=m" (*fx), "m" (*fx));
-	else if (IS_ENABLED(CONFIG_AS_FXSAVEQ))
-		return user_insn(fxsaveq %[fx], [fx] "=m" (*fx), "m" (*fx));
-
-	/* See comment in copy_fxregs_to_kernel() below. */
-	return user_insn(rex64/fxsave (%[fx]), "=m" (*fx), [fx] "R" (fx));
-}
-
 static inline void copy_kernel_to_fxregs(struct fxregs_state *fx)
 {
 	if (IS_ENABLED(CONFIG_X86_32)) {
@@ -349,35 +333,6 @@ static inline void copy_kernel_to_xregs(struct xregs_state *xstate, u64 mask)
 	XSTATE_XRESTORE(xstate, lmask, hmask);
 }
 
-/*
- * Save xstate to user space xsave area.
- *
- * We don't use modified optimization because xrstor/xrstors might track
- * a different application.
- *
- * We don't use compacted format xsave area for
- * backward compatibility for old applications which don't understand
- * compacted format of xsave area.
- */
-static inline int copy_xregs_to_user(struct xregs_state __user *buf)
-{
-	int err;
-
-	/*
-	 * Clear the xsave header first, so that reserved fields are
-	 * initialized to zero.
-	 */
-	err = __clear_user(&buf->header, sizeof(buf->header));
-	if (unlikely(err))
-		return -EFAULT;
-
-	stac();
-	XSTATE_OP(XSAVE, buf, -1, -1, err);
-	clac();
-
-	return err;
-}
-
 /*
  * Restore xstate from user space xsave area.
  */
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index f61f4d804537a..254a8dff9cd82 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -118,22 +118,6 @@ static inline int save_xstate_epilog(void __user *buf, int ia32_frame)
 	return err;
 }
 
-static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
-{
-	int err;
-
-	if (use_xsave())
-		err = copy_xregs_to_user(buf);
-	else if (use_fxsr())
-		err = copy_fxregs_to_user((struct fxregs_state __user *) buf);
-	else
-		err = copy_fregs_to_user((struct fregs_state __user *) buf);
-
-	if (unlikely(err) && __clear_user(buf, fpu_user_xstate_size))
-		err = -EFAULT;
-	return err;
-}
-
 /*
  * Save the fpu, extended register state to the user signal frame.
  *
@@ -157,6 +141,7 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
 int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 {
 	struct fpu *fpu = &current->thread.fpu;
+	struct xregs_state *xsave = &fpu->state.xsave;
 	struct task_struct *tsk = current;
 	int ia32_fxstate = (buf != buf_fx);
 
@@ -171,12 +156,19 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 			sizeof(struct user_i387_ia32_struct), NULL,
 			(struct _fpstate_32 __user *) buf) ? -1 : 1;
 
-	/* Save the live register state to the user directly. */
-	if (copy_fpregs_to_sigframe(buf_fx))
-		return -1;
 	/* Update the thread's fxstate to save the fsave header. */
 	if (ia32_fxstate)
 		copy_fxregs_to_kernel(fpu);
+	else
+		copy_fpregs_to_fpstate(fpu);
+
+	if (using_compacted_format()) {
+		copy_xstate_to_user(buf_fx, xsave, 0, size);
+	} else {
+		fpstate_sanitize_xstate(fpu);
+		if (__copy_to_user(buf_fx, xsave, fpu_user_xstate_size))
+			return -1;
+	}
 
 	/* Save the fsave header for the 32-bit frames. */
 	if ((ia32_fxstate || !use_fxsr()) && save_fsave_header(tsk, buf))
-- 
2.19.1

