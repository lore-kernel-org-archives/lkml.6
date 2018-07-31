Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193BCC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16CF20857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D16CF20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732080AbeGaLXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:23:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730149AbeGaLXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:23:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 153114021CC4;
        Tue, 31 Jul 2018 09:43:47 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-37.pek2.redhat.com [10.72.12.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98B9E10EE95C;
        Tue, 31 Jul 2018 09:43:41 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Subject: [PATCH net-next 1/2] virtio-net: correctly update XDP_TX counters
Date:   Tue, 31 Jul 2018 17:43:38 +0800
Message-Id: <1533030219-9904-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 31 Jul 2018 09:43:47 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 31 Jul 2018 09:43:47 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5b8f3c8d30a6 ("virtio_net: Add XDP related stats") tries to
count TX XDP stats in virtnet_receive(). This will cause several
issues:

- virtnet_xdp_sq() was called without checking whether or not XDP is
  set. This may cause out of bound access when there's no enough txq
  for XDP.
- Stats were updated even if there's no XDP/XDP_TX.

Fixing this by reusing virtnet_xdp_xmit() for XDP_TX which can counts
TX XDP counter itself and remove the unnecessary tx stats embedded in
rx stats.

Reported-by: syzbot+604f8271211546f5b3c7@syzkaller.appspotmail.com
Fixes: 5b8f3c8d30a6 ("virtio_net: Add XDP related stats")
Cc: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 39 ++++-----------------------------------
 1 file changed, 4 insertions(+), 35 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1880c86..72d3f68 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -105,10 +105,6 @@ struct virtnet_rq_stats {
 
 struct virtnet_rx_stats {
 	struct virtnet_rq_stat_items rx;
-	struct {
-		unsigned int xdp_tx;
-		unsigned int xdp_tx_drops;
-	} tx;
 };
 
 #define VIRTNET_SQ_STAT(m)	offsetof(struct virtnet_sq_stats, m)
@@ -485,22 +481,6 @@ static struct send_queue *virtnet_xdp_sq(struct virtnet_info *vi)
 	return &vi->sq[qp];
 }
 
-static int __virtnet_xdp_tx_xmit(struct virtnet_info *vi,
-				   struct xdp_frame *xdpf)
-{
-	struct xdp_frame *xdpf_sent;
-	struct send_queue *sq;
-	unsigned int len;
-
-	sq = virtnet_xdp_sq(vi);
-
-	/* Free up any pending old buffers before queueing new ones. */
-	while ((xdpf_sent = virtqueue_get_buf(sq->vq, &len)) != NULL)
-		xdp_return_frame(xdpf_sent);
-
-	return __virtnet_xdp_xmit_one(vi, sq, xdpf);
-}
-
 static int virtnet_xdp_xmit(struct net_device *dev,
 			    int n, struct xdp_frame **frames, u32 flags)
 {
@@ -707,10 +687,8 @@ static struct sk_buff *receive_small(struct net_device *dev,
 			xdpf = convert_to_xdp_frame(&xdp);
 			if (unlikely(!xdpf))
 				goto err_xdp;
-			stats->tx.xdp_tx++;
-			err = __virtnet_xdp_tx_xmit(vi, xdpf);
-			if (unlikely(err)) {
-				stats->tx.xdp_tx_drops++;
+			err = virtnet_xdp_xmit(dev, 1, &xdpf, 0);
+			if (unlikely(err < 0)) {
 				trace_xdp_exception(vi->dev, xdp_prog, act);
 				goto err_xdp;
 			}
@@ -879,10 +857,8 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 			xdpf = convert_to_xdp_frame(&xdp);
 			if (unlikely(!xdpf))
 				goto err_xdp;
-			stats->tx.xdp_tx++;
-			err = __virtnet_xdp_tx_xmit(vi, xdpf);
-			if (unlikely(err)) {
-				stats->tx.xdp_tx_drops++;
+			err = virtnet_xdp_xmit(dev, 1, &xdpf, 0);
+			if (unlikely(err < 0)) {
 				trace_xdp_exception(vi->dev, xdp_prog, act);
 				if (unlikely(xdp_page != page))
 					put_page(xdp_page);
@@ -1315,7 +1291,6 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 {
 	struct virtnet_info *vi = rq->vq->vdev->priv;
 	struct virtnet_rx_stats stats = {};
-	struct send_queue *sq;
 	unsigned int len;
 	void *buf;
 	int i;
@@ -1351,12 +1326,6 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 	}
 	u64_stats_update_end(&rq->stats.syncp);
 
-	sq = virtnet_xdp_sq(vi);
-	u64_stats_update_begin(&sq->stats.syncp);
-	sq->stats.xdp_tx += stats.tx.xdp_tx;
-	sq->stats.xdp_tx_drops += stats.tx.xdp_tx_drops;
-	u64_stats_update_end(&sq->stats.syncp);
-
 	return stats.rx.packets;
 }
 
-- 
2.7.4

