Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id h05CCto9GVvtRQAAmS7hNA
	; Thu, 07 Jun 2018 14:16:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 36D2D608B8; Thu,  7 Jun 2018 14:16:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DB80B6063F;
	Thu,  7 Jun 2018 14:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB80B6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933341AbeFGOQX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:16:23 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39557 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933101AbeFGOJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:14 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbD-0005Zk-FH; Thu, 07 Jun 2018 15:09:11 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbA-00039q-Fr; Thu, 07 Jun 2018 15:09:08 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Shawn Lin" <shawn.lin@rock-chips.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.493710855@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 302/410] mmc: dw_mmc: Factor out dw_mci_init_slot_caps
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Shawn Lin <shawn.lin@rock-chips.com>

commit a4faa4929ed3be15e2d500d2405f992f6dedc8eb upstream.

Factor out dw_mci_init_slot_caps to consolidate parsing
all differents types of capabilities from host contrllers.
No functional change intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Fixes: 800d78bfccb3 ("mmc: dw_mmc: add support for implementation specific callbacks")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[bwh: Backported to 3.16:
 - We don't set MMC_CAP_ERASE or MMC_CAP2_SDIO_IRQ_NOTHREAD capabilities
 - Fold in required changes to the exit path from commits 51da2240906c
   "mmc: dw_mmc: use mmc_regulator_get_supply to handle regulators" and
   3cf890fc42b2 "mmc: dw_mmc: Pass back errors from mmc_of_parse()"
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2044,12 +2044,40 @@ static struct device_node *dw_mci_of_fin
 }
 #endif /* CONFIG_OF */
 
+static int dw_mci_init_slot_caps(struct dw_mci_slot *slot)
+{
+	struct dw_mci *host = slot->host;
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
+	struct mmc_host *mmc = slot->mmc;
+	int ctrl_id;
+
+	if (host->pdata->caps)
+		mmc->caps = host->pdata->caps;
+
+	if (host->pdata->pm_caps)
+		mmc->pm_caps = host->pdata->pm_caps;
+
+	if (host->dev->of_node) {
+		ctrl_id = of_alias_get_id(host->dev->of_node, "mshc");
+		if (ctrl_id < 0)
+			ctrl_id = 0;
+	} else {
+		ctrl_id = to_platform_device(host->dev)->id;
+	}
+	if (drv_data && drv_data->caps)
+		mmc->caps |= drv_data->caps[ctrl_id];
+
+	if (host->pdata->caps2)
+		mmc->caps2 = host->pdata->caps2;
+
+	return 0;
+}
+
 static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 {
 	struct mmc_host *mmc;
 	struct dw_mci_slot *slot;
-	const struct dw_mci_drv_data *drv_data = host->drv_data;
-	int ctrl_id, ret;
+	int ret;
 	u32 freq[2];
 
 	mmc = mmc_alloc_host(sizeof(struct dw_mci_slot), host->dev);
@@ -2076,27 +2104,12 @@ static int dw_mci_init_slot(struct dw_mc
 
 	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
 
-	if (host->pdata->caps)
-		mmc->caps = host->pdata->caps;
-
-	if (host->pdata->pm_caps)
-		mmc->pm_caps = host->pdata->pm_caps;
-
-	if (host->dev->of_node) {
-		ctrl_id = of_alias_get_id(host->dev->of_node, "mshc");
-		if (ctrl_id < 0)
-			ctrl_id = 0;
-	} else {
-		ctrl_id = to_platform_device(host->dev)->id;
-	}
-	if (drv_data && drv_data->caps)
-		mmc->caps |= drv_data->caps[ctrl_id];
-
-	if (host->pdata->caps2)
-		mmc->caps2 = host->pdata->caps2;
-
 	mmc_of_parse(mmc);
 
+	ret = dw_mci_init_slot_caps(slot);
+	if (ret)
+		goto err_host_allocated;
+
 	if (host->pdata->blk_settings) {
 		mmc->max_segs = host->pdata->blk_settings->max_segs;
 		mmc->max_blk_size = host->pdata->blk_settings->max_blk_size;
@@ -2127,7 +2140,7 @@ static int dw_mci_init_slot(struct dw_mc
 
 	ret = mmc_add_host(mmc);
 	if (ret)
-		goto err_setup_bus;
+		goto err_host_allocated;
 
 #if defined(CONFIG_DEBUG_FS)
 	dw_mci_init_debugfs(slot);
@@ -2138,9 +2151,9 @@ static int dw_mci_init_slot(struct dw_mc
 
 	return 0;
 
-err_setup_bus:
+err_host_allocated:
 	mmc_free_host(mmc);
-	return -EINVAL;
+	return ret;
 }
 
 static void dw_mci_cleanup_slot(struct dw_mci_slot *slot, unsigned int id)
