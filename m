Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30D2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835C52147D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835C52147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeK2JYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:24:17 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:33114 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbeK2JYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:24:16 -0500
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gS8Cc-0001GX-0b; Wed, 28 Nov 2018 23:21:02 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 11/29] x86/fpu: Always init the `state' in fpu__clear()
Date:   Wed, 28 Nov 2018 23:20:17 +0100
Message-Id: <20181128222035.2996-12-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181128222035.2996-1-bigeasy@linutronix.de>
References: <20181128222035.2996-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fpu__clear() only initializes the `state' if the FPU is present. This
initialisation is also required for the FPU-less system and takes place
math_emulate(). Since fpu__initialize() only performs the initialization
if ->initialized is zero it does not matter that it is invoked each time
an opcode is emulated. It makes the removal of ->initialized easier if
the struct is also initialized in FPU-less case at the same time.

Move fpu__initialize() before the FPU check so it is also performed in
FPU-less case.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/include/asm/fpu/internal.h | 1 -
 arch/x86/kernel/fpu/core.c          | 5 ++---
 arch/x86/math-emu/fpu_entry.c       | 3 ---
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 415d43bdaaa76..1d0e043bfc447 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -24,7 +24,6 @@
 /*
  * High level FPU state handling functions:
  */
-extern void fpu__initialize(struct fpu *fpu);
 extern void fpu__prepare_read(struct fpu *fpu);
 extern void fpu__prepare_write(struct fpu *fpu);
 extern void fpu__save(struct fpu *fpu);
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 1940319268aef..e43296854e379 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -223,7 +223,7 @@ int fpu__copy(struct fpu *dst_fpu, struct fpu *src_fpu)
  * Activate the current task's in-memory FPU context,
  * if it has not been used before:
  */
-void fpu__initialize(struct fpu *fpu)
+static void fpu__initialize(struct fpu *fpu)
 {
 	WARN_ON_FPU(fpu != &current->thread.fpu);
 
@@ -236,7 +236,6 @@ void fpu__initialize(struct fpu *fpu)
 		fpu->initialized = 1;
 	}
 }
-EXPORT_SYMBOL_GPL(fpu__initialize);
 
 /*
  * This function must be called before we read a task's fpstate.
@@ -365,8 +364,8 @@ void fpu__clear(struct fpu *fpu)
 	/*
 	 * Make sure fpstate is cleared and initialized.
 	 */
+	fpu__initialize(fpu);
 	if (static_cpu_has(X86_FEATURE_FPU)) {
-		fpu__initialize(fpu);
 		user_fpu_begin();
 		copy_init_fpstate_to_fpregs();
 	}
diff --git a/arch/x86/math-emu/fpu_entry.c b/arch/x86/math-emu/fpu_entry.c
index 9e2ba7e667f61..a873da6b46d6b 100644
--- a/arch/x86/math-emu/fpu_entry.c
+++ b/arch/x86/math-emu/fpu_entry.c
@@ -113,9 +113,6 @@ void math_emulate(struct math_emu_info *info)
 	unsigned long code_base = 0;
 	unsigned long code_limit = 0;	/* Initialized to stop compiler warnings */
 	struct desc_struct code_descriptor;
-	struct fpu *fpu = &current->thread.fpu;
-
-	fpu__initialize(fpu);
 
 #ifdef RE_ENTRANT_CHECKING
 	if (emulating) {
-- 
2.20.0.rc1

