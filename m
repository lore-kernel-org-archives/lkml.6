Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755B9C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFAD215F9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="Ehjo6eMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFAD215F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733011AbeHCJTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:19:49 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:58124 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732459AbeHCJQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 415A0145043E0;
        Fri,  3 Aug 2018 15:25:06 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id avnzggResGyn; Fri,  3 Aug 2018 15:25:06 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id D38CC140B5B36;
        Fri,  3 Aug 2018 15:25:05 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai D38CC140B5B36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281105;
        bh=vcDaDJOSDa3hN9eZg/GV29baml3jT4+orzxm4WstkYk=;
        h=From:To:Subject:Date:Message-Id;
        b=Ehjo6eMUKCCZ06GV4uFkLaAglPxfsqRoTr9vSVEuu4EXxnHLRmdAPef5KCr96v9o3
         kTt99bkwu9jfsbmL+CtGUqZuwRb6zrQvTSKOtBUMhToYQW3PX5td1jmkA2Y63g5TfT
         1fbGBMkMbXUF/Oo7K+sQGV87DnNdljAByVDuK/EA=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id owEe3doObIDK; Fri,  3 Aug 2018 15:25:05 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 167EA107081ED;
        Fri,  3 Aug 2018 15:25:05 +0800 (CST)
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
Subject: [PATCH 19/46] dmaengine: sprd-dma: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:19:49 +0800
Message-Id: <20180803072016.21544-20-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180803072016.21544-1-sjhuang@iluvatar.ai>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dmaenginem_async_device_register to simplify the code:
	remove dma_async_device_unregister.
	remove label err_of_register

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 drivers/dma/sprd-dma.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 55df0d41355b..d06459d1f96f 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -943,7 +943,7 @@ static int sprd_dma_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_rpm;
 
-	ret = dma_async_device_register(&sdev->dma_dev);
+	ret = dmaenginem_async_device_register(&sdev->dma_dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "register dma device failed:%d\n", ret);
 		goto err_register;
@@ -953,13 +953,11 @@ static int sprd_dma_probe(struct platform_device *pdev)
 	ret = of_dma_controller_register(np, of_dma_simple_xlate,
 					 &sprd_dma_info);
 	if (ret)
-		goto err_of_register;
+		goto err_register;
 
 	pm_runtime_put(&pdev->dev);
 	return 0;
 
-err_of_register:
-	dma_async_device_unregister(&sdev->dma_dev);
 err_register:
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
@@ -989,7 +987,6 @@ static int sprd_dma_remove(struct platform_device *pdev)
 	}
 
 	of_dma_controller_free(pdev->dev.of_node);
-	dma_async_device_unregister(&sdev->dma_dev);
 	sprd_dma_disable(sdev);
 
 	pm_runtime_put_noidle(&pdev->dev);
-- 
2.17.1

