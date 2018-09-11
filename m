Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CB4C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F88620839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WOrua1vb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F88620839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeIKTRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:17:35 -0400
Received: from m12-13.163.com ([220.181.12.13]:60141 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbeIKTRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=nyEYvgNqD8tRs4FIIV
        8MO3fwUUVW0ZaflZPtHRCZfK4=; b=WOrua1vbJd+XLN8SvwMDyZZfdpWCz0QuPX
        Gk4VfVCnT/BuCq8iP7VuMV9bGB+E9KNNI2h+2mibM09u8muz/216SO30vNp9IPMO
        hH6H1qvlLlnAwrKm1YYJB4DtEhEHFaAHVLkNB6qOqo0sTudSn2yewk5F+YrIpwZM
        38qUupfbo=
Received: from localhost (unknown [183.134.187.192])
        by smtp9 (Coremail) with SMTP id DcCowADHaYiPzpdbSEDMJA--.60905S5;
        Tue, 11 Sep 2018 22:17:54 +0800 (CST)
From:   jun qian <hangdianqj@163.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        jun qian <hangdianqj@163.com>, Barry song <21cnbao@gmail.com>
Subject: [PATCH] dmaengine: moxart-dma:  replace spin_lock_irqsave with spin_lock in ISR
Date:   Tue, 11 Sep 2018 07:17:30 -0700
Message-Id: <20180911141730.52469-1-hangdianqj@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DcCowADHaYiPzpdbSEDMJA--.60905S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Jr1rAF4xAFyfGw18XF1UWrg_yoW8Jryfp3
        yxC3yY9r4jyanxJa1UJF1qqr43Ga9xXrWqkrWrGwn3Za4rJ3srZF4fKry2yry5JFZ7KFWF
        vF4Yqay3Cay3AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UFYLQUUUUU=
X-Originating-IP: [183.134.187.192]
X-CM-SenderInfo: pkdqwvpldq1yi6rwjhhfrp/1tbiJxK+R1XloCsZHwAAsx
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As you are already in ISR, it is unnecessary to call spin_lock_irqsave.

Signed-off-by: jun qian <hangdianqj@163.com>
Cc: Barry song <21cnbao@gmail.com>
---
 drivers/dma/moxart-dma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/moxart-dma.c b/drivers/dma/moxart-dma.c
index e04499c1f27f..77958f123226 100644
--- a/drivers/dma/moxart-dma.c
+++ b/drivers/dma/moxart-dma.c
@@ -524,7 +524,6 @@ static irqreturn_t moxart_dma_interrupt(int irq, void *devid)
 	struct moxart_dmadev *mc = devid;
 	struct moxart_chan *ch = &mc->slave_chans[0];
 	unsigned int i;
-	unsigned long flags;
 	u32 ctrl;
 
 	dev_dbg(chan2dev(&ch->vc.chan), "%s\n", __func__);
@@ -541,14 +540,14 @@ static irqreturn_t moxart_dma_interrupt(int irq, void *devid)
 		if (ctrl & APB_DMA_FIN_INT_STS) {
 			ctrl &= ~APB_DMA_FIN_INT_STS;
 			if (ch->desc) {
-				spin_lock_irqsave(&ch->vc.lock, flags);
+				spin_lock(&ch->vc.lock);
 				if (++ch->sgidx < ch->desc->sglen) {
 					moxart_dma_start_sg(ch, ch->sgidx);
 				} else {
 					vchan_cookie_complete(&ch->desc->vd);
 					moxart_dma_start_desc(&ch->vc.chan);
 				}
-				spin_unlock_irqrestore(&ch->vc.lock, flags);
+				spin_unlock(&ch->vc.lock);
 			}
 		}
 
-- 
2.17.1



