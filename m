Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095F2C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC27C215F9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="Z/3ficrO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC27C215F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732864AbeHCJTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:19:40 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:57719 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732044AbeHCJQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 09A33107081DE;
        Fri,  3 Aug 2018 15:25:04 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ggSJB_oDoFxx; Fri,  3 Aug 2018 15:25:03 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 220A7107081F8;
        Fri,  3 Aug 2018 15:25:03 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai 220A7107081F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281103;
        bh=Ow36zmdsQYZfWnD3zRukEJCZssrqFsof9z2X7IRzgbE=;
        h=From:To:Subject:Date:Message-Id;
        b=Z/3ficrOVbuMs0KcFpEu2lxDJ1ZyESta9v6MiT49YDHijVs8pxWXXQt04nyNxz3Ck
         XwcSXMqLE5Si75ZKWm0DkwDLbrHfpzzDPp0yp9bDzxav0YrljRbkLnO2GLYZB5fTHX
         Dp4EyrhhPNx0hnzh0XRd8ebY+duhV7r3d7zEqfM8=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id H_bEighWJhIa; Fri,  3 Aug 2018 15:25:03 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 308F1107081DB;
        Fri,  3 Aug 2018 15:25:02 +0800 (CST)
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
Subject: [PATCH 15/46] dmaengine: s3c24xx-dma: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:19:45 +0800
Message-Id: <20180803072016.21544-16-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180803072016.21544-1-sjhuang@iluvatar.ai>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dmaenginem_async_device_register to simplify the code:
	remove dma_async_device_unregister.
	remove label err_slave_reg

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 drivers/dma/s3c24xx-dma.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/s3c24xx-dma.c b/drivers/dma/s3c24xx-dma.c
index 64744eb88720..1d820c0cd14b 100644
--- a/drivers/dma/s3c24xx-dma.c
+++ b/drivers/dma/s3c24xx-dma.c
@@ -1330,7 +1330,7 @@ static int s3c24xx_dma_probe(struct platform_device *pdev)
 		goto err_slave;
 	}
 
-	ret = dma_async_device_register(&s3cdma->memcpy);
+	ret = dmaenginem_async_device_register(&s3cdma->memcpy);
 	if (ret) {
 		dev_warn(&pdev->dev,
 			"%s failed to register memcpy as an async device - %d\n",
@@ -1338,12 +1338,12 @@ static int s3c24xx_dma_probe(struct platform_device *pdev)
 		goto err_memcpy_reg;
 	}
 
-	ret = dma_async_device_register(&s3cdma->slave);
+	ret = dmaenginem_async_device_register(&s3cdma->slave);
 	if (ret) {
 		dev_warn(&pdev->dev,
 			"%s failed to register slave as an async device - %d\n",
 			__func__, ret);
-		goto err_slave_reg;
+		goto err_memcpy_reg;
 	}
 
 	platform_set_drvdata(pdev, s3cdma);
@@ -1352,8 +1352,6 @@ static int s3c24xx_dma_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_slave_reg:
-	dma_async_device_unregister(&s3cdma->memcpy);
 err_memcpy_reg:
 	s3c24xx_dma_free_virtual_channels(&s3cdma->slave);
 err_slave:
@@ -1388,9 +1386,6 @@ static int s3c24xx_dma_remove(struct platform_device *pdev)
 	struct soc_data *sdata = s3c24xx_dma_get_soc_data(pdev);
 	int i;
 
-	dma_async_device_unregister(&s3cdma->slave);
-	dma_async_device_unregister(&s3cdma->memcpy);
-
 	s3c24xx_dma_free_irq(pdev, s3cdma);
 
 	s3c24xx_dma_free_virtual_channels(&s3cdma->slave);
-- 
2.17.1

