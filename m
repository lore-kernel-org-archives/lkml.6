Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78567ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6C72084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DC6BbDSw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6C72084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731714AbeGSNjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 09:39:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34426 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731620AbeGSNji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 09:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=x6RXSh53hS1lcMeGzz6OwmXJ4b6tY/6usOk/RpovSPg=; b=DC6BbDSww8+760DbSuice8MYV
        pwTI8Nhz2q9lFvw0l+LAsyQeytHvB+z5k9M036H7H5c2TL+KWVuV/hOCsiC2Ykv84rUuFkbC5RRbt
        5VXt6x/j/Gz4XtnsVylspFTOn2PifmfJKGD1zbOqAaCSzWB0rBlPRdpkGEHe+9M2rSl8OZI/LnlCO
        KHrmm/qZ7Bc61Tu0N4z4f9LEA+E0RmH21G86499fysL0+TVsSJL+yLgLnk7eo1U0FCgeU5PYBpWXF
        2SUXBsQHZwRWVZVOloNWMWNcWIzMc+G7HKnWo05Hza+1LR86zbiQRPVWVHszOyXv8PPE9o800+2b6
        Cr94P0etg==;
Received: from [96.72.186.57] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fg8U0-0006RB-7g; Thu, 19 Jul 2018 12:56:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Richard Kuo <rkuo@codeaurora.org>
Cc:     linux-hexagon@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] hexagon: use generic dma_noncoherent_ops
Date:   Thu, 19 Jul 2018 05:56:35 -0700
Message-Id: <20180719125635.824-4-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180719125635.824-1-hch@lst.de>
References: <20180719125635.824-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to the generic noncoherent direct mapping implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/hexagon/Kconfig                   |   2 +
 arch/hexagon/include/asm/Kbuild        |   1 +
 arch/hexagon/include/asm/dma-mapping.h |  40 -------
 arch/hexagon/kernel/dma.c              | 148 ++-----------------------
 4 files changed, 11 insertions(+), 180 deletions(-)
 delete mode 100644 arch/hexagon/include/asm/dma-mapping.h

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 37adb2003033..bcbdcb32935c 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -4,6 +4,7 @@ comment "Linux Kernel Configuration for Hexagon"
 
 config HEXAGON
 	def_bool y
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select HAVE_OPROFILE
 	# Other pending projects/to-do items.
 	# select HAVE_REGS_AND_STACK_ACCESS_API
@@ -28,6 +29,7 @@ config HEXAGON
 	select GENERIC_CLOCKEVENTS_BROADCAST
 	select MODULES_USE_ELF_RELA
 	select GENERIC_CPU_DEVICES
+	select DMA_NONCOHERENT_OPS
 	---help---
 	  Qualcomm Hexagon is a processor architecture designed for high
 	  performance and low power across a wide variety of applications.
diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
index dd2fd9c0d292..47c4da3d64a4 100644
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -6,6 +6,7 @@ generic-y += compat.h
 generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
+generic-y += dma-mapping.h
 generic-y += emergency-restart.h
 generic-y += extable.h
 generic-y += fb.h
diff --git a/arch/hexagon/include/asm/dma-mapping.h b/arch/hexagon/include/asm/dma-mapping.h
deleted file mode 100644
index 263f6acbfb0f..000000000000
--- a/arch/hexagon/include/asm/dma-mapping.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- * DMA operations for the Hexagon architecture
- *
- * Copyright (c) 2010-2011, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
- */
-
-#ifndef _ASM_DMA_MAPPING_H
-#define _ASM_DMA_MAPPING_H
-
-#include <linux/types.h>
-#include <linux/cache.h>
-#include <linux/mm.h>
-#include <linux/scatterlist.h>
-#include <linux/dma-debug.h>
-#include <asm/io.h>
-
-struct device;
-
-extern const struct dma_map_ops *dma_ops;
-
-static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
-{
-	return dma_ops;
-}
-
-#endif
diff --git a/arch/hexagon/kernel/dma.c b/arch/hexagon/kernel/dma.c
index 9e46556a227d..ffc4ae8e126f 100644
--- a/arch/hexagon/kernel/dma.c
+++ b/arch/hexagon/kernel/dma.c
@@ -18,32 +18,19 @@
  * 02110-1301, USA.
  */
 
-#include <linux/dma-mapping.h>
-#include <linux/dma-direct.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/bootmem.h>
 #include <linux/genalloc.h>
-#include <asm/dma-mapping.h>
 #include <linux/module.h>
 #include <asm/page.h>
 
-#define HEXAGON_MAPPING_ERROR	0
-
-const struct dma_map_ops *dma_ops;
-EXPORT_SYMBOL(dma_ops);
-
-static inline void *dma_addr_to_virt(dma_addr_t dma_addr)
-{
-	return phys_to_virt((unsigned long) dma_addr);
-}
-
 static struct gen_pool *coherent_pool;
 
 
 /* Allocates from a pool of uncached memory that was reserved at boot time */
 
