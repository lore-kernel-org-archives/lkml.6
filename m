Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeEQRgd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 13:36:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52578 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbeEQRgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 13:36:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BB17660881
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-mm@kvack.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mm/dmapool: localize page allocations
Date: Thu, 17 May 2018 13:36:19 -0400
Message-Id: <1526578581-7658-1-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try to keep the pool closer to the device's NUMA node by changing kmalloc()
to kmalloc_node() and devres_alloc() to devres_alloc_node().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 mm/dmapool.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 4d90a64..023f3d9 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -223,7 +223,7 @@ static struct dma_page *pool_alloc_page(struct dma_pool *pool, gfp_t mem_flags)
 {
 	struct dma_page *page;
 
-	page = kmalloc(sizeof(*page), mem_flags);
+	page = kmalloc_node(sizeof(*page), mem_flags, dev_to_node(pool->dev));
 	if (!page)
 		return NULL;
 	page->vaddr = dma_alloc_coherent(pool->dev, pool->allocation,
@@ -504,7 +504,8 @@ struct dma_pool *dmam_pool_create(const char *name, struct device *dev,
 {
 	struct dma_pool **ptr, *pool;
 
-	ptr = devres_alloc(dmam_pool_release, sizeof(*ptr), GFP_KERNEL);
+	ptr = devres_alloc_node(dmam_pool_release, sizeof(*ptr), GFP_KERNEL,
+				dev_to_node(dev));
 	if (!ptr)
 		return NULL;
 
-- 
2.7.4
