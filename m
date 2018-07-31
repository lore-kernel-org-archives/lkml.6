Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B2FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB49208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB49208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732103AbeGaLXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:23:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730149AbeGaLXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:23:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B8C654021CC4;
        Tue, 31 Jul 2018 09:43:50 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-37.pek2.redhat.com [10.72.12.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D57DE10EE95C;
        Tue, 31 Jul 2018 09:43:47 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Subject: [PATCH net-next 2/2] virtio-net: get rid of unnecessary container of rq stats
Date:   Tue, 31 Jul 2018 17:43:39 +0800
Message-Id: <1533030219-9904-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1533030219-9904-1-git-send-email-jasowang@redhat.com>
References: <1533030219-9904-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 31 Jul 2018 09:43:50 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 31 Jul 2018 09:43:50 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't maintain tx counters in rx stats any more. There's no need
for an extra container of rq stats.

Cc: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 80 ++++++++++++++++++++++--------------------------
 1 file changed, 36 insertions(+), 44 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 72d3f68..14f661c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -87,7 +87,8 @@ struct virtnet_sq_stats {
 	u64 kicks;
 };
 
-struct virtnet_rq_stat_items {
+struct virtnet_rq_stats {
+	struct u64_stats_sync syncp;
 	u64 packets;
 	u64 bytes;
 	u64 drops;
@@ -98,17 +99,8 @@ struct virtnet_rq_stat_items {
 	u64 kicks;
 };
 
-struct virtnet_rq_stats {
-	struct u64_stats_sync syncp;
-	struct virtnet_rq_stat_items items;
-};
-
-struct virtnet_rx_stats {
-	struct virtnet_rq_stat_items rx;
-};
-
 #define VIRTNET_SQ_STAT(m)	offsetof(struct virtnet_sq_stats, m)
-#define VIRTNET_RQ_STAT(m)	offsetof(struct virtnet_rq_stat_items, m)
+#define VIRTNET_RQ_STAT(m)	offsetof(struct virtnet_rq_stats, m)
 
 static const struct virtnet_stat_desc virtnet_sq_stats_desc[] = {
 	{ "packets",		VIRTNET_SQ_STAT(packets) },
@@ -617,7 +609,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
 				     void *buf, void *ctx,
 				     unsigned int len,
 				     unsigned int *xdp_xmit,
-				     struct virtnet_rx_stats *stats)
+				     struct virtnet_rq_stats *stats)
 {
 	struct sk_buff *skb;
 	struct bpf_prog *xdp_prog;
@@ -632,7 +624,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
 	int err;
 
 	len -= vi->hdr_len;
-	stats->rx.bytes += len;
+	stats->bytes += len;
 
 	rcu_read_lock();
 	xdp_prog = rcu_dereference(rq->xdp_prog);
@@ -674,7 +666,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
 		xdp.rxq = &rq->xdp_rxq;
 		orig_data = xdp.data;
 		act = bpf_prog_run_xdp(xdp_prog, &xdp);
-		stats->rx.xdp_packets++;
+		stats->xdp_packets++;
 
 		switch (act) {
 		case XDP_PASS:
@@ -683,7 +675,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
 			len = xdp.data_end - xdp.data;
 			break;
 		case XDP_TX:
-			stats->rx.xdp_tx++;
+			stats->xdp_tx++;
 			xdpf = convert_to_xdp_frame(&xdp);
 			if (unlikely(!xdpf))
 				goto err_xdp;
@@ -696,7 +688,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
 			rcu_read_unlock();
 			goto xdp_xmit;
 		case XDP_REDIRECT:
-			stats->rx.xdp_redirects++;
+			stats->xdp_redirects++;
 			err = xdp_do_redirect(dev, &xdp, xdp_prog);
 			if (err)
 				goto err_xdp;
@@ -730,8 +722,8 @@ static struct sk_buff *receive_small(struct net_device *dev,
 
 err_xdp:
 	rcu_read_unlock();
-	stats->rx.xdp_drops++;
-	stats->rx.drops++;
+	stats->xdp_drops++;
+	stats->drops++;
 	put_page(page);
 xdp_xmit:
 	return NULL;
@@ -742,19 +734,19 @@ static struct sk_buff *receive_big(struct net_device *dev,
 				   struct receive_queue *rq,
 				   void *buf,
 				   unsigned int len,
-				   struct virtnet_rx_stats *stats)
+				   struct virtnet_rq_stats *stats)
 {
 	struct page *page = buf;
 	struct sk_buff *skb = page_to_skb(vi, rq, page, 0, len, PAGE_SIZE);
 
-	stats->rx.bytes += len - vi->hdr_len;
+	stats->bytes += len - vi->hdr_len;
 	if (unlikely(!skb))
 		goto err;
 
 	return skb;
 
 err:
-	stats->rx.drops++;
+	stats->drops++;
 	give_pages(rq, page);
 	return NULL;
 }
@@ -766,7 +758,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 					 void *ctx,
 					 unsigned int len,
 					 unsigned int *xdp_xmit,
-					 struct virtnet_rx_stats *stats)
+					 struct virtnet_rq_stats *stats)
 {
 	struct virtio_net_hdr_mrg_rxbuf *hdr = buf;
 	u16 num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
@@ -779,7 +771,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	int err;
 
 	head_skb = NULL;
-	stats->rx.bytes += len - vi->hdr_len;
+	stats->bytes += len - vi->hdr_len;
 
 	rcu_read_lock();
 	xdp_prog = rcu_dereference(rq->xdp_prog);
@@ -828,7 +820,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 		xdp.rxq = &rq->xdp_rxq;
 
 		act = bpf_prog_run_xdp(xdp_prog, &xdp);
-		stats->rx.xdp_packets++;
+		stats->xdp_packets++;
 
 		switch (act) {
 		case XDP_PASS:
@@ -853,7 +845,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 			}
 			break;
 		case XDP_TX:
-			stats->rx.xdp_tx++;
+			stats->xdp_tx++;
 			xdpf = convert_to_xdp_frame(&xdp);
 			if (unlikely(!xdpf))
 				goto err_xdp;
@@ -870,7 +862,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 			rcu_read_unlock();
 			goto xdp_xmit;
 		case XDP_REDIRECT:
-			stats->rx.xdp_redirects++;
+			stats->xdp_redirects++;
 			err = xdp_do_redirect(dev, &xdp, xdp_prog);
 			if (err) {
 				if (unlikely(xdp_page != page))
@@ -920,7 +912,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 			goto err_buf;
 		}
 
-		stats->rx.bytes += len;
+		stats->bytes += len;
 		page = virt_to_head_page(buf);
 
 		truesize = mergeable_ctx_to_truesize(ctx);
@@ -966,7 +958,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 
 err_xdp:
 	rcu_read_unlock();
-	stats->rx.xdp_drops++;
+	stats->xdp_drops++;
 err_skb:
 	put_page(page);
 	while (num_buf-- > 1) {
@@ -977,12 +969,12 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 			dev->stats.rx_length_errors++;
 			break;
 		}
-		stats->rx.bytes += len;
+		stats->bytes += len;
 		page = virt_to_head_page(buf);
 		put_page(page);
 	}
 err_buf:
-	stats->rx.drops++;
+	stats->drops++;
 	dev_kfree_skb(head_skb);
 xdp_xmit:
 	return NULL;
@@ -991,7 +983,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 			void *buf, unsigned int len, void **ctx,
 			unsigned int *xdp_xmit,
-			struct virtnet_rx_stats *stats)
+			struct virtnet_rq_stats *stats)
 {
 	struct net_device *dev = vi->dev;
 	struct sk_buff *skb;
@@ -1212,7 +1204,7 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
 	} while (rq->vq->num_free);
 	if (virtqueue_kick_prepare(rq->vq) && virtqueue_notify(rq->vq)) {
 		u64_stats_update_begin(&rq->stats.syncp);
-		rq->stats.items.kicks++;
+		rq->stats.kicks++;
 		u64_stats_update_end(&rq->stats.syncp);
 	}
 
