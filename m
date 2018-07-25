Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A87C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E0620685
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t7GvfpzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E0620685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbeGYKvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:51:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43486 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728632AbeGYKvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Niq8j26ItwVFgXTHUC0I9d2uex8M1FL6TCOOiCLuoRs=; b=t7GvfpzK6ePBv748TT5uuDNug
        65WDolKXm7ZUwG88hpvPPScHmaPLKLQfO+XOrIzbsQfFU0FNtof3x1m08kVgFxdip7WWoLgJ4G8+m
        qfkHui3tKhE7vwtNNvA36+PwM3aF6XvSZHA/5gT60PwU+TwQTHHt4ZYw6a9Aj9Ldkb0BO+HHe+Kz/
        vjrS30WSiF+afEIEFJ+wGOSXaMtv8tR2JXA4GJpj/bJchIph1k271jRbq9xabRGxzxSy7cxoHeUz0
        /ikiueqWmcMElrmEAG0y/TNR+XGnEMIWZo7mNzmMFyi5aDq0ka1cU+Dw5a7W3uL7nDGxlpv/Al9ps
        PEOpJhO0w==;
Received: from [91.112.108.175] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fiGHp-0007Sb-Id; Wed, 25 Jul 2018 09:40:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        linux-sh@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] sh: simplify get_arch_dma_ops
Date:   Wed, 25 Jul 2018 11:40:39 +0200
Message-Id: <20180725094043.32443-2-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180725094043.32443-1-hch@lst.de>
References: <20180725094043.32443-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the indirection through the dma_ops variable, and just return
nommu_dma_ops directly from get_arch_dma_ops.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/include/asm/dma-mapping.h |  5 ++---
 arch/sh/kernel/dma-nommu.c        |  8 +-------
 arch/sh/mm/consistent.c           |  3 ---
 arch/sh/mm/init.c                 | 10 ----------
 4 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/arch/sh/include/asm/dma-mapping.h b/arch/sh/include/asm/dma-mapping.h
index 41167931e5d9..149e71f95be7 100644
--- a/arch/sh/include/asm/dma-mapping.h
+++ b/arch/sh/include/asm/dma-mapping.h
@@ -2,12 +2,11 @@
 #ifndef __ASM_SH_DMA_MAPPING_H
 #define __ASM_SH_DMA_MAPPING_H
 
-extern const struct dma_map_ops *dma_ops;
-extern void no_iommu_init(void);
+extern const struct dma_map_ops nommu_dma_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-	return dma_ops;
+	return &nommu_dma_ops;
 }
 
 extern void *dma_generic_alloc_coherent(struct device *dev, size_t size,
diff --git a/arch/sh/kernel/dma-nommu.c b/arch/sh/kernel/dma-nommu.c
index 3e3a32fc676e..79a9edafa5b0 100644
--- a/arch/sh/kernel/dma-nommu.c
+++ b/arch/sh/kernel/dma-nommu.c
@@ -79,10 +79,4 @@ const struct dma_map_ops nommu_dma_ops = {
 	.sync_sg_for_device	= nommu_sync_sg_for_device,
 #endif
 };
-
-void __init no_iommu_init(void)
-{
-	if (dma_ops)
-		return;
-	dma_ops = &nommu_dma_ops;
-}
+EXPORT_SYMBOL(nommu_dma_ops);
diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index fceb2adfcac7..e9d422bd42a5 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -20,9 +20,6 @@
 #include <asm/cacheflush.h>
 #include <asm/addrspace.h>
 
-const struct dma_map_ops *dma_ops;
-EXPORT_SYMBOL(dma_ops);
-
 void *dma_generic_alloc_coherent(struct device *dev, size_t size,
 				 dma_addr_t *dma_handle, gfp_t gfp,
 				 unsigned long attrs)
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 4034035fbede..7713c084d040 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -339,22 +339,12 @@ void __init paging_init(void)
 	free_area_init_nodes(max_zone_pfns);
 }
 
-/*
- * Early initialization for any I/O MMUs we might have.
- */
-static void __init iommu_init(void)
-{
-	no_iommu_init();
-}
-
 unsigned int mem_init_done = 0;
 
 void __init mem_init(void)
 {
 	pg_data_t *pgdat;
 
-	iommu_init();
-
 	high_memory = NULL;
 	for_each_online_pgdat(pgdat)
 		high_memory = max_t(void *, high_memory,
-- 
2.18.0

