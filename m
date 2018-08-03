Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EA5C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC55E215F9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="EO1aJzBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC55E215F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733003AbeHCJTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:19:12 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:58124 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732577AbeHCJQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 1E75D107081F1;
        Fri,  3 Aug 2018 15:25:21 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ghKzrPCB-CCP; Fri,  3 Aug 2018 15:25:20 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id B53081450441E;
        Fri,  3 Aug 2018 15:25:20 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai B53081450441E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281120;
        bh=6DUAqC07vgSPkTJNSayDpKnDKQ1Qg/2ETN5hYoci42s=;
        h=From:To:Subject:Date:Message-Id;
        b=EO1aJzBusGjoEbDai/3zY3GjLHT4hdkgJfuBSGsg0EpHAJx/Kfgb9aFUbb0pocO05
         lmHrb2E73SixMHLISjUmTBHMULYOzLUobLanf+3HEMuY8z/efpht3Z0aOeblNmOcq5
         jmf3Wy+rVHrjmpZq5bf6218iKnyeSAbXo0Aemzag=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9m3sIUjFrKEy; Fri,  3 Aug 2018 15:25:20 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 010371450440F;
        Fri,  3 Aug 2018 15:25:19 +0800 (CST)
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
Subject: [PATCH 34/46] dmaengine: mxs-dma: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:20:04 +0800
Message-Id: <20180803072016.21544-35-sjhuang@iluvatar.ai>
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
 drivers/dma/mxs-dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index ae5182ff0128..35193b31a9e0 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -847,7 +847,7 @@ static int __init mxs_dma_probe(struct platform_device *pdev)
 	mxs_dma->dma_device.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 	mxs_dma->dma_device.device_issue_pending = mxs_dma_enable_chan;
 
-	ret = dma_async_device_register(&mxs_dma->dma_device);
+	ret = dmaenginem_async_device_register(&mxs_dma->dma_device);
 	if (ret) {
 		dev_err(mxs_dma->dma_device.dev, "unable to register\n");
 		return ret;
@@ -857,7 +857,6 @@ static int __init mxs_dma_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(mxs_dma->dma_device.dev,
 			"failed to register controller\n");
-		dma_async_device_unregister(&mxs_dma->dma_device);
 	}
 
 	dev_info(mxs_dma->dma_device.dev, "initialized\n");
-- 
2.17.1

