Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611FFC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF3E20665
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbfAILsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:48:46 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:56212 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731051AbfAILso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:48:44 -0500
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ghCLd-0007Al-5Q; Wed, 09 Jan 2019 12:48:37 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 14/22] x86/fpu: Eager switch PKRU state
Date:   Wed,  9 Jan 2019 12:47:36 +0100
Message-Id: <20190109114744.10936-15-bigeasy@linutronix.de>
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

While most of a task's FPU state is only needed in user space, the
protection keys need to be in place immediately after a context switch.

The reason is that any access to userspace memory while running in
kernel mode also need to abide by the memory permissions specified in
the protection keys.

The "eager switch" is a preparation for loading the FPU state on return
to userland. Instead of decoupling PKRU state from xstate I update PKRU
within xstate on write operations by the kernel.

The read/write_pkru() is moved to another header file so it can easily
accessed from pgtable.h and fpu/internal.h.

For user tasks we should always get the PKRU from the xsave area and it
should not change anything because the PKRU value was loaded as part of
FPU restore.
For kernel kernel threads we now will have the default "allow
everything" written.  Before this commit the kernel thread would end up
with a random value which it inherited from the previous user task.

Signed-off-by: Rik van Riel <riel@surriel.com>
[bigeasy: save pkru to xstate, no cache, don't use __raw_xsave_addr()]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/include/asm/fpu/internal.h | 20 ++++++++++++++++++--
 arch/x86/include/asm/fpu/xstate.h   |  1 +
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 795a0a2df135e..7191eb9686827 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -559,8 +559,24 @@ switch_fpu_prepare(struct fpu *old_fpu, int cpu)
  */
 static inline void switch_fpu_finish(struct fpu *new_fpu, int cpu)
 {
-	if (static_cpu_has(X86_FEATURE_FPU))
-		__fpregs_load_activate(new_fpu, cpu);
+	struct pkru_state *pk;
+	u32 pkru_val = 0;
+
+	if (!static_cpu_has(X86_FEATURE_FPU))
+		return;
+
+	__fpregs_load_activate(new_fpu, cpu);
+
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
+		return;
+
+	if (current->mm) {
+		pk = get_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU);
+		WARN_ON_ONCE(!pk);
+		if (pk)
+			pkru_val = pk->pkru;
+	}
+	__write_pkru(pkru_val);
 }
 
 /*
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index fbe41f808e5d8..4e18a837223ff 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <asm/processor.h>
 #include <linux/uaccess.h>
+#include <asm/user.h>
 
 /* Bit 63 of XCR0 is reserved for future expansion */
 #define XFEATURE_MASK_EXTEND	(~(XFEATURE_MASK_FPSSE | (1ULL << 63)))
-- 
2.20.1

