Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8676ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8206C20852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="R6nufVln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8206C20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbeGQKDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:03:18 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:38964 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbeGQKDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:03:17 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id A271810C13F0;
        Tue, 17 Jul 2018 02:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531819895; bh=ohb3Pfx99FW3KsuCzvqejnZ3kcoX2h4u4JY08pQ13+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=R6nufVln1pktgkkfu3jAU3Wrl21h5f5i5bgwE++tgWzmuihrLyswHNLr5CDTrm4qw
         zYELq4odvDim+vtvd5dmzyndroxPa40c6SM0LBjdMiPAOZfjT5urB5qF2PytMHNOgS
         iePUDmxrBbHCuASeONLfBVIxpDnwJmU9Vw3tzu54p73LUIkDzs7MRzfM4P3uuZakGR
         BDOn8D9TVnARfQZJuckoaLBSz/cvU8uOGTinXA0DHh9femvjsZAzUJZwOz4Egje9bd
         lRVoL2s0Nb1TcxFK+w17IQKA+mRSVIKSMlA//LNwWs/830p4O4aP0mvymKinwisi3A
         380Z8nybq9ZAA==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id B70CE593C;
        Tue, 17 Jul 2018 02:31:34 -0700 (PDT)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id CA4DD3BBEB;
        Tue, 17 Jul 2018 11:31:33 +0200 (CEST)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        joao.pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com,
        shawn.lin@rock-chips.com
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v12 01/12] PCI: dwc: Fix EP link notification implementation
Date:   Tue, 17 Jul 2018 11:31:21 +0200
Message-Id: <3cefa89ce2e496e7627bd3c7ade93348230adc14.1531818979.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531818979.git.gustavo.pimentel@synopsys.com>
References: <cover.1531818979.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1531818979.git.gustavo.pimentel@synopsys.com>
References: <cover.1531818979.git.gustavo.pimentel@synopsys.com>
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
Change v11->v12:
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

