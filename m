Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02ACC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB6720643
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730132AbfB0RZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:25:32 -0500
Received: from mga14.intel.com ([192.55.52.115]:44139 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730070AbfB0RZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:25:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 09:25:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,420,1544515200"; 
   d="scan'208";a="303030802"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by orsmga005.jf.intel.com with ESMTP; 27 Feb 2019 09:25:30 -0800
From:   thor.thayer@linux.intel.com
To:     bp@alien8.de, dinguyen@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, mchehab@kernel.org
Cc:     thor.thayer@linux.intel.com, devicetree@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCHv2 5/5] EDAC, altera: Remove Stratix10 Machine compatible check
Date:   Wed, 27 Feb 2019 11:27:25 -0600
Message-Id: <1551288445-22335-6-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551288445-22335-1-git-send-email-thor.thayer@linux.intel.com>
References: <1551288445-22335-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Replace the Stratix10 Machine compatible check with
specific ECC block compatible tests.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
v2 New patch
---
 drivers/edac/altera_edac.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index a92259d8afdc..3ff222a0c852 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1013,11 +1013,6 @@ static int socfpga_is_a10(void)
 	return of_machine_is_compatible("altr,socfpga-arria10");
 }
 
-static int socfpga_is_s10(void)
-{
-	return of_machine_is_compatible("altr,socfpga-stratix10");
-}
-
 static __init int __maybe_unused
 altr_init_a10_ecc_block(struct device_node *np, u32 irq_mask,
 			u32 ecc_ctrl_en_mask, bool dual_port)
@@ -1122,13 +1117,14 @@ static int __init __maybe_unused altr_init_a10_ecc_device_type(char *compat)
 	int irq;
 	struct device_node *child, *np;
 
-	if (!socfpga_is_a10() && !socfpga_is_s10())
-		return -ENODEV;
-
 	np = of_find_compatible_node(NULL, NULL,
 				     "altr,socfpga-a10-ecc-manager");
 	if (!np) {
-		edac_printk(KERN_ERR, EDAC_DEVICE, "ECC Manager not found\n");
+		/* Error only valid for Arria10 and Stratix10 */
+		if (!of_find_compatible_node(NULL, NULL,
+					     "altr,socfpga-ecc-manager"))
+			edac_printk(KERN_ERR, EDAC_DEVICE,
+				    "ECC Manager not found\n");
 		return -ENODEV;
 	}
 
@@ -1644,12 +1640,8 @@ static int __init socfpga_init_sdmmc_ecc(void)
 	int rc = -ENODEV;
 	struct device_node *child;
 
-	if (!socfpga_is_a10() && !socfpga_is_s10())
-		return -ENODEV;
-
 	child = of_find_compatible_node(NULL, NULL, "altr,socfpga-sdmmc-ecc");
 	if (!child) {
-		edac_printk(KERN_WARNING, EDAC_DEVICE, "SDMMC node not found\n");
 		return -ENODEV;
 	}
 
-- 
2.7.4

