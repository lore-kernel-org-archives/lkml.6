Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE00C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A312B2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfARPYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:24:19 -0500
Received: from mail.bootlin.com ([62.4.15.54]:51321 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727640AbfARPYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:24:16 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0FEEB207B0; Fri, 18 Jan 2019 16:24:14 +0100 (CET)
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id A61B2207B6;
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
Subject: [PATCH net-next 3/7] net: phy: Read 2.5G and 5G extended abilities
Date:   Fri, 18 Jan 2019 16:23:48 +0100
Message-Id: <20190118152352.26417-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register 1.21 "2.5G/5G PMA Extended abilities" contains the information
indicating whether or not 2.5GBASET and 5GBASET are supported by a PHY,
as per the 802.3bz specification.

If the bit 14 is set in the 1.11 "PMA Extended abilities" register, the
modes specified in the above-mentionned 1.21 register should be taken
into account.

This commit adds that logic into the genphy_c45_read_abilities function.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy-c45.c | 14 ++++++++++++++
 include/uapi/linux/mdio.h |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 61ca4f89e94a..ee32eba3dc20 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -377,6 +377,20 @@ int genphy_c45_read_abilities(struct phy_device *phydev)
 			__set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT,
 				  supported);
 		}
+
+		if (val & MDIO_PMA_EXTABLE_NBT) {
+			val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD,
+					   MDIO_PMA_NG_EXTABLE);
+			if (val < 0)
+				return val;
+
+			if (val & MDIO_PMA_NG_EXTABLE_2_5GBT)
+				__set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+					  supported);
+			if (val & MDIO_PMA_NG_EXTABLE_5GBT)
+				__set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+					  supported);
+		}
 	}
 
 	linkmode_copy(phydev->supported, supported);
diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index e2ab03606c1b..546509898867 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -45,6 +45,7 @@
 #define MDIO_AN_ADVERTISE	16	/* AN advertising (base page) */
 #define MDIO_AN_LPA		19	/* AN LP abilities (base page) */
 #define MDIO_PCS_EEE_ABLE	20	/* EEE Capability register */
+#define MDIO_PMA_NG_EXTABLE	21	/* 2.5G/5G PMA/PMD extended ability */
 #define MDIO_PCS_EEE_WK_ERR	22	/* EEE wake error counter */
 #define MDIO_PHYXS_LNSTAT	24	/* PHY XGXS lane state */
 #define MDIO_AN_EEE_ADV		60	/* EEE advertisement */
@@ -201,6 +202,7 @@
 #define MDIO_PMA_EXTABLE_1000BKX	0x0040	/* 1000BASE-KX ability */
 #define MDIO_PMA_EXTABLE_100BTX		0x0080	/* 100BASE-TX ability */
 #define MDIO_PMA_EXTABLE_10BT		0x0100	/* 10BASE-T ability */
+#define MDIO_PMA_EXTABLE_NBT		0x4000  /* 2.5/5GBASE-T ability */
 
 /* PHY XGXS lane state register. */
 #define MDIO_PHYXS_LNSTAT_SYNC0		0x0001
@@ -272,6 +274,10 @@
 #define MDIO_EEE_10GKX4		0x0020	/* 10G KX4 EEE cap */
 #define MDIO_EEE_10GKR		0x0040	/* 10G KR EEE cap */
 
+/* 2.5G/5G Extended abilities register. */
+#define MDIO_PMA_NG_EXTABLE_2_5GBT	0x0001	/* 2.5GBASET ability */
+#define MDIO_PMA_NG_EXTABLE_5GBT	0x0002	/* 5GBASET ability */
+
 /* LASI RX_ALARM control/status registers. */
 #define MDIO_PMA_LASI_RX_PHYXSLFLT	0x0001	/* PHY XS RX local fault */
 #define MDIO_PMA_LASI_RX_PCSLFLT	0x0008	/* PCS RX local fault */
-- 
2.19.2

