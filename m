Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC29C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECAC21B1A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436490AbfBNDs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:48:59 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:35730 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405549AbfBNDsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:48:47 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 058008E3585385FDF466;
        Thu, 14 Feb 2019 11:48:44 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Thu, 14 Feb 2019 11:48:35 +0800
From:   Jian Shen <shenjian15@huawei.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 1/2] net: phy: marvell: add new m88e1510 LED configuration
Date:   Thu, 14 Feb 2019 12:31:06 +0800
Message-ID: <1550118667-119947-2-git-send-email-shenjian15@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550118667-119947-1-git-send-email-shenjian15@huawei.com>
References: <1550118667-119947-1-git-send-email-shenjian15@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default m88e1510 LED configuration is 0x1177, used LED[0]
for 1000M link, LED[1] for 100M link, and LED[2] for active.
But for our boards, we want to use 0x1040, which use LED[0] for
link, and LED[1] for active.

This patch adds a new m88e1510 LED configuration for it.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
---
 drivers/net/phy/marvell.c   | 22 +++++++++++++++++++++-
 include/linux/marvell_phy.h |  1 +
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 3ccba37..c195286 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -128,6 +128,10 @@
 #define MII_PHY_LED_CTRL	        16
 #define MII_88E1121_PHY_LED_DEF		0x0030
 #define MII_88E1510_PHY_LED_DEF		0x1177
+#define MII_88E1510_PHY_HNS3_LED_DEF	0x1040
+
+#define MII_88E1510_PHY_LED_POLARITY_CTRL	0x11
+#define MII_88E1510_PHY_HNS3_LED_POLARITY	0x4415
 
 #define MII_M1011_PHY_STATUS		0x11
 #define MII_M1011_PHY_STATUS_1000	0x8000
@@ -619,12 +623,19 @@ static void marvell_config_led(struct phy_device *phydev)
 		def_config = MII_88E1121_PHY_LED_DEF;
 		break;
 	/* Default PHY LED config:
+	 * For hns3:
+	 * LED[0] .. Link
+	 * LED[1] .. Activity
+	 * For others:
 	 * LED[0] .. 1000Mbps Link
 	 * LED[1] .. 100Mbps Link
 	 * LED[2] .. Blink, Activity
 	 */
 	case MARVELL_PHY_FAMILY_ID(MARVELL_PHY_ID_88E1510):
-		def_config = MII_88E1510_PHY_LED_DEF;
+		if (phydev->dev_flags & MARVELL_PHY_M1510_HNS3_LEDS)
+			def_config = MII_88E1510_PHY_HNS3_LED_DEF;
+		else
+			def_config = MII_88E1510_PHY_LED_DEF;
 		break;
 	default:
 		return;
@@ -634,6 +645,15 @@ static void marvell_config_led(struct phy_device *phydev)
 			      def_config);
 	if (err < 0)
 		phydev_warn(phydev, "Fail to config marvell phy LED.\n");
+
+	if (phydev->dev_flags & MARVELL_PHY_M1510_HNS3_LEDS) {
+		err = phy_write_paged(phydev, MII_MARVELL_LED_PAGE,
+				      MII_88E1510_PHY_LED_POLARITY_CTRL,
+				      MII_88E1510_PHY_HNS3_LED_POLARITY);
+		if (err < 0)
+			phydev_warn(phydev,
+				    "Fail to config marvell phy LED polarity.\n");
+	}
 }
 
 static int marvell_config_init(struct phy_device *phydev)
diff --git a/include/linux/marvell_phy.h b/include/linux/marvell_phy.h
index 1eb6f24..99e0bbb 100644
--- a/include/linux/marvell_phy.h
+++ b/include/linux/marvell_phy.h
@@ -32,5 +32,6 @@
 /* struct phy_device dev_flags definitions */
 #define MARVELL_PHY_M1145_FLAGS_RESISTANCE	0x00000001
 #define MARVELL_PHY_M1118_DNS323_LEDS		0x00000002
+#define MARVELL_PHY_M1510_HNS3_LEDS		0x00000004
 
 #endif /* _MARVELL_PHY_H */
-- 
1.9.1

