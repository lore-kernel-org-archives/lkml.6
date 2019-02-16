Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA13C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 03:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8686C222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 03:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393455AbfBPDCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 22:02:06 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:43464 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727509AbfBPDCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 22:02:05 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4B64AD884B34000831E2;
        Sat, 16 Feb 2019 11:02:01 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Sat, 16 Feb 2019
 11:01:52 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
        <hkallweit1@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 net-next] mdio_bus: Fix PTR_ERR() usage after initialization to constant
Date:   Sat, 16 Feb 2019 10:59:35 +0800
Message-ID: <20190216025935.22888-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix coccinelle warning:

./drivers/net/phy/mdio_bus.c:51:5-12: ERROR: PTR_ERR applied after initialization to constant on line 44
./drivers/net/phy/mdio_bus.c:52:5-12: ERROR: PTR_ERR applied after initialization to constant on line 44

fix this by using IS_ERR before PTR_ERR

Fixes: bafbdd527d56 ("phylib: Add device reset GPIO support")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: remove variable 'ret'
---
 drivers/net/phy/mdio_bus.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 3d31358..debc74c 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -48,11 +48,12 @@ static int mdiobus_register_gpiod(struct mdio_device *mdiodev)
 		gpiod = fwnode_get_named_gpiod(&mdiodev->dev.of_node->fwnode,
 					       "reset-gpios", 0, GPIOD_OUT_LOW,
 					       "PHY reset");
-	if (PTR_ERR(gpiod) == -ENOENT ||
-	    PTR_ERR(gpiod) == -ENOSYS)
-		gpiod = NULL;
-	else if (IS_ERR(gpiod))
-		return PTR_ERR(gpiod);
+	if (IS_ERR(gpiod)) {
+		if (PTR_ERR(gpiod) == -ENOENT || PTR_ERR(gpiod) == -ENOSYS)
+			gpiod = NULL;
+		else
+			return PTR_ERR(gpiod);
+	}
 
 	mdiodev->reset = gpiod;
 
-- 
2.7.4


