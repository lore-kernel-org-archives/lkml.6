Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB9BC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D575120825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D575120825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbeKEVPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:15:07 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41772 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729047AbeKEVPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:15:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64F82EBD;
        Mon,  5 Nov 2018 03:55:44 -0800 (PST)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E0DFD3F5BD;
        Mon,  5 Nov 2018 03:55:42 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, vladimir.murzin@arm.com,
        will.deacon@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH 1/7] arm64: capabilities: Merge entries for ARM64_WORKAROUND_CLEAN_CACHE
Date:   Mon,  5 Nov 2018 11:55:11 +0000
Message-Id: <1541418917-14219-2-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541418917-14219-1-git-send-email-suzuki.poulose@arm.com>
References: <1541418917-14219-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have two entries for ARM64_WORKAROUND_CLEAN_CACHE capability :

1) ARM Errata 826319, 827319, 824069, 819472 on A53 r0p[012]
2) ARM Errata 819472 on A53 r0p[01]

Both have the same work around. Merge these entries to avoid
duplicate entries for a single capability.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpu_errata.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index a509e351..c825bc0 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -573,24 +573,19 @@ static const struct midr_range arm64_harden_el2_vectors[] = {
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #if	defined(CONFIG_ARM64_ERRATUM_826319) || \
 	defined(CONFIG_ARM64_ERRATUM_827319) || \
-	defined(CONFIG_ARM64_ERRATUM_824069)
+	defined(CONFIG_ARM64_ERRATUM_824069) || \
+	defined(CONFIG_ARM64_ERRATUM_819472)
 	{
-	/* Cortex-A53 r0p[012] */
-		.desc = "ARM errata 826319, 827319, 824069",
+	/*
+	 * Cortex-A53 r0p[012]: ARM errata 826319, 827319, 824069
+	 * Cortex-A53 r0p[01] : ARM errata 819472
+	 */
+		.desc = "ARM errata 826319, 827319, 824069, 819472",
 		.capability = ARM64_WORKAROUND_CLEAN_CACHE,
 		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A53, 0, 0, 2),
 		.cpu_enable = cpu_enable_cache_maint_trap,
 	},
 #endif
-#ifdef CONFIG_ARM64_ERRATUM_819472
-	{
-	/* Cortex-A53 r0p[01] */
-		.desc = "ARM errata 819472",
-		.capability = ARM64_WORKAROUND_CLEAN_CACHE,
-		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A53, 0, 0, 1),
-		.cpu_enable = cpu_enable_cache_maint_trap,
-	},
-#endif
 #ifdef CONFIG_ARM64_ERRATUM_832075
 	{
 	/* Cortex-A57 r0p0 - r1p2 */
-- 
2.7.4

