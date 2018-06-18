Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C72C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774A5208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BvOatrYh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 774A5208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965173AbeFRPEI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:04:08 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:42211 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964922AbeFRPBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:01:03 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id DE24A1E15FA;
        Mon, 18 Jun 2018 17:01:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1529334062; bh=FN23/dEHolaKQU5iHptZ1+obJDIx+nsMlHAcMASxZ98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=BvOatrYhJyP3ZXt73KM3OS865dYf7B7OJKScdXkSvmG8d+iB/fj8C6yb5IAsPWKZD
         lBcL70oE2YvSGCz68Q7P7zt+MGZsaq0OvS/IUOtwGGHgV2/BnaDpTTWSAhwdeTB587
         8z705l2lJmwgxfogJ2lWmh4LZDt2Gr5WdfWzoQo70vX1oPrpb/okOXgNCfcWwzDwCV
         tMvZDxjJhb2OxDkz216/eEq5vCNmAUW/At2sG9ulzTDul0FKc8GFj3so5NpshYuld/
         UX5GU0miOGmn0amf2d6StdJCBN/5HEMBtuccYLBH2oSEWq3SzQj4QnyOZgvvK54r9H
         NCACK0d/rMsVA==
Received: from pt02.synopsys.com (pt02.synopsys.com [10.107.23.240])
        by mailhost.synopsys.com (Postfix) with ESMTP id A831F3680;
        Mon, 18 Jun 2018 08:01:00 -0700 (PDT)
Received: from UbuntuMate-64Bits.internal.synopsys.com (gustavo-e7480.internal.synopsys.com [10.107.25.102])
        by pt02.synopsys.com (Postfix) with ESMTP id 0B9643D744;
        Mon, 18 Jun 2018 16:01:00 +0100 (WEST)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v4 02/10] PCI: dwc: Add MSI-X callbacks handler
Date:   Mon, 18 Jun 2018 16:00:21 +0100
Message-Id: <5beae521c5ee475b1c0e04f5eec07d0120b0fa2b.1529329262.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1529329262.git.gustavo.pimentel@synopsys.com>
References: <cover.1529329262.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1529329262.git.gustavo.pimentel@synopsys.com>
References: <cover.1529329262.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCIe config space capability search function.

Add sysfs set/get interface to allow the change of EP MSI-X maximum number.

Add EP MSI-X callback for triggering interruptions.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Change v1->v2:
 - Nothing changed, just to follow the patch set version.
Change v2->v3:
 - Moved dra7xx_pcie_raise_irq() signature change to patch file #3.
 - Moved artpec6_pcie_raise_irq() signature change to patch file #3.
 - Replaced wrong return value 0 to -EINVAL.
 - Removed an else if by code refactoring.
 - Reduced the size of ioremap_nocache mapping from ep->addr_size to
PCI_MSIX_ENTRY_SIZE.
 - Fixed a small bug. If the MSI-X vector bit has been set, the function
would return without executing the proper unmap.
Change v3->v4:
 - Rebased to Lorenzo's master branch v4.18-rc1.
 - Added static prefix to __dw_pcie_ep_find_next_cap function.

 drivers/pci/controller/dwc/pcie-designware-ep.c   | 146 +++++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware-plat.c |   4 +-
 drivers/pci/controller/dwc/pcie-designware.h      |  14 ++-
 3 files changed, 161 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 8650416..ad25654 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -40,6 +40,39 @@ void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
 	__dw_pcie_ep_reset_bar(pci, bar, 0);
 }
 
+static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
+			      u8 cap)
+{
+	u8 cap_id, next_cap_ptr;
+	u16 reg;
+
+	reg = dw_pcie_readw_dbi(pci, cap_ptr);
+	next_cap_ptr = (reg & 0xff00) >> 8;
+	cap_id = (reg & 0x00ff);
+
+	if (!next_cap_ptr || cap_id > PCI_CAP_ID_MAX)
+		return 0;
+
+	if (cap_id == cap)
+		return cap_ptr;
+
+	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
+}
+
+u8 dw_pcie_ep_find_capability(struct dw_pcie *pci, u8 cap)
+{
+	u8 next_cap_ptr;
+	u16 reg;
+
+	reg = dw_pcie_readw_dbi(pci, PCI_CAPABILITY_LIST);
+	next_cap_ptr = (reg & 0x00ff);
+
+	if (!next_cap_ptr)
+		return 0;
+
+	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
+}
+
 static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no,
 				   struct pci_epf_header *hdr)
 {
@@ -241,8 +274,47 @@ static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 encode_int)
 	return 0;
 }
 
