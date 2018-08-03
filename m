Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD6DC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C132172B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="ZG+X1DdT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C132172B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732873AbeHCJSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:18:55 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:59111 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732619AbeHCJQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 2CEC913AA51D9;
        Fri,  3 Aug 2018 15:25:24 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id D43tu2zrBXen; Fri,  3 Aug 2018 15:25:23 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id CF17C13AA51BE;
        Fri,  3 Aug 2018 15:25:23 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai CF17C13AA51BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281123;
        bh=wZ4aIDfQUJQq6YXYiT6w+/GpQddHamxLl2znTJrPDQw=;
        h=From:To:Subject:Date:Message-Id;
        b=ZG+X1DdT3gj7aEiaJvffyutgr2l+/xkisC0l9sP2S496Vv6b1xviQNahcPPXM61H0
         2W/7zV+aquf7KFe21lEF1Cw/JdCeiq2fB4xn+f9IVPdXxibNwZ6AONbKKXMPCmAgcr
         ReBIIwopt75xULzDmjDJRg7/AOQ+3KqtAPCndeSg=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1hZ_Cwc3E6Os; Fri,  3 Aug 2018 15:25:23 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 37FAE107081FC;
        Fri,  3 Aug 2018 15:25:23 +0800 (CST)
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave.jiang@intel.com, radhey.shyam.pandey@xilinx.com,
        appana.durga.rao@xilinx.com, jmkrzyszt@gmail.com,
        gomonovych@gmail.com, peter.ujfalusi@ti.com, keescook@chromium.org,
        horms+renesas@verge.net.au, geert+renesas@glider.be,
        shawnguo@kernel.org, baoyou.xie@linaro.org,
        michal.simek@xilinx.com, baohua@kernel.org,
        ludovic.desroches@microchip.com, linus.walleij@linaro.org,
        david.brown@linaro.org, Huang Shijie <sjhuang@iluvatar.ai>
Subject: [PATCH 38/46] dmaengine: imx-dma: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:20:08 +0800
Message-Id: <20180803072016.21544-39-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180803072016.21544-1-sjhuang@iluvatar.ai>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dmaenginem_async_device_register to simplify the code:
	remove dma_async_device_unregister.
	remove label err_of_dma_controller

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 drivers/dma/imx-dma.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index 75b6ff0415ee..d651fbea77ee 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -1186,7 +1186,7 @@ static int __init imxdma_probe(struct platform_device *pdev)
 	imxdma->dma_device.dev->dma_parms = &imxdma->dma_parms;
 	dma_set_max_seg_size(imxdma->dma_device.dev, 0xffffff);
 
-	ret = dma_async_device_register(&imxdma->dma_device);
+	ret = dmaenginem_async_device_register(&imxdma->dma_device);
 	if (ret) {
 		dev_err(&pdev->dev, "unable to register\n");
 		goto disable_dma_ahb_clk;
@@ -1197,14 +1197,12 @@ static int __init imxdma_probe(struct platform_device *pdev)
 				imxdma_xlate, imxdma);
 		if (ret) {
 			dev_err(&pdev->dev, "unable to register of_dma_controller\n");
-			goto err_of_dma_controller;
+			goto disable_dma_ahb_clk;
 		}
 	}
 
 	return 0;
 
-err_of_dma_controller:
-	dma_async_device_unregister(&imxdma->dma_device);
 disable_dma_ahb_clk:
 	clk_disable_unprepare(imxdma->dma_ahb);
 disable_dma_ipg_clk:
@@ -1237,8 +1235,6 @@ static int imxdma_remove(struct platform_device *pdev)
 
 	imxdma_free_irq(pdev, imxdma);
 
-        dma_async_device_unregister(&imxdma->dma_device);
-
 	if (pdev->dev.of_node)
 		of_dma_controller_free(pdev->dev.of_node);
 
-- 
2.17.1

