Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972F4C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4389E2077B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4389E2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbeICNIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 09:08:30 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53330 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbeICNIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 09:08:30 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 28E2F22A3F; Mon,  3 Sep 2018 10:49:21 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id D01F420726;
        Mon,  3 Sep 2018 10:49:10 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        andrew@lunn.ch, f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH net-next v2 1/7] net: phy: mscc: factorize code for LEDs mode
Date:   Mon,  3 Sep 2018 10:48:47 +0200
Message-Id: <20180903084853.18092-1-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LEDs modes are set the same way, except they are offset by 4 times the
index of the LED.

Let's factorize all the code so that it's easier to add support for the
4 LEDs of the VSC8584 PHY.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/net/phy/mscc.c | 75 ++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 36 deletions(-)

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index 84ca9ff40ae0..af433f226ef4 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -54,9 +54,9 @@ enum rgmii_rx_clock_delay {
 #define HP_AUTO_MDIX_X_OVER_IND_MASK	  0x2000
 
 #define MSCC_PHY_LED_MODE_SEL		  29
-#define LED_1_MODE_SEL_MASK		  0x00F0
-#define LED_0_MODE_SEL_MASK		  0x000F
-#define LED_1_MODE_SEL_POS		  4
+#define LED_MODE_SEL_POS(x)		  ((x) * 4)
+#define LED_MODE_SEL_MASK(x)		  (GENMASK(3, 0) << LED_MODE_SEL_POS(x))
+#define LED_MODE_SEL(x, mode)		  (((mode) << LED_MODE_SEL_POS(x)) & LED_MODE_SEL_MASK(x))
 
 #define MSCC_EXT_PAGE_ACCESS		  31
 #define MSCC_PHY_PAGE_STANDARD		  0x0000 /* Standard registers */
@@ -103,10 +103,11 @@ enum rgmii_rx_clock_delay {
 
 #define DOWNSHIFT_COUNT_MAX		  5
 
+#define MAX_LEDS			  4
 struct vsc8531_private {
 	int rate_magic;
-	u8 led_0_mode;
-	u8 led_1_mode;
+	u8 leds_mode[MAX_LEDS];
+	u8 nleds;
 };
 
 #ifdef CONFIG_OF_MDIO
@@ -140,14 +141,8 @@ static int vsc85xx_led_cntl_set(struct phy_device *phydev,
 
 	mutex_lock(&phydev->lock);
 	reg_val = phy_read(phydev, MSCC_PHY_LED_MODE_SEL);
-	if (led_num) {
-		reg_val &= ~LED_1_MODE_SEL_MASK;
-		reg_val |= (((u16)mode << LED_1_MODE_SEL_POS) &
-			    LED_1_MODE_SEL_MASK);
-	} else {
-		reg_val &= ~LED_0_MODE_SEL_MASK;
-		reg_val |= ((u16)mode & LED_0_MODE_SEL_MASK);
-	}
+	reg_val &= ~LED_MODE_SEL_MASK(led_num);
+	reg_val |= LED_MODE_SEL(led_num, (u16)mode);
 	rc = phy_write(phydev, MSCC_PHY_LED_MODE_SEL, reg_val);
 	mutex_unlock(&phydev->lock);
 
@@ -438,6 +433,27 @@ static int vsc85xx_dt_led_mode_get(struct phy_device *phydev,
 }
 #endif /* CONFIG_OF_MDIO */
 
+static int vsc85xx_dt_led_modes_get(struct phy_device *phydev, u8 *default_mode)
+{
+	struct vsc8531_private *priv = phydev->priv;
+	char led_dt_prop[19];
+	int i, ret;
+
+	for (i = 0; i < priv->nleds; i++) {
+		ret = sprintf(led_dt_prop, "vsc8531,led-%d-mode", i);
+		if (ret < 0)
+			return ret;
+
+		ret = vsc85xx_dt_led_mode_get(phydev, led_dt_prop,
+					      default_mode[i]);
+		if (ret < 0)
+			return ret;
+		priv->leds_mode[i] = ret;
+	}
+
+	return 0;
+}
+
 static int vsc85xx_edge_rate_cntl_set(struct phy_device *phydev, u8 edge_rate)
 {
 	int rc;
@@ -545,7 +561,7 @@ static int vsc85xx_set_tunable(struct phy_device *phydev,
 
 static int vsc85xx_config_init(struct phy_device *phydev)
 {
-	int rc;
+	int rc, i;
 	struct vsc8531_private *vsc8531 = phydev->priv;
 
 	rc = vsc85xx_default_config(phydev);
@@ -560,13 +576,11 @@ static int vsc85xx_config_init(struct phy_device *phydev)
 	if (rc)
 		return rc;
 
-	rc = vsc85xx_led_cntl_set(phydev, 1, vsc8531->led_1_mode);
-	if (rc)
-		return rc;
-
-	rc = vsc85xx_led_cntl_set(phydev, 0, vsc8531->led_0_mode);
-	if (rc)
-		return rc;
+	for (i = 0; i < vsc8531->nleds; i++) {
+		rc = vsc85xx_led_cntl_set(phydev, i, vsc8531->leds_mode[i]);
+		if (rc)
+			return rc;
+	}
 
 	rc = genphy_config_init(phydev);
 
@@ -626,7 +640,8 @@ static int vsc85xx_probe(struct phy_device *phydev)
 {
 	struct vsc8531_private *vsc8531;
 	int rate_magic;
-	int led_mode;
+	u8 default_mode[2] = {VSC8531_LINK_1000_ACTIVITY,
+	   VSC8531_LINK_100_ACTIVITY};
 
 	rate_magic = vsc85xx_edge_rate_magic_get(phydev);
 	if (rate_magic < 0)
@@ -639,21 +654,9 @@ static int vsc85xx_probe(struct phy_device *phydev)
 	phydev->priv = vsc8531;
 
 	vsc8531->rate_magic = rate_magic;
+	vsc8531->nleds = 2;
 
-	/* LED[0] and LED[1] mode */
-	led_mode = vsc85xx_dt_led_mode_get(phydev, "vsc8531,led-0-mode",
-					   VSC8531_LINK_1000_ACTIVITY);
-	if (led_mode < 0)
-		return led_mode;
-	vsc8531->led_0_mode = led_mode;
-
-	led_mode = vsc85xx_dt_led_mode_get(phydev, "vsc8531,led-1-mode",
-					   VSC8531_LINK_100_ACTIVITY);
-	if (led_mode < 0)
-		return led_mode;
-	vsc8531->led_1_mode = led_mode;
-
-	return 0;
+	return vsc85xx_dt_led_modes_get(phydev, default_mode);
 }
 
 /* Microsemi VSC85xx PHYs */
-- 
2.17.1

