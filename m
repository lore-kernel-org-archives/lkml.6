Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A347FC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1D22172D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="GBoX8swU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1D22172D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbeHCJQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:16:17 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:57164 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729808AbeHCJQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 5CFE1107081C5;
        Fri,  3 Aug 2018 15:24:53 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id vKU63yUJzV6Y; Fri,  3 Aug 2018 15:24:53 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 0372E107081C8;
        Fri,  3 Aug 2018 15:24:53 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai 0372E107081C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281093;
        bh=KDphEuHxfEV/bQvjVHae/IdvTgCB2O1z5hhVDSG7hJY=;
        h=From:To:Subject:Date:Message-Id;
        b=GBoX8swUjtj6ZjYON+03gJcJEDss1/oWCTeH/Eb+pdUglUAEAvfuNbW87F61McP2V
         hcz9UYQS7TnoCeDaNyU/i6x5Vwnyeq4yr9z+CERcMQaYQewcie5Y2vbweFEgL8zDKw
         WThu/a6vRJWVECiugF9RQ7zJus5AW5844nw4xPKE=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 75pcs9RCdl3c; Fri,  3 Aug 2018 15:24:52 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 43ED1107081C2;
        Fri,  3 Aug 2018 15:24:52 +0800 (CST)
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
Subject: [PATCH 06/46] dmaengine: timb_dma: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:19:36 +0800
Message-Id: <20180803072016.21544-7-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180803072016.21544-1-sjhuang@iluvatar.ai>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dmaenginem_async_device_register to simplify the code:
   remove dma_async_device_unregister

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 drivers/dma/timb_dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/timb_dma.c b/drivers/dma/timb_dma.c
index 395c698edb4d..39e1ba2347db 100644
--- a/drivers/dma/timb_dma.c
+++ b/drivers/dma/timb_dma.c
@@ -723,7 +723,7 @@ static int td_probe(struct platform_device *pdev)
 		list_add_tail(&td_chan->chan.device_node, &td->dma.channels);
 	}
 
-	err = dma_async_device_register(&td->dma);
+	err = dmaenginem_async_device_register(&td->dma);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to register async device\n");
 		goto err_free_irq;
@@ -754,7 +754,6 @@ static int td_remove(struct platform_device *pdev)
 	struct resource *iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	int irq = platform_get_irq(pdev, 0);
 
-	dma_async_device_unregister(&td->dma);
 	free_irq(irq, td);
 	tasklet_kill(&td->tasklet);
 	iounmap(td->membase);
-- 
2.17.1

