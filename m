Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40EAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD4320657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbfAOODh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:03:37 -0500
Received: from inva021.nxp.com ([92.121.34.21]:38316 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728812AbfAOODh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 09:03:37 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BC9C12000B1;
        Tue, 15 Jan 2019 15:03:34 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A46AD2000A9;
        Tue, 15 Jan 2019 15:03:34 +0100 (CET)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-ub1864-101.ea.freescale.net [10.171.82.46])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 1BE9C205DC;
        Tue, 15 Jan 2019 15:03:34 +0100 (CET)
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     linux-i2c@vger.kernel.org, linux-imx@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabio.estevam@nxp.com, leoyang.li@nxp.com,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH] i2c: imx: defer probing on dma channel request
Date:   Tue, 15 Jan 2019 16:03:32 +0200
Message-Id: <20190115140332.30417-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the dma controller is not yet probed, defer i2c probe.
The error path in probe was slightly modified (no functional change)
to avoid triggering this WARN_ON():
"cg-pll0-div1 already disabled
WARNING: CPU: 1 PID: 1 at drivers/clk/clk.c:828 clk_core_disable+0xa8/0xb0"

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/i2c/busses/i2c-imx.c | 45 +++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index fa9ad53845d9..5a28d25ff9b6 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -273,8 +273,8 @@ static inline unsigned char imx_i2c_read_reg(struct imx_i2c_struct *i2c_imx,
 }
 
 /* Functions for DMA support */
-static void i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
-						dma_addr_t phy_addr)
+static int i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
+			       dma_addr_t phy_addr)
 {
 	struct imx_i2c_dma *dma;
 	struct dma_slave_config dma_sconfig;
@@ -283,11 +283,12 @@ static void i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
 
 	dma = devm_kzalloc(dev, sizeof(*dma), GFP_KERNEL);
 	if (!dma)
-		return;
+		return -ENOMEM;
 
-	dma->chan_tx = dma_request_slave_channel(dev, "tx");
-	if (!dma->chan_tx) {
-		dev_dbg(dev, "can't request DMA tx channel\n");
+	dma->chan_tx = dma_request_slave_channel_reason(dev, "tx");
+	if (IS_ERR(dma->chan_tx)) {
+		ret = PTR_ERR(dma->chan_tx);
+		dma->chan_tx = NULL;
 		goto fail_al;
 	}
 
@@ -301,10 +302,10 @@ static void i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
 		dev_dbg(dev, "can't configure tx channel\n");
 		goto fail_tx;
 	}
-
-	dma->chan_rx = dma_request_slave_channel(dev, "rx");
-	if (!dma->chan_rx) {
-		dev_dbg(dev, "can't request DMA rx channel\n");
+	dma->chan_rx = dma_request_slave_channel_reason(dev, "rx");
+	if (IS_ERR(dma->chan_rx)) {
+		ret = PTR_ERR(dma->chan_rx);
+		dma->chan_rx = NULL;
 		goto fail_tx;
 	}
 
@@ -324,7 +325,7 @@ static void i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
 	dev_info(dev, "using %s (tx) and %s (rx) for DMA transfers\n",
 		dma_chan_name(dma->chan_tx), dma_chan_name(dma->chan_rx));
 
-	return;
+	return 0;
 
 fail_rx:
 	dma_release_channel(dma->chan_rx);
@@ -332,7 +333,8 @@ static void i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
 	dma_release_channel(dma->chan_tx);
 fail_al:
 	devm_kfree(dev, dma);
-	dev_info(dev, "can't use DMA, using PIO instead.\n");
+
+	return ret;
 }
 
 static void i2c_imx_dma_callback(void *arg)
@@ -1106,7 +1108,8 @@ static int i2c_imx_probe(struct platform_device *pdev)
 				pdev->name, i2c_imx);
 	if (ret) {
 		dev_err(&pdev->dev, "can't claim irq %d\n", irq);
-		goto clk_disable;
+		clk_disable_unprepare(i2c_imx->clk);
+		return ret;
 	}
 
 	/* Init queue */
@@ -1156,17 +1159,25 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
+	/* Init DMA config if supported */
+	ret = i2c_imx_dma_request(i2c_imx, phy_addr);
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_info(&pdev->dev, "can't use DMA, using PIO instead.\n");
+		else
+			goto del_adapter;
+	}
+
 	dev_dbg(&i2c_imx->adapter.dev, "claimed irq %d\n", irq);
 	dev_dbg(&i2c_imx->adapter.dev, "device resources: %pR\n", res);
 	dev_dbg(&i2c_imx->adapter.dev, "adapter name: \"%s\"\n",
 		i2c_imx->adapter.name);
 	dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
 
-	/* Init DMA config if supported */
-	i2c_imx_dma_request(i2c_imx, phy_addr);
-
 	return 0;   /* Return OK */
 
+del_adapter:
+	i2c_del_adapter(&i2c_imx->adapter);
 clk_notifier_unregister:
 	clk_notifier_unregister(i2c_imx->clk, &i2c_imx->clk_change_nb);
 rpm_disable:
@@ -1175,8 +1186,6 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 
-clk_disable:
-	clk_disable_unprepare(i2c_imx->clk);
 	return ret;
 }
 
-- 
2.17.1

