Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60334ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA822084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ezjjE3gP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA822084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbeGSNpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 09:45:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36888 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730096AbeGSNpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 09:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oScx1wM+5RRN7CigzC9G+KwvvOhAAXH6QUTfFx90jmw=; b=ezjjE3gPkfWxjcSMTHUJvq8+I
        IMyGm4KWVvw+p3nErwuCcPlkXVhV6hSKBtN9YJE27ttZWxAgdreQWUGVTd2hH2o+vbvwe6JkAp9DA
        rY8WWYRK9LCQxicNuteSakZWZbdTO32Otq/qd+mSwtAIxw83aebviakLWjUVBlC1DQysWpjlQoT1B
        olbkupEps9Y26p36MlXyYdWkwpcl0kgYkwHdmIsx1QPRgWzi62MdrbnFsDZ9PUumawc0LA0bn+RIf
        PpPtNHJIGPCDoiZK+aKgVXklLirEnYCePGvfWb7HhIpx7F1PjTdqwzYZpnRyB+mL29k5IzBRZj4PH
        nhFaE+eEw==;
Received: from [96.72.186.57] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fg8Zl-0008Lh-SL; Thu, 19 Jul 2018 13:02:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>
Cc:     openrisc@lists.librecores.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] openrisc: fix cache maintainance the the sync_single_for_device DMA operation
Date:   Thu, 19 Jul 2018 06:02:31 -0700
Message-Id: <20180719130232.1819-4-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180719130232.1819-1-hch@lst.de>
References: <20180719130232.1819-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cache maintaince in the sync_single_for_device operation should be
equivalent to the map_page operation to facilitate reusing buffers.  Fix the
openrisc implementation by moving the cache maintaince performed in map_page
into the sync_single method, and calling that from map_page.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/openrisc/kernel/dma.c | 42 +++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index 7cadff93d179..d6a0bf1fa713 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -133,19 +133,15 @@ or1k_dma_free(struct device *dev, size_t size, void *vaddr,
 	free_pages_exact(vaddr, size);
 }
 
-static dma_addr_t
-or1k_map_page(struct device *dev, struct page *page,
-	      unsigned long offset, size_t size,
-	      enum dma_data_direction dir,
-	      unsigned long attrs)
+static void
+or1k_sync_single_for_device(struct device *dev,
+			    dma_addr_t dma_handle, size_t size,
+			    enum dma_data_direction dir)
 {
 	unsigned long cl;
-	dma_addr_t addr = page_to_phys(page) + offset;
+	dma_addr_t addr = dma_handle;
 	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
 
-	if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
-		return addr;
-
 	switch (dir) {
 	case DMA_TO_DEVICE:
 		/* Flush the dcache for the requested range */
@@ -168,6 +164,20 @@ or1k_map_page(struct device *dev, struct page *page,
 		break;
 	}
 
+}
+
+static dma_addr_t
+or1k_map_page(struct device *dev, struct page *page,
+	      unsigned long offset, size_t size,
+	      enum dma_data_direction dir,
+	      unsigned long attrs)
+{
+	unsigned long cl;
+	dma_addr_t addr = page_to_phys(page) + offset;
+	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
+
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		or1k_sync_single_for_device(dev, addr, size, dir);
 	return addr;
 }
 
@@ -187,20 +197,6 @@ or1k_map_sg(struct device *dev, struct scatterlist *sg,
 	return nents;
 }
 
-static void
-or1k_sync_single_for_device(struct device *dev,
-			    dma_addr_t dma_handle, size_t size,
-			    enum dma_data_direction dir)
-{
-	unsigned long cl;
-	dma_addr_t addr = dma_handle;
-	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
-
-	/* Flush the dcache for the requested range */
-	for (cl = addr; cl < addr + size; cl += cpuinfo->dcache_block_size)
-		mtspr(SPR_DCBFR, cl);
-}
-
 const struct dma_map_ops or1k_dma_map_ops = {
 	.alloc = or1k_dma_alloc,
 	.free = or1k_dma_free,
-- 
2.18.0

