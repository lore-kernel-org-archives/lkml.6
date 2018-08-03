Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02348C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2BD21731
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="rWQ0k1cD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2BD21731
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732156AbeHCJQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:16:21 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:57210 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727811AbeHCJQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 402B7107081CB;
        Fri,  3 Aug 2018 15:24:55 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id hpnu-aZgwmDI; Fri,  3 Aug 2018 15:24:55 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id E116A107081D6;
        Fri,  3 Aug 2018 15:24:54 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai E116A107081D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281094;
        bh=JEg5tyXOeuWx5L8ppkqWYiCgCykzI9Su9e/d2v/AgjI=;
        h=From:To:Subject:Date:Message-Id;
        b=rWQ0k1cDcyQZRvvRsOGUBLOjKw8kZALPn7PW3ylN0VKngPwGm+DLg+yNAgr131e6r
         bwVXXONRsVAcnUyVJMtKGTjgf2ivMQiMvh9CRP1hBNmEne4f8JOlcAB0m03IGQniDe
         W4VrvSMN7wflCxkC09oZvDxRi1wnpwLasW4txJME=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YeGzlsy4dTJP; Fri,  3 Aug 2018 15:24:54 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 92BCF107081CB;
        Fri,  3 Aug 2018 15:24:53 +0800 (CST)
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
Subject: [PATCH 08/46] dmaengine: edma: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:19:38 +0800
Message-Id: <20180803072016.21544-9-sjhuang@iluvatar.ai>
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
 drivers/dma/ti/edma.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index ceabdea40ae0..28ba1e722c47 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2388,18 +2388,17 @@ static int edma_probe(struct platform_device *pdev)
 	ecc->dma_slave.filter.mapcnt = info->slavecnt;
 	ecc->dma_slave.filter.fn = edma_filter_fn;
 
-	ret = dma_async_device_register(&ecc->dma_slave);
+	ret = dmaenginem_async_device_register(&ecc->dma_slave);
 	if (ret) {
 		dev_err(dev, "slave ddev registration failed (%d)\n", ret);
 		goto err_reg1;
 	}
 
 	if (ecc->dma_memcpy) {
-		ret = dma_async_device_register(ecc->dma_memcpy);
+		ret = dmaenginem_async_device_register(ecc->dma_memcpy);
 		if (ret) {
 			dev_err(dev, "memcpy ddev registration failed (%d)\n",
 				ret);
-			dma_async_device_unregister(&ecc->dma_slave);
 			goto err_reg1;
 		}
 	}
@@ -2439,9 +2438,6 @@ static int edma_remove(struct platform_device *pdev)
 
 	if (dev->of_node)
 		of_dma_controller_free(dev->of_node);
-	dma_async_device_unregister(&ecc->dma_slave);
-	if (ecc->dma_memcpy)
-		dma_async_device_unregister(ecc->dma_memcpy);
 	edma_free_slot(ecc, ecc->dummy_slot);
 
 	return 0;
-- 
2.17.1

