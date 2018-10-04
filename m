Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F820C64EBD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1383A21470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1383A21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeJDPZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:25:39 -0400
Received: from foss.arm.com ([217.140.101.70]:60402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727557AbeJDPZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:25:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0191D15AD;
        Thu,  4 Oct 2018 01:33:31 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6E7F43F5A0;
        Thu,  4 Oct 2018 01:33:29 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, mark.rutland@arm.com, suzuki.poulose@arm.com,
        pelcan@codeaurora.org, shankerd@codeaurora.org
Subject: [PATCH 2/3] arm64: cpufeature: Fix handling of CTR_EL0.IDC field
Date:   Thu,  4 Oct 2018 09:33:14 +0100
Message-Id: <20181004083315.31174-3-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181004083315.31174-1-suzuki.poulose@arm.com>
References: <20181004083315.31174-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CTR_EL0.IDC reports the data cache clean requirements for instruction
to data coherence. However, if the field is 0, we need to check the
CLIDR_EL1 fields to detect the status of the feature. Currently we
don't do this and generate a warning with tainting the kernel, when
there is a mismatch in the field among the CPUs. Also the userspace
doesn't have a reliable way to check the CLIDR_EL1 register to check
the status.

This patch fixes the problem by checking the CLIDR_EL1 fields, when
(CTR_EL0.IDC == 0) and updates the kernel's copy of the CTR_EL0 for
the CPU with the actual status of the feature. This would allow the
sanity check infrastructure to do the proper checking of the fields
and also allow the CTR_EL0 emulation code to supply the real status
of the feature.

Now, if a CPU has raw CTR_EL0.IDC == 0 and effective IDC == 1 (with
overall system wide IDC == 1), we need to expose the real value to
the user. So, we trap CTR_EL0 access on the CPU which reports incorrect
CTR_EL0.IDC.

Fixes: commit 6ae4b6e057888 ("arm64: Add support for new control bits CTR_EL0.DIC and CTR_EL0.IDC")
Cc: Shanker Donthineni <shankerd@codeaurora.org>
Cc: Philip Elcan <pelcan@codeaurora.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cache.h | 40 ++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c | 10 +++++++--
 arch/arm64/kernel/cpufeature.c | 17 +++++++++++++--
 arch/arm64/kernel/cpuinfo.c    | 10 ++++++++-
 4 files changed, 72 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index 5ee5bca8c24b..904c42d4ff1a 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -40,6 +40,15 @@
 #define L1_CACHE_SHIFT		(6)
 #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
 
+
+#define CLIDR_LOUU_SHIFT	27
+#define CLIDR_LOC_SHIFT		24
+#define CLIDR_LOUIS_SHIFT	21
+
+#define CLIDR_LOUU(clidr)	(((clidr) >> CLIDR_LOUU_SHIFT) & 0x7)
+#define CLIDR_LOC(clidr)	(((clidr) >> CLIDR_LOC_SHIFT) & 0x7)
+#define CLIDR_LOUIS(clidr)	(((clidr) >> CLIDR_LOUIS_SHIFT) & 0x7)
+
 /*
  * Memory returned by kmalloc() may be used for DMA, so we must make
  * sure that all such allocations are cache aligned. Otherwise,
@@ -84,6 +93,37 @@ static inline int cache_line_size(void)
 	return cwg ? 4 << cwg : ARCH_DMA_MINALIGN;
 }
 
+/*
+ * Read the effective value of CTR_EL0.
+ *
+ * According to ARM ARM for ARMv8-A (ARM DDI 0487C.a),
+ * section D10.2.33 "CTR_EL0, Cache Type Register" :
+ *
+ * CTR_EL0.IDC reports the data cache clean requirements for
+ * instruction to data coherence.
+ *
+ *  0 - dcache clean to PoU is required unless :
+ *     (CLIDR_EL1.LoC == 0) || (CLIDR_EL1.LoUIS == 0 && CLIDR_EL1.LoUU == 0)
+ *  1 - dcache clean to PoU is not required for i-to-d coherence.
+ *
+ * This routine provides the CTR_EL0 with the IDC field updated to the
+ * effective state.
+ */
+static inline u32 __attribute_const__ read_cpuid_effective_cachetype(void)
+{
+	u64 ctr = read_cpuid_cachetype();
+
+	if (!(ctr & BIT(CTR_IDC_SHIFT))) {
+		u64 clidr = read_sysreg(clidr_el1);
+
+		if (CLIDR_LOC(clidr) == 0 ||
+		    (CLIDR_LOUIS(clidr) == 0 && CLIDR_LOUU(clidr) == 0))
+			ctr |= BIT(CTR_IDC_SHIFT);
+	}
+
+	return ctr;
+}
+
 #endif	/* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index cde948991d68..31551f444ce3 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -71,8 +71,14 @@ has_mismatched_cache_type(const struct arm64_cpu_capabilities *entry,
 	u64 mask = arm64_ftr_reg_ctrel0.strict_mask;;
 
 	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
-	return (read_cpuid_cachetype() & mask) !=
-	       (arm64_ftr_reg_ctrel0.sys_val & mask);
+
+	/*
+	 * Check the effective cache type here to allow booting a late CPU
+	 * which may expose raw CTR_EL0.IDC = 0, while effectively
+	 * it is not. We handle such CPUs with ARM64_HAS_CACHE_IDC capability.
+	 */
+	return (read_cpuid_effective_cachetype() & mask) !=
+		(arm64_ftr_reg_ctrel0.sys_val & mask);
 }
 
 static void
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index ba16bb7762ca..d3caeabf09ed 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -861,18 +861,30 @@ static bool has_cache_idc(const struct arm64_cpu_capabilities *entry,
 	if (scope == SCOPE_SYSTEM)
 		ctr = arm64_ftr_reg_ctrel0.sys_val;
 	else
-		ctr = read_cpuid_cachetype();
+		ctr = read_cpuid_effective_cachetype();
 
 	return ctr & BIT(CTR_IDC_SHIFT);
 }
 
