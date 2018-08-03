Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8517CC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFCB215F9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="FXA/9YJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CFCB215F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732513AbeHCJQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:16:33 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:57627 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727811AbeHCJQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 5B99B107081E8;
        Fri,  3 Aug 2018 15:25:02 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Cl0IAuMk5LhC; Fri,  3 Aug 2018 15:25:02 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 25607107081D1;
        Fri,  3 Aug 2018 15:25:01 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai 25607107081D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281101;
        bh=2Wl9tdroIJqJALsEWvvhvKhC1PI5MGOFbNV/MalC9cQ=;
        h=From:To:Subject:Date:Message-Id;
        b=FXA/9YJ05WyceDvlm4fTF8x+ph8nPC1A17HeNZOkKMxAfxdcgX4wSeiLDjWr8f5iT
         4AeIKOWFqvlmeiDMWwt0H/O73ywSffmGI+6zTl+ZszcYC49m+YnprFwlna5kHCrdOv
         pifVf6N4OJdP05JGJTsxBNg15yytHN2Uy2xlKWOU=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5t74v1Xazy-I; Fri,  3 Aug 2018 15:25:01 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 025F8107081CD;
        Fri,  3 Aug 2018 15:24:58 +0800 (CST)
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
Subject: [PATCH 13/46] dmaengine: sun4i-dma: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:19:43 +0800
Message-Id: <20180803072016.21544-14-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180803072016.21544-1-sjhuang@iluvatar.ai>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dmaenginem_async_device_register to simplify the code:
   remove dma_async_device_unregister
   remove label err_dma_unregister

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 drivers/dma/sun4i-dma.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index f4ed3f17607c..c80a59c1fc38 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -1228,7 +1228,7 @@ static int sun4i_dma_probe(struct platform_device *pdev)
 		goto err_clk_disable;
 	}
 
-	ret = dma_async_device_register(&priv->slave);
+	ret = dmaenginem_async_device_register(&priv->slave);
 	if (ret) {
 		dev_warn(&pdev->dev, "Failed to register DMA engine device\n");
 		goto err_clk_disable;
@@ -1238,15 +1238,13 @@ static int sun4i_dma_probe(struct platform_device *pdev)
 					 priv);
 	if (ret) {
 		dev_err(&pdev->dev, "of_dma_controller_register failed\n");
-		goto err_dma_unregister;
+		goto err_clk_disable;
 	}
 
 	dev_dbg(&pdev->dev, "Successfully probed SUN4I_DMA\n");
 
 	return 0;
 
-err_dma_unregister:
-	dma_async_device_unregister(&priv->slave);
 err_clk_disable:
 	clk_disable_unprepare(priv->clk);
 	return ret;
@@ -1260,7 +1258,6 @@ static int sun4i_dma_remove(struct platform_device *pdev)
 	disable_irq(priv->irq);
 
 	of_dma_controller_free(pdev->dev.of_node);
-	dma_async_device_unregister(&priv->slave);
 
 	clk_disable_unprepare(priv->clk);
 
-- 
2.17.1

