Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE055C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A0F214FA
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="f5ePX+m+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A0F214FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389193AbeHGN5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:57:47 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:51898 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbeHGN43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:56:29 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Paul Cercueil <paul@crapouillou.net>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH v4 05/18] dmaengine: dma-jz4780: Use 4-word descriptors
Date:   Tue,  7 Aug 2018 13:42:05 +0200
Message-Id: <20180807114218.20091-6-paul@crapouillou.net>
In-Reply-To: <20180807114218.20091-1-paul@crapouillou.net>
References: <20180807114218.20091-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1533642151; bh=4Jhom5kTG7+dvvC2F4QfYTNv7txKIAAqvYbPfxE5UJ0=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=f5ePX+m+7E4mZOIgMcErfziBcCu3q1+41zov1+t4JTWH0dghHnNBldeZzoK4p6wexaM4CZTWFf5TGBKapZjnhmQ3AX1vhyD/aFbqqWHzDELglVndTszkPbAxNyiSksSdlNfaDFdAzL7JhYiSfs/u0jkBNh5vOhPAfAu7JeOoxfQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only information we use in the 8-word version of the hardware DMA
descriptor that is not present in the 4-word version is the transfer
type, aka. the ID of the source or recipient device.

Since the transfer type will never change for a DMA channel in use,
we can just set it once for all in the corresponding DMA register
before starting any transfer.

This has several benefits:

* the driver will handle twice as many hardware DMA descriptors;

* the driver is closer to support the JZ4740, which only supports 4-word
  hardware DMA descriptors;

* the JZ4770 SoC needs the transfer type to be set in the corresponding
  DMA register anyway, even if 8-word descriptors are in use.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
---
 drivers/dma/dma-jz4780.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

 v2: No change

 v3: No change

 v4: No change

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index adf4d5efced6..7683de9fb9ee 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -95,17 +95,12 @@
  * @dtc: transfer count (number of blocks of the transfer size specified in DCM
  * to transfer) in the low 24 bits, offset of the next descriptor from the
  * descriptor base address in the upper 8 bits.
- * @sd: target/source stride difference (in stride transfer mode).
- * @drt: request type
  */
 struct jz4780_dma_hwdesc {
 	uint32_t dcm;
 	uint32_t dsa;
 	uint32_t dta;
 	uint32_t dtc;
-	uint32_t sd;
-	uint32_t drt;
-	uint32_t reserved[2];
 };
 
 /* Size of allocations for hardware descriptor blocks. */
@@ -281,7 +276,6 @@ static int jz4780_dma_setup_hwdesc(struct jz4780_dma_chan *jzchan,
 		desc->dcm = JZ_DMA_DCM_SAI;
 		desc->dsa = addr;
 		desc->dta = config->dst_addr;
-		desc->drt = jzchan->transfer_type;
 
 		width = config->dst_addr_width;
 		maxburst = config->dst_maxburst;
@@ -289,7 +283,6 @@ static int jz4780_dma_setup_hwdesc(struct jz4780_dma_chan *jzchan,
 		desc->dcm = JZ_DMA_DCM_DAI;
 		desc->dsa = config->src_addr;
 		desc->dta = addr;
-		desc->drt = jzchan->transfer_type;
 
 		width = config->src_addr_width;
 		maxburst = config->src_maxburst;
@@ -434,9 +427,10 @@ static struct dma_async_tx_descriptor *jz4780_dma_prep_dma_memcpy(
 	tsz = jz4780_dma_transfer_size(dest | src | len,
 				       &jzchan->transfer_shift);
 
+	jzchan->transfer_type = JZ_DMA_DRT_AUTO;
+
 	desc->desc[0].dsa = src;
 	desc->desc[0].dta = dest;
-	desc->desc[0].drt = JZ_DMA_DRT_AUTO;
 	desc->desc[0].dcm = JZ_DMA_DCM_TIE | JZ_DMA_DCM_SAI | JZ_DMA_DCM_DAI |
 			    tsz << JZ_DMA_DCM_TSZ_SHIFT |
 			    JZ_DMA_WIDTH_32_BIT << JZ_DMA_DCM_SP_SHIFT |
@@ -491,9 +485,12 @@ static void jz4780_dma_begin(struct jz4780_dma_chan *jzchan)
 			(jzchan->curr_hwdesc + 1) % jzchan->desc->count;
 	}
 
-	/* Use 8-word descriptors. */
-	jz4780_dma_chn_writel(jzdma, jzchan->id,
-			      JZ_DMA_REG_DCS, JZ_DMA_DCS_DES8);
+	/* Use 4-word descriptors. */
+	jz4780_dma_chn_writel(jzdma, jzchan->id, JZ_DMA_REG_DCS, 0);
+
+	/* Set transfer type. */
+	jz4780_dma_chn_writel(jzdma, jzchan->id, JZ_DMA_REG_DRT,
+			      jzchan->transfer_type);
 
 	/* Write descriptor address and initiate descriptor fetch. */
 	desc_phys = jzchan->desc->desc_phys +
@@ -503,7 +500,7 @@ static void jz4780_dma_begin(struct jz4780_dma_chan *jzchan)
 
 	/* Enable the channel. */
 	jz4780_dma_chn_writel(jzdma, jzchan->id, JZ_DMA_REG_DCS,
-			      JZ_DMA_DCS_DES8 | JZ_DMA_DCS_CTE);
+			      JZ_DMA_DCS_CTE);
 }
 
 static void jz4780_dma_issue_pending(struct dma_chan *chan)
-- 
2.11.0

