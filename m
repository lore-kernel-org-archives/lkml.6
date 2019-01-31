Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0979C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DB8218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfAaJeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:34:09 -0500
Received: from inva021.nxp.com ([92.121.34.21]:35964 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfAaJeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:34:08 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 07EE12000FC;
        Thu, 31 Jan 2019 10:34:06 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AC459200002;
        Thu, 31 Jan 2019 10:34:02 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id F13A6402C1;
        Thu, 31 Jan 2019 17:33:58 +0800 (SGT)
From:   Peng Ma <peng.ma@nxp.com>
To:     axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        yousaf.kaukab@suse.com, tj@kernel.org, Peng Ma <peng.ma@nxp.com>
Subject: [PATCH RESEND] ahci: qoriq: add lx2160 platforms support
Date:   Thu, 31 Jan 2019 17:28:29 +0800
Message-Id: <20190131092829.25005-1-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lx2160a is a new introduced soc which supports ATA3.0
Clean up some code

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
 drivers/ata/ahci_qoriq.c |   44 ++++++++++++--------------------------------
 1 files changed, 12 insertions(+), 32 deletions(-)

diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index ce59253..1994bf2 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -57,7 +57,7 @@ enum ahci_qoriq_type {
 	AHCI_LS2080A,
 	AHCI_LS1046A,
 	AHCI_LS1088A,
-	AHCI_LS2088A,
+	AHCI_LX2160A,
 };
 
 struct ahci_qoriq_priv {
@@ -73,7 +73,7 @@ struct ahci_qoriq_priv {
 	{ .compatible = "fsl,ls2080a-ahci", .data = (void *)AHCI_LS2080A},
 	{ .compatible = "fsl,ls1046a-ahci", .data = (void *)AHCI_LS1046A},
 	{ .compatible = "fsl,ls1088a-ahci", .data = (void *)AHCI_LS1088A},
-	{ .compatible = "fsl,ls2088a-ahci", .data = (void *)AHCI_LS2088A},
+	{ .compatible = "fsl,lx2160a-ahci", .data = (void *)AHCI_LX2160A},
 	{},
 };
 MODULE_DEVICE_TABLE(of, ahci_qoriq_of_match);
@@ -174,12 +174,10 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 		writel(LS1021A_PORT_PHY4, reg_base + PORT_PHY4);
 		writel(LS1021A_PORT_PHY5, reg_base + PORT_PHY5);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
-		if (qpriv->is_dmacoherent)
-			writel(AHCI_PORT_AXICC_CFG,
-					reg_base + LS1021A_AXICC_ADDR);
 		break;
 
 	case AHCI_LS1043A:
+	case AHCI_LS1046A:
 		if (!qpriv->ecc_addr)
 			return -EINVAL;
 		writel(readl(qpriv->ecc_addr) | ECC_DIS_ARMV8_CH2,
@@ -188,8 +186,6 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 		writel(AHCI_PORT_PHY2_CFG, reg_base + PORT_PHY2);
 		writel(AHCI_PORT_PHY3_CFG, reg_base + PORT_PHY3);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
-		if (qpriv->is_dmacoherent)
-			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
 		break;
 
 	case AHCI_LS2080A:
@@ -197,24 +193,10 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 		writel(AHCI_PORT_PHY2_CFG, reg_base + PORT_PHY2);
 		writel(AHCI_PORT_PHY3_CFG, reg_base + PORT_PHY3);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
-		if (qpriv->is_dmacoherent)
-			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
-		break;
-
-	case AHCI_LS1046A:
-		if (!qpriv->ecc_addr)
-			return -EINVAL;
-		writel(readl(qpriv->ecc_addr) | ECC_DIS_ARMV8_CH2,
-				qpriv->ecc_addr);
-		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
-		writel(AHCI_PORT_PHY2_CFG, reg_base + PORT_PHY2);
-		writel(AHCI_PORT_PHY3_CFG, reg_base + PORT_PHY3);
-		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
-		if (qpriv->is_dmacoherent)
-			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
 		break;
 
 	case AHCI_LS1088A:
+	case AHCI_LX2160A:
 		if (!qpriv->ecc_addr)
 			return -EINVAL;
 		writel(readl(qpriv->ecc_addr) | ECC_DIS_LS1088A,
@@ -223,18 +205,16 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 		writel(AHCI_PORT_PHY2_CFG, reg_base + PORT_PHY2);
 		writel(AHCI_PORT_PHY3_CFG, reg_base + PORT_PHY3);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
-		if (qpriv->is_dmacoherent)
-			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
 		break;
+	}
 
-	case AHCI_LS2088A:
-		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
-		writel(AHCI_PORT_PHY2_CFG, reg_base + PORT_PHY2);
-		writel(AHCI_PORT_PHY3_CFG, reg_base + PORT_PHY3);
-		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
-		if (qpriv->is_dmacoherent)
-			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
-		break;
+	if (qpriv->is_dmacoherent) {
+		if (qpriv->type == AHCI_LS1021A)
+			writel(AHCI_PORT_AXICC_CFG,
+			       reg_base + LS1021A_AXICC_ADDR);
+		else
+			writel(AHCI_PORT_AXICC_CFG,
+			       reg_base + PORT_AXICC);
 	}
 
 	return 0;
-- 
1.7.1

