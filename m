Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25344C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 05:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC38206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 05:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC38206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeI2LvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 07:51:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51446 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726325AbeI2LvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 07:51:21 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3B148ED05953D;
        Sat, 29 Sep 2018 13:24:17 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Sat, 29 Sep 2018 13:24:13 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>
CC:     <f.fainelli@gmail.com>, <andrew@lunn.ch>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] net: phy: Fix a unused function gcc warning.
Date:   Sat, 29 Sep 2018 13:11:43 +0800
Message-ID: <1538197903-37168-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following compile warning:

drivers/net/phy/mdio-bcm-unimac.c:321:12: warning: 'unimac_mdio_suspend' defined but not used [-Wunused-function]
 static int unimac_mdio_suspend(struct device *d)
            ^
drivers/net/phy/mdio-bcm-unimac.c:330:12: warning: 'unimac_mdio_resume' defined but not used [-Wunused-function]
 static int unimac_mdio_resume(struct device *d)

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/net/phy/mdio-bcm-unimac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/mdio-bcm-unimac.c b/drivers/net/phy/mdio-bcm-unimac.c
index 80b9583..f5b83ea 100644
--- a/drivers/net/phy/mdio-bcm-unimac.c
+++ b/drivers/net/phy/mdio-bcm-unimac.c
@@ -318,6 +318,7 @@ static int unimac_mdio_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
 static int unimac_mdio_suspend(struct device *d)
 {
 	struct unimac_mdio_priv *priv = dev_get_drvdata(d);
@@ -343,6 +344,7 @@ static int unimac_mdio_resume(struct device *d)
 
 static SIMPLE_DEV_PM_OPS(unimac_mdio_pm_ops,
 			 unimac_mdio_suspend, unimac_mdio_resume);
+#endif /* CONFIG_PM_SLEEP */
 
 static const struct of_device_id unimac_mdio_ids[] = {
 	{ .compatible = "brcm,genet-mdio-v5", },
@@ -359,7 +361,9 @@ static SIMPLE_DEV_PM_OPS(unimac_mdio_pm_ops,
 	.driver = {
 		.name = UNIMAC_MDIO_DRV_NAME,
 		.of_match_table = unimac_mdio_ids,
+#ifdef CONFIG_PM_SLEEP
 		.pm = &unimac_mdio_pm_ops,
+#endif
 	},
 	.probe	= unimac_mdio_probe,
 	.remove	= unimac_mdio_remove,
-- 
1.7.12.4

