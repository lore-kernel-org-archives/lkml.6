Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A0AC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04DBE217FA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277276;
	bh=H1rZRCG+qvwnAIU6h6pMgT+1rZO5+AIkfeGzXo8YV+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MPNNpj5TyT7J7F1Sl09gEWDldglRkg20QZDif/uynjBdEEjdujEu4TUmvipiBwMaI
	 lFfON2z4nQhegkUH5P0XhdstFJfCelUSJJX5GruMbom4zLQuIy/mYsH+oS6l0IE4Vv
	 8Y59/iRX2YWDVm+c5ODHKqgoR1elRHuh0mN+6TWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbfBDKry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:47:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:46008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729719AbfBDKrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:47:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB0D7217D6;
        Mon,  4 Feb 2019 10:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277272;
        bh=H1rZRCG+qvwnAIU6h6pMgT+1rZO5+AIkfeGzXo8YV+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HEyIoOQS6m9FkVcay7FzIbl1fab5pnRtethZTrih1lP6I7nt/LZW4vos6+x/stGDS
         ABEFUPNeYzNiiFDZP/CG67wj1qTv49liO4OGWJW6oxKHBxZNKRMz8A9GpTNVJ2kEkC
         P8vXmh/yYE8DkxPUl9ssY4nEpZJ6LOzCJtany7GI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 32/74] virtio_net: Differentiate sk_buff and xdp_frame on freeing
Date:   Mon,  4 Feb 2019 11:36:45 +0100
Message-Id: <20190204103623.538231886@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
References: <20190204103619.714714157@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>

[ Upstream commit 5050471d35d1316ba32dfcbb409978337eb9e75e

  I had to fold commit df133f3f9625 ("virtio_net: bulk free tx skbs")
  into this to make it work.  ]

We do not reset or free up unused buffers when enabling/disabling XDP,
so it can happen that xdp_frames are freed after disabling XDP or
sk_buffs are freed after enabling XDP on xdp tx queues.
Thus we need to handle both forms (xdp_frames and sk_buffs) regardless
of XDP setting.
One way to trigger this problem is to disable XDP when napi_tx is
enabled. In that case, virtnet_xdp_set() calls virtnet_napi_enable()
which kicks NAPI. The NAPI handler will call virtnet_poll_cleantx()
which invokes free_old_xmit_skbs() for queues which have been used by
XDP.

Note that even with this change we need to keep skipping
free_old_xmit_skbs() from NAPI handlers when XDP is enabled, because XDP
tx queues do not aquire queue locks.

