Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EDAC04EBF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F80223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F80223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388162AbeKOTuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:50:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50052 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729039AbeKOTuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:50:23 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 748EFC0495AD;
        Thu, 15 Nov 2018 09:43:18 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-99.pek2.redhat.com [10.72.12.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E7DDA1A92C;
        Thu, 15 Nov 2018 09:43:12 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] vhost_net: mitigate page reference counting during page frag refill
Date:   Thu, 15 Nov 2018 17:43:09 +0800
Message-Id: <20181115094310.17307-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 15 Nov 2018 09:43:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do a get_page() which involves a atomic operation. This patch tries
to mitigate a per packet atomic operation by maintaining a reference
bias which is initially USHRT_MAX. Each time a page is got, instead of
calling get_page() we decrease the bias and when we find it's time to
use a new page we will decrease the bias at one time through
__page_cache_drain_cache().

Testpmd(virtio_user + vhost_net) + XDP_DROP on TAP shows about 1.6%
improvement.

Before: 4.63Mpps
After:  4.71Mpps

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 54 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index ab11b2bee273..d919284f103b 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -141,6 +141,10 @@ struct vhost_net {
 	unsigned tx_zcopy_err;
 	/* Flush in progress. Protected by tx vq lock. */
 	bool tx_flush;
+	/* Private page frag */
+	struct page_frag page_frag;
+	/* Refcount bias of page frag */
+	int refcnt_bias;
 };
 
 static unsigned vhost_net_zcopy_mask __read_mostly;
@@ -637,14 +641,53 @@ static bool tx_can_batch(struct vhost_virtqueue *vq, size_t total_len)
 	       !vhost_vq_avail_empty(vq->dev, vq);
 }
 
+#define SKB_FRAG_PAGE_ORDER     get_order(32768)
+
+static bool vhost_net_page_frag_refill(struct vhost_net *net, unsigned int sz,
+				       struct page_frag *pfrag, gfp_t gfp)
+{
+	if (pfrag->page) {
+		if (pfrag->offset + sz <= pfrag->size)
+			return true;
+		__page_frag_cache_drain(pfrag->page, net->refcnt_bias);
+	}
+
+	pfrag->offset = 0;
+	net->refcnt_bias = 0;
+	if (SKB_FRAG_PAGE_ORDER) {
+		/* Avoid direct reclaim but allow kswapd to wake */
+		pfrag->page = alloc_pages((gfp & ~__GFP_DIRECT_RECLAIM) |
+					  __GFP_COMP | __GFP_NOWARN |
+					  __GFP_NORETRY,
+					  SKB_FRAG_PAGE_ORDER);
+		if (likely(pfrag->page)) {
+			pfrag->size = PAGE_SIZE << SKB_FRAG_PAGE_ORDER;
+			goto done;
+		}
+	}
+	pfrag->page = alloc_page(gfp);
+	if (likely(pfrag->page)) {
+		pfrag->size = PAGE_SIZE;
+		goto done;
+	}
+	return false;
+
+done:
+	net->refcnt_bias = USHRT_MAX;
+	page_ref_add(pfrag->page, USHRT_MAX - 1);
+	return true;
+}
+
 #define VHOST_NET_RX_PAD (NET_IP_ALIGN + NET_SKB_PAD)
 
 static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
 			       struct iov_iter *from)
 {
 	struct vhost_virtqueue *vq = &nvq->vq;
+	struct vhost_net *net = container_of(vq->dev, struct vhost_net,
+					     dev);
 	struct socket *sock = vq->private_data;
-	struct page_frag *alloc_frag = &current->task_frag;
+	struct page_frag *alloc_frag = &net->page_frag;
 	struct virtio_net_hdr *gso;
 	struct xdp_buff *xdp = &nvq->xdp[nvq->batched_xdp];
 	struct tun_xdp_hdr *hdr;
@@ -665,7 +708,8 @@ static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
 
 	buflen += SKB_DATA_ALIGN(len + pad);
 	alloc_frag->offset = ALIGN((u64)alloc_frag->offset, SMP_CACHE_BYTES);
-	if (unlikely(!skb_page_frag_refill(buflen, alloc_frag, GFP_KERNEL)))
+	if (unlikely(!vhost_net_page_frag_refill(net, buflen,
+						 alloc_frag, GFP_KERNEL)))
 		return -ENOMEM;
 
 	buf = (char *)page_address(alloc_frag->page) + alloc_frag->offset;
@@ -703,7 +747,7 @@ static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
 	xdp->data_end = xdp->data + len;
 	hdr->buflen = buflen;
 
-	get_page(alloc_frag->page);
+	--net->refcnt_bias;
 	alloc_frag->offset += buflen;
 
 	++nvq->batched_xdp;
@@ -1292,6 +1336,8 @@ static int vhost_net_open(struct inode *inode, struct file *f)
 	vhost_poll_init(n->poll + VHOST_NET_VQ_RX, handle_rx_net, EPOLLIN, dev);
 
 	f->private_data = n;
+	n->page_frag.page = NULL;
+	n->refcnt_bias = 0;
 
 	return 0;
 }
@@ -1366,6 +1412,8 @@ static int vhost_net_release(struct inode *inode, struct file *f)
 	kfree(n->vqs[VHOST_NET_VQ_RX].rxq.queue);
 	kfree(n->vqs[VHOST_NET_VQ_TX].xdp);
 	kfree(n->dev.vqs);
+	if (n->page_frag.page)
+		__page_frag_cache_drain(n->page_frag.page, n->refcnt_bias);
 	kvfree(n);
 	return 0;
 }
-- 
2.17.1

