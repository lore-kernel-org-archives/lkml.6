Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA2DC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2738C216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="OragWE49"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2738C216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732831AbeHCJQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:16:52 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:57210 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732737AbeHCJQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 0639B14556867;
        Fri,  3 Aug 2018 15:25:28 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Rz1MkBeQqoG1; Fri,  3 Aug 2018 15:25:27 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 9CA941455686D;
        Fri,  3 Aug 2018 15:25:27 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai 9CA941455686D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281127;
        bh=sTw1UU5qD7fkC1MT8wtHFAyBFEwMFPe8deeAAyKJf3U=;
        h=From:To:Subject:Date:Message-Id;
        b=OragWE493wIYKzgOU9JitevokFP+8PS6XDrayqOjB5a8FsULpbQEDCych1EOpEg4q
         3ToIVeCHecn5mOdsWUAQZDJra1Mqy8HJfojsBDlCkJ1CwnYQl2km/zDtavHo8cBsce
         9xnMYT0k7Sht7gHhaj+zZ5JzIqhZIWqTZlWaAHRc=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id F3ndg3WZgssX; Fri,  3 Aug 2018 15:25:27 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 5319B140B5B37;
        Fri,  3 Aug 2018 15:25:26 +0800 (CST)
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
Subject: [PATCH 41/46] dmaengine: at_hdmac: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:20:11 +0800
Message-Id: <20180803072016.21544-42-sjhuang@iluvatar.ai>
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
 drivers/dma/at_hdmac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 75f38d19fcbe..536146601238 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1954,7 +1954,7 @@ static int __init at_dma_probe(struct platform_device *pdev)
 	  dma_has_cap(DMA_SLAVE, atdma->dma_common.cap_mask)  ? "slave " : "",
 	  plat_dat->nr_channels);
 
-	dma_async_device_register(&atdma->dma_common);
+	dmaenginem_async_device_register(&atdma->dma_common);
 
 	/*
 	 * Do not return an error if the dmac node is not present in order to
@@ -1973,7 +1973,6 @@ static int __init at_dma_probe(struct platform_device *pdev)
 	return 0;
 
 err_of_dma_controller_register:
-	dma_async_device_unregister(&atdma->dma_common);
 	dma_pool_destroy(atdma->memset_pool);
 err_memset_pool_create:
 	dma_pool_destroy(atdma->dma_desc_pool);
@@ -2000,7 +1999,6 @@ static int at_dma_remove(struct platform_device *pdev)
 	struct resource		*io;
 
 	at_dma_off(atdma);
-	dma_async_device_unregister(&atdma->dma_common);
 
 	dma_pool_destroy(atdma->memset_pool);
 	dma_pool_destroy(atdma->dma_desc_pool);
-- 
2.17.1

