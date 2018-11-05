Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16343ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4E620825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4E620825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbeKEVPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:15:15 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41804 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729416AbeKEVPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:15:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA89C169E;
        Mon,  5 Nov 2018 03:55:52 -0800 (PST)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 75D803F5BD;
        Mon,  5 Nov 2018 03:55:51 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, vladimir.murzin@arm.com,
        will.deacon@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 6/7] arm64: capabilities: Use linear array for detection and verification
Date:   Mon,  5 Nov 2018 11:55:16 +0000
Message-Id: <1541418917-14219-7-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541418917-14219-1-git-send-email-suzuki.poulose@arm.com>
References: <1541418917-14219-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the sorted list of capability entries for the detection and
verification.

Cc: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 42 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 96e687e..fff430d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1508,28 +1508,25 @@ static void __init setup_elf_hwcaps(const struct arm64_cpu_capabilities *hwcaps)
 			cap_set_elf_hwcap(hwcaps);
 }
 
-static void __update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
-				      u16 scope_mask, const char *info)
+static void update_cpu_capabilities(u16 scope_mask)
 {
+	int i;
+	const struct arm64_cpu_capabilities *caps;
+
 	scope_mask &= ARM64_CPUCAP_SCOPE_MASK;
-	for (; caps->matches; caps++) {
-		if (!(caps->type & scope_mask) ||
+	for (i = 0; i < ARM64_NCAPS; i++) {
+		caps = cpu_hwcaps_ptrs[i];
+		if (!caps || !(caps->type & scope_mask) ||
+		    cpus_have_cap(caps->capability) ||
 		    !caps->matches(caps, cpucap_default_scope(caps)))
 			continue;
 
-		if (!cpus_have_cap(caps->capability) && caps->desc)
-			pr_info("%s %s\n", info, caps->desc);
+		if (caps->desc)
+			pr_info("detected: %s\n", caps->desc);
 		cpus_set_cap(caps->capability);
 	}
 }
 
-static void update_cpu_capabilities(u16 scope_mask)
-{
-	__update_cpu_capabilities(arm64_errata, scope_mask,
-				  "enabling workaround for");
-	__update_cpu_capabilities(arm64_features, scope_mask, "detected:");
-}
-
 static int __enable_cpu_capability(void *arg)
 {
 	const struct arm64_cpu_capabilities *cap = arg;
@@ -1593,16 +1590,17 @@ static void __init enable_cpu_capabilities(u16 scope_mask)
  *
  * Returns "false" on conflicts.
  */
-static bool
-__verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps,
-			u16 scope_mask)
+static bool verify_local_cpu_caps(u16 scope_mask)
 {
+	int i;
 	bool cpu_has_cap, system_has_cap;
+	const struct arm64_cpu_capabilities *caps;
 
 	scope_mask &= ARM64_CPUCAP_SCOPE_MASK;
 
-	for (; caps->matches; caps++) {
-		if (!(caps->type & scope_mask))
+	for (i = 0; i < ARM64_NCAPS; i++) {
+		caps = cpu_hwcaps_ptrs[i];
+		if (!caps || !(caps->type & scope_mask))
 			continue;
 
 		cpu_has_cap = caps->matches(caps, SCOPE_LOCAL_CPU);
@@ -1633,7 +1631,7 @@ __verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps,
 		}
 	}
 
-	if (caps->matches) {
+	if (i < ARM64_NCAPS) {
 		pr_crit("CPU%d: Detected conflict for capability %d (%s), System: %d, CPU: %d\n",
 			smp_processor_id(), caps->capability,
 			caps->desc, system_has_cap, cpu_has_cap);
@@ -1643,12 +1641,6 @@ __verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps,
 	return true;
 }
 
-static bool verify_local_cpu_caps(u16 scope_mask)
-{
-	return __verify_local_cpu_caps(arm64_errata, scope_mask) &&
-	       __verify_local_cpu_caps(arm64_features, scope_mask);
-}
-
 /*
  * Check for CPU features that are used in early boot
  * based on the Boot CPU value.
-- 
2.7.4

