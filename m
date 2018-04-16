Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753128AbeDPCdN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 22:33:13 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:12487 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753099AbeDPCdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 22:33:12 -0400
X-UUID: a0a4f853752742158f1bcb187882d0da-20180416
From: Ryder Lee <ryder.lee@mediatek.com>
To: Mark Brown <broonie@kernel.org>
CC: Leilk Liu <leilk.liu@mediatek.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] spi: mediatek: Use of_device_get_match_data()
Date: Mon, 16 Apr 2018 10:33:00 +0800
Message-ID: <94cba80f703be048666afde1ed53c15c3704c533.1523347340.git.ryder.lee@mediatek.com>
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

Also, the only way to call mtk_spi_probe() is to match an entry in
mtk_spi_of_match[], so of_id cannot be NULL.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 86bf456..3edc183 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -20,6 +20,7 @@
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/spi-mt65xx.h>
@@ -578,7 +579,6 @@ static int mtk_spi_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
 	struct mtk_spi *mdata;
-	const struct of_device_id *of_id;
 	struct resource *res;
 	int i, irq, ret;
 
@@ -598,15 +598,9 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	master->can_dma = mtk_spi_can_dma;
 	master->setup = mtk_spi_setup;
 
-	of_id = of_match_node(mtk_spi_of_match, pdev->dev.of_node);
-	if (!of_id) {
-		dev_err(&pdev->dev, "failed to probe of_node\n");
-		ret = -EINVAL;
-		goto err_put_master;
-	}
-
 	mdata = spi_master_get_devdata(master);
-	mdata->dev_comp = of_id->data;
+	mdata->dev_comp = of_device_get_match_data(&pdev->dev);
+
 	if (mdata->dev_comp->must_tx)
 		master->flags = SPI_MASTER_MUST_TX;
 
-- 
1.9.1
