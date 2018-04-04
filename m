Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753117AbeDDDHU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 23:07:20 -0400
Received: from m12-17.163.com ([220.181.12.17]:58603 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751850AbeDDDHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 23:07:19 -0400
From: Xidong Wang <wangxidong_97@163.com>
To: Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>
Cc: Xidong Wang <wangxidong_97@163.com>, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] mtd:nand:fix memory leak
Date: Wed,  4 Apr 2018 11:05:51 +0800
Message-Id: <1522811151-18853-1-git-send-email-wangxidong_97@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: EcCowADn90sVQcRa4Ik6CA--.51098S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF13KrWDZrW8XF4rGrWUXFb_yoWDuFb_Ww
        4S9ryxtry29a4j9ry7KF4fJry2kF4IgrWrWw1Fqw4fta48JF1xt3ZrZrnxuw48uF4FgrW5
        A3y5Ar1fAw43XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5VxR3UUUUU==
X-Originating-IP: [106.120.213.14]
X-CM-SenderInfo: pzdqw5xlgr0wrbzxqiywtou0bp/1tbiPRse81SIWJ-JewAAsi
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function tango_nand_probe(), the memory allocated by
clk_get() is not released on the normal path and
the error path that IS_ERR(nfc->chan) returns true.
This will result in a memory leak bug.

Signed-off-by: Xidong Wang <wangxidong_97@163.com>
---
 drivers/mtd/nand/tango_nand.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/tango_nand.c b/drivers/mtd/nand/tango_nand.c
index c5bee00b..8083459 100644
--- a/drivers/mtd/nand/tango_nand.c
+++ b/drivers/mtd/nand/tango_nand.c
@@ -648,12 +648,15 @@ static int tango_nand_probe(struct platform_device *pdev)
 		return PTR_ERR(clk);
 
 	nfc->chan = dma_request_chan(&pdev->dev, "rxtx");
-	if (IS_ERR(nfc->chan))
+	if (IS_ERR(nfc->chan)) {
+		clk_put(clk);
 		return PTR_ERR(nfc->chan);
+	}
 
 	platform_set_drvdata(pdev, nfc);
 	nand_hw_control_init(&nfc->hw);
 	nfc->freq_kHz = clk_get_rate(clk) / 1000;
+	clk_put(clk);
 
 	for_each_child_of_node(pdev->dev.of_node, np) {
 		err = chip_init(&pdev->dev, np);
-- 
2.7.4
