Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7CAC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB6120882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB6120882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbeILSkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:40:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43885 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbeILSkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:40:31 -0400
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g05JC-0001Ap-6f; Wed, 12 Sep 2018 15:35:54 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 03/10] x86/fpu: add (__)make_fpregs_active helpers
Date:   Wed, 12 Sep 2018 15:33:46 +0200
Message-Id: <20180912133353.20595-4-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180912133353.20595-1-bigeasy@linutronix.de>
References: <20180912133353.20595-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rik van Riel <riel@surriel.com>

Add helper function that ensures the floating point registers for
the current task are active. Use with preemption disabled.

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/include/asm/fpu/internal.h | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index a38bf5a1e37ad..16c4077ffc945 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -514,6 +514,26 @@ static inline void fpregs_activate(struct fpu *fpu)
 	trace_x86_fpu_regs_activated(fpu);
 }
 
+/*
+ * Load the FPU state for the current task. Call with preemption disabled.
+ */
+static inline void __fpregs_load_activate(struct fpu *fpu, int cpu)
+{
+	if (!fpregs_state_valid(fpu, cpu))
+		copy_kernel_to_fpregs(&fpu->state);
+	fpregs_activate(fpu);
+}
+
+static inline void __fpregs_changes_begin(void)
+{
+	preempt_disable();
+}
+
+static inline void __fpregs_changes_end(void)
+{
+	preempt_enable();
+}
+
 /*
  * FPU state switching for scheduling.
  *
@@ -553,11 +573,8 @@ static inline void switch_fpu_finish(struct fpu *new_fpu, int cpu)
 	bool preload = static_cpu_has(X86_FEATURE_FPU) &&
 		       new_fpu->initialized;
 
-	if (preload) {
-		if (!fpregs_state_valid(new_fpu, cpu))
-			copy_kernel_to_fpregs(&new_fpu->state);
-		fpregs_activate(new_fpu);
-	}
+	if (preload)
+		__fpregs_load_activate(new_fpu, cpu);
 }
 
 /*
-- 
2.19.0

