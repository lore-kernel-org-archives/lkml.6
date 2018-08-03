Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A935C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD182172B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="N+SaFlDi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD182172B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732557AbeHCJQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:16:34 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:57735 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728037AbeHCJQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 3F6F7107081E0;
        Fri,  3 Aug 2018 15:25:04 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id fVM2UXrjxfXz; Fri,  3 Aug 2018 15:25:04 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id D827D107081CD;
        Fri,  3 Aug 2018 15:25:03 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai D827D107081CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281103;
        bh=BKayUkDt7LxUjs0513qVAfXIf3FnhRR8RnCrBKcr6a8=;
        h=From:To:Subject:Date:Message-Id;
        b=N+SaFlDiTrv7+l9+LmbjfU59PQaYKYt9jbGFoSuSKycP9kNQ6mIubruD1UDqa7Ddy
         bi3YkuxBKf+XhNnz42KWHGuOI/gEn6WkPY0T6Rnw8xwgsCUJuesyRQxjwCCqwIw1eB
         gA1+6C++8YY8QX9tCLPyd+4/PAVRrIzfXhuVzzMo=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id G304xBUbhKNA; Fri,  3 Aug 2018 15:25:03 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 1AF84107081F1;
        Fri,  3 Aug 2018 15:25:03 +0800 (CST)
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
Subject: [PATCH 16/46] dmaengine: ste_dma40: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:19:46 +0800
Message-Id: <20180803072016.21544-17-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180803072016.21544-1-sjhuang@iluvatar.ai>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dmaenginem_async_device_register to simplify the code:
	remove dma_async_device_unregister.
	remove label unregister_slave, unregister_memcpy

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 drivers/dma/ste_dma40.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index f4edfc56f34e..5e328bd10c27 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -2839,7 +2839,7 @@ static int __init d40_dmaengine_init(struct d40_base *base,
 
 	d40_ops_init(base, &base->dma_slave);
 
-	err = dma_async_device_register(&base->dma_slave);
+	err = dmaenginem_async_device_register(&base->dma_slave);
 
 	if (err) {
 		d40_err(base->dev, "Failed to register slave channels\n");
@@ -2854,12 +2854,12 @@ static int __init d40_dmaengine_init(struct d40_base *base,
 
 	d40_ops_init(base, &base->dma_memcpy);
 
-	err = dma_async_device_register(&base->dma_memcpy);
+	err = dmaenginem_async_device_register(&base->dma_memcpy);
 
 	if (err) {
 		d40_err(base->dev,
 			"Failed to register memcpy only channels\n");
-		goto unregister_slave;
+		goto exit;
 	}
 
 	d40_chan_init(base, &base->dma_both, base->phy_chans,
@@ -2871,18 +2871,14 @@ static int __init d40_dmaengine_init(struct d40_base *base,
 	dma_cap_set(DMA_CYCLIC, base->dma_slave.cap_mask);
 
 	d40_ops_init(base, &base->dma_both);
-	err = dma_async_device_register(&base->dma_both);
+	err = dmaenginem_async_device_register(&base->dma_both);
 
 	if (err) {
 		d40_err(base->dev,
 			"Failed to register logical and physical capable channels\n");
-		goto unregister_memcpy;
+		goto exit;
 	}
 	return 0;
- unregister_memcpy:
-	dma_async_device_unregister(&base->dma_memcpy);
- unregister_slave:
-	dma_async_device_unregister(&base->dma_slave);
  exit:
 	return err;
 }
-- 
2.17.1

