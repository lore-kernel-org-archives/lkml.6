Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E56C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C433E21104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C433E21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbeK2TLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 14:11:18 -0500
Received: from mx.socionext.com ([202.248.49.38]:4099 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbeK2TLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 14:11:17 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 29 Nov 2018 17:06:46 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 2B3C3180BCB;
        Thu, 29 Nov 2018 17:06:46 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 29 Nov 2018 17:06:46 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id C6D111A03A2;
        Thu, 29 Nov 2018 17:06:45 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH net-next 2/3] net: ethernet: ave: Set initial wol state to disabled
Date:   Thu, 29 Nov 2018 17:06:32 +0900
Message-Id: <1543478793-13719-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543478793-13719-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1543478793-13719-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If wol state of phy hardware is enabled after reset, phy_ethtool_get_wol()
returns that wol.wolopts is true.

However, since net_device.wol_enabled is zero and this doesn't apply wol
state until calling ethtool_set_wol(), so mdio_bus_phy_may_suspend()
returns true, that is, it's in a state where phy can suspend even though
wol state is enabled.

In this inconsistency, phy_suspend() returns -EBUSY, and at last,
suspend sequence fails with the following message:

    dpm_run_callback(): mdio_bus_phy_suspend+0x0/0x58 returns -16
    PM: Device 65000000.ethernet-ffffffff:01 failed to suspend: error -16
    PM: Some devices failed to suspend, or early wake event detected

In order to fix the above issue, this patch forces to set initial wol state
to disabled as default.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/net/ethernet/socionext/sni_ave.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
index 64115b1..ac96fb9 100644
--- a/drivers/net/ethernet/socionext/sni_ave.c
+++ b/drivers/net/ethernet/socionext/sni_ave.c
@@ -1208,9 +1208,13 @@ static int ave_init(struct net_device *ndev)
 
 	priv->phydev = phydev;
 
-	phy_ethtool_get_wol(phydev, &wol);
+	ave_ethtool_get_wol(ndev, &wol);
 	device_set_wakeup_capable(&ndev->dev, !!wol.supported);
 
+	/* set wol initial state disabled */
+	wol.wolopts = 0;
+	ave_ethtool_set_wol(ndev, &wol);
+
 	if (!phy_interface_is_rgmii(phydev))
 		phy_set_max_speed(phydev, SPEED_100);
 
-- 
2.7.4

