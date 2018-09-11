Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232B9C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D6B20880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IgdQcMKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D6B20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbeIKThM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:37:12 -0400
Received: from m12-15.163.com ([220.181.12.15]:47252 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbeIKThM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=UPb7GCKMfSRQrOB6Qr
        Q1HTVXT8DJ4BMbTI4/8eD4G+k=; b=IgdQcMKuu0s7HkD+igHfGqmjioh/o1xrYp
        LO30q/duB+ui3oh0D3RGultSEdxf/q6H2sgfCeseyrMnIwCLijowaH+bCvcjAh7X
        VSKtYMdmDy23MnUyeO9Naws3mCJVFNBaBEcekDJ5p/TLU4mqWl5rpbI6Bn15srr1
        /c70RG0rk=
Received: from localhost (unknown [183.134.187.192])
        by smtp11 (Coremail) with SMTP id D8CowAAnrNEo05dbWuCMGw--.5989S5;
        Tue, 11 Sep 2018 22:37:29 +0800 (CST)
From:   jun qian <hangdianqj@163.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        jun qian <hangdianqj@163.com>, Barry song <21cnbao@gmail.com>
Subject: [PATCH] dmaengine: idma64: replace spin_lock_irqsave with spin_lock in ISR
Date:   Tue, 11 Sep 2018 07:37:27 -0700
Message-Id: <20180911143727.53147-1-hangdianqj@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: D8CowAAnrNEo05dbWuCMGw--.5989S5
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr1rAF4xAFyfGw18XF1UWrg_yoWkWrg_tF
        4Uury7JrnIyr1Ykr18Jrn8GFyIkw4DXF18G3Z2ya1ayF90qwn8JrWDXrn5Ar1UZa1Uur90
        9ryq9FyfK342gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUlfO3UUUUU==
X-Originating-IP: [183.134.187.192]
X-CM-SenderInfo: pkdqwvpldq1yi6rwjhhfrp/1tbiUQm+R1WBHxvCbAAAsf
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As you are already in ISR, it is unnecessary to call spin_lock_irqsave.

Signed-off-by: jun qian <hangdianqj@163.com>
Cc: Barry song <21cnbao@gmail.com>
---
 drivers/dma/idma64.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index 1fbf9cb9b742..5b9c1566ad73 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -142,9 +142,8 @@ static void idma64_chan_irq(struct idma64 *idma64, unsigned short c,
 {
 	struct idma64_chan *idma64c = &idma64->chan[c];
 	struct idma64_desc *desc;
-	unsigned long flags;
 
-	spin_lock_irqsave(&idma64c->vchan.lock, flags);
+	spin_lock(&idma64c->vchan.lock);
 	desc = idma64c->desc;
 	if (desc) {
 		if (status_err & (1 << c)) {
@@ -161,7 +160,7 @@ static void idma64_chan_irq(struct idma64 *idma64, unsigned short c,
 		if (idma64c->desc == NULL || desc->status == DMA_ERROR)
 			idma64_stop_transfer(idma64c);
 	}
-	spin_unlock_irqrestore(&idma64c->vchan.lock, flags);
+	spin_unlock(&idma64c->vchan.lock);
 }
 
 static irqreturn_t idma64_irq(int irq, void *dev)
-- 
2.17.1



