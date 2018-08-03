Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FACC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419B0216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="K2C9q9BM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419B0216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732791AbeHCJQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:16:50 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:57244 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729813AbeHCJQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 43261107081D5;
        Fri,  3 Aug 2018 15:24:56 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Bko_pmyfqmv0; Fri,  3 Aug 2018 15:24:56 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id BEE2A107081D0;
        Fri,  3 Aug 2018 15:24:55 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai BEE2A107081D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281095;
        bh=F+49CsiicXwSAQTxB0GG4z7Cl9pIEsQPRQxX9QgEffE=;
        h=From:To:Subject:Date:Message-Id;
        b=K2C9q9BMu3xmW1sCoxuGDW/vsCvsZBJTg1LfvpNDFqFGC8GwMYBDxmq/pAImtkAot
         cDI91SPdFRoggpzVJqL6J5KupPRZicM8u3htYn7X6z02XzCA47wHMxmu4oDs7c4KiD
         9KRdl8recV9xLYKjtNvUHhbvHcPp84ZCuLkuqkuc=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id g7z6qFEuj1GH; Fri,  3 Aug 2018 15:24:55 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id D2692107081CD;
        Fri,  3 Aug 2018 15:24:54 +0800 (CST)
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
Subject: [PATCH 09/46] dmaengine: cppi41: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:19:39 +0800
Message-Id: <20180803072016.21544-10-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180803072016.21544-1-sjhuang@iluvatar.ai>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dmaenginem_async_device_register to simplify the code:
   remove dma_async_device_unregister

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 drivers/dma/ti/cppi41.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/ti/cppi41.c b/drivers/dma/ti/cppi41.c
index 1497da367710..d2998a19ed2e 100644
--- a/drivers/dma/ti/cppi41.c
+++ b/drivers/dma/ti/cppi41.c
@@ -1096,21 +1096,19 @@ static int cppi41_dma_probe(struct platform_device *pdev)
 		goto err_chans;
 	cdd->irq = irq;
 
-	ret = dma_async_device_register(&cdd->ddev);
+	ret = dmaenginem_async_device_register(&cdd->ddev);
 	if (ret)
 		goto err_chans;
 
 	ret = of_dma_controller_register(dev->of_node,
 			cppi41_dma_xlate, &cpp41_dma_info);
 	if (ret)
-		goto err_of;
+		goto err_chans;
 
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return 0;
-err_of:
-	dma_async_device_unregister(&cdd->ddev);
 err_chans:
 	deinit_cppi41(dev, cdd);
 err_init_cppi:
@@ -1132,7 +1130,6 @@ static int cppi41_dma_remove(struct platform_device *pdev)
 		dev_err(&pdev->dev, "%s could not pm_runtime_get: %i\n",
 			__func__, error);
 	of_dma_controller_free(pdev->dev.of_node);
-	dma_async_device_unregister(&cdd->ddev);
 
 	devm_free_irq(&pdev->dev, cdd->irq, cdd);
 	deinit_cppi41(&pdev->dev, cdd);
-- 
2.17.1

