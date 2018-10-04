Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DDDC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FBE2147D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88FBE2147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbeJDU7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:59:40 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36331 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbeJDU7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:59:39 -0400
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g84GV-0002ic-8f; Thu, 04 Oct 2018 16:06:07 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 10/11] x86/fpu: prepare copy_fpstate_to_sigframe for TIF_LOAD_FPU
Date:   Thu,  4 Oct 2018 16:05:46 +0200
Message-Id: <20181004140547.13014-11-bigeasy@linutronix.de>
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

If TIF_LOAD_FPU is set, then the registers are saved (not loaded). In that case
we skip the saving part.

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/fpu/signal.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index c8f5ff58578ed..979dcd1ed82e0 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -155,13 +155,17 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 			sizeof(struct user_i387_ia32_struct), NULL,
 			(struct _fpstate_32 __user *) buf) ? -1 : 1;
 
-	/* Update the thread's fxstate to save the fsave header. */
-	if (ia32_fxstate) {
-		copy_fxregs_to_kernel(fpu);
-	} else {
-		copy_fpregs_to_fpstate(fpu);
-		fpregs_deactivate(fpu);
+	__fpregs_changes_begin();
+	if (!test_thread_flag(TIF_LOAD_FPU)) {
+		/* Update the thread's fxstate to save the fsave header. */
+		if (ia32_fxstate) {
+			copy_fxregs_to_kernel(fpu);
+		} else {
+			copy_fpregs_to_fpstate(fpu);
+			fpregs_deactivate(fpu);
+		}
 	}
+	__fpregs_changes_end();
 
 	if (using_compacted_format()) {
 		copy_xstate_to_user(buf_fx, xsave, 0, size);
-- 
2.19.0

