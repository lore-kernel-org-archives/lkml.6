Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F34EC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 04:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D818E2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 04:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KQRmLHat";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KQRmLHat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D818E2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbeJHLod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 07:44:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40508 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725760AbeJHLod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 07:44:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E4A6B60C62; Mon,  8 Oct 2018 04:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538973288;
        bh=g4MtXne5Kbhz0irwNFy3uq+4cp9ucn8ThsYOHZ8o9fI=;
        h=From:To:Cc:Subject:Date:From;
        b=KQRmLHat96OirHp+aGAN3HsiHsQZfxFx2dK1t+Xxja2/0v/C0wEtmisE0BBD4uhc/
         wMLW9O7rdr+nbEmzQWTy3yQfAQwKXvgIHjrmgCCkaeujTUJSrdW+rXqlLcv82QBRLQ
         eft6P+MDwxbXmMB05rLq8QgkDWwuWtzywbYEDWtY=
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7425E6031A;
        Mon,  8 Oct 2018 04:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538973288;
        bh=g4MtXne5Kbhz0irwNFy3uq+4cp9ucn8ThsYOHZ8o9fI=;
        h=From:To:Cc:Subject:Date:From;
        b=KQRmLHat96OirHp+aGAN3HsiHsQZfxFx2dK1t+Xxja2/0v/C0wEtmisE0BBD4uhc/
         wMLW9O7rdr+nbEmzQWTy3yQfAQwKXvgIHjrmgCCkaeujTUJSrdW+rXqlLcv82QBRLQ
         eft6P+MDwxbXmMB05rLq8QgkDWwuWtzywbYEDWtY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7425E6031A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From:   Can Guo <cang@codeaurora.org>
To:     subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        evgreen@chromium.org, vinholikatti@gmail.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Can Guo <cang@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/1] scsi: ufs: make UFS Tx lane1 clock optional
Date:   Sun,  7 Oct 2018 21:34:34 -0700
Message-Id: <1538973275-5961-1-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Venkat Gopalakrishnan <venkatg@codeaurora.org>

The UFS Tx lane1 clock could be muxed, hence keep it optional by ignoring
it if it is not provided in device tree.

Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/ufs/ufs-qcom.c | 46 ++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index 2b38db2..a6e2ed3 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -85,13 +85,10 @@ static int ufs_qcom_host_clk_get(struct device *dev,
 	int err = 0;
 
 	clk = devm_clk_get(dev, name);
-	if (IS_ERR(clk)) {
+	if (IS_ERR(clk))
 		err = PTR_ERR(clk);
-		dev_err(dev, "%s: failed to get %s err %d",
-				__func__, name, err);
-	} else {
+	else
 		*clk_out = clk;
-	}
 
 	return err;
 }
@@ -113,10 +110,10 @@ static void ufs_qcom_disable_lane_clks(struct ufs_qcom_host *host)
 	if (!host->is_lane_clks_enabled)
 		return;
 
-	if (host->hba->lanes_per_direction > 1)
+	if (host->tx_l1_sync_clk)
 		clk_disable_unprepare(host->tx_l1_sync_clk);
 	clk_disable_unprepare(host->tx_l0_sync_clk);
-	if (host->hba->lanes_per_direction > 1)
+	if (host->rx_l1_sync_clk)
 		clk_disable_unprepare(host->rx_l1_sync_clk);
 	clk_disable_unprepare(host->rx_l0_sync_clk);
 
@@ -141,24 +138,21 @@ static int ufs_qcom_enable_lane_clks(struct ufs_qcom_host *host)
 	if (err)
 		goto disable_rx_l0;
 
-	if (host->hba->lanes_per_direction > 1) {
+	if (host->rx_l1_sync_clk) {
 		err = ufs_qcom_host_clk_enable(dev, "rx_lane1_sync_clk",
 			host->rx_l1_sync_clk);
 		if (err)
 			goto disable_tx_l0;
-
-		err = ufs_qcom_host_clk_enable(dev, "tx_lane1_sync_clk",
-			host->tx_l1_sync_clk);
-		if (err)
-			goto disable_rx_l1;
 	}
 
+	/* The tx lane1 clk could be muxed, hence keep this optional */
+	if (host->tx_l1_sync_clk)
+		ufs_qcom_host_clk_enable(dev, "tx_lane1_sync_clk",
+					 host->tx_l1_sync_clk);
+
 	host->is_lane_clks_enabled = true;
 	goto out;
 
-disable_rx_l1:
-	if (host->hba->lanes_per_direction > 1)
-		clk_disable_unprepare(host->rx_l1_sync_clk);
 disable_tx_l0:
 	clk_disable_unprepare(host->tx_l0_sync_clk);
 disable_rx_l0:
@@ -174,23 +168,33 @@ static int ufs_qcom_init_lane_clks(struct ufs_qcom_host *host)
 
 	err = ufs_qcom_host_clk_get(dev,
 			"rx_lane0_sync_clk", &host->rx_l0_sync_clk);
-	if (err)
+	if (err) {
+		dev_err(dev, "%s: failed to get rx_lane0_sync_clk, err %d",
+				__func__, err);
 		goto out;
+	}
 
 	err = ufs_qcom_host_clk_get(dev,
 			"tx_lane0_sync_clk", &host->tx_l0_sync_clk);
-	if (err)
+	if (err) {
+		dev_err(dev, "%s: failed to get tx_lane0_sync_clk, err %d",
+				__func__, err);
 		goto out;
+	}
 
 	/* In case of single lane per direction, don't read lane1 clocks */
 	if (host->hba->lanes_per_direction > 1) {
 		err = ufs_qcom_host_clk_get(dev, "rx_lane1_sync_clk",
 			&host->rx_l1_sync_clk);
-		if (err)
+		if (err) {
+			dev_err(dev, "%s: failed to get rx_lane1_sync_clk, err %d",
+					__func__, err);
 			goto out;
+		}
 
-		err = ufs_qcom_host_clk_get(dev, "tx_lane1_sync_clk",
-			&host->tx_l1_sync_clk);
+		/* The tx lane1 clk could be muxed, hence keep this optional */
+		ufs_qcom_host_clk_get(dev, "tx_lane1_sync_clk",
+					&host->tx_l1_sync_clk);
 	}
 out:
 	return err;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

