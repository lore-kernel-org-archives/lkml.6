Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D67C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40222083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfBUQye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:54:34 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:58777 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfBUQye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:54:34 -0500
X-Originating-IP: 90.88.23.190
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 8F0102000F;
        Thu, 21 Feb 2019 16:54:29 +0000 (UTC)
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
        thomas.petazzoni@bootlin.com
Subject: [PATCH net] net: phy: marvell10g: Fix Multi-G advertisement to only advertise 10G
Date:   Thu, 21 Feb 2019 17:54:11 +0100
Message-Id: <20190221165411.9739-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Marvell Alaska PHYs support 2.5G, 5G and 10G BaseT links. Their
default behaviour is to advertise all of these modes, but at the moment,
only 10GBaseT is supported. To prevent link partners from establishing
link at that speed, clear these modes upon configuring aneg parameters.

Fixes: 20b2af32ff3f ("net: phy: add Marvell Alaska X 88X3310 10Gigabit PHY support")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reported-by: Russell King <linux@armlinux.org.uk>
---

Dave,

This patch will conflict when merging net into net-next, and is actually
not needed there. In net-next, this issue is fixed by the recent work
done by Andrew and Heiner, that introduce more generic ways to handle aneg
configuration for C45 PHYs.

The commit fixing this would be :
3de97f3c6308 ("net: phy: marvell10g: use genphy_c45_an_config_aneg")

However this fix should be backported, hence why it was implemented in a
small standalone patch here.

Please tell me if you have any issue with this.

Thanks,

Maxime

 drivers/net/phy/marvell10g.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 82ab6ed3b74e..6bac602094bd 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -26,6 +26,8 @@
 #include <linux/marvell_phy.h>
 #include <linux/phy.h>
 
+#define MDIO_AN_10GBT_CTRL_ADV_NBT_MASK	0x01e0
+
 enum {
 	MV_PCS_BASE_T		= 0x0000,
 	MV_PCS_BASE_R		= 0x1000,
@@ -386,8 +388,10 @@ static int mv3310_config_aneg(struct phy_device *phydev)
 	else
 		reg = 0;
 
+	/* Make sure we clear unsupported 2.5G/5G advertising */
 	ret = mv3310_modify(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
-			    MDIO_AN_10GBT_CTRL_ADV10G, reg);
+			    MDIO_AN_10GBT_CTRL_ADV10G |
+			    MDIO_AN_10GBT_CTRL_ADV_NBT_MASK, reg);
 	if (ret < 0)
 		return ret;
 	if (ret > 0)
-- 
2.19.2

