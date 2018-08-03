Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0E6C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6B5216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="pz0Zd68l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D6B5216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732920AbeHCJRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:17:19 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:57164 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732739AbeHCJQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 10E3414556879;
        Fri,  3 Aug 2018 15:25:32 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id oxeSf0xP0lan; Fri,  3 Aug 2018 15:25:31 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 42FC514556877;
        Fri,  3 Aug 2018 15:25:31 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai 42FC514556877
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281131;
        bh=HMv50tUv+bwDyIbJOht8l4tiQTzfkN+NHv5bWAMm32U=;
        h=From:To:Subject:Date:Message-Id;
        b=pz0Zd68l/dmLeFiywj+jcQUN/5SMe5kKa/7nRQq771307jJpjnLDDljjow4GA/k1n
         xtjg8O9GXAcBA+a2BGtNmpRXOS5rDD8KctsQ5s/bpzqq3QwZEcrKjyZZaxDlsVsiBL
         6mdqTZFRjiR5PIfww1/NdaG0l0wZsxcN4AbGzY1k=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FJaGqLgJnup1; Fri,  3 Aug 2018 15:25:31 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id BBF6F14556879;
        Fri,  3 Aug 2018 15:25:30 +0800 (CST)
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
Subject: [PATCH 45/46] dmaengine: dma-axi-dmac: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:20:15 +0800
Message-Id: <20180803072016.21544-46-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180803072016.21544-1-sjhuang@iluvatar.ai>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dmaenginem_async_device_register to simplify the code:
	remove dma_async_device_unregister.
	remove label err_unregister_device

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 drivers/dma/dma-axi-dmac.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 15b2453d2647..d510184762e6 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -678,14 +678,14 @@ static int axi_dmac_probe(struct platform_device *pdev)
 
 	axi_dmac_write(dmac, AXI_DMAC_REG_IRQ_MASK, 0x00);
 
-	ret = dma_async_device_register(dma_dev);
+	ret = dmaenginem_async_device_register(dma_dev);
 	if (ret)
 		goto err_clk_disable;
 
 	ret = of_dma_controller_register(pdev->dev.of_node,
 		of_dma_xlate_by_chan_id, dma_dev);
 	if (ret)
-		goto err_unregister_device;
+		goto err_clk_disable;
 
 	ret = request_irq(dmac->irq, axi_dmac_interrupt_handler, IRQF_SHARED,
 		dev_name(&pdev->dev), dmac);
@@ -698,8 +698,6 @@ static int axi_dmac_probe(struct platform_device *pdev)
 
 err_unregister_of:
 	of_dma_controller_free(pdev->dev.of_node);
-err_unregister_device:
-	dma_async_device_unregister(&dmac->dma_dev);
 err_clk_disable:
 	clk_disable_unprepare(dmac->clk);
 
@@ -713,7 +711,6 @@ static int axi_dmac_remove(struct platform_device *pdev)
 	of_dma_controller_free(pdev->dev.of_node);
 	free_irq(dmac->irq, dmac);
 	tasklet_kill(&dmac->chan.vchan.task);
-	dma_async_device_unregister(&dmac->dma_dev);
 	clk_disable_unprepare(dmac->clk);
 
 	return 0;
-- 
2.17.1

