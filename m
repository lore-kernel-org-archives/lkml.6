Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF80C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C8A2173B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbfAILs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:48:57 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:56265 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731150AbfAILsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:48:55 -0500
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ghCLo-0007Al-B5; Wed, 09 Jan 2019 12:48:48 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 21/22] x86/fpu: Merge the two code paths in __fpu__restore_sig()
Date:   Wed,  9 Jan 2019 12:47:43 +0100
Message-Id: <20190109114744.10936-22-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109114744.10936-1-bigeasy@linutronix.de>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ia32_fxstate case (32bit with fxsr) and the other (64bit, 32bit
without fxsr) restore both from kernel memory and sanitize the content.
The !ia32_fxstate version restores missing xstates from "init state"
while the ia32_fxstate doesn't and skips it.

Merge the two code paths and keep the !ia32_fxstate version. Copy only
the user_i387_ia32_struct data structure in the ia32_fxstate.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/fpu/signal.c | 162 ++++++++++++++---------------------
 1 file changed, 65 insertions(+), 97 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 4ed5c400cac58..a17e75fa1a0a6 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -224,12 +224,17 @@ sanitize_restored_xstate(union fpregs_state *state,
 
 static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 {
+	struct user_i387_ia32_struct *envp = NULL;
 	int ia32_fxstate = (buf != buf_fx);
 	struct task_struct *tsk = current;
 	struct fpu *fpu = &tsk->thread.fpu;
 	int state_size = fpu_kernel_xstate_size;
+	struct user_i387_ia32_struct env;
+	union fpregs_state *state;
 	u64 xfeatures = 0;
 	int fx_only = 0;
+	int ret = 0;
+	void *tmp;
 
 	ia32_fxstate &= (IS_ENABLED(CONFIG_X86_32) ||
 			 IS_ENABLED(CONFIG_IA32_EMULATION));
@@ -264,106 +269,69 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		}
 	}
 
+	tmp = kzalloc(sizeof(*state) + fpu_kernel_xstate_size + 64, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+	state = PTR_ALIGN(tmp, 64);
+
+	if ((unsigned long)buf_fx % 64)
+		fx_only = 1;
+
+	/*
+	 * For 32-bit frames with fxstate, copy the fxstate so it can be
+	 * reconstructed later.
+	 */
 	if (ia32_fxstate) {
-		/*
-		 * For 32-bit frames with fxstate, copy the user state to the
-		 * thread's fpu state, reconstruct fxstate from the fsave
-		 * header. Validate and sanitize the copied state.
-		 */
-		struct user_i387_ia32_struct env;
-		union fpregs_state *state;
-		int err = 0;
-		void *tmp;
-
-		tmp = kzalloc(sizeof(*state) + fpu_kernel_xstate_size + 64, GFP_KERNEL);
-		if (!tmp)
-			return -ENOMEM;
-		state = PTR_ALIGN(tmp, 64);
-
-		if (using_compacted_format()) {
-			err = copy_user_to_xstate(&state->xsave, buf_fx);
-		} else {
-			err = __copy_from_user(&state->xsave, buf_fx, state_size);
-
-			if (!err && state_size > offsetof(struct xregs_state, header))
-				err = validate_xstate_header(&state->xsave.header);
-		}
-
-		if (err || __copy_from_user(&env, buf, sizeof(env))) {
-			err = -1;
-		} else {
-			sanitize_restored_xstate(state, &env,
-						 xfeatures, fx_only);
-			copy_kernel_to_fpregs(state);
-		}
-
-		kfree(tmp);
-		return err;
-	} else {
-		union fpregs_state *state;
-		void *tmp;
-		int ret;
-
-		tmp = kzalloc(sizeof(*state) + fpu_kernel_xstate_size + 64, GFP_KERNEL);
-		if (!tmp)
-			return -ENOMEM;
-		state = PTR_ALIGN(tmp, 64);
-
-		/*
-		 * For 64-bit frames and 32-bit fsave frames, restore the user
-		 * state to the registers directly (with exceptions handled).
-		 */
-		if ((unsigned long)buf_fx % 64)
-			fx_only = 1;
-
-		if (use_xsave() && !fx_only) {
-			u64 init_bv = xfeatures_mask & ~xfeatures;
-
-			if (using_compacted_format()) {
-				ret = copy_user_to_xstate(&state->xsave, buf_fx);
-			} else {
-				ret = __copy_from_user(&state->xsave, buf_fx, state_size);
-
-				if (!ret && state_size > offsetof(struct xregs_state, header))
-					ret = validate_xstate_header(&state->xsave.header);
-			}
-			if (ret)
-				goto err_out;
-			sanitize_restored_xstate(state, NULL, xfeatures,
-						 fx_only);
-
-			if (unlikely(init_bv))
-				copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
-			ret = copy_users_to_xregs(&state->xsave, xfeatures);
-
-		} else if (use_fxsr()) {
-			ret = __copy_from_user(&state->fxsave, buf_fx, state_size);
-			if (ret)
-				goto err_out;
-
-			if (use_xsave()) {
-				u64 init_bv = xfeatures_mask & ~XFEATURE_MASK_FPSSE;
-				copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
-			}
-			state->fxsave.mxcsr &= mxcsr_feature_mask;
-
-			ret = copy_users_to_fxregs(&state->fxsave);
-		} else {
-			ret = __copy_from_user(&state->fsave, buf_fx, state_size);
-			if (ret)
-				goto err_out;
-			ret = copy_users_to_fregs(buf_fx);
-		}
-
-err_out:
-		kfree(tmp);
-		if (ret) {
-			fpu__clear(fpu);
-			return -1;
-		}
+		ret = __copy_from_user(&env, buf, sizeof(env));
+		if (ret)
+			goto err_out;
+		envp = &env;
 	}
 
-	return 0;
+	if (use_xsave() && !fx_only) {
+		u64 init_bv = xfeatures_mask & ~xfeatures;
+
+		if (using_compacted_format()) {
+			ret = copy_user_to_xstate(&state->xsave, buf_fx);
+		} else {
+			ret = __copy_from_user(&state->xsave, buf_fx, state_size);
+
+			if (!ret && state_size > offsetof(struct xregs_state, header))
+				ret = validate_xstate_header(&state->xsave.header);
+		}
+		if (ret)
+			goto err_out;
+
+		sanitize_restored_xstate(state, envp, xfeatures, fx_only);
+
+		if (unlikely(init_bv))
+			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
+		ret = copy_users_to_xregs(&state->xsave, xfeatures);
+
+	} else if (use_fxsr()) {
+		ret = __copy_from_user(&state->fxsave, buf_fx, state_size);
+		if (ret)
+			goto err_out;
+
+		sanitize_restored_xstate(state, envp, xfeatures, fx_only);
+		if (use_xsave()) {
+			u64 init_bv = xfeatures_mask & ~XFEATURE_MASK_FPSSE;
+			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
+		}
+
+		ret = copy_users_to_fxregs(&state->fxsave);
+	} else {
+		ret = __copy_from_user(&state->fsave, buf_fx, state_size);
+		if (ret)
+			goto err_out;
+		ret = copy_users_to_fregs(buf_fx);
+	}
+
+err_out:
+	kfree(tmp);
+	if (ret)
+		fpu__clear(fpu);
+	return ret;
 }
 
 static inline int xstate_sigframe_size(void)
-- 
2.20.1

