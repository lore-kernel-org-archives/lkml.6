Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D36CC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D8820856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D8820856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbeICNIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 09:08:31 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53362 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbeICNIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 09:08:30 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 27DBC22A39; Mon,  3 Sep 2018 10:49:22 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id D3E8F22A3A;
        Mon,  3 Sep 2018 10:49:11 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        andrew@lunn.ch, f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH net-next v2 5/7] net: phy: mscc: read 'vsc8531,led-%d-mode' as an u32
Date:   Mon,  3 Sep 2018 10:48:51 +0200
Message-Id: <20180903084853.18092-5-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180903084853.18092-1-quentin.schulz@bootlin.com>
References: <20180903084853.18092-1-quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the DT binding, it is specified nowhere that 'vsc8531,led-%d-mode' is
an u8, even though it's read as an u8 in the driver.

Let's update the driver to take into consideration that the
'vsc8531,led-%d-mode' property is of the default type u32.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---

added in v2 in lieu of the DT binding patch for adding /bits 8/ to the
vsc8531,led-N-mode property

 drivers/net/phy/mscc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index 3c7b02bb5c38..2d9676d78d3f 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -122,7 +122,7 @@ enum rgmii_rx_clock_delay {
 struct vsc8531_private {
 	int rate_magic;
 	u16 supp_led_modes;
-	u8 leds_mode[MAX_LEDS];
+	u32 leds_mode[MAX_LEDS];
 	u8 nleds;
 };
 
@@ -414,19 +414,19 @@ static int vsc85xx_edge_rate_magic_get(struct phy_device *phydev)
 
 static int vsc85xx_dt_led_mode_get(struct phy_device *phydev,
 				   char *led,
-				   u8 default_mode)
+				   u32 default_mode)
 {
 	struct vsc8531_private *priv = phydev->priv;
 	struct device *dev = &phydev->mdio.dev;
 	struct device_node *of_node = dev->of_node;
-	u8 led_mode;
+	u32 led_mode;
 	int err;
 
 	if (!of_node)
 		return -ENODEV;
 
 	led_mode = default_mode;
-	err = of_property_read_u8(of_node, led, &led_mode);
+	err = of_property_read_u32(of_node, led, &led_mode);
 	if (!err && !(BIT(led_mode) & priv->supp_led_modes)) {
 		phydev_err(phydev, "DT %s invalid\n", led);
 		return -EINVAL;
@@ -449,7 +449,8 @@ static int vsc85xx_dt_led_mode_get(struct phy_device *phydev,
 }
 #endif /* CONFIG_OF_MDIO */
 
-static int vsc85xx_dt_led_modes_get(struct phy_device *phydev, u8 *default_mode)
+static int vsc85xx_dt_led_modes_get(struct phy_device *phydev,
+				    u32 *default_mode)
 {
 	struct vsc8531_private *priv = phydev->priv;
 	char led_dt_prop[19];
@@ -656,7 +657,7 @@ static int vsc85xx_probe(struct phy_device *phydev)
 {
 	struct vsc8531_private *vsc8531;
 	int rate_magic;
-	u8 default_mode[2] = {VSC8531_LINK_1000_ACTIVITY,
+	u32 default_mode[2] = {VSC8531_LINK_1000_ACTIVITY,
 	   VSC8531_LINK_100_ACTIVITY};
 
 	rate_magic = vsc85xx_edge_rate_magic_get(phydev);
-- 
2.17.1

