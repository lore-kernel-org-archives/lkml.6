Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BF3C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D97B216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="BcZobnst"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D97B216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732703AbeHCJQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:16:46 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:59304 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732578AbeHCJQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 176EE14556868;
        Fri,  3 Aug 2018 15:25:27 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Z2BftHRRyNyL; Fri,  3 Aug 2018 15:25:26 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 7F7C614556865;
        Fri,  3 Aug 2018 15:25:26 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai 7F7C614556865
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281126;
        bh=gRFOnUg805YoPlmlwGSAHvU6J1kX5Vd5rugJZ5+KGvM=;
        h=From:To:Subject:Date:Message-Id;
        b=BcZobnstU4T8XJnMqVul7rNxMybDfPGssMVMUdj2a51DJffTOgi9rGcZfHiCCplVn
         1GAV4xvS+FVFtQgXe8CysyxKcKuiZrVHw4HmYCRUvH0jRBotO+w/rx69z5G3/d1HyM
         rjtawHi7LsdO6iuoKlfAaSIPyBffdVT/x5b937hY=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sMUF25L9K6tQ; Fri,  3 Aug 2018 15:25:26 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 95F51107081FA;
        Fri,  3 Aug 2018 15:25:24 +0800 (CST)
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
Subject: [PATCH 40/46] dmaengine: fsl-edma: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:20:10 +0800
Message-Id: <20180803072016.21544-41-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180803072016.21544-1-sjhuang@iluvatar.ai>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dmaenginem_async_device_register to simplify the code:
	remove dma_async_device_unregister.

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 drivers/dma/fsl-edma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
index c7568869284e..f475efce1d60 100644
--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -972,7 +972,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, fsl_edma);
 
-	ret = dma_async_device_register(&fsl_edma->dma_dev);
+	ret = dmaenginem_async_device_register(&fsl_edma->dma_dev);
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA engine. (%d)\n", ret);
@@ -984,7 +984,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA of_dma. (%d)\n", ret);
-		dma_async_device_unregister(&fsl_edma->dma_dev);
 		fsl_disable_clocks(fsl_edma, DMAMUX_NR);
 		return ret;
 	}
@@ -1014,7 +1013,6 @@ static int fsl_edma_remove(struct platform_device *pdev)
 	fsl_edma_irq_exit(pdev, fsl_edma);
 	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
 	of_dma_controller_free(np);
-	dma_async_device_unregister(&fsl_edma->dma_dev);
 	fsl_disable_clocks(fsl_edma, DMAMUX_NR);
 
 	return 0;
-- 
2.17.1

