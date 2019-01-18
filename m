Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D072FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86DB2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfARPYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:24:17 -0500
Received: from mail.bootlin.com ([62.4.15.54]:51310 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727633AbfARPYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:24:16 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BB8EF207A3; Fri, 18 Jan 2019 16:24:13 +0100 (CET)
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id 57BA2207B0;
        Fri, 18 Jan 2019 16:24:03 +0100 (CET)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 2/7] net: phy: Add generic support for 2.5GBaseT and 5GBaseT
Date:   Fri, 18 Jan 2019 16:23:47 +0100
Message-Id: <20190118152352.26417-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 802.3bz specification, based on previous by the NBASET alliance,
defines the 2.5GBaseT and 5GBaseT link modes for ethernet traffic on
cat5e, cat6 and cat7 cables.

These mode integrate with the already defined C45 MDIO PMA/PMD registers
set that added 10G support, by defining some previously reserved bits,
and adding a new register (2.5G/5G Extended abilities).

This commit adds the required definitions in include/uapi/linux/mdio.h
to support these modes, and detect when a link-partner advertises them.

It also adds support for these mode in the generic C45 PHY
infrastructure.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy-c45.c | 22 ++++++++++++++++++++++
 include/uapi/linux/mdio.h | 10 ++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 31806b432734..61ca4f89e94a 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -47,6 +47,16 @@ int genphy_c45_pma_setup_forced(struct phy_device *phydev)
 		/* Assume 1000base-T */
 		ctrl2 |= MDIO_PMA_CTRL2_1000BT;
 		break;
+	case SPEED_2500:
+		ctrl1 |= MDIO_CTRL1_SPEED2_5G;
+		/* Assume 2.5Gbase-T */
+		ctrl2 |= MDIO_PMA_CTRL2_2_5GBT;
+		break;
+	case SPEED_5000:
+		ctrl1 |= MDIO_CTRL1_SPEED5G;
+		/* Assume 5Gbase-T */
+		ctrl2 |= MDIO_PMA_CTRL2_5GBT;
+		break;
 	case SPEED_10000:
 		ctrl1 |= MDIO_CTRL1_SPEED10G;
 		/* Assume 10Gbase-T */
@@ -190,6 +200,12 @@ int genphy_c45_read_lpa(struct phy_device *phydev)
 	if (val < 0)
 		return val;
 
+	if (val & MDIO_AN_10GBT_STAT_LP2_5G)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+				 phydev->lp_advertising);
+	if (val & MDIO_AN_10GBT_STAT_LP5G)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+				 phydev->lp_advertising);
 	if (val & MDIO_AN_10GBT_STAT_LP10G)
 		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
 				 phydev->lp_advertising);
@@ -220,6 +236,12 @@ int genphy_c45_read_pma(struct phy_device *phydev)
 	case MDIO_PMA_CTRL1_SPEED1000:
 		phydev->speed = SPEED_1000;
 		break;
+	case MDIO_CTRL1_SPEED2_5G:
+		phydev->speed = SPEED_2500;
+		break;
+	case MDIO_CTRL1_SPEED5G:
+		phydev->speed = SPEED_5000;
+		break;
 	case MDIO_CTRL1_SPEED10G:
 		phydev->speed = SPEED_10000;
 		break;
diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index d435b00d64ad..e2ab03606c1b 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -92,6 +92,10 @@
 #define MDIO_CTRL1_SPEED10G		(MDIO_CTRL1_SPEEDSELEXT | 0x00)
 /* 10PASS-TS/2BASE-TL */
 #define MDIO_CTRL1_SPEED10P2B		(MDIO_CTRL1_SPEEDSELEXT | 0x04)
+/* 2.5 Gb/s */
+#define MDIO_CTRL1_SPEED2_5G		(MDIO_CTRL1_SPEEDSELEXT | 0x18)
+/* 5 Gb/s */
+#define MDIO_CTRL1_SPEED5G		(MDIO_CTRL1_SPEEDSELEXT | 0x1c)
 
 /* Status register 1. */
 #define MDIO_STAT1_LPOWERABLE		0x0002	/* Low-power ability */
@@ -142,6 +146,8 @@
 #define MDIO_PMA_CTRL2_1000BKX		0x000d	/* 1000BASE-KX type */
 #define MDIO_PMA_CTRL2_100BTX		0x000e	/* 100BASE-TX type */
 #define MDIO_PMA_CTRL2_10BT		0x000f	/* 10BASE-T type */
+#define MDIO_PMA_CTRL2_2_5GBT		0x0030  /* 2.5GBaseT type */
+#define MDIO_PMA_CTRL2_5GBT		0x0031  /* 5GBaseT type */
 #define MDIO_PCS_CTRL2_TYPE		0x0003	/* PCS type selection */
 #define MDIO_PCS_CTRL2_10GBR		0x0000	/* 10GBASE-R type */
 #define MDIO_PCS_CTRL2_10GBX		0x0001	/* 10GBASE-X type */
@@ -231,9 +237,13 @@
 #define MDIO_PCS_10GBRT_STAT2_BER	0x3f00
 
 /* AN 10GBASE-T control register. */
+#define MDIO_AN_10GBT_CTRL_ADV2_5G	0x0080	/* Advertise 2.5GBASE-T */
+#define MDIO_AN_10GBT_CTRL_ADV5G	0x0100	/* Advertise 5GBASE-T */
 #define MDIO_AN_10GBT_CTRL_ADV10G	0x1000	/* Advertise 10GBASE-T */
 
 /* AN 10GBASE-T status register. */
+#define MDIO_AN_10GBT_STAT_LP2_5G	0x0020  /* LP is 2.5GBT capable */
+#define MDIO_AN_10GBT_STAT_LP5G		0x0040  /* LP is 5GBT capable */
 #define MDIO_AN_10GBT_STAT_LPTRR	0x0200	/* LP training reset req. */
 #define MDIO_AN_10GBT_STAT_LPLTABLE	0x0400	/* LP loop timing ability */
 #define MDIO_AN_10GBT_STAT_LP10G	0x0800	/* LP is 10GBT capable */
-- 
2.19.2

