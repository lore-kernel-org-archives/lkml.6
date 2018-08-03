Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942C4C46463
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3D821736
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="eII7g+3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3D821736
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732421AbeHCJQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:16:28 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:57164 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729792AbeHCJQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 38BD1107081E6;
        Fri,  3 Aug 2018 15:25:02 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 9Xtb-kLa-cMJ; Fri,  3 Aug 2018 15:25:01 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 36406107081EA;
        Fri,  3 Aug 2018 15:24:59 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai 36406107081EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281099;
        bh=NJv+olFHX2YCF2+oZqo7kxe07VRNXEfRgtCOC357ldA=;
        h=From:To:Subject:Date:Message-Id;
        b=eII7g+3QEtUyBOviw57tBfUN4hPMPGdzYkGqn5wHxswNBpV1cbVlOvjbBGQ5BzmvF
         rc7gOsERRtc7+DCHhRZ7jHtRQt32TksbPpY+mPMJioSfVT4oqq0c5KrhQ3SAOWjqHn
         QH9KVShK4rrk14NNmm+hDnPOBoZByAgVe8DoXDiY=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fsF29KP6y11h; Fri,  3 Aug 2018 15:24:59 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 230A9107081E0;
        Fri,  3 Aug 2018 15:24:58 +0800 (CST)
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
Subject: [PATCH 12/46] dmaengine: sun6i-dma: use helper dmaenginem_async_device_register
Date:   Fri,  3 Aug 2018 15:19:42 +0800
Message-Id: <20180803072016.21544-13-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180803072016.21544-1-sjhuang@iluvatar.ai>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dmaenginem_async_device_register to simplify the code:
   remove dma_async_device_unregister
   remove the label err_dma_unregister

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 drivers/dma/sun6i-dma.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 0cd13f17fc11..419d6090f9e1 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -1319,7 +1319,7 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 		goto err_clk_disable;
 	}
 
-	ret = dma_async_device_register(&sdc->slave);
+	ret = dmaenginem_async_device_register(&sdc->slave);
 	if (ret) {
 		dev_warn(&pdev->dev, "Failed to register DMA engine device\n");
 		goto err_irq_disable;
@@ -1329,7 +1329,7 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 					 sdc);
 	if (ret) {
 		dev_err(&pdev->dev, "of_dma_controller_register failed\n");
-		goto err_dma_unregister;
+		goto err_irq_disable;
 	}
 
 	if (sdc->cfg->clock_autogate_enable)
@@ -1337,8 +1337,6 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_dma_unregister:
-	dma_async_device_unregister(&sdc->slave);
 err_irq_disable:
 	sun6i_kill_tasklet(sdc);
 err_clk_disable:
@@ -1355,7 +1353,6 @@ static int sun6i_dma_remove(struct platform_device *pdev)
 	struct sun6i_dma_dev *sdc = platform_get_drvdata(pdev);
 
 	of_dma_controller_free(pdev->dev.of_node);
-	dma_async_device_unregister(&sdc->slave);
 
 	sun6i_kill_tasklet(sdc);
 
-- 
2.17.1

