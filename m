Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E031C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5981B20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5981B20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbeKIXpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:45:52 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:47741 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728236AbeKIXpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:45:51 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E1BA5692CA548;
        Fri,  9 Nov 2018 22:05:04 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Fri, 9 Nov 2018 22:04:55 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Xiang Chen <chenxiang66@hisilicon.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 2/5] scsi: hisi_sas: Add support for interrupt converge for v3 hw
Date:   Fri, 9 Nov 2018 22:06:33 +0800
Message-ID: <1541772396-161814-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1541772396-161814-1-git-send-email-john.garry@huawei.com>
References: <1541772396-161814-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

If CQ_INT_CONVERGE_EN is enabled, the interrupts of all the 16 CQ queues
will be reported by CQ0.

So we need to change the process of CQ tasklet for this situation.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 68a6ec2..10d1651 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -42,6 +42,7 @@
 #define MAX_CON_TIME_LIMIT_TIME		0xa4
 #define BUS_INACTIVE_LIMIT_TIME		0xa8
 #define REJECT_TO_OPEN_LIMIT_TIME	0xac
+#define CQ_INT_CONVERGE_EN		0xb0
 #define CFG_AGING_TIME			0xbc
 #define HGC_DFX_CFG2			0xc0
 #define CFG_ABT_SET_QUERY_IPTT	0xd4
@@ -371,6 +372,9 @@ struct hisi_sas_err_record_v3 {
 	((fis.command == ATA_CMD_DEV_RESET) && \
 	((fis.control & ATA_SRST) != 0)))
 
+static bool hisi_sas_intr_conv;
+MODULE_PARM_DESC(intr_conv, "interrupt converge enable (0-1)");
+
 static u32 hisi_sas_read32(struct hisi_hba *hisi_hba, u32 off)
 {
 	void __iomem *regs = hisi_hba->regs + off;
@@ -436,6 +440,8 @@ static void init_reg_v3_hw(struct hisi_hba *hisi_hba)
 	hisi_sas_write32(hisi_hba, INT_COAL_EN, 0x1);
 	hisi_sas_write32(hisi_hba, OQ_INT_COAL_TIME, 0x1);
 	hisi_sas_write32(hisi_hba, OQ_INT_COAL_CNT, 0x1);
+	hisi_sas_write32(hisi_hba, CQ_INT_CONVERGE_EN,
+			 hisi_sas_intr_conv);
 	hisi_sas_write32(hisi_hba, OQ_INT_SRC, 0xffff);
 	hisi_sas_write32(hisi_hba, ENT_INT_SRC1, 0xffffffff);
 	hisi_sas_write32(hisi_hba, ENT_INT_SRC2, 0xffffffff);
@@ -1880,10 +1886,12 @@ static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
 	for (i = 0; i < hisi_hba->queue_count; i++) {
 		struct hisi_sas_cq *cq = &hisi_hba->cq[i];
 		struct tasklet_struct *t = &cq->tasklet;
+		int nr = hisi_sas_intr_conv ? 16 : 16 + i;
+		unsigned long irqflags = hisi_sas_intr_conv ? IRQF_SHARED : 0;
 
-		rc = devm_request_irq(dev, pci_irq_vector(pdev, i+16),
-					  cq_interrupt_v3_hw, 0,
-					  DRV_NAME " cq", cq);
+		rc = devm_request_irq(dev, pci_irq_vector(pdev, nr),
+				      cq_interrupt_v3_hw, irqflags,
+				      DRV_NAME " cq", cq);
 		if (rc) {
 			dev_err(dev,
 				"could not request cq%d interrupt, rc=%d\n",
@@ -1900,8 +1908,9 @@ static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
 free_cq_irqs:
 	for (k = 0; k < i; k++) {
 		struct hisi_sas_cq *cq = &hisi_hba->cq[k];
+		int nr = hisi_sas_intr_conv ? 16 : 16 + k;
 
-		free_irq(pci_irq_vector(pdev, k+16), cq);
+		free_irq(pci_irq_vector(pdev, nr), cq);
 	}
 	free_irq(pci_irq_vector(pdev, 11), hisi_hba);
 free_chnl_interrupt:
@@ -2091,8 +2100,16 @@ static void wait_cmds_complete_timeout_v3_hw(struct hisi_hba *hisi_hba,
 	dev_dbg(dev, "wait commands complete %dms\n", time);
 }
 
+static ssize_t intr_conv_v3_hw_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%u\n", hisi_sas_intr_conv);
+}
+static DEVICE_ATTR_RO(intr_conv_v3_hw);
+
 struct device_attribute *host_attrs_v3_hw[] = {
 	&dev_attr_phy_event_threshold,
+	&dev_attr_intr_conv_v3_hw,
 	NULL
 };
 
@@ -2308,8 +2325,9 @@ struct device_attribute *host_attrs_v3_hw[] = {
 	free_irq(pci_irq_vector(pdev, 11), hisi_hba);
 	for (i = 0; i < hisi_hba->queue_count; i++) {
 		struct hisi_sas_cq *cq = &hisi_hba->cq[i];
+		int nr = hisi_sas_intr_conv ? 16 : 16 + i;
 
-		free_irq(pci_irq_vector(pdev, i+16), cq);
+		free_irq(pci_irq_vector(pdev, nr), cq);
 	}
 	pci_free_irq_vectors(pdev);
 }
@@ -2631,6 +2649,7 @@ static int hisi_sas_v3_resume(struct pci_dev *pdev)
 };
 
 module_pci_driver(sas_v3_pci_driver);
+module_param_named(intr_conv, hisi_sas_intr_conv, bool, 0444);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("John Garry <john.garry@huawei.com>");
-- 
1.9.1

