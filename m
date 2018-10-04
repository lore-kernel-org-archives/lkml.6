Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CE0C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD3220684
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD3220684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeJDTom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:44:42 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37519 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727293AbeJDToL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:44:11 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 95623207C4; Thu,  4 Oct 2018 14:50:59 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 43FC9207CC;
        Thu,  4 Oct 2018 14:50:49 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com,
        Raju Lakkaraju <Raju.Lakkaraju@microchip.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH net-next v2 3/6] net: phy: mscc: Add EEE init sequence
Date:   Thu,  4 Oct 2018 14:47:25 +0200
Message-Id: <20181004124728.9821-4-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004124728.9821-1-quentin.schulz@bootlin.com>
References: <20181004124728.9821-1-quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>

Microsemi PHYs (VSC 8530/31/40/41) need to update the Energy Efficient
Ethernet initialization sequence.
In order to avoid certain link state errors that could result in link
drops and packet loss, the physical coding sublayer (PCS) must be
updated with settings related to EEE in order to improve performance.

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/net/phy/mscc.c | 65 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index ca97488d76ef..f863a580308f 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -67,6 +67,7 @@ enum rgmii_rx_clock_delay {
 #define MSCC_PHY_PAGE_STANDARD		  0x0000 /* Standard registers */
 #define MSCC_PHY_PAGE_EXTENDED		  0x0001 /* Extended registers */
 #define MSCC_PHY_PAGE_EXTENDED_2	  0x0002 /* Extended reg - page 2 */
+#define MSCC_PHY_PAGE_TR		  0x52b5 /* Token ring registers */
 
 /* Extended Page 1 Registers */
 #define MSCC_PHY_CU_MEDIA_CRC_VALID_CNT	  18
@@ -100,6 +101,13 @@ enum rgmii_rx_clock_delay {
 #define SECURE_ON_ENABLE		  0x8000
 #define SECURE_ON_PASSWD_LEN_4		  0x4000
 
+/* Token ring page Registers */
+#define MSCC_PHY_TR_CNTL		  16
+#define TR_WRITE			  0x8000
+#define TR_ADDR(x)			  (0x7fff & (x))
+#define MSCC_PHY_TR_LSB			  17
+#define MSCC_PHY_TR_MSB			  18
+
 /* Microsemi PHY ID's */
 #define PHY_ID_VSC8530			  0x00070560
 #define PHY_ID_VSC8531			  0x00070570
@@ -129,6 +137,11 @@ enum rgmii_rx_clock_delay {
 				BIT(VSC8531_FORCE_LED_OFF) | \
 				BIT(VSC8531_FORCE_LED_ON))
 
+struct reg_val {
+	u16	reg;
+	u32	val;
+};
+
 struct vsc85xx_hw_stat {
 	const char *string;
 	u8 reg;
@@ -693,6 +706,54 @@ static int vsc85xx_set_tunable(struct phy_device *phydev,
 	}
 }
 
+/* mdiobus lock should be locked when using this function */
+static void vsc85xx_tr_write(struct phy_device *phydev, u16 addr, u32 val)
+{
+	__phy_write(phydev, MSCC_PHY_TR_MSB, val >> 16);
+	__phy_write(phydev, MSCC_PHY_TR_LSB, val & GENMASK(15, 0));
+	__phy_write(phydev, MSCC_PHY_TR_CNTL, TR_WRITE | TR_ADDR(addr));
+}
+
+static int vsc85xx_eee_init_seq_set(struct phy_device *phydev)
+{
+	const struct reg_val init_eee[] = {
+		{0x0f82, 0x0012b00a},
+		{0x1686, 0x00000004},
+		{0x168c, 0x00d2c46f},
+		{0x17a2, 0x00000620},
+		{0x16a0, 0x00eeffdd},
+		{0x16a6, 0x00071448},
+		{0x16a4, 0x0013132f},
+		{0x16a8, 0x00000000},
+		{0x0ffc, 0x00c0a028},
+		{0x0fe8, 0x0091b06c},
+		{0x0fea, 0x00041600},
+		{0x0f80, 0x00000af4},
+		{0x0fec, 0x00901809},
+		{0x0fee, 0x0000a6a1},
+		{0x0ffe, 0x00b01007},
+		{0x16b0, 0x00eeff00},
+		{0x16b2, 0x00007000},
+		{0x16b4, 0x00000814},
+	};
+	unsigned int i;
+	int oldpage;
+
+	mutex_lock(&phydev->lock);
+	oldpage = phy_select_page(phydev, MSCC_PHY_PAGE_TR);
+	if (oldpage < 0)
+		goto out_unlock;
+
+	for (i = 0; i < ARRAY_SIZE(init_eee); i++)
+		vsc85xx_tr_write(phydev, init_eee[i].reg, init_eee[i].val);
+
+out_unlock:
+	oldpage = phy_restore_page(phydev, oldpage, oldpage);
+	mutex_unlock(&phydev->lock);
+
+	return oldpage;
+}
+
 static int vsc85xx_config_init(struct phy_device *phydev)
 {
 	int rc, i;
@@ -710,6 +771,10 @@ static int vsc85xx_config_init(struct phy_device *phydev)
 	if (rc)
 		return rc;
 
+	rc = vsc85xx_eee_init_seq_set(phydev);
+	if (rc)
+		return rc;
+
 	for (i = 0; i < vsc8531->nleds; i++) {
 		rc = vsc85xx_led_cntl_set(phydev, i, vsc8531->leds_mode[i]);
 		if (rc)
-- 
2.17.1