@@ -1290,7 +1282,7 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 			   unsigned int *xdp_xmit)
 {
 	struct virtnet_info *vi = rq->vq->vdev->priv;
-	struct virtnet_rx_stats stats = {};
+	struct virtnet_rq_stats stats = {};
 	unsigned int len;
 	void *buf;
 	int i;
@@ -1298,16 +1290,16 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 	if (!vi->big_packets || vi->mergeable_rx_bufs) {
 		void *ctx;
 
-		while (stats.rx.packets < budget &&
+		while (stats.packets < budget &&
 		       (buf = virtqueue_get_buf_ctx(rq->vq, &len, &ctx))) {
 			receive_buf(vi, rq, buf, len, ctx, xdp_xmit, &stats);
-			stats.rx.packets++;
+			stats.packets++;
 		}
 	} else {
-		while (stats.rx.packets < budget &&
+		while (stats.packets < budget &&
 		       (buf = virtqueue_get_buf(rq->vq, &len)) != NULL) {
 			receive_buf(vi, rq, buf, len, NULL, xdp_xmit, &stats);
-			stats.rx.packets++;
+			stats.packets++;
 		}
 	}
 
@@ -1321,12 +1313,12 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 		size_t offset = virtnet_rq_stats_desc[i].offset;
 		u64 *item;
 
-		item = (u64 *)((u8 *)&rq->stats.items + offset);
-		*item += *(u64 *)((u8 *)&stats.rx + offset);
+		item = (u64 *)((u8 *)&rq->stats + offset);
+		*item += *(u64 *)((u8 *)&stats + offset);
 	}
 	u64_stats_update_end(&rq->stats.syncp);
 
-	return stats.rx.packets;
+	return stats.packets;
 }
 
 static void free_old_xmit_skbs(struct send_queue *sq)
@@ -1686,9 +1678,9 @@ static void virtnet_stats(struct net_device *dev,
 
 		do {
 			start = u64_stats_fetch_begin_irq(&rq->stats.syncp);
-			rpackets = rq->stats.items.packets;
-			rbytes   = rq->stats.items.bytes;
-			rdrops   = rq->stats.items.drops;
+			rpackets = rq->stats.packets;
+			rbytes   = rq->stats.bytes;
+			rdrops   = rq->stats.drops;
 		} while (u64_stats_fetch_retry_irq(&rq->stats.syncp, start));
 
 		tot->rx_packets += rpackets;
@@ -2078,7 +2070,7 @@ static void virtnet_get_ethtool_stats(struct net_device *dev,
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
 		struct receive_queue *rq = &vi->rq[i];
 
-		stats_base = (u8 *)&rq->stats.items;
+		stats_base = (u8 *)&rq->stats;
 		do {
 			start = u64_stats_fetch_begin_irq(&rq->stats.syncp);
 			for (j = 0; j < VIRTNET_RQ_STATS_LEN; j++) {
-- 
2.7.4

