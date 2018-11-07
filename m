Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CDDC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3967F20837
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3967F20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbeKHFVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:21:25 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:41990 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbeKHFVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:21:24 -0500
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gKTpR-00070Q-7K; Wed, 07 Nov 2018 20:49:29 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 22/23] x86/fpu: Don't restore the FPU state directly from userland in __fpu__restore_sig()
Date:   Wed,  7 Nov 2018 20:48:57 +0100
Message-Id: <20181107194858.9380-23-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181107194858.9380-1-bigeasy@linutronix.de>
References: <20181107194858.9380-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__fpu__restore_sig() restores the CPU's FPU state directly from
userland. If we restore registers on return to userland then we can't
load them directly from userland because a context switch/BH could
destroy them.

Restore the FPU registers after they have been copied from userland.
__fpregs_changes_begin() ensures that they are not modified while beeing
worked on. TIF_NEED_FPU_LOAD is clreared we want to keep our state, not
the saved state.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/include/asm/fpu/internal.h | 34 -----------------------------
 arch/x86/kernel/fpu/signal.c        | 33 ++++++++++++++++++----------
 2 files changed, 22 insertions(+), 45 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 9e213a6703c84..5e86ff60a3a5c 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -137,28 +137,11 @@ static inline void copy_kernel_to_fxregs(struct fxregs_state *fx)
 	}
 }
 
-static inline int copy_user_to_fxregs(struct fxregs_state __user *fx)
-{
-	if (IS_ENABLED(CONFIG_X86_32))
-		return user_insn(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
-	else if (IS_ENABLED(CONFIG_AS_FXSAVEQ))
-		return user_insn(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
-
-	/* See comment in copy_fxregs_to_kernel() below. */
-	return user_insn(rex64/fxrstor (%[fx]), "=m" (*fx), [fx] "R" (fx),
-			  "m" (*fx));
-}
-
 static inline void copy_kernel_to_fregs(struct fregs_state *fx)
 {
 	kernel_insn(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
-static inline int copy_user_to_fregs(struct fregs_state __user *fx)
-{
-	return user_insn(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
-}
-
 static inline void copy_fxregs_to_kernel(struct fpu *fpu)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
@@ -333,23 +316,6 @@ static inline void copy_kernel_to_xregs(struct xregs_state *xstate, u64 mask)
 	XSTATE_XRESTORE(xstate, lmask, hmask);
 }
 
-/*
- * Restore xstate from user space xsave area.
- */
-static inline int copy_user_to_xregs(struct xregs_state __user *buf, u64 mask)
-{
-	struct xregs_state *xstate = ((__force struct xregs_state *)buf);
-	u32 lmask = mask;
-	u32 hmask = mask >> 32;
-	int err;
-
-	stac();
-	XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
-	clac();
-
-	return err;
-}
-
 /*
  * These must be called with preempt disabled. Returns
  * 'true' if the FPU state is still intact and we can
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 179e2b19976ad..9720529859483 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -228,23 +228,30 @@ sanitize_restored_xstate(union fpregs_state *state,
 /*
  * Restore the extended state if present. Otherwise, restore the FP/SSE state.
  */
-static inline int copy_user_to_fpregs_zeroing(void __user *buf, u64 xbv, int fx_only)
+static void copy_to_fpregs_zeroing(struct fpu *fpu, u64 xbv, int fx_only)
 {
+	__fpregs_changes_begin();
 	if (use_xsave()) {
-		if ((unsigned long)buf % 64 || fx_only) {
+		if (fx_only) {
 			u64 init_bv = xfeatures_mask & ~XFEATURE_MASK_FPSSE;
+
 			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
-			return copy_user_to_fxregs(buf);
+			copy_kernel_to_fxregs(&fpu->state.fxsave);
 		} else {
 			u64 init_bv = xfeatures_mask & ~xbv;
+
 			if (unlikely(init_bv))
 				copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
-			return copy_user_to_xregs(buf, xbv);
+			copy_kernel_to_xregs(&fpu->state.xsave, xbv);
 		}
 	} else if (use_fxsr()) {
-		return copy_user_to_fxregs(buf);
-	} else
-		return copy_user_to_fregs(buf);
+		copy_kernel_to_fxregs(&fpu->state.fxsave);
+	} else {
+		copy_kernel_to_fregs(&fpu->state.fsave);
+	}
+	clear_thread_flag(TIF_NEED_FPU_LOAD);
+	fpregs_activate(fpu);
+	__fpregs_changes_end();
 }
 
 static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
@@ -255,6 +262,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 	int state_size = fpu_kernel_xstate_size;
 	u64 xfeatures = 0;
 	int fx_only = 0;
+	int err = 0;
 
 	ia32_fxstate &= (IS_ENABLED(CONFIG_X86_32) ||
 			 IS_ENABLED(CONFIG_IA32_EMULATION));
@@ -298,7 +306,6 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		union fpregs_state *state;
 		void *tmp;
 		struct user_i387_ia32_struct env;
-		int err = 0;
 
 		tmp = kmalloc(sizeof(*state) + fpu_kernel_xstate_size + 64, GFP_KERNEL);
 		if (!tmp)
@@ -327,12 +334,16 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 	} else {
 		/*
 		 * For 64-bit frames and 32-bit fsave frames, restore the user
-		 * state to the registers directly (with exceptions handled).
+		 * state from a copy in thread's fpu state.
 		 */
-		if (copy_user_to_fpregs_zeroing(buf_fx, xfeatures, fx_only)) {
+		err = __copy_from_user(&fpu->state.xsave, buf_fx, state_size);
+		if (err) {
 			fpu__clear(fpu);
-			return -1;
+			return -EFAULT;
 		}
+		if ((unsigned long)buf_fx % 64)
+			fx_only = 1;
+		copy_to_fpregs_zeroing(fpu, xfeatures, fx_only);
 	}
 
 	return 0;
-- 
2.19.1

