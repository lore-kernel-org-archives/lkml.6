Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965728AbeCADTh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 22:19:37 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57454 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965696AbeCADTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 22:19:22 -0500
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: brouer@redhat.com, john.fastabend@gmail.com,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next 2/2] virtio-net: simplify XDP handling in small buffer
Date: Thu,  1 Mar 2018 11:19:05 +0800
Message-Id: <1519874345-10235-3-git-send-email-jasowang@redhat.com>
In-Reply-To: <1519874345-10235-1-git-send-email-jasowang@redhat.com>
References: <1519874345-10235-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to do data copy through xdp_linearize_page() for the buffer
without sufficient headroom, it brings extra complexity without
helping for the performance. So this patch remove it and switch to use
generic XDP routine to handle this case.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 93 ++++++------------------------------------------
 1 file changed, 10 insertions(+), 83 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 81190ba..3f14948 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -474,69 +474,6 @@ static unsigned int virtnet_get_headroom(struct virtnet_info *vi)
 	return vi->xdp_queue_pairs ? VIRTIO_XDP_HEADROOM : 0;
 }
 
-/* We copy the packet for XDP in the following cases:
- *
- * 1) Packet is scattered across multiple rx buffers.
- * 2) Headroom space is insufficient.
- *
- * This is inefficient but it's a temporary condition that
- * we hit right after XDP is enabled and until queue is refilled
- * with large buffers with sufficient headroom - so it should affect
- * at most queue size packets.
- * Afterwards, the conditions to enable
- * XDP should preclude the underlying device from sending packets
- * across multiple buffers (num_buf > 1), and we make sure buffers
- * have enough headroom.
- */
-static struct page *xdp_linearize_page(struct receive_queue *rq,
-				       u16 *num_buf,
-				       struct page *p,
-				       int offset,
-				       int page_off,
-				       unsigned int *len)
-{
-	struct page *page = alloc_page(GFP_ATOMIC);
-
-	if (!page)
-		return NULL;
-
-	memcpy(page_address(page) + page_off, page_address(p) + offset, *len);
-	page_off += *len;
-
-	while (--*num_buf) {
-		unsigned int buflen;
-		void *buf;
-		int off;
-
-		buf = virtqueue_get_buf(rq->vq, &buflen);
-		if (unlikely(!buf))
-			goto err_buf;
-
-		p = virt_to_head_page(buf);
-		off = buf - page_address(p);
-
-		/* guard against a misconfigured or uncooperative backend that
-		 * is sending packet larger than the MTU.
-		 */
-		if ((page_off + buflen) > PAGE_SIZE) {
-			put_page(p);
-			goto err_buf;
-		}
-
-		memcpy(page_address(page) + page_off,
-		       page_address(p) + off, buflen);
-		page_off += buflen;
-		put_page(p);
-	}
-
-	/* Headroom does not contribute to packet length */
-	*len = page_off - VIRTIO_XDP_HEADROOM;
-	return page;
-err_buf:
-	__free_pages(page, 0);
-	return NULL;
-}
-
 static struct sk_buff *virtnet_skb_xdp(struct receive_queue *rq,
 				       struct sk_buff *skb)
 {
@@ -573,8 +510,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
 			      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 	struct page *page = virt_to_head_page(buf);
 	unsigned int delta = 0;
-	struct page *xdp_page;
-	bool sent;
+	bool sent, skb_xdp = false;
 	int err;
 
 	len -= vi->hdr_len;
@@ -590,25 +526,14 @@ static struct sk_buff *receive_small(struct net_device *dev,
 		if (unlikely(hdr->hdr.gso_type))
 			goto err_xdp;
 
+		/* This happnes when headroom is not enough because
+		 * the buffer was refilled before XDP is set. This
+		 * only happen for several packets, for simplicity,
+		 * offload them to generic XDP routine.
+		 */
 		if (unlikely(xdp_headroom < virtnet_get_headroom(vi))) {
-			int offset = buf - page_address(page) + header_offset;
-			unsigned int tlen = len + vi->hdr_len;
-			u16 num_buf = 1;
-
-			xdp_headroom = virtnet_get_headroom(vi);
-			header_offset = VIRTNET_RX_PAD + xdp_headroom;
-			headroom = vi->hdr_len + header_offset;
-			buflen = SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
-				 SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-			xdp_page = xdp_linearize_page(rq, &num_buf, page,
-						      offset, header_offset,
-						      &tlen);
-			if (!xdp_page)
-				goto err_xdp;
-
-			buf = page_address(xdp_page);
-			put_page(page);
-			page = xdp_page;
+			skb_xdp = true;
+			goto skb_xdp;
 		}
 
 		xdp.data_hard_start = buf + VIRTNET_RX_PAD + vi->hdr_len;
@@ -650,6 +575,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
 	}
 	rcu_read_unlock();
 
+skb_xdp:
 	skb = build_skb(buf, buflen);
 	if (!skb) {
 		put_page(page);
@@ -662,6 +588,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
 		memcpy(skb_vnet_hdr(skb), buf, vi->hdr_len);
 	} /* keep zeroed vnet hdr since packet was changed by bpf */
 
+	skb = virtnet_skb_xdp(rq, skb);
 err:
 	return skb;
 
-- 
2.7.4
