Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE58C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71F720839
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71F720839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388067AbeHWMWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:22:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51986 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728574AbeHWMWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:22:03 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A5D29C74;
        Thu, 23 Aug 2018 08:53:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wang Dongsheng <dongsheng.wang@hxt-semitech.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 181/324] net: phy: marvell: change default m88e1510 LED configuration
Date:   Thu, 23 Aug 2018 09:54:07 +0200
Message-Id: <20180823075005.264686687@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>

[ Upstream commit 077772468ec141b22e1e7c0c58bc09e2f9dc8762 ]

The m88e1121 LED default configuration does not apply m88e151x.
So add a function to relpace m88e1121 LED configuration.

Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/marvell.c   |   54 +++++++++++++++++++++++++++++---------------
 include/linux/marvell_phy.h |    2 +
 2 files changed, 38 insertions(+), 18 deletions(-)

--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -130,8 +130,9 @@
 #define MII_88E1318S_PHY_WOL_CTRL_CLEAR_WOL_STATUS		BIT(12)
 #define MII_88E1318S_PHY_WOL_CTRL_MAGIC_PACKET_MATCH_ENABLE	BIT(14)
 
-#define MII_88E1121_PHY_LED_CTRL	16
+#define MII_PHY_LED_CTRL	        16
 #define MII_88E1121_PHY_LED_DEF		0x0030
+#define MII_88E1510_PHY_LED_DEF		0x1177
 
 #define MII_M1011_PHY_STATUS		0x11
 #define MII_M1011_PHY_STATUS_1000	0x8000
@@ -632,8 +633,40 @@ error:
 	return err;
 }
 
+static void marvell_config_led(struct phy_device *phydev)
+{
+	u16 def_config;
+	int err;
+
+	switch (MARVELL_PHY_FAMILY_ID(phydev->phy_id)) {
+	/* Default PHY LED config: LED[0] .. Link, LED[1] .. Activity */
+	case MARVELL_PHY_FAMILY_ID(MARVELL_PHY_ID_88E1121R):
+	case MARVELL_PHY_FAMILY_ID(MARVELL_PHY_ID_88E1318S):
+		def_config = MII_88E1121_PHY_LED_DEF;
+		break;
+	/* Default PHY LED config:
+	 * LED[0] .. 1000Mbps Link
+	 * LED[1] .. 100Mbps Link
+	 * LED[2] .. Blink, Activity
+	 */
+	case MARVELL_PHY_FAMILY_ID(MARVELL_PHY_ID_88E1510):
+		def_config = MII_88E1510_PHY_LED_DEF;
+		break;
+	default:
+		return;
+	}
+
+	err = phy_write_paged(phydev, MII_MARVELL_LED_PAGE, MII_PHY_LED_CTRL,
+			      def_config);
+	if (err < 0)
+		pr_warn("Fail to config marvell phy LED.\n");
+}
+
 static int marvell_config_init(struct phy_device *phydev)
 {
+	/* Set defalut LED */
+	marvell_config_led(phydev);
+
 	/* Set registers from marvell,reg-init DT property */
 	return marvell_of_reg_init(phydev);
 }
@@ -813,21 +846,6 @@ static int m88e1111_config_init(struct p
 	return genphy_soft_reset(phydev);
 }
 
-static int m88e1121_config_init(struct phy_device *phydev)
-{
-	int err;
-
-	/* Default PHY LED config: LED[0] .. Link, LED[1] .. Activity */
-	err = phy_write_paged(phydev, MII_MARVELL_LED_PAGE,
-			      MII_88E1121_PHY_LED_CTRL,
-			      MII_88E1121_PHY_LED_DEF);
-	if (err < 0)
-		return err;
-
-	/* Set marvell,reg-init configuration from device tree */
-	return marvell_config_init(phydev);
-}
-
 static int m88e1318_config_init(struct phy_device *phydev)
 {
 	if (phy_interrupt_is_valid(phydev)) {
@@ -841,7 +859,7 @@ static int m88e1318_config_init(struct p
 			return err;
 	}
 
-	return m88e1121_config_init(phydev);
+	return marvell_config_init(phydev);
 }
 
 static int m88e1510_config_init(struct phy_device *phydev)
@@ -2090,7 +2108,7 @@ static struct phy_driver marvell_drivers
 		.features = PHY_GBIT_FEATURES,
 		.flags = PHY_HAS_INTERRUPT,
 		.probe = &m88e1121_probe,
-		.config_init = &m88e1121_config_init,
+		.config_init = &marvell_config_init,
 		.config_aneg = &m88e1121_config_aneg,
 		.read_status = &marvell_read_status,
 		.ack_interrupt = &marvell_ack_interrupt,
--- a/include/linux/marvell_phy.h
+++ b/include/linux/marvell_phy.h
@@ -27,6 +27,8 @@
  */
 #define MARVELL_PHY_ID_88E6390		0x01410f90
 
+#define MARVELL_PHY_FAMILY_ID(id)	((id) >> 4)
+
 /* struct phy_device dev_flags definitions */
 #define MARVELL_PHY_M1145_FLAGS_RESISTANCE	0x00000001
 #define MARVELL_PHY_M1118_DNS323_LEDS		0x00000002


