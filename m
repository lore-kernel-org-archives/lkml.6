Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756218AbeDYSXH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:23:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46404 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755758AbeDYSV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:21:27 -0400
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH net v2 1/2] net: mvpp2: Fix clk error path in mvpp2_probe
Date: Wed, 25 Apr 2018 20:21:16 +0200
Message-Id: <20180425182117.28826-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180425182117.28826-1-maxime.chevallier@bootlin.com>
References: <20180425182117.28826-1-maxime.chevallier@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When clk_prepare_enable fails for the axi_clk, the mg_clk isn't properly
cleaned up. Add another jump label to handle that case, and make sure we
jump to it in the later error cases.

Fixes: 4792ea04bcd0 ("net: mvpp2: Fix clock resource by adding an optional bus clock")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
V2: Added Gregory Clement's Acked-by.

 drivers/net/ethernet/marvell/mvpp2.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 4202f9b5b966..0c2f04813d42 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -8774,12 +8774,12 @@ static int mvpp2_probe(struct platform_device *pdev)
 		if (IS_ERR(priv->axi_clk)) {
 			err = PTR_ERR(priv->axi_clk);
 			if (err == -EPROBE_DEFER)
-				goto err_gop_clk;
+				goto err_mg_clk;
 			priv->axi_clk = NULL;
 		} else {
 			err = clk_prepare_enable(priv->axi_clk);
 			if (err < 0)
-				goto err_gop_clk;
+				goto err_mg_clk;
 		}
 
 		/* Get system's tclk rate */
@@ -8793,7 +8793,7 @@ static int mvpp2_probe(struct platform_device *pdev)
 	if (priv->hw_version == MVPP22) {
 		err = dma_set_mask(&pdev->dev, MVPP2_DESC_DMA_MASK);
 		if (err)
-			goto err_mg_clk;
+			goto err_axi_clk;
 		/* Sadly, the BM pools all share the same register to
 		 * store the high 32 bits of their address. So they
 		 * must all have the same high 32 bits, which forces
@@ -8801,14 +8801,14 @@ static int mvpp2_probe(struct platform_device *pdev)
 		 */
 		err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
 		if (err)
-			goto err_mg_clk;
+			goto err_axi_clk;
 	}
 
 	/* Initialize network controller */
 	err = mvpp2_init(pdev, priv);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to initialize controller\n");
-		goto err_mg_clk;
+		goto err_axi_clk;
 	}
 
 	/* Initialize ports */
@@ -8821,7 +8821,7 @@ static int mvpp2_probe(struct platform_device *pdev)
 	if (priv->port_count == 0) {
 		dev_err(&pdev->dev, "no ports enabled\n");
 		err = -ENODEV;
-		goto err_mg_clk;
+		goto err_axi_clk;
 	}
 
 	/* Statistics must be gathered regularly because some of them (like
@@ -8849,8 +8849,9 @@ static int mvpp2_probe(struct platform_device *pdev)
 			mvpp2_port_remove(priv->port_list[i]);
 		i++;
 	}
-err_mg_clk:
+err_axi_clk:
 	clk_disable_unprepare(priv->axi_clk);
+err_mg_clk:
 	if (priv->hw_version == MVPP22)
 		clk_disable_unprepare(priv->mg_clk);
 err_gop_clk:
-- 
2.11.0
