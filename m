Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF028C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B9B20834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:18:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B9B20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeLAE2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:28:31 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60978 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727588AbeLAE2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 23:28:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 849E6165C;
        Fri, 30 Nov 2018 09:18:32 -0800 (PST)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DB0883F5A0;
        Fri, 30 Nov 2018 09:18:30 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, will.deacon@arm.com,
        catalin.marinas@arm.com, dave.martin@arm.com, mark.rutland@arm.com,
        vladimir.murzin@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Christopher Covington <cov@codeaurora.org>
Subject: [PATCH v2 3/7] arm64: capabilities: Merge duplicate entries for Qualcomm erratum 1003
Date:   Fri, 30 Nov 2018 17:18:02 +0000
Message-Id: <1543598286-2663-4-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543598286-2663-1-git-send-email-suzuki.poulose@arm.com>
References: <1543598286-2663-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate entries for Qualcomm erratum 1003. Since the entries
are not purely based on generic MIDR checks, use the multi_cap_entry
type to merge the entries.

Cc: Christopher Covington <cov@codeaurora.org>
Cc: Will Deacon <will.deacon@arm.com>
Reviewed-by: Vladimiri Murzin <vladimir.murzin@arm.com>
Tested-by: Vladimiri Murzin <vladimir.murzin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpu_errata.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index bff8fa8..0ef4bb9 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -592,6 +592,19 @@ static const struct midr_range cavium_erratum_30115_cpus[] = {
 };
 #endif
 
+#ifdef CONFIG_QCOM_FALKOR_ERRATUM_1003
+static const struct arm64_cpu_capabilities qcom_erratum_1003_list[] = {
+	{
+		ERRATA_MIDR_REV(MIDR_QCOM_FALKOR_V1, 0, 0),
+	},
+	{
+		.midr_range.model = MIDR_QCOM_KRYO,
+		.matches = is_kryo_midr,
+	},
+	{},
+};
+#endif
+
 #ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
 static const struct midr_range workaround_clean_cache[] = {
 #if	defined(CONFIG_ARM64_ERRATUM_826319) || \
@@ -685,16 +698,10 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	},
 #ifdef CONFIG_QCOM_FALKOR_ERRATUM_1003
 	{
-		.desc = "Qualcomm Technologies Falkor erratum 1003",
+		.desc = "Qualcomm Technologies Falkor/Kryo erratum 1003",
 		.capability = ARM64_WORKAROUND_QCOM_FALKOR_E1003,
-		ERRATA_MIDR_REV(MIDR_QCOM_FALKOR_V1, 0, 0),
-	},
-	{
-		.desc = "Qualcomm Technologies Kryo erratum 1003",
-		.capability = ARM64_WORKAROUND_QCOM_FALKOR_E1003,
-		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
-		.midr_range.model = MIDR_QCOM_KRYO,
-		.matches = is_kryo_midr,
+		.matches = multi_entry_cap_matches,
+		.match_list = qcom_erratum_1003_list,
 	},
 #endif
 #ifdef CONFIG_QCOM_FALKOR_ERRATUM_1009
-- 
2.7.4

