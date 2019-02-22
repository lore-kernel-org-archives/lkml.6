Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8BEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878552070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfBVXiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:38:00 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:59431 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBVXh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:37:58 -0500
X-Originating-IP: 86.201.231.99
Received: from mc-bl-xps13.lan (lfbn-tou-1-149-99.w86-201.abo.wanadoo.fr [86.201.231.99])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 1F5606000D;
        Fri, 22 Feb 2019 23:37:52 +0000 (UTC)
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
Subject: [PATCH net-next v2 1/7] net: phy: marvell10g: Use get_features to get the PHY abilities
Date:   Sat, 23 Feb 2019 00:37:38 +0100
Message-Id: <20190222233744.25735-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190222233744.25735-1-maxime.chevallier@bootlin.com>
References: <20190222233744.25735-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Alaska family of 10G PHYs has more abilities than the ones listed in
PHY_10GBIT_FULL_FEATURES, the exact list depending on the model.

Make use of the newly introduced .get_features call to build this list,
using genphy_c45_pma_read_abilities to build the list of supported
linkmodes, and adding autoneg ability based on what's reported by the AN
MMD.

.config_init is still used to validate the interface_mode.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---

V2: Added missing blank line

 drivers/net/phy/marvell10g.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 586ae1bc5a50..89920b10d75b 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -233,8 +233,6 @@ static int mv3310_resume(struct phy_device *phydev)
 
 static int mv3310_config_init(struct phy_device *phydev)
 {
-	int ret, val;
-
 	/* Check that the PHY interface type is compatible */
 	if (phydev->interface != PHY_INTERFACE_MODE_SGMII &&
 	    phydev->interface != PHY_INTERFACE_MODE_XAUI &&
@@ -242,6 +240,13 @@ static int mv3310_config_init(struct phy_device *phydev)
 	    phydev->interface != PHY_INTERFACE_MODE_10GKR)
 		return -ENODEV;
 
+	return 0;
+}
+
+static int mv3310_get_features(struct phy_device *phydev)
+{
+	int ret, val;
+
 	if (phydev->c45_ids.devices_in_package & MDIO_DEVS_AN) {
 		val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_STAT1);
 		if (val < 0)
@@ -416,7 +421,7 @@ static struct phy_driver mv3310_drivers[] = {
 		.phy_id		= 0x002b09aa,
 		.phy_id_mask	= MARVELL_PHY_ID_MASK,
 		.name		= "mv88x3310",
-		.features	= PHY_10GBIT_FEATURES,
+		.get_features	= mv3310_get_features,
 		.soft_reset	= gen10g_no_soft_reset,
 		.config_init	= mv3310_config_init,
 		.probe		= mv3310_probe,
-- 
2.19.2

