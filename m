Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C49ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FAE2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="qfqxZP6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9FAE2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbeGRTAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 15:00:07 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:43014 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730279AbeGRTAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 15:00:06 -0400
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
Subject: [PATCH v2 12/17] dmaengine: dma-jz4780: Set DTCn register explicitly
Date:   Wed, 18 Jul 2018 20:20:18 +0200
Message-Id: <20180718182023.8182-13-paul@crapouillou.net>
In-Reply-To: <20180718182023.8182-1-paul@crapouillou.net>
References: <20180718182023.8182-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1531938058; bh=jFX5EDK+g+3dPbj76T77dswfQ2u0wskPmtmghK9zTmg=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qfqxZP6QsJ38+Dy1pdXWb09uUXWk1vanWmRorUUIcUMxaOML8zHC1WrEYy5GvRrtXYZZMdbZCPGtaKRIGbwNDH1XGFPJOxlKRSHbelal6BPBUrFYh5s4agkdIGkJ1V2q9wrJCO4OpG6iiEuAXgmd5x6Oi5Y+zOCaNoyFhoxUEV8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Silsby <dansilsby@gmail.com>

Normally, we wouldn't set the channel transfer count register directly
when using descriptor-driven transfers. However, there is no harm in
doing so, and it allows jz4780_dma_desc_residue() to report the correct
residue of an ongoing transfer, no matter when it is called.

Signed-off-by: Daniel Silsby <dansilsby@gmail.com>
Tested-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/dma/dma-jz4780.c | 9 +++++++++
 1 file changed, 9 insertions(+)

 v2: No change

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index cc2a86844db4..78849131c81d 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -530,6 +530,15 @@ static void jz4780_dma_begin(struct jz4780_dma_chan *jzchan)
 	jz4780_dma_chn_writel(jzdma, jzchan->id, JZ_DMA_REG_DRT,
 			      jzchan->transfer_type);
 
+	/*
+	 * Set the transfer count. This is redundant for a descriptor-driven
+	 * transfer. However, there can be a delay between the transfer start
+	 * time and when DTCn reg contains the new transfer count. Setting
+	 * it explicitly ensures residue is computed correctly at all times.
+	 */
+	jz4780_dma_chn_writel(jzdma, jzchan->id, JZ_DMA_REG_DTC,
+				jzchan->desc->desc[jzchan->curr_hwdesc].dtc);
+
 	/* Write descriptor address and initiate descriptor fetch. */
 	desc_phys = jzchan->desc->desc_phys +
 		    (jzchan->curr_hwdesc * sizeof(*jzchan->desc->desc));
-- 
2.11.0

