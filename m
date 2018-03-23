Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752512AbeCWTy7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:54:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58399 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbeCWTy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:54:57 -0400
Date: Fri, 23 Mar 2018 12:54:47 -0700
From: tip-bot for Christoph Hellwig <tipbot@zytor.com>
Message-ID: <tip-0803e6051c1562e1525c3e044313390bf8b35c2b@git.kernel.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
        hpa@zytor.com, hch@lst.de, sfr@canb.auug.org.au
Reply-To: sfr@canb.auug.org.au, hch@lst.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <20180323174930.17767-1-hch@lst.de>
References: <20180323174930.17767-1-hch@lst.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/dma] swiotlb: Make swiotlb_{alloc,free}_buffer depend on
 CONFIG_DMA_DIRECT_OPS
Git-Commit-ID: 0803e6051c1562e1525c3e044313390bf8b35c2b
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

Commit-ID:  0803e6051c1562e1525c3e044313390bf8b35c2b
Gitweb:     https://git.kernel.org/tip/0803e6051c1562e1525c3e044313390bf8b35c2b
Author:     Christoph Hellwig <hch@lst.de>
AuthorDate: Fri, 23 Mar 2018 18:49:30 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 23 Mar 2018 20:15:38 +0100

swiotlb: Make swiotlb_{alloc,free}_buffer depend on CONFIG_DMA_DIRECT_OPS

Otherwise this causes unused symbol warnings for configs that build
swiotlb.c only for use by xen-swiotlb.c and that don't otherwise select
CONFIG_DMA_DIRECT_OPS, which is possible on arm.

Fixes: 16e73adbca76 ("dma/swiotlb: Remove swiotlb_{alloc,free}_coherent()")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: iommu@lists.linux-foundation.org
Cc: konrad.wilk@oracle.com
Link: https://lkml.kernel.org/r/20180323174930.17767-1-hch@lst.de
---
 lib/swiotlb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 15954b86f09e..47aeb04c1997 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -692,6 +692,7 @@ void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
 	}
 }
 
+#ifdef CONFIG_DMA_DIRECT_OPS
 static inline bool dma_coherent_ok(struct device *dev, dma_addr_t addr,
 		size_t size)
 {
@@ -763,6 +764,7 @@ static bool swiotlb_free_buffer(struct device *dev, size_t size,
 				 DMA_ATTR_SKIP_CPU_SYNC);
 	return true;
 }
+#endif
 
 static void
 swiotlb_full(struct device *dev, size_t size, enum dma_data_direction dir,
