Return-Path: <kernel-hardening-return-13023-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49t+FB9321jtV8RK5dUguo8XDKpfdIFRbqDN1fAd3/ksfdbaTM7bPb8EtF0lPEt9EIS2rAd
ARC-Seal: i=1; a=rsa-sha256; t=1523990367; cv=none;
        d=google.com; s=arc-20160816;
        b=nvZtlyr0cbc8vjvuPw/RawQGfg5LJP762SXKKMzeQtg2drD7zl/jPzlp/6l4VsGxNs
         qVo5wMkl9OsptNR+2/oZ3f8SoxQdeuHD9ob6+51yKk0hRT6vXlBCJ7VdcvL3Hq6MQV2t
         6yrDQK9ZbrOJE6xVDgQh3lqM4Pdgpmhsd0RdsX96eKmf2cRXtCagvhgYdUyBHG0U8X9G
         IxxXvAarrkw+hHapACJVFKNZ+EcSorFbOZ3NLm1vsAmspzWF8sWKoO00ssc/PeGAIYJR
         hc0+kX8z0KrVasGyAN+BJC1UDgIsT4xa6jrH0g+JvccnR1umL0qfdZX6+apWwC4XAAsM
         qXzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=XRqeiWN62iYC/SKfswSUlXoSTH6ynOz0k/prXfeTS9Y=;
        b=aJVak+6p8xUP79cWYy7/F/4W562oAKGlzOqxceqo2pGoJK7q1JzTBxkfyDTw8YJQM2
         lu4HlZeD9DQnOcrBJFbahPl71cv+7sx85O9/C2GaqsmPCNOtV0iL5/vvYRy3kY+lTy1x
         hRGKNx/a0hk4Aac2flnmSz40/YrPhzvs/R74+fw1fDEUxJP+KoInAjsrsQp+uP+KyETc
         N9qiHGpcZUk6NB7woMOHqPYiJdCY6Mnqr6q/GK+0BUg5icgXGyQcVgz3DIYi2yuX1T52
         Bp9Ls+IklFmn/YXBkKDZcoyb6X9dcBjW89ZaD+awDf3B0WrclA43nL5DZGJfAepl2EsX
         ++/w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13023-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13023-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13023-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13023-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de,
	catalin.marinas@arm.com,
	cdall@kernel.org,
	drjones@redhat.com,
	kvmarm@lists.cs.columbia.edu,
	linux-arch@vger.kernel.org,
	marc.zyngier@arm.com,
	mark.rutland@arm.com,
	ramana.radhakrishnan@arm.com,
	suzuki.poulose@arm.com,
	will.deacon@arm.com,
	linux-kernel@vger.kernel.org,
	awallis@codeaurora.org,
	kernel-hardening@lists.openwall.com
Subject: [PATCHv3 05/11] arm64/cpufeature: detect pointer authentication
Date: Tue, 17 Apr 2018 19:37:29 +0100
Message-Id: <20180417183735.56985-6-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180417183735.56985-1-mark.rutland@arm.com>
References: <20180417183735.56985-1-mark.rutland@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598019723101175336?=
X-GMAIL-MSGID: =?utf-8?q?1598019723101175336?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

So that we can dynamically handle the presence of pointer authentication
functionality, wire up probing code in cpufeature.c.

>From ARMv8.3 onwards, ID_AA64ISAR1 is no longer entirely RES0, and now
has four fields describing the presence of pointer authentication
functionality:

* APA - address authentication present, using an architected algorithm
* API - address authentication present, using an IMP DEF algorithm
* GPA - generic authentication present, using an architected algorithm
* GPI - generic authentication present, using an IMP DEF algorithm

For the moment we only care about address authentication, so we only
need to check APA and API. It is assumed that if all CPUs support an IMP
DEF algorithm, the same algorithm is used across all CPUs.

Note that when we implement KVM support, we will also need to ensure
that CPUs have uniform support for GPA and GPI.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cpucaps.h |  5 ++++-
 arch/arm64/kernel/cpufeature.c   | 47 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index bc51b72fafd4..9dcb4d1b14f5 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -48,7 +48,10 @@
 #define ARM64_HAS_CACHE_IDC			27
 #define ARM64_HAS_CACHE_DIC			28
 #define ARM64_HW_DBM				29
+#define ARM64_HAS_ADDRESS_AUTH_ARCH		30
+#define ARM64_HAS_ADDRESS_AUTH_IMP_DEF		31
+#define ARM64_HAS_ADDRESS_AUTH			32
 
-#define ARM64_NCAPS				30
+#define ARM64_NCAPS				33
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 536d572e5596..01b1a7e7d70f 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -142,6 +142,10 @@ static const struct arm64_ftr_bits ftr_id_aa64isar1[] = {
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
@@ -1025,6 +1029,22 @@ static void cpu_copy_el2regs(const struct arm64_cpu_capabilities *__unused)
 }
 #endif
 
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
+#endif /* CONFIG_ARM64_PTR_AUTH */
+
 static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "GIC system register CPU interface",
@@ -1201,6 +1221,33 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.cpu_enable = cpu_enable_hw_dbm,
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
+#endif /* CONFIG_ARM64_PTR_AUTH */
 	{},
 };
 
-- 
2.11.0
