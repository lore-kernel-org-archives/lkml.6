Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84F1C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858C520837
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858C520837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeKHFVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:21:06 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:41861 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbeKHFVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:21:05 -0500
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gKTp9-00070Q-7D; Wed, 07 Nov 2018 20:49:11 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 07/23] x86/fpu: Remove fpu->initialized usage in copy_fpstate_to_sigframe()
Date:   Wed,  7 Nov 2018 20:48:42 +0100
Message-Id: <20181107194858.9380-8-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181107194858.9380-1-bigeasy@linutronix.de>
References: <20181107194858.9380-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since ->initialized is always true for user tasks and kernel threads
don't get this far, we always save the registers directly to userspace.

Remove check for ->initialized because it is always true and remove the
false condition.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/fpu/signal.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 5777ee0c32fed..30e65085dc4d9 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -157,7 +157,6 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
 int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 {
 	struct fpu *fpu = &current->thread.fpu;
-	struct xregs_state *xsave = &fpu->state.xsave;
 	struct task_struct *tsk = current;
 	int ia32_fxstate = (buf != buf_fx);
 
@@ -172,29 +171,12 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
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
-- 
2.19.1

