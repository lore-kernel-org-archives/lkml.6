Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29303ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F89208A6
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NogsiDc7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F89208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731446AbeGMQME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:12:04 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:57955 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbeGMQME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:12:04 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 26A7C24E082E;
        Fri, 13 Jul 2018 08:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531497411; bh=evyae7gxx7k7ivy3n0QAAQHbwJHsrCXF4dYRRZqDsZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=NogsiDc7r4rkNuoizvFSm7C9dQ3K0YcmdbYHqPFU+jUjhCovNp+ht1ZFgOz4s4Sr6
         iuEnQaclnHLRMbB24Yj1HWQ6HOEpv385AAY039VGvCl5zHuQXWBf/8ddTjz3GoHyUQ
         G8TeEnr13Ekh6RNdzWgPZfgdm+OXyJMZDf/NXGfU5WTNo+OREYigHh6HW/ZvmE3jLd
         8+a/6DQZbKSc5t1o1m9Tj/LbyNOG85RRtyikbgQHDI4MrmBoX+qen20Q3ysKksD+36
         xnpKC6LaEUnltWhUaUp2cOV3fdGtHkuSndgtSpl/Q5mPb0oL4kotjav8yAjXWnIwFn
         XNNWOVYkY6nJg==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id AA58A3B8D;
        Fri, 13 Jul 2018 08:56:49 -0700 (PDT)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id D42223E8C7;
        Fri, 13 Jul 2018 17:56:48 +0200 (CEST)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        joao.pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com,
        shawn.lin@rock-chips.com
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v10 01/12] PCI: dwc: Fix EP link notification implementation
Date:   Fri, 13 Jul 2018 17:56:33 +0200
Message-Id: <3b43f37cc5fe654294c1ea696ed8df1797ad213b.1531496321.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531496321.git.gustavo.pimentel@synopsys.com>
References: <cover.1531496321.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1531496321.git.gustavo.pimentel@synopsys.com>
References: <cover.1531496321.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move specific features settings from EP shared code
(pcie-designware-ep.c) to the driver (pcie-designware-plat.c).

Previous implementation disables the EP link notification
by default for all SoCs that uses EP DesignWare IP, which affects
directly the dra7xx and artpec6 SoCs.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Change v8->v9:
 - Created patch file.
Change v9->v10:
 - Nothing changed, just to follow the patch set version.

 drivers/pci/controller/dwc/pcie-designware-ep.c   | 14 ++++++--------
 drivers/pci/controller/dwc/pcie-designware-plat.c |  3 +++
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 8650416..04092a7 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -386,15 +386,18 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		return -ENOMEM;
 	ep->outbound_addr = addr;
 
-	if (ep->ops->ep_init)
-		ep->ops->ep_init(ep);
-
 	epc = devm_pci_epc_create(dev, &epc_ops);
 	if (IS_ERR(epc)) {
 		dev_err(dev, "Failed to create epc device\n");
 		return PTR_ERR(epc);
 	}
 
+	ep->epc = epc;
+	epc_set_drvdata(epc, ep);
+
+	if (ep->ops->ep_init)
+		ep->ops->ep_init(ep);
+
 	ret = of_property_read_u8(np, "max-functions", &epc->max_functions);
 	if (ret < 0)
 		epc->max_functions = 1;
@@ -413,11 +416,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		return -ENOMEM;
 	}
 
-	epc->features = EPC_FEATURE_NO_LINKUP_NOTIFIER;
-	EPC_FEATURE_SET_BAR(epc->features, BAR_0);
-
-	ep->epc = epc;
-	epc_set_drvdata(epc, ep);
 	dw_pcie_setup(pci);
 
 	return 0;
diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index 5937fed..0ce3440 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -70,10 +70,13 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 static void dw_plat_pcie_ep_init(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct pci_epc *epc = ep->epc;
 	enum pci_barno bar;
 
 	for (bar = BAR_0; bar <= BAR_5; bar++)
 		dw_pcie_ep_reset_bar(pci, bar);
+
+	epc->features |= EPC_FEATURE_NO_LINKUP_NOTIFIER;
 }
 
 static int dw_plat_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
-- 
2.7.4

