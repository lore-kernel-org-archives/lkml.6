Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE605C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A6C20874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="REY5dTQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A6C20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932819AbeFTQbl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:31:41 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:52401 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932220AbeFTQ2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:28:44 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id BFCC61E15FA;
        Wed, 20 Jun 2018 18:28:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1529512122; bh=NtcVQ4VIQRkyL2GVsYUQLBBExXRyPTaHt9gmkO1IoBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=REY5dTQU0O8JfFJXn7IpHEeg2Upg19GW9sKrnyNV7xqSVVFXKxZo4BLcmRYN9lBul
         MF6ki/UxQRGOr62IqGgGeqlADXJVv2YWEUFewVKz23VTx/DU/hphORPLgNpfeo5PBP
         dOToiLN6cUqEdFpRz/KUfs4F2i0qh6q5vw/JiRkOp397WDYcUp5MEM5FTNGqVEzr+L
         +N0ediA3TGgb1e+E0AIm87fEIpvbCMfUejJ4rQjQ66XoK41WKxoFh//MZXdD0EQQ5k
         V9vDZTXamW1n4iexJ0OV0RgPlaWAmTbM93PiTCv8rgBYW5n7WHX6zvXakxVEz5GfPh
         zHCHrMxuPshcg==
Received: from pt02.synopsys.com (pt02.synopsys.com [10.107.23.240])
        by mailhost.synopsys.com (Postfix) with ESMTP id E7A4C3A0C;
        Wed, 20 Jun 2018 09:28:41 -0700 (PDT)
Received: from UbuntuMate-64Bits.internal.synopsys.com (gustavo-e7480.internal.synopsys.com [10.107.25.102])
        by pt02.synopsys.com (Postfix) with ESMTP id 0E1FC3D4F4;
        Wed, 20 Jun 2018 17:28:41 +0100 (WEST)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com, sboyd@codeaurora.org
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v5 04/11] PCI: dwc: Rework MSI callbacks handler
Date:   Wed, 20 Jun 2018 17:28:26 +0100
Message-Id: <0b2b5dc028fd0b92263edc097f182246901d6c0d.1529507416.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1529507416.git.gustavo.pimentel@synopsys.com>
References: <cover.1529507416.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1529507416.git.gustavo.pimentel@synopsys.com>
References: <cover.1529507416.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate defines located on pcie-designware.h file already
available on /include/uapi/linux/pci-regs.h file.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Change v1->v2:
 - Nothing changed, just to follow the patch set version.
Change v2->v3:
 - Replaced wrong return value 0 to -EINVAL.
Change v3->v4:
 - Rebased to Lorenzo's master branch v4.18-rc1.
Change v4->v5:
 - Moved pci_epc_set_msi maximum interrupts validation into a new patch
file #11.

 drivers/pci/controller/dwc/pcie-designware-ep.c | 49 +++++++++++++++++--------
 drivers/pci/controller/dwc/pcie-designware.h    | 11 ------
 2 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index bbe75d7..1f98db3 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -246,29 +246,38 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no,
 
 static int dw_pcie_ep_get_msi(struct pci_epc *epc, u8 func_no)
 {
-	int val;
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	u32 val, reg;
+
+	if (!ep->msi_cap)
+		return -EINVAL;
 
-	val = dw_pcie_readw_dbi(pci, MSI_MESSAGE_CONTROL);
-	if (!(val & MSI_CAP_MSI_EN_MASK))
+	reg = ep->msi_cap + PCI_MSI_FLAGS;
+	val = dw_pcie_readw_dbi(pci, reg);
+	if (!(val & PCI_MSI_FLAGS_ENABLE))
 		return -EINVAL;
 
-	val = (val & MSI_CAP_MME_MASK) >> MSI_CAP_MME_SHIFT;
+	val = (val & PCI_MSI_FLAGS_QSIZE) >> 4;
+
 	return val;
 }
 
