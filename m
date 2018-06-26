Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B77FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D4BA26D46
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4BA26D46
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rockwellcollins.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754756AbeFZRvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:51:19 -0400
Received: from secvs02.rockwellcollins.com ([205.175.225.241]:21409 "EHLO
        secvs02.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754714AbeFZRvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:51:16 -0400
Received: from ofwgwc03.rockwellcollins.com (HELO ciulimr02.rockwellcollins.com) ([205.175.225.12])
  by secvs02.rockwellcollins.com with ESMTP; 26 Jun 2018 12:51:15 -0500
X-Received: from righttwix.rockwellcollins.com (righttwix.rockwellcollins.com [192.168.141.218])
        by ciulimr02.rockwellcollins.com (Postfix) with ESMTP id 9B16D2007E;
        Tue, 26 Jun 2018 12:51:15 -0500 (CDT)
From:   Brandon Maier <brandon.maier@rockwellcollins.com>
To:     netdev@vger.kernel.org
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
        michal.simek@xilinx.com, clayton.shotwell@rockwellcollins.com,
        kristopher.cory@rockwellcollins.com, linux-kernel@vger.kernel.org,
        Brandon Maier <brandon.maier@rockwellcollins.com>
Subject: [PATCH net-next v2 3/3] net: phy: xgmiitorgmii: Check read_status results
Date:   Tue, 26 Jun 2018 12:50:50 -0500
Message-Id: <20180626175050.71165-3-brandon.maier@rockwellcollins.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626175050.71165-1-brandon.maier@rockwellcollins.com>
References: <20180626175050.71165-1-brandon.maier@rockwellcollins.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're ignoring the result of the attached phy device's read_status().
Return it so we can detect errors.

Signed-off-by: Brandon Maier <brandon.maier@rockwellcollins.com>
---
v2:
- No change

v1: https://marc.info/?l=linux-netdev&m=152838766410559&w=2

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
2.17.1

