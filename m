Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16648C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87622173B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbfAILud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:50:33 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:56167 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730986AbfAILsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:48:36 -0500
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ghCLX-0007Al-83; Wed, 09 Jan 2019 12:48:31 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 09/22] x86/fpu: Add (__)make_fpregs_active helpers
Date:   Wed,  9 Jan 2019 12:47:31 +0100
Message-Id: <20190109114744.10936-10-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109114744.10936-1-bigeasy@linutronix.de>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
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
 arch/x86/include/asm/fpu/api.h      | 11 +++++++++++
 arch/x86/include/asm/fpu/internal.h | 19 +++++++++++--------
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index b56d504af6545..31b66af8eb914 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -10,6 +10,7 @@
 
 #ifndef _ASM_X86_FPU_API_H
 #define _ASM_X86_FPU_API_H
+#include <linux/preempt.h>
 
 /*
  * Use kernel_fpu_begin/end() if you intend to use FPU in kernel context. It
@@ -22,6 +23,16 @@ extern void kernel_fpu_begin(void);
 extern void kernel_fpu_end(void);
 extern bool irq_fpu_usable(void);
 
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
  * Query the presence of one or more xfeatures. Works on any legacy CPU as well.
  *
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 03acb9aeb32fc..795a0a2df135e 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -515,6 +515,15 @@ static inline void fpregs_activate(struct fpu *fpu)
 	trace_x86_fpu_regs_activated(fpu);
 }
 
+static inline void __fpregs_load_activate(struct fpu *fpu, int cpu)
+{
+	if (!fpregs_state_valid(fpu, cpu)) {
+		if (current->mm)
+			copy_kernel_to_fpregs(&fpu->state);
+		fpregs_activate(fpu);
+	}
+}
+
 /*
  * FPU state switching for scheduling.
  *
@@ -550,14 +559,8 @@ switch_fpu_prepare(struct fpu *old_fpu, int cpu)
  */
 static inline void switch_fpu_finish(struct fpu *new_fpu, int cpu)
 {
-	if (static_cpu_has(X86_FEATURE_FPU)) {
-		if (!fpregs_state_valid(new_fpu, cpu)) {
-			if (current->mm)
-				copy_kernel_to_fpregs(&new_fpu->state);
-		}
-
-		fpregs_activate(new_fpu);
-	}
+	if (static_cpu_has(X86_FEATURE_FPU))
+		__fpregs_load_activate(new_fpu, cpu);
 }
 
 /*
-- 
2.20.1

