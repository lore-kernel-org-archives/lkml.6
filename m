Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59C7C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A26205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A26205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbeJSCRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:17:24 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:58948 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbeJSCRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:17:24 -0400
X-IronPort-AV: E=Sophos;i="5.54,397,1534834800"; 
   d="scan'208";a="21902677"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 18 Oct 2018 11:15:13 -0700
Received: from validation1-HP-EliteBook-8540p.mchp-main.com (10.10.76.4) by
 CHN-SV-EXCH01.mchp-main.com (10.10.76.37) with Microsoft SMTP Server id
 14.3.352.0; Thu, 18 Oct 2018 11:15:12 -0700
From:   Yuiko Oshino <yuiko.oshino@microchip.com>
To:     <davem@davemloft.net>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <f.fainelli@gmail.com>,
        <andrew@lunn.ch>
CC:     <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <m.felsch@pengutronix.de>, <Markus.Niebel@tqs.de>,
        <netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH v3 net-next 1/2] net: phy: micrel: add Microchip KSZ9131 initial driver
Date:   Thu, 18 Oct 2018 15:06:01 -0400
Message-ID: <1539889562-21458-2-git-send-email-yuiko.oshino@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539889562-21458-1-git-send-email-yuiko.oshino@microchip.com>
References: <1539889562-21458-1-git-send-email-yuiko.oshino@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Microchip Technology KSZ9131 10/100/1000 Ethernet PHY

Signed-off-by: Yuiko Oshino <yuiko.oshino@microchip.com>
---
 drivers/net/phy/micrel.c   | 130 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/micrel_phy.h |   1 +
 2 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 3db06b4..270ea16 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -14,7 +14,7 @@
  * option) any later version.
  *
  * Support : Micrel Phys:
- *		Giga phys: ksz9021, ksz9031
+ *		Giga phys: ksz9021, ksz9031, ksz9131
  *		100/10 Phys : ksz8001, ksz8721, ksz8737, ksz8041
  *			   ksz8021, ksz8031, ksz8051,
  *			   ksz8081, ksz8091,
@@ -609,6 +609,116 @@ static int ksz9031_config_init(struct phy_device *phydev)
 	return result;
 }
 
