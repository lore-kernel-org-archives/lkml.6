Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67C5C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4814D21779
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Lixiz9SQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4814D21779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389027AbeHGN4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:56:37 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:52542 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388986AbeHGN4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:56:35 -0400
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
Subject: [PATCH v4 10/18] dmaengine: dma-jz4780: Enable Fast DMA to the AIC
Date:   Tue,  7 Aug 2018 13:42:10 +0200
Message-Id: <20180807114218.20091-11-paul@crapouillou.net>
In-Reply-To: <20180807114218.20091-1-paul@crapouillou.net>
References: <20180807114218.20091-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1533642157; bh=eiUOmW3tAutUTASBDPdhm67AII/Vgxt1HbD0ikyWV4M=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Lixiz9SQcKIzwbZWeg3/WseFwtvwCaIFyY84Fu2FHM9q/LocISeOClDS6V13wiYL5jpYSJWx1K9OdpULBw2YkDvHxpOf/g3x5X2tg6K3BqeHepiw9J4wg3QFcwjxRt6uUuIom2TPE6sIe0x/P/8fPCzhAbXWk9xQvWSX02Q038Y=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the fast DMA bit set, the DMA will transfer twice as much data
per clock period to the AIC, so there is little point not to set it.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
---
 drivers/dma/dma-jz4780.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

 v2: No change

 v3: No change

 v4: No change

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 565971c2a33c..3a4d0a4b550d 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -52,6 +52,7 @@
 #define JZ_DMA_DMAC_DMAE	BIT(0)
 #define JZ_DMA_DMAC_AR		BIT(2)
 #define JZ_DMA_DMAC_HLT		BIT(3)
+#define JZ_DMA_DMAC_FAIC	BIT(27)
 #define JZ_DMA_DMAC_FMSC	BIT(31)
 
 #define JZ_DMA_DRT_AUTO		0x8
@@ -923,8 +924,8 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 	 * Also set the FMSC bit - it increases MSC performance, so it makes
 	 * little sense not to enable it.
 	 */
-	jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMAC,
-			  JZ_DMA_DMAC_DMAE | JZ_DMA_DMAC_FMSC);
+	jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMAC, JZ_DMA_DMAC_DMAE |
+			       JZ_DMA_DMAC_FAIC | JZ_DMA_DMAC_FMSC);
 
 	if (soc_data->flags & JZ_SOC_DATA_PROGRAMMABLE_DMA)
 		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMACP, 0);
-- 
2.11.0

