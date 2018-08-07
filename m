Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C62AC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BCD72172E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BCD72172E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389814AbeHGUat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 16:30:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:48624 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389446AbeHGUah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 16:30:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8F463AD82;
        Tue,  7 Aug 2018 18:15:02 +0000 (UTC)
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     will.deacon@arm.com, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robert.richter@cavium.com, cwu@amperecomputing.com,
        Mian Yousaf Kaukab <ykaukab@suse.de>
Subject: [PATCH 5/6] arm64: add sysfs vulnerability show for speculative store bypass
Date:   Tue,  7 Aug 2018 20:14:18 +0200
Message-Id: <20180807181419.15690-6-ykaukab@suse.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180807181419.15690-1-ykaukab@suse.de>
References: <20180807181419.15690-1-ykaukab@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return status based no ssbd_state. Return string "Unknown" in case
CONFIG_ARM64_SSBD is disabled or arch workaround2 is not available
in the firmware.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
---
 arch/arm64/kernel/cpu_errata.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 8469d3be7b15..8b60aa30a3fa 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -744,4 +744,24 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "Not affected\n");
 }
 
+ssize_t cpu_show_spec_store_bypass(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	switch (arm64_get_ssbd_state()) {
+	case ARM64_SSBD_MITIGATED:
+		return sprintf(buf, "Not affected\n");
+
+	case ARM64_SSBD_KERNEL:
+	case ARM64_SSBD_FORCE_ENABLE:
+		return sprintf(buf,
+			"Mitigation: Speculative Store Bypass disabled");
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
2.11.0

