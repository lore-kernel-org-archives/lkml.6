Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF88BC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625D5215F9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="EZwqH9o+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625D5215F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732652AbeHCJQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:16:43 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:57735 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732578AbeHCJQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 6290C1450440F;
        Fri,  3 Aug 2018 15:25:22 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id tjS73QsVDCqm; Fri,  3 Aug 2018 15:25:21 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id BFB82107081FA;
        Fri,  3 Aug 2018 15:25:21 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai BFB82107081FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281121;
        bh=ncGrydPtnf/aSQhFluURaqoFDfr7SHrg7yjX2icP44M=;
        h=From:To:Subject:Date:Message-Id;
        b=EZwqH9o+2D1qZXEdFyb+WKDyNNhP5IOzFrOJy9YGY/5SPn5UQ9hfgwLcy5ht41lXX
         zupY+gQoqeXu2CIJMSue9AzYTrmfkBKIZvtbA5M1O+SycaXvRumuOoIWDQG7gXGMfi
         52FUgHlflYZpWE9k5ipFr3SpF68lrMOQsueANp2g=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eqBmntOVgyws; Fri,  3 Aug 2018 15:25:21 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 990E414504402;
        Fri,  3 Aug 2018 15:25:20 +0800 (CST)
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
Subject: [PATCH 35/46] dmaengine: mtk-hsdma: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:20:05 +0800
Message-Id: <20180803072016.21544-36-sjhuang@iluvatar.ai>
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
 drivers/dma/mediatek/mtk-hsdma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-hsdma.c b/drivers/dma/mediatek/mtk-hsdma.c
index b7ec56ae02a6..a8b2e84e1556 100644
--- a/drivers/dma/mediatek/mtk-hsdma.c
+++ b/drivers/dma/mediatek/mtk-hsdma.c
@@ -977,7 +977,7 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
 		INIT_LIST_HEAD(&vc->desc_hw_processing);
 	}
 
-	err = dma_async_device_register(dd);
+	err = dmaenginem_async_device_register(dd);
 	if (err)
 		return err;
 
@@ -1007,7 +1007,6 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
 	return 0;
 
 err_unregister:
-	dma_async_device_unregister(dd);
 
 	return err;
 }
@@ -1035,7 +1034,6 @@ static int mtk_hsdma_remove(struct platform_device *pdev)
 	/* Disable hardware */
 	mtk_hsdma_hw_deinit(hsdma);
 
-	dma_async_device_unregister(&hsdma->ddev);
 	of_dma_controller_free(pdev->dev.of_node);
 
 	return 0;
-- 
2.17.1

