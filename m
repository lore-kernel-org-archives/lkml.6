Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53240C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25FB220832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25FB220832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbeK1Tog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 14:44:36 -0500
Received: from 8bytes.org ([81.169.241.247]:50636 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727954AbeK1Tof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 14:44:35 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 2E5DA445; Wed, 28 Nov 2018 09:43:44 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@kv.home.8bytes.org>
Subject: [PATCH 2/3] iommu/amd: Fix line-break in error log reporting
Date:   Wed, 28 Nov 2018 09:43:41 +0100
Message-Id: <20181128084342.16363-3-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181128084342.16363-1-joro@8bytes.org>
References: <20181128084342.16363-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <joro@kv.home.8bytes.org>

With the switch to dev_err for reporting errors from the
iommu log there was an unwanted newline introduced. The
reason was that the reporting was done in multiple dev_err()
calls, and dev_err adds a newline after every call.

Fix it by printing the log messages with only one dev_err()
call.

Signed-off-by: Joerg Roedel <joro@kv.home.8bytes.org>
---
 drivers/iommu/amd_iommu.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 9b96b424add4..7f38eab5aef4 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -540,7 +540,7 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
 		dev_data = get_dev_data(&pdev->dev);
 
 	if (dev_data && __ratelimit(&dev_data->rs)) {
-		dev_err(&pdev->dev, "AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%016llx flags=0x%04x]\n",
+		dev_err(&pdev->dev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%016llx flags=0x%04x]\n",
 			domain_id, address, flags);
 	} else if (printk_ratelimit()) {
 		pr_err("Event logged [IO_PAGE_FAULT device=%02x:%02x.%x domain=0x%04x address=0x%016llx flags=0x%04x]\n",
@@ -580,43 +580,41 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 	if (type == EVENT_TYPE_IO_FAULT) {
 		amd_iommu_report_page_fault(devid, pasid, address, flags);
 		return;
-	} else {
-		dev_err(dev, "AMD-Vi: Event logged [");
 	}
 
 	switch (type) {
 	case EVENT_TYPE_ILL_DEV:
-		dev_err(dev, "ILLEGAL_DEV_TABLE_ENTRY device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
+		dev_err(dev, "Event logged [ILLEGAL_DEV_TABLE_ENTRY device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			pasid, address, flags);
 		dump_dte_entry(devid);
 		break;
 	case EVENT_TYPE_DEV_TAB_ERR:
-		dev_err(dev, "DEV_TAB_HARDWARE_ERROR device=%02x:%02x.%x "
+		dev_err(dev, "Event logged [DEV_TAB_HARDWARE_ERROR device=%02x:%02x.%x "
 			"address=0x%016llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			address, flags);
 		break;
 	case EVENT_TYPE_PAGE_TAB_ERR:
-		dev_err(dev, "PAGE_TAB_HARDWARE_ERROR device=%02x:%02x.%x domain=0x%04x address=0x%016llx flags=0x%04x]\n",
+		dev_err(dev, "Event logged [PAGE_TAB_HARDWARE_ERROR device=%02x:%02x.%x domain=0x%04x address=0x%016llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			pasid, address, flags);
 		break;
 	case EVENT_TYPE_ILL_CMD:
-		dev_err(dev, "ILLEGAL_COMMAND_ERROR address=0x%016llx]\n", address);
+		dev_err(dev, "Event logged [ILLEGAL_COMMAND_ERROR address=0x%016llx]\n", address);
 		dump_command(address);
 		break;
 	case EVENT_TYPE_CMD_HARD_ERR:
-		dev_err(dev, "COMMAND_HARDWARE_ERROR address=0x%016llx flags=0x%04x]\n",
+		dev_err(dev, "Event logged [COMMAND_HARDWARE_ERROR address=0x%016llx flags=0x%04x]\n",
 			address, flags);
 		break;
 	case EVENT_TYPE_IOTLB_INV_TO:
-		dev_err(dev, "IOTLB_INV_TIMEOUT device=%02x:%02x.%x address=0x%016llx]\n",
+		dev_err(dev, "Event logged [IOTLB_INV_TIMEOUT device=%02x:%02x.%x address=0x%016llx]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			address);
 		break;
 	case EVENT_TYPE_INV_DEV_REQ:
-		dev_err(dev, "INVALID_DEVICE_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
+		dev_err(dev, "Event logged [INVALID_DEVICE_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			pasid, address, flags);
 		break;
@@ -624,12 +622,12 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 		pasid = ((event[0] >> 16) & 0xFFFF)
 			| ((event[1] << 6) & 0xF0000);
 		tag = event[1] & 0x03FF;
-		dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
+		dev_err(dev, "Event logged [INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			pasid, address, flags);
 		break;
 	default:
-		dev_err(dev, "UNKNOWN event[0]=0x%08x event[1]=0x%08x event[2]=0x%08x event[3]=0x%08x\n",
+		dev_err(dev, "Event logged [UNKNOWN event[0]=0x%08x event[1]=0x%08x event[2]=0x%08x event[3]=0x%08x\n",
 			event[0], event[1], event[2], event[3]);
 	}
 
-- 
2.17.1

