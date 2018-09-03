Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABADC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192BB2077B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192BB2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbeICNJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 09:09:08 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53345 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbeICNIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 09:08:30 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9E07D20DEA; Mon,  3 Sep 2018 10:49:21 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 575ED215E6;
        Mon,  3 Sep 2018 10:49:11 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        andrew@lunn.ch, f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH net-next v2 3/7] net: phy: mscc: read 'vsc8531,vddmac' as an u32
Date:   Mon,  3 Sep 2018 10:48:49 +0200
Message-Id: <20180903084853.18092-3-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180903084853.18092-1-quentin.schulz@bootlin.com>
References: <20180903084853.18092-1-quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the DT binding, it is specified nowhere that 'vsc8531,vddmac' is an
u16, even though it's read as an u16 in the driver.

Let's update the driver to take into consideration that the
'vsc8531,vddmac' property is of the default type u32.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---

added in v2

 drivers/net/phy/mscc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index aa37e8547cd0..49dc23117732 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -128,7 +128,7 @@ struct vsc8531_private {
 
 #ifdef CONFIG_OF_MDIO
 struct vsc8531_edge_rate_table {
-	u16 vddmac;
+	u32 vddmac;
 	u8 slowdown[8];
 };
 
@@ -387,7 +387,7 @@ static void vsc85xx_wol_get(struct phy_device *phydev,
 static int vsc85xx_edge_rate_magic_get(struct phy_device *phydev)
 {
 	u8 sd;
-	u16 vdd;
+	u32 vdd;
 	int rc, i, j;
 	struct device *dev = &phydev->mdio.dev;
 	struct device_node *of_node = dev->of_node;
@@ -396,7 +396,7 @@ static int vsc85xx_edge_rate_magic_get(struct phy_device *phydev)
 	if (!of_node)
 		return -ENODEV;
 
-	rc = of_property_read_u16(of_node, "vsc8531,vddmac", &vdd);
+	rc = of_property_read_u32(of_node, "vsc8531,vddmac", &vdd);
 	if (rc != 0)
 		vdd = MSCC_VDDMAC_3300;
 
-- 
2.17.1

