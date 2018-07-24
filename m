Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913FDECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46AE420880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uxCaRIRT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46AE420880
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388581AbeGXSis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:38:48 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:44016 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388565AbeGXSis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:38:48 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6OHVBki099590;
        Tue, 24 Jul 2018 12:31:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1532453471;
        bh=j8XsSxSVgH+cP/G7GLs/92NwhMzPgFCc6ZeAWq4cKCE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=uxCaRIRTqEtZ5/Q6uEfCQm9ATcpylloxvRV7aETjMCnjgr6ytVIZQTJWesxOwV9UY
         7MUG8NG/tyPA9TI7vUPswCjGkOKECuTqna2t8rh556HdcLonO5Wjb3tzLylEXJVzgt
         4+9oQs0OdDxZwHozbka2urRzN4EdwRRFnC1x02v8=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6OHVBWj011478;
        Tue, 24 Jul 2018 12:31:11 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 24
 Jul 2018 12:31:10 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 24 Jul 2018 12:31:10 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6OHUt8W031458;
        Tue, 24 Jul 2018 12:31:08 -0500
From:   Vignesh R <vigneshr@ti.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh R <vigneshr@ti.com>
Subject: [PATCH v3 4/4] pci: dwc: pci-dra7xx: Enable errata i870 for both EP and RC mode
Date:   Tue, 24 Jul 2018 23:01:50 +0530
Message-ID: <20180724173150.2701-5-vigneshr@ti.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724173150.2701-1-vigneshr@ti.com>
References: <20180724173150.2701-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Errata i870 is applicable in both EP and RC mode. Therefore rename
function dra7xx_pcie_ep_unaligned_memaccess(), that implements errata
workaround, to dra7xx_pcie_unaligned_memaccess() and call it from a
common place. So, that errata workaround is applied for both modes of
operation.

Reported-by: Chris Welch <Chris.Welch@viavisolutions.com>
Signed-off-by: Vignesh R <vigneshr@ti.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
v3:
collect ACKs.
Fix s/appplied/applied.

 drivers/pci/controller/dwc/pci-dra7xx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index ce9224a36f62..43711561a199 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -542,7 +542,7 @@ static const struct of_device_id of_dra7xx_pcie_match[] = {
 };
 
 /*
- * dra7xx_pcie_ep_unaligned_memaccess: workaround for AM572x/AM571x Errata i870
+ * dra7xx_pcie_unaligned_memaccess: workaround for AM572x/AM571x Errata i870
  * @dra7xx: the dra7xx device where the workaround should be applied
  *
  * Access to the PCIe slave port that are not 32-bit aligned will result
@@ -552,7 +552,7 @@ static const struct of_device_id of_dra7xx_pcie_match[] = {
  *
  * To avoid this issue set PCIE_SS1_AXI2OCP_LEGACY_MODE_ENABLE to 1.
  */
-static int dra7xx_pcie_ep_unaligned_memaccess(struct device *dev)
+static int dra7xx_pcie_unaligned_memaccess(struct device *dev)
 {
 	int ret;
 	struct device_node *np = dev->of_node;
@@ -695,6 +695,10 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	if (dra7xx->link_gen < 0 || dra7xx->link_gen > 2)
 		dra7xx->link_gen = 2;
 
+	ret = dra7xx_pcie_unaligned_memaccess(dev);
+	if (ret)
+		dev_err(dev, "WA for Errata i870 not applied. Update DT\n");
+
 	switch (mode) {
 	case DW_PCIE_RC_TYPE:
 		if (!IS_ENABLED(CONFIG_PCI_DRA7XX_HOST)) {
@@ -717,10 +721,6 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
 				   DEVICE_TYPE_EP);
 
-		ret = dra7xx_pcie_ep_unaligned_memaccess(dev);
-		if (ret)
-			goto err_gpio;
-
 		ret = dra7xx_add_pcie_ep(dra7xx, pdev);
 		if (ret < 0)
 			goto err_gpio;
-- 
2.18.0

