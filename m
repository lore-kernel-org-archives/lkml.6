Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8E3C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6D422AAE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="J2tX3ueB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C6D422AAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933402AbeGFPxe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:53:34 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:37560 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933045AbeGFPvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:51:41 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 3B20124E08C9;
        Fri,  6 Jul 2018 08:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1530892301; bh=Z0DXlmogNAGxuCnHCtO9eVU9YBBKNFp/608zfAXg1+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=J2tX3ueBrvyf83f1biGYhbQCKpPb25u0tScnkWQtOUhfhoJuXFbGZqD992GU/wcXK
         YY9X7pnI3uswFWvg8/zVaOrBfvf8K02Q0Odc93NRP4TerjqbPX60HZxG/0nrpbQYlH
         wFrwlaRRsWs4wMpLyHI6sZ49dY3/Omu7Tu2UjCIaMBEoFAbbLdVJ6cC8yvAhDjX4L2
         XESaKENUIHUCJJ/8ISB0fPtg+TYuUn8vefpmd4XYL0iHBu7fMiZnQqxR/Lhwg8UUu7
         WAKFOnHH7UxLrjsAS7G8qADuA6nuthQk0xdJwihXzQzeobCqn1wBdHXj3JoxIgkD/L
         S6x5q0BOqx3/g==
Received: from pt02.synopsys.com (pt02.internal.synopsys.com [10.107.23.240])
        by mailhost.synopsys.com (Postfix) with ESMTP id AC99034CE;
        Fri,  6 Jul 2018 08:51:40 -0700 (PDT)
Received: from UbuntuMate-64Bits.internal.synopsys.com (gustavo-e7480.internal.synopsys.com [10.107.25.102])
        by pt02.synopsys.com (Postfix) with ESMTP id 091473D24B;
        Fri,  6 Jul 2018 16:51:39 +0100 (WEST)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com,
        shawn.lin@rock-chips.com
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v8 05/11] PCI: dwc: Add legacy interrupt callback handler
Date:   Fri,  6 Jul 2018 16:51:28 +0100
Message-Id: <a7e396fda2f0fdae79ecabf4ae7adee9eb40e6dc.1530891871.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1530891871.git.gustavo.pimentel@synopsys.com>
References: <cover.1530891871.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1530891871.git.gustavo.pimentel@synopsys.com>
References: <cover.1530891871.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a legacy interrupt callback handler. Currently DesignWare IP don't
allow trigger legacy interrupts.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Change v1->v2:
 - Nothing changed, just to follow the patch set version.
Change v2->v3:
 - Nothing changed, just to follow the patch set version.
Change v3->v4:
 - Rebased to Lorenzo's master branch v4.18-rc1.
Change v4->v5:
 - Nothing changed, just to follow the patch set version.
Change v5->v6:
 - Nothing changed, just to follow the patch set version.
Change v6->v7:
 - Nothing changed, just to follow the patch set version.
Change v7->v8:
 - Re-sending the patch series.

 drivers/pci/controller/dwc/pcie-designware-ep.c   | 10 ++++++++++
 drivers/pci/controller/dwc/pcie-designware-plat.c |  3 +--
 drivers/pci/controller/dwc/pcie-designware.h      |  6 ++++++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 1f98db3..70d0688 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -370,6 +370,16 @@ static const struct pci_epc_ops epc_ops = {
 	.stop			= dw_pcie_ep_stop,
 };
 
+int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct device *dev = pci->dev;
+
+	dev_err(dev, "EP cannot trigger legacy IRQs\n");
+
+	return -EINVAL;
+}
+
 int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 			     u8 interrupt_num)
 {
diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index 654dcb5..90a8c95 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -84,8 +84,7 @@ static int dw_plat_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 
 	switch (type) {
 	case PCI_EPC_IRQ_LEGACY:
-		dev_err(pci->dev, "EP cannot trigger legacy IRQs\n");
-		return -EINVAL;
+		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
 	case PCI_EPC_IRQ_MSI:
 		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
 	case PCI_EPC_IRQ_MSIX:
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index a0ab12f..69e6e17 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -350,6 +350,7 @@ static inline int dw_pcie_allocate_domains(struct pcie_port *pp)
 void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
 int dw_pcie_ep_init(struct dw_pcie_ep *ep);
 void dw_pcie_ep_exit(struct dw_pcie_ep *ep);
+int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no);
 int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 			     u8 interrupt_num);
 int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
@@ -369,6 +370,11 @@ static inline void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
 {
 }
 
+static inline int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no)
+{
+	return 0;
+}
+
 static inline int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 					   u8 interrupt_num)
 {
-- 
2.7.4