+static int dw_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	u32 val, reg;
+
+	if (!ep->msix_cap)
+		return -EINVAL;
+
+	reg = ep->msix_cap + PCI_MSIX_FLAGS;
+	val = dw_pcie_readw_dbi(pci, reg);
+	if (!(val & PCI_MSIX_FLAGS_ENABLE))
+		return -EINVAL;
+
+	val &= PCI_MSIX_FLAGS_QSIZE;
+
+	return val;
+}
+
+static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	u32 val, reg;
+
+	if (!ep->msix_cap)
+		return -EINVAL;
+
+	reg = ep->msix_cap + PCI_MSIX_FLAGS;
+	val = dw_pcie_readw_dbi(pci, reg);
+	val &= ~PCI_MSIX_FLAGS_QSIZE;
+	val |= interrupts;
+	dw_pcie_dbi_ro_wr_en(pci);
+	dw_pcie_writew_dbi(pci, reg, val);
+	dw_pcie_dbi_ro_wr_dis(pci);
+
+	return 0;
+}
+
 static int dw_pcie_ep_raise_irq(struct pci_epc *epc, u8 func_no,
-				enum pci_epc_irq_type type, u8 interrupt_num)
+				enum pci_epc_irq_type type, u16 interrupt_num)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 
@@ -282,6 +354,8 @@ static const struct pci_epc_ops epc_ops = {
 	.unmap_addr		= dw_pcie_ep_unmap_addr,
 	.set_msi		= dw_pcie_ep_set_msi,
 	.get_msi		= dw_pcie_ep_get_msi,
+	.set_msix		= dw_pcie_ep_set_msix,
+	.get_msix		= dw_pcie_ep_get_msix,
 	.raise_irq		= dw_pcie_ep_raise_irq,
 	.start			= dw_pcie_ep_start,
 	.stop			= dw_pcie_ep_stop,
@@ -322,6 +396,64 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 	return 0;
 }
 
+int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
+			     u16 interrupt_num)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct pci_epc *epc = ep->epc;
+	u16 tbl_offset, bir;
+	u32 bar_addr_upper, bar_addr_lower;
+	u32 msg_addr_upper, msg_addr_lower;
+	u32 reg, msg_data, vec_ctrl;
+	u64 tbl_addr, msg_addr, reg_u64;
+	void __iomem *msix_tbl;
+	int ret;
+
+	reg = ep->msix_cap + PCI_MSIX_TABLE;
+	tbl_offset = dw_pcie_readl_dbi(pci, reg);
+	bir = (tbl_offset & PCI_MSIX_TABLE_BIR);
+	tbl_offset &= PCI_MSIX_TABLE_OFFSET;
+	tbl_offset >>= 3;
+
+	reg = PCI_BASE_ADDRESS_0 + (4 * bir);
+	bar_addr_upper = 0;
+	bar_addr_lower = dw_pcie_readl_dbi(pci, reg);
+	reg_u64 = (bar_addr_lower & PCI_BASE_ADDRESS_MEM_TYPE_MASK);
+	if (reg_u64 == PCI_BASE_ADDRESS_MEM_TYPE_64)
+		bar_addr_upper = dw_pcie_readl_dbi(pci, reg + 4);
+
+	tbl_addr = ((u64) bar_addr_upper) << 32 | bar_addr_lower;
+	tbl_addr += (tbl_offset + ((interrupt_num - 1) * PCI_MSIX_ENTRY_SIZE));
+	tbl_addr &= PCI_BASE_ADDRESS_MEM_MASK;
+
+	msix_tbl = ioremap_nocache(ep->phys_base + tbl_addr,
+				   PCI_MSIX_ENTRY_SIZE);
+	if (!msix_tbl)
+		return -EINVAL;
+
+	msg_addr_lower = readl(msix_tbl + PCI_MSIX_ENTRY_LOWER_ADDR);
+	msg_addr_upper = readl(msix_tbl + PCI_MSIX_ENTRY_UPPER_ADDR);
+	msg_addr = ((u64) msg_addr_upper) << 32 | msg_addr_lower;
+	msg_data = readl(msix_tbl + PCI_MSIX_ENTRY_DATA);
+	vec_ctrl = readl(msix_tbl + PCI_MSIX_ENTRY_VECTOR_CTRL);
+
+	iounmap(msix_tbl);
+
+	if (vec_ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT)
+		return -EPERM;
+
+	ret = dw_pcie_ep_map_addr(epc, func_no, ep->msix_mem_phys, msg_addr,
+				  epc->mem->page_size);
+	if (ret)
+		return ret;
+
+	writel(msg_data, ep->msix_mem);
+
+	dw_pcie_ep_unmap_addr(epc, func_no, ep->msix_mem_phys);
+
+	return 0;
+}
+
 void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
 {
 	struct pci_epc *epc = ep->epc;
@@ -329,6 +461,9 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
 	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
 			      epc->mem->page_size);
 
