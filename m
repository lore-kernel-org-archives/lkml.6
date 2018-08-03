Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86A0C46463
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9469F2172B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="B/ivTNjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9469F2172B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbeHCJQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:16:12 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:56620 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727860AbeHCJQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 5CE9613ED1C88;
        Fri,  3 Aug 2018 15:24:49 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xtBoARfdOPR8; Fri,  3 Aug 2018 15:24:49 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id DA7E113ED1C8D;
        Fri,  3 Aug 2018 15:24:48 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai DA7E113ED1C8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281088;
        bh=F33xm6M0PmgJhj0I9FWkzwTHSkkQ4tkLbOJX0yHkoAE=;
        h=From:To:Subject:Date:Message-Id;
        b=B/ivTNjITH4zedkfbTzyKhw4lL3EWIjBVvQgU7BTMTUq68sOu2kM+XIi3yPAUb4d6
         bau+/3dcat17khYXV2BixMx1d3y8lZds5MGUyzyzP6k8KK2SbWf+c494O6/pD2GDiF
         qFDlfBOSblmbpJju9pSzB4j00Eav61DNw14A+eCA=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pPOHSV7LhCj5; Fri,  3 Aug 2018 15:24:48 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id A553913ED1C84;
        Fri,  3 Aug 2018 15:24:47 +0800 (CST)
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
Subject: [PATCH 03/46] dmaengine: xilinx_dma: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:19:33 +0800
Message-Id: <20180803072016.21544-4-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180803072016.21544-1-sjhuang@iluvatar.ai>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dmaenginem_async_device_register to simplify the code,
remove dma_async_device_unregister.

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 drivers/dma/xilinx/xilinx_dma.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index c12442312595..97ffeb5e59bb 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2705,13 +2705,12 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	}
 
 	/* Register the DMA engine with the core */
-	dma_async_device_register(&xdev->common);
+	dmaenginem_async_device_register(&xdev->common);
 
 	err = of_dma_controller_register(node, of_dma_xilinx_xlate,
 					 xdev);
 	if (err < 0) {
 		dev_err(&pdev->dev, "Unable to register DMA to DT\n");
-		dma_async_device_unregister(&xdev->common);
 		goto error;
 	}
 
@@ -2747,8 +2746,6 @@ static int xilinx_dma_remove(struct platform_device *pdev)
 
 	of_dma_controller_free(pdev->dev.of_node);
 
-	dma_async_device_unregister(&xdev->common);
-
 	for (i = 0; i < xdev->nr_channels; i++)
 		if (xdev->chan[i])
 			xilinx_dma_chan_remove(xdev->chan[i]);
-- 
2.17.1