-static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 encode_int)
+static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts)
 {
-	int val;
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	u32 val, reg;
 
-	val = dw_pcie_readw_dbi(pci, MSI_MESSAGE_CONTROL);
-	val &= ~MSI_CAP_MMC_MASK;
-	val |= (encode_int << MSI_CAP_MMC_SHIFT) & MSI_CAP_MMC_MASK;
+	if (!ep->msi_cap)
+		return -EINVAL;
+
+	reg = ep->msi_cap + PCI_MSI_FLAGS;
+	val = dw_pcie_readw_dbi(pci, reg);
+	val &= ~PCI_MSI_FLAGS_QMASK;
+	val |= (interrupts << 1) & PCI_MSI_FLAGS_QMASK;
 	dw_pcie_dbi_ro_wr_en(pci);
-	dw_pcie_writew_dbi(pci, MSI_MESSAGE_CONTROL, val);
+	dw_pcie_writew_dbi(pci, reg, val);
 	dw_pcie_dbi_ro_wr_dis(pci);
 
 	return 0;
@@ -367,21 +376,29 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct pci_epc *epc = ep->epc;
 	u16 msg_ctrl, msg_data;
-	u32 msg_addr_lower, msg_addr_upper;
+	u32 msg_addr_lower, msg_addr_upper, reg;
 	u64 msg_addr;
 	bool has_upper;
 	int ret;
 
+	if (!ep->msi_cap)
+		return -EINVAL;
+
 	/* Raise MSI per the PCI Local Bus Specification Revision 3.0, 6.8.1. */
-	msg_ctrl = dw_pcie_readw_dbi(pci, MSI_MESSAGE_CONTROL);
+	reg = ep->msi_cap + PCI_MSI_FLAGS;
+	msg_ctrl = dw_pcie_readw_dbi(pci, reg);
 	has_upper = !!(msg_ctrl & PCI_MSI_FLAGS_64BIT);
-	msg_addr_lower = dw_pcie_readl_dbi(pci, MSI_MESSAGE_ADDR_L32);
+	reg = ep->msi_cap + PCI_MSI_ADDRESS_LO;
+	msg_addr_lower = dw_pcie_readl_dbi(pci, reg);
 	if (has_upper) {
-		msg_addr_upper = dw_pcie_readl_dbi(pci, MSI_MESSAGE_ADDR_U32);
-		msg_data = dw_pcie_readw_dbi(pci, MSI_MESSAGE_DATA_64);
+		reg = ep->msi_cap + PCI_MSI_ADDRESS_HI;
+		msg_addr_upper = dw_pcie_readl_dbi(pci, reg);
+		reg = ep->msi_cap + PCI_MSI_DATA_64;
+		msg_data = dw_pcie_readw_dbi(pci, reg);
 	} else {
 		msg_addr_upper = 0;
-		msg_data = dw_pcie_readw_dbi(pci, MSI_MESSAGE_DATA_32);
+		reg = ep->msi_cap + PCI_MSI_DATA_32;
+		msg_data = dw_pcie_readw_dbi(pci, reg);
 	}
 	msg_addr = ((u64) msg_addr_upper) << 32 | msg_addr_lower;
 	ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys, msg_addr,
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index b22c5bb..a0ab12f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -96,17 +96,6 @@
 #define PCIE_GET_ATU_INB_UNR_REG_OFFSET(region)				\
 			((0x3 << 20) | ((region) << 9) | (0x1 << 8))
 
-#define MSI_MESSAGE_CONTROL		0x52
-#define MSI_CAP_MMC_SHIFT		1
-#define MSI_CAP_MMC_MASK		(7 << MSI_CAP_MMC_SHIFT)
-#define MSI_CAP_MME_SHIFT		4
-#define MSI_CAP_MSI_EN_MASK		0x1
-#define MSI_CAP_MME_MASK		(7 << MSI_CAP_MME_SHIFT)
-#define MSI_MESSAGE_ADDR_L32		0x54
-#define MSI_MESSAGE_ADDR_U32		0x58
-#define MSI_MESSAGE_DATA_32		0x58
-#define MSI_MESSAGE_DATA_64		0x5C
-
 #define MAX_MSI_IRQS			256
 #define MAX_MSI_IRQS_PER_CTRL		32
 #define MAX_MSI_CTRLS			(MAX_MSI_IRQS / MAX_MSI_IRQS_PER_CTRL)
-- 
2.7.4


