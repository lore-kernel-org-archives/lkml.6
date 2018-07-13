Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F3CECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7309A208A6
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="W+pGmqxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7309A208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387770AbeGMQMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:12:35 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:57980 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729735AbeGMQME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:12:04 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 4347C24E2324;
        Fri, 13 Jul 2018 08:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531497411; bh=b8B2i0+INrL+NSkFhnrRV0RdEob5Y2ZZHT9Jb/+LYtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=W+pGmqxXFheHzDqdLxOGadi/EIJte896C6/F2XFP9brD74B1bpmhJA6PhcDWJaf/T
         iVWqc/SI0DY9x6FoVSr/edouoY/+xNhAw/DJPstoeb2ELcWi2i3szDsmm9UciZFVK6
         jHbFUdfRMetiHSVyejHq4CJ7sKEuhqJ2DFVYBBEZDcFONSC8Sa4ICMhXqJH6PjAb9Y
         mql+kbtXCNmlrDQNTiDQOurDIotVYIwrNIe0yYwuK0v3FtDkqoaBV5+8Vgtj8VtsB4
         5cro4sLh3050p02pHXeLz+r13ajGYfFH8BnG9YjQfFvfOJSSK3sL22Cz1l4sMDFBRT
         NNOqpaN/zYaOw==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id EAF8A30D9;
        Fri, 13 Jul 2018 08:56:50 -0700 (PDT)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 3512C3E8E2;
        Fri, 13 Jul 2018 17:56:49 +0200 (CEST)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        joao.pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com,
        shawn.lin@rock-chips.com
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v10 06/12] PCI: dwc: Add legacy interrupt callback handler
Date:   Fri, 13 Jul 2018 17:56:38 +0200
Message-Id: <08a3f4563dd4a8964ff0866ffa6ea752c238fc2b.1531496321.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531496321.git.gustavo.pimentel@synopsys.com>
References: <cover.1531496321.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1531496321.git.gustavo.pimentel@synopsys.com>
References: <cover.1531496321.git.gustavo.pimentel@synopsys.com>
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
Change v8->v9:
 - Nothing changed, just to follow the patch set version.
Change v9->v10:
 - Nothing changed, just to follow the patch set version.

 drivers/pci/controller/dwc/pcie-designware-ep.c   | 10 ++++++++++
 drivers/pci/controller/dwc/pcie-designware-plat.c |  3 +--
 drivers/pci/controller/dwc/pcie-designware.h      |  6 ++++++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index dd9c366..1e7b022 100644
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
index 8bb2ecb..160714d 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -87,8 +87,7 @@ static int dw_plat_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 
 	switch (type) {
 	case PCI_EPC_IRQ_LEGACY:
-		dev_err(pci->dev, "EP cannot trigger legacy IRQs\n");
-		return -EINVAL;
+		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
 	case PCI_EPC_IRQ_MSI:
 		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
 	case PCI_EPC_IRQ_MSIX:
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index e8b97f5..96126fd 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -348,6 +348,7 @@ static inline int dw_pcie_allocate_domains(struct pcie_port *pp)
 void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
 int dw_pcie_ep_init(struct dw_pcie_ep *ep);
 void dw_pcie_ep_exit(struct dw_pcie_ep *ep);
+int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no);
 int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 			     u8 interrupt_num);
 int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
@@ -367,6 +368,11 @@ static inline void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
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

