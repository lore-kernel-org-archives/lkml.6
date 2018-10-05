Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DEBC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DC62084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65DC62084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbeJEPso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:48:44 -0400
Received: from foss.arm.com ([217.140.101.70]:48086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728608AbeJEPsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:48:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54F6A1650;
        Fri,  5 Oct 2018 01:50:58 -0700 (PDT)
Received: from moonbear.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 201433F5B3;
        Fri,  5 Oct 2018 01:50:54 -0700 (PDT)
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
Subject: [RFC 16/17] arm64: initialize and switch ptrauth kernel keys
Date:   Fri,  5 Oct 2018 09:47:53 +0100
Message-Id: <20181005084754.20950-17-kristina.martsenko@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181005084754.20950-1-kristina.martsenko@arm.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set up keys to use pointer auth in the kernel. Each task has its own
APIAKey, which is initialized during fork. The key is changed during
context switch and on kernel entry from EL0.

A function that changes the key cannot return, so inline such functions.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---
 arch/arm64/include/asm/pointer_auth.h |  9 ++++++++-
 arch/arm64/include/asm/ptrauth-asm.h  | 13 +++++++++++++
 arch/arm64/include/asm/thread_info.h  |  1 +
 arch/arm64/kernel/asm-offsets.c       |  1 +
 arch/arm64/kernel/entry.S             |  4 ++++
 arch/arm64/kernel/process.c           |  3 +++
 arch/arm64/kernel/smp.c               |  3 +++
 7 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
index 0634f06c3af2..e94ca7df8dab 100644
--- a/arch/arm64/include/asm/pointer_auth.h
+++ b/arch/arm64/include/asm/pointer_auth.h
@@ -50,12 +50,13 @@ do {								\
 	write_sysreg_s(__pki_v.hi, SYS_ ## k ## KEYHI_EL1);	\
 } while (0)
 
-static inline void ptrauth_keys_switch(struct ptrauth_keys *keys)
+static __always_inline void ptrauth_keys_switch(struct ptrauth_keys *keys)
 {
 	if (!cpus_have_const_cap(ARM64_HAS_ADDRESS_AUTH))
 		return;
 
 	__ptrauth_key_install(APIA, keys->apia);
+	isb();
 }
 
 static __always_inline void ptrauth_cpu_enable(void)
@@ -85,11 +86,17 @@ static inline unsigned long ptrauth_strip_insn_pac(unsigned long ptr)
 
 #define ptrauth_task_init_user(tsk)	\
 	ptrauth_keys_init(&(tsk)->thread_info.keys_user)
+#define ptrauth_task_init_kernel(tsk)	\
+	ptrauth_keys_init(&(tsk)->thread_info.keys_kernel)
+#define ptrauth_task_switch(tsk)	\
+	ptrauth_keys_switch(&(tsk)->thread_info.keys_kernel)
 
 #else /* CONFIG_ARM64_PTR_AUTH */
 #define __no_ptrauth
 #define ptrauth_strip_insn_pac(lr)	(lr)
 #define ptrauth_task_init_user(tsk)
+#define ptrauth_task_init_kernel(tsk)
+#define ptrauth_task_switch(tsk)
 #define ptrauth_cpu_enable(tsk)
 #endif /* CONFIG_ARM64_PTR_AUTH */
 
diff --git a/arch/arm64/include/asm/ptrauth-asm.h b/arch/arm64/include/asm/ptrauth-asm.h
index f50bdfc4046c..3ef1cc8903d5 100644
--- a/arch/arm64/include/asm/ptrauth-asm.h
+++ b/arch/arm64/include/asm/ptrauth-asm.h
@@ -16,11 +16,24 @@ alternative_if ARM64_HAS_ADDRESS_AUTH
 alternative_else_nop_endif
 	.endm
 
+	.macro ptrauth_keys_install_kernel tsk, tmp
+alternative_if ARM64_HAS_ADDRESS_AUTH
+	ldr	\tmp, [\tsk, #(TSK_TI_KEYS_KERNEL + PTRAUTH_KEY_APIALO)]
+	msr_s	SYS_APIAKEYLO_EL1, \tmp
+	ldr	\tmp, [\tsk, #(TSK_TI_KEYS_KERNEL + PTRAUTH_KEY_APIAHI)]
+	msr_s	SYS_APIAKEYHI_EL1, \tmp
+	isb
+alternative_else_nop_endif
+	.endm
+
 #else /* CONFIG_ARM64_PTR_AUTH */
 
 	.macro ptrauth_keys_install_user tsk, tmp
 	.endm
 
+	.macro ptrauth_keys_install_kernel tsk, tmp
+	.endm
+
 #endif /* CONFIG_ARM64_PTR_AUTH */
 
 #endif /* __ASM_PTRAUTH_ASM_H */
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index ea9272fb52d4..e3ec5345addc 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -46,6 +46,7 @@ struct thread_info {
 	int			preempt_count;	/* 0 => preemptable, <0 => bug */
 #ifdef CONFIG_ARM64_PTR_AUTH
 	struct ptrauth_keys	keys_user;
+	struct ptrauth_keys	keys_kernel;
 #endif
 };
 
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index b6be0dd037fd..6c61c9722b47 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -47,6 +47,7 @@ int main(void)
 #endif
 #ifdef CONFIG_ARM64_PTR_AUTH
   DEFINE(TSK_TI_KEYS_USER, 	offsetof(struct task_struct, thread_info.keys_user));
+  DEFINE(TSK_TI_KEYS_KERNEL, 	offsetof(struct task_struct, thread_info.keys_kernel));
 #endif
   DEFINE(TSK_STACK,		offsetof(struct task_struct, stack));
   BLANK();
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 1e925f6d2978..a4503da445f7 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -250,6 +250,10 @@ alternative_else_nop_endif
 	msr	sp_el0, tsk
 	.endif
 
+	.if	\el == 0
+	ptrauth_keys_install_kernel tsk, x20
+	.endif
+
 	/*
 	 * Registers that may be useful after this macro is invoked:
 	 *
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 857ae05cd04c..a866996610de 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -330,6 +330,8 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 	 */
 	fpsimd_flush_task_state(p);
 
+	ptrauth_task_init_kernel(p);
+
 	if (likely(!(p->flags & PF_KTHREAD))) {
 		*childregs = *current_pt_regs();
 		childregs->regs[0] = 0;
@@ -426,6 +428,7 @@ __notrace_funcgraph struct task_struct *__switch_to(struct task_struct *prev,
 	contextidr_thread_switch(next);
 	entry_task_switch(next);
 	uao_thread_switch(next);
+	ptrauth_task_switch(next);
 
 	/*
 	 * Complete any pending TLB or cache maintenance on this CPU in case
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 09690024dce8..d952dd62c780 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -212,6 +212,7 @@ asmlinkage notrace void secondary_start_kernel(void)
 	 */
 	check_local_cpu_capabilities();
 
+	ptrauth_task_switch(current);
 	ptrauth_cpu_enable();
 
 	if (cpu_ops[cpu]->cpu_postboot)
@@ -418,6 +419,8 @@ void __init __no_ptrauth smp_prepare_boot_cpu(void)
 	jump_label_init();
 	cpuinfo_store_boot_cpu();
 
+	ptrauth_task_init_kernel(current);
+	ptrauth_task_switch(current);
 	ptrauth_cpu_enable();
 }
 
-- 
2.11.0

