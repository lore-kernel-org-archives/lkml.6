Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7F0C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06660215F9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="vG/XcPhb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06660215F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732999AbeHCJTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:19:02 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:59071 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732617AbeHCJQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id C5331107081FF;
        Fri,  3 Aug 2018 15:25:23 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6Jmc3i1VDrHN; Fri,  3 Aug 2018 15:25:23 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 44939107081FE;
        Fri,  3 Aug 2018 15:25:23 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai 44939107081FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281123;
        bh=TBaKrpfhbftcvr/p6WFhOBVBJ1IwI0NZpO0Qr7fxBzI=;
        h=From:To:Subject:Date:Message-Id;
        b=vG/XcPhbyJBswCkMboq9r7H10IZVMpgvSqSx6PhUWMsHXR1HYZQ+wYWFaRkgZkXe6
         dsPxsWIedqwI5Ln/WS6ajd20jZUwNDe5EBkf6Qj5wchSE2uuusps7aa+eVeeqta79Y
         irloDcMQ/9cHTWD+PtN1X91pM9og1362rWGXnyPM=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Pd3CL0Ucq_3U; Fri,  3 Aug 2018 15:25:23 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 9E088107081FA;
        Fri,  3 Aug 2018 15:25:22 +0800 (CST)
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
Subject: [PATCH 37/46] dmaengine: imx-sdma: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:20:07 +0800
Message-Id: <20180803072016.21544-38-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180803072016.21544-1-sjhuang@iluvatar.ai>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dmaenginem_async_device_register to simplify the code:
	remove dma_async_device_unregister.
	remove label err_register

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 drivers/dma/imx-sdma.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index b4ec2d20e661..3ee28d044e3c 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2062,7 +2062,7 @@ static int sdma_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sdma);
 
-	ret = dma_async_device_register(&sdma->dma_device);
+	ret = dmaenginem_async_device_register(&sdma->dma_device);
 	if (ret) {
 		dev_err(&pdev->dev, "unable to register\n");
 		goto err_init;
@@ -2072,7 +2072,7 @@ static int sdma_probe(struct platform_device *pdev)
 		ret = of_dma_controller_register(np, sdma_xlate, sdma);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to register controller\n");
-			goto err_register;
+			goto err_init;
 		}
 
 		spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
@@ -2086,8 +2086,6 @@ static int sdma_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_register:
-	dma_async_device_unregister(&sdma->dma_device);
 err_init:
 	kfree(sdma->script_addrs);
 err_irq:
@@ -2103,7 +2101,6 @@ static int sdma_remove(struct platform_device *pdev)
 	int i;
 
 	devm_free_irq(&pdev->dev, sdma->irq, sdma);
-	dma_async_device_unregister(&sdma->dma_device);
 	kfree(sdma->script_addrs);
 	clk_unprepare(sdma->clk_ahb);
 	clk_unprepare(sdma->clk_ipg);
-- 
2.17.1

