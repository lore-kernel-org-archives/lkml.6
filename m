Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B53C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DC22148C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9DC22148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeJDToV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:44:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37532 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbeJDToU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:44:20 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 08C1E207C4; Thu,  4 Oct 2018 14:51:09 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id ACC1E20802;
        Thu,  4 Oct 2018 14:50:49 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH net-next v2 5/6] net: phy: mscc: shorten `x != 0` condition to `x`
Date:   Thu,  4 Oct 2018 14:47:27 +0200
Message-Id: <20181004124728.9821-6-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004124728.9821-1-quentin.schulz@bootlin.com>
References: <20181004124728.9821-1-quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`if (x != 0)` is basically a more verbose version of `if (x)` so let's
use the latter so it's consistent throughout the whole driver.

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/net/phy/mscc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index c136ed71110b..720d8dc81410 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -318,7 +318,7 @@ static int vsc85xx_mdix_set(struct phy_device *phydev, u8 mdix)
 			     DISABLE_HP_AUTO_MDIX_MASK);
 	}
 	rc = phy_write(phydev, MSCC_PHY_BYPASS_CONTROL, reg_val);
-	if (rc != 0)
+	if (rc)
 		return rc;
 
 	oldpage = phy_select_page(phydev, MSCC_PHY_PAGE_EXTENDED);
@@ -334,7 +334,7 @@ static int vsc85xx_mdix_set(struct phy_device *phydev, u8 mdix)
 	else if (mdix == ETH_TP_MDI_X)
 		reg_val |= FORCE_MDI_CROSSOVER_MDIX;
 	rc = __phy_write(phydev, MSCC_PHY_EXT_MODE_CNTL, reg_val);
-	if (rc != 0)
+	if (rc)
 		goto out;
 
 	rc = phy_restore_page(phydev, oldpage, rc);
@@ -458,14 +458,14 @@ static int vsc85xx_wol_set(struct phy_device *phydev,
 		reg_val = phy_read(phydev, MII_VSC85XX_INT_MASK);
 		reg_val |= MII_VSC85XX_INT_MASK_WOL;
 		rc = phy_write(phydev, MII_VSC85XX_INT_MASK, reg_val);
-		if (rc != 0)
+		if (rc)
 			goto out_unlock;
 	} else {
 		/* Disable the WOL interrupt */
 		reg_val = phy_read(phydev, MII_VSC85XX_INT_MASK);
 		reg_val &= (~MII_VSC85XX_INT_MASK_WOL);
 		rc = phy_write(phydev, MII_VSC85XX_INT_MASK, reg_val);
-		if (rc != 0)
+		if (rc)
 			goto out_unlock;
 	}
 	/* Clear WOL iterrupt status */
@@ -614,7 +614,7 @@ static int vsc85xx_edge_rate_cntl_set(struct phy_device *phydev, u8 edge_rate)
 	reg_val &= ~(EDGE_RATE_CNTL_MASK);
 	reg_val |= (edge_rate << EDGE_RATE_CNTL_POS);
 	rc = __phy_write(phydev, MSCC_PHY_WOL_MAC_CONTROL, reg_val);
-	if (rc != 0)
+	if (rc)
 		goto out_unlock;
 
 out_unlock:
@@ -649,7 +649,7 @@ static int vsc85xx_mac_if_set(struct phy_device *phydev,
 		goto out_unlock;
 	}
 	rc = phy_write(phydev, MSCC_PHY_EXT_PHY_CNTL_1, reg_val);
-	if (rc != 0)
+	if (rc)
 		goto out_unlock;
 
 	rc = genphy_soft_reset(phydev);
-- 
2.17.1

