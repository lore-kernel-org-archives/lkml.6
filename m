Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B53EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C1B20657
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfARPY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:24:27 -0500
Received: from mail.bootlin.com ([62.4.15.54]:51327 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727640AbfARPYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:24:25 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 34998207B0; Fri, 18 Jan 2019 16:24:23 +0100 (CET)
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4E6DA20955;
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
Subject: [PATCH net-next 5/7] net: phy: marvell10g: Force reading of 2.5/5G PMA extended abilities
Date:   Fri, 18 Jan 2019 16:23:50 +0100
Message-Id: <20190118152352.26417-6-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per 802.3bz, if bit 14 of (1.11) "PMA Extended Abilities" indicates
whether or not we should read register (1.21) "2.52/5G PMA Extended
Abilities", which contains information on the support of 2.5GBASET and
5GBASET.

After testing on several variants of PHYS of this family, it appears
that bit 14 in (1.11) isn't always set when it should be.

PHYs 88X3310 (on MacchiatoBin) and 88E2010 do support 2.5G and 5GBASET,
but don't have 1.11.14 set. Their register 1.21 is filled with the
correct values, indicating 2.5G and 5G support.

PHYs 88X2110 do have their 1.11.14 bit set, as it should.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/marvell10g.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index f45ddf3bc138..0a35bf0fac47 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -251,7 +251,7 @@ static int mv3310_resume(struct phy_device *phydev)
 
 static int mv3310_config_init(struct phy_device *phydev)
 {
-	int ret;
+	int ret, val;
 
 	/* Check that the PHY interface type is compatible */
 	if (phydev->interface != PHY_INTERFACE_MODE_SGMII &&
@@ -265,6 +265,23 @@ static int mv3310_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	/* Some PHYs in the Alaska family such as the 88X3310 and the 88E2010
+	 * don't set bit 14 in PMA Extended Abilities (1.11), although they do
+	 * support 2.5GBASET and 5GBASET. Their 2.5/5G PMA Extended abilities
+	 * (1.21) still have a meaningful value, so read it anyway to make sure
+	 * we enable support for these modes if needed.
+	 */
+	val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_NG_EXTABLE);
+	if (val < 0)
+		return val;
+
+	if (val & MDIO_PMA_NG_EXTABLE_2_5GBT)
+		__set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+			  phydev->supported);
+	if (val & MDIO_PMA_NG_EXTABLE_5GBT)
+		__set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+			  phydev->supported);
+
 	/* Make sure we advertise all the supported modes, and not just the
 	 * default one specified in the driver's .features.
 	 */
-- 
2.19.2

