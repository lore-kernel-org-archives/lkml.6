Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CD4C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BCF0216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="bn3pxKbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BCF0216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732317AbeHCJRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:17:53 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:59014 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732327AbeHCJQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 09DEE107081FD;
        Fri,  3 Aug 2018 15:25:23 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id PH5eJj_AmsQP; Fri,  3 Aug 2018 15:25:22 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id B45EF14504410;
        Fri,  3 Aug 2018 15:25:22 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai B45EF14504410
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281122;
        bh=yokq+J9xdJRpn6yDKc3HUxfNPmMCa2VnExcS/vsCY7w=;
        h=From:To:Subject:Date:Message-Id;
        b=bn3pxKbldtgzgkrxXbM6+T5eCBQxBgyBD2QWTFbHX2g87c3jSbQ9fFqu7tBuDhtC5
         IAA35li/zyfaFMs5k23G4SAKbeen7wdHD5W1HfzbpGGMMQ3OjW4Rde0pWPInRwxnWS
         YfJ3myi1YhuN5ecdB3LAhK8eyL9OZSYXJZGC8h0o=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id I1eoUGLO-tVd; Fri,  3 Aug 2018 15:25:22 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id B311F107081F7;
        Fri,  3 Aug 2018 15:25:21 +0800 (CST)
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
Subject: [PATCH 36/46] dmaengine: k3dma: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:20:06 +0800
Message-Id: <20180803072016.21544-37-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180803072016.21544-1-sjhuang@iluvatar.ai>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dmaenginem_async_device_register to simplify the code:
	remove dma_async_device_unregister.
	remove label of_dma_register_fail

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 drivers/dma/k3dma.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index 6bfa217ed6d0..5d9ab35b982d 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -902,14 +902,14 @@ static int k3_dma_probe(struct platform_device *op)
 
 	k3_dma_enable_dma(d, true);
 
-	ret = dma_async_device_register(&d->slave);
+	ret = dmaenginem_async_device_register(&d->slave);
 	if (ret)
 		goto dma_async_register_fail;
 
 	ret = of_dma_controller_register((&op->dev)->of_node,
 					k3_of_dma_simple_xlate, d);
 	if (ret)
-		goto of_dma_register_fail;
+		goto dma_async_register_fail;
 
 	spin_lock_init(&d->lock);
 	INIT_LIST_HEAD(&d->chan_pending);
@@ -919,8 +919,6 @@ static int k3_dma_probe(struct platform_device *op)
 
 	return 0;
 
-of_dma_register_fail:
-	dma_async_device_unregister(&d->slave);
 dma_async_register_fail:
 	clk_disable_unprepare(d->clk);
 	return ret;
@@ -931,7 +929,6 @@ static int k3_dma_remove(struct platform_device *op)
 	struct k3_dma_chan *c, *cn;
 	struct k3_dma_dev *d = platform_get_drvdata(op);
 
-	dma_async_device_unregister(&d->slave);
 	of_dma_controller_free((&op->dev)->of_node);
 
 	devm_free_irq(&op->dev, d->irq, d);
-- 
2.17.1

