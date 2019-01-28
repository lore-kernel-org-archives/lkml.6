Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31235C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B55120989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfA1NY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:24:28 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:38856 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726647AbfA1NY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 08:24:27 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D0AB047B67543F56BF28;
        Mon, 28 Jan 2019 21:24:24 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Mon, 28 Jan 2019
 21:24:15 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
        <hkallweit1@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] mdio_bus: Fix PTR_ERR() usage after initialization to constant
Date:   Mon, 28 Jan 2019 21:24:09 +0800
Message-ID: <20190128132409.17736-1-yuehaibing@huawei.com>
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
 drivers/net/phy/mdio_bus.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 3d31358..802716a 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -42,17 +42,20 @@
 static int mdiobus_register_gpiod(struct mdio_device *mdiodev)
 {
 	struct gpio_desc *gpiod = NULL;
+	int ret;
 
 	/* Deassert the optional reset signal */
 	if (mdiodev->dev.of_node)
 		gpiod = fwnode_get_named_gpiod(&mdiodev->dev.of_node->fwnode,
 					       "reset-gpios", 0, GPIOD_OUT_LOW,
 					       "PHY reset");
-	if (PTR_ERR(gpiod) == -ENOENT ||
-	    PTR_ERR(gpiod) == -ENOSYS)
-		gpiod = NULL;
-	else if (IS_ERR(gpiod))
-		return PTR_ERR(gpiod);
+	if (IS_ERR(gpiod)) {
+		ret = PTR_ERR(gpiod);
+		if (ret == -ENOENT || ret == -ENOSYS)
+			gpiod = NULL;
+		else
+			return ret;
+	}
 
 	mdiodev->reset = gpiod;
 
-- 
2.7.4


