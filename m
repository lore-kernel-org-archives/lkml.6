Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C853C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA62B20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="D9BRCI+U";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Vzu2PHc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA62B20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeIDOmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:42:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39746 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbeIDOmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:42:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1CC10607B5; Tue,  4 Sep 2018 10:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536056257;
        bh=srtV9DP2y2RSfnhEhVMD+XaRuINYvEdNxB4iTyqdyss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D9BRCI+UN1fd3kiOlbfWgbk4Akj1Z/BvMU4N44k/ssVLacbm0jcL8nFwCBlsNYsDn
         5qpKovR3HgAQJIDQluGqAXfRpyfgx76otW6GGTEkC6tOg2T3SSCw1leHy0Fwxu+eUB
         +7sKU5LRnM4PBa9++NLWHWIMIapAYPPJa+/bWPVc=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8EDF160710;
        Tue,  4 Sep 2018 10:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536056256;
        bh=srtV9DP2y2RSfnhEhVMD+XaRuINYvEdNxB4iTyqdyss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vzu2PHc3U++bhwhpbgFI1dQmZqE5Tngpy3KPDEB21rf4dEp28gn7LCObJWVBKEnk4
         kiJVMg43G5YhbPIGNTJ2V4WWrbpms1qQjrIzE3s4QHWSzQSaJKua630jMJsCLu+Ng7
         mPX+80OWlFoO83boJH6ifGr6FVEY+KVlAGMCNAbc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8EDF160710
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     kishon@ti.com, vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     subhashj@codeaurora.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH 1/3] phy: qcom-ufs: Remove stale methods that handle ref clk
Date:   Tue,  4 Sep 2018 15:47:17 +0530
Message-Id: <20180904101719.18049-2-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20180904101719.18049-1-vivek.gautam@codeaurora.org>
References: <20180904101719.18049-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove ufs_qcom_phy_enable/(disable)_dev_ref_clk() that
are not being used by any code.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 drivers/phy/qualcomm/phy-qcom-ufs.c | 50 -------------------------------------
 include/linux/phy/phy-qcom-ufs.h    | 14 -----------
 2 files changed, 64 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-ufs.c b/drivers/phy/qualcomm/phy-qcom-ufs.c
index c5493ea51282..f2979ccad00a 100644
--- a/drivers/phy/qualcomm/phy-qcom-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-ufs.c
@@ -431,56 +431,6 @@ static void ufs_qcom_phy_disable_ref_clk(struct ufs_qcom_phy *phy)
 	}
 }
 
-#define UFS_REF_CLK_EN	(1 << 5)
-
-static void ufs_qcom_phy_dev_ref_clk_ctrl(struct phy *generic_phy, bool enable)
-{
-	struct ufs_qcom_phy *phy = get_ufs_qcom_phy(generic_phy);
-
-	if (phy->dev_ref_clk_ctrl_mmio &&
-	    (enable ^ phy->is_dev_ref_clk_enabled)) {
-		u32 temp = readl_relaxed(phy->dev_ref_clk_ctrl_mmio);
-
-		if (enable)
-			temp |= UFS_REF_CLK_EN;
-		else
-			temp &= ~UFS_REF_CLK_EN;
-
-		/*
-		 * If we are here to disable this clock immediately after
-		 * entering into hibern8, we need to make sure that device
-		 * ref_clk is active atleast 1us after the hibern8 enter.
-		 */
-		if (!enable)
-			udelay(1);
-
-		writel_relaxed(temp, phy->dev_ref_clk_ctrl_mmio);
-		/* ensure that ref_clk is enabled/disabled before we return */
-		wmb();
-		/*
-		 * If we call hibern8 exit after this, we need to make sure that
-		 * device ref_clk is stable for atleast 1us before the hibern8
-		 * exit command.
-		 */
-		if (enable)
-			udelay(1);
-
-		phy->is_dev_ref_clk_enabled = enable;
-	}
-}
-
-void ufs_qcom_phy_enable_dev_ref_clk(struct phy *generic_phy)
-{
-	ufs_qcom_phy_dev_ref_clk_ctrl(generic_phy, true);
-}
-EXPORT_SYMBOL_GPL(ufs_qcom_phy_enable_dev_ref_clk);
-
-void ufs_qcom_phy_disable_dev_ref_clk(struct phy *generic_phy)
-{
-	ufs_qcom_phy_dev_ref_clk_ctrl(generic_phy, false);
-}
-EXPORT_SYMBOL_GPL(ufs_qcom_phy_disable_dev_ref_clk);
-
 /* Turn ON M-PHY RMMI interface clocks */
 static int ufs_qcom_phy_enable_iface_clk(struct ufs_qcom_phy *phy)
 {
diff --git a/include/linux/phy/phy-qcom-ufs.h b/include/linux/phy/phy-qcom-ufs.h
index 0a2c18a9771d..9dd85071bcce 100644
--- a/include/linux/phy/phy-qcom-ufs.h
+++ b/include/linux/phy/phy-qcom-ufs.h
@@ -17,20 +17,6 @@
 
 #include "phy.h"
 
-/**
- * ufs_qcom_phy_enable_dev_ref_clk() - Enable the device
- * ref clock.
- * @phy: reference to a generic phy.
- */
-void ufs_qcom_phy_enable_dev_ref_clk(struct phy *phy);
-
-/**
- * ufs_qcom_phy_disable_dev_ref_clk() - Disable the device
- * ref clock.
- * @phy: reference to a generic phy.
- */
-void ufs_qcom_phy_disable_dev_ref_clk(struct phy *phy);
-
 int ufs_qcom_phy_set_tx_lane_enable(struct phy *phy, u32 tx_lanes);
 void ufs_qcom_phy_save_controller_version(struct phy *phy,
 			u8 major, u16 minor, u16 step);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

