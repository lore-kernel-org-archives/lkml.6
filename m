Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675E1C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD382077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PYxZkBBv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EVEJCiuS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD382077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbeJKUA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:00:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34468 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbeJKUA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 16:00:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 214E260591; Thu, 11 Oct 2018 12:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539261207;
        bh=aysgS+5CM212wCVijR7G0robII6tmYJLsVBTe0/r/aQ=;
        h=From:To:Cc:Subject:Date:From;
        b=PYxZkBBv1LykK+Qi5fFC0es2zuecGbDmedCm2RqBbNSbvRHYnXV8tlEq6iNTl9xgh
         fDv116M28dirZvA4VuhfEA10GdjpwPBMSdclicStCeytHZEwaYvFnLbMEZT6SeesPP
         SX6ar2FytOfPFsjLoHQpMgEndGKe69nzp5nl+JHw=
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3A8B560285;
        Thu, 11 Oct 2018 12:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539261205;
        bh=aysgS+5CM212wCVijR7G0robII6tmYJLsVBTe0/r/aQ=;
        h=From:To:Cc:Subject:Date:From;
        b=EVEJCiuSPpSpIptx93EzP2rr7IwrbbPhN+Gguiym6QnK2q7+PRvE404a9DE5p/H3r
         t9CUKcM6mDnz37D0E4YWkseduR0B8GuuRo6qNyOTGNqmD4L64oSWVDrFVLF/mkIrRC
         m83D5uCImJ9fi/AgtcRNwOO6am7HWKprvnH0sWZU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3A8B560285
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
Subject: [PATCH v2 1/1] scsi: ufs: make UFS Tx lane1 clock optional for QCOM platforms
Date:   Thu, 11 Oct 2018 05:33:14 -0700
Message-Id: <1539261196-14550-1-git-send-email-cang@codeaurora.org>
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
---

Changes since v1:
- Incorporated review comments from Doug.
- Update the commit title and commit message.

 drivers/scsi/ufs/ufs-qcom.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index 2b38db2..a7ec959 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -79,13 +79,19 @@ static int ufs_qcom_get_connected_tx_lanes(struct ufs_hba *hba, u32 *tx_lanes)
 }
 
 static int ufs_qcom_host_clk_get(struct device *dev,
-		const char *name, struct clk **clk_out)
+		const char *name, struct clk **clk_out, bool optional)
 {
 	struct clk *clk;
 	int err = 0;
 
 	clk = devm_clk_get(dev, name);
-	if (IS_ERR(clk)) {
+	if (clk == ERR_PTR(-EPROBE_DEFER)) {
+		err = -EPROBE_DEFER;
+		dev_warn(dev, "required clock %s hasn't probed yet, err %d\n",
+				name, err);
+	} else if (IS_ERR(clk)) {
+		if (optional)
+			return 0;
 		err = PTR_ERR(clk);
 		dev_err(dev, "%s: failed to get %s err %d",
 				__func__, name, err);
@@ -113,10 +119,10 @@ static void ufs_qcom_disable_lane_clks(struct ufs_qcom_host *host)
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
 
@@ -141,12 +147,14 @@ static int ufs_qcom_enable_lane_clks(struct ufs_qcom_host *host)
 	if (err)
 		goto disable_rx_l0;
 
-	if (host->hba->lanes_per_direction > 1) {
+	if (host->rx_l1_sync_clk) {
 		err = ufs_qcom_host_clk_enable(dev, "rx_lane1_sync_clk",
 			host->rx_l1_sync_clk);
 		if (err)
 			goto disable_tx_l0;
+	}
 
+	if (host->tx_l1_sync_clk) {
 		err = ufs_qcom_host_clk_enable(dev, "tx_lane1_sync_clk",
 			host->tx_l1_sync_clk);
 		if (err)
@@ -157,8 +165,7 @@ static int ufs_qcom_enable_lane_clks(struct ufs_qcom_host *host)
 	goto out;
 
 disable_rx_l1:
-	if (host->hba->lanes_per_direction > 1)
-		clk_disable_unprepare(host->rx_l1_sync_clk);
+	clk_disable_unprepare(host->rx_l1_sync_clk);
 disable_tx_l0:
 	clk_disable_unprepare(host->tx_l0_sync_clk);
 disable_rx_l0:
@@ -172,25 +179,25 @@ static int ufs_qcom_init_lane_clks(struct ufs_qcom_host *host)
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

