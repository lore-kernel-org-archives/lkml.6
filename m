Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422897AbeCBIYT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 03:24:19 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56182 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422781AbeCBIYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 03:24:13 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4DAA160316
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From: Can Guo <cang@codeaurora.org>
To: subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Can Guo <cang@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1] scsi: ufs: add 2 lane support
Date: Fri,  2 Mar 2018 16:18:08 +0800
Message-Id: <20180302082346.8188-1-cang@codeaurora.org>
X-Mailer: git-send-email 2.15.0.windows.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Venkat Gopalakrishnan <venkatg@codeaurora.org>

Qcom ufs controller v3.1.0 supports 2 lanes, add support
to configure 2 lanes during phy initialization.

Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/ufs/ufs-qcom.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index 2b38db2..51889ad 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -113,10 +113,10 @@ static void ufs_qcom_disable_lane_clks(struct ufs_qcom_host *host)
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
 
@@ -147,18 +147,15 @@ static int ufs_qcom_enable_lane_clks(struct ufs_qcom_host *host)
 		if (err)
 			goto disable_tx_l0;
 
-		err = ufs_qcom_host_clk_enable(dev, "tx_lane1_sync_clk",
-			host->tx_l1_sync_clk);
-		if (err)
-			goto disable_rx_l1;
+		/* The tx lane1 clk could be muxed, hence keep this optional */
+		if (host->tx_l1_sync_clk)
+			ufs_qcom_host_clk_enable(dev, "tx_lane1_sync_clk",
+						 host->tx_l1_sync_clk);
 	}
 
 	host->is_lane_clks_enabled = true;
 	goto out;
 
-disable_rx_l1:
-	if (host->hba->lanes_per_direction > 1)
-		clk_disable_unprepare(host->rx_l1_sync_clk);
 disable_tx_l0:
 	clk_disable_unprepare(host->tx_l0_sync_clk);
 disable_rx_l0:
@@ -189,8 +186,9 @@ static int ufs_qcom_init_lane_clks(struct ufs_qcom_host *host)
 		if (err)
 			goto out;
 
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
