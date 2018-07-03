Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34856C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A7624C7A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="OkwR0CB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A7624C7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753447AbeGCMdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 08:33:49 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:46646 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753370AbeGCMck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 08:32:40 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH 09/14] dmaengine: dma-jz4780: Simplify jz4780_dma_desc_residue()
Date:   Tue,  3 Jul 2018 14:32:09 +0200
Message-Id: <20180703123214.23090-10-paul@crapouillou.net>
In-Reply-To: <20180703123214.23090-1-paul@crapouillou.net>
References: <20180703123214.23090-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1530621158; bh=etNvu++QjGMWLSYkyKc75Q73fElUynmKAMsXw0ay0Is=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OkwR0CB9cT0+gfYUB8sMtFmrDXVPWxPBzimqmqhmoxSZ5xxuupMw8jN1QKXx0q6GRWm4cnWpLBj/nU+t69N4ITEzT2my/2jXOoIogG5+Xz/lY0GZFGJJUc7ZvT1I5POlFapn5Yp07NResKdQATkk2aZn7Oyeam0tJcMBeEkQJ6Q=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Silsby <dansilsby@gmail.com>

Simple cleanup, no changes to actual logic here.

Signed-off-by: Daniel Silsby <dansilsby@gmail.com>
---
 drivers/dma/dma-jz4780.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 7b2e305e28fb..adada2a3a067 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -604,22 +604,17 @@ static size_t jz4780_dma_desc_residue(struct jz4780_dma_chan *jzchan,
 	struct jz4780_dma_desc *desc, unsigned int next_sg)
 {
 	struct jz4780_dma_dev *jzdma = jz4780_dma_chan_parent(jzchan);
-	unsigned int residue, count;
+	unsigned int count = 0;
 	unsigned int i;
 
-	residue = 0;
-
 	for (i = next_sg; i < desc->count; i++)
-		residue += (desc->desc[i].dtc & 0xffffff) <<
-			jzchan->transfer_shift;
+		count += desc->desc[i].dtc & 0xffffff;
 
-	if (next_sg != 0) {
-		count = jz4780_dma_chn_readl(jzdma, jzchan->id,
+	if (next_sg != 0)
+		count += jz4780_dma_chn_readl(jzdma, jzchan->id,
 					 JZ_DMA_REG_DTC);
-		residue += count << jzchan->transfer_shift;
-	}
 
-	return residue;
+	return count << jzchan->transfer_shift;
 }
 
 static enum dma_status jz4780_dma_tx_status(struct dma_chan *chan,
-- 
2.18.0