+	pci_epc_mem_free_addr(epc, ep->msix_mem_phys, ep->msix_mem,
+			      epc->mem->page_size);
+
 	pci_epc_mem_exit(epc);
 }
 
@@ -412,6 +547,15 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		dev_err(dev, "Failed to reserve memory for MSI\n");
 		return -ENOMEM;
 	}
+	ep->msi_cap = dw_pcie_ep_find_capability(pci, PCI_CAP_ID_MSI);
+
+	ep->msix_mem = pci_epc_mem_alloc_addr(epc, &ep->msix_mem_phys,
+					     epc->mem->page_size);
+	if (!ep->msix_mem) {
+		dev_err(dev, "Failed to reserve memory for MSI-X\n");
+		return -ENOMEM;
+	}
+	ep->msix_cap = dw_pcie_ep_find_capability(pci, PCI_CAP_ID_MSIX);
 
 	epc->features = EPC_FEATURE_NO_LINKUP_NOTIFIER;
 	EPC_FEATURE_SET_BAR(epc->features, BAR_0);
diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index 5937fed..654dcb5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -78,7 +78,7 @@ static void dw_plat_pcie_ep_init(struct dw_pcie_ep *ep)
 
 static int dw_plat_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 				     enum pci_epc_irq_type type,
-				     u8 interrupt_num)
+				     u16 interrupt_num)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
@@ -88,6 +88,8 @@ static int dw_plat_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 		return -EINVAL;
 	case PCI_EPC_IRQ_MSI:
 		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
+	case PCI_EPC_IRQ_MSIX:
+		return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
 	default:
 		dev_err(pci->dev, "UNKNOWN IRQ type\n");
 	}
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index bee4e25..b22c5bb 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -191,7 +191,7 @@ enum dw_pcie_as_type {
 struct dw_pcie_ep_ops {
 	void	(*ep_init)(struct dw_pcie_ep *ep);
 	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
-			     enum pci_epc_irq_type type, u8 interrupt_num);
+			     enum pci_epc_irq_type type, u16 interrupt_num);
 };
 
 struct dw_pcie_ep {
@@ -208,6 +208,10 @@ struct dw_pcie_ep {
 	u32			num_ob_windows;
 	void __iomem		*msi_mem;
 	phys_addr_t		msi_mem_phys;
+	void __iomem		*msix_mem;
+	phys_addr_t		msix_mem_phys;
+	u8			msi_cap;	/* MSI capability offset */
+	u8			msix_cap;	/* MSI-X capability offset */
 };
 
 struct dw_pcie_ops {
@@ -359,6 +363,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep);
 void dw_pcie_ep_exit(struct dw_pcie_ep *ep);
 int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 			     u8 interrupt_num);
+int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
+			     u16 interrupt_num);
 void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar);
 #else
 static inline void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
@@ -380,6 +386,12 @@ static inline int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 	return 0;
 }
 
+static inline int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
+					   u16 interrupt_num)
+{
+	return 0;
+}
+
 static inline void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
 {
 }
-- 
2.7.4


