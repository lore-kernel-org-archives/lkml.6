Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE8CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7F2208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfBTJCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:02:18 -0500
Received: from inva021.nxp.com ([92.121.34.21]:42638 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfBTJCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:02:15 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1EE592002E3;
        Wed, 20 Feb 2019 10:02:14 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 813D720017D;
        Wed, 20 Feb 2019 10:02:08 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A1145402C9;
        Wed, 20 Feb 2019 17:02:01 +0800 (SGT)
From:   Peng Ma <peng.ma@nxp.com>
To:     axboe@kernel.dk, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com, andy.tang@nxp.com
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        yousaf.kaukab@suse.com, Peng Ma <peng.ma@nxp.com>
Subject: [v6 3/3] ahci: qoriq: add lx2160 platforms support
Date:   Wed, 20 Feb 2019 08:56:07 +0000
Message-Id: <20190220085607.31582-3-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190220085607.31582-1-peng.ma@nxp.com>
References: <20190220085607.31582-1-peng.ma@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lx2160a is a new introduced soc which supports ATA3.0

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
changed for V6:
	- Add ecc_initialized to ensure set sata bit once of
	ECC error register
	- Recovery AHCI_LS2088A platform

 drivers/ata/ahci_qoriq.c |   52 +++++++++++++++++++++++++++++++---------------
 1 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index ce59253..08dbb86 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -58,6 +58,7 @@ enum ahci_qoriq_type {
 	AHCI_LS1046A,
 	AHCI_LS1088A,
 	AHCI_LS2088A,
+	AHCI_LX2160A,
 };
 
 struct ahci_qoriq_priv {
@@ -67,6 +68,8 @@ struct ahci_qoriq_priv {
 	bool is_dmacoherent;
 };
 
+static bool ecc_initialized;
+
 static const struct of_device_id ahci_qoriq_of_match[] = {
 	{ .compatible = "fsl,ls1021a-ahci", .data = (void *)AHCI_LS1021A},
 	{ .compatible = "fsl,ls1043a-ahci", .data = (void *)AHCI_LS1043A},
@@ -74,6 +77,7 @@ struct ahci_qoriq_priv {
 	{ .compatible = "fsl,ls1046a-ahci", .data = (void *)AHCI_LS1046A},
 	{ .compatible = "fsl,ls1088a-ahci", .data = (void *)AHCI_LS1088A},
 	{ .compatible = "fsl,ls2088a-ahci", .data = (void *)AHCI_LS2088A},
+	{ .compatible = "fsl,lx2160a-ahci", .data = (void *)AHCI_LX2160A},
 	{},
 };
 MODULE_DEVICE_TABLE(of, ahci_qoriq_of_match);
@@ -165,9 +169,10 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 
 	switch (qpriv->type) {
 	case AHCI_LS1021A:
-		if (!qpriv->ecc_addr)
+		if (!(qpriv->ecc_addr || ecc_initialized))
 			return -EINVAL;
-		writel(SATA_ECC_DISABLE, qpriv->ecc_addr);
+		else if (qpriv->ecc_addr && !ecc_initialized)
+			writel(SATA_ECC_DISABLE, qpriv->ecc_addr);
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
 		writel(LS1021A_PORT_PHY2, reg_base + PORT_PHY2);
 		writel(LS1021A_PORT_PHY3, reg_base + PORT_PHY3);
@@ -180,10 +185,12 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 		break;
 
 	case AHCI_LS1043A:
-		if (!qpriv->ecc_addr)
+		if (!(qpriv->ecc_addr || ecc_initialized))
 			return -EINVAL;
-		writel(readl(qpriv->ecc_addr) | ECC_DIS_ARMV8_CH2,
-				qpriv->ecc_addr);
+		else if (qpriv->ecc_addr && !ecc_initialized)
+			writel(readl(qpriv->ecc_addr) |
+			       ECC_DIS_ARMV8_CH2,
+			       qpriv->ecc_addr);
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
 		writel(AHCI_PORT_PHY2_CFG, reg_base + PORT_PHY2);
 		writel(AHCI_PORT_PHY3_CFG, reg_base + PORT_PHY3);
@@ -202,10 +209,12 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 		break;
 
 	case AHCI_LS1046A:
-		if (!qpriv->ecc_addr)
+		if (!(qpriv->ecc_addr || ecc_initialized))
 			return -EINVAL;
-		writel(readl(qpriv->ecc_addr) | ECC_DIS_ARMV8_CH2,
-				qpriv->ecc_addr);
+		else if (qpriv->ecc_addr && !ecc_initialized)
+			writel(readl(qpriv->ecc_addr) |
+			       ECC_DIS_ARMV8_CH2,
+			       qpriv->ecc_addr);
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
 		writel(AHCI_PORT_PHY2_CFG, reg_base + PORT_PHY2);
 		writel(AHCI_PORT_PHY3_CFG, reg_base + PORT_PHY3);
@@ -215,10 +224,13 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 		break;
 
 	case AHCI_LS1088A:
-		if (!qpriv->ecc_addr)
+	case AHCI_LX2160A:
+		if (!(qpriv->ecc_addr || ecc_initialized))
 			return -EINVAL;
-		writel(readl(qpriv->ecc_addr) | ECC_DIS_LS1088A,
-		       qpriv->ecc_addr);
+		else if (qpriv->ecc_addr && !ecc_initialized)
+			writel(readl(qpriv->ecc_addr) |
+			       ECC_DIS_LS1088A,
+			       qpriv->ecc_addr);
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
 		writel(AHCI_PORT_PHY2_CFG, reg_base + PORT_PHY2);
 		writel(AHCI_PORT_PHY3_CFG, reg_base + PORT_PHY3);
@@ -237,6 +249,7 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 		break;
 	}
 
+	ecc_initialized = true;
 	return 0;
 }
 
@@ -264,13 +277,18 @@ static int ahci_qoriq_probe(struct platform_device *pdev)
 
 	qoriq_priv->type = (enum ahci_qoriq_type)of_id->data;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-			"sata-ecc");
-	if (res) {
-		qoriq_priv->ecc_addr = devm_ioremap_resource(dev, res);
-		if (IS_ERR(qoriq_priv->ecc_addr))
-			return PTR_ERR(qoriq_priv->ecc_addr);
+	if (unlikely(!ecc_initialized)) {
+		res = platform_get_resource_byname(pdev,
+						   IORESOURCE_MEM,
+						   "sata-ecc");
+		if (res) {
+			qoriq_priv->ecc_addr =
+				devm_ioremap_resource(dev, res);
+			if (IS_ERR(qoriq_priv->ecc_addr))
+				return PTR_ERR(qoriq_priv->ecc_addr);
+		}
 	}
+
 	qoriq_priv->is_dmacoherent = of_dma_is_coherent(np);
 
 	rc = ahci_platform_enable_resources(hpriv);
-- 
1.7.1

