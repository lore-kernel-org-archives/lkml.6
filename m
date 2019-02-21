Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91F7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90EC320880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfBUJv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:51:57 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:56669 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfBUJvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:51:54 -0500
X-Originating-IP: 90.88.23.190
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 10512C000A;
        Thu, 21 Feb 2019 09:51:50 +0000 (UTC)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 7/7] net: phy: marvell10g: add support for the 88x2110 PHY
Date:   Thu, 21 Feb 2019 10:51:28 +0100
Message-Id: <20190221095128.28188-8-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190221095128.28188-1-maxime.chevallier@bootlin.com>
References: <20190221095128.28188-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the 88x2110 PHY, which is similar to the
already supported 88x3310 PHY without the SFP interface.

It supports 10/100/1000BASET along with 2.5GBASET, 5GBASET and 10GBASET,
with the same interface modes that are used by the 3310.

This PHY don't have the same issue as the 88x3310 regarding 2.5/5G
abilities, and correctly follows the 802.3bz standard to list the
supported abilities.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Suggested-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/phy/marvell10g.c | 13 +++++++++++++
 include/linux/marvell_phy.h  |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index c48669d50653..bac199b7540f 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -490,12 +490,25 @@ static struct phy_driver mv3310_drivers[] = {
 		.aneg_done	= mv3310_aneg_done,
 		.read_status	= mv3310_read_status,
 	},
+	{
+		.phy_id		= MARVELL_PHY_ID_88E2110,
+		.phy_id_mask	= MARVELL_PHY_ID_MASK,
+		.name		= "mv88x2110",
+		.features	= PHY_10GBIT_FEATURES,
+		.probe		= mv3310_probe,
+		.soft_reset	= gen10g_no_soft_reset,
+		.config_init	= mv3310_config_init,
+		.config_aneg	= mv3310_config_aneg,
+		.aneg_done	= mv3310_aneg_done,
+		.read_status	= mv3310_read_status,
+	},
 };
 
 module_phy_driver(mv3310_drivers);
 
 static struct mdio_device_id __maybe_unused mv3310_tbl[] = {
 	{ MARVELL_PHY_ID_88X3310, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88E2110, MARVELL_PHY_ID_MASK },
 	{ },
 };
 MODULE_DEVICE_TABLE(mdio, mv3310_tbl);
diff --git a/include/linux/marvell_phy.h b/include/linux/marvell_phy.h
index 70c17345e118..73d04743a2bb 100644
--- a/include/linux/marvell_phy.h
+++ b/include/linux/marvell_phy.h
@@ -21,6 +21,7 @@
 #define MARVELL_PHY_ID_88E1545		0x01410ea0
 #define MARVELL_PHY_ID_88E3016		0x01410e60
 #define MARVELL_PHY_ID_88X3310		0x002b09a0
+#define MARVELL_PHY_ID_88E2110		0x002b09b0
 
 /* The MV88e6390 Ethernet switch contains embedded PHYs. These PHYs do
  * not have a model ID. So the switch driver traps reads to the ID2
-- 
2.19.2