+static void cpu_emulate_effective_ctr(const struct arm64_cpu_capabilities *__unused)
+{
+	/*
+	 * If the CPU exposes raw CTR_EL0.IDC = 0, while effectively
+	 * CTR_EL0.IDC = 1 (from CLIDR values), we need to trap accesses
+	 * to the CTR_EL0 on this CPU and emulate it with the real/safe
+	 * value.
+	 */
+	if (!(read_cpuid_cachetype() & BIT(CTR_IDC_SHIFT)))
+		sysreg_clear_set(sctlr_el1, SCTLR_EL1_UCT, 0);
+}
+
 static bool has_cache_dic(const struct arm64_cpu_capabilities *entry,
 			  int scope)
 {
 	u64 ctr;
 
 	if (scope == SCOPE_SYSTEM)
-		ctr = arm64_ftr_reg_ctrel0.sys_val;
+		ctr = read_cpuid_effective_cachetype();
 	else
 		ctr = read_cpuid_cachetype();
 
@@ -1282,6 +1294,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.capability = ARM64_HAS_CACHE_IDC,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_cache_idc,
+		.cpu_enable = cpu_emulate_effective_ctr,
 	},
 	{
 		.desc = "Instruction cache invalidation not required for I/D coherence",
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index dce971f2c167..bcc2831399cb 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -325,7 +325,15 @@ static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
 static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 {
 	info->reg_cntfrq = arch_timer_get_cntfrq();
-	info->reg_ctr = read_cpuid_cachetype();
+	/*
+	 * Use the effective value of the CTR_EL0 than the raw value
+	 * exposed by the CPU. CTR_E0.IDC field value must be interpreted
+	 * with the CLIDR_EL1 fields to avoid triggering false warnings
+	 * when there is a mismatch across the CPUs. Keep track of the
+	 * effective value of the CTR_EL0 in our internal records for
+	 * acurate sanity check and feature enablement.
+	 */
+	info->reg_ctr = read_cpuid_effective_cachetype();
 	info->reg_dczid = read_cpuid(DCZID_EL0);
 	info->reg_midr = read_cpuid_id();
 	info->reg_revidr = read_cpuid(REVIDR_EL1);
-- 
2.19.0

