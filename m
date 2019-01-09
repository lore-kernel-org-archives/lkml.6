Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04703C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C550D2177B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731211AbfAILtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:49:15 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:56260 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731128AbfAILsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:48:53 -0500
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ghCLl-0007Al-Mc; Wed, 09 Jan 2019 12:48:46 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 20/22] x86/fpu: Let __fpu__restore_sig() restore the !32bit+fxsr frame from kernel memory
Date:   Wed,  9 Jan 2019 12:47:42 +0100
Message-Id: <20190109114744.10936-21-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109114744.10936-1-bigeasy@linutronix.de>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The !32bit+fxsr case loads the new state from user memory. In case we
restore the FPU state on return to userland we can't do this. It would
be required to disable preemption in order to avoid a context switch
which would set TIF_NEED_FPU_LOAD. If this happens before the "restore"
operation then the loaded registers would become volatile.

Disabling preemption while accessing user memory requires to disable the
pagefault handler. An error during XRSTOR would then mean that either a
page fault occured (and we have to retry with enabled page fault
handler) or a #GP occured because the xstate is bogus (after all the
sig-handler can modify it).

In order to avoid that mess, copy the FPU state from userland, validate
it and then load it. The copy_users_…() helper are basically the old
helper except that they operate on kernel memory and the fault handler
just sets the error value and the caller handles it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/include/asm/fpu/internal.h | 32 ++++++++++-----
 arch/x86/kernel/fpu/signal.c        | 62 +++++++++++++++++++++++------
 2 files changed, 71 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 16ea30235b025..672e51bc0e9b5 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -120,6 +120,21 @@ extern void fpstate_sanitize_xstate(struct fpu *fpu);
 	err;								\
 })
 
+#define kernel_insn_norestore(insn, output, input...)			\
+({									\
+	int err;							\
+	asm volatile("1:" #insn "\n\t"					\
+		     "2:\n"						\
+		     ".section .fixup,\"ax\"\n"				\
+		     "3:  movl $-1,%[err]\n"				\
+		     "    jmp  2b\n"					\
+		     ".previous\n"					\
+		     _ASM_EXTABLE(1b, 3b)				\
+		     : [err] "=r" (err), output				\
+		     : "0"(0), input);					\
+	err;								\
+})
+
 #define kernel_insn(insn, output, input...)				\
 	asm volatile("1:" #insn "\n\t"					\
 		     "2:\n"						\
@@ -140,15 +155,15 @@ static inline void copy_kernel_to_fxregs(struct fxregs_state *fx)
 	}
 }
 
-static inline int copy_user_to_fxregs(struct fxregs_state __user *fx)
+static inline int copy_users_to_fxregs(struct fxregs_state *fx)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
-		return user_insn(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
+		return kernel_insn_norestore(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 	else if (IS_ENABLED(CONFIG_AS_FXSAVEQ))
-		return user_insn(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
+		return kernel_insn_norestore(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
 
 	/* See comment in copy_fxregs_to_kernel() below. */
-	return user_insn(rex64/fxrstor (%[fx]), "=m" (*fx), [fx] "R" (fx),
+	return kernel_insn_norestore(rex64/fxrstor (%[fx]), "=m" (*fx), [fx] "R" (fx),
 			  "m" (*fx));
 }
 
@@ -157,9 +172,9 @@ static inline void copy_kernel_to_fregs(struct fregs_state *fx)
 	kernel_insn(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
-static inline int copy_user_to_fregs(struct fregs_state __user *fx)
+static inline int copy_users_to_fregs(struct fregs_state *fx)
 {
-	return user_insn(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
+	return kernel_insn_norestore(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
 static inline void copy_fxregs_to_kernel(struct fpu *fpu)
@@ -339,16 +354,13 @@ static inline void copy_kernel_to_xregs(struct xregs_state *xstate, u64 mask)
 /*
  * Restore xstate from user space xsave area.
  */
-static inline int copy_user_to_xregs(struct xregs_state __user *buf, u64 mask)
+static inline int copy_users_to_xregs(struct xregs_state *xstate, u64 mask)
 {
-	struct xregs_state *xstate = ((__force struct xregs_state *)buf);
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 	int err;
 
-	stac();
 	XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
-	clac();
 
 	return err;
 }
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 970091fb011e9..4ed5c400cac58 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -217,7 +217,8 @@ sanitize_restored_xstate(union fpregs_state *state,
 		 */
 		xsave->i387.mxcsr &= mxcsr_feature_mask;
 
-		convert_to_fxsr(&state->fxsave, ia32_env);
+		if (ia32_env)
+			convert_to_fxsr(&state->fxsave, ia32_env);
 	}
 }
 
@@ -299,28 +300,63 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		kfree(tmp);
 		return err;
 	} else {
+		union fpregs_state *state;
+		void *tmp;
 		int ret;
 
+		tmp = kzalloc(sizeof(*state) + fpu_kernel_xstate_size + 64, GFP_KERNEL);
+		if (!tmp)
+			return -ENOMEM;
+		state = PTR_ALIGN(tmp, 64);
+
 		/*
 		 * For 64-bit frames and 32-bit fsave frames, restore the user
 		 * state to the registers directly (with exceptions handled).
 		 */
-		if (use_xsave()) {
-			if ((unsigned long)buf_fx % 64 || fx_only) {
+		if ((unsigned long)buf_fx % 64)
+			fx_only = 1;
+
+		if (use_xsave() && !fx_only) {
+			u64 init_bv = xfeatures_mask & ~xfeatures;
+
+			if (using_compacted_format()) {
+				ret = copy_user_to_xstate(&state->xsave, buf_fx);
+			} else {
+				ret = __copy_from_user(&state->xsave, buf_fx, state_size);
+
+				if (!ret && state_size > offsetof(struct xregs_state, header))
+					ret = validate_xstate_header(&state->xsave.header);
+			}
+			if (ret)
+				goto err_out;
+			sanitize_restored_xstate(state, NULL, xfeatures,
+						 fx_only);
+
+			if (unlikely(init_bv))
+				copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
+			ret = copy_users_to_xregs(&state->xsave, xfeatures);
+
+		} else if (use_fxsr()) {
+			ret = __copy_from_user(&state->fxsave, buf_fx, state_size);
+			if (ret)
+				goto err_out;
+
+			if (use_xsave()) {
 				u64 init_bv = xfeatures_mask & ~XFEATURE_MASK_FPSSE;
 				copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
-				ret = copy_user_to_fxregs(buf_fx);
-			} else {
-				u64 init_bv = xfeatures_mask & ~xfeatures;
-				if (unlikely(init_bv))
-					copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
-				ret = copy_user_to_xregs(buf_fx, xfeatures);
 			}
-		} else if (use_fxsr()) {
-			ret = copy_user_to_fxregs(buf_fx);
-		} else
-			ret = copy_user_to_fregs(buf_fx);
+			state->fxsave.mxcsr &= mxcsr_feature_mask;
 
+			ret = copy_users_to_fxregs(&state->fxsave);
+		} else {
+			ret = __copy_from_user(&state->fsave, buf_fx, state_size);
+			if (ret)
+				goto err_out;
+			ret = copy_users_to_fregs(buf_fx);
+		}
+
+err_out:
+		kfree(tmp);
 		if (ret) {
 			fpu__clear(fpu);
 			return -1;
-- 
2.20.1

