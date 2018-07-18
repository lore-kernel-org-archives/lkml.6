Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD68ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A223620850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A223620850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731527AbeGROzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:55:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9691 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731037AbeGROy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:54:27 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D19062DA4D696;
        Wed, 18 Jul 2018 22:16:03 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.382.0; Wed, 18 Jul 2018 22:15:56 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 5/9] scsi: hisi_sas: relocate some common code for v3 hw
Date:   Wed, 18 Jul 2018 22:14:29 +0800
Message-ID: <1531923273-193768-6-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531923273-193768-1-git-send-email-john.garry@huawei.com>
References: <1531923273-193768-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaofei Tan <tanxiaofei@huawei.com>

Much code of PM suspend function also exists in soft reset function. This
is not concise. So, this patch relocates the common code of these two
functions to a separate function.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 50 ++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 70a6aa2..3577843 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -210,6 +210,8 @@
 
 #define AXI_MASTER_CFG_BASE		(0x5000)
 #define AM_CTRL_GLOBAL			(0x0)
+#define AM_CTRL_SHUTDOWN_REQ_OFF	0
+#define AM_CTRL_SHUTDOWN_REQ_MSK	(0x1 << AM_CTRL_SHUTDOWN_REQ_OFF)
 #define AM_CURR_TRANS_RETURN	(0x150)
 
 #define AM_CFG_MAX_TRANS		(0x5010)
@@ -1976,11 +1978,11 @@ static void phy_get_events_v3_hw(struct hisi_hba *hisi_hba, int phy_no)
 
 }
 
-static int soft_reset_v3_hw(struct hisi_hba *hisi_hba)
+static int disable_host_v3_hw(struct hisi_hba *hisi_hba)
 {
 	struct device *dev = hisi_hba->dev;
+	u32 status, reg_val;
 	int rc;
-	u32 status;
 
 	interrupt_disable_v3_hw(hisi_hba);
 	hisi_sas_write32(hisi_hba, DLVRY_QUEUE_ENABLE, 0x0);
@@ -1990,14 +1992,32 @@ static int soft_reset_v3_hw(struct hisi_hba *hisi_hba)
 
 	mdelay(10);
 
-	hisi_sas_write32(hisi_hba, AXI_MASTER_CFG_BASE + AM_CTRL_GLOBAL, 0x1);
+	reg_val = hisi_sas_read32(hisi_hba, AXI_MASTER_CFG_BASE +
+				  AM_CTRL_GLOBAL);
+	reg_val |= AM_CTRL_SHUTDOWN_REQ_MSK;
+	hisi_sas_write32(hisi_hba, AXI_MASTER_CFG_BASE +
+			 AM_CTRL_GLOBAL, reg_val);
 
 	/* wait until bus idle */
 	rc = hisi_sas_read32_poll_timeout(AXI_MASTER_CFG_BASE +
 					  AM_CURR_TRANS_RETURN, status,
 					  status == 0x3, 10, 100);
 	if (rc) {
-		dev_err(dev, "axi bus is not idle, rc = %d\n", rc);
+		dev_err(dev, "axi bus is not idle, rc=%d\n", rc);
+		return rc;
+	}
+
+	return 0;
+}
+
+static int soft_reset_v3_hw(struct hisi_hba *hisi_hba)
+{
+	struct device *dev = hisi_hba->dev;
+	int rc;
+
+	rc = disable_host_v3_hw(hisi_hba);
+	if (rc) {
+		dev_err(dev, "soft reset: disable host failed rc=%d\n", rc);
 		return rc;
 	}
 
@@ -2456,9 +2476,8 @@ static int hisi_sas_v3_suspend(struct pci_dev *pdev, pm_message_t state)
 	struct hisi_hba *hisi_hba = sha->lldd_ha;
 	struct device *dev = hisi_hba->dev;
 	struct Scsi_Host *shost = hisi_hba->shost;
-	u32 device_state, status;
+	u32 device_state;
 	int rc;
-	u32 reg_val;
 
 	if (!pdev->pm_cap) {
 		dev_err(dev, "PCI PM not supported\n");
@@ -2471,25 +2490,10 @@ static int hisi_sas_v3_suspend(struct pci_dev *pdev, pm_message_t state)
 	scsi_block_requests(shost);
 	set_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags);
 	flush_workqueue(hisi_hba->wq);
-	/* disable DQ/PHY/bus */
-	interrupt_disable_v3_hw(hisi_hba);
-	hisi_sas_write32(hisi_hba, DLVRY_QUEUE_ENABLE, 0x0);
-	hisi_sas_kill_tasklets(hisi_hba);
 
-	hisi_sas_stop_phys(hisi_hba);
-
-	reg_val = hisi_sas_read32(hisi_hba, AXI_MASTER_CFG_BASE +
-		AM_CTRL_GLOBAL);
-	reg_val |= 0x1;
-	hisi_sas_write32(hisi_hba, AXI_MASTER_CFG_BASE +
-		AM_CTRL_GLOBAL, reg_val);
-
-	/* wait until bus idle */
-	rc = hisi_sas_read32_poll_timeout(AXI_MASTER_CFG_BASE +
-					  AM_CURR_TRANS_RETURN, status,
-					  status == 0x3, 10, 100);
+	rc = disable_host_v3_hw(hisi_hba);
 	if (rc) {
-		dev_err(dev, "axi bus is not idle, rc = %d\n", rc);
+		dev_err(dev, "PM suspend: disable host failed rc=%d\n", rc);
 		clear_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags);
 		clear_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags);
 		scsi_unblock_requests(shost);
-- 
1.9.1

