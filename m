Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753171AbeDPCdu (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 22:33:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41359 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753139AbeDPCdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 22:33:49 -0400
X-UUID: a1ccc2918fb74be6845bdddde40af7c1-20180416
From: Ryder Lee <ryder.lee@mediatek.com>
To: "David S. Miller" <davem@davemloft.net>
CC: Sean Wang <sean.wang@mediatek.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] net: mediatek: use of_device_get_match_data()
Date: Mon, 16 Apr 2018 10:33:41 +0800
Message-ID: <9bf87205f84062580934168774d690d4cd2bf26b.1523347340.git.ryder.lee@mediatek.com>
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

Also, the only way to call mtk_probe() is to match an entry in
of_mtk_match[], so match cannot be NULL.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index e0b72bf..d8ebf0a 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2503,7 +2503,6 @@ static int mtk_probe(struct platform_device *pdev)
 {
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct device_node *mac_np;
-	const struct of_device_id *match;
 	struct mtk_eth *eth;
 	int err;
 	int i;
@@ -2512,8 +2511,7 @@ static int mtk_probe(struct platform_device *pdev)
 	if (!eth)
 		return -ENOMEM;
 
-	match = of_match_device(of_mtk_match, &pdev->dev);
-	eth->soc = (struct mtk_soc_data *)match->data;
+	eth->soc = of_device_get_match_data(&pdev->dev);
 
 	eth->dev = &pdev->dev;
 	eth->base = devm_ioremap_resource(&pdev->dev, res);
-- 
1.9.1
