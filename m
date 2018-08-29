Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FD1C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64D820652
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="IFjCsUND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D64D820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeH3Bcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:32:51 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:53184 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbeH3BcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:32:07 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
Cc:     od@zcrc.me, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Daniel Silsby <dansilsby@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v5 13/18] dmaengine: dma-jz4780: Set DTCn register explicitly
Date:   Wed, 29 Aug 2018 23:32:55 +0200
Message-Id: <20180829213300.22829-14-paul@crapouillou.net>
In-Reply-To: <20180829213300.22829-1-paul@crapouillou.net>
References: <20180829213300.22829-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1535578398; bh=wBcNmBnqQKtkU2S10+UH6pynUHfBfHNfnHqd15R9rdE=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IFjCsUND0a/KpR7tyUMvaBCgNP+uQuP3tPHZWzS0jX13yTUTf74+GdWlfRW7/s9Psz7oBp6jNhDtfh9wGhTcASHysqr76x3qaCgPz4Z6sZVEtWAj8+oAA5fbJGoKeNu9JRJXjKHintOcqmSg2pcrYlDXVuCBedm2GMr5GR6TbaU=
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
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
---

Notes:
     v2: No change
    
     v3: No change
    
     v4: Add my Signed-off-by
    
     v5: No change

 drivers/dma/dma-jz4780.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index d055602a92ca..d3b915ec8a09 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -532,6 +532,15 @@ static void jz4780_dma_begin(struct jz4780_dma_chan *jzchan)
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

