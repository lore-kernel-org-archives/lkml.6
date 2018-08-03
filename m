Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D25FC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07868216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="MbYBU8UH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07868216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732721AbeHCJQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:16:46 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:57164 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732620AbeHCJQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 2A56C1450441C;
        Fri,  3 Aug 2018 15:25:19 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id OFR43FS-YQg2; Fri,  3 Aug 2018 15:25:18 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id B3B1C1450441A;
        Fri,  3 Aug 2018 15:25:18 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai B3B1C1450441A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281118;
        bh=sYlwJ5RiWGaXSyuQbIFZWdtOrzK7EPZqNPhlQmJhOkg=;
        h=From:To:Subject:Date:Message-Id;
        b=MbYBU8UHwufVusFdJv2Ix1/hKvWQhk8iyPw8FiWF82RxQTX2+SclbA4dHq5YlyVsX
         xpT5biHkG7eP9RXrhssUSSOZEayo9FdVVGfDLhBqR0ZZY319u9+MK4AXaVutljCuuR
         1vUdY7k+YMsORwzQ1kOPqH1ELu5Gkx8rCsmf7nAc=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3aFBHEXK6QuG; Fri,  3 Aug 2018 15:25:18 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id E395014504413;
        Fri,  3 Aug 2018 15:25:16 +0800 (CST)
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
Subject: [PATCH 32/46] dmaengine: pl330: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:20:02 +0800
Message-Id: <20180803072016.21544-33-sjhuang@iluvatar.ai>
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
 drivers/dma/pl330.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 88750a34e859..e4bc330132c7 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -3037,7 +3037,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 	pd->max_burst = ((pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP) ?
 			 1 : PL330_MAX_BURST);
 
-	ret = dma_async_device_register(pd);
+	ret = dmaenginem_async_device_register(pd);
 	if (ret) {
 		dev_err(&adev->dev, "unable to register DMAC\n");
 		goto probe_err3;
@@ -3114,8 +3114,6 @@ static int pl330_remove(struct amba_device *adev)
 			devm_free_irq(&adev->dev, irq, pl330);
 	}
 
-	dma_async_device_unregister(&pl330->ddma);
-
 	/* Idle the DMAC */
 	list_for_each_entry_safe(pch, _p, &pl330->ddma.channels,
 			chan.device_node) {
-- 
2.17.1

