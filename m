Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5E1C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68C82083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68C82083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387629AbeHAUM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:12:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46122 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404284AbeHATDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:37 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9DC4412B5;
        Wed,  1 Aug 2018 17:10:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 323/336] virtio_net: Fix incosistent received bytes counter
Date:   Wed,  1 Aug 2018 18:50:58 +0200
Message-Id: <20180801165041.398879997@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
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

From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>

[ Upstream commit ecbc42ca5d665e9238a4cdb595024d2e6cf87f2d ]

When received packets are dropped in virtio_net driver, received packets
counter is incremented but bytes counter is not.
As a result, for instance if we drop all packets by XDP, only received
is counted and bytes stays 0, which looks inconsistent.
IMHO received packets/bytes should be counted if packets are produced by
the hypervisor, like what common NICs on physical machines are doing.
So fix the bytes counter.

Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |   41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -551,7 +551,8 @@ static struct sk_buff *receive_small(str
 				     struct receive_queue *rq,
 				     void *buf, void *ctx,
 				     unsigned int len,
-				     unsigned int *xdp_xmit)
+				     unsigned int *xdp_xmit,
+				     unsigned int *rbytes)
 {
 	struct sk_buff *skb;
 	struct bpf_prog *xdp_prog;
@@ -567,6 +568,7 @@ static struct sk_buff *receive_small(str
 	int err;
 
 	len -= vi->hdr_len;
+	*rbytes += len;
 
 	rcu_read_lock();
 	xdp_prog = rcu_dereference(rq->xdp_prog);
@@ -666,11 +668,13 @@ static struct sk_buff *receive_big(struc
 				   struct virtnet_info *vi,
 				   struct receive_queue *rq,
 				   void *buf,
-				   unsigned int len)
+				   unsigned int len,
+				   unsigned int *rbytes)
 {
 	struct page *page = buf;
 	struct sk_buff *skb = page_to_skb(vi, rq, page, 0, len, PAGE_SIZE);
 
+	*rbytes += len - vi->hdr_len;
 	if (unlikely(!skb))
 		goto err;
 
@@ -688,7 +692,8 @@ static struct sk_buff *receive_mergeable
 					 void *buf,
 					 void *ctx,
 					 unsigned int len,
-					 unsigned int *xdp_xmit)
+					 unsigned int *xdp_xmit,
+					 unsigned int *rbytes)
 {
 	struct virtio_net_hdr_mrg_rxbuf *hdr = buf;
 	u16 num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
@@ -702,6 +707,7 @@ static struct sk_buff *receive_mergeable
 	int err;
 
 	head_skb = NULL;
+	*rbytes += len - vi->hdr_len;
 
 	rcu_read_lock();
 	xdp_prog = rcu_dereference(rq->xdp_prog);
@@ -831,6 +837,7 @@ static struct sk_buff *receive_mergeable
 			goto err_buf;
 		}
 
+		*rbytes += len;
 		page = virt_to_head_page(buf);
 
 		truesize = mergeable_ctx_to_truesize(ctx);
@@ -886,6 +893,7 @@ err_skb:
 			dev->stats.rx_length_errors++;
 			break;
 		}
+		*rbytes += len;
 		page = virt_to_head_page(buf);
 		put_page(page);
 	}
@@ -896,14 +904,13 @@ xdp_xmit:
 	return NULL;
 }
 
-static int receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
-		       void *buf, unsigned int len, void **ctx,
-		       unsigned int *xdp_xmit)
+static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
+			void *buf, unsigned int len, void **ctx,
+			unsigned int *xdp_xmit, unsigned int *rbytes)
 {
 	struct net_device *dev = vi->dev;
 	struct sk_buff *skb;
 	struct virtio_net_hdr_mrg_rxbuf *hdr;
-	int ret;
 
 	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
 		pr_debug("%s: short packet %i\n", dev->name, len);
@@ -915,23 +922,22 @@ static int receive_buf(struct virtnet_in
 		} else {
 			put_page(virt_to_head_page(buf));
 		}
-		return 0;
+		return;
 	}
 
 	if (vi->mergeable_rx_bufs)
-		skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit);
+		skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
+					rbytes);
 	else if (vi->big_packets)
-		skb = receive_big(dev, vi, rq, buf, len);
+		skb = receive_big(dev, vi, rq, buf, len, rbytes);
 	else
-		skb = receive_small(dev, vi, rq, buf, ctx, len, xdp_xmit);
+		skb = receive_small(dev, vi, rq, buf, ctx, len, xdp_xmit, rbytes);
 
 	if (unlikely(!skb))
-		return 0;
+		return;
 
 	hdr = skb_vnet_hdr(skb);
 
-	ret = skb->len;
-
 	if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
@@ -948,12 +954,11 @@ static int receive_buf(struct virtnet_in
 		 ntohs(skb->protocol), skb->len, skb->pkt_type);
 
 	napi_gro_receive(&rq->napi, skb);
-	return ret;
+	return;
 
 frame_err:
 	dev->stats.rx_frame_errors++;
 	dev_kfree_skb(skb);
-	return 0;
 }
 
 /* Unlike mergeable buffers, all buffers are allocated to the
@@ -1203,13 +1208,13 @@ static int virtnet_receive(struct receiv
 
 		while (received < budget &&
 		       (buf = virtqueue_get_buf_ctx(rq->vq, &len, &ctx))) {
-			bytes += receive_buf(vi, rq, buf, len, ctx, xdp_xmit);
+			receive_buf(vi, rq, buf, len, ctx, xdp_xmit, &bytes);
 			received++;
 		}
 	} else {
 		while (received < budget &&
 		       (buf = virtqueue_get_buf(rq->vq, &len)) != NULL) {
-			bytes += receive_buf(vi, rq, buf, len, NULL, xdp_xmit);
+			receive_buf(vi, rq, buf, len, NULL, xdp_xmit, &bytes);
 			received++;
 		}
 	}


