Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9B0C6787C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 02:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FAF92098A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 02:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JL2cRDhX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PN17RrkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FAF92098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbeJMJzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 05:55:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55322 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbeJMJzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 05:55:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 479E060BFE; Sat, 13 Oct 2018 02:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539397235;
        bh=Is9RPBX3dUJkwVn3h7PwR1/BiatLF4RnifcY99EdzAg=;
        h=From:To:Cc:Subject:Date:From;
        b=JL2cRDhXV5y2RQlxxV/PijyoIra4dXADftxX97tFzT5F7cEJOJ8ysNSVHkxnGndME
         vs7oFZZzPDVNao88u3+iOZrU/3QMbLtEzSlK04NkpnX9q4xsm9j4xEfaL6Oau5ebwP
         5owJ9n/9LvnbRNhfjgebNEUScHGJWj2OcTYxLIy4=
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 70F2B6079C;
        Sat, 13 Oct 2018 02:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539397234;
        bh=Is9RPBX3dUJkwVn3h7PwR1/BiatLF4RnifcY99EdzAg=;
        h=From:To:Cc:Subject:Date:From;
        b=PN17RrkW3AyKesbR/wEcBx52hOwMTnTo4hL6tUZBPLKtA+vaKKTuVCuMJEiO5QKU7
         cgRU1usVjDI3I8R3FIhVSWYN0Et+XrLU0rSPyN0OiQAnYUYS9azWP5AS6jJZvHoxxk
         E0JclN4jcLH/NnrC0Y3z0uvxVitZr6sYkGNJ+IVw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 70F2B6079C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From:   Can Guo <cang@codeaurora.org>
To:     dianders@chromium.org, subhashj@codeaurora.org,
        asutoshd@codeaurora.org, vivek.gautam@codeaurora.org,
        evgreen@chromium.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Can Guo <cang@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 1/1] scsi: ufs: make UFS Tx lane1 clock optional for QCOM platforms
Date:   Fri, 12 Oct 2018 19:17:10 -0700
Message-Id: <1539397031-30014-1-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Venkat Gopalakrishnan <venkatg@codeaurora.org>

Per Qcom's UFS host controller HW design, the UFS Tx lane1 clock could be
muxed with Tx lane0 clock, hence keep Tx lane1 clock optional by ignoring
it if it is not provided in device tree. This change also performs some
cleanup to lanes per direction checks when enable/disable lane clocks just
for symmetry.

Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Can Guo <cang@codeaurora.org>
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
---
Changes since v3:
- Incorporated review comments from Doug.

Changes since v2:
- Incorporated review comments from Doug.

Changes since v1:
- Incorporated review comments from Doug.
- Update the commit title and commit message.

 drivers/scsi/ufs/ufs-qcom.c | 54 +++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index 2b38db2..9f9c6c7 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -79,20 +79,27 @@ static int ufs_qcom_get_connected_tx_lanes(struct ufs_hba *hba, u32 *tx_lanes)
 }
 
 static int ufs_qcom_host_clk_get(struct device *dev,
-		const char *name, struct clk **clk_out)
+		const char *name, struct clk **clk_out, bool optional)
 {
 	struct clk *clk;
 	int err = 0;
 
 	clk = devm_clk_get(dev, name);
-	if (IS_ERR(clk)) {
-		err = PTR_ERR(clk);
-		dev_err(dev, "%s: failed to get %s err %d",
-				__func__, name, err);
-	} else {
+	if (!IS_ERR(clk)) {
 		*clk_out = clk;
+		return 0;
 	}
 
+	err = PTR_ERR(clk);
+
+	if (optional && err == -ENOENT) {
+		*clk_out = NULL;
+		return 0;
+	}
+
+	if (err != -EPROBE_DEFER)
+		dev_err(dev, "failed to get %s err %d", name, err);
+
 	return err;
 }
 
@@ -113,11 +120,9 @@ static void ufs_qcom_disable_lane_clks(struct ufs_qcom_host *host)
 	if (!host->is_lane_clks_enabled)
 		return;
 
-	if (host->hba->lanes_per_direction > 1)
-		clk_disable_unprepare(host->tx_l1_sync_clk);
+	clk_disable_unprepare(host->tx_l1_sync_clk);
 	clk_disable_unprepare(host->tx_l0_sync_clk);
-	if (host->hba->lanes_per_direction > 1)
-		clk_disable_unprepare(host->rx_l1_sync_clk);
+	clk_disable_unprepare(host->rx_l1_sync_clk);
 	clk_disable_unprepare(host->rx_l0_sync_clk);
 
 	host->is_lane_clks_enabled = false;
@@ -141,24 +146,21 @@ static int ufs_qcom_enable_lane_clks(struct ufs_qcom_host *host)
 	if (err)
 		goto disable_rx_l0;
 
-	if (host->hba->lanes_per_direction > 1) {
-		err = ufs_qcom_host_clk_enable(dev, "rx_lane1_sync_clk",
+	err = ufs_qcom_host_clk_enable(dev, "rx_lane1_sync_clk",
 			host->rx_l1_sync_clk);
-		if (err)
-			goto disable_tx_l0;
+	if (err)
+		goto disable_tx_l0;
 
-		err = ufs_qcom_host_clk_enable(dev, "tx_lane1_sync_clk",
+	err = ufs_qcom_host_clk_enable(dev, "tx_lane1_sync_clk",
 			host->tx_l1_sync_clk);
-		if (err)
-			goto disable_rx_l1;
-	}
+	if (err)
+		goto disable_rx_l1;
 
 	host->is_lane_clks_enabled = true;
 	goto out;
 
 disable_rx_l1:
-	if (host->hba->lanes_per_direction > 1)
-		clk_disable_unprepare(host->rx_l1_sync_clk);
+	clk_disable_unprepare(host->rx_l1_sync_clk);
 disable_tx_l0:
 	clk_disable_unprepare(host->tx_l0_sync_clk);
 disable_rx_l0:
@@ -172,25 +174,25 @@ static int ufs_qcom_init_lane_clks(struct ufs_qcom_host *host)
 	int err = 0;
 	struct device *dev = host->hba->dev;
 
-	err = ufs_qcom_host_clk_get(dev,
-			"rx_lane0_sync_clk", &host->rx_l0_sync_clk);
+	err = ufs_qcom_host_clk_get(dev, "rx_lane0_sync_clk",
+					&host->rx_l0_sync_clk, false);
 	if (err)
 		goto out;
 
-	err = ufs_qcom_host_clk_get(dev,
-			"tx_lane0_sync_clk", &host->tx_l0_sync_clk);
+	err = ufs_qcom_host_clk_get(dev, "tx_lane0_sync_clk",
+					&host->tx_l0_sync_clk, false);
 	if (err)
 		goto out;
 
 	/* In case of single lane per direction, don't read lane1 clocks */
 	if (host->hba->lanes_per_direction > 1) {
 		err = ufs_qcom_host_clk_get(dev, "rx_lane1_sync_clk",
-			&host->rx_l1_sync_clk);
+			&host->rx_l1_sync_clk, false);
 		if (err)
 			goto out;
 
 		err = ufs_qcom_host_clk_get(dev, "tx_lane1_sync_clk",
-			&host->tx_l1_sync_clk);
+			&host->tx_l1_sync_clk, true);
 	}
 out:
 	return err;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

