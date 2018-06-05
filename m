Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753876AbeFERH3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:07:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753409AbeFERH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:07:26 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "tariqt@mellanox.com, davem@davemloft.net, Sarah Newman"
        <srn@prgmr.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>, Sarah Newman <srn@prgmr.com>
Subject: [PATCH 4.9 47/61] net/mlx4_en: fix potential use-after-free with dma_unmap_page
Date: Tue,  5 Jun 2018 19:02:08 +0200
Message-Id: <20180605170120.705206058@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605170117.643936916@linuxfoundation.org>
References: <20180605170117.643936916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sarah Newman <srn@prgmr.com>

[ Not relevant upstream, therefore no upstream commit. ]

To fix, unmap the page as soon as possible.

When swiotlb is in use, calling dma_unmap_page means that
the original page mapped with dma_map_page must still be valid,
as swiotlb will copy data from its internal cache back to the
originally requested DMA location.

When GRO is enabled, before this patch all references to the
original frag may be put and the page freed before dma_unmap_page
in mlx4_en_free_frag is called.

It is possible there is a path where the use-after-free occurs
even with GRO disabled, but this has not been observed so far.

The bug can be trivially detected by doing the following:

* Compile the kernel with DEBUG_PAGEALLOC
* Run the kernel as a Xen Dom0
* Leave GRO enabled on the interface
* Run a 10 second or more test with iperf over the interface.

This bug was likely introduced in
commit 4cce66cdd14a ("mlx4_en: map entire pages to increase throughput"),
first part of u3.6.

It was incidentally fixed in
commit 34db548bfb95 ("mlx4: add page recycling in receive path"),
first part of v4.12.

This version applies to the v4.9 series.

Signed-off-by: Sarah Newman <srn@prgmr.com>
Tested-by: Sarah Newman <srn@prgmr.com>
Cc: Tariq Toukan <tariqt@mellanox.com>
Cc: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_rx.c |   32 ++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 12 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -142,16 +142,17 @@ static void mlx4_en_free_frag(struct mlx
 			      struct mlx4_en_rx_alloc *frags,
 			      int i)
 {
-	const struct mlx4_en_frag_info *frag_info = &priv->frag_info[i];
-	u32 next_frag_end = frags[i].page_offset + 2 * frag_info->frag_stride;
-
-
-	if (next_frag_end > frags[i].page_size)
-		dma_unmap_page(priv->ddev, frags[i].dma, frags[i].page_size,
-			       frag_info->dma_dir);
+	if (frags[i].page) {
+		const struct mlx4_en_frag_info *frag_info = &priv->frag_info[i];
+		u32 next_frag_end = frags[i].page_offset +
+				2 * frag_info->frag_stride;
 
-	if (frags[i].page)
+		if (next_frag_end > frags[i].page_size) {
+			dma_unmap_page(priv->ddev, frags[i].dma,
+				       frags[i].page_size, frag_info->dma_dir);
+		}
 		put_page(frags[i].page);
+	}
 }
 
 static int mlx4_en_init_allocator(struct mlx4_en_priv *priv,
@@ -586,21 +587,28 @@ static int mlx4_en_complete_rx_desc(stru
 				    int length)
 {
 	struct skb_frag_struct *skb_frags_rx = skb_shinfo(skb)->frags;
-	struct mlx4_en_frag_info *frag_info;
 	int nr;
 	dma_addr_t dma;
 
 	/* Collect used fragments while replacing them in the HW descriptors */
 	for (nr = 0; nr < priv->num_frags; nr++) {
-		frag_info = &priv->frag_info[nr];
+		struct mlx4_en_frag_info *frag_info = &priv->frag_info[nr];
+		u32 next_frag_end = frags[nr].page_offset +
+				2 * frag_info->frag_stride;
+
 		if (length <= frag_info->frag_prefix_size)
 			break;
 		if (unlikely(!frags[nr].page))
 			goto fail;
 
 		dma = be64_to_cpu(rx_desc->data[nr].addr);
-		dma_sync_single_for_cpu(priv->ddev, dma, frag_info->frag_size,
-					DMA_FROM_DEVICE);
+		if (next_frag_end > frags[nr].page_size)
+			dma_unmap_page(priv->ddev, frags[nr].dma,
+				       frags[nr].page_size, frag_info->dma_dir);
+		else
+			dma_sync_single_for_cpu(priv->ddev, dma,
+						frag_info->frag_size,
+						DMA_FROM_DEVICE);
 
 		/* Save page reference in skb */
 		__skb_frag_set_page(&skb_frags_rx[nr], frags[nr].page);