+#define KSZ9131_SKEW_5BIT_MAX	2400
+#define KSZ9131_SKEW_4BIT_MAX	800
+#define KSZ9131_OFFSET		700
+#define KSZ9131_STEP		100
+
+static int ksz9131_of_load_skew_values(struct phy_device *phydev,
+				       struct device_node *of_node,
+				       u16 reg, size_t field_sz,
+				       char *field[], u8 numfields)
+{
+	int val[4] = {-(1 + KSZ9131_OFFSET), -(2 + KSZ9131_OFFSET),
+		      -(3 + KSZ9131_OFFSET), -(4 + KSZ9131_OFFSET)};
+	int skewval, skewmax = 0;
+	int matches = 0;
+	u16 maxval;
+	u16 newval;
+	u16 mask;
+	int i;
+
+	/* psec properties in dts should mean x pico seconds */
+	if (field_sz == 5)
+		skewmax = KSZ9131_SKEW_5BIT_MAX;
+	else
+		skewmax = KSZ9131_SKEW_4BIT_MAX;
+
+	for (i = 0; i < numfields; i++)
+		if (!of_property_read_s32(of_node, field[i], &skewval)) {
+			if (skewval < -KSZ9131_OFFSET)
+				skewval = -KSZ9131_OFFSET;
+			else if (skewval > skewmax)
+				skewval = skewmax;
+
+			val[i] = skewval + KSZ9131_OFFSET;
+			matches++;
+		}
+
+	if (!matches)
+		return 0;
+
+	if (matches < numfields)
+		newval = ksz9031_extended_read(phydev, OP_DATA, 2, reg);
+	else
+		newval = 0;
+
+	maxval = (field_sz == 4) ? 0xf : 0x1f;
+	for (i = 0; i < numfields; i++)
+		if (val[i] != -(i + 1 + KSZ9131_OFFSET)) {
+			mask = 0xffff;
+			mask ^= maxval << (field_sz * i);
+			newval = (newval & mask) |
+				(((val[i] / KSZ9131_STEP) & maxval)
+					<< (field_sz * i));
+		}
+
+	return ksz9031_extended_write(phydev, OP_DATA, 2, reg, newval);
+}
+
+static int ksz9131_config_init(struct phy_device *phydev)
+{
+	const struct device *dev = &phydev->mdio.dev;
+	struct device_node *of_node = dev->of_node;
+	char *clk_skews[2] = {"rxc-skew-psec", "txc-skew-psec"};
+	char *rx_data_skews[4] = {
+		"rxd0-skew-psec", "rxd1-skew-psec",
+		"rxd2-skew-psec", "rxd3-skew-psec"
+	};
+	char *tx_data_skews[4] = {
+		"txd0-skew-psec", "txd1-skew-psec",
+		"txd2-skew-psec", "txd3-skew-psec"
+	};
+	char *control_skews[2] = {"txen-skew-psec", "rxdv-skew-psec"};
+	const struct device *dev_walker;
+	int ret;
+
+	dev_walker = &phydev->mdio.dev;
+	do {
+		of_node = dev_walker->of_node;
+		dev_walker = dev_walker->parent;
+	} while (!of_node && dev_walker);
+
+	if (!of_node)
+		return 0;
+
+	ret = ksz9131_of_load_skew_values(phydev, of_node,
+					  MII_KSZ9031RN_CLK_PAD_SKEW, 5,
+					  clk_skews, 2);
+	if (ret < 0)
+		return ret;
+
+	ret = ksz9131_of_load_skew_values(phydev, of_node,
+					  MII_KSZ9031RN_CONTROL_PAD_SKEW, 4,
+					  control_skews, 2);
+	if (ret < 0)
+		return ret;
+
+	ret = ksz9131_of_load_skew_values(phydev, of_node,
+					  MII_KSZ9031RN_RX_DATA_PAD_SKEW, 4,
+					  rx_data_skews, 4);
+	if (ret < 0)
+		return ret;
+
+	ret = ksz9131_of_load_skew_values(phydev, of_node,
+					  MII_KSZ9031RN_TX_DATA_PAD_SKEW, 4,
+					  tx_data_skews, 4);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 #define KSZ8873MLL_GLOBAL_CONTROL_4	0x06
 #define KSZ8873MLL_GLOBAL_CONTROL_4_DUPLEX	BIT(6)
 #define KSZ8873MLL_GLOBAL_CONTROL_4_SPEED	BIT(4)
@@ -975,6 +1085,23 @@ static struct phy_driver ksphy_driver[] = {
 	.suspend	= genphy_suspend,
 	.resume		= kszphy_resume,
 }, {
+	.phy_id		= PHY_ID_KSZ9131,
+	.phy_id_mask	= MICREL_PHY_ID_MASK,
+	.name		= "Microchip KSZ9131 Gigabit PHY",
+	.features	= PHY_GBIT_FEATURES,
+	.flags		= PHY_HAS_INTERRUPT,
+	.driver_data	= &ksz9021_type,
+	.probe		= kszphy_probe,
+	.config_init	= ksz9131_config_init,
+	.read_status	= ksz9031_read_status,
+	.ack_interrupt	= kszphy_ack_interrupt,
+	.config_intr	= kszphy_config_intr,
+	.get_sset_count = kszphy_get_sset_count,
+	.get_strings	= kszphy_get_strings,
+	.get_stats	= kszphy_get_stats,
+	.suspend	= genphy_suspend,
+	.resume		= kszphy_resume,
+}, {
 	.phy_id		= PHY_ID_KSZ8873MLL,
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
 	.name		= "Micrel KSZ8873MLL Switch",
@@ -1022,6 +1149,7 @@ MODULE_LICENSE("GPL");
 static struct mdio_device_id __maybe_unused micrel_tbl[] = {
 	{ PHY_ID_KSZ9021, 0x000ffffe },
 	{ PHY_ID_KSZ9031, MICREL_PHY_ID_MASK },
+	{ PHY_ID_KSZ9131, MICREL_PHY_ID_MASK },
 	{ PHY_ID_KSZ8001, 0x00fffffc },
 	{ PHY_ID_KS8737, MICREL_PHY_ID_MASK },
 	{ PHY_ID_KSZ8021, 0x00ffffff },
diff --git a/include/linux/micrel_phy.h b/include/linux/micrel_phy.h
index 472fa4d..7361cd3 100644
--- a/include/linux/micrel_phy.h
+++ b/include/linux/micrel_phy.h
@@ -31,6 +31,7 @@
 #define PHY_ID_KSZ8081		0x00221560
 #define PHY_ID_KSZ8061		0x00221570
 #define PHY_ID_KSZ9031		0x00221620
+#define PHY_ID_KSZ9131		0x00221640
 
 #define PHY_ID_KSZ886X		0x00221430
 #define PHY_ID_KSZ8863		0x00221435
-- 
2.7.4

