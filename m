Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351D4C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 04:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFD520840
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 04:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCFD520840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zoho.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbeG2GAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 02:00:41 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25890 "EHLO
        sender1.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726054AbeG2GAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 02:00:40 -0400
X-Greylist: delayed 922 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Jul 2018 02:00:39 EDT
Received: from localhost.localdomain.localdomain (115.231.19.14 [115.231.19.14]) by mx.zoho.com.cn
        with SMTPS id 1532837763388923.49301159268; Sun, 29 Jul 2018 12:16:03 +0800 (CST)
From:   oceanhe@zoho.com.cn
To:     srinivas.pandruvada@linux.intel.com, lenb@kernel.org
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ocean He <hehy1@lenovo.com>
Subject: [PATCH] cpufreq: intel_pstate: warn if HWP Native mode and OOB mode are both set
Date:   Sun, 29 Jul 2018 00:14:56 -0400
Message-Id: <1532837696-11505-1-git-send-email-oceanhe@zoho.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-ZohoCNMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ocean He <hehy1@lenovo.com>

Refer to Intel HWPM Compliance Guide (Document Number: 566474): Bit[6] or
bit[8] of MSR MISC_PWR_MGMT is set only when BIOS select either HWP Native
mode or HWP OOB mode. Bit[6] and bit[8] cannot be set both at the same
time.

Add a warning message if intel_pstate detects both HWP Native mode and
HWP OOB mode are set at the same time.

Signed-off-by: Ocean He <hehy1@lenovo.com>
---
 drivers/cpufreq/intel_pstate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 3c39712..678d3f2 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2455,8 +2455,12 @@ static bool __init intel_pstate_platform_pwr_mgmt_exists(void)
 	id = x86_match_cpu(intel_pstate_cpu_oob_ids);
 	if (id) {
 		rdmsrl(MSR_MISC_PWR_MGMT, misc_pwr);
-		if ( misc_pwr & (1 << 8))
+		if (misc_pwr & (1 << 8)) {
+			if (misc_pwr & (1 << 6))
+				pr_warn(FW_WARN
+					"HWP Native mode and OOB mode cannot be set both at the same time.\n");
 			return true;
+		}
 	}
 
 	idx = acpi_match_platform_list(plat_info);
-- 
1.8.3.1


