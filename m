Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429DFC282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126E62075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277078;
	bh=vIL9olYqdTYDAY9fvvX9gneSf4FFqZZpLKdRfXedVWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zAQWGUWLAejxCkkJkxZLgHnqPfvRbJFivLZE5mXMKgKoOmT0j5Y7RSNJyflm8/GUi
	 5LMMZP33Lffl6su1UPmQSKZT5bB02JoQf7/muyOwH9ONpwHYBHUq9OVVBqnaasNQXw
	 rB8tlUIpizsR5LmC2O/5U+NxPXQGYQi8zq4isleg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731033AbfBDKog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:44:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:42398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730538AbfBDKof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:44:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25ACF2176F;
        Mon,  4 Feb 2019 10:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277073;
        bh=vIL9olYqdTYDAY9fvvX9gneSf4FFqZZpLKdRfXedVWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zhhxT9Y5fCZS3irTEEFXvQMqP2W48YHLqcjWVd5OH46tz/5VE3UhiH/iVEWJAK8Zf
         ehKYZwwxIO4PCtr6tTJhIm3gInvy6JgkH5XhzoITAuDAOEARDjkgoWvT1+h8mZf8o1
         dk1a+SjrN3hcTMJ+ReJuzilXGO4+n2Pk1MCipODo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 13/46] virtio_net: Dont call free_old_xmit_skbs for xdp_frames
Date:   Mon,  4 Feb 2019 11:36:44 +0100
Message-Id: <20190204103610.990022121@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103608.651205056@linuxfoundation.org>
References: <20190204103608.651205056@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>

[ Upstream commit 534da5e856334fb54cb0272a9fb3afec28ea3aed ]

When napi_tx is enabled, virtnet_poll_cleantx() called
free_old_xmit_skbs() even for xdp send queue.
This is bogus since the queue has xdp_frames, not sk_buffs, thus mangled
device tx bytes counters because skb->len is meaningless value, and even
triggered oops due to general protection fault on freeing them.

Since xdp send queues do not aquire locks, old xdp_frames should be
freed only in virtnet_xdp_xmit(), so just skip free_old_xmit_skbs() for
xdp send queues.

Similarly virtnet_poll_tx() called free_old_xmit_skbs(). This NAPI
handler is called even without calling start_xmit() because cb for tx is
by default enabled. Once the handler is called, it enabled the cb again,
and then the handler would be called again. We don't need this handler
for XDP, so don't enable cb as well as not calling free_old_xmit_skbs().

Also, we need to disable tx NAPI when disabling XDP, so
virtnet_poll_tx() can safely access curr_queue_pairs and
xdp_queue_pairs, which are not atomically updated while disabling XDP.

Fixes: b92f1e6751a6 ("virtio-net: transmit napi")
Fixes: 7b0411ef4aa6 ("virtio-net: clean tx descriptors from rx napi")
Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |   49 +++++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 16 deletions(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1149,6 +1149,16 @@ static void free_old_xmit_skbs(struct se
 	u64_stats_update_end(&stats->tx_syncp);
 }
 
+static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
+{
+	if (q < (vi->curr_queue_pairs - vi->xdp_queue_pairs))
+		return false;
+	else if (q < vi->curr_queue_pairs)
+		return true;
+	else
+		return false;
+}
+
 static void virtnet_poll_cleantx(struct receive_queue *rq)
 {
 	struct virtnet_info *vi = rq->vq->vdev->priv;
@@ -1156,7 +1166,7 @@ static void virtnet_poll_cleantx(struct
 	struct send_queue *sq = &vi->sq[index];
 	struct netdev_queue *txq = netdev_get_tx_queue(vi->dev, index);
 
-	if (!sq->napi.weight)
+	if (!sq->napi.weight || is_xdp_raw_buffer_queue(vi, index))
 		return;
 
 	if (__netif_tx_trylock(txq)) {
@@ -1206,8 +1216,16 @@ static int virtnet_poll_tx(struct napi_s
 {
 	struct send_queue *sq = container_of(napi, struct send_queue, napi);
 	struct virtnet_info *vi = sq->vq->vdev->priv;
-	struct netdev_queue *txq = netdev_get_tx_queue(vi->dev, vq2txq(sq->vq));
+	unsigned int index = vq2txq(sq->vq);
+	struct netdev_queue *txq;
 
+	if (unlikely(is_xdp_raw_buffer_queue(vi, index))) {
+		/* We don't need to enable cb for XDP */
+		napi_complete_done(napi, 0);
+		return 0;
+	}
+
+	txq = netdev_get_tx_queue(vi->dev, index);
 	__netif_tx_lock(txq, raw_smp_processor_id());
 	free_old_xmit_skbs(sq);
 	__netif_tx_unlock(txq);
@@ -2006,9 +2024,12 @@ static int virtnet_xdp_set(struct net_de
 	}
 
 	/* Make sure NAPI is not using any XDP TX queues for RX. */
-	if (netif_running(dev))
-		for (i = 0; i < vi->max_queue_pairs; i++)
+	if (netif_running(dev)) {
+		for (i = 0; i < vi->max_queue_pairs; i++) {
 			napi_disable(&vi->rq[i].napi);
+			virtnet_napi_tx_disable(&vi->sq[i].napi);
+		}
+	}
 
 	netif_set_real_num_rx_queues(dev, curr_qp + xdp_qp);
 	err = _virtnet_set_queues(vi, curr_qp + xdp_qp);
@@ -2027,16 +2048,22 @@ static int virtnet_xdp_set(struct net_de
 		}
 		if (old_prog)
 			bpf_prog_put(old_prog);
-		if (netif_running(dev))
+		if (netif_running(dev)) {
 			virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
+			virtnet_napi_tx_enable(vi, vi->sq[i].vq,
+					       &vi->sq[i].napi);
+		}
 	}
 
 	return 0;
 
 err:
 	if (netif_running(dev)) {
-		for (i = 0; i < vi->max_queue_pairs; i++)
+		for (i = 0; i < vi->max_queue_pairs; i++) {
 			virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
+			virtnet_napi_tx_enable(vi, vi->sq[i].vq,
+					       &vi->sq[i].napi);
+		}
 	}
 	if (prog)
 		bpf_prog_sub(prog, vi->max_queue_pairs - 1);
@@ -2178,16 +2205,6 @@ static void free_receive_page_frags(stru
 			put_page(vi->rq[i].alloc_frag.page);
 }
 
-static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
-{
-	if (q < (vi->curr_queue_pairs - vi->xdp_queue_pairs))
-		return false;
-	else if (q < vi->curr_queue_pairs)
-		return true;
-	else
-		return false;
-}
-
 static void free_unused_bufs(struct virtnet_info *vi)
 {
 	void *buf;


