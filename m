Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8E4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260A0217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeLRH5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:57:35 -0500
Received: from mx.socionext.com ([202.248.49.38]:4468 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbeLRH5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 02:57:32 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 18 Dec 2018 16:57:29 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 1B796180097;
        Tue, 18 Dec 2018 16:57:30 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 18 Dec 2018 16:57:30 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 686BD1A1235;
        Tue, 18 Dec 2018 16:57:29 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH net] net: phy: Fix the issue that netif always links up after resuming
Date:   Tue, 18 Dec 2018 16:57:04 +0900
Message-Id: <1545119824-30380-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though the link is down before entering hibernation,
there is an issue that the network interface always links up after resuming
from hibernation.

If the link is still down before enabling the network interface,
and after resuming from hibernation, the phydev->state is forcibly set
to PHY_UP in mdio_bus_phy_restore(), and the link becomes up.

In suspend sequence, only if the PHY is attached, mdio_bus_phy_suspend()
calls phy_stop_machine(), and mdio_bus_phy_resume() calls
phy_start_machine().
In resume sequence, it's enough to do the same as mdio_bus_phy_resume()
because the state has been preserved.

This patch fixes the issue by calling phy_start_machine() in
mdio_bus_phy_restore() in the same way as mdio_bus_phy_resume().

Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/net/phy/phy_device.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

This patch is based on the RFC patch discussion [1].
[1] https://www.spinics.net/lists/netdev/msg537326.html

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 7d5d698..3685be4 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -315,11 +315,8 @@ static int mdio_bus_phy_restore(struct device *dev)
 	if (ret < 0)
 		return ret;
 
-	/* The PHY needs to renegotiate. */
-	phydev->link = 0;
-	phydev->state = PHY_UP;
-
-	phy_start_machine(phydev);
+	if (phydev->attached_dev && phydev->adjust_link)
+		phy_start_machine(phydev);
 
 	return 0;
 }
-- 
2.7.4

