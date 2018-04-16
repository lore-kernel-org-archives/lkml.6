Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753213AbeDPCeD (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 22:34:03 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:3490 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752965AbeDPCeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 22:34:01 -0400
X-UUID: 527ab7cc19f846d196a829430d856b46-20180416
From: Ryder Lee <ryder.lee@mediatek.com>
To: Boris Brezillon <boris.brezillon@free-electrons.com>
CC: Xiaolei Li <xiaolei.li@mediatek.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mtd: nand: mtk: use of_device_get_match_data()
Date: Mon, 16 Apr 2018 10:33:54 +0800
Message-ID: <c3af6d5035e43b53b5cc7ee68f9f1a853ce2a8f9.1523347340.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <31f944ab8dfcc1d7b6f03b35657a2a34825b5246.1523347340.git.ryder.lee@mediatek.com>
References: <31f944ab8dfcc1d7b6f03b35657a2a34825b5246.1523347340.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usage of of_device_get_match_data() reduce the code size a bit.

Also, the only way to call .probe() is to match an entry in
.of_match_table[], so of_device_id cannot be NULL.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/mtd/nand/raw/mtk_ecc.c  |  7 +------
 drivers/mtd/nand/raw/mtk_nand.c | 10 +---------
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/nand/mtk_ecc.c b/drivers/mtd/nand/mtk_ecc.c
index 40d86a8..6432bd7 100644
--- a/drivers/mtd/nand/raw/mtk_ecc.c
+++ b/drivers/mtd/nand/raw/mtk_ecc.c
@@ -500,7 +500,6 @@ static int mtk_ecc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct mtk_ecc *ecc;
 	struct resource *res;
-	const struct of_device_id *of_ecc_id = NULL;
 	u32 max_eccdata_size;
 	int irq, ret;
 
@@ -508,11 +507,7 @@ static int mtk_ecc_probe(struct platform_device *pdev)
 	if (!ecc)
 		return -ENOMEM;
 
-	of_ecc_id = of_match_device(mtk_ecc_dt_match, &pdev->dev);
-	if (!of_ecc_id)
-		return -ENODEV;
-
-	ecc->caps = of_ecc_id->data;
+	ecc->caps = of_device_get_match_data(dev);
 
 	max_eccdata_size = ecc->caps->num_ecc_strength - 1;
 	max_eccdata_size = ecc->caps->ecc_strength[max_eccdata_size];
diff --git a/drivers/mtd/nand/mtk_nand.c b/drivers/mtd/nand/mtk_nand.c
index 6977da3..75c845a 100644
--- a/drivers/mtd/nand/raw/mtk_nand.c
+++ b/drivers/mtd/nand/raw/mtk_nand.c
@@ -1434,7 +1434,6 @@ static int mtk_nfc_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct mtk_nfc *nfc;
 	struct resource *res;
-	const struct of_device_id *of_nfc_id = NULL;
 	int ret, irq;
 
 	nfc = devm_kzalloc(dev, sizeof(*nfc), GFP_KERNEL);
@@ -1452,6 +1451,7 @@ static int mtk_nfc_probe(struct platform_device *pdev)
 	else if (!nfc->ecc)
 		return -ENODEV;
 
+	nfc->caps = of_device_get_match_data(dev);
 	nfc->dev = dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1498,14 +1498,6 @@ static int mtk_nfc_probe(struct platform_device *pdev)
 		goto clk_disable;
 	}
 
-	of_nfc_id = of_match_device(mtk_nfc_id_table, &pdev->dev);
-	if (!of_nfc_id) {
-		ret = -ENODEV;
-		goto clk_disable;
-	}
-
-	nfc->caps = of_nfc_id->data;
-
 	platform_set_drvdata(pdev, nfc);
 
 	ret = mtk_nfc_nand_chips_init(dev, nfc);
-- 
1.9.1
