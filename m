Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BD1C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2622320862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2622320862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbeKHFVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:21:23 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:41970 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbeKHFVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:21:22 -0500
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gKTpO-00070Q-QI; Wed, 07 Nov 2018 20:49:27 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 20/23] x86/fpu: Prepare copy_fpstate_to_sigframe() for TIF_NEED_FPU_LOAD
Date:   Wed,  7 Nov 2018 20:48:55 +0100
Message-Id: <20181107194858.9380-21-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181107194858.9380-1-bigeasy@linutronix.de>
References: <20181107194858.9380-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rik van Riel <riel@surriel.com>

The FPU registers need only to be saved if TIF_NEED_FPU_LOAD is not set.
Otherwise this has been already done and can be skipped.

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/fpu/signal.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 254a8dff9cd82..179e2b19976ad 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -156,11 +156,20 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 			sizeof(struct user_i387_ia32_struct), NULL,
 			(struct _fpstate_32 __user *) buf) ? -1 : 1;
 
-	/* Update the thread's fxstate to save the fsave header. */
-	if (ia32_fxstate)
-		copy_fxregs_to_kernel(fpu);
-	else
-		copy_fpregs_to_fpstate(fpu);
+	__fpregs_changes_begin();
+	/*
+	 * If we do not need to load the FPU registers at return to userspace
+	 * then the CPU has the current state and we need to save it. Otherwise
+	 * it is already done and we can skip it.
+	 */
+	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
+		/* Update the thread's fxstate to save the fsave header. */
+		if (ia32_fxstate)
+			copy_fxregs_to_kernel(fpu);
+		else
+			copy_fpregs_to_fpstate(fpu);
+	}
+	__fpregs_changes_end();
 
 	if (using_compacted_format()) {
 		copy_xstate_to_user(buf_fx, xsave, 0, size);
-- 
2.19.1

