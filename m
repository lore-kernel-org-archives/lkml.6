Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86924C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F752081C
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F752081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395227AbeKVXxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 18:53:33 -0500
Received: from mail.bootlin.com ([62.4.15.54]:55537 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391278AbeKVXxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 18:53:32 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 02B5220DBE; Thu, 22 Nov 2018 14:14:14 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id B608B20741;
        Thu, 22 Nov 2018 14:14:03 +0100 (CET)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH net] net: phy: mscc: fix deadlock in vsc85xx_default_config
Date:   Thu, 22 Nov 2018 14:12:32 +0100
Message-Id: <20181122131232.32032-1-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vsc85xx_default_config function called in the vsc85xx_config_init
function which is used by VSC8530, VSC8531, VSC8540 and VSC8541 PHYs
mistakenly calls phy_read and phy_write in-between phy_select_page and
phy_restore_page.

phy_select_page and phy_restore_page actually take and release the MDIO
bus lock so __phy_write and __phy_read (which assume that you already
have the MDIO bus lock unlike phy_write and phy_read) should be used for
any call in between the two said functions.

Let's fix this deadlock.

Fixes: 6a0bfbbe20b0 ("net: phy: mscc: migrate to phy_select/restore_page functions")

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/net/phy/mscc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index 62269e578718..6856fe4d1a60 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -814,10 +814,10 @@ static int vsc85xx_default_config(struct phy_device *phydev)
 	if (rc < 0)
 		goto out_unlock;
 
-	reg_val = phy_read(phydev, MSCC_PHY_RGMII_CNTL);
+	reg_val = __phy_read(phydev, MSCC_PHY_RGMII_CNTL);
 	reg_val &= ~(RGMII_RX_CLK_DELAY_MASK);
 	reg_val |= (RGMII_RX_CLK_DELAY_1_1_NS << RGMII_RX_CLK_DELAY_POS);
-	phy_write(phydev, MSCC_PHY_RGMII_CNTL, reg_val);
+	__phy_write(phydev, MSCC_PHY_RGMII_CNTL, reg_val);
 
 out_unlock:
 	rc = phy_restore_page(phydev, rc, rc > 0 ? 0 : rc);
-- 
2.17.1