- v2: Use napi_consume_skb() instead of dev_consume_skb_any()

Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")
Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |   64 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 17 deletions(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -57,6 +57,8 @@ module_param(napi_tx, bool, 0644);
 #define VIRTIO_XDP_TX		BIT(0)
 #define VIRTIO_XDP_REDIR	BIT(1)
 
+#define VIRTIO_XDP_FLAG	BIT(0)
+
 /* RX packet size EWMA. The average packet size is used to determine the packet
  * buffer size when refilling RX rings. As the entire RX ring may be refilled
  * at once, the weight is chosen so that the EWMA will be insensitive to short-
@@ -251,6 +253,21 @@ struct padded_vnet_hdr {
 	char padding[4];
 };
 
+static bool is_xdp_frame(void *ptr)
+{
+	return (unsigned long)ptr & VIRTIO_XDP_FLAG;
+}
+
+static void *xdp_to_ptr(struct xdp_frame *ptr)
+{
+	return (void *)((unsigned long)ptr | VIRTIO_XDP_FLAG);
+}
+
+static struct xdp_frame *ptr_to_xdp(void *ptr)
+{
+	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
+}
+
 /* Converting between virtqueue no. and kernel tx/rx queue no.
  * 0:rx0 1:tx0 2:rx1 3:tx1 ... 2N:rxN 2N+1:txN 2N+2:cvq
  */
@@ -461,7 +478,8 @@ static int __virtnet_xdp_xmit_one(struct
 
 	sg_init_one(sq->sg, xdpf->data, xdpf->len);
 
-	err = virtqueue_add_outbuf(sq->vq, sq->sg, 1, xdpf, GFP_ATOMIC);
+	err = virtqueue_add_outbuf(sq->vq, sq->sg, 1, xdp_to_ptr(xdpf),
+				   GFP_ATOMIC);
 	if (unlikely(err))
 		return -ENOSPC; /* Caller handle free/refcnt */
 
@@ -481,13 +499,13 @@ static int virtnet_xdp_xmit(struct net_d
 {
 	struct virtnet_info *vi = netdev_priv(dev);
 	struct receive_queue *rq = vi->rq;
-	struct xdp_frame *xdpf_sent;
 	struct bpf_prog *xdp_prog;
 	struct send_queue *sq;
 	unsigned int len;
 	int drops = 0;
 	int kicks = 0;
 	int ret, err;
+	void *ptr;
 	int i;
 
 	/* Only allow ndo_xdp_xmit if XDP is loaded on dev, as this
@@ -506,8 +524,12 @@ static int virtnet_xdp_xmit(struct net_d
 	}
 
 	/* Free up any pending old buffers before queueing new ones. */
-	while ((xdpf_sent = virtqueue_get_buf(sq->vq, &len)) != NULL)
-		xdp_return_frame(xdpf_sent);
+	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
+		if (likely(is_xdp_frame(ptr)))
+			xdp_return_frame(ptr_to_xdp(ptr));
+		else
+			napi_consume_skb(ptr, false);
+	}
 
 	for (i = 0; i < n; i++) {
 		struct xdp_frame *xdpf = frames[i];
@@ -1326,20 +1348,28 @@ static int virtnet_receive(struct receiv
 	return stats.packets;
 }
 
-static void free_old_xmit_skbs(struct send_queue *sq)
+static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
 {
-	struct sk_buff *skb;
 	unsigned int len;
 	unsigned int packets = 0;
 	unsigned int bytes = 0;
+	void *ptr;
 
-	while ((skb = virtqueue_get_buf(sq->vq, &len)) != NULL) {
-		pr_debug("Sent skb %p\n", skb);
+	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
+		if (likely(!is_xdp_frame(ptr))) {
+			struct sk_buff *skb = ptr;
 
-		bytes += skb->len;
-		packets++;
+			pr_debug("Sent skb %p\n", skb);
 
-		dev_consume_skb_any(skb);
+			bytes += skb->len;
+			napi_consume_skb(skb, in_napi);
+		} else {
+			struct xdp_frame *frame = ptr_to_xdp(ptr);
+
+			bytes += frame->len;
+			xdp_return_frame(frame);
+		}
+		packets++;
 	}
 
 	/* Avoid overhead when no packets have been processed
@@ -1375,7 +1405,7 @@ static void virtnet_poll_cleantx(struct
 		return;
 
 	if (__netif_tx_trylock(txq)) {
-		free_old_xmit_skbs(sq);
+		free_old_xmit_skbs(sq, true);
 		__netif_tx_unlock(txq);
 	}
 
@@ -1459,7 +1489,7 @@ static int virtnet_poll_tx(struct napi_s
 
 	txq = netdev_get_tx_queue(vi->dev, index);
 	__netif_tx_lock(txq, raw_smp_processor_id());
-	free_old_xmit_skbs(sq);
+	free_old_xmit_skbs(sq, true);
 	__netif_tx_unlock(txq);
 
 	virtqueue_napi_complete(napi, sq->vq, 0);
@@ -1528,7 +1558,7 @@ static netdev_tx_t start_xmit(struct sk_
 	bool use_napi = sq->napi.weight;
 
 	/* Free up any pending old buffers before queueing new ones. */
-	free_old_xmit_skbs(sq);
+	free_old_xmit_skbs(sq, false);
 
 	if (use_napi && kick)
 		virtqueue_enable_cb_delayed(sq->vq);
@@ -1571,7 +1601,7 @@ static netdev_tx_t start_xmit(struct sk_
 		if (!use_napi &&
 		    unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
 			/* More just got used, free them then recheck. */
-			free_old_xmit_skbs(sq);
+			free_old_xmit_skbs(sq, false);
 			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
 				netif_start_subqueue(dev, qnum);
 				virtqueue_disable_cb(sq->vq);
@@ -2590,10 +2620,10 @@ static void free_unused_bufs(struct virt
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		struct virtqueue *vq = vi->sq[i].vq;
 		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL) {
-			if (!is_xdp_raw_buffer_queue(vi, i))
+			if (!is_xdp_frame(buf))
 				dev_kfree_skb(buf);
 			else
-				xdp_return_frame(buf);
+				xdp_return_frame(ptr_to_xdp(buf));
 		}
 	}
 


