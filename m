Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 5wj6OP1XGVvzfQAAmS7hNA
	; Thu, 07 Jun 2018 16:06:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D519C6089E; Thu,  7 Jun 2018 16:06:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4294360590;
	Thu,  7 Jun 2018 16:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4294360590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=rockwellcollins.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935168AbeFGQGS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:06:18 -0400
Received: from ch3vs01.rockwellcollins.com ([205.175.226.27]:22530 "EHLO
        ch3vs01.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933058AbeFGQGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:06:16 -0400
X-Greylist: delayed 567 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Jun 2018 12:06:15 EDT
Received: from ofwch3n02.rockwellcollins.com (HELO ciulimr02.rockwellcollins.com) ([205.175.226.14])
  by ch3vs01.rockwellcollins.com with ESMTP; 07 Jun 2018 10:56:48 -0500
X-Received: from righttwix.rockwellcollins.com (righttwix.rockwellcollins.com [192.168.141.218])
        by ciulimr02.rockwellcollins.com (Postfix) with ESMTP id 242EE20094;
        Thu,  7 Jun 2018 10:56:48 -0500 (CDT)
From: Brandon Maier <brandon.maier@rockwellcollins.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
        michal.simek@xilinx.com, clayton.shotwell@rockwellcollins.com,
        kristopher.cory@rockwellcollins.com, linux-kernel@vger.kernel.org,
        Brandon Maier <brandon.maier@rockwellcollins.com>
Subject: [PATCH 3/3] net: phy: xgmiitorgmii: Check read_status results
Date: Thu,  7 Jun 2018 10:53:48 -0500
Message-Id: <20180607155348.149665-3-brandon.maier@rockwellcollins.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180607155348.149665-1-brandon.maier@rockwellcollins.com>
References: <20180607155348.149665-1-brandon.maier@rockwellcollins.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're ignoring the result of the attached phy device's read_status().
Return it so we can detect errors.

Signed-off-by: Brandon Maier <brandon.maier@rockwellcollins.com>
---
 drivers/net/phy/xilinx_gmii2rgmii.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
index d6f8b64cddbe..74a8782313cf 100644
--- a/drivers/net/phy/xilinx_gmii2rgmii.c
+++ b/drivers/net/phy/xilinx_gmii2rgmii.c
@@ -42,8 +42,11 @@ static int xgmiitorgmii_read_status(struct phy_device *phydev)
 	struct mii_bus *bus = priv->mdio->bus;
 	int addr = priv->mdio->addr;
 	u16 val = 0;
+	int err;
 
-	priv->phy_drv->read_status(phydev);
+	err = priv->phy_drv->read_status(phydev);
+	if (err < 0)
+		return err;
 
 	val = mdiobus_read(bus, addr, XILINX_GMII2RGMII_REG);
 	val &= ~XILINX_GMII2RGMII_SPEED_MASK;
-- 
2.14.3
