Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753088AbeDPCdB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 22:33:01 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:7448 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751774AbeDPCdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 22:33:00 -0400
X-UUID: 67316a4ddc064d1bb3612b02b363bce5-20180416
From: Ryder Lee <ryder.lee@mediatek.com>
To: Wolfram Sang <wsa@the-dreams.de>
CC: Jun Gao <jun.gao@mediatek.com>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] i2c: mediatek: use of_device_get_match_data()
Date: Mon, 16 Apr 2018 10:32:52 +0800
Message-ID: <31f944ab8dfcc1d7b6f03b35657a2a34825b5246.1523347340.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usage of of_device_get_match_data() reduce the code size a bit.

Also, the only way to call mtk_i2c_probe() is to match an entry in
mtk_i2c_of_match[], so of_id cannot be NULL.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/i2c/busses/i2c-mt65xx.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index cf23a74..1e57f58 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -27,6 +27,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/scatterlist.h>
@@ -734,7 +735,6 @@ static int mtk_i2c_parse_dt(struct device_node *np, struct mtk_i2c *i2c)
 
 static int mtk_i2c_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id;
 	int ret = 0;
 	struct mtk_i2c *i2c;
 	struct clk *clk;
@@ -761,11 +761,7 @@ static int mtk_i2c_probe(struct platform_device *pdev)
 
 	init_completion(&i2c->msg_complete);
 
-	of_id = of_match_node(mtk_i2c_of_match, pdev->dev.of_node);
-	if (!of_id)
-		return -EINVAL;
-
-	i2c->dev_comp = of_id->data;
+	i2c->dev_comp = of_device_get_match_data(&pdev->dev);
 	i2c->adap.dev.of_node = pdev->dev.of_node;
 	i2c->dev = &pdev->dev;
 	i2c->adap.dev.parent = &pdev->dev;
-- 
1.9.1