-static void *hexagon_dma_alloc_coherent(struct device *dev, size_t size,
-				 dma_addr_t *dma_addr, gfp_t flag,
-				 unsigned long attrs)
+void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_addr,
+		gfp_t flag, unsigned long attrs)
 {
 	void *ret;
 
@@ -75,58 +62,17 @@ static void *hexagon_dma_alloc_coherent(struct device *dev, size_t size,
 	return ret;
 }
 
-static void hexagon_free_coherent(struct device *dev, size_t size, void *vaddr,
-				  dma_addr_t dma_addr, unsigned long attrs)
+void arch_dma_free(struct device *dev, size_t size, void *vaddr,
+		dma_addr_t dma_addr, unsigned long attrs)
 {
 	gen_pool_free(coherent_pool, (unsigned long) vaddr, size);
 }
 
-static int check_addr(const char *name, struct device *hwdev,
-		      dma_addr_t bus, size_t size)
-{
-	if (hwdev && hwdev->dma_mask && !dma_capable(hwdev, bus, size)) {
-		if (*hwdev->dma_mask >= DMA_BIT_MASK(32))
-			printk(KERN_ERR
-				"%s: overflow %Lx+%zu of device mask %Lx\n",
-				name, (long long)bus, size,
-				(long long)*hwdev->dma_mask);
-		return 0;
-	}
-	return 1;
-}
-
-static int hexagon_map_sg(struct device *hwdev, struct scatterlist *sg,
-			  int nents, enum dma_data_direction dir,
-			  unsigned long attrs)
+void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
 {
-	struct scatterlist *s;
-	int i;
-
-	WARN_ON(nents == 0 || sg[0].length == 0);
-
-	for_each_sg(sg, s, nents, i) {
-		s->dma_address = sg_phys(s);
-		if (!check_addr("map_sg", hwdev, s->dma_address, s->length))
-			return 0;
-
-		s->dma_length = s->length;
+	void *addr = phys_to_virt(paddr);
 
-		if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
-			continue;
-
-		flush_dcache_range(dma_addr_to_virt(s->dma_address),
-				   dma_addr_to_virt(s->dma_address + s->length));
-	}
-
-	return nents;
-}
-
-/*
- * address is virtual
- */
-static inline void dma_sync(void *addr, size_t size,
-			    enum dma_data_direction dir)
-{
 	switch (dir) {
 	case DMA_TO_DEVICE:
 		hexagon_clean_dcache_range((unsigned long) addr,
@@ -144,81 +90,3 @@ static inline void dma_sync(void *addr, size_t size,
 		BUG();
 	}
 }
-
-/**
- * hexagon_map_page() - maps an address for device DMA
- * @dev:	pointer to DMA device
- * @page:	pointer to page struct of DMA memory
- * @offset:	offset within page
- * @size:	size of memory to map
- * @dir:	transfer direction
- * @attrs:	pointer to DMA attrs (not used)
- *
- * Called to map a memory address to a DMA address prior
- * to accesses to/from device.
- *
- * We don't particularly have many hoops to jump through
- * so far.  Straight translation between phys and virtual.
- *
- * DMA is not cache coherent so sync is necessary; this
- * seems to be a convenient place to do it.
- *
- */
-static dma_addr_t hexagon_map_page(struct device *dev, struct page *page,
-				   unsigned long offset, size_t size,
-				   enum dma_data_direction dir,
-				   unsigned long attrs)
-{
-	dma_addr_t bus = page_to_phys(page) + offset;
-	WARN_ON(size == 0);
-
-	if (!check_addr("map_single", dev, bus, size))
-		return HEXAGON_MAPPING_ERROR;
-
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		dma_sync(dma_addr_to_virt(bus), size, dir);
-
-	return bus;
-}
-
-static void hexagon_sync_single_for_device(struct device *dev,
-					dma_addr_t dma_handle, size_t size,
-					enum dma_data_direction dir)
-{
-	dma_sync(dma_addr_to_virt(dma_handle), size, dir);
-}
-
-static void hexagon_sync_sg_for_device(struct device *dev,
-		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
-{
-	struct scatterlist *sg;
-	int i;
-
-	for_each_sg(sgl, sg, nents, i)
-		hexagon_sync_single_for_device(dev, sg_dma_address(sg),
-				sg->length, dir);
-}
-
-
-static int hexagon_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return dma_addr == HEXAGON_MAPPING_ERROR;
-}
-
-const struct dma_map_ops hexagon_dma_ops = {
-	.alloc		= hexagon_dma_alloc_coherent,
-	.free		= hexagon_free_coherent,
-	.map_sg		= hexagon_map_sg,
-	.map_page	= hexagon_map_page,
-	.sync_single_for_device = hexagon_sync_single_for_device,
-	.sync_sg_for_device = hexagon_sync_sg_for_device,
-	.mapping_error	= hexagon_mapping_error,
-};
-
-void __init hexagon_dma_init(void)
-{
-	if (dma_ops)
-		return;
-
-	dma_ops = &hexagon_dma_ops;
-}
-- 
2.18.0

