Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2D3C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B15216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="rP78sdgE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B15216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732924AbeHCJSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:18:08 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:57868 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732669AbeHCJQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 610D51455686C;
        Fri,  3 Aug 2018 15:25:29 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id pVd05TpmKQLH; Fri,  3 Aug 2018 15:25:29 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id E015514556875;
        Fri,  3 Aug 2018 15:25:28 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai E015514556875
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281128;
        bh=ejPrVnB9CtqvxqJa/YPyb+cjeDYkd96NtXhy/IBIQK0=;
        h=From:To:Subject:Date:Message-Id;
        b=rP78sdgE+18qkrXZSWewxt6hmbOKA6aPyzIiwfwsK1aYt75j2lYI7+qq+/eGVLbi0
         YZaIlr5eo2uniYsWUNHBFI9Didw8rcxsNeCfrzR3pz7OXpgpAU1Qotzc14P3yNLKgn
         NzVfWtSrhax5INnEnyMLHqms6/LaLcDwma40WRBY=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UbsmcR8DOfoh; Fri,  3 Aug 2018 15:25:28 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 7AA401455686C;
        Fri,  3 Aug 2018 15:25:27 +0800 (CST)
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
Subject: [PATCH 42/46] dmaengine: at_xdmac: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:20:12 +0800
Message-Id: <20180803072016.21544-43-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180803072016.21544-1-sjhuang@iluvatar.ai>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dmaenginem_async_device_register to simplify the code:
	remove dma_async_device_unregister.
	remove label err_dma_unregister

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 drivers/dma/at_xdmac.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 4bf72561667c..c220f667be80 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -2041,7 +2041,7 @@ static int at_xdmac_probe(struct platform_device *pdev)
 	}
 	platform_set_drvdata(pdev, atxdmac);
 
-	ret = dma_async_device_register(&atxdmac->dma);
+	ret = dmaenginem_async_device_register(&atxdmac->dma);
 	if (ret) {
 		dev_err(&pdev->dev, "fail to register DMA engine device\n");
 		goto err_clk_disable;
@@ -2051,7 +2051,7 @@ static int at_xdmac_probe(struct platform_device *pdev)
 					 at_xdmac_xlate, atxdmac);
 	if (ret) {
 		dev_err(&pdev->dev, "could not register of dma controller\n");
-		goto err_dma_unregister;
+		goto err_clk_disable;
 	}
 
 	dev_info(&pdev->dev, "%d channels, mapped at 0x%p\n",
@@ -2059,8 +2059,6 @@ static int at_xdmac_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_dma_unregister:
-	dma_async_device_unregister(&atxdmac->dma);
 err_clk_disable:
 	clk_disable_unprepare(atxdmac->clk);
 err_free_irq:
@@ -2075,7 +2073,6 @@ static int at_xdmac_remove(struct platform_device *pdev)
 
 	at_xdmac_off(atxdmac);
 	of_dma_controller_free(pdev->dev.of_node);
-	dma_async_device_unregister(&atxdmac->dma);
 	clk_disable_unprepare(atxdmac->clk);
 
 	free_irq(atxdmac->irq, atxdmac);
-- 
2.17.1

