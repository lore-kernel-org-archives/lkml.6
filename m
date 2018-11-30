Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E64C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71D720834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71D720834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbeLAE22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:28:28 -0500
Received: from foss.arm.com ([217.140.101.70]:60964 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbeLAE22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 23:28:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 954F31596;
        Fri, 30 Nov 2018 09:18:28 -0800 (PST)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EBDD53F5A0;
        Fri, 30 Nov 2018 09:18:26 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, will.deacon@arm.com,
        catalin.marinas@arm.com, dave.martin@arm.com, mark.rutland@arm.com,
        vladimir.murzin@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v2 1/7] arm64: capabilities: Merge entries for ARM64_WORKAROUND_CLEAN_CACHE
Date:   Fri, 30 Nov 2018 17:18:00 +0000
Message-Id: <1543598286-2663-2-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543598286-2663-1-git-send-email-suzuki.poulose@arm.com>
References: <1543598286-2663-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have two entries for ARM64_WORKAROUND_CLEAN_CACHE capability :

1) ARM Errata 826319, 827319, 824069, 819472 on A53 r0p[012]
2) ARM Errata 819472 on A53 r0p[01]

Both have the same work around. Merge these entries to avoid
duplicate entries for a single capability. Add a new Kconfig
entry to control the "capability" entry to make it easier
to handle combinations of the CONFIGs.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/Kconfig               |  7 +++++++
 arch/arm64/include/asm/cputype.h |  1 +
 arch/arm64/kernel/cpu_errata.c   | 28 ++++++++++++++++------------
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 787d785..ad69e15 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -313,9 +313,13 @@ menu "Kernel Features"
 
 menu "ARM errata workarounds via the alternatives framework"
 
+config ARM64_WORKAROUND_CLEAN_CACHE
+	def_bool n
+
 config ARM64_ERRATUM_826319
 	bool "Cortex-A53: 826319: System might deadlock if a write cannot complete until read data is accepted"
 	default y
+	select ARM64_WORKAROUND_CLEAN_CACHE
 	help
 	  This option adds an alternative code sequence to work around ARM
 	  erratum 826319 on Cortex-A53 parts up to r0p2 with an AMBA 4 ACE or
@@ -337,6 +341,7 @@ config ARM64_ERRATUM_826319
 config ARM64_ERRATUM_827319
 	bool "Cortex-A53: 827319: Data cache clean instructions might cause overlapping transactions to the interconnect"
 	default y
+	select ARM64_WORKAROUND_CLEAN_CACHE
 	help
 	  This option adds an alternative code sequence to work around ARM
 	  erratum 827319 on Cortex-A53 parts up to r0p2 with an AMBA 5 CHI
@@ -358,6 +363,7 @@ config ARM64_ERRATUM_827319
 config ARM64_ERRATUM_824069
 	bool "Cortex-A53: 824069: Cache line might not be marked as clean after a CleanShared snoop"
 	default y
+	select ARM64_WORKAROUND_CLEAN_CACHE
 	help
 	  This option adds an alternative code sequence to work around ARM
 	  erratum 824069 on Cortex-A53 parts up to r0p2 when it is connected
@@ -380,6 +386,7 @@ config ARM64_ERRATUM_824069
 config ARM64_ERRATUM_819472
 	bool "Cortex-A53: 819472: Store exclusive instructions might cause data corruption"
 	default y
+	select ARM64_WORKAROUND_CLEAN_CACHE
 	help
 	  This option adds an alternative code sequence to work around ARM
 	  erratum 819472 on Cortex-A53 parts up to r0p1 with an L2 cache
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 12f93e4d..2e26375 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -151,6 +151,7 @@ struct midr_range {
 		.rv_max = MIDR_CPU_VAR_REV(v_max, r_max),	\
 	}
 
+#define MIDR_REV_RANGE(m, v, r_min, r_max) MIDR_RANGE(m, v, r_min, v, r_max)
 #define MIDR_ALL_VERSIONS(m) MIDR_RANGE(m, 0, 0, 0xf, 0xf)
 
 static inline bool is_midr_in_range(u32 midr, struct midr_range const *range)
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index a509e351..be1a8bc 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -570,24 +570,28 @@ static const struct midr_range arm64_harden_el2_vectors[] = {
 
 #endif
 
-const struct arm64_cpu_capabilities arm64_errata[] = {
+#ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
+static const struct midr_range workaround_clean_cache[] = {
 #if	defined(CONFIG_ARM64_ERRATUM_826319) || \
 	defined(CONFIG_ARM64_ERRATUM_827319) || \
 	defined(CONFIG_ARM64_ERRATUM_824069)
-	{
-	/* Cortex-A53 r0p[012] */
-		.desc = "ARM errata 826319, 827319, 824069",
-		.capability = ARM64_WORKAROUND_CLEAN_CACHE,
-		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A53, 0, 0, 2),
-		.cpu_enable = cpu_enable_cache_maint_trap,
-	},
+	/* Cortex-A53 r0p[012]: ARM errata 826319, 827319, 824069 */
+	MIDR_REV_RANGE(MIDR_CORTEX_A53, 0, 0, 2),
+#endif
+#ifdef	CONFIG_ARM64_ERRATUM_819472
+	/* Cortex-A53 r0p[01] : ARM errata 819472 */
+	MIDR_REV_RANGE(MIDR_CORTEX_A53, 0, 0, 1),
+#endif
+	{},
+};
 #endif
-#ifdef CONFIG_ARM64_ERRATUM_819472
+
+const struct arm64_cpu_capabilities arm64_errata[] = {
+#ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
 	{
-	/* Cortex-A53 r0p[01] */
-		.desc = "ARM errata 819472",
+		.desc = "ARM errata 826319, 827319, 824069, 819472",
 		.capability = ARM64_WORKAROUND_CLEAN_CACHE,
-		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A53, 0, 0, 1),
+		ERRATA_MIDR_RANGE_LIST(workaround_clean_cache),
 		.cpu_enable = cpu_enable_cache_maint_trap,
 	},
 #endif
-- 
2.7.4

