Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539D8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A0420850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10A0420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbeGROyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:54:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9698 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730869AbeGROye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:54:34 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3572F1F098290;
        Wed, 18 Jul 2018 22:16:04 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.382.0; Wed, 18 Jul 2018 22:15:58 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 9/9] scsi: hisi_sas: Add SATA FIS check for v3 hw
Date:   Wed, 18 Jul 2018 22:14:33 +0800
Message-ID: <1531923273-193768-10-git-send-email-john.garry@huawei.com>
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

From: Xiang Chen <chenxiang66@hisilicon.com>

Add a check ERR bit of status to decide whether there is something wrong
with initial register-D2H FIS. If error exist, PHY link reset the channel
to restart OOB.

Directly call work HISI_PHYE_LINK_RESET replacing disable_phy_vx_hw() and
enable_phy_vx_hw().

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  3 +--
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 10 ++++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 5a3d6a7..9c5c5a6 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3240,8 +3240,7 @@ static irqreturn_t sata_int_v2_hw(int irq_no, void *p)
 	if (fis->status & ATA_ERR) {
 		dev_warn(dev, "sata int: phy%d FIS status: 0x%x\n", phy_no,
 				fis->status);
-		disable_phy_v2_hw(hisi_hba, phy_no);
-		enable_phy_v2_hw(hisi_hba, phy_no);
+		hisi_sas_notify_phy_event(phy, HISI_PHYE_LINK_RESET);
 		res = IRQ_NONE;
 		goto end;
 	}
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 70e2299..08b503e2 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -1191,6 +1191,16 @@ static irqreturn_t phy_up_v3_hw(int phy_no, struct hisi_hba *hisi_hba)
 		dev_info(dev, "phyup: phy%d link_rate=%d(sata)\n", phy_no, link_rate);
 		initial_fis = &hisi_hba->initial_fis[phy_no];
 		fis = &initial_fis->fis;
+
+		/* check ERR bit of Status Register */
+		if (fis->status & ATA_ERR) {
+			dev_warn(dev, "sata int: phy%d FIS status: 0x%x\n",
+				 phy_no, fis->status);
+			hisi_sas_notify_phy_event(phy, HISI_PHYE_LINK_RESET);
+			res = IRQ_NONE;
+			goto end;
+		}
+
 		sas_phy->oob_mode = SATA_OOB_MODE;
 		attached_sas_addr[0] = 0x50;
 		attached_sas_addr[7] = phy_no;
-- 
1.9.1

