Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C48C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA3520684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BhkyanM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA3520684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437236AbeKWAnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:43:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59632 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731181AbeKWAnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NRkfp6v/tyUENHy0v3FTFCa7RE2ArNmx9O95c3iBPt0=; b=BhkyanM6gWSsCuX6iaFbuGduoS
        toCX63m7RIQFNq2vYWjKqhgQG9FSqxcmCclgXpsAg00C8mB3yKFH4SOihjFdqi+a1JGZl6dPQVecj
        E4A5VsMJbV/K6cmXiC2TZmRbdllLX8hh0j78WQfaUdGl81tMwDtE2zzDb8TIVI4QQ/ivyA8f2hfxf
        Zt4KbhSd/BULRcE97LNe3BgAHJdGlgfOa0zBls4RZfUvb2K/gDEiySPOq4dcbYDHKYIXYi2rOddNz
        AaHQtQkDL9QEL8nPchcZNwFn/QTysKBSgf/ZWInsLotPdCEpgkF5hN5ArlIfSpuApg1IC/KEX/BvL
        EYMbkiww==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPpaK-0008Ki-OC; Thu, 22 Nov 2018 14:04:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jon Mason <jdmason@kudzu.us>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/24] arm64: remove the dummy_dma_ops mapping_error method
Date:   Thu, 22 Nov 2018 15:03:08 +0100
Message-Id: <20181122140320.24080-13-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122140320.24080-1-hch@lst.de>
References: <20181122140320.24080-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just return DMA_MAPPING_ERROR from __dummy_map_page and let the core
dma-mapping code handle the rest.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/mm/dma-mapping.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index a3ac26284845..fdc26ea5036c 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -282,7 +282,7 @@ static dma_addr_t __dummy_map_page(struct device *dev, struct page *page,
 				   enum dma_data_direction dir,
 				   unsigned long attrs)
 {
-	return 0;
+	return DMA_MAPPING_ERROR;
 }
 
 static void __dummy_unmap_page(struct device *dev, dma_addr_t dev_addr,
@@ -317,11 +317,6 @@ static void __dummy_sync_sg(struct device *dev,
 {
 }
 
-static int __dummy_mapping_error(struct device *hwdev, dma_addr_t dma_addr)
-{
-	return 1;
-}
-
 static int __dummy_dma_supported(struct device *hwdev, u64 mask)
 {
 	return 0;
@@ -339,7 +334,6 @@ const struct dma_map_ops dummy_dma_ops = {
 	.sync_single_for_device = __dummy_sync_single,
 	.sync_sg_for_cpu        = __dummy_sync_sg,
 	.sync_sg_for_device     = __dummy_sync_sg,
-	.mapping_error          = __dummy_mapping_error,
 	.dma_supported          = __dummy_dma_supported,
 };
 EXPORT_SYMBOL(dummy_dma_ops);
-- 
2.19.1

