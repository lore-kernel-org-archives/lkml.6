Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC49AC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD39020837
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD39020837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbeKHFVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:21:18 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:41948 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbeKHFVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:21:18 -0500
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gKTpL-00070Q-QA; Wed, 07 Nov 2018 20:49:24 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 17/23] x86/fpu: Eager switch PKRU state
Date:   Wed,  7 Nov 2018 20:48:52 +0100
Message-Id: <20181107194858.9380-18-bigeasy@linutronix.de>
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

Signed-off-by: Rik van Riel <riel@surriel.com>
[bigeasy: save pkru to xstate, no cache]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/include/asm/fpu/internal.h | 13 +++++++++++--
 arch/x86/include/asm/fpu/xstate.h   |  2 ++
 arch/x86/kernel/fpu/xstate.c        |  2 +-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 260cd4f4ba2bb..ed65e0642a1e1 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -561,8 +561,17 @@ switch_fpu_prepare(struct fpu *old_fpu, int cpu)
  */
 static inline void switch_fpu_finish(struct fpu *new_fpu, int cpu)
 {
-	if (static_cpu_has(X86_FEATURE_FPU))
-		__fpregs_load_activate(new_fpu, cpu);
+	if (!static_cpu_has(X86_FEATURE_FPU))
+		return;
+
+	__fpregs_load_activate(new_fpu, cpu);
+
+	if (cpu_feature_enabled(X86_FEATURE_OSPKE)) {
+		struct pkru_state *pk;
+
+		pk = __raw_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU);
+		__write_pkru(pk->pkru);
+	}
 }
 
 /*
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index fbe41f808e5d8..dd138f5eb5c66 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <asm/processor.h>
 #include <linux/uaccess.h>
+#include <asm/user.h>
 
 /* Bit 63 of XCR0 is reserved for future expansion */
 #define XFEATURE_MASK_EXTEND	(~(XFEATURE_MASK_FPSSE | (1ULL << 63)))
@@ -47,6 +48,7 @@ extern void __init update_regset_xstate_info(unsigned int size,
 
 void fpu__xstate_clear_all_cpu_caps(void);
 void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
+void *__raw_xsave_addr(struct xregs_state *xsave, int feature_nr);
 const void *get_xsave_field_ptr(int xfeature_nr);
 int using_compacted_format(void);
 int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int offset, unsigned int size);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 375226055a413..5b33985d9f475 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -811,7 +811,7 @@ void fpu__resume_cpu(void)
  *
  * Note: does not work for compacted buffers.
  */
-static void *__raw_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
+void *__raw_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
 {
 	if (!xfeature_enabled(xfeature_nr)) {
 		WARN_ON_FPU(1);
-- 
2.19.1

