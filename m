Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9CAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C567208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C567208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbeK2TLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 14:11:19 -0500
Received: from mx.socionext.com ([202.248.49.38]:4094 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbeK2TLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 14:11:18 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 29 Nov 2018 17:06:47 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 5C01060062;
        Thu, 29 Nov 2018 17:06:47 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 29 Nov 2018 17:06:47 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id BD2511A03A2;
        Thu, 29 Nov 2018 17:06:46 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH net-next 3/3] net: ethernet: ave: Preserve wol state in suspend/resume sequence
Date:   Thu, 29 Nov 2018 17:06:33 +0900
Message-Id: <1543478793-13719-4-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543478793-13719-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1543478793-13719-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the wol state forces to be initialized after reset, the state should
be preserved in suspend/resume sequence.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/net/ethernet/socionext/sni_ave.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
index ac96fb9..8c1e120 100644
--- a/drivers/net/ethernet/socionext/sni_ave.c
+++ b/drivers/net/ethernet/socionext/sni_ave.c
@@ -261,6 +261,7 @@ struct ave_private {
 	struct regmap		*regmap;
 	unsigned int		pinmode_mask;
 	unsigned int		pinmode_val;
+	u32			wolopts;
 
 	/* stats */
 	struct ave_stats	stats_rx;
@@ -1741,6 +1742,7 @@ static int ave_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int ave_suspend(struct device *dev)
 {
+	struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct ave_private *priv = netdev_priv(ndev);
 	int ret = 0;
@@ -1750,17 +1752,25 @@ static int ave_suspend(struct device *dev)
 		netif_device_detach(ndev);
 	}
 
+	ave_ethtool_get_wol(ndev, &wol);
+	priv->wolopts = wol.wolopts;
+
 	return ret;
 }
 
 static int ave_resume(struct device *dev)
 {
+	struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct ave_private *priv = netdev_priv(ndev);
 	int ret = 0;
 
 	ave_global_reset(ndev);
 
+	ave_ethtool_get_wol(ndev, &wol);
+	wol.wolopts = priv->wolopts;
+	ave_ethtool_set_wol(ndev, &wol);
+
 	if (ndev->phydev) {
 		ret = phy_resume(ndev->phydev);
 		if (ret)
-- 
2.7.4

