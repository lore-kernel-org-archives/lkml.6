Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94162C04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF1F20834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF1F20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeK2TLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 14:11:17 -0500
Received: from mx.socionext.com ([202.248.49.38]:4095 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbeK2TLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 14:11:16 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 29 Nov 2018 17:06:45 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 23488180BCB;
        Thu, 29 Nov 2018 17:06:45 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 29 Nov 2018 17:06:45 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id DCB0F1A03A2;
        Thu, 29 Nov 2018 17:06:44 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH net-next 1/3] net: ethernet: ave: Add suspend/resume support
Date:   Thu, 29 Nov 2018 17:06:31 +0900
Message-Id: <1543478793-13719-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543478793-13719-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1543478793-13719-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces suspend and resume functions to ave driver.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/net/ethernet/socionext/sni_ave.c | 44 ++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
index 6732f5c..64115b1 100644
--- a/drivers/net/ethernet/socionext/sni_ave.c
+++ b/drivers/net/ethernet/socionext/sni_ave.c
@@ -1734,6 +1734,49 @@ static int ave_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int ave_suspend(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct ave_private *priv = netdev_priv(ndev);
+	int ret = 0;
+
+	if (netif_running(ndev)) {
+		ret = ave_stop(ndev);
+		netif_device_detach(ndev);
+	}
+
+	return ret;
+}
+
+static int ave_resume(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct ave_private *priv = netdev_priv(ndev);
+	int ret = 0;
+
+	ave_global_reset(ndev);
+
+	if (ndev->phydev) {
+		ret = phy_resume(ndev->phydev);
+		if (ret)
+			return ret;
+	}
+
+	if (netif_running(ndev)) {
+		ret = ave_open(ndev);
+		netif_device_attach(ndev);
+	}
+
+	return ret;
+}
+
+static SIMPLE_DEV_PM_OPS(ave_pm_ops, ave_suspend, ave_resume);
+#define AVE_PM_OPS	(&ave_pm_ops)
+#else
+#define AVE_PM_OPS	NULL
+#endif
+
 static int ave_pro4_get_pinmode(struct ave_private *priv,
 				phy_interface_t phy_mode, u32 arg)
 {
@@ -1908,6 +1951,7 @@ static struct platform_driver ave_driver = {
 	.remove = ave_remove,
 	.driver	= {
 		.name = "ave",
+		.pm   = AVE_PM_OPS,
 		.of_match_table	= of_ave_match,
 	},
 };
-- 
2.7.4

