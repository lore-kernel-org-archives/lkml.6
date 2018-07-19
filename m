Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7546CC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0552084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R2Rl1+/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F0552084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbeGSNpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 09:45:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36904 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbeGSNpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 09:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=73uzvUUvyq9ZZVZI8jOJWl6HjwqwSmytV2Y1+qykoMw=; b=R2Rl1+/yyI+7S8LYYopJEJxjI
        KB0SRY6IhsuPu0HKlMnlMhCWTDPwKaXartg7WKHHVkUehmaoI35Lc/G/TgbVKP5c6KXpXC3v8358h
        KmUW71SvUqPUfEBDOTr8xHtFw3O6c/Yj61nT1U5NrhLqIwYXtzwZ42OtOlVd4LCJfkgNGY94DnNb1
        CLnjR0yrROTqQJPdHPl7/HFgiXN2tPC7nxYbwmV4dagqE5Q9rJ7cJ8Yi4DrPezm072i1ckSuGXj4U
        yiVe5aB0vCKkMMMLecBvhFsod1JgoJQmZ0p032uf8RIbXI1+D91yB4HpzRgFtb+D81BkuOURWnw1U
        n3wrT1F+g==;
Received: from [96.72.186.57] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fg8Zm-0008Lk-73; Thu, 19 Jul 2018 13:02:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>
Cc:     openrisc@lists.librecores.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] openrisc: use generic dma_noncoherent_ops
Date:   Thu, 19 Jul 2018 06:02:32 -0700
Message-Id: <20180719130232.1819-5-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180719130232.1819-1-hch@lst.de>
References: <20180719130232.1819-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to the generic noncoherent direct mapping implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/openrisc/Kconfig                   |  2 +
 arch/openrisc/include/asm/Kbuild        |  1 +
 arch/openrisc/include/asm/dma-mapping.h | 35 -------------
 arch/openrisc/kernel/dma.c              | 65 ++++---------------------
 4 files changed, 12 insertions(+), 91 deletions(-)
 delete mode 100644 arch/openrisc/include/asm/dma-mapping.h

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 9ecad05bfc73..65e3c574c9d3 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -6,6 +6,8 @@
 
 config OPENRISC
 	def_bool y
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select DMA_NONCOHERENT_OPS
 	select OF
 	select OF_EARLY_FLATTREE
 	select IRQ_DOMAIN
diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index 65964d390b10..eb87cd8327c8 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -7,6 +7,7 @@ generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
 generic-y += dma.h
+generic-y += dma-mapping.h
 generic-y += emergency-restart.h
 generic-y += exec.h
 generic-y += extable.h
diff --git a/arch/openrisc/include/asm/dma-mapping.h b/arch/openrisc/include/asm/dma-mapping.h
deleted file mode 100644
index e212a1f0b6d2..000000000000
--- a/arch/openrisc/include/asm/dma-mapping.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * OpenRISC Linux
- *
- * Linux architectural port borrowing liberally from similar works of
- * others.  All original copyrights apply as per the original source
- * declaration.
- *
- * OpenRISC implementation:
- * Copyright (C) 2010-2011 Jonas Bonn <jonas@southpole.se>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#ifndef __ASM_OPENRISC_DMA_MAPPING_H
-#define __ASM_OPENRISC_DMA_MAPPING_H
-
-/*
- * See Documentation/DMA-API-HOWTO.txt and
- * Documentation/DMA-API.txt for documentation.
- */
-
-#include <linux/dma-debug.h>
-#include <linux/dma-mapping.h>
-
-extern const struct dma_map_ops or1k_dma_map_ops;
-
-static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
-{
-	return &or1k_dma_map_ops;
-}
-
-#endif	/* __ASM_OPENRISC_DMA_MAPPING_H */
diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index d6a0bf1fa713..159336adfa2f 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -19,9 +19,7 @@
  * the only thing implemented properly.  The rest need looking into...
  */
 
-#include <linux/dma-mapping.h>
-#include <linux/dma-debug.h>
-#include <linux/export.h>
+#include <linux/dma-noncoherent.h>
 
 #include <asm/cpuinfo.h>
 #include <asm/spr_defs.h>
@@ -80,10 +78,9 @@ page_clear_nocache(pte_t *pte, unsigned long addr,
  * is being ignored for now; uncached but write-combined memory is a
  * missing feature of the OR1K.
  */
-static void *
-or1k_dma_alloc(struct device *dev, size_t size,
-	       dma_addr_t *dma_handle, gfp_t gfp,
-	       unsigned long attrs)
+void *
+arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		gfp_t gfp, unsigned long attrs)
 {
 	unsigned long va;
 	void *page;
@@ -115,9 +112,9 @@ or1k_dma_alloc(struct device *dev, size_t size,
 	return (void *)va;
 }
 
-static void
-or1k_dma_free(struct device *dev, size_t size, void *vaddr,
-	      dma_addr_t dma_handle, unsigned long attrs)
+void
+arch_dma_free(struct device *dev, size_t size, void *vaddr,
+		dma_addr_t dma_handle, unsigned long attrs)
 {
 	unsigned long va = (unsigned long)vaddr;
 	struct mm_walk walk = {
@@ -133,13 +130,10 @@ or1k_dma_free(struct device *dev, size_t size, void *vaddr,
 	free_pages_exact(vaddr, size);
 }
 
-static void
-or1k_sync_single_for_device(struct device *dev,
-			    dma_addr_t dma_handle, size_t size,
-			    enum dma_data_direction dir)
+void arch_sync_dma_for_device(struct device *dev, phys_addr_t addr, size_t size,
+		enum dma_data_direction dir)
 {
 	unsigned long cl;
-	dma_addr_t addr = dma_handle;
 	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
 
 	switch (dir) {
@@ -163,45 +157,4 @@ or1k_sync_single_for_device(struct device *dev,
 		 */
 		break;
 	}
-
-}
-
-static dma_addr_t
-or1k_map_page(struct device *dev, struct page *page,
-	      unsigned long offset, size_t size,
-	      enum dma_data_direction dir,
-	      unsigned long attrs)
-{
-	unsigned long cl;
-	dma_addr_t addr = page_to_phys(page) + offset;
-	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
-
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		or1k_sync_single_for_device(dev, addr, size, dir);
-	return addr;
 }
-
-static int
-or1k_map_sg(struct device *dev, struct scatterlist *sg,
-	    int nents, enum dma_data_direction dir,
-	    unsigned long attrs)
-{
-	struct scatterlist *s;
-	int i;
-
-	for_each_sg(sg, s, nents, i) {
-		s->dma_address = or1k_map_page(dev, sg_page(s), s->offset,
-					       s->length, dir, 0);
-	}
-
-	return nents;
-}
-
-const struct dma_map_ops or1k_dma_map_ops = {
-	.alloc = or1k_dma_alloc,
-	.free = or1k_dma_free,
-	.map_page = or1k_map_page,
-	.map_sg = or1k_map_sg,
-	.sync_single_for_device = or1k_sync_single_for_device,
-};
-EXPORT_SYMBOL(or1k_dma_map_ops);
-- 
2.18.0

