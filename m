Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFF2C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5BC20825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5BC20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbeKEVPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:15:09 -0500
Received: from foss.arm.com ([217.140.101.70]:41778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729165AbeKEVPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:15:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4923615AB;
        Mon,  5 Nov 2018 03:55:46 -0800 (PST)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A1CBC3F5BD;
        Mon,  5 Nov 2018 03:55:44 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, vladimir.murzin@arm.com,
        will.deacon@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andrew Pinski <apinski@cavium.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 2/7] arm64: capabilities: Merge duplicate Cavium erratum entries
Date:   Mon,  5 Nov 2018 11:55:12 +0000
Message-Id: <1541418917-14219-3-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541418917-14219-1-git-send-email-suzuki.poulose@arm.com>
References: <1541418917-14219-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge duplicate entries for a single capability using the midr
range list for Cavium errata 30115 and 27456.

Cc: Andrew Pinski <apinski@cavium.com>
Cc: David Daney <david.daney@cavium.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cputype.h |  2 ++
 arch/arm64/kernel/cpu_errata.c   | 50 +++++++++++++++++++---------------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 12f93e4d..5de4f6a 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -151,6 +151,8 @@ struct midr_range {
 		.rv_max = MIDR_CPU_VAR_REV(v_max, r_max),	\
 	}
 
+#define MIDR_REV_RANGE(m, v, r_min, r_max)	MIDR_RANGE(m, v, r_min, v, r_max)
+#define MIDR_REV(m, v, r)			MIDR_RANGE(m, v, r, v, r)
 #define MIDR_ALL_VERSIONS(m) MIDR_RANGE(m, 0, 0, 0xf, 0xf)
 
 static inline bool is_midr_in_range(u32 midr, struct midr_range const *range)
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index c825bc0..7242e4c 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -570,6 +570,28 @@ static const struct midr_range arm64_harden_el2_vectors[] = {
 
 #endif
 
+#ifdef CONFIG_CAVIUM_ERRATUM_27456
+static const struct midr_range cavium_erratum_27456_cpus[] = {
+	/* Cavium ThunderX, T88 pass 1.x - 2.1 */
+	MIDR_RANGE(MIDR_THUNDERX, 0, 0, 1, 1),
+	/* Cavium ThunderX, T81 pass 1.0 */
+	MIDR_REV(MIDR_THUNDERX_81XX, 0, 0),
+	{},
+};
+#endif
+
+#ifdef CONFIG_CAVIUM_ERRATUM_30115
+static const struct midr_range cavium_erratum_30115_cpus[] = {
+	/* Cavium ThunderX, T88 pass 1.x - 2.2 */
+	MIDR_RANGE(MIDR_THUNDERX, 0, 0, 1, 2),
+	/* Cavium ThunderX, T81 pass 1.0 - 1.2 */
+	MIDR_REV_RANGE(MIDR_THUNDERX_81XX, 0, 0, 2),
+	/* Cavium ThunderX, T83 pass 1.0 */
+	MIDR_REV(MIDR_THUNDERX_83XX, 0, 0),
+	{},
+};
+#endif
+
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #if	defined(CONFIG_ARM64_ERRATUM_826319) || \
 	defined(CONFIG_ARM64_ERRATUM_827319) || \
@@ -633,40 +655,16 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 #endif
 #ifdef CONFIG_CAVIUM_ERRATUM_27456
 	{
-	/* Cavium ThunderX, T88 pass 1.x - 2.1 */
 		.desc = "Cavium erratum 27456",
 		.capability = ARM64_WORKAROUND_CAVIUM_27456,
-		ERRATA_MIDR_RANGE(MIDR_THUNDERX,
-				  0, 0,
-				  1, 1),
-	},
-	{
-	/* Cavium ThunderX, T81 pass 1.0 */
-		.desc = "Cavium erratum 27456",
-		.capability = ARM64_WORKAROUND_CAVIUM_27456,
-		ERRATA_MIDR_REV(MIDR_THUNDERX_81XX, 0, 0),
+		ERRATA_MIDR_RANGE_LIST(cavium_erratum_27456_cpus),
 	},
 #endif
 #ifdef CONFIG_CAVIUM_ERRATUM_30115
 	{
-	/* Cavium ThunderX, T88 pass 1.x - 2.2 */
 		.desc = "Cavium erratum 30115",
 		.capability = ARM64_WORKAROUND_CAVIUM_30115,
-		ERRATA_MIDR_RANGE(MIDR_THUNDERX,
-				      0, 0,
-				      1, 2),
-	},
-	{
-	/* Cavium ThunderX, T81 pass 1.0 - 1.2 */
-		.desc = "Cavium erratum 30115",
-		.capability = ARM64_WORKAROUND_CAVIUM_30115,
-		ERRATA_MIDR_REV_RANGE(MIDR_THUNDERX_81XX, 0, 0, 2),
-	},
-	{
-	/* Cavium ThunderX, T83 pass 1.0 */
-		.desc = "Cavium erratum 30115",
-		.capability = ARM64_WORKAROUND_CAVIUM_30115,
-		ERRATA_MIDR_REV(MIDR_THUNDERX_83XX, 0, 0),
+		ERRATA_MIDR_RANGE_LIST(cavium_erratum_30115_cpus),
 	},
 #endif
 	{
-- 
2.7.4

