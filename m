Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E33BC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1429B21872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfBGJuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:50:23 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:55949 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfBGJuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:50:21 -0500
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id E4A13100022;
        Thu,  7 Feb 2019 09:50:17 +0000 (UTC)
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
Subject: [PATCH net-next v2 08/10] net: phy: marvell10g: Force reading of 2.5/5G
Date:   Thu,  7 Feb 2019 10:49:37 +0100
Message-Id: <20190207094939.27369-9-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
References: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
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

PHYs 88E2110 do have their 1.11.14 bit set, as it should.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V1 -> V2: Use the PMA device id to identify which devices need this
	  quirk, based on Andrew's idea.

 drivers/net/phy/marvell10g.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 581b4b6e31e9..2593db608af7 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -232,6 +232,23 @@ static int mv3310_resume(struct phy_device *phydev)
 	return mv3310_hwmon_config(phydev, true);
 }
 
+/* Some PHYs in the Alaska family such as the 88X3310 and the 88E2010
+ * don't set bit 14 in PMA Extended Abilities (1.11), although they do
+ * support 2.5GBASET and 5GBASET. For these models, we can still read their
+ * 2.5G/5G extended abilities register (1.21). We detect these models based on
+ * the PMA device identifier, with a mask matching models known to have this
+ * issue
+ */
+static bool mv3310_has_pma_ngbaset_quirk(struct phy_device *phydev)
+{
+	if (!(phydev->c45_ids.devices_in_package & MDIO_DEVS_PMAPMD))
+		return false;
+
+	/* Only some revisions of the 88X3310 family PMA seem to be impacted */
+	return (phydev->c45_ids.device_ids[MDIO_MMD_PMAPMD] & 0xfffffffe) ==
+	       (MARVELL_PHY_ID_88X3310 & 0xfffffffe);
+}
+
 static int mv3310_config_init(struct phy_device *phydev)
 {
 	int ret, val;
@@ -261,6 +278,20 @@ static int mv3310_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	if (mv3310_has_pma_ngbaset_quirk(phydev)) {
+		val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD,
+				   MDIO_PMA_NG_EXTABLE);
+		if (val < 0)
+			return val;
+
+		if (val & MDIO_PMA_NG_EXTABLE_2_5GBT)
+			__set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+				  phydev->supported);
+		if (val & MDIO_PMA_NG_EXTABLE_5GBT)
+			__set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+				  phydev->supported);
+	}
+
 	return 0;
 }
 
-- 
2.19.2

