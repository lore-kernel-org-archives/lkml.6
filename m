Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AB6C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4C92172D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="lU9bnVzt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4C92172D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732573AbeHCJQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:16:35 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:57209 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732189AbeHCJQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 12ABF107081D4;
        Fri,  3 Aug 2018 15:25:05 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wlplvU3QaoJ7; Fri,  3 Aug 2018 15:25:04 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id B0A21107081E5;
        Fri,  3 Aug 2018 15:25:04 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai B0A21107081E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281104;
        bh=kAT7hdz1/c/kUv3J+HigDrxi1unz0rwsArvtG4ZSK48=;
        h=From:To:Subject:Date:Message-Id;
        b=lU9bnVztzFC7McuKr+Iw4SwQHat+aanZfJenoNaUdibtR7eT8+BPKOgSOwc+oO9po
         PmVlE8IKVOtYpyaugQC/LcdJNfg7fmEAkWNX+/SEKJIe/483Tu66EK91jBD70M1ivN
         wnL9FaYTUvnpqrtz9M1bFgKr9GUSqpys0pWKtGBY=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BH673FF6TXwq; Fri,  3 Aug 2018 15:25:04 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id C780D107081D4;
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
Subject: [PATCH 17/46] dmaengine: stm32-mdma: use dmaenginem_async_device_register to simplify the code
Date:   Fri,  3 Aug 2018 15:19:47 +0800
Message-Id: <20180803072016.21544-18-sjhuang@iluvatar.ai>
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
 drivers/dma/stm32-mdma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index 06dd1725375e..390e4cae0e1a 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -1656,7 +1656,7 @@ static int stm32_mdma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = dma_async_device_register(dd);
+	ret = dmaenginem_async_device_register(dd);
 	if (ret)
 		return ret;
 
@@ -1674,8 +1674,6 @@ static int stm32_mdma_probe(struct platform_device *pdev)
 	return 0;
 
 err_unregister:
-	dma_async_device_unregister(dd);
-
 	return ret;
 }
 
-- 
2.17.1

