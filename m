Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866E2C46463
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6EE216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="EHCokPj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D6EE216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732869AbeHCJQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:16:55 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:57735 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732670AbeHCJQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id D96BC1455686F;
        Fri,  3 Aug 2018 15:25:29 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ibrkgwYSh1EH; Fri,  3 Aug 2018 15:25:29 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 8AB2114556870;
        Fri,  3 Aug 2018 15:25:29 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai 8AB2114556870
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281129;
        bh=wFyy7JV/hK38zSHu+jvvNX7SVjgqYRFDGo08N42P96Q=;
        h=From:To:Subject:Date:Message-Id;
        b=EHCokPj1hkqyDaeUfpQT9LEwZCHfy2O9XQbXme7At//+gtKwtDcWvHOMMvAPa/K8d
         sODhFrgb4Zi41a5lzqQC2W68ufU8CJAP+CYjng0w5S5eAmUlPElkbnSBokGk2NQufH
         3IfgOBNYeBRCELLXpoKdsE0dxl5w9C60LnMW44i8=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3eqB7x0ZCGvS; Fri,  3 Aug 2018 15:25:29 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id DF13F14556874;
        Fri,  3 Aug 2018 15:25:28 +0800 (CST)
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
Subject: [PATCH 43/46] dmaengine: dma-jz4780: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:20:13 +0800
Message-Id: <20180803072016.21544-44-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180803072016.21544-1-sjhuang@iluvatar.ai>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dmaenginem_async_device_register to simplify the code:
	remove dma_async_device_unregister.
	remove label err_unregister_dev

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 drivers/dma/dma-jz4780.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 85820a2d69d4..b2a244902bc5 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -847,7 +847,7 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 		jzchan->vchan.desc_free = jz4780_dma_desc_free;
 	}
 
-	ret = dma_async_device_register(dd);
+	ret = dmaenginem_async_device_register(dd);
 	if (ret) {
 		dev_err(dev, "failed to register device\n");
 		goto err_disable_clk;
@@ -858,15 +858,12 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 					 jzdma);
 	if (ret) {
 		dev_err(dev, "failed to register OF DMA controller\n");
-		goto err_unregister_dev;
+		goto err_disable_clk;
 	}
 
 	dev_info(dev, "JZ4780 DMA controller initialised\n");
 	return 0;
 
-err_unregister_dev:
-	dma_async_device_unregister(dd);
-
 err_disable_clk:
 	clk_disable_unprepare(jzdma->clk);
 
@@ -887,7 +884,6 @@ static int jz4780_dma_remove(struct platform_device *pdev)
 	for (i = 0; i < JZ_DMA_NR_CHANNELS; i++)
 		tasklet_kill(&jzdma->chan[i].vchan.task);
 
-	dma_async_device_unregister(&jzdma->dma_device);
 	return 0;
 }
 
-- 
2.17.1

