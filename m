Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3B2C46463
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494892172B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="fX+cHGOM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494892172B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbeHCJQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:16:16 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:57165 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727860AbeHCJQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id B313B107081C3;
        Fri,  3 Aug 2018 15:24:52 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ySt_aobsaY1l; Fri,  3 Aug 2018 15:24:52 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 5382D107081C0;
        Fri,  3 Aug 2018 15:24:52 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai 5382D107081C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281092;
        bh=AuYl1ulqWH7OcoD9TefNAwqylFfF8nf6isSlVfTBlXc=;
        h=From:To:Subject:Date:Message-Id;
        b=fX+cHGOMOWxAnXSkOHM8gPQSuJIUo3OzAllPRnHxBlf7iKuBu1nzkBI5XEFRo3DH4
         E7dfJpZpWIzMSqNlnpMC176DwetgyXPyKQWdSJFSZyANE+K6mo3g+plVtkjDyt3s/z
         Gi8gNwYp5NbSCNCcFgxJQvIiSdiHCeWzCzm/f8aE=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Y1yumzJzBsEl; Fri,  3 Aug 2018 15:24:52 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 19E5F13ED1C92;
        Fri,  3 Aug 2018 15:24:51 +0800 (CST)
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
Subject: [PATCH 05/46] dmaengine: txx9dmac: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:19:35 +0800
Message-Id: <20180803072016.21544-6-sjhuang@iluvatar.ai>
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
 drivers/dma/txx9dmac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/txx9dmac.c b/drivers/dma/txx9dmac.c
index eb45af71d3a3..1e97bee485d7 100644
--- a/drivers/dma/txx9dmac.c
+++ b/drivers/dma/txx9dmac.c
@@ -1147,7 +1147,7 @@ static int __init txx9dmac_chan_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, dc);
 
-	err = dma_async_device_register(&dc->dma);
+	err = dmaenginem_async_device_register(&dc->dma);
 	if (err)
 		return err;
 	dev_dbg(&pdev->dev, "TXx9 DMA Channel (dma%d%s%s)\n",
@@ -1162,8 +1162,6 @@ static int txx9dmac_chan_remove(struct platform_device *pdev)
 {
 	struct txx9dmac_chan *dc = platform_get_drvdata(pdev);
 
-
-	dma_async_device_unregister(&dc->dma);
 	if (dc->irq >= 0) {
 		devm_free_irq(&pdev->dev, dc->irq, dc);
 		tasklet_kill(&dc->tasklet);
-- 
2.17.1

