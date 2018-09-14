Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674C2C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF302146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF302146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbeINNr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:47:29 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34124 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728037AbeINNr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:47:29 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5D41D208B7; Fri, 14 Sep 2018 10:34:02 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1F4FA20731;
        Fri, 14 Sep 2018 10:34:02 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Subject: [PATCH net-next 2/5] net: phy: mscc: Add EEE init sequence
Date:   Fri, 14 Sep 2018 10:33:44 +0200
Message-Id: <64809c5f01f3c6407257553a286b82949cef1ac0.1536913944.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
References: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
In-Reply-To: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
References: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
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

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/net/phy/mscc.c | 54 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+)

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index 62d6e0a..c0a9ea9 100644
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
@@ -685,6 +693,48 @@ static int vsc85xx_set_tunable(struct phy_device *phydev,
 	}
 }
 
+static void vsc85xx_tr_write(struct phy_device *phydev, u16 addr, u32 val)
+{
+	phy_write(phydev, MSCC_PHY_TR_MSB, val >> 16);
+	phy_write(phydev, MSCC_PHY_TR_LSB, val & GENMASK(15, 0));
+	phy_write(phydev, MSCC_PHY_TR_CNTL, TR_WRITE | TR_ADDR(addr));
+}
+
+static int vsc85xx_eee_init_seq_set(struct phy_device *phydev)
+{
+	int rc;
+
+	mutex_lock(&phydev->lock);
+	rc = vsc85xx_phy_page_set(phydev, MSCC_PHY_PAGE_TR);
+	if (rc)
+		goto out_unlock;
+
+	vsc85xx_tr_write(phydev, 0x0f82, 0x0012b00a);
+	vsc85xx_tr_write(phydev, 0x1686, 0x00000004);
+	vsc85xx_tr_write(phydev, 0x168c, 0x00d2c46f);
+	vsc85xx_tr_write(phydev, 0x17a2, 0x00000620);
+	vsc85xx_tr_write(phydev, 0x16a0, 0x00eeffdd);
+	vsc85xx_tr_write(phydev, 0x16a6, 0x00071448);
+	vsc85xx_tr_write(phydev, 0x16a4, 0x0013132f);
+	vsc85xx_tr_write(phydev, 0x16a8, 0x00000000);
+	vsc85xx_tr_write(phydev, 0x0ffc, 0x00c0a028);
+	vsc85xx_tr_write(phydev, 0x0fe8, 0x0091b06c);
+	vsc85xx_tr_write(phydev, 0x0fea, 0x00041600);
+	vsc85xx_tr_write(phydev, 0x0f80, 0x00000af4);
+	vsc85xx_tr_write(phydev, 0x0fec, 0x00901809);
+	vsc85xx_tr_write(phydev, 0x0fee, 0x0000a6a1);
+	vsc85xx_tr_write(phydev, 0x0ffe, 0x00b01007);
+	vsc85xx_tr_write(phydev, 0x16b0, 0x00eeff00);
+	vsc85xx_tr_write(phydev, 0x16b2, 0x00007000);
+	vsc85xx_tr_write(phydev, 0x16b4, 0x00000814);
+
+out_unlock:
+	rc = vsc85xx_phy_page_set(phydev, MSCC_PHY_PAGE_STANDARD);
+	mutex_unlock(&phydev->lock);
+
+	return rc;
+}
+
 static int vsc85xx_config_init(struct phy_device *phydev)
 {
 	int rc, i;
@@ -702,6 +752,10 @@ static int vsc85xx_config_init(struct phy_device *phydev)
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
git-series 0.9.1
