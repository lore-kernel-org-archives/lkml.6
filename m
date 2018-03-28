Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753988AbeC1Pk1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 11:40:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54371 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753710AbeC1Pk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 11:40:26 -0400
Date: Wed, 28 Mar 2018 08:40:12 -0700
From: tip-bot for Christoph Hellwig <tipbot@zytor.com>
Message-ID: <tip-e89f5b37015309a8bdf0b21d08007580b92f92a4@git.kernel.org>
Cc: sebott@linux.vnet.ibm.com, tglx@linutronix.de, hch@lst.de,
        mingo@kernel.org, Evgeniy.Didin@synopsys.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com,
        Evgeniy.Didin@synopsys.com, mingo@kernel.org, hch@lst.de,
        sebott@linux.vnet.ibm.com, tglx@linutronix.de
In-Reply-To: <20180328133535.17302-2-hch@lst.de>
References: <20180328133535.17302-2-hch@lst.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/dma] dma-mapping: Don't clear GFP_ZERO in dma_alloc_attrs
Git-Commit-ID: e89f5b37015309a8bdf0b21d08007580b92f92a4
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e89f5b37015309a8bdf0b21d08007580b92f92a4
Gitweb:     https://git.kernel.org/tip/e89f5b37015309a8bdf0b21d08007580b92f92a4
Author:     Christoph Hellwig <hch@lst.de>
AuthorDate: Wed, 28 Mar 2018 15:35:35 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Mar 2018 17:34:23 +0200

dma-mapping: Don't clear GFP_ZERO in dma_alloc_attrs

Revert the clearing of __GFP_ZERO in dma_alloc_attrs and move it to
dma_direct_alloc for now.  While most common architectures always zero dma
cohereny allocations (and x86 did so since day one) this is not documented
and at least arc and s390 do not zero without the explicit __GFP_ZERO
argument.

Fixes: 57bf5a8963f8 ("dma-mapping: clear harmful GFP_* flags in common code")
Reported-by: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
Reported-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
Cc: iommu@lists.linux-foundation.org
Link: https://lkml.kernel.org/r/20180328133535.17302-2-hch@lst.de

---
 include/linux/dma-mapping.h | 8 ++------
 lib/dma-direct.c            | 3 +++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index eb9eab4ecd6d..12fedcba9a9a 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -518,12 +518,8 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
 	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
 		return cpu_addr;
 
-	/*
-	 * Let the implementation decide on the zone to allocate from, and
-	 * decide on the way of zeroing the memory given that the memory
-	 * returned should always be zeroed.
-	 */
-	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM | __GFP_ZERO);
+	/* let the implementation decide on the zone to allocate from: */
+	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
 
 	if (!arch_dma_alloc_attrs(&dev, &flag))
 		return NULL;
diff --git a/lib/dma-direct.c b/lib/dma-direct.c
index 1277d293d4da..c0bba30fef0a 100644
--- a/lib/dma-direct.c
+++ b/lib/dma-direct.c
@@ -59,6 +59,9 @@ void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	struct page *page = NULL;
 	void *ret;
 
+	/* we always manually zero the memory once we are done: */
+	gfp &= ~__GFP_ZERO;
+
 	/* GFP_DMA32 and GFP_DMA are no ops without the corresponding zones: */
 	if (dev->coherent_dma_mask <= DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
 		gfp |= GFP_DMA;
