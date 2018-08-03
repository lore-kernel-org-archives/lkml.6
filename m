Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA5FC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84978215F9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="XeUUvuyX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84978215F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732684AbeHCJUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:20:38 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:57165 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729808AbeHCJQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 90B1A107081CA;
        Fri,  3 Aug 2018 15:24:58 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HVC-IuNmFMX2; Fri,  3 Aug 2018 15:24:58 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 25892107081E1;
        Fri,  3 Aug 2018 15:24:58 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai 25892107081E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281098;
        bh=Z+SOxwgabn0PZIzvevtjxhyKnCRTzlMyJFOK4zpfag8=;
        h=From:To:Subject:Date:Message-Id;
        b=XeUUvuyXcXnudTcMkd0+m5u0JP6bmotanJa8ezZlTsx2usPv3G2aokN7YwehQF9kp
         m6/IYIUYXUCzxlzzyY5WHjy5gw/qcBeZwWHd9MmpsSwu69GGF0+jt2YgczNC4Jf33P
         imdSFGaBIPBv5Vyvo1nbcQN2CvZl5iUKtTK3hpyQ=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AFbxfcYPAj19; Fri,  3 Aug 2018 15:24:57 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id BBF9B107081C4;
        Fri,  3 Aug 2018 15:24:56 +0800 (CST)
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
Subject: [PATCH 11/46] dmaengine: tegra20-apb-dma: use helper dmaenginem_async_device_register
Date:   Fri,  3 Aug 2018 15:19:41 +0800
Message-Id: <20180803072016.21544-12-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180803072016.21544-1-sjhuang@iluvatar.ai>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dmaenginem_async_device_register to simplify the code:
   remove dma_async_device_unregister
   remove the label err_unregister_dma_dev

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 drivers/dma/tegra20-apb-dma.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 9a558e30c461..9f6f51abbeef 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1444,7 +1444,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	tdma->dma_dev.device_tx_status = tegra_dma_tx_status;
 	tdma->dma_dev.device_issue_pending = tegra_dma_issue_pending;
 
-	ret = dma_async_device_register(&tdma->dma_dev);
+	ret = dmaenginem_async_device_register(&tdma->dma_dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev,
 			"Tegra20 APB DMA driver registration failed %d\n", ret);
@@ -1456,15 +1456,13 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		dev_err(&pdev->dev,
 			"Tegra20 APB DMA OF registration failed %d\n", ret);
-		goto err_unregister_dma_dev;
+		goto err_irq;
 	}
 
 	dev_info(&pdev->dev, "Tegra20 APB DMA driver register %d channels\n",
 			cdata->nr_channels);
 	return 0;
 
-err_unregister_dma_dev:
-	dma_async_device_unregister(&tdma->dma_dev);
 err_irq:
 	while (--i >= 0) {
 		struct tegra_dma_channel *tdc = &tdma->channels[i];
@@ -1485,8 +1483,6 @@ static int tegra_dma_remove(struct platform_device *pdev)
 	int i;
 	struct tegra_dma_channel *tdc;
 
-	dma_async_device_unregister(&tdma->dma_dev);
-
 	for (i = 0; i < tdma->chip_data->nr_channels; ++i) {
 		tdc = &tdma->channels[i];
 		free_irq(tdc->irq, tdc);
-- 
2.17.1

