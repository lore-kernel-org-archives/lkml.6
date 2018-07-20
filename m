Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775DDECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA2420652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA2420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390025AbeGTNat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:30:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52736 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389343AbeGTNat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:30:49 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CD25ECBF;
        Fri, 20 Jul 2018 12:38:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 060/101] virtio_net: split XDP_TX kick and XDP_REDIRECT map flushing
Date:   Fri, 20 Jul 2018 14:14:06 +0200
Message-Id: <20180720121425.744946108@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
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

From: Jesper Dangaard Brouer <brouer@redhat.com>

[ Upstream commit 2471c75efed32529698c26da499954f0253cb401 ]

The driver was combining XDP_TX virtqueue_kick and XDP_REDIRECT
map flushing (xdp_do_flush_map).  This is suboptimal, these two
flush operations should be kept separate.

The suboptimal behavior was introduced in commit 9267c430c6b6
("virtio-net: add missing virtqueue kick when flushing packets").

Fixes: 9267c430c6b6 ("virtio-net: add missing virtqueue kick when flushing packets")
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |   30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -50,6 +50,10 @@ module_param(napi_tx, bool, 0644);
 /* Amount of XDP headroom to prepend to packets for use by xdp_adjust_head */
 #define VIRTIO_XDP_HEADROOM 256
 
+/* Separating two types of XDP xmit */
+#define VIRTIO_XDP_TX		BIT(0)
+#define VIRTIO_XDP_REDIR	BIT(1)
+
 /* RX packet size EWMA. The average packet size is used to determine the packet
  * buffer size when refilling RX rings. As the entire RX ring may be refilled
  * at once, the weight is chosen so that the EWMA will be insensitive to short-
@@ -547,7 +551,7 @@ static struct sk_buff *receive_small(str
 				     struct receive_queue *rq,
 				     void *buf, void *ctx,
 				     unsigned int len,
-				     bool *xdp_xmit)
+				     unsigned int *xdp_xmit)
 {
 	struct sk_buff *skb;
 	struct bpf_prog *xdp_prog;
@@ -615,14 +619,14 @@ static struct sk_buff *receive_small(str
 				trace_xdp_exception(vi->dev, xdp_prog, act);
 				goto err_xdp;
 			}
-			*xdp_xmit = true;
+			*xdp_xmit |= VIRTIO_XDP_TX;
 			rcu_read_unlock();
 			goto xdp_xmit;
 		case XDP_REDIRECT:
 			err = xdp_do_redirect(dev, &xdp, xdp_prog);
 			if (err)
 				goto err_xdp;
-			*xdp_xmit = true;
+			*xdp_xmit |= VIRTIO_XDP_REDIR;
 			rcu_read_unlock();
 			goto xdp_xmit;
 		default:
@@ -684,7 +688,7 @@ static struct sk_buff *receive_mergeable
 					 void *buf,
 					 void *ctx,
 					 unsigned int len,
-					 bool *xdp_xmit)
+					 unsigned int *xdp_xmit)
 {
 	struct virtio_net_hdr_mrg_rxbuf *hdr = buf;
 	u16 num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
@@ -772,7 +776,7 @@ static struct sk_buff *receive_mergeable
 					put_page(xdp_page);
 				goto err_xdp;
 			}
-			*xdp_xmit = true;
+			*xdp_xmit |= VIRTIO_XDP_REDIR;
 			if (unlikely(xdp_page != page))
 				put_page(page);
 			rcu_read_unlock();
@@ -784,7 +788,7 @@ static struct sk_buff *receive_mergeable
 					put_page(xdp_page);
 				goto err_xdp;
 			}
-			*xdp_xmit = true;
+			*xdp_xmit |= VIRTIO_XDP_TX;
 			if (unlikely(xdp_page != page))
 				put_page(page);
 			rcu_read_unlock();
@@ -893,7 +897,8 @@ xdp_xmit:
 }
 
 static int receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
-		       void *buf, unsigned int len, void **ctx, bool *xdp_xmit)
+		       void *buf, unsigned int len, void **ctx,
+		       unsigned int *xdp_xmit)
 {
 	struct net_device *dev = vi->dev;
 	struct sk_buff *skb;
@@ -1186,7 +1191,8 @@ static void refill_work(struct work_stru
 	}
 }
 
-static int virtnet_receive(struct receive_queue *rq, int budget, bool *xdp_xmit)
+static int virtnet_receive(struct receive_queue *rq, int budget,
+			   unsigned int *xdp_xmit)
 {
 	struct virtnet_info *vi = rq->vq->vdev->priv;
 	unsigned int len, received = 0, bytes = 0;
@@ -1275,7 +1281,7 @@ static int virtnet_poll(struct napi_stru
 	struct virtnet_info *vi = rq->vq->vdev->priv;
 	struct send_queue *sq;
 	unsigned int received, qp;
-	bool xdp_xmit = false;
+	unsigned int xdp_xmit = 0;
 
 	virtnet_poll_cleantx(rq);
 
@@ -1285,12 +1291,14 @@ static int virtnet_poll(struct napi_stru
 	if (received < budget)
 		virtqueue_napi_complete(napi, rq->vq, received);
 
-	if (xdp_xmit) {
+	if (xdp_xmit & VIRTIO_XDP_REDIR)
+		xdp_do_flush_map();
+
+	if (xdp_xmit & VIRTIO_XDP_TX) {
 		qp = vi->curr_queue_pairs - vi->xdp_queue_pairs +
 		     smp_processor_id();
 		sq = &vi->sq[qp];
 		virtqueue_kick(sq->vq);
-		xdp_do_flush_map();
 	}
 
 	return received;


