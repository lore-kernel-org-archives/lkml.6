Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBED2C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50DB218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbfAYOWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:22:43 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2766 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728917AbfAYOWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 09:22:07 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5FA1568C4132576BA01C;
        Fri, 25 Jan 2019 22:21:59 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.408.0; Fri, 25 Jan 2019 22:21:51 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 05/13] scsi: hisi_sas: shutdown axi bus to avoid exception CQ returned
Date:   Fri, 25 Jan 2019 22:22:31 +0800
Message-ID: <1548426159-225679-6-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1548426159-225679-1-git-send-email-john.garry@huawei.com>
References: <1548426159-225679-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

When injecting 2 bit ECC error, it will cause fatal AXI interrupts. Before
the recovery of SAS controller reset, the internal of SAS controller is in
error. If CQ interrupts return at the time, actually it is exception CQ
interrupt, and it may cause resource release in disorder.

To avoid the exception situation, shutdown AXI bus after fatal AXI
interrupt. In SAS controller reset, it will restart AXI bus. For later
version of v3 hw, hardware will shutdown AXI bus for this situation, so just
fix current ver of v3 hw.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 726ac4bd..d5eabfc 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -1646,6 +1646,7 @@ static irqreturn_t fatal_axi_int_v3_hw(int irq_no, void *p)
 	u32 irq_value, irq_msk;
 	struct hisi_hba *hisi_hba = p;
 	struct device *dev = hisi_hba->dev;
+	struct pci_dev *pdev = hisi_hba->pci_dev;
 	int i;
 
 	irq_msk = hisi_sas_read32(hisi_hba, ENT_INT_SRC_MSK3);
@@ -1677,6 +1678,17 @@ static irqreturn_t fatal_axi_int_v3_hw(int irq_no, void *p)
 				error->msg, irq_value);
 			queue_work(hisi_hba->wq, &hisi_hba->rst_work);
 		}
+
+		if (pdev->revision < 0x21) {
+			u32 reg_val;
+
+			reg_val = hisi_sas_read32(hisi_hba,
+						  AXI_MASTER_CFG_BASE +
+						  AM_CTRL_GLOBAL);
+			reg_val |= AM_CTRL_SHUTDOWN_REQ_MSK;
+			hisi_sas_write32(hisi_hba, AXI_MASTER_CFG_BASE +
+					 AM_CTRL_GLOBAL, reg_val);
+		}
 	}
 
 	if (irq_value & BIT(ENT_INT_SRC3_ITC_INT_OFF)) {
-- 
1.9.1

