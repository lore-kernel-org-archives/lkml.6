Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7ABC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53CFE216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="Jt+jtPVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53CFE216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732456AbeHCJQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:16:29 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:57165 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729811AbeHCJQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id B2AEE145043EE;
        Fri,  3 Aug 2018 15:25:09 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id U-52KWmOzNC2; Fri,  3 Aug 2018 15:25:08 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 758CC145043F2;
        Fri,  3 Aug 2018 15:25:08 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai 758CC145043F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281108;
        bh=R2Yu2XUwLb8y9Ys11jzguBQX/2VSgq1uLgTtlHP65OY=;
        h=From:To:Subject:Date:Message-Id;
        b=Jt+jtPVINBy2CQXzF4bENqtOqvUvtWdfHRdLO0oHm/oFvnm0g/pakT5rwRrCEJKRt
         vV2qRi4/oV/Qy+FQBHGYlmjDBNqeAl1QnqfDIh/ggfymDGKB/6kc08oecYYs9v9Us9
         FLdrbfqboH4sIcnKd0A8uycrScBtEuTCi8sT8PfI=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kwfUPpbiEdOA; Fri,  3 Aug 2018 15:25:08 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id BCA94145043EE;
        Fri,  3 Aug 2018 15:25:07 +0800 (CST)
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
Subject: [PATCH 23/46] dmaengine: sa11x0-dma: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:19:53 +0800
Message-Id: <20180803072016.21544-24-sjhuang@iluvatar.ai>
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
 drivers/dma/sa11x0-dma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/sa11x0-dma.c b/drivers/dma/sa11x0-dma.c
index b31d07c7d93c..9181d6048f43 100644
--- a/drivers/dma/sa11x0-dma.c
+++ b/drivers/dma/sa11x0-dma.c
@@ -863,7 +863,7 @@ static int sa11x0_dma_init_dmadev(struct dma_device *dmadev,
 		vchan_init(&c->vc, dmadev);
 	}
 
-	return dma_async_device_register(dmadev);
+	return dmaenginem_async_device_register(dmadev);
 }
 
 static int sa11x0_dma_request_irq(struct platform_device *pdev, int nr,
@@ -987,8 +987,6 @@ static int sa11x0_dma_remove(struct platform_device *pdev)
 	struct sa11x0_dma_dev *d = platform_get_drvdata(pdev);
 	unsigned pch;
 
-	dma_async_device_unregister(&d->slave);
-
 	sa11x0_dma_free_channels(&d->slave);
 	for (pch = 0; pch < NR_PHY_CHAN; pch++)
 		sa11x0_dma_free_irq(pdev, pch, &d->phy[pch]);
-- 
2.17.1

