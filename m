Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA6DC10F08
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F8D2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfBULus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:50:48 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45637 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbfBULum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:50:42 -0500
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gwms8-0001RC-C6; Thu, 21 Feb 2019 12:50:36 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH 08/22] x86/fpu: Remove user_fpu_begin()
Date:   Thu, 21 Feb 2019 12:50:06 +0100
Message-Id: <20190221115020.12385-9-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221115020.12385-1-bigeasy@linutronix.de>
References: <20190221115020.12385-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

user_fpu_begin() sets fpu_fpregs_owner_ctx to task's fpu struct. This is
always the case since there is no lazy FPU anymore.

fpu_fpregs_owner_ctx is used during context switch to decide if it needs
to load the saved registers or if the currently loaded registers are
valid. It could be skipped during
	taskA -> kernel thread -> taskA

because the switch to kernel thread would not alter the CPU's FPU state.

Since this field is always updated during context switch and never
invalidated, setting it manually (in user context) makes no difference.
A kernel thread with kernel_fpu_begin() block could set
fpu_fpregs_owner_ctx to NULL but a kernel thread does not use
user_fpu_begin().
This is a leftover from the lazy-FPU time.

Remove user_fpu_begin(), it does not change fpu_fpregs_owner_ctx's
content.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/fpu/internal.h | 17 -----------------
 arch/x86/kernel/fpu/core.c          |  4 +---
 arch/x86/kernel/fpu/signal.c        |  1 -
 3 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 973aab8c1f6f1..96835d04e9343 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -563,23 +563,6 @@ static inline void switch_fpu_finish(struct fpu *new_fpu, int cpu)
 	}
 }
 
-/*
- * Needs to be preemption-safe.
- *
- * NOTE! user_fpu_begin() must be used only immediately before restoring
- * the save state. It does not do any saving/restoring on its own. In
- * lazy FPU mode, it is just an optimization to avoid a #NM exception,
- * the task can lose the FPU right after preempt_enable().
- */
-static inline void user_fpu_begin(void)
-{
-	struct fpu *fpu = &current->thread.fpu;
-
-	preempt_disable();
-	fpregs_activate(fpu);
-	preempt_enable();
-}
-
 /*
  * MXCSR and XCR definitions:
  */
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 97e27de2b7c05..739ca3ae2bdcd 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -335,10 +335,8 @@ void fpu__clear(struct fpu *fpu)
 	 * Make sure fpstate is cleared and initialized.
 	 */
 	fpu__initialize(fpu);
-	if (static_cpu_has(X86_FEATURE_FPU)) {
-		user_fpu_begin();
+	if (static_cpu_has(X86_FEATURE_FPU))
 		copy_init_fpstate_to_fpregs();
-	}
 }
 
 /*
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 2f044021fde2b..6475320939ce3 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -322,7 +322,6 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		 * For 64-bit frames and 32-bit fsave frames, restore the user
 		 * state to the registers directly (with exceptions handled).
 		 */
-		user_fpu_begin();
 		if (copy_user_to_fpregs_zeroing(buf_fx, xfeatures, fx_only)) {
 			fpu__clear(fpu);
 			return -1;
-- 
2.20.1

