Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF513C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880EB208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 880EB208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbeLFSnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:43:33 -0500
Received: from verein.lst.de ([213.95.11.211]:58865 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbeLFSnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:43:32 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 8195668AA6; Thu,  6 Dec 2018 19:43:30 +0100 (CET)
Date:   Thu, 6 Dec 2018 19:43:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        brouer@redhat.com, tariqt@mellanox.com,
        ilias.apalodimas@linaro.org, toke@toke.dk, robin.murphy@arm.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] avoid indirect calls for DMA direct mappings
Message-ID: <20181206184330.GB30039@lst.de>
References: <20181206153720.10702-1-hch@lst.de> <CAHk-=wgz6PFCm+XMWN31dRHzA3JcNP0x0Y-z5NMMw3dHhrDXAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgz6PFCm+XMWN31dRHzA3JcNP0x0Y-z5NMMw3dHhrDXAw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 10:28:22AM -0800, Linus Torvalds wrote:
> which is counterproductive because it checks for the fast case *after*
> you've done a load (and a check) that is entirely pointless for the
> fast case.
> 
> Put another way, you made the fast case unnecessarily slow.
> 
> If this fast case matters (and the whole point of the series is that
> it *does* matter), then you should make sure that
> 
>  (a) the dma_is_direct() function/macro uses "likely()" for the test

I'm a little worried about that.  Yes, for the common case it is
likely.  But if you run a setup where you say always have an iommu
it is not, in fact it is never called in that case, but we only know
that at runtime.

>  (b) the code is organized like this instead:
> 
> +       if (dma_is_direct(ops))
> +               dma_direct_unmap_page(dev, addr, size, dir, attrs);
> +       else if (ops->unmap_page)
> +               ops->unmap_page(dev, addr, size, dir, attrs);
> 
> because now you avoid that unnecessary conditional for the common
> case, and you hopefully never even access the pointer (because you
> know what's behind it: the direct ops cases that you're
> short-circuiting).

Agreed on that, I've fixed it up now (current patch attached below).

> In fact, as a further micro-optimization it might be a good idea to
> just specify that the dma_is_direct() ops is a special pointer
> (perhaps even just say that "NULL means it's direct"), because that
> then makes the fast-case test much simpler (avoids a whole nasty
> constant load, and testing for NULL in particular is often much
> better).

So I wanted to do the NULL case, and it would be much nicer.  But the
arm folks went to great length to make sure they don't have a default
set of dma ops and require it to be explicitly set on every device
to catch cases where people don't set things up properly and I didn't
want to piss them off..  But maybe I should just go for it and see who
screams, as the benefit is pretty obvious.

---
From 89cc8ab03798177339ad916efabd320e792ee034 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 3 Dec 2018 16:49:29 +0100
Subject: dma-mapping: bypass indirect calls for dma-direct

Avoid expensive indirect calls in the fast path DMA mapping
operations by directly calling the dma_direct_* ops if we are using
the directly mapped DMA operations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-direct.h  |  17 ------
 include/linux/dma-mapping.h | 110 ++++++++++++++++++++++++++++++++----
 kernel/dma/direct.c         |  13 +++--
 3 files changed, 106 insertions(+), 34 deletions(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 3b0a3ea3876d..b7338702592a 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -60,22 +60,5 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs);
 void __dma_direct_free_pages(struct device *dev, size_t size, struct page *page);
-dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
-		unsigned long offset, size_t size, enum dma_data_direction dir,
-		unsigned long attrs);
-void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
-		size_t size, enum dma_data_direction dir, unsigned long attrs);
-int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
-		enum dma_data_direction dir, unsigned long attrs);
-void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
-		int nents, enum dma_data_direction dir, unsigned long attrs);
-void dma_direct_sync_single_for_device(struct device *dev,
-		dma_addr_t addr, size_t size, enum dma_data_direction dir);
-void dma_direct_sync_sg_for_device(struct device *dev,
-		struct scatterlist *sgl, int nents, enum dma_data_direction dir);
-void dma_direct_sync_single_for_cpu(struct device *dev,
-		dma_addr_t addr, size_t size, enum dma_data_direction dir);
-void dma_direct_sync_sg_for_cpu(struct device *dev,
-		struct scatterlist *sgl, int nents, enum dma_data_direction dir);
 int dma_direct_supported(struct device *dev, u64 mask);
 #endif /* _LINUX_DMA_DIRECT_H */
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 8916499d2805..98e4dd67c906 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -221,6 +221,69 @@ static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
 }
 #endif
 
