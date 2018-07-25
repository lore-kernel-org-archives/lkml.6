Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CEDC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBE720685
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VwPLkYWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBE720685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbeGYKwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:52:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43544 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728694AbeGYKwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8zDp8XDIFXvRBeRTZNhL7LfrjVgqeU+Ui97cbyEsJMo=; b=VwPLkYWfE+8m3gRO46QCivGEw
        0KkcbHHoMa5LdeS4dlXIjSGV56JM0qbQcL+zjoXuaqGSPSWOc7fPUkfAViBJ4Gf06DJC2N3tmzqiv
        Thry5YVaDPqOLrCqh7bof84Qli0KloBXQtgJldLn2o+r3nYo5A+s8w080219WC+djIlvxGj/QLjes
        UR94bCCEUYGk56cbdRIZxdawEvpQXbPIcekmp3v5QSmuV07/nXxcWD6+w1HNTG4MqUqNQFUqyxmwY
        KBEHGb8zgL+lo70ZS/PKTB5rr8injwEq1mGdmRaDSPnvOGL9iTg1H9wROk2BXrLRedvaL5HCk+zRp
        BNGy7A5TA==;
Received: from [91.112.108.175] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fiGI1-0007Tl-5u; Wed, 25 Jul 2018 09:41:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        linux-sh@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] sh: use generic dma_noncoherent_ops
Date:   Wed, 25 Jul 2018 11:40:43 +0200
Message-Id: <20180725094043.32443-6-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180725094043.32443-1-hch@lst.de>
References: <20180725094043.32443-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to the generic noncoherent direct mapping implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/Kconfig                   |  3 +-
 arch/sh/include/asm/Kbuild        |  1 +
 arch/sh/include/asm/dma-mapping.h | 26 -----------
 arch/sh/kernel/Makefile           |  2 +-
 arch/sh/kernel/dma-coherent.c     | 23 +++++----
 arch/sh/kernel/dma-nommu.c        | 78 -------------------------------
 6 files changed, 15 insertions(+), 118 deletions(-)
 delete mode 100644 arch/sh/include/asm/dma-mapping.h
 delete mode 100644 arch/sh/kernel/dma-nommu.c

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index c9993a0cdc7e..da4db4b5359f 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -51,7 +51,6 @@ config SUPERH
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_NMI
-	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
 
 	help
@@ -164,6 +163,8 @@ config DMA_COHERENT
 
 config DMA_NONCOHERENT
 	def_bool !DMA_COHERENT
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select DMA_NONCOHERENT_OPS
 
 config PGTABLE_LEVELS
 	default 3 if X2TLB
diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index 46dd82ab2c29..6a5609a55965 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -2,6 +2,7 @@ generic-y += compat.h
 generic-y += current.h
 generic-y += delay.h
 generic-y += div64.h
+generic-y += dma-mapping.h
 generic-y += emergency-restart.h
 generic-y += exec.h
 generic-y += irq_regs.h
diff --git a/arch/sh/include/asm/dma-mapping.h b/arch/sh/include/asm/dma-mapping.h
deleted file mode 100644
index 1ebc6a4eb1c5..000000000000
--- a/arch/sh/include/asm/dma-mapping.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_SH_DMA_MAPPING_H
-#define __ASM_SH_DMA_MAPPING_H
-
-extern const struct dma_map_ops nommu_dma_ops;
-
-static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
-{
-#ifdef CONFIG_DMA_NONCOHERENT
-	return &nommu_dma_ops;
-#else
-	return &dma_direct_ops;
-#endif
-}
-
-extern void *dma_generic_alloc_coherent(struct device *dev, size_t size,
-					dma_addr_t *dma_addr, gfp_t flag,
-					unsigned long attrs);
-extern void dma_generic_free_coherent(struct device *dev, size_t size,
-				      void *vaddr, dma_addr_t dma_handle,
-				      unsigned long attrs);
-
-void sh_sync_dma_for_device(void *vaddr, size_t size,
-	    enum dma_data_direction dir);
-
-#endif /* __ASM_SH_DMA_MAPPING_H */
diff --git a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
index d5ddb64bfffe..59673f8a3379 100644
--- a/arch/sh/kernel/Makefile
+++ b/arch/sh/kernel/Makefile
@@ -45,7 +45,7 @@ obj-$(CONFIG_DUMP_CODE)		+= disassemble.o
 obj-$(CONFIG_HIBERNATION)	+= swsusp.o
 obj-$(CONFIG_DWARF_UNWINDER)	+= dwarf.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_callchain.o
-obj-$(CONFIG_DMA_NONCOHERENT)	+= dma-nommu.o dma-coherent.o
+obj-$(CONFIG_DMA_NONCOHERENT)	+= dma-coherent.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)		+= hw_breakpoint.o
 
 ccflags-y := -Werror
diff --git a/arch/sh/kernel/dma-coherent.c b/arch/sh/kernel/dma-coherent.c
index 2518065d5d27..a0021eef956b 100644
--- a/arch/sh/kernel/dma-coherent.c
+++ b/arch/sh/kernel/dma-coherent.c
@@ -7,14 +7,13 @@
  */
 #include <linux/mm.h>
 #include <linux/init.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/module.h>
 #include <asm/cacheflush.h>
 #include <asm/addrspace.h>
 
