Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368E1C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02DA92081C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02DA92081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbeLGSku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:40:50 -0500
Received: from foss.arm.com ([217.140.101.70]:52174 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbeLGSko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:40:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0330BEBD;
        Fri,  7 Dec 2018 10:40:44 -0800 (PST)
Received: from moonbear.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE3FD3F5AF;
        Fri,  7 Dec 2018 10:40:40 -0800 (PST)
From:   Kristina Martsenko <kristina.martsenko@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Adam Wallis <awallis@codeaurora.org>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave P Martin <dave.martin@arm.com>,
        Jacob Bramley <jacob.bramley@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: [PATCH v6 11/13] arm64: add ptrace regsets for ptrauth key management
Date:   Fri,  7 Dec 2018 18:39:29 +0000
Message-Id: <20181207183931.4285-12-kristina.martsenko@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181207183931.4285-1-kristina.martsenko@arm.com>
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two new ptrace regsets, which can be used to request and change the
pointer authentication keys of a thread. NT_ARM_PACA_KEYS gives access
to the instruction/data address keys, and NT_ARM_PACG_KEYS to the
generic authentication key.

The regsets are only exposed if the kernel is compiled with
CONFIG_CHECKPOINT_RESTORE=y, as the intended use case is checkpointing
and restoring processes that are using pointer authentication. Normally
applications or debuggers should not need to know the keys (and exposing
the keys is a security risk), so the regsets are not exposed by default.

Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---
 arch/arm64/include/uapi/asm/ptrace.h | 18 +++++++++
 arch/arm64/kernel/ptrace.c           | 72 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/elf.h             |  2 +
 3 files changed, 92 insertions(+)

diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index c2f249bcd829..fafa7f6decf9 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -236,6 +236,24 @@ struct user_pac_mask {
 	__u64		insn_mask;
 };
 
+/* pointer authentication keys (NT_ARM_PACA_KEYS, NT_ARM_PACG_KEYS) */
+
+struct user_pac_address_keys {
+	__u64		apiakey_lo;
+	__u64		apiakey_hi;
+	__u64		apibkey_lo;
+	__u64		apibkey_hi;
+	__u64		apdakey_lo;
+	__u64		apdakey_hi;
+	__u64		apdbkey_lo;
+	__u64		apdbkey_hi;
+};
+
+struct user_pac_generic_keys {
+	__u64		apgakey_lo;
+	__u64		apgakey_hi;
+};
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _UAPI__ASM_PTRACE_H */
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 6c1f63cb6c4e..f18f14c64d1e 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -979,6 +979,56 @@ static int pac_mask_get(struct task_struct *target,
 
 	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, &uregs, 0, -1);
 }
+
+#ifdef CONFIG_CHECKPOINT_RESTORE
+static int pac_address_keys_get(struct task_struct *target,
+				const struct user_regset *regset,
+				unsigned int pos, unsigned int count,
+				void *kbuf, void __user *ubuf)
+{
+	if (!system_supports_address_auth())
+		return -EINVAL;
+
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+			&target->thread_info.keys_user, 0, -1);
+}
+
+static int pac_address_keys_set(struct task_struct *target,
+				const struct user_regset *regset,
+				unsigned int pos, unsigned int count,
+				const void *kbuf, const void __user *ubuf)
+{
+	if (!system_supports_address_auth())
+		return -EINVAL;
+
+	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+			&target->thread_info.keys_user, 0, -1);
+}
+
+static int pac_generic_keys_get(struct task_struct *target,
+				const struct user_regset *regset,
+				unsigned int pos, unsigned int count,
+				void *kbuf, void __user *ubuf)
+{
+	if (!system_supports_generic_auth())
+		return -EINVAL;
+
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+			&target->thread_info.keys_user.apga, 0, -1);
+}
+
+static int pac_generic_keys_set(struct task_struct *target,
+				const struct user_regset *regset,
+				unsigned int pos, unsigned int count,
+				const void *kbuf, const void __user *ubuf)
+{
+	if (!system_supports_generic_auth())
+		return -EINVAL;
+
+	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+			&target->thread_info.keys_user.apga, 0, -1);
+}
+#endif /* CONFIG_CHECKPOINT_RESTORE */
 #endif /* CONFIG_ARM64_PTR_AUTH */
 
 enum aarch64_regset {
@@ -995,6 +1045,10 @@ enum aarch64_regset {
 #endif
 #ifdef CONFIG_ARM64_PTR_AUTH
 	REGSET_PAC_MASK,
+#ifdef CONFIG_CHECKPOINT_RESTORE
+	REGSET_PACA_KEYS,
+	REGSET_PACG_KEYS,
+#endif
 #endif
 };
 
@@ -1074,6 +1128,24 @@ static const struct user_regset aarch64_regsets[] = {
 		.get = pac_mask_get,
 		/* this cannot be set dynamically */
 	},
+#ifdef CONFIG_CHECKPOINT_RESTORE
+	[REGSET_PACA_KEYS] = {
+		.core_note_type = NT_ARM_PACA_KEYS,
+		.n = sizeof(struct user_pac_address_keys) / sizeof(u64),
+		.size = sizeof(u64),
+		.align = sizeof(u64),
+		.get = pac_address_keys_get,
+		.set = pac_address_keys_set,
+	},
+	[REGSET_PACG_KEYS] = {
+		.core_note_type = NT_ARM_PACG_KEYS,
+		.n = sizeof(struct user_pac_generic_keys) / sizeof(u64),
+		.size = sizeof(u64),
+		.align = sizeof(u64),
+		.get = pac_generic_keys_get,
+		.set = pac_generic_keys_set,
+	},
+#endif
 #endif
 };
 
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 3f23273d690c..c1afbc592531 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -421,6 +421,8 @@ typedef struct elf64_shdr {
 #define NT_ARM_SYSTEM_CALL	0x404	/* ARM system call number */
 #define NT_ARM_SVE	0x405		/* ARM Scalable Vector Extension registers */
 #define NT_ARM_PAC_MASK		0x406	/* ARM pointer authentication code masks */
+#define NT_ARM_PACA_KEYS	0x407	/* ARM pointer authentication address keys */
+#define NT_ARM_PACG_KEYS	0x408	/* ARM pointer authentication generic key */
 #define NT_ARC_V2	0x600		/* ARCv2 accumulator/extra registers */
 #define NT_VMCOREDD	0x700		/* Vmcore Device Dump Note */
 #define NT_MIPS_DSP	0x800		/* MIPS DSP ASE registers */
-- 
2.11.0

