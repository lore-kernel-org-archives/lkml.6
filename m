Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F9CECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1980020850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1980020850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbeGROyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:54:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9695 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731246AbeGROyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:54:31 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 43CCBDFABF429;
        Wed, 18 Jul 2018 22:16:04 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.382.0; Wed, 18 Jul 2018 22:15:56 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 4/9] scsi: hisi_sas: tidy host controller reset function a bit
Date:   Wed, 18 Jul 2018 22:14:28 +0800
Message-ID: <1531923273-193768-5-git-send-email-john.garry@huawei.com>
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

This patch tidies host controller reset function by putting some code to
two new functions, and exports these two functions out, so that they could
be used by FLR feature to be realised.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h      |  3 ++
 drivers/scsi/hisi_sas/hisi_sas_main.c | 61 ++++++++++++++++++++++-------------
 2 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index 0ff9115..6c7d2e2 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -320,6 +320,7 @@ struct hisi_hba {
 	const struct hisi_sas_hw *hw;	/* Low level hw interface */
 	unsigned long sata_dev_bitmap[BITS_TO_LONGS(HISI_SAS_MAX_DEVICES)];
 	struct work_struct rst_work;
+	u32 phy_state;
 };
 
 /* Generic HW DMA host memory structures */
@@ -480,4 +481,6 @@ extern bool hisi_sas_notify_phy_event(struct hisi_sas_phy *phy,
 				enum hisi_sas_phy_event event);
 extern void hisi_sas_release_tasks(struct hisi_hba *hisi_hba);
 extern u8 hisi_sas_get_prog_phy_linkrate_mask(enum sas_linkrate max);
+extern void hisi_sas_controller_reset_prepare(struct hisi_hba *hisi_hba);
+extern void hisi_sas_controller_reset_done(struct hisi_hba *hisi_hba);
 #endif
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index ed671af..b0bcd14 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1309,22 +1309,12 @@ static void hisi_sas_terminate_stp_reject(struct hisi_hba *hisi_hba)
 	}
 }
 
-static int hisi_sas_controller_reset(struct hisi_hba *hisi_hba)
+void hisi_sas_controller_reset_prepare(struct hisi_hba *hisi_hba)
 {
-	struct device *dev = hisi_hba->dev;
 	struct Scsi_Host *shost = hisi_hba->shost;
-	u32 old_state, state;
-	int rc;
-
-	if (!hisi_hba->hw->soft_reset)
-		return -1;
-
-	if (test_and_set_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags))
-		return -1;
 
 	down(&hisi_hba->sem);
-	dev_info(dev, "controller resetting...\n");
-	old_state = hisi_hba->hw->get_phys_state(hisi_hba);
+	hisi_hba->phy_state = hisi_hba->hw->get_phys_state(hisi_hba);
 
 	scsi_block_requests(shost);
 	hisi_hba->hw->wait_cmds_complete_timeout(hisi_hba, 100, 5000);
@@ -1333,15 +1323,13 @@ static int hisi_sas_controller_reset(struct hisi_hba *hisi_hba)
 		del_timer_sync(&hisi_hba->timer);
 
 	set_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags);
-	rc = hisi_hba->hw->soft_reset(hisi_hba);
-	if (rc) {
-		dev_warn(dev, "controller reset failed (%d)\n", rc);
-		clear_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags);
-		up(&hisi_hba->sem);
-		scsi_unblock_requests(shost);
-		clear_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags);
-		return rc;
-	}
+}
+EXPORT_SYMBOL_GPL(hisi_sas_controller_reset_prepare);
+
+void hisi_sas_controller_reset_done(struct hisi_hba *hisi_hba)
+{
+	struct Scsi_Host *shost = hisi_hba->shost;
+	u32 state;
 
 	/* Init and wait for PHYs to come up and all libsas event finished. */
 	hisi_hba->hw->phys_init(hisi_hba);
@@ -1357,7 +1345,36 @@ static int hisi_sas_controller_reset(struct hisi_hba *hisi_hba)
 	clear_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags);
 
 	state = hisi_hba->hw->get_phys_state(hisi_hba);
-	hisi_sas_rescan_topology(hisi_hba, old_state, state);
+	hisi_sas_rescan_topology(hisi_hba, hisi_hba->phy_state, state);
+}
+EXPORT_SYMBOL_GPL(hisi_sas_controller_reset_done);
+
+static int hisi_sas_controller_reset(struct hisi_hba *hisi_hba)
+{
+	struct device *dev = hisi_hba->dev;
+	struct Scsi_Host *shost = hisi_hba->shost;
+	int rc;
+
+	if (!hisi_hba->hw->soft_reset)
+		return -1;
+
+	if (test_and_set_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags))
+		return -1;
+
+	dev_info(dev, "controller resetting...\n");
+	hisi_sas_controller_reset_prepare(hisi_hba);
+
+	rc = hisi_hba->hw->soft_reset(hisi_hba);
+	if (rc) {
+		dev_warn(dev, "controller reset failed (%d)\n", rc);
+		clear_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags);
+		up(&hisi_hba->sem);
+		scsi_unblock_requests(shost);
+		clear_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags);
+		return rc;
+	}
+
+	hisi_sas_controller_reset_done(hisi_hba);
 	dev_info(dev, "controller reset complete\n");
 
 	return 0;
-- 
1.9.1

