Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63CDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCAB223DD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DCAB223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbeKLVub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 16:50:31 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34524 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729569AbeKLVua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 16:50:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 313831650;
        Mon, 12 Nov 2018 03:57:34 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 386B83F5A0;
        Mon, 12 Nov 2018 03:57:32 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Julien Thierry <julien.thierry@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v6 03/24] arm64: cpufeature: Add cpufeature for IRQ priority masking
Date:   Mon, 12 Nov 2018 11:56:54 +0000
Message-Id: <1542023835-21446-4-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a cpufeature indicating whether a cpu supports masking interrupts
by priority.

The feature will be properly enabled in a later patch.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpucaps.h    |  3 ++-
 arch/arm64/include/asm/cpufeature.h |  6 ++++++
 arch/arm64/kernel/cpufeature.c      | 23 +++++++++++++++++++++++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 6e2d254..f367e5c 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -54,7 +54,8 @@
 #define ARM64_HAS_CRC32				33
 #define ARM64_SSBS				34
 #define ARM64_WORKAROUND_1188873		35
+#define ARM64_HAS_IRQ_PRIO_MASKING		36
 
-#define ARM64_NCAPS				36
+#define ARM64_NCAPS				37
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 7e2ec64..a6e063f 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -514,6 +514,12 @@ static inline bool system_supports_cnp(void)
 		cpus_have_const_cap(ARM64_HAS_CNP);
 }
 
+static inline bool system_supports_irq_prio_masking(void)
+{
+	return IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) &&
+	       cpus_have_const_cap(ARM64_HAS_IRQ_PRIO_MASKING);
+}
+
 #define ARM64_SSBD_UNKNOWN		-1
 #define ARM64_SSBD_FORCE_DISABLE	0
 #define ARM64_SSBD_KERNEL		1
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 03a9d96..1b5b553 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1145,6 +1145,14 @@ static void cpu_clear_disr(const struct arm64_cpu_capabilities *__unused)
 }
 #endif /* CONFIG_ARM64_RAS_EXTN */
 
+#ifdef CONFIG_ARM64_PSEUDO_NMI
+static bool can_use_gic_priorities(const struct arm64_cpu_capabilities *entry,
+				   int scope)
+{
+	return false;
+}
+#endif
+
 static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "GIC system register CPU interface",
@@ -1368,6 +1376,21 @@ static void cpu_clear_disr(const struct arm64_cpu_capabilities *__unused)
 		.cpu_enable = cpu_enable_cnp,
 	},
 #endif
+#ifdef CONFIG_ARM64_PSEUDO_NMI
+	{
+		/*
+		 * Depends on having GICv3
+		 */
+		.desc = "IRQ priority masking",
+		.capability = ARM64_HAS_IRQ_PRIO_MASKING,
+		.type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
+		.matches = can_use_gic_priorities,
+		.sys_reg = SYS_ID_AA64PFR0_EL1,
+		.field_pos = ID_AA64PFR0_GIC_SHIFT,
+		.sign = FTR_UNSIGNED,
+		.min_field_value = 1,
+	},
+#endif
 	{},
 };
 
-- 
1.9.1

