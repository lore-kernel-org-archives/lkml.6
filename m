Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9ADECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD8420880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD8420880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388730AbeGWN2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:28:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45528 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387922AbeGWN2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:28:52 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 93322BDB;
        Mon, 23 Jul 2018 12:27:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Saeed Mahameed <saeedm@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 56/63] net/mlx4_en: Dont reuse RX page when XDP is set
Date:   Mon, 23 Jul 2018 14:25:02 +0200
Message-Id: <20180723122448.472348330@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122446.351334162@linuxfoundation.org>
References: <20180723122446.351334162@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Saeed Mahameed <saeedm@mellanox.com>

[ Upstream commit 432e629e56432064761be63bcd5e263c0920430d ]

When a new rx packet arrives, the rx path will decide whether to reuse
the remainder of the page or not according to one of the below conditions:
1. frag_info->frag_stride == PAGE_SIZE / 2
2. frags->page_offset + frag_info->frag_size > PAGE_SIZE;

The first condition is no met for when XDP is set.
For XDP, page_offset is always set to priv->rx_headroom which is
XDP_PACKET_HEADROOM and frag_info->frag_size is around mtu size + some
padding, still the 2nd release condition will hold since
XDP_PACKET_HEADROOM + 1536 < PAGE_SIZE, as a result the page will not
be released and will be _wrongly_ reused for next free rx descriptor.

In XDP there is an assumption to have a page per packet and reuse can
break such assumption and might cause packet data corruptions.

Fix this by adding an extra condition (!priv->rx_headroom) to the 2nd
case to avoid page reuse when XDP is set, since rx_headroom is set to 0
for non XDP setup and set to XDP_PACKET_HEADROOM for XDP setup.

No additional cache line is required for the new condition.

Fixes: 34db548bfb95 ("mlx4: add page recycling in receive path")
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Suggested-by: Martin KaFai Lau <kafai@fb.com>
CC: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_rx.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -474,10 +474,10 @@ static int mlx4_en_complete_rx_desc(stru
 {
 	const struct mlx4_en_frag_info *frag_info = priv->frag_info;
 	unsigned int truesize = 0;
+	bool release = true;
 	int nr, frag_size;
 	struct page *page;
 	dma_addr_t dma;
-	bool release;
 
 	/* Collect used fragments while replacing them in the HW descriptors */
 	for (nr = 0;; frags++) {
@@ -500,7 +500,11 @@ static int mlx4_en_complete_rx_desc(stru
 			release = page_count(page) != 1 ||
 				  page_is_pfmemalloc(page) ||
 				  page_to_nid(page) != numa_mem_id();
-		} else {
+		} else if (!priv->rx_headroom) {
+			/* rx_headroom for non XDP setup is always 0.
+			 * When XDP is set, the above condition will
+			 * guarantee page is always released.
+			 */
 			u32 sz_align = ALIGN(frag_size, SMP_CACHE_BYTES);
 
 			frags->page_offset += sz_align;


