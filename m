Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753523AbeCPKfr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 06:35:47 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35035 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753467AbeCPKfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 06:35:45 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net, kishon@ti.com, linux@armlinux.org.uk,
        gregory.clement@bootlin.com, andrew@lunn.ch, jason@lakedaemon.net,
        sebastian.hesselbarth@gmail.com
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 06/10] net: mvpp2: 1000baseX support
Date: Fri, 16 Mar 2018 11:33:47 +0100
Message-Id: <20180316103351.16616-7-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180316103351.16616-1-antoine.tenart@bootlin.com>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the 1000Base-X PHY mode support in the Marvell PPv2
driver. 1000Base-X is quite close the SGMII and uses nearly the same
code path.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 74 +++++++++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 8e8e7afcd437..f6c35b688af4 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -4896,6 +4896,7 @@ static int mvpp22_gop_init(struct mvpp2_port *port)
 		mvpp22_gop_init_rgmii(port);
 		break;
 	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
 		mvpp22_gop_init_sgmii(port);
 		break;
 	case PHY_INTERFACE_MODE_10GKR:
@@ -4933,7 +4934,8 @@ static void mvpp22_gop_unmask_irq(struct mvpp2_port *port)
 	u32 val;
 
 	if (phy_interface_mode_is_rgmii(port->phy_interface) ||
-	    port->phy_interface == PHY_INTERFACE_MODE_SGMII) {
+	    port->phy_interface == PHY_INTERFACE_MODE_SGMII ||
+	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
 		/* Enable the GMAC link status irq for this port */
 		val = readl(port->base + MVPP22_GMAC_INT_SUM_MASK);
 		val |= MVPP22_GMAC_INT_SUM_MASK_LINK_STAT;
@@ -4963,7 +4965,8 @@ static void mvpp22_gop_mask_irq(struct mvpp2_port *port)
 	}
 
 	if (phy_interface_mode_is_rgmii(port->phy_interface) ||
-	    port->phy_interface == PHY_INTERFACE_MODE_SGMII) {
+	    port->phy_interface == PHY_INTERFACE_MODE_SGMII ||
+	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
 		val = readl(port->base + MVPP22_GMAC_INT_SUM_MASK);
 		val &= ~MVPP22_GMAC_INT_SUM_MASK_LINK_STAT;
 		writel(val, port->base + MVPP22_GMAC_INT_SUM_MASK);
@@ -4975,7 +4978,8 @@ static void mvpp22_gop_setup_irq(struct mvpp2_port *port)
 	u32 val;
 
 	if (phy_interface_mode_is_rgmii(port->phy_interface) ||
-	    port->phy_interface == PHY_INTERFACE_MODE_SGMII) {
+	    port->phy_interface == PHY_INTERFACE_MODE_SGMII ||
+	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
 		val = readl(port->base + MVPP22_GMAC_INT_MASK);
 		val |= MVPP22_GMAC_INT_MASK_LINK_STAT;
 		writel(val, port->base + MVPP22_GMAC_INT_MASK);
@@ -5000,6 +5004,7 @@ static int mvpp22_comphy_init(struct mvpp2_port *port)
 
 	switch (port->phy_interface) {
 	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
 		mode = PHY_MODE_SGMII;
 		break;
 	case PHY_INTERFACE_MODE_10GKR:
@@ -5079,7 +5084,8 @@ static void mvpp2_port_loopback_set(struct mvpp2_port *port,
 	else
 		val &= ~MVPP2_GMAC_GMII_LB_EN_MASK;
 
-	if (port->phy_interface == PHY_INTERFACE_MODE_SGMII)
+	if (port->phy_interface == PHY_INTERFACE_MODE_SGMII ||
+	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX)
 		val |= MVPP2_GMAC_PCS_LB_EN_MASK;
 	else
 		val &= ~MVPP2_GMAC_PCS_LB_EN_MASK;
@@ -6288,7 +6294,8 @@ static irqreturn_t mvpp2_link_status_isr(int irq, void *dev_id)
 				link = true;
 		}
 	} else if (phy_interface_mode_is_rgmii(port->phy_interface) ||
-		   port->phy_interface == PHY_INTERFACE_MODE_SGMII) {
+		   port->phy_interface == PHY_INTERFACE_MODE_SGMII ||
+		   port->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
 		val = readl(port->base + MVPP22_GMAC_INT_STAT);
 		if (val & MVPP22_GMAC_INT_STAT_LINK) {
 			event = true;
@@ -8055,21 +8062,25 @@ static void mvpp2_phylink_validate(struct net_device *dev,
 	phylink_set(mask, Pause);
 	phylink_set(mask, Asym_Pause);
 
-	phylink_set(mask, 10baseT_Half);
-	phylink_set(mask, 10baseT_Full);
-	phylink_set(mask, 100baseT_Half);
-	phylink_set(mask, 100baseT_Full);
-	phylink_set(mask, 1000baseT_Full);
-	phylink_set(mask, 1000baseX_Full);
-	phylink_set(mask, 10000baseT_Full);
-
-	if (state->interface == PHY_INTERFACE_MODE_10GKR) {
+	switch (state->interface) {
+	case PHY_INTERFACE_MODE_10GKR:
 		phylink_set(mask, 10000baseCR_Full);
 		phylink_set(mask, 10000baseSR_Full);
 		phylink_set(mask, 10000baseLR_Full);
 		phylink_set(mask, 10000baseLRM_Full);
 		phylink_set(mask, 10000baseER_Full);
 		phylink_set(mask, 10000baseKR_Full);
+		/* Fall-through */
+	default:
+		phylink_set(mask, 10baseT_Half);
+		phylink_set(mask, 10baseT_Full);
+		phylink_set(mask, 100baseT_Half);
+		phylink_set(mask, 100baseT_Full);
+		phylink_set(mask, 10000baseT_Full);
+		/* Fall-through */
+	case PHY_INTERFACE_MODE_1000BASEX:
+		phylink_set(mask, 1000baseT_Full);
+		phylink_set(mask, 1000baseX_Full);
 	}
 
 	bitmap_and(supported, supported, mask, __ETHTOOL_LINK_MODE_MASK_NBITS);
@@ -8108,12 +8119,18 @@ static void mvpp2_gmac_link_state(struct mvpp2_port *port,
 	state->link = !!(val & MVPP2_GMAC_STATUS0_LINK_UP);
 	state->duplex = !!(val & MVPP2_GMAC_STATUS0_FULL_DUPLEX);
 
-	if (val & MVPP2_GMAC_STATUS0_GMII_SPEED)
+	switch (port->phy_interface) {
+	case PHY_INTERFACE_MODE_1000BASEX:
 		state->speed = SPEED_1000;
-	else if (val & MVPP2_GMAC_STATUS0_MII_SPEED)
-		state->speed = SPEED_100;
-	else
-		state->speed = SPEED_10;
+		break;
+	default:
+		if (val & MVPP2_GMAC_STATUS0_GMII_SPEED)
+			state->speed = SPEED_1000;
+		else if (val & MVPP2_GMAC_STATUS0_MII_SPEED)
+			state->speed = SPEED_100;
+		else
+			state->speed = SPEED_10;
+	}
 
 	state->pause = 0;
 	if (val & MVPP2_GMAC_STATUS0_RX_PAUSE)
@@ -8204,7 +8221,18 @@ static void mvpp2_gmac_config(struct mvpp2_port *port, unsigned int mode,
 	ctrl0 &= ~MVPP2_GMAC_PORT_TYPE_MASK;
 	ctrl2 &= ~(MVPP2_GMAC_PORT_RESET_MASK | MVPP2_GMAC_PCS_ENABLE_MASK);
 
-	an |= MVPP2_GMAC_AN_SPEED_EN | MVPP2_GMAC_FLOW_CTRL_AUTONEG;
+	if (state->interface == PHY_INTERFACE_MODE_1000BASEX) {
+		/* 1000BaseX port cannot negotiate speed nor can it negotiate
+		 * duplex: they are always operating with a fixed speed of
+		 * 1000Mbps in full duplex, so force 1000 speed and full duplex
+		 * here.
+		 */
+		ctrl0 |= MVPP2_GMAC_PORT_TYPE_MASK;
+		an |= MVPP2_GMAC_CONFIG_GMII_SPEED |
+		      MVPP2_GMAC_CONFIG_FULL_DUPLEX;
+	} else {
+		an |= MVPP2_GMAC_AN_SPEED_EN | MVPP2_GMAC_FLOW_CTRL_AUTONEG;
+	}
 
 	if (state->duplex)
 		an |= MVPP2_GMAC_CONFIG_FULL_DUPLEX;
@@ -8213,7 +8241,8 @@ static void mvpp2_gmac_config(struct mvpp2_port *port, unsigned int mode,
 	if (phylink_test(state->advertising, Asym_Pause))
 		an |= MVPP2_GMAC_FC_ADV_ASM_EN;
 
-	if (state->interface == PHY_INTERFACE_MODE_SGMII) {
+	if (state->interface == PHY_INTERFACE_MODE_SGMII ||
+	    state->interface == PHY_INTERFACE_MODE_1000BASEX) {
 		an |= MVPP2_GMAC_IN_BAND_AUTONEG;
 		ctrl2 |= MVPP2_GMAC_INBAND_AN_MASK | MVPP2_GMAC_PCS_ENABLE_MASK;
 
@@ -8275,7 +8304,8 @@ static void mvpp2_mac_config(struct net_device *dev, unsigned int mode,
 	if (state->interface == PHY_INTERFACE_MODE_10GKR)
 		mvpp2_xlg_config(port, mode, state);
 	else if (phy_interface_mode_is_rgmii(state->interface) ||
-		 state->interface == PHY_INTERFACE_MODE_SGMII)
+		 state->interface == PHY_INTERFACE_MODE_SGMII ||
+		 state->interface == PHY_INTERFACE_MODE_1000BASEX)
 		mvpp2_gmac_config(port, mode, state);
 
 	if (port->priv->hw_version == MVPP21 && port->flags & MVPP2_F_LOOPBACK)
-- 
2.14.3
