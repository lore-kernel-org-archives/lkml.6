Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3BEFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5772F2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5772F2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbeINNr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:47:28 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34116 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727853AbeINNr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:47:28 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3020A208AC; Fri, 14 Sep 2018 10:34:02 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id E070C207D4;
        Fri, 14 Sep 2018 10:34:01 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Raju Lakkaraju <Raju.Lakkaraju@microsemi.com>
Subject: [PATCH net-next 1/5] net: phy: mscc: add ethtool statistics counters
Date:   Fri, 14 Sep 2018 10:33:43 +0200
Message-Id: <e220fe75053e200f91554b752905d84b14b76eb6.1536913944.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
References: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
In-Reply-To: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
References: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raju Lakkaraju <Raju.Lakkaraju@microsemi.com>

There are a few counters available in the PHY: receive errors, false
carriers, link disconnects, media CRC errors and valids counters.

So let's expose those in the PHY driver.

Use the priv structure as the next PHY to be supported has a few
additional counters.

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microsemi.com>
Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/net/phy/mscc.c | 128 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 128 insertions(+)

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index 2d9676d..62d6e0a 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -33,6 +33,11 @@ enum rgmii_rx_clock_delay {
 #define DISABLE_PAIR_SWAP_CORR_MASK	  0x0020
 #define DISABLE_POLARITY_CORR_MASK	  0x0010
 
+#define MSCC_PHY_ERR_RX_CNT		  19
+#define MSCC_PHY_ERR_FALSE_CARRIER_CNT	  20
+#define MSCC_PHY_ERR_LINK_DISCONNECT_CNT  21
+#define ERR_CNT_MASK			  GENMASK(7, 0)
+
 #define MSCC_PHY_EXT_PHY_CNTL_1           23
 #define MAC_IF_SELECTION_MASK             0x1800
 #define MAC_IF_SELECTION_GMII             0
@@ -64,6 +69,9 @@ enum rgmii_rx_clock_delay {
 #define MSCC_PHY_PAGE_EXTENDED_2	  0x0002 /* Extended reg - page 2 */
 
 /* Extended Page 1 Registers */
+#define MSCC_PHY_CU_MEDIA_CRC_VALID_CNT	  18
+#define VALID_CRC_CNT_CRC_MASK		  GENMASK(13, 0)
+
 #define MSCC_PHY_EXT_MODE_CNTL		  19
 #define FORCE_MDI_CROSSOVER_MASK	  0x000C
 #define FORCE_MDI_CROSSOVER_MDIX	  0x000C
@@ -74,6 +82,8 @@ enum rgmii_rx_clock_delay {
 #define DOWNSHIFT_EN			  0x0010
 #define DOWNSHIFT_CNTL_POS		  2
 
+#define MSCC_PHY_EXT_PHY_CNTL_4		  23
+
 /* Extended Page 2 Registers */
 #define MSCC_PHY_RGMII_CNTL		  20
 #define RGMII_RX_CLK_DELAY_MASK		  0x0070
@@ -119,11 +129,50 @@ enum rgmii_rx_clock_delay {
 				BIT(VSC8531_FORCE_LED_OFF) | \
 				BIT(VSC8531_FORCE_LED_ON))
 
+struct vsc85xx_hw_stat {
+	const char *string;
+	u8 reg;
+	u16 page;
+	u16 mask;
+};
+
+static struct vsc85xx_hw_stat vsc85xx_hw_stats[] = {
+	{
+		.string	= "phy_receive_errors",
+		.reg	= MSCC_PHY_ERR_RX_CNT,
+		.page	= MSCC_PHY_PAGE_STANDARD,
+		.mask	= ERR_CNT_MASK,
+	}, {
+		.string	= "phy_false_carrier",
+		.reg	= MSCC_PHY_ERR_FALSE_CARRIER_CNT,
+		.page	= MSCC_PHY_PAGE_STANDARD,
+		.mask	= ERR_CNT_MASK,
+	}, {
+		.string	= "phy_cu_media_link_disconnect",
+		.reg	= MSCC_PHY_ERR_LINK_DISCONNECT_CNT,
+		.page	= MSCC_PHY_PAGE_STANDARD,
+		.mask	= ERR_CNT_MASK,
+	}, {
+		.string	= "phy_cu_media_crc_good_count",
+		.reg	= MSCC_PHY_CU_MEDIA_CRC_VALID_CNT,
+		.page	= MSCC_PHY_PAGE_EXTENDED,
+		.mask	= VALID_CRC_CNT_CRC_MASK,
+	}, {
+		.string	= "phy_cu_media_crc_error_count",
+		.reg	= MSCC_PHY_EXT_PHY_CNTL_4,
+		.page	= MSCC_PHY_PAGE_EXTENDED,
+		.mask	= ERR_CNT_MASK,
+	},
+};
+
 struct vsc8531_private {
 	int rate_magic;
 	u16 supp_led_modes;
 	u32 leds_mode[MAX_LEDS];
 	u8 nleds;
+	struct vsc85xx_hw_stat *hw_stats;
+	u64 *stats;
+	int nstats;
 };
 
 #ifdef CONFIG_OF_MDIO
@@ -148,6 +197,66 @@ static int vsc85xx_phy_page_set(struct phy_device *phydev, u16 page)
 	return rc;
 }
 
+static int vsc85xx_get_sset_count(struct phy_device *phydev)
+{
+	struct vsc8531_private *priv = phydev->priv;
+
+	if (!priv)
+		return 0;
+
+	return priv->nstats;
+}
+
+static void vsc85xx_get_strings(struct phy_device *phydev, u8 *data)
+{
+	struct vsc8531_private *priv = phydev->priv;
+	int i;
+
+	if (!priv)
+		return;
+
+	for (i = 0; i < priv->nstats; i++)
+		strlcpy(data + i * ETH_GSTRING_LEN, priv->hw_stats[i].string,
+			ETH_GSTRING_LEN);
+}
+
+static u64 vsc85xx_get_stat(struct phy_device *phydev, int i)
+{
+	struct vsc8531_private *priv = phydev->priv;
+	int val;
+	u64 ret;
+
+	vsc85xx_phy_page_set(phydev, priv->hw_stats[i].page);
+
+	val = phy_read(phydev, priv->hw_stats[i].reg);
+	if (val < 0) {
+		ret = U64_MAX;
+		goto out;
+	}
+
+	val = val & priv->hw_stats[i].mask;
+	priv->stats[i] += val;
+	ret = priv->stats[i];
+
+out:
+	vsc85xx_phy_page_set(phydev, MSCC_PHY_PAGE_STANDARD);
+
+	return ret;
+}
+
+static void vsc85xx_get_stats(struct phy_device *phydev,
+			      struct ethtool_stats *stats, u64 *data)
+{
+	struct vsc8531_private *priv = phydev->priv;
+	int i;
+
+	if (!priv)
+		return;
+
+	for (i = 0; i < priv->nstats; i++)
+		data[i] = vsc85xx_get_stat(phydev, i);
+}
+
 static int vsc85xx_led_cntl_set(struct phy_device *phydev,
 				u8 led_num,
 				u8 mode)
@@ -673,6 +782,13 @@ static int vsc85xx_probe(struct phy_device *phydev)
 	vsc8531->rate_magic = rate_magic;
 	vsc8531->nleds = 2;
 	vsc8531->supp_led_modes = VSC85XX_SUPP_LED_MODES;
+	vsc8531->hw_stats = vsc85xx_hw_stats;
+	vsc8531->nstats = ARRAY_SIZE(vsc85xx_hw_stats);
+	vsc8531->stats = devm_kzalloc(&phydev->mdio.dev,
+				      sizeof(u64) * vsc8531->nstats,
+				      GFP_KERNEL);
+	if (!vsc8531->stats)
+		return -ENOMEM;
 
 	return vsc85xx_dt_led_modes_get(phydev, default_mode);
 }
@@ -699,6 +815,9 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_wol	= &vsc85xx_wol_get,
 	.get_tunable	= &vsc85xx_get_tunable,
 	.set_tunable	= &vsc85xx_set_tunable,
+	.get_sset_count = &vsc85xx_get_sset_count,
+	.get_strings    = &vsc85xx_get_strings,
+	.get_stats      = &vsc85xx_get_stats,
 },
 {
 	.phy_id		= PHY_ID_VSC8531,
@@ -720,6 +839,9 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_wol	= &vsc85xx_wol_get,
 	.get_tunable	= &vsc85xx_get_tunable,
 	.set_tunable	= &vsc85xx_set_tunable,
+	.get_sset_count = &vsc85xx_get_sset_count,
+	.get_strings    = &vsc85xx_get_strings,
+	.get_stats      = &vsc85xx_get_stats,
 },
 {
 	.phy_id		= PHY_ID_VSC8540,
@@ -741,6 +863,9 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_wol	= &vsc85xx_wol_get,
 	.get_tunable	= &vsc85xx_get_tunable,
 	.set_tunable	= &vsc85xx_set_tunable,
+	.get_sset_count = &vsc85xx_get_sset_count,
+	.get_strings    = &vsc85xx_get_strings,
+	.get_stats      = &vsc85xx_get_stats,
 },
 {
 	.phy_id		= PHY_ID_VSC8541,
@@ -762,6 +887,9 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_wol	= &vsc85xx_wol_get,
 	.get_tunable	= &vsc85xx_get_tunable,
 	.set_tunable	= &vsc85xx_set_tunable,
+	.get_sset_count = &vsc85xx_get_sset_count,
+	.get_strings    = &vsc85xx_get_strings,
+	.get_stats      = &vsc85xx_get_stats,
 }
 
 };
-- 
git-series 0.9.1
