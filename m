Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751801AbeEDOD7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:03:59 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60439 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751807AbeEDOAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 10:00:15 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net, kishon@ti.com, linux@armlinux.org.uk,
        gregory.clement@bootlin.com, andrew@lunn.ch, jason@lakedaemon.net,
        sebastian.hesselbarth@gmail.com
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v2 07/13] phy: cp110-comphy: 2.5G SGMII mode
Date: Fri,  4 May 2018 15:56:37 +0200
Message-Id: <20180504135643.23466-8-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180504135643.23466-1-antoine.tenart@bootlin.com>
References: <20180504135643.23466-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allow the CP110 comphy to configure some lanes in the
2.5G SGMII mode. This mode is quite close to SGMII and uses nearly the
same code path.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
index a0d522154cdf..4ef429250d7b 100644
--- a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
+++ b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
@@ -135,19 +135,25 @@ struct mvebu_comhy_conf {
 static const struct mvebu_comhy_conf mvebu_comphy_cp110_modes[] = {
 	/* lane 0 */
 	MVEBU_COMPHY_CONF(0, 1, PHY_MODE_SGMII, 0x1),
+	MVEBU_COMPHY_CONF(0, 1, PHY_MODE_2500SGMII, 0x1),
 	/* lane 1 */
 	MVEBU_COMPHY_CONF(1, 2, PHY_MODE_SGMII, 0x1),
+	MVEBU_COMPHY_CONF(1, 2, PHY_MODE_2500SGMII, 0x1),
 	/* lane 2 */
 	MVEBU_COMPHY_CONF(2, 0, PHY_MODE_SGMII, 0x1),
+	MVEBU_COMPHY_CONF(2, 0, PHY_MODE_2500SGMII, 0x1),
 	MVEBU_COMPHY_CONF(2, 0, PHY_MODE_10GKR, 0x1),
 	/* lane 3 */
 	MVEBU_COMPHY_CONF(3, 1, PHY_MODE_SGMII, 0x2),
+	MVEBU_COMPHY_CONF(3, 1, PHY_MODE_2500SGMII, 0x2),
 	/* lane 4 */
 	MVEBU_COMPHY_CONF(4, 0, PHY_MODE_SGMII, 0x2),
+	MVEBU_COMPHY_CONF(4, 0, PHY_MODE_2500SGMII, 0x2),
 	MVEBU_COMPHY_CONF(4, 0, PHY_MODE_10GKR, 0x2),
 	MVEBU_COMPHY_CONF(4, 1, PHY_MODE_SGMII, 0x1),
 	/* lane 5 */
 	MVEBU_COMPHY_CONF(5, 2, PHY_MODE_SGMII, 0x1),
+	MVEBU_COMPHY_CONF(5, 2, PHY_MODE_2500SGMII, 0x1),
 };
 
 struct mvebu_comphy_priv {
@@ -206,6 +212,10 @@ static void mvebu_comphy_ethernet_init_reset(struct mvebu_comphy_lane *lane,
 	if (mode == PHY_MODE_10GKR)
 		val |= MVEBU_COMPHY_SERDES_CFG0_GEN_RX(0xe) |
 		       MVEBU_COMPHY_SERDES_CFG0_GEN_TX(0xe);
+	else if (mode == PHY_MODE_2500SGMII)
+		val |= MVEBU_COMPHY_SERDES_CFG0_GEN_RX(0x8) |
+		       MVEBU_COMPHY_SERDES_CFG0_GEN_TX(0x8) |
+		       MVEBU_COMPHY_SERDES_CFG0_HALF_BUS;
 	else if (mode == PHY_MODE_SGMII)
 		val |= MVEBU_COMPHY_SERDES_CFG0_GEN_RX(0x6) |
 		       MVEBU_COMPHY_SERDES_CFG0_GEN_TX(0x6) |
@@ -296,13 +306,13 @@ static int mvebu_comphy_init_plls(struct mvebu_comphy_lane *lane,
 	return 0;
 }
 
-static int mvebu_comphy_set_mode_sgmii(struct phy *phy)
+static int mvebu_comphy_set_mode_sgmii(struct phy *phy, enum phy_mode mode)
 {
 	struct mvebu_comphy_lane *lane = phy_get_drvdata(phy);
 	struct mvebu_comphy_priv *priv = lane->priv;
 	u32 val;
 
-	mvebu_comphy_ethernet_init_reset(lane, PHY_MODE_SGMII);
+	mvebu_comphy_ethernet_init_reset(lane, mode);
 
 	val = readl(priv->base + MVEBU_COMPHY_RX_CTRL1(lane->id));
 	val &= ~MVEBU_COMPHY_RX_CTRL1_CLK8T_EN;
@@ -487,7 +497,8 @@ static int mvebu_comphy_power_on(struct phy *phy)
 
 	switch (lane->mode) {
 	case PHY_MODE_SGMII:
-		ret = mvebu_comphy_set_mode_sgmii(phy);
+	case PHY_MODE_2500SGMII:
+		ret = mvebu_comphy_set_mode_sgmii(phy, lane->mode);
 		break;
 	case PHY_MODE_10GKR:
 		ret = mvebu_comphy_set_mode_10gkr(phy);
-- 
2.17.0
