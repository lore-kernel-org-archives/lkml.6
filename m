Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57500C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DAAD20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DtcGb+uy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DAAD20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbeIKTYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:24:47 -0400
Received: from m12-17.163.com ([220.181.12.17]:51053 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbeIKTYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=AyLh+c76afFa8cklIW
        H20lxnUL4lMkkmfDk/IJ3Ux7w=; b=DtcGb+uyB12XHv3MMMK9ETeMDpeQ7mgkR9
        I26qJoTsVTjjyoycXywbEJ7OuZzd81h5lVBSZCWL+X7HCbonvK3V/c60YuZhFpiv
        aZMhTOKvW4vgVND/mGX257C0t6360f4lNy5SFNyLRmgOD/uh3Gt41a1iPC8xFfeD
        nHN90ra08=
Received: from localhost (unknown [183.134.187.192])
        by smtp13 (Coremail) with SMTP id EcCowADnobtB0JdbhsF2AA--.5532S5;
        Tue, 11 Sep 2018 22:25:07 +0800 (CST)
From:   jun qian <hangdianqj@163.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        jun qian <hangdianqj@163.com>, Barry song <21cnbao@gmail.com>
Subject: [PATCH] dmaengine: k3dma: replace spin_lock_irqsave with spin_lock in ISR
Date:   Tue, 11 Sep 2018 07:25:05 -0700
Message-Id: <20180911142505.52710-1-hangdianqj@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EcCowADnobtB0JdbhsF2AA--.5532S5
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr1rAF4xAFyfGw18XF1UWrg_yoWktFb_uF
        48WFZ3J390kw1jyw10y398Gw1UKanYqFn3Wr4vkay3XryYvF9YgrW8Xrn5Z3s8ua1xC39x
        Cr1YvFn7ury2gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUJUU5UUUUU==
X-Originating-IP: [183.134.187.192]
X-CM-SenderInfo: pkdqwvpldq1yi6rwjhhfrp/1tbiNx6+R1WBZCdrogAAsO
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As you are already in ISR, it is unnecessary to call spin_lock_irqsave.

Signed-off-by: jun qian <hangdianqj@163.com>
Cc: Barry song <21cnbao@gmail.com>
---
 drivers/dma/k3dma.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index 6bfa217ed6d0..30052258ffd5 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -216,22 +216,21 @@ static irqreturn_t k3_dma_int_handler(int irq, void *dev_id)
 		i = __ffs(stat);
 		stat &= ~BIT(i);
 		if (likely(tc1 & BIT(i)) || (tc2 & BIT(i))) {
-			unsigned long flags;
 
 			p = &d->phy[i];
 			c = p->vchan;
 			if (c && (tc1 & BIT(i))) {
-				spin_lock_irqsave(&c->vc.lock, flags);
+				spin_lock(&c->vc.lock);
 				vchan_cookie_complete(&p->ds_run->vd);
 				p->ds_done = p->ds_run;
 				p->ds_run = NULL;
-				spin_unlock_irqrestore(&c->vc.lock, flags);
+				spin_unlock(&c->vc.lock);
 			}
 			if (c && (tc2 & BIT(i))) {
-				spin_lock_irqsave(&c->vc.lock, flags);
+				spin_lock(&c->vc.lock);
 				if (p->ds_run != NULL)
 					vchan_cyclic_callback(&p->ds_run->vd);
-				spin_unlock_irqrestore(&c->vc.lock, flags);
+				spin_unlock(&c->vc.lock);
 			}
 			irq_chan |= BIT(i);
 		}
-- 
2.17.1



