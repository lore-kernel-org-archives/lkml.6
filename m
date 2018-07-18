Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADC1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06E820850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="o8Ouv8UT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06E820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbeGRTAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 15:00:06 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:42666 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730810AbeGRTAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 15:00:05 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH v2 11/17] dmaengine: dma-jz4780: Simplify jz4780_dma_desc_residue()
Date:   Wed, 18 Jul 2018 20:20:17 +0200
Message-Id: <20180718182023.8182-12-paul@crapouillou.net>
In-Reply-To: <20180718182023.8182-1-paul@crapouillou.net>
References: <20180718182023.8182-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1531938057; bh=vzelrVMKs/0wg3dLlRx1QkugqOvdrasHHVxrnabaetQ=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=o8Ouv8UTg8uPrsfR324em7lZFz7rdJj+XY+A40LTIK3rIz/LndR9Zwga16U8q1Qa7xLLaJsKnRkklkKEhZXIL3mqPG2aJHA1VnxclzOtb5PGQO/EA5RiyyZYY5IL+1MQOiYvmf9YI0uw8Yz2w7YkTjPGnsfVTZNkaG9IuWBN9j4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Silsby <dansilsby@gmail.com>

Simple cleanup, no changes to actual logic here.

Signed-off-by: Daniel Silsby <dansilsby@gmail.com>
Tested-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/dma/dma-jz4780.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

 v2: No change

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index fa926de082ba..cc2a86844db4 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -608,22 +608,17 @@ static size_t jz4780_dma_desc_residue(struct jz4780_dma_chan *jzchan,
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
2.11.0

