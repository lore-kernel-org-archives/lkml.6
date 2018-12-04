Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A4FC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF50920879
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aAPLZvqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF50920879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeLDQRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:17:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51378 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbeLDQRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wGOQvkZqq0wHy8bDnO+MiQJtbDM796t5ELhd1RsQZNg=; b=aAPLZvqaGOXZJQpaVeF9AE3apS
        ropZvHzJYaF4zz+/NQ8gcIFkH9mXVrAFP32WOLoSbSV4exaFzeMbueV3+vaEOb3TbyGIljrtR+3kg
        f0FwJGGbRrRXNGsRVTyqwbLB5RjL/hcVbiDjYwNV8OrKvZZdnhYi4VSQdY1KKOakyWi8JhplIC/Ij
        ca5czRt1SS+PLrcYKYefcMsBa7IAZdt/W9PatQN1iz6Y8c4YUsjbSGqgG3liGpoqNMBo6MU7gO6PV
        1h5ju+XXByIHZ3xuJ7KfAMmvZfTE0svIYKgSzJNLCC60iHiASm5K2bUJ11Qu5vEuNLm1Xbm5eedvE
        bmhtF8MA==;
Received: from [38.126.112.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUDNd-0002LO-89; Tue, 04 Dec 2018 16:17:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-ia64@vger.kernel.org, iommu@lists.linux-foundation.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] dma-direct: use dma_direct_map_page to implement dma_direct_map_sg
Date:   Tue,  4 Dec 2018 08:16:44 -0800
Message-Id: <20181204161645.8038-5-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204161645.8038-1-hch@lst.de>
References: <20181204161645.8038-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to duplicate the mapping logic.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index edb24f94ea1e..d45306473c90 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -217,6 +217,7 @@ static void dma_direct_sync_single_for_device(struct device *dev,
 	arch_sync_dma_for_device(dev, dma_to_phys(dev, addr), size, dir);
 }
 
+#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE)
 static void dma_direct_sync_sg_for_device(struct device *dev,
 		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
 {
@@ -229,6 +230,7 @@ static void dma_direct_sync_sg_for_device(struct device *dev,
 	for_each_sg(sgl, sg, nents, i)
 		arch_sync_dma_for_device(dev, sg_phys(sg), sg->length, dir);
 }
+#endif
 
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
@@ -294,19 +296,13 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 	struct scatterlist *sg;
 
 	for_each_sg(sgl, sg, nents, i) {
-		BUG_ON(!sg_page(sg));
-
-		sg_dma_address(sg) = phys_to_dma(dev, sg_phys(sg));
-		if (unlikely(dev && !dma_capable(dev, sg_dma_address(sg),
-				sg->length))) {
-			report_addr(dev, sg_dma_address(sg), sg->length);
+		sg->dma_address = dma_direct_map_page(dev, sg_page(sg),
+				sg->offset, sg->length, dir, attrs);
+		if (sg->dma_address == DMA_MAPPING_ERROR)
 			return 0;
-		}
 		sg_dma_len(sg) = sg->length;
 	}
 
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		dma_direct_sync_sg_for_device(dev, sgl, nents, dir);
 	return nents;
 }
 
-- 
2.19.1