+static inline bool dma_is_direct(const struct dma_map_ops *ops)
+{
+	return IS_ENABLED(CONFIG_DMA_DIRECT_OPS) && ops == &dma_direct_ops;
+}
+
+/*
+ * All the dma_direct_* declarations are here just for the indirect call bypass,
+ * and must not be used directly drivers!
+ */
+dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
+		unsigned long offset, size_t size, enum dma_data_direction dir,
+		unsigned long attrs);
+int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
+		enum dma_data_direction dir, unsigned long attrs);
+
+#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
+    defined(CONFIG_SWIOTLB)
+void dma_direct_sync_single_for_device(struct device *dev,
+		dma_addr_t addr, size_t size, enum dma_data_direction dir);
+void dma_direct_sync_sg_for_device(struct device *dev,
+		struct scatterlist *sgl, int nents, enum dma_data_direction dir);
+#else
+static inline void dma_direct_sync_single_for_device(struct device *dev,
+		dma_addr_t addr, size_t size, enum dma_data_direction dir)
+{
+}
+static inline void dma_direct_sync_sg_for_device(struct device *dev,
+		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
+{
+}
+#endif
+
+#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
+    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL) || \
+    defined(CONFIG_SWIOTLB)
+void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs);
+void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
+		int nents, enum dma_data_direction dir, unsigned long attrs);
+void dma_direct_sync_single_for_cpu(struct device *dev,
+		dma_addr_t addr, size_t size, enum dma_data_direction dir);
+void dma_direct_sync_sg_for_cpu(struct device *dev,
+		struct scatterlist *sgl, int nents, enum dma_data_direction dir);
+#else
+static inline void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+}
+static inline void dma_direct_unmap_sg(struct device *dev,
+		struct scatterlist *sgl, int nents, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+}
+static inline void dma_direct_sync_single_for_cpu(struct device *dev,
+		dma_addr_t addr, size_t size, enum dma_data_direction dir)
+{
+}
+static inline void dma_direct_sync_sg_for_cpu(struct device *dev,
+		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
+{
+}
+#endif
+
 static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
 					      size_t size,
 					      enum dma_data_direction dir,
@@ -231,9 +294,12 @@ static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
 
 	BUG_ON(!valid_dma_direction(dir));
 	debug_dma_map_single(dev, ptr, size);
-	addr = ops->map_page(dev, virt_to_page(ptr),
-			     offset_in_page(ptr), size,
-			     dir, attrs);
+	if (dma_is_direct(ops))
+		addr = dma_direct_map_page(dev, virt_to_page(ptr),
+				offset_in_page(ptr), size, dir, attrs);
+	else
+		addr = ops->map_page(dev, virt_to_page(ptr),
+				offset_in_page(ptr), size, dir, attrs);
 	debug_dma_map_page(dev, virt_to_page(ptr),
 			   offset_in_page(ptr), size,
 			   dir, addr, true);
@@ -248,7 +314,9 @@ static inline void dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!valid_dma_direction(dir));
-	if (ops->unmap_page)
+	if (dma_is_direct(ops))
+		dma_direct_unmap_page(dev, addr, size, dir, attrs);
+	else if (ops->unmap_page)
 		ops->unmap_page(dev, addr, size, dir, attrs);
 	debug_dma_unmap_page(dev, addr, size, dir, true);
 }
@@ -265,7 +333,10 @@ static inline int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 	int ents;
 
 	BUG_ON(!valid_dma_direction(dir));
-	ents = ops->map_sg(dev, sg, nents, dir, attrs);
+	if (dma_is_direct(ops))
+		ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
+	else
+		ents = ops->map_sg(dev, sg, nents, dir, attrs);
 	BUG_ON(ents < 0);
 	debug_dma_map_sg(dev, sg, nents, ents, dir);
 
@@ -280,7 +351,9 @@ static inline void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg
 
 	BUG_ON(!valid_dma_direction(dir));
 	debug_dma_unmap_sg(dev, sg, nents, dir);
-	if (ops->unmap_sg)
+	if (dma_is_direct(ops))
+		dma_direct_unmap_sg(dev, sg, nents, dir, attrs);
+	else if (ops->unmap_sg)
 		ops->unmap_sg(dev, sg, nents, dir, attrs);
 }
 
@@ -294,7 +367,10 @@ static inline dma_addr_t dma_map_page_attrs(struct device *dev,
 	dma_addr_t addr;
 
 	BUG_ON(!valid_dma_direction(dir));
-	addr = ops->map_page(dev, page, offset, size, dir, attrs);
+	if (dma_is_direct(ops))
+		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
+	else
+		addr = ops->map_page(dev, page, offset, size, dir, attrs);
 	debug_dma_map_page(dev, page, offset, size, dir, addr, false);
 
 	return addr;
@@ -308,7 +384,9 @@ static inline void dma_unmap_page_attrs(struct device *dev,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!valid_dma_direction(dir));
-	if (ops->unmap_page)
+	if (dma_is_direct(ops))
+		dma_direct_unmap_page(dev, addr, size, dir, attrs);
+	else if (ops->unmap_page)
 		ops->unmap_page(dev, addr, size, dir, attrs);
 	debug_dma_unmap_page(dev, addr, size, dir, false);
 }
