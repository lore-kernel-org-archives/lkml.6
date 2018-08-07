Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC24C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966252172E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 966252172E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389514AbeHGUag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 16:30:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:48556 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727572AbeHGUaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 16:30:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A32F6ACD3;
        Tue,  7 Aug 2018 18:15:00 +0000 (UTC)
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     will.deacon@arm.com, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robert.richter@cavium.com, cwu@amperecomputing.com,
        Mian Yousaf Kaukab <ykaukab@suse.de>
Subject: [PATCH 1/6] arm64: kpti: move check for non-vulnerable CPUs to a function
Date:   Tue,  7 Aug 2018 20:14:14 +0200
Message-Id: <20180807181419.15690-2-ykaukab@suse.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180807181419.15690-1-ykaukab@suse.de>
References: <20180807181419.15690-1-ykaukab@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare to call it in generic cpu vulnerabilities support.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
---
 arch/arm64/include/asm/cpufeature.h | 16 ++++++++++++++++
 arch/arm64/kernel/cpufeature.c      |  9 +--------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 1717ba1db35d..0b0b5b3e36ba 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -530,6 +530,22 @@ void arm64_set_ssbd_mitigation(bool state);
 static inline void arm64_set_ssbd_mitigation(bool state) {}
 #endif
 
+static inline bool is_cpu_meltdown_safe(void)
+{
+	/* List of CPUs that are not vulnerable and don't need KPTI */
+	static const struct midr_range kpti_safe_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
+		MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
+		{ /* sentinel */ }
+	};
+
+	/* Don't force KPTI for CPUs that are not vulnerable */
+	if (is_midr_in_range_list(read_cpuid_id(), kpti_safe_list))
+		return true;
+
+	return false;
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index e238b7932096..6a94f8bce35a 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -865,12 +865,6 @@ static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
 static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 				int scope)
 {
-	/* List of CPUs that are not vulnerable and don't need KPTI */
-	static const struct midr_range kpti_safe_list[] = {
-		MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
-		MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
-		{ /* sentinel */ }
-	};
 	char const *str = "command line option";
 
 	/*
@@ -894,8 +888,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
 		return true;
 
-	/* Don't force KPTI for CPUs that are not vulnerable */
-	if (is_midr_in_range_list(read_cpuid_id(), kpti_safe_list))
+	if (is_cpu_meltdown_safe())
 		return false;
 
 	/* Defer to CPU feature registers */
-- 
2.11.0

