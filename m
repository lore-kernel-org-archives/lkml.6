Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AAAECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBC020854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FBC020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731473AbeGROyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:54:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9697 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730987AbeGROy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:54:29 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 272E06796FA1F;
        Wed, 18 Jul 2018 22:16:04 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.382.0; Wed, 18 Jul 2018 22:15:57 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 6/9] scsi: hisi_sas: Implement handlers of PCIe FLR for v3 hw
Date:   Wed, 18 Jul 2018 22:14:30 +0800
Message-ID: <1531923273-193768-7-git-send-email-john.garry@huawei.com>
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

This patch implements handlers of PCIe FLR for v3 hw, reset_prepare() and
reset_done().

User can issue FLR through sysfs interface, as v3 hw support PCIe FLR.
Then if we don't implement these two handlers, our SAS controller will not
work after executing FLR.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 37 ++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 3577843..3d20fcf 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2465,6 +2465,41 @@ static pci_ers_result_t hisi_sas_slot_reset_v3_hw(struct pci_dev *pdev)
 	return PCI_ERS_RESULT_DISCONNECT;
 }
 
+static void hisi_sas_reset_prepare_v3_hw(struct pci_dev *pdev)
+{
+	struct sas_ha_struct *sha = pci_get_drvdata(pdev);
+	struct hisi_hba *hisi_hba = sha->lldd_ha;
+	struct device *dev = hisi_hba->dev;
+	int rc;
+
+	dev_info(dev, "FLR prepare\n");
+	set_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags);
+	hisi_sas_controller_reset_prepare(hisi_hba);
+
+	rc = disable_host_v3_hw(hisi_hba);
+	if (rc)
+		dev_err(dev, "FLR: disable host failed rc=%d\n", rc);
+}
+
+static void hisi_sas_reset_done_v3_hw(struct pci_dev *pdev)
+{
+	struct sas_ha_struct *sha = pci_get_drvdata(pdev);
+	struct hisi_hba *hisi_hba = sha->lldd_ha;
+	struct device *dev = hisi_hba->dev;
+	int rc;
+
+	hisi_sas_init_mem(hisi_hba);
+
+	rc = hw_init_v3_hw(hisi_hba);
+	if (rc) {
+		dev_err(dev, "FLR: hw init failed rc=%d\n", rc);
+		return;
+	}
+
+	hisi_sas_controller_reset_done(hisi_hba);
+	dev_info(dev, "FLR done\n");
+}
+
 enum {
 	/* instances of the controller */
 	hip08,
@@ -2556,6 +2591,8 @@ static int hisi_sas_v3_resume(struct pci_dev *pdev)
 	.error_detected	= hisi_sas_error_detected_v3_hw,
 	.mmio_enabled	= hisi_sas_mmio_enabled_v3_hw,
 	.slot_reset	= hisi_sas_slot_reset_v3_hw,
+	.reset_prepare	= hisi_sas_reset_prepare_v3_hw,
+	.reset_done	= hisi_sas_reset_done_v3_hw,
 };
 
 static struct pci_driver sas_v3_pci_driver = {
-- 
1.9.1

