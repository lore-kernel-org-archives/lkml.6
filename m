Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E2BECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7EC120856
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="g/KNDXKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7EC120856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbeGPPUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 11:20:16 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:46657 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729593AbeGPPUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 11:20:15 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 2C82110C1A61;
        Mon, 16 Jul 2018 07:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531752748; bh=HtlYz51v/dMT+BWkZXvXcXvkxrvI8KkJ/TYasi8BwYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=g/KNDXKajFAkA3zg7t8dhkwJNpDhjpdlDtaIGIHZ7ohtcizMr72hMYE5SKfKdK3kQ
         Uon3iIw0gwN3Va3FiYxg4572eMkR04iH6FSF+ZSBVpuqt+IqodnnMnoVZCKr7l5Nyt
         lz8HTXdyN11U2UW0ZEX4zvzfdrAA87B4m2Kw4INgOVLAM8+XfozXqr6pSLL/OCGEUW
         jhky4FCJWbjZRd+d6isJGfnhshwurOuuCo2roRnZI+TY2I+zkr1+xlfKivACr5EFsx
         pPMQCHQIvd1ASJGdORHKxC4zqcJMbDSLh1AWzlOcOE6+EffquClMpDUaDalC1zZdHC
         rq0tdQVlNwqvw==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 82E5A304D;
        Mon, 16 Jul 2018 07:52:27 -0700 (PDT)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id AD6A63DCC1;
        Mon, 16 Jul 2018 16:52:26 +0200 (CEST)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        joao.pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com,
        shawn.lin@rock-chips.com
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v11 01/12] PCI: dwc: Fix EP link notification implementation
Date:   Mon, 16 Jul 2018 16:52:13 +0200
Message-Id: <3cefa89ce2e496e7627bd3c7ade93348230adc14.1531751641.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531751641.git.gustavo.pimentel@synopsys.com>
References: <cover.1531751641.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1531751641.git.gustavo.pimentel@synopsys.com>
References: <cover.1531751641.git.gustavo.pimentel@synopsys.com>
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
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Change v8->v9:
 - Created patch file.
Change v9->v10:
 - Nothing changed, just to follow the patch set version.
Change v10->v11:
 - Missed Kishon acknowledge.

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

