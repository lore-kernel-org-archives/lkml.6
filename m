Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E09C46463
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CEF0216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="iGIPQaev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CEF0216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732889AbeHCJRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:17:00 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:58213 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732709AbeHCJRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:17:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 223F814556872;
        Fri,  3 Aug 2018 15:25:31 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jhFo-M7nNTZg; Fri,  3 Aug 2018 15:25:30 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id CD87E1455687B;
        Fri,  3 Aug 2018 15:25:30 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai CD87E1455687B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281130;
        bh=g0artj/6uiXTZ0Awb0M9IlCS/jEKLN8ycLjuXH4i9mA=;
        h=From:To:Subject:Date:Message-Id;
        b=iGIPQaeviz85nxB/ZhoFqQ8Olhulu0MnV2ycAQQwBPHZXV4j8sDzuqaULoxrfzkq9
         VJWBdYSGIeeGvIVfU5bKq9QbW1xV3C/D/Z6Q6nWyg8fCqOWcMS+2CE+3hVzJ2+isXz
         kLiuUVBWFIBmOlxi5DHM21AXStk91b48gJjOXhKg=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sENx-j6ZVKPJ; Fri,  3 Aug 2018 15:25:30 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 7C80614556865;
        Fri,  3 Aug 2018 15:25:29 +0800 (CST)
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
Subject: [PATCH 44/46] dmaengine: dma-jz4740: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:20:14 +0800
Message-Id: <20180803072016.21544-45-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180803072016.21544-1-sjhuang@iluvatar.ai>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dmaenginem_async_device_register to simplify the code:
	remove dma_async_device_unregister.
	remove label err_unregister

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 drivers/dma/dma-jz4740.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dma-jz4740.c b/drivers/dma/dma-jz4740.c
index afd5e10f8927..30513a16e344 100644
--- a/drivers/dma/dma-jz4740.c
+++ b/drivers/dma/dma-jz4740.c
@@ -553,21 +553,19 @@ static int jz4740_dma_probe(struct platform_device *pdev)
 		vchan_init(&chan->vchan, dd);
 	}
 
-	ret = dma_async_device_register(dd);
+	ret = dmaenginem_async_device_register(dd);
 	if (ret)
 		goto err_clk;
 
 	irq = platform_get_irq(pdev, 0);
 	ret = request_irq(irq, jz4740_dma_irq, 0, dev_name(&pdev->dev), dmadev);
 	if (ret)
-		goto err_unregister;
+		goto err_clk;
 
 	platform_set_drvdata(pdev, dmadev);
 
 	return 0;
 
-err_unregister:
-	dma_async_device_unregister(dd);
 err_clk:
 	clk_disable_unprepare(dmadev->clk);
 	return ret;
@@ -593,7 +591,6 @@ static int jz4740_dma_remove(struct platform_device *pdev)
 	free_irq(irq, dmadev);
 
 	jz4740_cleanup_vchan(&dmadev->ddev);
-	dma_async_device_unregister(&dmadev->ddev);
 	clk_disable_unprepare(dmadev->clk);
 
 	return 0;
-- 
2.17.1

