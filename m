Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A34C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF63A216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="GzzM0bro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF63A216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732774AbeHCJQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:16:49 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:58241 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732649AbeHCJQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id B26DF145043FD;
        Fri,  3 Aug 2018 15:25:11 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 05L9LKppd-4y; Fri,  3 Aug 2018 15:25:10 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 3C27A14504407;
        Fri,  3 Aug 2018 15:25:10 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai 3C27A14504407
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281110;
        bh=tCNaotTdSqbGTfT8OB8f2ujghYiT6G00YFSCojxCDi4=;
        h=From:To:Subject:Date:Message-Id;
        b=GzzM0broSo02Lyqc0ApOFE6mQ5Niltv+2xGDxHSI3cno3hp1KcCfPNkcPvMZb06Ad
         HvpPOAbo84ym1hiQOkIEQBbQEN9RFyzWTw9Vd9lUZo+SIXMncni7OH0e/kb1+4+4hT
         8/BXV5nBkGC3HObjD1dFG3NbSNKYpi/rCI2qs6aQ=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BMiyBOIkuFOQ; Fri,  3 Aug 2018 15:25:10 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 4FC8A145043FD;
        Fri,  3 Aug 2018 15:25:09 +0800 (CST)
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
Subject: [PATCH 26/46] dmaengine: shdmac: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:19:56 +0800
Message-Id: <20180803072016.21544-27-sjhuang@iluvatar.ai>
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
 drivers/dma/sh/shdmac.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index 04a74e0a95b7..52060cd21e79 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -866,7 +866,7 @@ static int sh_dmae_probe(struct platform_device *pdev)
 
 	pm_runtime_put(&pdev->dev);
 
-	err = dma_async_device_register(&shdev->shdma_dev.dma_dev);
+	err = dmaenginem_async_device_register(&shdev->shdma_dev.dma_dev);
 	if (err < 0)
 		goto edmadevreg;
 
@@ -897,9 +897,6 @@ static int sh_dmae_probe(struct platform_device *pdev)
 static int sh_dmae_remove(struct platform_device *pdev)
 {
 	struct sh_dmae_device *shdev = platform_get_drvdata(pdev);
-	struct dma_device *dma_dev = &shdev->shdma_dev.dma_dev;
-
-	dma_async_device_unregister(dma_dev);
 
 	spin_lock_irq(&sh_dmae_lock);
 	list_del_rcu(&shdev->node);
-- 
2.17.1

