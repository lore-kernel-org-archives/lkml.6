Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA4DC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23722083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbfBYQOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:14:19 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:57589 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727661AbfBYQOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:14:17 -0500
X-Originating-IP: 90.88.23.190
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 9D69CE001B;
        Mon, 25 Feb 2019 16:14:13 +0000 (UTC)
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
        miquel.raynal@bootlin.com
Subject: [PATCH net-next 1/2] net: phy: marvell10g: Let genphy_c45_pma_read_abilities set Aneg bit
Date:   Mon, 25 Feb 2019 17:14:06 +0100
Message-Id: <20190225161407.19510-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190225161407.19510-1-maxime.chevallier@bootlin.com>
References: <20190225161407.19510-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The genphy_c45_pma_read_abilities helper now sets the Autoneg ability
in phydev->supported according to what the AN MMD reports.

We therefore don't need to manually do that in mv3310_get_features().

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/marvell10g.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 580e91deadbc..ab71da55c1e0 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -268,16 +268,6 @@ static int mv3310_get_features(struct phy_device *phydev)
 {
 	int ret, val;
 
-	if (phydev->c45_ids.devices_in_package & MDIO_DEVS_AN) {
-		val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_STAT1);
-		if (val < 0)
-			return val;
-
-		if (val & MDIO_AN_STAT1_ABLE)
-			linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
-					 phydev->supported);
-	}
-
 	ret = genphy_c45_pma_read_abilities(phydev);
 	if (ret)
 		return ret;
-- 
2.19.2

