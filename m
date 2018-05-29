Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754595AbeE2GSb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 02:18:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751800AbeE2GS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 02:18:27 -0400
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] vhost_net: flush batched heads before trying to busy polling
Date: Tue, 29 May 2018 14:18:19 +0800
Message-Id: <1527574699-13047-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit e2b3b35eb989 ("vhost_net: batch used ring update in rx"),
we tend to batch updating used heads. But it doesn't flush batched
heads before trying to do busy polling, this will cause vhost to wait
for guest TX which waits for the used RX. Fixing by flush batched
heads before busy loop.

1 byte TCP_RR performance recovers from 13107.83 to 50402.65.

Fixes: e2b3b35eb989 ("vhost_net: batch used ring update in rx")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 986058a..eeaf673 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -105,7 +105,9 @@ struct vhost_net_virtqueue {
 	/* vhost zerocopy support fields below: */
 	/* last used idx for outstanding DMA zerocopy buffers */
 	int upend_idx;
-	/* first used idx for DMA done zerocopy buffers */
+	/* For TX, first used idx for DMA done zerocopy buffers
+	 * For RX, number of batched heads
+	 */
 	int done_idx;
 	/* an array of userspace buffers info */
 	struct ubuf_info *ubuf_info;
@@ -626,6 +628,18 @@ static int sk_has_rx_data(struct sock *sk)
 	return skb_queue_empty(&sk->sk_receive_queue);
 }
 
+static void vhost_rx_signal_used(struct vhost_net_virtqueue *nvq)
+{
+	struct vhost_virtqueue *vq = &nvq->vq;
+	struct vhost_dev *dev = vq->dev;
+
+	if (!nvq->done_idx)
+		return;
+
+	vhost_add_used_and_signal_n(dev, vq, vq->heads, nvq->done_idx);
+	nvq->done_idx = 0;
+}
+
 static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk)
 {
 	struct vhost_net_virtqueue *rvq = &net->vqs[VHOST_NET_VQ_RX];
@@ -635,6 +649,8 @@ static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk)
 	int len = peek_head_len(rvq, sk);
 
 	if (!len && vq->busyloop_timeout) {
+		/* Flush batched heads first */
+		vhost_rx_signal_used(rvq);
 		/* Both tx vq and rx socket were polled here */
 		mutex_lock_nested(&vq->mutex, 1);
 		vhost_disable_notify(&net->dev, vq);
@@ -762,7 +778,7 @@ static void handle_rx(struct vhost_net *net)
 	};
 	size_t total_len = 0;
 	int err, mergeable;
-	s16 headcount, nheads = 0;
+	s16 headcount;
 	size_t vhost_hlen, sock_hlen;
 	size_t vhost_len, sock_len;
 	struct socket *sock;
@@ -790,8 +806,8 @@ static void handle_rx(struct vhost_net *net)
 	while ((sock_len = vhost_net_rx_peek_head_len(net, sock->sk))) {
 		sock_len += sock_hlen;
 		vhost_len = sock_len + vhost_hlen;
-		headcount = get_rx_bufs(vq, vq->heads + nheads, vhost_len,
-					&in, vq_log, &log,
+		headcount = get_rx_bufs(vq, vq->heads + nvq->done_idx,
+					vhost_len, &in, vq_log, &log,
 					likely(mergeable) ? UIO_MAXIOV : 1);
 		/* On error, stop handling until the next kick. */
 		if (unlikely(headcount < 0))
@@ -862,12 +878,9 @@ static void handle_rx(struct vhost_net *net)
 			vhost_discard_vq_desc(vq, headcount);
 			goto out;
 		}
-		nheads += headcount;
-		if (nheads > VHOST_RX_BATCH) {
-			vhost_add_used_and_signal_n(&net->dev, vq, vq->heads,
-						    nheads);
-			nheads = 0;
-		}
+		nvq->done_idx += headcount;
+		if (nvq->done_idx > VHOST_RX_BATCH)
+			vhost_rx_signal_used(nvq);
 		if (unlikely(vq_log))
 			vhost_log_write(vq, vq_log, log, vhost_len);
 		total_len += vhost_len;
@@ -878,9 +891,7 @@ static void handle_rx(struct vhost_net *net)
 	}
 	vhost_net_enable_vq(net, vq);
 out:
-	if (nheads)
-		vhost_add_used_and_signal_n(&net->dev, vq, vq->heads,
-					    nheads);
+	vhost_rx_signal_used(nvq);
 	mutex_unlock(&vq->mutex);
 }
 
-- 
2.7.4
