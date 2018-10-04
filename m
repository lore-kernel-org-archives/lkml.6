Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AA5C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8442F20684
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8442F20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbeJDToV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:44:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37538 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727279AbeJDToU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:44:20 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0A742207B4; Thu,  4 Oct 2018 14:51:09 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id E0FAA208B5;
        Thu,  4 Oct 2018 14:50:49 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH net-next v2 6/6] net: phy: mscc: remove unneeded temporary variable
Date:   Thu,  4 Oct 2018 14:47:28 +0200
Message-Id: <20181004124728.9821-7-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004124728.9821-1-quentin.schulz@bootlin.com>
References: <20181004124728.9821-1-quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here, the rc variable is either used only for the condition right after
the assignment or right before being used as the return value of the
function it's being used in.

So let's remove this unneeded temporary variable whenever possible.

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/net/phy/mscc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index 720d8dc81410..9c7159e1ae17 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -514,7 +514,7 @@ static void vsc85xx_wol_get(struct phy_device *phydev,
 static int vsc85xx_edge_rate_magic_get(struct phy_device *phydev)
 {
 	u32 vdd, sd;
-	int rc, i, j;
+	int i, j;
 	struct device *dev = &phydev->mdio.dev;
 	struct device_node *of_node = dev->of_node;
 	u8 sd_array_size = ARRAY_SIZE(edge_table[0].slowdown);
@@ -522,12 +522,10 @@ static int vsc85xx_edge_rate_magic_get(struct phy_device *phydev)
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
@@ -781,9 +779,7 @@ static int vsc85xx_config_init(struct phy_device *phydev)
 			return rc;
 	}
 
-	rc = genphy_config_init(phydev);
-
-	return rc;
+	return genphy_config_init(phydev);
 }
 
 static int vsc85xx_ack_interrupt(struct phy_device *phydev)
-- 
2.17.1