-void *dma_generic_alloc_coherent(struct device *dev, size_t size,
-				 dma_addr_t *dma_handle, gfp_t gfp,
-				 unsigned long attrs)
+void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		gfp_t gfp, unsigned long attrs)
 {
 	void *ret, *ret_nocache;
 	int order = get_order(size);
@@ -29,7 +28,8 @@ void *dma_generic_alloc_coherent(struct device *dev, size_t size,
 	 * Pages from the page allocator may have data present in
 	 * cache. So flush the cache before using uncached memory.
 	 */
-	sh_sync_dma_for_device(ret, size, DMA_BIDIRECTIONAL);
+	arch_sync_dma_for_device(dev, virt_to_phys(ret), size,
+			DMA_BIDIRECTIONAL);
 
 	ret_nocache = (void __force *)ioremap_nocache(virt_to_phys(ret), size);
 	if (!ret_nocache) {
@@ -46,9 +46,8 @@ void *dma_generic_alloc_coherent(struct device *dev, size_t size,
 	return ret_nocache;
 }
 
-void dma_generic_free_coherent(struct device *dev, size_t size,
-			       void *vaddr, dma_addr_t dma_handle,
-			       unsigned long attrs)
+void arch_dma_free(struct device *dev, size_t size, void *vaddr,
+		dma_addr_t dma_handle, unsigned long attrs)
 {
 	int order = get_order(size);
 	unsigned long pfn = (dma_handle >> PAGE_SHIFT);
@@ -63,12 +62,12 @@ void dma_generic_free_coherent(struct device *dev, size_t size,
 	iounmap(vaddr);
 }
 
-void sh_sync_dma_for_device(void *vaddr, size_t size,
-		    enum dma_data_direction direction)
+void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
 {
-	void *addr = sh_cacheop_vaddr(vaddr);
+	void *addr = sh_cacheop_vaddr(phys_to_virt(paddr));
 
-	switch (direction) {
+	switch (dir) {
 	case DMA_FROM_DEVICE:		/* invalidate only */
 		__flush_invalidate_region(addr, size);
 		break;
diff --git a/arch/sh/kernel/dma-nommu.c b/arch/sh/kernel/dma-nommu.c
deleted file mode 100644
index d8689b1cb743..000000000000
--- a/arch/sh/kernel/dma-nommu.c
+++ /dev/null
@@ -1,78 +0,0 @@
-/*
- * DMA mapping support for platforms lacking IOMMUs.
- *
- * Copyright (C) 2009  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-#include <linux/dma-mapping.h>
-#include <linux/io.h>
-#include <asm/cacheflush.h>
-
-static dma_addr_t nommu_map_page(struct device *dev, struct page *page,
-				 unsigned long offset, size_t size,
-				 enum dma_data_direction dir,
-				 unsigned long attrs)
-{
-	dma_addr_t addr = page_to_phys(page) + offset
-		- PFN_PHYS(dev->dma_pfn_offset);
-
-	WARN_ON(size == 0);
-
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		sh_sync_dma_for_device(page_address(page) + offset, size, dir);
-
-	return addr;
-}
-
-static int nommu_map_sg(struct device *dev, struct scatterlist *sg,
-			int nents, enum dma_data_direction dir,
-			unsigned long attrs)
-{
-	struct scatterlist *s;
-	int i;
-
-	WARN_ON(nents == 0 || sg[0].length == 0);
-
-	for_each_sg(sg, s, nents, i) {
-		dma_addr_t offset = PFN_PHYS(dev->dma_pfn_offset);
-
-		BUG_ON(!sg_page(s));
-
-		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-			sh_sync_dma_for_device(sg_virt(s), s->length, dir);
-
-		s->dma_address = sg_phys(s) - offset;
-		s->dma_length = s->length;
-	}
-
-	return nents;
-}
-
-static void nommu_sync_single_for_device(struct device *dev, dma_addr_t addr,
-			      size_t size, enum dma_data_direction dir)
-{
-	sh_sync_dma_for_device(phys_to_virt(addr), size, dir);
-}
-
-static void nommu_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
-			  int nelems, enum dma_data_direction dir)
-{
-	struct scatterlist *s;
-	int i;
-
-	for_each_sg(sg, s, nelems, i)
-		sh_sync_dma_for_device(sg_virt(s), s->length, dir);
-}
-
-const struct dma_map_ops nommu_dma_ops = {
-	.alloc			= dma_generic_alloc_coherent,
-	.free			= dma_generic_free_coherent,
-	.map_page		= nommu_map_page,
-	.map_sg			= nommu_map_sg,
-	.sync_single_for_device	= nommu_sync_single_for_device,
-	.sync_sg_for_device	= nommu_sync_sg_for_device,
-};
-EXPORT_SYMBOL(nommu_dma_ops);
-- 
2.18.0

