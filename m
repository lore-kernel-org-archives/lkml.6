Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4FFC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50E021480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50E021480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbeIYUHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:07:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42648 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbeIYUHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 16:07:25 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 312AE207CA; Tue, 25 Sep 2018 15:59:43 +0200 (CEST)
Received: from mc-bl-xps13.lan (AAubervilliers-681-1-42-80.w90-88.abo.wanadoo.fr [90.88.160.80])
        by mail.bootlin.com (Postfix) with ESMTPSA id D3D2720723;
        Tue, 25 Sep 2018 15:59:42 +0200 (CEST)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com, yelena@marvell.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next] net: mvneta: Add support for 2500Mbps SGMII
Date:   Tue, 25 Sep 2018 15:59:39 +0200
Message-Id: <20180925135939.4816-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mvneta controller can handle speeds up to 2500Mbps on the SGMII
interface. This relies on serdes configuration, the lane must be
configured at 3.125Gbps and we can't use in-band autoneg at that speed.

The main issue when supporting that speed on this particular controller
is that the link partner can send ethernet frames with a shortened
preamble, which if not explicitly enabled in the controller will cause
unexpected behaviours.

This was tested on Armada 385, with the comphy configuration done in
bootloader.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 59ed63102e14..650303577090 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -221,6 +221,8 @@
 #define      MVNETA_GMAC_AN_FLOW_CTRL_EN         BIT(11)
 #define      MVNETA_GMAC_CONFIG_FULL_DUPLEX      BIT(12)
 #define      MVNETA_GMAC_AN_DUPLEX_EN            BIT(13)
+#define MVNETA_GMAC_CTRL_4                       0x2c90
+#define      MVNETA_GMAC4_SHORT_PREAMBLE_ENABLE  BIT(1)
 #define MVNETA_MIB_COUNTERS_BASE                 0x3000
 #define      MVNETA_MIB_LATE_COLLISION           0x7c
 #define MVNETA_DA_FILT_SPEC_MCAST                0x3400
@@ -3342,6 +3344,7 @@ static void mvneta_validate(struct net_device *ndev, unsigned long *supported,
 	if (state->interface != PHY_INTERFACE_MODE_NA &&
 	    state->interface != PHY_INTERFACE_MODE_QSGMII &&
 	    state->interface != PHY_INTERFACE_MODE_SGMII &&
+	    state->interface != PHY_INTERFACE_MODE_2500BASEX &&
 	    !phy_interface_mode_is_8023z(state->interface) &&
 	    !phy_interface_mode_is_rgmii(state->interface)) {
 		bitmap_zero(supported, __ETHTOOL_LINK_MODE_MASK_NBITS);
@@ -3354,9 +3357,15 @@ static void mvneta_validate(struct net_device *ndev, unsigned long *supported,
 
 	/* Asymmetric pause is unsupported */
 	phylink_set(mask, Pause);
-	/* Half-duplex at speeds higher than 100Mbit is unsupported */
-	phylink_set(mask, 1000baseT_Full);
-	phylink_set(mask, 1000baseX_Full);
+
+	/* We cannot use 1Gbps when using the 2.5G interface. */
+	if (state->interface == PHY_INTERFACE_MODE_2500BASEX) {
+		phylink_set(mask, 2500baseT_Full);
+		phylink_set(mask, 2500baseX_Full);
+	} else {
+		phylink_set(mask, 1000baseT_Full);
+		phylink_set(mask, 1000baseX_Full);
+	}
 
 	if (!phy_interface_mode_is_8023z(state->interface)) {
 		/* 10M and 100M are only supported in non-802.3z mode */
@@ -3417,12 +3426,14 @@ static void mvneta_mac_config(struct net_device *ndev, unsigned int mode,
 	struct mvneta_port *pp = netdev_priv(ndev);
 	u32 new_ctrl0, gmac_ctrl0 = mvreg_read(pp, MVNETA_GMAC_CTRL_0);
 	u32 new_ctrl2, gmac_ctrl2 = mvreg_read(pp, MVNETA_GMAC_CTRL_2);
+	u32 new_ctrl4, gmac_ctrl4 = mvreg_read(pp, MVNETA_GMAC_CTRL_4);
 	u32 new_clk, gmac_clk = mvreg_read(pp, MVNETA_GMAC_CLOCK_DIVIDER);
 	u32 new_an, gmac_an = mvreg_read(pp, MVNETA_GMAC_AUTONEG_CONFIG);
 
 	new_ctrl0 = gmac_ctrl0 & ~MVNETA_GMAC0_PORT_1000BASE_X;
 	new_ctrl2 = gmac_ctrl2 & ~(MVNETA_GMAC2_INBAND_AN_ENABLE |
 				   MVNETA_GMAC2_PORT_RESET);
+	new_ctrl4 = gmac_ctrl4 & ~(MVNETA_GMAC4_SHORT_PREAMBLE_ENABLE);
 	new_clk = gmac_clk & ~MVNETA_GMAC_1MS_CLOCK_ENABLE;
 	new_an = gmac_an & ~(MVNETA_GMAC_INBAND_AN_ENABLE |
 			     MVNETA_GMAC_INBAND_RESTART_AN |
@@ -3455,7 +3466,7 @@ static void mvneta_mac_config(struct net_device *ndev, unsigned int mode,
 		if (state->duplex)
 			new_an |= MVNETA_GMAC_CONFIG_FULL_DUPLEX;
 
-		if (state->speed == SPEED_1000)
+		if (state->speed == SPEED_1000 || state->speed == SPEED_2500)
 			new_an |= MVNETA_GMAC_CONFIG_GMII_SPEED;
 		else if (state->speed == SPEED_100)
 			new_an |= MVNETA_GMAC_CONFIG_MII_SPEED;
@@ -3494,10 +3505,18 @@ static void mvneta_mac_config(struct net_device *ndev, unsigned int mode,
 			    MVNETA_GMAC_FORCE_LINK_DOWN);
 	}
 
+	/* When at 2.5G, the link partner can send frames with shortened
+	 * preambles.
+	 */
+	if (state->speed == SPEED_2500)
+		new_ctrl4 |= MVNETA_GMAC4_SHORT_PREAMBLE_ENABLE;
+
 	if (new_ctrl0 != gmac_ctrl0)
 		mvreg_write(pp, MVNETA_GMAC_CTRL_0, new_ctrl0);
 	if (new_ctrl2 != gmac_ctrl2)
 		mvreg_write(pp, MVNETA_GMAC_CTRL_2, new_ctrl2);
+	if (new_ctrl4 != gmac_ctrl4)
+		mvreg_write(pp, MVNETA_GMAC_CTRL_4, new_ctrl4);
 	if (new_clk != gmac_clk)
 		mvreg_write(pp, MVNETA_GMAC_CLOCK_DIVIDER, new_clk);
 	if (new_an != gmac_an)
-- 
2.11.0

