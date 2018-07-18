Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEFEECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A91C2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Nq3R8hiv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A91C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbeGRTAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 15:00:10 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:43712 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730279AbeGRTAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 15:00:09 -0400
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
Subject: [PATCH v2 14/17] dmaengine: dma-jz4780: Use dma_set_residue()
Date:   Wed, 18 Jul 2018 20:20:20 +0200
Message-Id: <20180718182023.8182-15-paul@crapouillou.net>
In-Reply-To: <20180718182023.8182-1-paul@crapouillou.net>
References: <20180718182023.8182-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1531938061; bh=aVUOO2rcn9/wxwIufLlkTaDgU6pxqL9ciWmSVw8bKS4=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Nq3R8hivhegBPphX5cW8sVkZUnnsQxBkcZgWAccK/HyZ6n6wmOEs6/exBOWJgYC/+cbc6Mu4tBigMaINqicCcuUbs4hsj/RYQYPAz9cbHYCLsm65b7rtZlEQKclROtIFIrnleGxhRmXD0FyHMn1TqtmJui/8fLy+uG7U/cA7KqE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Silsby <dansilsby@gmail.com>

This is the standard method provided by dmaengine header.

Signed-off-by: Daniel Silsby <dansilsby@gmail.com>
Tested-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/dma/dma-jz4780.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

 v2: No change

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index b9db539a5b34..ea17886031fa 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -637,6 +637,7 @@ static enum dma_status jz4780_dma_tx_status(struct dma_chan *chan,
 	struct virt_dma_desc *vdesc;
 	enum dma_status status;
 	unsigned long flags;
+	unsigned long residue = 0;
 
 	status = dma_cookie_status(chan, cookie, txstate);
 	if ((status == DMA_COMPLETE) || (txstate == NULL))
@@ -647,13 +648,13 @@ static enum dma_status jz4780_dma_tx_status(struct dma_chan *chan,
 	vdesc = vchan_find_desc(&jzchan->vchan, cookie);
 	if (vdesc) {
 		/* On the issued list, so hasn't been processed yet */
-		txstate->residue = jz4780_dma_desc_residue(jzchan,
+		residue = jz4780_dma_desc_residue(jzchan,
 					to_jz4780_dma_desc(vdesc), 0);
 	} else if (cookie == jzchan->desc->vdesc.tx.cookie) {
-		txstate->residue = jz4780_dma_desc_residue(jzchan, jzchan->desc,
+		residue = jz4780_dma_desc_residue(jzchan, jzchan->desc,
 					jzchan->curr_hwdesc + 1);
-	} else
-		txstate->residue = 0;
+	}
+	dma_set_residue(txstate, residue);
 
 	if (vdesc && jzchan->desc && vdesc == &jzchan->desc->vdesc
 	    && jzchan->desc->status & (JZ_DMA_DCS_AR | JZ_DMA_DCS_HLT))
-- 
2.11.0

