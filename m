Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756417AbeDYSVc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:21:32 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46411 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756331AbeDYSV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:21:29 -0400
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH net v2 2/2] net: mvpp2: Fix clock resource by adding missing mg_core_clk
Date: Wed, 25 Apr 2018 20:21:17 +0200
Message-Id: <20180425182117.28826-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180425182117.28826-1-maxime.chevallier@bootlin.com>
References: <20180425182117.28826-1-maxime.chevallier@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marvell's PPv2.2 IP needs an additional clock named "MG Core clock".
This is required on Armada 7K and 8K.

This commit adds the required clock in mvpp2, making sure it's only
used on PPv2.2.

Fixes: c7e92def1ef4 ("clk: mvebu: cp110: Fix clock tree representation")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V2: Don't immediately fail if mg_core_clk isn't present in DT, following
    G.Clement's remarks.

 drivers/net/ethernet/marvell/mvpp2.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 0c2f04813d42..6f410235987c 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -942,6 +942,7 @@ struct mvpp2 {
 	struct clk *pp_clk;
 	struct clk *gop_clk;
 	struct clk *mg_clk;
+	struct clk *mg_core_clk;
 	struct clk *axi_clk;
 
 	/* List of pointers to port structures */
@@ -8768,18 +8769,27 @@ static int mvpp2_probe(struct platform_device *pdev)
 			err = clk_prepare_enable(priv->mg_clk);
 			if (err < 0)
 				goto err_gop_clk;
+
+			priv->mg_core_clk = devm_clk_get(&pdev->dev, "mg_core_clk");
+			if (IS_ERR(priv->mg_core_clk)) {
+				priv->mg_core_clk = NULL;
+			} else {
+				err = clk_prepare_enable(priv->mg_core_clk);
+				if (err < 0)
+					goto err_mg_clk;
+			}
 		}
 
 		priv->axi_clk = devm_clk_get(&pdev->dev, "axi_clk");
 		if (IS_ERR(priv->axi_clk)) {
 			err = PTR_ERR(priv->axi_clk);
 			if (err == -EPROBE_DEFER)
-				goto err_mg_clk;
+				goto err_mg_core_clk;
 			priv->axi_clk = NULL;
 		} else {
 			err = clk_prepare_enable(priv->axi_clk);
 			if (err < 0)
-				goto err_mg_clk;
+				goto err_mg_core_clk;
 		}
 
 		/* Get system's tclk rate */
@@ -8851,6 +8861,10 @@ static int mvpp2_probe(struct platform_device *pdev)
 	}
 err_axi_clk:
 	clk_disable_unprepare(priv->axi_clk);
+
+err_mg_core_clk:
+	if (priv->hw_version == MVPP22)
+		clk_disable_unprepare(priv->mg_core_clk);
 err_mg_clk:
 	if (priv->hw_version == MVPP22)
 		clk_disable_unprepare(priv->mg_clk);
@@ -8898,6 +8912,7 @@ static int mvpp2_remove(struct platform_device *pdev)
 		return 0;
 
 	clk_disable_unprepare(priv->axi_clk);
+	clk_disable_unprepare(priv->mg_core_clk);
 	clk_disable_unprepare(priv->mg_clk);
 	clk_disable_unprepare(priv->pp_clk);
 	clk_disable_unprepare(priv->gop_clk);
-- 
2.11.0
