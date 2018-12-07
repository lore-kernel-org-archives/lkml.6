Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6748AC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C86220672
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C86220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbeLGSkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:40:25 -0500
Received: from foss.arm.com ([217.140.101.70]:52046 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbeLGSkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:40:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31FAB15BE;
        Fri,  7 Dec 2018 10:40:24 -0800 (PST)
Received: from moonbear.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 190A33F5AF;
        Fri,  7 Dec 2018 10:40:20 -0800 (PST)
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
Subject: [PATCH v6 06/13] arm64/cpufeature: detect pointer authentication
Date:   Fri,  7 Dec 2018 18:39:24 +0000
Message-Id: <20181207183931.4285-7-kristina.martsenko@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181207183931.4285-1-kristina.martsenko@arm.com>
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

So that we can dynamically handle the presence of pointer authentication
functionality, wire up probing code in cpufeature.c.

From ARMv8.3 onwards, ID_AA64ISAR1 is no longer entirely RES0, and now
has four fields describing the presence of pointer authentication
functionality:

* APA - address authentication present, using an architected algorithm
* API - address authentication present, using an IMP DEF algorithm
* GPA - generic authentication present, using an architected algorithm
* GPI - generic authentication present, using an IMP DEF algorithm

This patch checks for both address and generic authentication,
separately. It is assumed that if all CPUs support an IMP DEF algorithm,
the same algorithm is used across all CPUs.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cpucaps.h    |  8 +++-
 arch/arm64/include/asm/cpufeature.h | 12 +++++
 arch/arm64/kernel/cpufeature.c      | 90 +++++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 6e2d254c09eb..62fc48604263 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -54,7 +54,13 @@
 #define ARM64_HAS_CRC32				33
 #define ARM64_SSBS				34
 #define ARM64_WORKAROUND_1188873		35
+#define ARM64_HAS_ADDRESS_AUTH_ARCH		36
+#define ARM64_HAS_ADDRESS_AUTH_IMP_DEF		37
+#define ARM64_HAS_ADDRESS_AUTH			38
+#define ARM64_HAS_GENERIC_AUTH_ARCH		39
+#define ARM64_HAS_GENERIC_AUTH_IMP_DEF		40
+#define ARM64_HAS_GENERIC_AUTH			41
 
-#define ARM64_NCAPS				36
+#define ARM64_NCAPS				42
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 7e2ec64aa414..1c8393ffabff 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -514,6 +514,18 @@ static inline bool system_supports_cnp(void)
 		cpus_have_const_cap(ARM64_HAS_CNP);
 }
 
+static inline bool system_supports_address_auth(void)
+{
+	return IS_ENABLED(CONFIG_ARM64_PTR_AUTH) &&
+		cpus_have_const_cap(ARM64_HAS_ADDRESS_AUTH);
+}
+
+static inline bool system_supports_generic_auth(void)
+{
+	return IS_ENABLED(CONFIG_ARM64_PTR_AUTH) &&
+		cpus_have_const_cap(ARM64_HAS_GENERIC_AUTH);
+}
+
 #define ARM64_SSBD_UNKNOWN		-1
 #define ARM64_SSBD_FORCE_DISABLE	0
 #define ARM64_SSBD_KERNEL		1
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index aec5ecb85737..f8e3c3568a79 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -141,9 +141,17 @@ static const struct arm64_ftr_bits ftr_id_aa64isar0[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64isar1[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_PTR_AUTH),
+		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_GPI_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_PTR_AUTH),
+		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_GPA_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_LRCPC_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_FCMA_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_JSCVT_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_PTR_AUTH),
+		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_API_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_PTR_AUTH),
+		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_APA_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_DPB_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
@@ -1145,6 +1153,36 @@ static void cpu_clear_disr(const struct arm64_cpu_capabilities *__unused)
 }
 #endif /* CONFIG_ARM64_RAS_EXTN */
 
+#ifdef CONFIG_ARM64_PTR_AUTH
+static bool has_address_auth(const struct arm64_cpu_capabilities *entry,
+			     int __unused)
+{
+	u64 isar1 = read_sanitised_ftr_reg(SYS_ID_AA64ISAR1_EL1);
+	bool api, apa;
+
+	apa = cpuid_feature_extract_unsigned_field(isar1,
+					ID_AA64ISAR1_APA_SHIFT) > 0;
+	api = cpuid_feature_extract_unsigned_field(isar1,
+					ID_AA64ISAR1_API_SHIFT) > 0;
+
+	return apa || api;
+}
+
+static bool has_generic_auth(const struct arm64_cpu_capabilities *entry,
+			     int __unused)
+{
+	u64 isar1 = read_sanitised_ftr_reg(SYS_ID_AA64ISAR1_EL1);
+	bool gpi, gpa;
+
+	gpa = cpuid_feature_extract_unsigned_field(isar1,
+					ID_AA64ISAR1_GPA_SHIFT) > 0;
+	gpi = cpuid_feature_extract_unsigned_field(isar1,
+					ID_AA64ISAR1_GPI_SHIFT) > 0;
+
+	return gpa || gpi;
+}
+#endif /* CONFIG_ARM64_PTR_AUTH */
+
 static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "GIC system register CPU interface",
@@ -1368,6 +1406,58 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.cpu_enable = cpu_enable_cnp,
 	},
 #endif
+#ifdef CONFIG_ARM64_PTR_AUTH
+	{
+		.desc = "Address authentication (architected algorithm)",
+		.capability = ARM64_HAS_ADDRESS_AUTH_ARCH,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.sys_reg = SYS_ID_AA64ISAR1_EL1,
+		.sign = FTR_UNSIGNED,
+		.field_pos = ID_AA64ISAR1_APA_SHIFT,
+		.min_field_value = ID_AA64ISAR1_APA_ARCHITECTED,
+		.matches = has_cpuid_feature,
+	},
+	{
+		.desc = "Address authentication (IMP DEF algorithm)",
+		.capability = ARM64_HAS_ADDRESS_AUTH_IMP_DEF,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.sys_reg = SYS_ID_AA64ISAR1_EL1,
+		.sign = FTR_UNSIGNED,
+		.field_pos = ID_AA64ISAR1_API_SHIFT,
+		.min_field_value = ID_AA64ISAR1_API_IMP_DEF,
+		.matches = has_cpuid_feature,
+	},
+	{
+		.capability = ARM64_HAS_ADDRESS_AUTH,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches = has_address_auth,
+	},
+	{
+		.desc = "Generic authentication (architected algorithm)",
+		.capability = ARM64_HAS_GENERIC_AUTH_ARCH,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.sys_reg = SYS_ID_AA64ISAR1_EL1,
+		.sign = FTR_UNSIGNED,
+		.field_pos = ID_AA64ISAR1_GPA_SHIFT,
+		.min_field_value = ID_AA64ISAR1_GPA_ARCHITECTED,
+		.matches = has_cpuid_feature,
+	},
+	{
+		.desc = "Generic authentication (IMP DEF algorithm)",
+		.capability = ARM64_HAS_GENERIC_AUTH_IMP_DEF,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.sys_reg = SYS_ID_AA64ISAR1_EL1,
+		.sign = FTR_UNSIGNED,
+		.field_pos = ID_AA64ISAR1_GPI_SHIFT,
+		.min_field_value = ID_AA64ISAR1_GPI_IMP_DEF,
+		.matches = has_cpuid_feature,
+	},
+	{
+		.capability = ARM64_HAS_GENERIC_AUTH,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches = has_generic_auth,
+	},
+#endif /* CONFIG_ARM64_PTR_AUTH */
 	{},
 };
 
-- 
2.11.0

