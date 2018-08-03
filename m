Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8048C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845892172B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="HcC2/Aqo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845892172B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732809AbeHCJQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:16:51 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:59484 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729792AbeHCJQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id D4E12145043E7;
        Fri,  3 Aug 2018 15:25:06 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qbi4HePeErs1; Fri,  3 Aug 2018 15:25:06 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 83230145043E5;
        Fri,  3 Aug 2018 15:25:06 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai 83230145043E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281106;
        bh=+0LEdI0tbpncqLolsx8+88+h1o2BYz5/RWpFQWPdgbQ=;
        h=From:To:Subject:Date:Message-Id;
        b=HcC2/AqoeB8Ev3PQmhVaekRq8vZM23ITh/7Jas7xLU2S1xwK9HRtrgmGqcGQIPg2k
         dbNGaigiU+uUXWf4eh6hakCqEHM0BbkELp6gH0X7hcOnyj6UT+ZGLzS5Vz+yDkt/Qh
         zZAl+p/ZLRJlzmkWlaZkxtpXs42HopmvQ7WUSenA=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Za_VUvQ5aMC0; Fri,  3 Aug 2018 15:25:06 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id A2667107081E4;
        Fri,  3 Aug 2018 15:25:05 +0800 (CST)
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
Subject: [PATCH 20/46] dmaengine: sirf-dma: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:19:50 +0800
Message-Id: <20180803072016.21544-21-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180803072016.21544-1-sjhuang@iluvatar.ai>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dmaenginem_async_device_register to simplify the code:
	remove dma_async_device_unregister.
	remove label unreg_dma_dev

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 drivers/dma/sirf-dma.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index a0733ac3edb1..de19880d4254 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -944,7 +944,7 @@ static int sirfsoc_dma_probe(struct platform_device *op)
 	/* Register DMA engine */
 	dev_set_drvdata(dev, sdma);
 
-	ret = dma_async_device_register(dma);
+	ret = dmaenginem_async_device_register(dma);
 	if (ret)
 		goto free_irq;
 
@@ -952,7 +952,7 @@ static int sirfsoc_dma_probe(struct platform_device *op)
 	ret = of_dma_controller_register(dn, of_dma_sirfsoc_xlate, sdma);
 	if (ret) {
 		dev_err(dev, "failed to register DMA controller\n");
-		goto unreg_dma_dev;
+		goto free_irq;
 	}
 
 	pm_runtime_enable(&op->dev);
@@ -960,8 +960,6 @@ static int sirfsoc_dma_probe(struct platform_device *op)
 
 	return 0;
 
-unreg_dma_dev:
-	dma_async_device_unregister(dma);
 free_irq:
 	free_irq(sdma->irq, sdma);
 irq_dispose:
@@ -975,7 +973,6 @@ static int sirfsoc_dma_remove(struct platform_device *op)
 	struct sirfsoc_dma *sdma = dev_get_drvdata(dev);
 
 	of_dma_controller_free(op->dev.of_node);
-	dma_async_device_unregister(&sdma->dma);
 	free_irq(sdma->irq, sdma);
 	tasklet_kill(&sdma->tasklet);
 	irq_dispose_mapping(sdma->irq);
-- 
2.17.1

