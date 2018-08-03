Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199F1C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD790216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="NDA6ue//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD790216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732735AbeHCJQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:16:47 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:58213 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729792AbeHCJQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id B3259145043FF;
        Fri,  3 Aug 2018 15:25:09 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ZihNdxV5xzk7; Fri,  3 Aug 2018 15:25:08 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id C8FE4145043F5;
        Fri,  3 Aug 2018 15:25:08 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai C8FE4145043F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281108;
        bh=MIDct06K7D3I+nNx9snOLVORGB+I4sXowbtdn7FRzIA=;
        h=From:To:Subject:Date:Message-Id;
        b=NDA6ue//yU8oQGHglIQILXocid84co2jfpNOq6v5Mxs+al8P+LnQamlkEe1QhxQmr
         z9FC+ClIMykJA02yGMqAQwft0hfAQtx0mzuN+gEby+K8aeGTV0Zm/jrWjqxbUoGfuz
         2ZyPD0MyifvF4Vw3wAxzpiThSiwgk2oahI9Ln00c=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0Qbw3UhO52Md; Fri,  3 Aug 2018 15:25:08 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 64575145043E5;
        Fri,  3 Aug 2018 15:25:08 +0800 (CST)
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
Subject: [PATCH 24/46] dmaengine: nbpfaxi: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:19:54 +0800
Message-Id: <20180803072016.21544-25-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180803072016.21544-1-sjhuang@iluvatar.ai>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dmaenginem_async_device_register to simplify the code:
	remove dma_async_device_unregister.
	remove label e_dma_dev_unreg

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 drivers/dma/nbpfaxi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
index 8c7b2e8703da..def82e77f321 100644
--- a/drivers/dma/nbpfaxi.c
+++ b/drivers/dma/nbpfaxi.c
@@ -1437,18 +1437,16 @@ static int nbpf_probe(struct platform_device *pdev)
 
 	nbpf_configure(nbpf);
 
-	ret = dma_async_device_register(dma_dev);
+	ret = dmaenginem_async_device_register(dma_dev);
 	if (ret < 0)
 		goto e_clk_off;
 
 	ret = of_dma_controller_register(np, nbpf_of_xlate, nbpf);
 	if (ret < 0)
-		goto e_dma_dev_unreg;
+		goto e_clk_off;
 
 	return 0;
 
-e_dma_dev_unreg:
-	dma_async_device_unregister(dma_dev);
 e_clk_off:
 	clk_disable_unprepare(nbpf->clk);
 
@@ -1471,7 +1469,6 @@ static int nbpf_remove(struct platform_device *pdev)
 	}
 
 	of_dma_controller_free(pdev->dev.of_node);
-	dma_async_device_unregister(&nbpf->dma_dev);
 	clk_disable_unprepare(nbpf->clk);
 
 	return 0;
-- 
2.17.1

