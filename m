Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8D7C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D47F216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="iYDGbPUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D47F216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeHCJQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:16:11 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:56587 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728033AbeHCJQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 04DCC13ED1C8E;
        Fri,  3 Aug 2018 15:24:49 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id A0Z3kgtpprml; Fri,  3 Aug 2018 15:24:47 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 42D0513ED1C88;
        Fri,  3 Aug 2018 15:24:47 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai 42D0513ED1C88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281087;
        bh=zT0yr/2y1bafwx2D4ro8vCwnXIfhv+I+MXgsXjZqfAs=;
        h=From:To:Subject:Date:Message-Id;
        b=iYDGbPUBiPrkR7ZZbALJK0FzCjNl8LvyJcfqMJH3tQV8a2xraDzeVgZspDEP56rbR
         6dah+kBzmjGW5Y1ygsV7QU7B8BKzgl3pNL9u66lx+rekc8uwXhNntzUtwEmqdN0NlA
         RYp4ziWfEUmnqNGqkAMskLLYFp6FbVbe2ZZiPZEo=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lm2U5uAs6_2z; Fri,  3 Aug 2018 15:24:46 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 7161713ED1C84;
        Fri,  3 Aug 2018 15:24:45 +0800 (CST)
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
Subject: [PATCH 01/46] dmaengine: zx_dma: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:19:31 +0800
Message-Id: <20180803072016.21544-2-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180803072016.21544-1-sjhuang@iluvatar.ai>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dmaenginem_async_device_register() to simplify the code.
Remove the code calling dma_async_device_unregister().

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 drivers/dma/zx_dma.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/zx_dma.c b/drivers/dma/zx_dma.c
index 2571bc7693df..7febd20113ef 100644
--- a/drivers/dma/zx_dma.c
+++ b/drivers/dma/zx_dma.c
@@ -861,20 +861,18 @@ static int zx_dma_probe(struct platform_device *op)
 	INIT_LIST_HEAD(&d->chan_pending);
 	platform_set_drvdata(op, d);
 
-	ret = dma_async_device_register(&d->slave);
+	ret = dmaenginem_async_device_register(&d->slave);
 	if (ret)
 		goto clk_dis;
 
 	ret = of_dma_controller_register((&op->dev)->of_node,
 					 zx_of_dma_simple_xlate, d);
 	if (ret)
-		goto of_dma_register_fail;
+		goto clk_dis;
 
 	dev_info(&op->dev, "initialized\n");
 	return 0;
 
-of_dma_register_fail:
-	dma_async_device_unregister(&d->slave);
 clk_dis:
 	clk_disable_unprepare(d->clk);
 zx_dma_out:
@@ -889,7 +887,6 @@ static int zx_dma_remove(struct platform_device *op)
 	/* explictly free the irq */
 	devm_free_irq(&op->dev, d->irq, d);
 
-	dma_async_device_unregister(&d->slave);
 	of_dma_controller_free((&op->dev)->of_node);
 
 	list_for_each_entry_safe(c, cn, &d->slave.channels,
-- 
2.17.1

