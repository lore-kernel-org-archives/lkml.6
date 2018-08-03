Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C7FC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52147216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="RLjqsI1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52147216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732763AbeHCJTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:19:33 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:57627 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732576AbeHCJQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id D0369107081F0;
        Fri,  3 Aug 2018 15:25:18 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SfCSmav23mhm; Fri,  3 Aug 2018 15:25:18 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 40E091450440D;
        Fri,  3 Aug 2018 15:25:17 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai 40E091450440D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281117;
        bh=mxbkTipqAX2GlVy4BQFdzxVEf7gVOcJdK1nV6gJ/jBc=;
        h=From:To:Subject:Date:Message-Id;
        b=RLjqsI1+j68k0wF86fYPfYZAYmec10pBIixjNwAilWf2/XD9nNAQX9UiCmMZXzYxN
         OTus1lOZpSOHGojivKA9SrlrP9UcCax3Cj7RKf8MXl1fhYV+sL2fOCYWIL6zzI2sKc
         27Rqs+FziKMQcsu1P1NuytQAQwEQtowruKj46mN4=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1gvrlceLYi7h; Fri,  3 Aug 2018 15:25:16 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id ADCF7107081F1;
        Fri,  3 Aug 2018 15:25:15 +0800 (CST)
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
Subject: [PATCH 31/46] dmaengine: moxart-dma: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:20:01 +0800
Message-Id: <20180803072016.21544-32-sjhuang@iluvatar.ai>
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
 drivers/dma/moxart-dma.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/moxart-dma.c b/drivers/dma/moxart-dma.c
index e04499c1f27f..80bff27c5f9b 100644
--- a/drivers/dma/moxart-dma.c
+++ b/drivers/dma/moxart-dma.c
@@ -618,7 +618,7 @@ static int moxart_probe(struct platform_device *pdev)
 	}
 	mdc->irq = irq;
 
-	ret = dma_async_device_register(&mdc->dma_slave);
+	ret = dmaenginem_async_device_register(&mdc->dma_slave);
 	if (ret) {
 		dev_err(dev, "dma_async_device_register failed\n");
 		return ret;
@@ -627,7 +627,6 @@ static int moxart_probe(struct platform_device *pdev)
 	ret = of_dma_controller_register(node, moxart_of_xlate, mdc);
 	if (ret) {
 		dev_err(dev, "of_dma_controller_register failed\n");
-		dma_async_device_unregister(&mdc->dma_slave);
 		return ret;
 	}
 
@@ -642,8 +641,6 @@ static int moxart_remove(struct platform_device *pdev)
 
 	devm_free_irq(&pdev->dev, m->irq, m);
 
-	dma_async_device_unregister(&m->dma_slave);
-
 	if (pdev->dev.of_node)
 		of_dma_controller_free(pdev->dev.of_node);
 
-- 
2.17.1

