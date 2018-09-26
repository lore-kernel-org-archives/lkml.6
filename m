Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3B2C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48632152F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A48632152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbeIZXoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:44:32 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:43102 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbeIZXoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:44:32 -0400
X-IronPort-AV: E=Sophos;i="5.54,307,1534834800"; 
   d="scan'208";a="17824474"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Sep 2018 10:30:32 -0700
Received: from validation1-HP-EliteBook-8540p.mchp-main.com (10.10.76.4) by
 chn-sv-exch03.mchp-main.com (10.10.76.49) with Microsoft SMTP Server id
 14.3.352.0; Wed, 26 Sep 2018 10:30:32 -0700
From:   Yuiko Oshino <yuiko.oshino@microchip.com>
To:     <andrew@lunn.ch>, <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <UNGLinuxDriver@microchip.com>
Subject: [PATCH net] net: phy: micrel: add Microchip KSZ9131 inital driver
Date:   Wed, 26 Sep 2018 14:22:21 -0400
Message-ID: <1537986141-22832-1-git-send-email-yuiko.oshino@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Microchip Technology KSZ9131 10/100/1000 Ethernet phy

Signed-off-by: Yuiko Oshino <yuiko.oshino@microchip.com>
---
 drivers/net/phy/micrel.c   | 32 +++++++++++++++++++++++++++++---
 include/linux/micrel_phy.h |  1 +
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 3db06b4..a4473cb 100644
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
@@ -425,6 +425,7 @@ static int ksz9021_config_init(struct phy_device *phydev)
 #define MII_KSZ9031RN_MMD_REGDATA_REG	0x0e
 #define OP_DATA				1
 #define KSZ9031_PS_TO_REG		60
+#define KSZ9131_PS_TO_REG		100
 
 /* Extended registers */
 /* MMD Address 0x0 */
@@ -470,6 +471,10 @@ static int ksz9031_of_load_skew_values(struct phy_device *phydev,
 	u16 maxval;
 	u16 newval;
 	int i;
+	int pstoreg = KSZ9031_PS_TO_REG;
+
+	if (phydev->drv->phy_id == PHY_ID_KSZ9131)
+		pstoreg = KSZ9131_PS_TO_REG;
 
 	for (i = 0; i < numfields; i++)
 		if (!of_property_read_u32(of_node, field[i], val + i))
@@ -489,7 +494,7 @@ static int ksz9031_of_load_skew_values(struct phy_device *phydev,
 			mask = 0xffff;
 			mask ^= maxval << (field_sz * i);
 			newval = (newval & mask) |
-				(((val[i] / KSZ9031_PS_TO_REG) & maxval)
+				(((val[i] / pstoreg) & maxval)
 					<< (field_sz * i));
 		}
 
@@ -602,7 +607,10 @@ static int ksz9031_config_init(struct phy_device *phydev)
 		}
 	}
 
-	return ksz9031_center_flp_timing(phydev);
+	if (phydev->drv->phy_id == PHY_ID_KSZ9031)
+		return ksz9031_center_flp_timing(phydev);
+	else
+		return 0;
 
 err_force_master:
 	phydev_err(phydev, "failed to force the phy to master mode\n");
@@ -975,6 +983,23 @@ static struct phy_driver ksphy_driver[] = {
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
+	.config_init	= ksz9031_config_init,
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
@@ -1022,6 +1047,7 @@ MODULE_LICENSE("GPL");
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

