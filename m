Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C779FC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6112082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L4R+5BrX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E6112082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeLDQQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:16:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51328 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeLDQQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:16:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KDUsWhqtiK68OQ6enzSKjeJHX/RuYZSLZlpmVulYSRQ=; b=L4R+5BrXIB3jZ/4IRJ7ioUuCFI
        6RnxZj9popsX5Bx5Acc1bx7ahfiJvQxE8iL6oEDJ89RE4kO82hMzFgE0AejxWb5bI5qoFfA8vRH7r
        82dEB/CTwCTPIZ/brfzck0vSQ4EnhkUlrxCHwUdjFLYK5ifKDZJnbJWpSC0fJsbpCYht7HmuffCst
        rg6K5tIs+RXMvx6LveuvmBKRs5LmhiBsd36GMIgoS5qRN92AJpQts9ESef9nwsMyB7Jcwnq3kaRZ1
        t+CFOsAv3PdLCMjS8L9orLdLo6/h57zKq1G1gNXTYusu6TZ8o/ySSn+PEu7M2hjDOE4VpFau02HHb
        b8bCTjYA==;
Received: from [38.126.112.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUDNY-0002Jk-23; Tue, 04 Dec 2018 16:16:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-ia64@vger.kernel.org, iommu@lists.linux-foundation.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] dma-direct: improve addressability error reporting
Date:   Tue,  4 Dec 2018 08:16:43 -0800
Message-Id: <20181204161645.8038-4-hch@lst.de>
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

Only report report a DMA addressability report once to avoid spewing the
kernel log with repeated message.  Also provide a stack trace to make it
easy to find the actual caller that caused the problem.

Last but not least move the actual check into the fast path and only
leave the error reporting in a helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 308f88a750c8..edb24f94ea1e 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -30,27 +30,16 @@ static inline bool force_dma_unencrypted(void)
 	return sev_active();
 }
 
-static bool
-check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
-		const char *caller)
+static void report_addr(struct device *dev, dma_addr_t dma_addr, size_t size)
 {
-	if (unlikely(dev && !dma_capable(dev, dma_addr, size))) {
-		if (!dev->dma_mask) {
-			dev_err(dev,
-				"%s: call on device without dma_mask\n",
-				caller);
-			return false;
-		}
-
-		if (*dev->dma_mask >= DMA_BIT_MASK(32) || dev->bus_dma_mask) {
-			dev_err(dev,
-				"%s: overflow %pad+%zu of device mask %llx bus mask %llx\n",
-				caller, &dma_addr, size,
-				*dev->dma_mask, dev->bus_dma_mask);
-		}
-		return false;
+	if (!dev->dma_mask) {
+		dev_err_once(dev, "DMA map on device without dma_mask\n");
+	} else if (*dev->dma_mask >= DMA_BIT_MASK(32) || dev->bus_dma_mask) {
+		dev_err_once(dev,
+			"overflow %pad+%zu of DMA mask %llx bus mask %llx\n",
+			&dma_addr, size, *dev->dma_mask, dev->bus_dma_mask);
 	}
-	return true;
+	WARN_ON_ONCE(1);
 }
 
 static inline dma_addr_t phys_to_dma_direct(struct device *dev,
@@ -288,8 +277,10 @@ dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
 	phys_addr_t phys = page_to_phys(page) + offset;
 	dma_addr_t dma_addr = phys_to_dma(dev, phys);
 
-	if (!check_addr(dev, dma_addr, size, __func__))
+	if (unlikely(dev && !dma_capable(dev, dma_addr, size))) {
+		report_addr(dev, dma_addr, size);
 		return DMA_MAPPING_ERROR;
+	}
 
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		dma_direct_sync_single_for_device(dev, dma_addr, size, dir);
@@ -306,8 +297,11 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		BUG_ON(!sg_page(sg));
 
 		sg_dma_address(sg) = phys_to_dma(dev, sg_phys(sg));
-		if (!check_addr(dev, sg_dma_address(sg), sg->length, __func__))
+		if (unlikely(dev && !dma_capable(dev, sg_dma_address(sg),
+				sg->length))) {
+			report_addr(dev, sg_dma_address(sg), sg->length);
 			return 0;
+		}
 		sg_dma_len(sg) = sg->length;
 	}
 
-- 
2.19.1

