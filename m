Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EBCC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA172086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="p+6c/OoM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA172086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbeIKTcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:32:53 -0400
Received: from m12-18.163.com ([220.181.12.18]:42145 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727231AbeIKTcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=7MFUDwA9j6qQBSC9WR
        ytxqLZFLN9HWCKF7WtSMmDbMQ=; b=p+6c/OoMlOBO4Iju2GQ3YF6F5OUU/utfwH
        uVsIrLkjVc14yCWjrJ8TICfx3YSIU+SiUMQN6UXYd3cG7FrwKT7X38nkcj/ZLqjV
        tGYUxBxURVz+tCarGxJ2OUVMNcSsuQklQbMl1mURMiGIV36qysXvkEKVBzXUfmzE
        0vzdp1VM8=
Received: from localhost (unknown [183.134.187.192])
        by smtp14 (Coremail) with SMTP id EsCowADHuwzl0ZdbEJfCSw--.47011S5;
        Tue, 11 Sep 2018 22:32:07 +0800 (CST)
From:   jun qian <hangdianqj@163.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Jun Nie <jun.nie@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, jun qian <hangdianqj@163.com>,
        Barry song <21cnbao@gmail.com>
Subject: [PATCH] dmaengine: zx-dma: replace spin_lock_irqsave with spin_lock in ISR
Date:   Tue, 11 Sep 2018 07:31:58 -0700
Message-Id: <20180911143158.52917-1-hangdianqj@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EsCowADHuwzl0ZdbEJfCSw--.47011S5
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr1rAF4xAFyfGw18XF1UWrg_yoWfuwc_uF
        48ur97Gwn8Cw1jyw18Zr13C3429as5XFn7Ww4I9ay3WrW5Zr95X3ykXw1kW34DZF4kCwnI
        kryYvFyxuF129jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjJ3vUUUUUU==
X-Originating-IP: [183.134.187.192]
X-CM-SenderInfo: pkdqwvpldq1yi6rwjhhfrp/1tbiRAe+R1SIX4ZnXQAAsF
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As you are already in ISR, it is unnecessary to call spin_lock_irqsave.

Signed-off-by: jun qian <hangdianqj@163.com>
Cc: Barry song <21cnbao@gmail.com>
---
 drivers/dma/zx_dma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/zx_dma.c b/drivers/dma/zx_dma.c
index 2571bc7693df..111ab2db83b1 100644
--- a/drivers/dma/zx_dma.c
+++ b/drivers/dma/zx_dma.c
@@ -288,9 +288,8 @@ static irqreturn_t zx_dma_int_handler(int irq, void *dev_id)
 		p = &d->phy[i];
 		c = p->vchan;
 		if (c) {
-			unsigned long flags;
 
-			spin_lock_irqsave(&c->vc.lock, flags);
+			spin_lock(&c->vc.lock);
 			if (c->cyclic) {
 				vchan_cyclic_callback(&p->ds_run->vd);
 			} else {
@@ -298,7 +297,7 @@ static irqreturn_t zx_dma_int_handler(int irq, void *dev_id)
 				p->ds_done = p->ds_run;
 				task = 1;
 			}
-			spin_unlock_irqrestore(&c->vc.lock, flags);
+			spin_unlock(&c->vc.lock);
 			irq_chan |= BIT(i);
 		}
 	}
-- 
2.17.1



