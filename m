Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35894C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD992172F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFD992172F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389677AbeHGUah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 16:30:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:48604 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbeHGUah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 16:30:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 12093AD04;
        Tue,  7 Aug 2018 18:15:02 +0000 (UTC)
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     will.deacon@arm.com, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robert.richter@cavium.com, cwu@amperecomputing.com,
        Mian Yousaf Kaukab <ykaukab@suse.de>
Subject: [PATCH 4/6] arm64: add sysfs vulnerability show for spectre v2
Date:   Tue,  7 Aug 2018 20:14:17 +0200
Message-Id: <20180807181419.15690-5-ykaukab@suse.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180807181419.15690-1-ykaukab@suse.de>
References: <20180807181419.15690-1-ykaukab@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only report mitigation present if hardening callback has been
successfully installed.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
---
 arch/arm64/kernel/cpu_errata.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 92616431ae4e..8469d3be7b15 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -481,7 +481,8 @@ multi_entry_cap_cpu_enable(const struct arm64_cpu_capabilities *entry)
 			caps->cpu_enable(caps);
 }
 
-#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+#if defined(CONFIG_HARDEN_BRANCH_PREDICTOR) || \
+	defined(CONFIG_GENERIC_CPU_VULNERABILITIES)
 
 /*
  * List of CPUs where we need to issue a psci call to
@@ -712,4 +713,35 @@ ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
 }
 
+ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	u64 pfr0;
+	struct bp_hardening_data *data;
+
+	pfr0 = read_cpuid(ID_AA64PFR0_EL1);
+	if (cpuid_feature_extract_unsigned_field(pfr0, ID_AA64PFR0_CSV2_SHIFT))
+		return sprintf(buf, "Not affected\n");
+
+	if (cpus_have_const_cap(ARM64_HARDEN_BRANCH_PREDICTOR)) {
+		/*
+		 * Hardware is vulnerable. Lets check if bp hardening callback
+		 * has been successfully installed
+		 */
+		data = arm64_get_bp_hardening_data();
+		if (data && data->fn)
+			return sprintf(buf,
+				"Mitigation: Branch predictor hardening");
+		else
+			/* For example SMCCC_VERSION_1_0 */
+			return sprintf(buf, "Vulnerable\n");
+	}
+
+	/* In case CONFIG_HARDEN_BRANCH_PREDICTOR is not enabled */
+	if (is_midr_in_range_list(read_cpuid_id(), arm64_bp_harden_smccc_cpus))
+		return sprintf(buf, "Vulnerable\n");
+
+	return sprintf(buf, "Not affected\n");
+}
+
 #endif
-- 
2.11.0

