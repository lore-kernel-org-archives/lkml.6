Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C01C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56ED52087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56ED52087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbeJDU7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:59:38 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36314 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbeJDU7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:59:37 -0400
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g84GT-0002ic-Jv; Thu, 04 Oct 2018 16:06:05 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 08/11] x86/fpu: Always store the registers in copy_fpstate_to_sigframe()
Date:   Thu,  4 Oct 2018 16:05:44 +0200
Message-Id: <20181004140547.13014-9-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181004140547.13014-1-bigeasy@linutronix.de>
References: <20181004140547.13014-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rik van Riel <riel@surriel.com>

copy_fpstate_to_sigframe() has two callers and both invoke the function only if
fpu->initialized is set. So the check in the function for ->initialized makes
no sense. It might be a relict from the lazy-FPU time: If the FPU registers
were "loaded" then we could save them directly. Otherwise (the FPU
registers are not up to date) they are saved in the FPU struct and
it could be used for memcpy().

Since the registers always loaded at this point, save them and copy
later.
This code is extracted from an earlier version of the patchset while
there still was lazy-FPU on x86. This is a preparation for loading the
FPU registers on return to userland.

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/include/asm/fpu/internal.h | 45 ----------------------------
 arch/x86/kernel/fpu/signal.c        | 46 +++++++----------------------
 2 files changed, 11 insertions(+), 80 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 4ecaf4d22954e..df8816be3efdd 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -126,22 +126,6 @@ extern void fpstate_sanitize_xstate(struct fpu *fpu);
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
@@ -352,35 +336,6 @@ static inline void copy_kernel_to_xregs(struct xregs_state *xstate, u64 mask)
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
index 23f1691670b66..c8f5ff58578ed 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -117,23 +117,6 @@ static inline int save_xstate_epilog(void __user *buf, int ia32_frame)
 
 	return err;
 }
-
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
@@ -172,27 +155,20 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 			sizeof(struct user_i387_ia32_struct), NULL,
 			(struct _fpstate_32 __user *) buf) ? -1 : 1;
 
-	if (fpu->initialized || using_compacted_format()) {
-		/* Save the live register state to the user directly. */
-		if (copy_fpregs_to_sigframe(buf_fx))
-			return -1;
-		/* Update the thread's fxstate to save the fsave header. */
-		if (ia32_fxstate)
-			copy_fxregs_to_kernel(fpu);
+	/* Update the thread's fxstate to save the fsave header. */
+	if (ia32_fxstate) {
+		copy_fxregs_to_kernel(fpu);
 	} else {
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
+		copy_fpregs_to_fpstate(fpu);
+		fpregs_deactivate(fpu);
+	}
 
+	if (using_compacted_format()) {
+		copy_xstate_to_user(buf_fx, xsave, 0, size);
+	} else {
 		fpstate_sanitize_xstate(fpu);
-		if (__copy_to_user(buf_fx, xsave, fpu_user_xstate_size))
+		size = fpu_user_xstate_size;
+		if (__copy_to_user(buf_fx, xsave, size))
 			return -1;
 	}
 
-- 
2.19.0

