Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20686C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47ED2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fMRhy6gj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47ED2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbeGYMtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 08:49:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39588 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbeGYMtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 08:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g1XJc4NMMKruBuBefALJIyJ4oWcJvLNZ3oMaHkEybYA=; b=fMRhy6gjMwQxHMPeRGkIaVAtq
        BujM9X4Ss07k0gaTfDL994lgNsN4YJV+0CSmWLpoa4lJymJrxXS5d+hWg8BalAJOuk7xjASgS7At4
        k8LkpT7E5ysF6S/3MHw9XfskPuT1qdS/8BFz8dVqIEl2U2wYFwPzIMb1hcqD64H1AicHbyCfu4TF8
        D8zpFqOtSbZchyTWVFmEqQfLKj4d6h+u3bNMGIswaq2903qW3v6iWUu9BZrAzkil2LfNNyxi+/zJ5
        SAvFd0FjA8Dq0wPd+ebwCWhHZcbPJ7/XH5Tj+Xk9V/GQohzfKWL7zL0FB+Cg49CxGXyITwwDTsV6p
        mu2D5VaUQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fiI7Z-0006pE-Nj; Wed, 25 Jul 2018 11:38:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] swiotlb: respect DMA_ATTR_NO_WARN in __swiotlb_map_page
Date:   Wed, 25 Jul 2018 13:38:02 +0200
Message-Id: <20180725113802.18943-7-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180725113802.18943-1-hch@lst.de>
References: <20180725113802.18943-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/swiotlb.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 8ca0964ebf3a..5c3db7c89e0f 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -606,8 +606,11 @@ __swiotlb_map_page(struct device *dev, phys_addr_t phys, size_t size,
 
 	switch (swiotlb_force) {
 	case SWIOTLB_NO_FORCE:
-		dev_warn_ratelimited(dev,
-			"swiotlb: force disabled for address %pa\n", &phys);
+		if (!(attrs & DMA_ATTR_NO_WARN)) {
+			dev_warn_ratelimited(dev,
+				"swiotlb: force disabled for address %pa\n",
+				&phys);
+		}
 		return -EOPNOTSUPP;
 	case SWIOTLB_NORMAL:
 		/* can we address the memory directly? */
@@ -627,10 +630,12 @@ __swiotlb_map_page(struct device *dev, phys_addr_t phys, size_t size,
 	/* Ensure that the address returned is DMA'ble */
 	*dma_addr = __phys_to_dma(dev, map_addr);
 	if (unlikely(!dma_capable(dev, *dma_addr, size))) {
-		dev_err_ratelimited(dev,
-			"DMA: swiotlb buffer not addressable.\n");
+		if (!(attrs & DMA_ATTR_NO_WARN)) {
+			dev_err_ratelimited(dev,
+				"DMA: swiotlb buffer not addressable.\n");
+		}
 		swiotlb_tbl_unmap_single(dev, map_addr, size, dir,
-			attrs | DMA_ATTR_SKIP_CPU_SYNC);
+				attrs | DMA_ATTR_SKIP_CPU_SYNC);
 		return -EINVAL;
 	}
 	return 0;
-- 
2.18.0

