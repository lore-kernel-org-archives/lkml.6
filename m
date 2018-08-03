Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B29C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CAB8216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="XDMyc/Sy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CAB8216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732934AbeHCJSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:18:18 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:57209 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732189AbeHCJQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 437E714504417;
        Fri,  3 Aug 2018 15:25:20 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4IzbfSzBoPLT; Fri,  3 Aug 2018 15:25:20 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id E5FC814504402;
        Fri,  3 Aug 2018 15:25:19 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai E5FC814504402
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281119;
        bh=nqlPz7JrYaKKmhBz9zE4hhMU07s7gR6n7SR3LwpBZ0o=;
        h=From:To:Subject:Date:Message-Id;
        b=XDMyc/SyXPIYN9g4m+sZUzBbsHQNVH3ZlkTcOV90wCZxtS3Srk+qGB+IIu/qol5GA
         2DkB9Ajb0aYHAOOOO1HuV1kLdJCQ60bJl6ZSEbH8VhPivfj/5EtXfKvCQTpELZ80i0
         PPrZBAtQUWWJmokisBuXbvnAElMF1Ar7YU6SdiTs=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ENSTlBKo1pFK; Fri,  3 Aug 2018 15:25:19 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id DDE87107081F1;
        Fri,  3 Aug 2018 15:25:18 +0800 (CST)
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
Subject: [PATCH 33/46] dmaengine: pch_dma: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:20:03 +0800
Message-Id: <20180803072016.21544-34-sjhuang@iluvatar.ai>
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
 drivers/dma/pch_dma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
index afd8f27bda96..505463d077c0 100644
--- a/drivers/dma/pch_dma.c
+++ b/drivers/dma/pch_dma.c
@@ -922,7 +922,7 @@ static int pch_dma_probe(struct pci_dev *pdev,
 	pd->dma.device_prep_slave_sg = pd_prep_slave_sg;
 	pd->dma.device_terminate_all = pd_device_terminate_all;
 
-	err = dma_async_device_register(&pd->dma);
+	err = dmaenginem_async_device_register(&pd->dma);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to register DMA device\n");
 		goto err_free_pool;
@@ -952,8 +952,6 @@ static void pch_dma_remove(struct pci_dev *pdev)
 	struct dma_chan *chan, *_c;
 
 	if (pd) {
-		dma_async_device_unregister(&pd->dma);
-
 		free_irq(pdev->irq, pd);
 
 		list_for_each_entry_safe(chan, _c, &pd->dma.channels,
-- 
2.17.1

