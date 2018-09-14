Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED87C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB7620882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB7620882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbeINNrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:47:31 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34148 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbeINNra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:47:30 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E3050208ED; Fri, 14 Sep 2018 10:34:02 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id A795D207D4;
        Fri, 14 Sep 2018 10:34:02 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH net-next 5/5] net: phy: mscc: remove unneeded temporary variable
Date:   Fri, 14 Sep 2018 10:33:47 +0200
Message-Id: <d9cca8eef36bb8918c9ed28574b79b7674fd36f6.1536913944.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
References: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
In-Reply-To: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
References: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here, the rc variable is either used only for the condition right after
the assignment or right before being used as the return value of the
function it's being used in.

So let's remove this unneeded temporary variable whenever possible.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/net/phy/mscc.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index efa9352..24f4754 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -199,10 +199,7 @@ static const struct vsc8531_edge_rate_table edge_table[] = {
 
 static int vsc85xx_phy_page_set(struct phy_device *phydev, u16 page)
 {
-	int rc;
-
-	rc = phy_write(phydev, MSCC_EXT_PAGE_ACCESS, page);
-	return rc;
+	return phy_write(phydev, MSCC_EXT_PAGE_ACCESS, page);
 }
 
 static int vsc85xx_get_sset_count(struct phy_device *phydev)
@@ -504,7 +501,7 @@ static void vsc85xx_wol_get(struct phy_device *phydev,
 static int vsc85xx_edge_rate_magic_get(struct phy_device *phydev)
 {
 	u32 vdd, sd;
-	int rc, i, j;
+	int i, j;
 	struct device *dev = &phydev->mdio.dev;
 	struct device_node *of_node = dev->of_node;
 	u8 sd_array_size = ARRAY_SIZE(edge_table[0].slowdown);
@@ -512,12 +509,10 @@ static int vsc85xx_edge_rate_magic_get(struct phy_device *phydev)
 	if (!of_node)
 		return -ENODEV;
 
-	rc = of_property_read_u32(of_node, "vsc8531,vddmac", &vdd);
-	if (rc != 0)
+	if (of_property_read_u32(of_node, "vsc8531,vddmac", &vdd))
 		vdd = MSCC_VDDMAC_3300;
 
-	rc = of_property_read_u32(of_node, "vsc8531,edge-slowdown", &sd);
-	if (rc != 0)
+	if (of_property_read_u32(of_node, "vsc8531,edge-slowdown", &sd))
 		sd = 0;
 
 	for (i = 0; i < ARRAY_SIZE(edge_table); i++)
@@ -762,9 +757,7 @@ static int vsc85xx_config_init(struct phy_device *phydev)
 			return rc;
 	}
 
-	rc = genphy_config_init(phydev);
-
-	return rc;
+	return genphy_config_init(phydev);
 }
 
 static int vsc85xx_ack_interrupt(struct phy_device *phydev)
-- 
git-series 0.9.1
