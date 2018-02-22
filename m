Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753688AbeBVLW0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 06:22:26 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:19600 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753512AbeBVLWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 06:22:25 -0500
X-UUID: 4d9a3e23ca4645a99fd962b21a432692-20180222
From: <miles.chen@mediatek.com>
To: Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
CC: <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH] lib/dma-debug.c: fix memory leakage
Date: Thu, 22 Feb 2018 19:22:20 +0800
Message-ID: <1519298540-3071-1-git-send-email-miles.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miles Chen <miles.chen@mediatek.com>

Marty reported a memory leakage introduced by commit 3aaabbf1c39e
("lib/dma-debug.c: fix incorrect pfn calculation"). Fix it
by checking the virtual address before allocating the entry.

This patch also use virt_addr_valid() instead of virt_to_page()
to check if a virtual address is linear.

Reported-by: Marty Faltesek <mfaltesek@google.com>
Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 lib/dma-debug.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/dma-debug.c b/lib/dma-debug.c
index 1b34d210452c..7f5cdc1e6b29 100644
--- a/lib/dma-debug.c
+++ b/lib/dma-debug.c
@@ -1491,12 +1491,12 @@ void debug_dma_alloc_coherent(struct device *dev, size_t size,
 	if (unlikely(virt == NULL))
 		return;
 
-	entry = dma_entry_alloc();
-	if (!entry)
+	/* handle vmalloc and linear addresses */
+	if (!is_vmalloc_addr(virt) && !virt_addr_valid(virt))
 		return;
 
-	/* handle vmalloc and linear addresses */
-	if (!is_vmalloc_addr(virt) && !virt_to_page(virt))
+	entry = dma_entry_alloc();
+	if (!entry)
 		return;
 
 	entry->type      = dma_debug_coherent;
@@ -1528,7 +1528,7 @@ void debug_dma_free_coherent(struct device *dev, size_t size,
 	};
 
 	/* handle vmalloc and linear addresses */
-	if (!is_vmalloc_addr(virt) && !virt_to_page(virt))
+	if (!is_vmalloc_addr(virt) && !virt_addr_valid(virt))
 		return;
 
 	if (is_vmalloc_addr(virt))
-- 
2.12.5
