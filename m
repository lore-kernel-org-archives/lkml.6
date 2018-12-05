Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12A4C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84844208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84844208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbeLEWyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:54:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58026 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbeLEWyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:54:24 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 071094E916;
        Wed,  5 Dec 2018 22:54:24 +0000 (UTC)
Received: from redhat.com (ovpn-122-208.rdu2.redhat.com [10.10.122.208])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4C2755D6A6;
        Wed,  5 Dec 2018 22:54:16 +0000 (UTC)
Date:   Wed, 5 Dec 2018 17:54:15 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     maxime.coquelin@redhat.com, tiwei.bie@intel.com, wexu@redhat.com,
        jfreimann@redhat.com, Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH RFC 1/2] virtio-net: bql support
Message-ID: <20181205225323.12555-2-mst@redhat.com>
References: <20181205225323.12555-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205225323.12555-1-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 05 Dec 2018 22:54:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When use_napi is set, let's enable BQLs.  Note: some of the issues are
similar to wifi.  It's worth considering whether something similar to
commit 36148c2bbfbe ("mac80211: Adjust TSQ pacing shift") might be
benefitial.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index cecfd77c9f3c..b657bde6b94b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1325,7 +1325,8 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 	return stats.packets;
 }
 
-static void free_old_xmit_skbs(struct send_queue *sq)
+static void free_old_xmit_skbs(struct send_queue *sq, struct netdev_queue *txq,
+			       bool use_napi)
 {
 	struct sk_buff *skb;
 	unsigned int len;
@@ -1347,6 +1348,9 @@ static void free_old_xmit_skbs(struct send_queue *sq)
 	if (!packets)
 		return;
 
+	if (use_napi)
+		netdev_tx_completed_queue(txq, packets, bytes);
+
 	u64_stats_update_begin(&sq->stats.syncp);
 	sq->stats.bytes += bytes;
 	sq->stats.packets += packets;
@@ -1364,7 +1368,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 		return;
 
 	if (__netif_tx_trylock(txq)) {
-		free_old_xmit_skbs(sq);
+		free_old_xmit_skbs(sq, txq, true);
 		__netif_tx_unlock(txq);
 	}
 
@@ -1440,7 +1444,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	struct netdev_queue *txq = netdev_get_tx_queue(vi->dev, vq2txq(sq->vq));
 
 	__netif_tx_lock(txq, raw_smp_processor_id());
-	free_old_xmit_skbs(sq);
+	free_old_xmit_skbs(sq, txq, true);
 	__netif_tx_unlock(txq);
 
 	virtqueue_napi_complete(napi, sq->vq, 0);
@@ -1505,13 +1509,15 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct send_queue *sq = &vi->sq[qnum];
 	int err;
 	struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
-	bool kick = !skb->xmit_more;
+	bool more = skb->xmit_more;
 	bool use_napi = sq->napi.weight;
+	unsigned int bytes = skb->len;
+	bool kick;
 
 	/* Free up any pending old buffers before queueing new ones. */
-	free_old_xmit_skbs(sq);
+	free_old_xmit_skbs(sq, txq, use_napi);
 
-	if (use_napi && kick)
+	if (use_napi && !more)
 		virtqueue_enable_cb_delayed(sq->vq);
 
 	/* timestamp packet in software */
@@ -1552,7 +1558,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (!use_napi &&
 		    unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
 			/* More just got used, free them then recheck. */
-			free_old_xmit_skbs(sq);
+			free_old_xmit_skbs(sq, txq, false);
 			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
 				netif_start_subqueue(dev, qnum);
 				virtqueue_disable_cb(sq->vq);
@@ -1560,7 +1566,12 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 	}
 
-	if (kick || netif_xmit_stopped(txq)) {
+	if (use_napi)
+		kick = __netdev_tx_sent_queue(txq, bytes, more);
+	else
+		kick = !more || netif_xmit_stopped(txq);
+
+	if (kick) {
 		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
 			u64_stats_update_begin(&sq->stats.syncp);
 			sq->stats.kicks++;
-- 
MST

