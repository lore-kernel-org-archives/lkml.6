Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26315C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E264420866
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bIMdEaPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbeL1IgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 03:36:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51170 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730386AbeL1IgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 03:36:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Sl6n8Cyo7YEkkBVgEXoakF9zl/6bKqP1pjuQgucCGrE=; b=bIMdEaPFlJk6NVoo9ZnqbqqVV
        OmwWGwL6TjXWI8PWiD6rWNaJldQ/57+S9CODJEkPwV3AoWCfRlCDwGaUssLM9LbY5zJH9h8cDbc3O
        YGrYP50JlPgVxFgHSg4hoIZ+iejQZUyi1Jh2KHJ704MtTBX4ID4GexdBYkNZyPzFs5WbDh4RRSllG
        94ZOxzIn2PRTMQTV2BC2nLnPJmWAFWT3h+yhBPywTWORa6IvWgJFb0w3dNC1SQq7dzY0sYQWHWJvQ
        AgVFCmw8ClyC3MKd7b8uyZski+gy6kS47rD+SwbpFI+38tQB5hdXer02TpwKXMUbGG4H7I1VsZ8Kh
        9tYdGHAPQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gcncz-0001gB-EO; Fri, 28 Dec 2018 08:36:21 +0000
Date:   Fri, 28 Dec 2018 00:36:21 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG] net: sungem: device driver frees DMA memory with wrong
 function
Message-ID: <20181228083621.GA25585@infradead.org>
References: <20181223193821.GA24922@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181223193821.GA24922@Red>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please try this patch:

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index a52c6409bdc2..f454e0ed1398 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -284,32 +284,25 @@ static inline void dma_direct_sync_sg_for_cpu(struct device *dev,
 }
 #endif
 
-static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
-					      size_t size,
-					      enum dma_data_direction dir,
-					      unsigned long attrs)
+static inline dma_addr_t dma_map_page_attrs(struct device *dev,
+		struct page *page, size_t offset, size_t size,
+		enum dma_data_direction dir, unsigned long attrs)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 	dma_addr_t addr;
 
 	BUG_ON(!valid_dma_direction(dir));
-	debug_dma_map_single(dev, ptr, size);
 	if (dma_is_direct(ops))
-		addr = dma_direct_map_page(dev, virt_to_page(ptr),
-				offset_in_page(ptr), size, dir, attrs);
+		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
 	else
-		addr = ops->map_page(dev, virt_to_page(ptr),
-				offset_in_page(ptr), size, dir, attrs);
-	debug_dma_map_page(dev, virt_to_page(ptr),
-			   offset_in_page(ptr), size,
-			   dir, addr, true);
+		addr = ops->map_page(dev, page, offset, size, dir, attrs);
+	debug_dma_map_page(dev, page, offset, size, dir, addr, false);
+
 	return addr;
 }
 
-static inline void dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
-					  size_t size,
-					  enum dma_data_direction dir,
-					  unsigned long attrs)
+static inline void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
@@ -321,12 +314,6 @@ static inline void dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
 	debug_dma_unmap_page(dev, addr, size, dir, true);
 }
 
-static inline void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr,
-		size_t size, enum dma_data_direction dir, unsigned long attrs)
-{
-	return dma_unmap_single_attrs(dev, addr, size, dir, attrs);
-}
-
 /*
  * dma_maps_sg_attrs returns 0 on error and > 0 on success.
  * It should never return a value < 0.
@@ -363,25 +350,6 @@ static inline void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg
 		ops->unmap_sg(dev, sg, nents, dir, attrs);
 }
 
-static inline dma_addr_t dma_map_page_attrs(struct device *dev,
-					    struct page *page,
-					    size_t offset, size_t size,
-					    enum dma_data_direction dir,
-					    unsigned long attrs)
-{
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-	dma_addr_t addr;
-
-	BUG_ON(!valid_dma_direction(dir));
-	if (dma_is_direct(ops))
-		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
-	else
-		addr = ops->map_page(dev, page, offset, size, dir, attrs);
-	debug_dma_map_page(dev, page, offset, size, dir, addr, false);
-
-	return addr;
-}
-
 static inline dma_addr_t dma_map_resource(struct device *dev,
 					  phys_addr_t phys_addr,
 					  size_t size,
@@ -488,6 +456,19 @@ dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 
 }
 
+static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	return dma_map_page_attrs(dev, virt_to_page(ptr), offset_in_page(ptr),
+			size, dir, attrs);
+}
+
+static inline void dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	return dma_unmap_page_attrs(dev, addr, size, dir, attrs);
+}
+
 #define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, 0)
 #define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, 0)
 #define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
