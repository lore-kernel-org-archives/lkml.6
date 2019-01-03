Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF446C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9329420815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbfACAtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 19:49:43 -0500
Received: from foss.arm.com ([217.140.101.70]:39854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730253AbfACAtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 19:49:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17BFA1596;
        Wed,  2 Jan 2019 16:49:39 -0800 (PST)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com [10.118.12.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 415EF3F5AF;
        Wed,  2 Jan 2019 16:49:38 -0800 (PST)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        suzuki.poulose@arm.com, dave.martin@arm.com,
        shankerd@codeaurora.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, ykaukab@suse.de,
        julien.thierry@arm.com, mlangsdo@redhat.com, steven.price@arm.com,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v2 6/7] arm64: add sysfs vulnerability show for speculative store bypass
Date:   Wed,  2 Jan 2019 18:49:20 -0600
Message-Id: <20190103004921.1928921-7-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190103004921.1928921-1-jeremy.linton@arm.com>
References: <20190103004921.1928921-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mian Yousaf Kaukab <ykaukab@suse.de>

Return status based on ssbd_state and the arm64 SSBS feature.
Return string "Unknown" in case CONFIG_ARM64_SSBD is disabled
or arch workaround2 is not available in the firmware.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
[Added SSBS logic]
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/cpu_errata.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 96a55accefa9..c962b5856c87 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -420,6 +420,7 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
 		ssbd_state = ARM64_SSBD_UNKNOWN;
 		return false;
 
+	/* machines with mixed mitigation requirements must not return this */
 	case SMCCC_RET_NOT_REQUIRED:
 		pr_info_once("%s mitigation not required\n", entry->desc);
 		ssbd_state = ARM64_SSBD_MITIGATED;
@@ -810,4 +811,31 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
 	}
 }
 
+ssize_t cpu_show_spec_store_bypass(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	/*
+	 *  Two assumptions: First, get_ssbd_state() reflects the worse case
+	 *  for hetrogenous machines, and that if SSBS is supported its
+	 *  supported by all cores.
+	 */
+	switch (arm64_get_ssbd_state()) {
+	case ARM64_SSBD_MITIGATED:
+		return sprintf(buf, "Not affected\n");
+
+	case ARM64_SSBD_KERNEL:
+	case ARM64_SSBD_FORCE_ENABLE:
+		if (cpus_have_cap(ARM64_SSBS))
+			return sprintf(buf, "Not affected\n");
+		return sprintf(buf,
+			"Mitigation: Speculative Store Bypass disabled\n");
+
+	case ARM64_SSBD_FORCE_DISABLE:
+		return sprintf(buf, "Vulnerable\n");
+
+	default: /* ARM64_SSBD_UNKNOWN*/
+		return sprintf(buf, "Unknown\n");
+	}
+}
+
 #endif
-- 
2.17.2

