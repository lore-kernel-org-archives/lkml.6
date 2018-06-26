Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A17C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A89926E96
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A89926E96
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rockwellcollins.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754730AbeFZRvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:51:16 -0400
Received: from da1vs03.rockwellcollins.com ([205.175.227.47]:30924 "EHLO
        da1vs03.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754675AbeFZRvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:51:15 -0400
Received: from ofwda1n02.rockwellcollins.com (HELO ciulimr02.rockwellcollins.com) ([205.175.227.14])
  by da1vs03.rockwellcollins.com with ESMTP; 26 Jun 2018 12:51:14 -0500
X-Received: from righttwix.rockwellcollins.com (righttwix.rockwellcollins.com [192.168.141.218])
        by ciulimr02.rockwellcollins.com (Postfix) with ESMTP id 29E1420096;
        Tue, 26 Jun 2018 12:51:14 -0500 (CDT)
From:   Brandon Maier <brandon.maier@rockwellcollins.com>
To:     netdev@vger.kernel.org
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
        michal.simek@xilinx.com, clayton.shotwell@rockwellcollins.com,
        kristopher.cory@rockwellcollins.com, linux-kernel@vger.kernel.org,
        Brandon Maier <brandon.maier@rockwellcollins.com>
Subject: [PATCH net-next v2 2/3] net: phy: xgmiitorgmii: Use correct mdio bus
Date:   Tue, 26 Jun 2018 12:50:49 -0500
Message-Id: <20180626175050.71165-2-brandon.maier@rockwellcollins.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626175050.71165-1-brandon.maier@rockwellcollins.com>
References: <20180626175050.71165-1-brandon.maier@rockwellcollins.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The xgmiitorgmii is using the mii_bus of the device it's attached to,
instead of the bus it was given during probe.

Signed-off-by: Brandon Maier <brandon.maier@rockwellcollins.com>
---
v2:
- Fix trivial typo in commit message

v1: https://marc.info/?l=linux-netdev&m=152838761310537&w=2

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
2.17.1

