Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8950FC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435EC20835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026506;
	bh=392aSnT/mJa7J5/GKfiyizPF2vgAiJF4zWLmY7VUBuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0DcKxGugIr477TAxg3CZUb/Tak19+1idOdQAX9i+yCj07V5tcD/XwCpjaWqcQ0KbR
	 w6O+r1xSLj2OqxaAWmgbB/iZZYB5YWaXyDz1Uf1FPhF/e2xAiyf/EYUUbQuPucEk9B
	 bIU5cF9kfk4fOmYgCrR6aLmQWlGEE8vTU7Tw/sLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390015AbfBMCzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:55:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:41116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388336AbfBMChf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:37:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09BDC206B6;
        Wed, 13 Feb 2019 02:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025454;
        bh=392aSnT/mJa7J5/GKfiyizPF2vgAiJF4zWLmY7VUBuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yGr/Kuz33CJ/GwLWqsJW/PT4t1igT6JUMaYGQppzqNFhjighB0SOfn+nyGFByJKz1
         PCVFSc+bFQVHk1yZ9PjLuMwnfVnLKBHfe6Mvvfiuw8OuMS3+0jLsC3wG0ckSntnU4j
         zcwfmLqka8OUw+kTrKYUuh+lu/GpPVdhimsqKc3Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stephen Warren <swarren@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 27/83] net/mlx4: Get rid of page operation after dma_alloc_coherent
Date:   Tue, 12 Feb 2019 21:36:05 -0500
Message-Id: <20190213023701.20286-27-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Warren <swarren@nvidia.com>

[ Upstream commit f65e192af35058e5c82da9e90871b472d24912bc ]

This patch solves a crash at the time of mlx4 driver unload or system
shutdown. The crash occurs because dma_alloc_coherent() returns one
value in mlx4_alloc_icm_coherent(), but a different value is passed to
dma_free_coherent() in mlx4_free_icm_coherent(). In turn this is because
when allocated, that pointer is passed to sg_set_buf() to record it,
then when freed it is re-calculated by calling
lowmem_page_address(sg_page()) which returns a different value. Solve
this by recording the value that dma_alloc_coherent() returns, and
passing this to dma_free_coherent().