@@ -355,7 +433,9 @@ static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!valid_dma_direction(dir));
-	if (ops->sync_single_for_cpu)
+	if (dma_is_direct(ops))
+		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
+	else if (ops->sync_single_for_cpu)
 		ops->sync_single_for_cpu(dev, addr, size, dir);
 	debug_dma_sync_single_for_cpu(dev, addr, size, dir);
 }
@@ -374,7 +454,9 @@ static inline void dma_sync_single_for_device(struct device *dev,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!valid_dma_direction(dir));
-	if (ops->sync_single_for_device)
+	if (dma_is_direct(ops))
+		dma_direct_sync_single_for_device(dev, addr, size, dir);
+	else if (ops->sync_single_for_device)
 		ops->sync_single_for_device(dev, addr, size, dir);
 	debug_dma_sync_single_for_device(dev, addr, size, dir);
 }
@@ -393,7 +475,9 @@ dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!valid_dma_direction(dir));
-	if (ops->sync_sg_for_cpu)
+	if (dma_is_direct(ops))
+		dma_direct_sync_sg_for_cpu(dev, sg, nelems, dir);
+	else if (ops->sync_sg_for_cpu)
 		ops->sync_sg_for_cpu(dev, sg, nelems, dir);
 	debug_dma_sync_sg_for_cpu(dev, sg, nelems, dir);
 }
@@ -405,7 +489,9 @@ dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!valid_dma_direction(dir));
-	if (ops->sync_sg_for_device)
+	if (dma_is_direct(ops))
+		dma_direct_sync_sg_for_device(dev, sg, nelems, dir);
+	else if (ops->sync_sg_for_device)
 		ops->sync_sg_for_device(dev, sg, nelems, dir);
 	debug_dma_sync_sg_for_device(dev, sg, nelems, dir);
 
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 372c1955454a..cd535e7c67d7 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -223,6 +223,7 @@ void dma_direct_sync_single_for_device(struct device *dev,
 	if (!dev_is_dma_coherent(dev))
 		arch_sync_dma_for_device(dev, paddr, size, dir);
 }
+EXPORT_SYMBOL(dma_direct_sync_single_for_device);
 
 void dma_direct_sync_sg_for_device(struct device *dev,
 		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
@@ -240,6 +241,7 @@ void dma_direct_sync_sg_for_device(struct device *dev,
 					dir);
 	}
 }
+EXPORT_SYMBOL(dma_direct_sync_sg_for_device);
 #endif
 
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
@@ -258,6 +260,7 @@ void dma_direct_sync_single_for_cpu(struct device *dev,
 	if (is_swiotlb_buffer(paddr))
 		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_CPU);
 }
+EXPORT_SYMBOL(dma_direct_sync_single_for_cpu);
 
 void dma_direct_sync_sg_for_cpu(struct device *dev,
 		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
@@ -277,6 +280,7 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 	if (!dev_is_dma_coherent(dev))
 		arch_sync_dma_for_cpu_all(dev);
 }
+EXPORT_SYMBOL(dma_direct_sync_sg_for_cpu);
 
 void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
@@ -289,6 +293,7 @@ void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
 	if (is_swiotlb_buffer(phys))
 		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
 }
+EXPORT_SYMBOL(dma_direct_unmap_page);
 
 void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
 		int nents, enum dma_data_direction dir, unsigned long attrs)
@@ -300,11 +305,7 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
 		dma_direct_unmap_page(dev, sg->dma_address, sg_dma_len(sg), dir,
 			     attrs);
 }
-#else
-void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
-		int nents, enum dma_data_direction dir, unsigned long attrs)
-{
-}
+EXPORT_SYMBOL(dma_direct_unmap_sg);
 #endif
 
 static inline bool dma_direct_possible(struct device *dev, dma_addr_t dma_addr,
@@ -331,6 +332,7 @@ dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
 		arch_sync_dma_for_device(dev, phys, size, dir);
 	return dma_addr;
 }
+EXPORT_SYMBOL(dma_direct_map_page);
 
 int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		enum dma_data_direction dir, unsigned long attrs)
@@ -352,6 +354,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 	dma_direct_unmap_sg(dev, sgl, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
 	return 0;
 }
+EXPORT_SYMBOL(dma_direct_map_sg);
 
 /*
  * Because 32-bit DMA masks are so common we expect every architecture to be
-- 
2.19.1

