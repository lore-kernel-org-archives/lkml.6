Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3ABCC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71BE12084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71BE12084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbeJEPs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:48:27 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48008 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727809AbeJEPs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:48:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5500F15BE;
        Fri,  5 Oct 2018 01:50:42 -0700 (PDT)
Received: from moonbear.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2013B3F5B3;
        Fri,  5 Oct 2018 01:50:38 -0700 (PDT)
From:   Kristina Martsenko <kristina.martsenko@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Adam Wallis <awallis@codeaurora.org>,
        Amit Kachhap <Amit.Kachhap@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Jacob Bramley <jacob.bramley@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        "Suzuki K . Poulose" <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 13/17] arm64: install user ptrauth keys at kernel exit time
Date:   Fri,  5 Oct 2018 09:47:50 +0100
Message-Id: <20181005084754.20950-14-kristina.martsenko@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181005084754.20950-1-kristina.martsenko@arm.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

This will mean we do more work per EL0 exception return, but is a
stepping-stone to enable keys within the kernel.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---
 arch/arm64/include/asm/pointer_auth.h |  7 +------
 arch/arm64/include/asm/ptrauth-asm.h  | 26 ++++++++++++++++++++++++++
 arch/arm64/kernel/asm-offsets.c       |  7 +++++++
 arch/arm64/kernel/entry.S             |  9 +++++++--
 arch/arm64/kernel/process.c           |  1 -
 5 files changed, 41 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/include/asm/ptrauth-asm.h

diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
index cedb03bd175b..5e40533f4ea2 100644
--- a/arch/arm64/include/asm/pointer_auth.h
+++ b/arch/arm64/include/asm/pointer_auth.h
@@ -64,16 +64,11 @@ static inline unsigned long ptrauth_strip_insn_pac(unsigned long ptr)
 }
 
 #define ptrauth_task_init_user(tsk)	\
-	ptrauth_keys_init(&(tsk)->thread_info.keys_user); \
-	ptrauth_keys_switch(&(tsk)->thread_info.keys_user)
-
-#define ptrauth_task_switch(tsk)	\
-	ptrauth_keys_switch(&(tsk)->thread_info.keys_user)
+	ptrauth_keys_init(&(tsk)->thread_info.keys_user)
 
 #else /* CONFIG_ARM64_PTR_AUTH */
 #define ptrauth_strip_insn_pac(lr)	(lr)
 #define ptrauth_task_init_user(tsk)
-#define ptrauth_task_switch(tsk)
 #endif /* CONFIG_ARM64_PTR_AUTH */
 
 #endif /* __ASM_POINTER_AUTH_H */
diff --git a/arch/arm64/include/asm/ptrauth-asm.h b/arch/arm64/include/asm/ptrauth-asm.h
new file mode 100644
index 000000000000..f50bdfc4046c
--- /dev/null
+++ b/arch/arm64/include/asm/ptrauth-asm.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_PTRAUTH_ASM_H
+#define __ASM_PTRAUTH_ASM_H
+
+#include <asm/asm-offsets.h>
+#include <asm/sysreg.h>
+
+#ifdef CONFIG_ARM64_PTR_AUTH
+
+	.macro ptrauth_keys_install_user tsk, tmp
+alternative_if ARM64_HAS_ADDRESS_AUTH
+	ldr	\tmp, [\tsk, #(TSK_TI_KEYS_USER + PTRAUTH_KEY_APIALO)]
+	msr_s	SYS_APIAKEYLO_EL1, \tmp
+	ldr	\tmp, [\tsk, #(TSK_TI_KEYS_USER + PTRAUTH_KEY_APIAHI)]
+	msr_s	SYS_APIAKEYHI_EL1, \tmp
+alternative_else_nop_endif
+	.endm
+
+#else /* CONFIG_ARM64_PTR_AUTH */
+
+	.macro ptrauth_keys_install_user tsk, tmp
+	.endm
+
+#endif /* CONFIG_ARM64_PTR_AUTH */
+
+#endif /* __ASM_PTRAUTH_ASM_H */
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 323aeb5f2fe6..b6be0dd037fd 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -45,6 +45,9 @@ int main(void)
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
   DEFINE(TSK_TI_TTBR0,		offsetof(struct task_struct, thread_info.ttbr0));
 #endif
+#ifdef CONFIG_ARM64_PTR_AUTH
+  DEFINE(TSK_TI_KEYS_USER, 	offsetof(struct task_struct, thread_info.keys_user));
+#endif
   DEFINE(TSK_STACK,		offsetof(struct task_struct, stack));
   BLANK();
   DEFINE(THREAD_CPU_CONTEXT,	offsetof(struct task_struct, thread.cpu_context));
@@ -169,5 +172,9 @@ int main(void)
   DEFINE(SDEI_EVENT_INTREGS,	offsetof(struct sdei_registered_event, interrupted_regs));
   DEFINE(SDEI_EVENT_PRIORITY,	offsetof(struct sdei_registered_event, priority));
 #endif
+#ifdef CONFIG_ARM64_PTR_AUTH
+  DEFINE(PTRAUTH_KEY_APIALO,	offsetof(struct ptrauth_keys, apia.lo));
+  DEFINE(PTRAUTH_KEY_APIAHI,	offsetof(struct ptrauth_keys, apia.hi));
+#endif
   return 0;
 }
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 09dbea221a27..1e925f6d2978 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -23,8 +23,9 @@
 #include <linux/linkage.h>
 
 #include <asm/alternative.h>
-#include <asm/assembler.h>
 #include <asm/asm-offsets.h>
+#include <asm/asm-uaccess.h>
+#include <asm/assembler.h>
 #include <asm/cpufeature.h>
 #include <asm/errno.h>
 #include <asm/esr.h>
@@ -33,8 +34,8 @@
 #include <asm/mmu.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
+#include <asm/ptrauth-asm.h>
 #include <asm/thread_info.h>
-#include <asm/asm-uaccess.h>
 #include <asm/unistd.h>
 
 /*
@@ -325,6 +326,10 @@ alternative_else_nop_endif
 	apply_ssbd 0, x0, x1
 	.endif
 
+	.if	\el == 0
+	ptrauth_keys_install_user tsk, x0
+	.endif
+
 	msr	elr_el1, x21			// set up the return data
 	msr	spsr_el1, x22
 	ldp	x0, x1, [sp, #16 * 0]
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index fae52be66c92..857ae05cd04c 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -426,7 +426,6 @@ __notrace_funcgraph struct task_struct *__switch_to(struct task_struct *prev,
 	contextidr_thread_switch(next);
 	entry_task_switch(next);
 	uao_thread_switch(next);
-	ptrauth_task_switch(next);
 
 	/*
 	 * Complete any pending TLB or cache maintenance on this CPU in case
-- 
2.11.0

