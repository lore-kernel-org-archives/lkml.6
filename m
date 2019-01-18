Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566CFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3213520657
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfARPYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:24:31 -0500
Received: from mail.bootlin.com ([62.4.15.54]:51356 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727950AbfARPY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:24:26 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8EB8D209C0; Fri, 18 Jan 2019 16:24:23 +0100 (CET)
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id EEA5C209EF;
        Fri, 18 Jan 2019 16:24:04 +0100 (CET)
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
Subject: [PATCH net-next 7/7] net: phy: marvell10g: add support for the 88x2110 PHY
Date:   Fri, 18 Jan 2019 16:23:52 +0100
Message-Id: <20190118152352.26417-8-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the 88x2110 PHY, which is similar to the
already supported 88x3310 PHY without the SFP interface.

It supports 10/100/1000BASET along with 2.5GBASET, 5GBASET and 10GBASET,
with the same interface modes that are used by the 3310.

This PHY don't have the same issue as the 88x3310 regarding 2.5/5G
abilities, and correctly follows the 802.3bz standard to list the
supported abilities.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Suggested-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/phy/marvell10g.c | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 0a35bf0fac47..106491ecc016 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -290,6 +290,30 @@ static int mv3310_config_init(struct phy_device *phydev)
 	return 0;
 }
 
+static int mv2110_config_init(struct phy_device *phydev)
+{
+	int ret;
+
+	/* Check that the PHY interface type is compatible */
+	if (phydev->interface != PHY_INTERFACE_MODE_SGMII &&
+	    phydev->interface != PHY_INTERFACE_MODE_2500BASEX &&
+	    phydev->interface != PHY_INTERFACE_MODE_XAUI &&
+	    phydev->interface != PHY_INTERFACE_MODE_RXAUI &&
+	    phydev->interface != PHY_INTERFACE_MODE_10GKR)
+		return -ENODEV;
+
+	ret = genphy_c45_read_abilities(phydev);
+	if (ret)
+		return ret;
+
+	/* Make sure we advertise all the supported modes, and not just the
+	 * default one specified in the driver's .features.
+	 */
+	linkmode_copy(phydev->advertising, phydev->supported);
+
+	return 0;
+}
+
 static int mv3310_config_aneg(struct phy_device *phydev)
 {
 	bool changed = false;
@@ -504,12 +528,25 @@ static struct phy_driver mv3310_drivers[] = {
 		.aneg_done	= mv3310_aneg_done,
 		.read_status	= mv3310_read_status,
 	},
+	{
+		.phy_id		= 0x002b09b8,
+		.phy_id_mask	= MARVELL_PHY_ID_MASK,
+		.name		= "mv88x2110",
+		.features	= PHY_10GBIT_FEATURES,
+		.probe		= mv3310_probe,
+		.soft_reset	= gen10g_no_soft_reset,
+		.config_init	= mv2110_config_init,
+		.config_aneg	= mv3310_config_aneg,
+		.aneg_done	= mv3310_aneg_done,
+		.read_status	= mv3310_read_status,
+	},
 };
 
 module_phy_driver(mv3310_drivers);
 
 static struct mdio_device_id __maybe_unused mv3310_tbl[] = {
 	{ 0x002b09aa, MARVELL_PHY_ID_MASK },
+	{ 0x002b09b8, MARVELL_PHY_ID_MASK },
 	{ },
 };
 MODULE_DEVICE_TABLE(mdio, mv3310_tbl);
-- 
2.19.2

