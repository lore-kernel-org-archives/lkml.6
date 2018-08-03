Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04C4C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8447E215F9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="vOCoo3PW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8447E215F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732752AbeHCJUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:20:06 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:57164 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732037AbeHCJQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 34B28145043F6;
        Fri,  3 Aug 2018 15:25:12 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cEm1KUxuKtZo; Fri,  3 Aug 2018 15:25:11 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id C64C2145043F3;
        Fri,  3 Aug 2018 15:25:11 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai C64C2145043F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281111;
        bh=pte43Blx/ULsRNdZYeg/TR9QXeb2ZlzdXvZnohLoGWw=;
        h=From:To:Subject:Date:Message-Id;
        b=vOCoo3PWY1xVBRMBOkxuZg46Y5Vq6VK8LvEC137M7LQcUF0DjTDf5jcdJM9amO5Iz
         Gq8kWBTyv8Oshu/Ad+cmrFA9tF2SGMVKKxzGCRYNkscYEoUWZZFBZSGINzplEHdd3u
         xGlftQJkEilEJ6z76Hdo8MTTiNENfoqZL0DUTl78=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id h1zZD5SB2GLL; Fri,  3 Aug 2018 15:25:11 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id C99AE145043F5;
        Fri,  3 Aug 2018 15:25:10 +0800 (CST)
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
Subject: [PATCH 27/46] dmaengine: usb-dmac: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:19:57 +0800
Message-Id: <20180803072016.21544-28-sjhuang@iluvatar.ai>
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
 drivers/dma/sh/usb-dmac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
index 1bb1a8e09025..c09d7c65c2c5 100644
--- a/drivers/dma/sh/usb-dmac.c
+++ b/drivers/dma/sh/usb-dmac.c
@@ -849,7 +849,7 @@ static int usb_dmac_probe(struct platform_device *pdev)
 	engine->device_tx_status = usb_dmac_tx_status;
 	engine->device_issue_pending = usb_dmac_issue_pending;
 
-	ret = dma_async_device_register(engine);
+	ret = dmaenginem_async_device_register(engine);
 	if (ret < 0)
 		goto error;
 
@@ -879,7 +879,6 @@ static int usb_dmac_remove(struct platform_device *pdev)
 	for (i = 0; i < dmac->n_channels; ++i)
 		usb_dmac_chan_remove(dmac, &dmac->channels[i]);
 	of_dma_controller_free(pdev->dev.of_node);
-	dma_async_device_unregister(&dmac->engine);
 
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.17.1

