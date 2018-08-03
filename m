Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2173C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6560216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="WOjgy5gz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6560216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbeHCJQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:16:44 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:57210 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732423AbeHCJQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 76F26107081ED;
        Fri,  3 Aug 2018 15:25:15 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id pjuNEn1BXXDP; Fri,  3 Aug 2018 15:25:15 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id D46F41450441E;
        Fri,  3 Aug 2018 15:25:14 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai D46F41450441E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281114;
        bh=Sqfrl7Ojt0xjPSw4q5Us2rESf0dIPYLXdnwTkSqSbO4=;
        h=From:To:Subject:Date:Message-Id;
        b=WOjgy5gzBnUsjpw0kBSE1KOReW3/qvPhUgfzylkcSKn6LDCcsvK7OBjxh7v6Rv1ev
         pgaWHqRusQP9hS7dhBfkrz2aZ30cS4OhZhJT67V8t0i8mTIRg7mp5V1J8AitGNxUzW
         J9vsujvEaELayMVNJotibon5ICY9rrv13b//WU7s=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ta4LdwZ_2w59; Fri,  3 Aug 2018 15:25:14 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 5CFAA1450440C;
        Fri,  3 Aug 2018 15:25:13 +0800 (CST)
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
Subject: [PATCH 29/46] dmaengine: hidma: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:19:59 +0800
Message-Id: <20180803072016.21544-30-sjhuang@iluvatar.ai>
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
 drivers/dma/qcom/hidma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 43d4b00b8138..1d8130edea58 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -877,7 +877,7 @@ static int hidma_probe(struct platform_device *pdev)
 	if (rc)
 		goto uninit;
 
-	rc = dma_async_device_register(&dmadev->ddev);
+	rc = dmaenginem_async_device_register(&dmadev->ddev);
 	if (rc)
 		goto uninit;
 
@@ -924,7 +924,6 @@ static int hidma_remove(struct platform_device *pdev)
 	struct hidma_dev *dmadev = platform_get_drvdata(pdev);
 
 	pm_runtime_get_sync(dmadev->ddev.dev);
-	dma_async_device_unregister(&dmadev->ddev);
 	if (!dmadev->lldev->msi_support)
 		devm_free_irq(dmadev->ddev.dev, dmadev->irq, dmadev->lldev);
 	else
-- 
2.17.1

