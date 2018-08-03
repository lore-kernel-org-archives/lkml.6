Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB805C46467
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853A02172B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="X5zERYy2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853A02172B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732613AbeHCJQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:16:40 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:58141 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732327AbeHCJQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 8F5D5145043EC;
        Fri,  3 Aug 2018 15:25:07 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id A588wdDxjdzk; Fri,  3 Aug 2018 15:25:07 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 3870B145043E6;
        Fri,  3 Aug 2018 15:25:07 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai 3870B145043E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281107;
        bh=w3cxYzdbbUkJtxOQKY/8TfWTnojmX4H6Gg3ntVMaPUY=;
        h=From:To:Subject:Date:Message-Id;
        b=X5zERYy2BRXYoa6cdNrzHOsr6UXiRHys9mmrKg/uxcioca0AaLvd+CqvZw88IFaGZ
         QDej070cvjWueguqxykxTqU0SXbq+OwfiRga9s9u5U4gkI1oL8zxDg6oNrUbS1WJ6l
         4/6yYPdHy16jbxiRkcJ/m36fxMVG/xMbuZOgTEbk=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kKUaJ0llosoK; Fri,  3 Aug 2018 15:25:07 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 77824145043E2;
        Fri,  3 Aug 2018 15:25:06 +0800 (CST)
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
Subject: [PATCH 21/46] dmaengine: bam_dma: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:19:51 +0800
Message-Id: <20180803072016.21544-22-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180803072016.21544-1-sjhuang@iluvatar.ai>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dmaenginem_async_device_register to simplify the code:
	remove dma_async_device_unregister.
	remove label err_unregister_dma

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 drivers/dma/qcom/bam_dma.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 1617715aa6e0..d164892a8aa4 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1332,7 +1332,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 	bdev->common.device_tx_status = bam_tx_status;
 	bdev->common.dev = bdev->dev;
 
-	ret = dma_async_device_register(&bdev->common);
+	ret = dmaenginem_async_device_register(&bdev->common);
 	if (ret) {
 		dev_err(bdev->dev, "failed to register dma async device\n");
 		goto err_bam_channel_exit;
@@ -1341,7 +1341,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 	ret = of_dma_controller_register(pdev->dev.of_node, bam_dma_xlate,
 					&bdev->common);
 	if (ret)
-		goto err_unregister_dma;
+		goto err_bam_channel_exit;
 
 	if (bdev->controlled_remotely) {
 		pm_runtime_disable(&pdev->dev);
@@ -1357,8 +1357,6 @@ static int bam_dma_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_unregister_dma:
-	dma_async_device_unregister(&bdev->common);
 err_bam_channel_exit:
 	for (i = 0; i < bdev->num_channels; i++)
 		tasklet_kill(&bdev->channels[i].vc.task);
@@ -1378,7 +1376,6 @@ static int bam_dma_remove(struct platform_device *pdev)
 	pm_runtime_force_suspend(&pdev->dev);
 
 	of_dma_controller_free(pdev->dev.of_node);
-	dma_async_device_unregister(&bdev->common);
 
 	/* mask all interrupts for this execution environment */
 	writel_relaxed(0, bam_addr(bdev, 0,  BAM_IRQ_SRCS_MSK_EE));
-- 
2.17.1

