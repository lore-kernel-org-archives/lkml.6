Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id NpjBHus8GlvmPAAAmS7hNA
	; Fri, 08 Jun 2018 08:23:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 34D016089E; Fri,  8 Jun 2018 08:23:55 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="lJrrgRWB"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8C7A060590;
	Fri,  8 Jun 2018 08:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8C7A060590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932489AbeFHIXu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:23:50 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:47736 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932163AbeFHITg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:19:36 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id B1A4C1E137F;
        Fri,  8 Jun 2018 10:19:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1528445973; bh=s0SY2uOlVJ0alDC6OD9teEy2sW9WSrhp8LrOQJhmOnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=lJrrgRWBXmShDZF67tfpNGG65f/pvRXZPqw+uQkTUUL3WQdQIwP/AJ2sqyexBPep8
         3uyzVBSj/RC2866cb0bsOmvyTu3ufmA0E7EPtMvjCOKA0FwZHCtr9pmfGY58vfQPpN
         j2bfuAEULV2T64TJkZt0xv4TsSTiYGuX/g5TXsck0SMWoG4WtLEBCD4w2fhRV370/s
         CbjEzBNUFJqE8vY9wKi2mCtm5Bmi2h/EBQWWff8flTmAvZtHOOQYQeWp6/aWLD5uBl
         f/9us6Ol2DZHbbMR2Sn82JyRzqlqlHMrwnK8RDtm0/oZFfQC4UK6XmKJe6pBwYRs6J
         WANxnhJXWZd+w==
Received: from pt02.synopsys.com (pt02.internal.synopsys.com [10.107.23.240])
        by mailhost.synopsys.com (Postfix) with ESMTP id A18853403;
        Fri,  8 Jun 2018 01:19:32 -0700 (PDT)
Received: from UbuntuMate-64Bits.internal.synopsys.com (gustavo-e7480.internal.synopsys.com [10.107.25.102])
        by pt02.synopsys.com (Postfix) with ESMTP id 06B243E922;
        Fri,  8 Jun 2018 09:19:32 +0100 (WEST)
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v3 04/10] PCI: dwc: Rework MSI callbacks handler
Date: Fri,  8 Jun 2018 09:19:20 +0100
Message-Id:
 <a300c2c7ca631bf4df41de4f9e0c6428c9e1c6c6.1527862777.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1527862777.git.gustavo.pimentel@synopsys.com>
References: <cover.1527862777.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1527862777.git.gustavo.pimentel@synopsys.com>
References: <cover.1527862777.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20180608081920.3eIY4NzwYrA9mhSiRyTJJQectKFVV-Kxp8wTRIMvxfc@z>

Remove duplicate defines located on pcie-designware.h file already
available on /include/uapi/linux/pci-regs.h file.

Add pci_epc_set_msi() maximum 32 interrupts validation.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Change v1->v2:
 - Nothing changed, just to follow the patch set version.
Change v2->v3:
 - Replaced wrong return value 0 to -EINVAL.

 drivers/pci/dwc/pcie-designware-ep.c | 49 ++++++++++++++++++++++++------------
 drivers/pci/dwc/pcie-designware.h    | 11 --------
 drivers/pci/endpoint/pci-epc-core.c  |  3 ++-
 3 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
index c7f2fa9..3ba7059 100644
--- a/drivers/pci/dwc/pcie-designware-ep.c
+++ b/drivers/pci/dwc/pcie-designware-ep.c
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
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index b22c5bb..a0ab12f 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
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
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index c72e656..094dcc3 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -201,7 +201,8 @@ int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts)
 	u8 encode_int;
 	unsigned long flags;
 
-	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
+	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
+	    interrupts > 32)
 		return -EINVAL;
 
 	if (!epc->ops->set_msi)
-- 
2.7.4
