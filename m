Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4798EC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E467A245D6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="DoryTjR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E467A245D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753464AbeGCMeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 08:34:17 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:46646 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752612AbeGCMch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 08:32:37 -0400
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
        linux-mips@linux-mips.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 07/14] dmaengine: dma-jz4780: Enable Fast DMA to the AIC
Date:   Tue,  3 Jul 2018 14:32:07 +0200
Message-Id: <20180703123214.23090-8-paul@crapouillou.net>
In-Reply-To: <20180703123214.23090-1-paul@crapouillou.net>
References: <20180703123214.23090-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1530621156; bh=IqjpwS2nEXZxovuEFSDRJK3MSn/uWmXaM9cI/ycZOC0=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=DoryTjR2pNoekwiM9kz/7vpVFa+2fEpr4A6vg4bPDSOYA7HLaDJxRIGQAGHWWlDsyje2qzvKRyfiipxg9CTvEmRQlVGx+1UyP6OB98krp0jOutun2mfNa5Uozp4FYPC4Z8DnEKn/ppeOjsuyo4N2RUqR7yCasrSmriHce1i2gVY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the fast DMA bit set, the DMA will transfer twice as much data
per clock period to the AIC, so there is little point not to set it.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/dma/dma-jz4780.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 922e4031e70e..7ee2c121948f 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -52,6 +52,7 @@
 #define JZ_DMA_DMAC_DMAE	BIT(0)
 #define JZ_DMA_DMAC_AR		BIT(2)
 #define JZ_DMA_DMAC_HLT		BIT(3)
+#define JZ_DMA_DMAC_FAIC	BIT(27)
 #define JZ_DMA_DMAC_FMSC	BIT(31)
 
 #define JZ_DMA_DRT_AUTO		0x8
@@ -929,8 +930,8 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 	 * Also set the FMSC bit - it increases MSC performance, so it makes
 	 * little sense not to enable it.
 	 */
-	jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMAC,
-			  JZ_DMA_DMAC_DMAE | JZ_DMA_DMAC_FMSC);
+	jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMAC, JZ_DMA_DMAC_DMAE |
+			       JZ_DMA_DMAC_FAIC | JZ_DMA_DMAC_FMSC);
 
 	if (jzdma->version == ID_JZ4780)
 		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMACP, 0);
-- 
2.18.0

