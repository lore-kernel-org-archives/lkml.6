Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1088CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26F62077B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26F62077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbeICNIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 09:08:30 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53337 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbeICNIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 09:08:30 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 645A222A3E; Mon,  3 Sep 2018 10:49:21 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 19D9320DEA;
        Mon,  3 Sep 2018 10:49:11 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        andrew@lunn.ch, f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH net-next v2 2/7] net: phy: mscc: factorize function for getting LED mode from DT
Date:   Mon,  3 Sep 2018 10:48:48 +0200
Message-Id: <20180903084853.18092-2-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180903084853.18092-1-quentin.schulz@bootlin.com>
References: <20180903084853.18092-1-quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Microsemi PHYs support different LED modes depending on the variant, so
let's factorize the code so we just have to give the supported modes
while the logic behind getting the mode remains identical.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---

added in v2

 drivers/net/phy/mscc.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index af433f226ef4..aa37e8547cd0 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -104,8 +104,24 @@ enum rgmii_rx_clock_delay {
 #define DOWNSHIFT_COUNT_MAX		  5
 
 #define MAX_LEDS			  4
+#define VSC85XX_SUPP_LED_MODES (BIT(VSC8531_LINK_ACTIVITY) | \
+				BIT(VSC8531_LINK_1000_ACTIVITY) | \
+				BIT(VSC8531_LINK_100_ACTIVITY) | \
+				BIT(VSC8531_LINK_10_ACTIVITY) | \
+				BIT(VSC8531_LINK_100_1000_ACTIVITY) | \
+				BIT(VSC8531_LINK_10_1000_ACTIVITY) | \
+				BIT(VSC8531_LINK_10_100_ACTIVITY) | \
+				BIT(VSC8531_DUPLEX_COLLISION) | \
+				BIT(VSC8531_COLLISION) | \
+				BIT(VSC8531_ACTIVITY) | \
+				BIT(VSC8531_AUTONEG_FAULT) | \
+				BIT(VSC8531_SERIAL_MODE) | \
+				BIT(VSC8531_FORCE_LED_OFF) | \
+				BIT(VSC8531_FORCE_LED_ON))
+
 struct vsc8531_private {
 	int rate_magic;
+	u16 supp_led_modes;
 	u8 leds_mode[MAX_LEDS];
 	u8 nleds;
 };
@@ -401,6 +417,7 @@ static int vsc85xx_dt_led_mode_get(struct phy_device *phydev,
 				   char *led,
 				   u8 default_mode)
 {
+	struct vsc8531_private *priv = phydev->priv;
 	struct device *dev = &phydev->mdio.dev;
 	struct device_node *of_node = dev->of_node;
 	u8 led_mode;
@@ -411,7 +428,7 @@ static int vsc85xx_dt_led_mode_get(struct phy_device *phydev,
 
 	led_mode = default_mode;
 	err = of_property_read_u8(of_node, led, &led_mode);
-	if (!err && (led_mode > 15 || led_mode == 7 || led_mode == 11)) {
+	if (!err && !(BIT(led_mode) & priv->supp_led_modes)) {
 		phydev_err(phydev, "DT %s invalid\n", led);
 		return -EINVAL;
 	}
@@ -655,6 +672,7 @@ static int vsc85xx_probe(struct phy_device *phydev)
 
 	vsc8531->rate_magic = rate_magic;
 	vsc8531->nleds = 2;
+	vsc8531->supp_led_modes = VSC85XX_SUPP_LED_MODES;
 
 	return vsc85xx_dt_led_modes_get(phydev, default_mode);
 }
-- 
2.17.1

