Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D47EC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3555C216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="QQHQVUWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3555C216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732688AbeHCJQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:16:46 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:58562 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732423AbeHCJQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 295AE1450440A;
        Fri,  3 Aug 2018 15:25:16 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Bfu6Ffp2WxfK; Fri,  3 Aug 2018 15:25:15 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id CF7BE14504414;
        Fri,  3 Aug 2018 15:25:15 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai CF7BE14504414
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281115;
        bh=HliJq+/uUFwV1AE8KSSlvTLy4bv3cU7FKfsNTt8PeI4=;
        h=From:To:Subject:Date:Message-Id;
        b=QQHQVUWw2piJQrcd/JWSqCw6qqXFLues7nrUTdY+J0Du7eCQGUoWJDZC3z6s5qBEH
         hVuqA+0fYcSOIq2OU+0DWqUMWPmaKuNuXTSPdVB9bnbYWPQ8vtukGm8k3ItMTcW2MJ
         JpfcTrWD8dTMW+ozRYwKi9F6tNW0JqkhY1kM1br0=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nwlm95gPp_BG; Fri,  3 Aug 2018 15:25:15 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id A78FC1450440A;
        Fri,  3 Aug 2018 15:25:14 +0800 (CST)
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
Subject: [PATCH 30/46] dmaengine: pxa_dma: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:20:00 +0800
Message-Id: <20180803072016.21544-31-sjhuang@iluvatar.ai>
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
 drivers/dma/pxa_dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index b31c28b67ad3..21001ea078fb 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -1285,7 +1285,6 @@ static int pxad_remove(struct platform_device *op)
 
 	pxad_cleanup_debugfs(pdev);
 	pxad_free_channels(&pdev->slave);
-	dma_async_device_unregister(&pdev->slave);
 	return 0;
 }
 
@@ -1396,7 +1395,7 @@ static int pxad_init_dmadev(struct platform_device *op,
 		init_waitqueue_head(&c->wq_state);
 	}
 
-	return dma_async_device_register(&pdev->slave);
+	return dmaenginem_async_device_register(&pdev->slave);
 }
 
 static int pxad_probe(struct platform_device *op)
-- 
2.17.1

