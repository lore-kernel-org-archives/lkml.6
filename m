Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38192C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04BF215F9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="gMXiRZU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04BF215F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732535AbeHCJQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:16:33 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:58139 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732424AbeHCJQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 151D1145043ED;
        Fri,  3 Aug 2018 15:25:08 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id yhSkQc7kYrmS; Fri,  3 Aug 2018 15:25:07 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 8EAFA145043EA;
        Fri,  3 Aug 2018 15:25:07 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai 8EAFA145043EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281107;
        bh=ejI9XChtJpbB5/46gl8gx4n8gFnpPKkCC/37oVfT2DE=;
        h=From:To:Subject:Date:Message-Id;
        b=gMXiRZU6VryuZbZYblIIQtf/7KlXdZiJccGSsTw/JtkZ2DAm9mqabYMFayk2FLLcl
         UJ34GAGA65dTuYKvv3C4ivBwkg7ftDXOU78X0lCxPsGvZIcrmWu0/LHib1RNfw4zS/
         o2TyfQbAN2hSx13Jqzpw7fRrtOyKyvs4+ck5e+yI=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Smf9vVHJK4BW; Fri,  3 Aug 2018 15:25:07 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 280E9145043E1;
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
Subject: [PATCH 22/46] dmaengine: sudmac: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:19:52 +0800
Message-Id: <20180803072016.21544-23-sjhuang@iluvatar.ai>
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
 drivers/dma/sh/sudmac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/sh/sudmac.c b/drivers/dma/sh/sudmac.c
index 69b9564dc9d9..f861067edef4 100644
--- a/drivers/dma/sh/sudmac.c
+++ b/drivers/dma/sh/sudmac.c
@@ -376,7 +376,7 @@ static int sudmac_probe(struct platform_device *pdev)
 			goto chan_probe_err;
 	}
 
-	err = dma_async_device_register(&su_dev->shdma_dev.dma_dev);
+	err = dmaenginem_async_device_register(&su_dev->shdma_dev.dma_dev);
 	if (err < 0)
 		goto chan_probe_err;
 
@@ -393,9 +393,7 @@ static int sudmac_probe(struct platform_device *pdev)
 static int sudmac_remove(struct platform_device *pdev)
 {
 	struct sudmac_device *su_dev = platform_get_drvdata(pdev);
-	struct dma_device *dma_dev = &su_dev->shdma_dev.dma_dev;
 
-	dma_async_device_unregister(dma_dev);
 	sudmac_chan_remove(su_dev);
 	shdma_cleanup(&su_dev->shdma_dev);
 
-- 
2.17.1

