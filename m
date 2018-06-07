Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 0xcbKw9YGVs9fgAAmS7hNA
	; Thu, 07 Jun 2018 16:06:39 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9F6F1608B8; Thu,  7 Jun 2018 16:06:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2A64460590;
	Thu,  7 Jun 2018 16:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A64460590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=rockwellcollins.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936059AbeFGQGh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:06:37 -0400
Received: from secvs01.rockwellcollins.com ([205.175.225.240]:49607 "EHLO
        secvs01.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935284AbeFGQGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:06:23 -0400
X-Greylist: delayed 575 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Jun 2018 12:06:23 EDT
Received: from ofwgwc03.rockwellcollins.com (HELO ciulimr02.rockwellcollins.com) ([205.175.225.12])
  by secvs01.rockwellcollins.com with ESMTP; 07 Jun 2018 10:56:46 -0500
X-Received: from righttwix.rockwellcollins.com (righttwix.rockwellcollins.com [192.168.141.218])
        by ciulimr02.rockwellcollins.com (Postfix) with ESMTP id B655220094;
        Thu,  7 Jun 2018 10:56:46 -0500 (CDT)
From: Brandon Maier <brandon.maier@rockwellcollins.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
        michal.simek@xilinx.com, clayton.shotwell@rockwellcollins.com,
        kristopher.cory@rockwellcollins.com, linux-kernel@vger.kernel.org,
        Brandon Maier <brandon.maier@rockwellcollins.com>
Subject: [PATCH 2/3] net: phy: xgmiitorgmii: Use correct mdio bus
Date: Thu,  7 Jun 2018 10:53:47 -0500
Message-Id: <20180607155348.149665-2-brandon.maier@rockwellcollins.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180607155348.149665-1-brandon.maier@rockwellcollins.com>
References: <20180607155348.149665-1-brandon.maier@rockwellcollins.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The xgmiitorgmii is using the mii_bus of the device it's attached too,
instead of the bus it was given during probe.

Signed-off-by: Brandon Maier <brandon.maier@rockwellcollins.com>
---
 drivers/net/phy/xilinx_gmii2rgmii.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
index 04c8bec1c4c1..d6f8b64cddbe 100644
--- a/drivers/net/phy/xilinx_gmii2rgmii.c
+++ b/drivers/net/phy/xilinx_gmii2rgmii.c
@@ -33,17 +33,19 @@ struct gmii2rgmii {
 	struct phy_device *phy_dev;
 	struct phy_driver *phy_drv;
 	struct phy_driver conv_phy_drv;
-	int addr;
+	struct mdio_device *mdio;
 };
 
 static int xgmiitorgmii_read_status(struct phy_device *phydev)
 {
 	struct gmii2rgmii *priv = phydev->priv;
+	struct mii_bus *bus = priv->mdio->bus;
+	int addr = priv->mdio->addr;
 	u16 val = 0;
 
 	priv->phy_drv->read_status(phydev);
 
-	val = mdiobus_read(phydev->mdio.bus, priv->addr, XILINX_GMII2RGMII_REG);
+	val = mdiobus_read(bus, addr, XILINX_GMII2RGMII_REG);
 	val &= ~XILINX_GMII2RGMII_SPEED_MASK;
 
 	if (phydev->speed == SPEED_1000)
@@ -53,7 +55,7 @@ static int xgmiitorgmii_read_status(struct phy_device *phydev)
 	else
 		val |= BMCR_SPEED10;
 
-	mdiobus_write(phydev->mdio.bus, priv->addr, XILINX_GMII2RGMII_REG, val);
+	mdiobus_write(bus, addr, XILINX_GMII2RGMII_REG, val);
 
 	return 0;
 }
@@ -86,7 +88,7 @@ static int xgmiitorgmii_probe(struct mdio_device *mdiodev)
 		return -EPROBE_DEFER;
 	}
 
-	priv->addr = mdiodev->addr;
+	priv->mdio = mdiodev;
 	priv->phy_drv = priv->phy_dev->drv;
 	memcpy(&priv->conv_phy_drv, priv->phy_dev->drv,
 	       sizeof(struct phy_driver));
-- 
2.14.3