This patch is roughly equivalent to commit 378efe798ecf ("RDMA/hns: Get
rid of page operation after dma_alloc_coherent").

Based-on-code-from: Christoph Hellwig <hch@lst.de>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx4/icm.c | 92 ++++++++++++++----------
 drivers/net/ethernet/mellanox/mlx4/icm.h | 22 +++++-
 2 files changed, 75 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/icm.c b/drivers/net/ethernet/mellanox/mlx4/icm.c
index 7262c6310650..288fca826a55 100644
--- a/drivers/net/ethernet/mellanox/mlx4/icm.c
+++ b/drivers/net/ethernet/mellanox/mlx4/icm.c
@@ -57,12 +57,12 @@ static void mlx4_free_icm_pages(struct mlx4_dev *dev, struct mlx4_icm_chunk *chu
 	int i;
 
 	if (chunk->nsg > 0)
-		pci_unmap_sg(dev->persist->pdev, chunk->mem, chunk->npages,
+		pci_unmap_sg(dev->persist->pdev, chunk->sg, chunk->npages,
 			     PCI_DMA_BIDIRECTIONAL);
 
 	for (i = 0; i < chunk->npages; ++i)
-		__free_pages(sg_page(&chunk->mem[i]),
-			     get_order(chunk->mem[i].length));
+		__free_pages(sg_page(&chunk->sg[i]),
+			     get_order(chunk->sg[i].length));
 }
 
 static void mlx4_free_icm_coherent(struct mlx4_dev *dev, struct mlx4_icm_chunk *chunk)
@@ -71,9 +71,9 @@ static void mlx4_free_icm_coherent(struct mlx4_dev *dev, struct mlx4_icm_chunk *
 
 	for (i = 0; i < chunk->npages; ++i)
 		dma_free_coherent(&dev->persist->pdev->dev,
-				  chunk->mem[i].length,
-				  lowmem_page_address(sg_page(&chunk->mem[i])),
-				  sg_dma_address(&chunk->mem[i]));
+				  chunk->buf[i].size,
+				  chunk->buf[i].addr,
+				  chunk->buf[i].dma_addr);
 }
 
 void mlx4_free_icm(struct mlx4_dev *dev, struct mlx4_icm *icm, int coherent)
@@ -111,22 +111,21 @@ static int mlx4_alloc_icm_pages(struct scatterlist *mem, int order,
 	return 0;
 }
 
-static int mlx4_alloc_icm_coherent(struct device *dev, struct scatterlist *mem,
-				    int order, gfp_t gfp_mask)
+static int mlx4_alloc_icm_coherent(struct device *dev, struct mlx4_icm_buf *buf,
+				   int order, gfp_t gfp_mask)
 {
-	void *buf = dma_alloc_coherent(dev, PAGE_SIZE << order,
-				       &sg_dma_address(mem), gfp_mask);
-	if (!buf)
+	buf->addr = dma_alloc_coherent(dev, PAGE_SIZE << order,
+				       &buf->dma_addr, gfp_mask);
+	if (!buf->addr)
 		return -ENOMEM;
 
-	if (offset_in_page(buf)) {
-		dma_free_coherent(dev, PAGE_SIZE << order,
-				  buf, sg_dma_address(mem));
+	if (offset_in_page(buf->addr)) {
+		dma_free_coherent(dev, PAGE_SIZE << order, buf->addr,
+				  buf->dma_addr);
 		return -ENOMEM;
 	}
 
-	sg_set_buf(mem, buf, PAGE_SIZE << order);
-	sg_dma_len(mem) = PAGE_SIZE << order;
+	buf->size = PAGE_SIZE << order;
 	return 0;
 }
 
@@ -159,21 +158,21 @@ struct mlx4_icm *mlx4_alloc_icm(struct mlx4_dev *dev, int npages,
 
 	while (npages > 0) {
 		if (!chunk) {
-			chunk = kmalloc_node(sizeof(*chunk),
+			chunk = kzalloc_node(sizeof(*chunk),
 					     gfp_mask & ~(__GFP_HIGHMEM |
 							  __GFP_NOWARN),
 					     dev->numa_node);
 			if (!chunk) {
-				chunk = kmalloc(sizeof(*chunk),
+				chunk = kzalloc(sizeof(*chunk),
 						gfp_mask & ~(__GFP_HIGHMEM |
 							     __GFP_NOWARN));
 				if (!chunk)
 					goto fail;
 			}
+			chunk->coherent = coherent;
 
-			sg_init_table(chunk->mem, MLX4_ICM_CHUNK_LEN);
-			chunk->npages = 0;
-			chunk->nsg    = 0;
+			if (!coherent)
+				sg_init_table(chunk->sg, MLX4_ICM_CHUNK_LEN);
 			list_add_tail(&chunk->list, &icm->chunk_list);
 		}
 
@@ -186,10 +185,10 @@ struct mlx4_icm *mlx4_alloc_icm(struct mlx4_dev *dev, int npages,
 
 		if (coherent)
 			ret = mlx4_alloc_icm_coherent(&dev->persist->pdev->dev,
-						      &chunk->mem[chunk->npages],
-						      cur_order, mask);
+						&chunk->buf[chunk->npages],
+						cur_order, mask);
 		else
-			ret = mlx4_alloc_icm_pages(&chunk->mem[chunk->npages],
+			ret = mlx4_alloc_icm_pages(&chunk->sg[chunk->npages],
 						   cur_order, mask,
 						   dev->numa_node);
 
@@ -205,7 +204,7 @@ struct mlx4_icm *mlx4_alloc_icm(struct mlx4_dev *dev, int npages,
 		if (coherent)
 			++chunk->nsg;
 		else if (chunk->npages == MLX4_ICM_CHUNK_LEN) {
-			chunk->nsg = pci_map_sg(dev->persist->pdev, chunk->mem,
+			chunk->nsg = pci_map_sg(dev->persist->pdev, chunk->sg,
 						chunk->npages,
 						PCI_DMA_BIDIRECTIONAL);
 
@@ -220,7 +219,7 @@ struct mlx4_icm *mlx4_alloc_icm(struct mlx4_dev *dev, int npages,
 	}
 
 	if (!coherent && chunk) {
-		chunk->nsg = pci_map_sg(dev->persist->pdev, chunk->mem,
+		chunk->nsg = pci_map_sg(dev->persist->pdev, chunk->sg,
 					chunk->npages,
 					PCI_DMA_BIDIRECTIONAL);
 
@@ -320,7 +319,7 @@ void *mlx4_table_find(struct mlx4_icm_table *table, u32 obj,
 	u64 idx;
 	struct mlx4_icm_chunk *chunk;
 	struct mlx4_icm *icm;
-	struct page *page = NULL;
+	void *addr = NULL;
 
 	if (!table->lowmem)
 		return NULL;
@@ -336,28 +335,49 @@ void *mlx4_table_find(struct mlx4_icm_table *table, u32 obj,
 
 	list_for_each_entry(chunk, &icm->chunk_list, list) {
 		for (i = 0; i < chunk->npages; ++i) {
+			dma_addr_t dma_addr;
+			size_t len;
+
+			if (table->coherent) {
+				len = chunk->buf[i].size;
+				dma_addr = chunk->buf[i].dma_addr;
+				addr = chunk->buf[i].addr;
+			} else {
+				struct page *page;
+
+				len = sg_dma_len(&chunk->sg[i]);
+				dma_addr = sg_dma_address(&chunk->sg[i]);
+
+				/* XXX: we should never do this for highmem
+				 * allocation.  This function either needs
+				 * to be split, or the kernel virtual address
+				 * return needs to be made optional.
+				 */
+				page = sg_page(&chunk->sg[i]);
+				addr = lowmem_page_address(page);
+			}
+
 			if (dma_handle && dma_offset >= 0) {
-				if (sg_dma_len(&chunk->mem[i]) > dma_offset)
-					*dma_handle = sg_dma_address(&chunk->mem[i]) +
-						dma_offset;
-				dma_offset -= sg_dma_len(&chunk->mem[i]);
+				if (len > dma_offset)
+					*dma_handle = dma_addr + dma_offset;
+				dma_offset -= len;
 			}
+
 			/*
 			 * DMA mapping can merge pages but not split them,
 			 * so if we found the page, dma_handle has already
 			 * been assigned to.
 			 */
-			if (chunk->mem[i].length > offset) {
-				page = sg_page(&chunk->mem[i]);
+			if (len > offset)
 				goto out;
-			}
-			offset -= chunk->mem[i].length;
+			offset -= len;
 		}
 	}
 
+	addr = NULL;
 out:
 	mutex_unlock(&table->mutex);
-	return page ? lowmem_page_address(page) + offset : NULL;
+	return addr ? addr + offset : NULL;
 }
 
 int mlx4_table_get_range(struct mlx4_dev *dev, struct mlx4_icm_table *table,
diff --git a/drivers/net/ethernet/mellanox/mlx4/icm.h b/drivers/net/ethernet/mellanox/mlx4/icm.h
index c9169a490557..d199874b1c07 100644
--- a/drivers/net/ethernet/mellanox/mlx4/icm.h
+++ b/drivers/net/ethernet/mellanox/mlx4/icm.h
@@ -47,11 +47,21 @@ enum {
 	MLX4_ICM_PAGE_SIZE	= 1 << MLX4_ICM_PAGE_SHIFT,
 };
 
+struct mlx4_icm_buf {
+	void			*addr;
+	size_t			size;
+	dma_addr_t		dma_addr;
+};
+
 struct mlx4_icm_chunk {
 	struct list_head	list;
 	int			npages;
 	int			nsg;
-	struct scatterlist	mem[MLX4_ICM_CHUNK_LEN];
+	bool			coherent;
+	union {
+		struct scatterlist	sg[MLX4_ICM_CHUNK_LEN];
+		struct mlx4_icm_buf	buf[MLX4_ICM_CHUNK_LEN];
+	};
 };
 
 struct mlx4_icm {
@@ -114,12 +124,18 @@ static inline void mlx4_icm_next(struct mlx4_icm_iter *iter)
 
 static inline dma_addr_t mlx4_icm_addr(struct mlx4_icm_iter *iter)
 {
-	return sg_dma_address(&iter->chunk->mem[iter->page_idx]);
+	if (iter->chunk->coherent)
+		return iter->chunk->buf[iter->page_idx].dma_addr;
+	else
+		return sg_dma_address(&iter->chunk->sg[iter->page_idx]);
 }
 
 static inline unsigned long mlx4_icm_size(struct mlx4_icm_iter *iter)
 {
-	return sg_dma_len(&iter->chunk->mem[iter->page_idx]);
+	if (iter->chunk->coherent)
+		return iter->chunk->buf[iter->page_idx].size;
+	else
+		return sg_dma_len(&iter->chunk->sg[iter->page_idx]);
 }
 
 int mlx4_MAP_ICM_AUX(struct mlx4_dev *dev, struct mlx4_icm *icm);
-- 
2.19.1

