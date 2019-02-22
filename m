Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586B8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3145D2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfBVXiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:38:20 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:58745 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBVXiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:38:18 -0500
X-Originating-IP: 86.201.231.99
Received: from mc-bl-xps13.lan (lfbn-tou-1-149-99.w86-201.abo.wanadoo.fr [86.201.231.99])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id C1C2B6000D;
        Fri, 22 Feb 2019 23:38:12 +0000 (UTC)
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
Subject: [PATCH net-next v2 5/7] net: phy: marvell10g: Force reading of 2.5/5G
Date:   Sat, 23 Feb 2019 00:37:42 +0100
Message-Id: <20190222233744.25735-6-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190222233744.25735-1-maxime.chevallier@bootlin.com>
References: <20190222233744.25735-1-maxime.chevallier@bootlin.com>
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
 drivers/net/phy/marvell10g.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 9c0b8f16cec5..8f354c3f3876 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -27,6 +27,9 @@
 #include <linux/marvell_phy.h>
 #include <linux/phy.h>
 
+#define MV_PHY_ALASKA_NBT_QUIRK_MASK	0xfffffffe
+#define MV_PHY_ALASKA_NBT_QUIRK_REV	(MARVELL_PHY_ID_88X3310 | 0xa)
+
 enum {
 	MV_PCS_BASE_T		= 0x0000,
 	MV_PCS_BASE_R		= 0x1000,
@@ -231,6 +234,23 @@ static int mv3310_resume(struct phy_device *phydev)
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
+	return (phydev->c45_ids.device_ids[MDIO_MMD_PMAPMD] &
+		MV_PHY_ALASKA_NBT_QUIRK_MASK) == MV_PHY_ALASKA_NBT_QUIRK_REV;
+}
+
 static int mv3310_config_init(struct phy_device *phydev)
 {
 	/* Check that the PHY interface type is compatible */
@@ -262,6 +282,21 @@ static int mv3310_get_features(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	if (mv3310_has_pma_ngbaset_quirk(phydev)) {
+		val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD,
+				   MDIO_PMA_NG_EXTABLE);
+		if (val < 0)
+			return val;
+
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+				 phydev->supported,
+				 val & MDIO_PMA_NG_EXTABLE_2_5GBT);
+
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+				 phydev->supported,
+				 val & MDIO_PMA_NG_EXTABLE_5GBT);
+	}
+
 	return 0;
 }
 
-- 
2.19.2

