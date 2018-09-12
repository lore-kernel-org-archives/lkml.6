Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02211C04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 03:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EB320882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 03:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EB320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbeILIUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 04:20:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728242AbeILIUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 04:20:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 18AE1402333A;
        Wed, 12 Sep 2018 03:18:10 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-130.pek2.redhat.com [10.72.12.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1DF322027EA4;
        Wed, 12 Sep 2018 03:18:06 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        mst@redhat.com, jasowang@redhat.com
Subject: [PATCH net-next V2 11/11] vhost_net: batch submitting XDP buffers to underlayer sockets
Date:   Wed, 12 Sep 2018 11:17:09 +0800
Message-Id: <20180912031709.14112-12-jasowang@redhat.com>
In-Reply-To: <20180912031709.14112-1-jasowang@redhat.com>
References: <20180912031709.14112-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 12 Sep 2018 03:18:10 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 12 Sep 2018 03:18:10 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements XDP batching for vhost_net. The idea is first to
try to do userspace copy and build XDP buff directly in vhost. Instead
of submitting the packet immediately, vhost_net will batch them in an
array and submit every 64 (VHOST_NET_BATCH) packets to the under layer
sockets through msg_control of sendmsg().

When XDP is enabled on the TUN/TAP, TUN/TAP can process XDP inside a
loop without caring GUP thus it can do batch map flushing. When XDP is
not enabled or not supported, the underlayer socket need to build skb
and pass it to network core. The batched packet submission allows us
to do batching like netif_receive_skb_list() in the future.

This saves lots of indirect calls for better cache utilization. For
the case that we can't so batching e.g when sndbuf is limited or
packet size is too large, we will go for usual one packet per
sendmsg() way.

Doing testpmd on various setups gives us:

Test                /+pps%
XDP_DROP on TAP     /+44.8%
XDP_REDIRECT on TAP /+29%
macvtap (skb)       /+26%

Netperf tests shows obvious improvements for small packet transmission:

size/session/+thu%/+normalize%
   64/     1/   +2%/    0%
   64/     2/   +3%/   +1%
   64/     4/   +7%/   +5%
   64/     8/   +8%/   +6%
  256/     1/   +3%/    0%
  256/     2/  +10%/   +7%
  256/     4/  +26%/  +22%
  256/     8/  +27%/  +23%
  512/     1/   +3%/   +2%
  512/     2/  +19%/  +14%
  512/     4/  +43%/  +40%
  512/     8/  +45%/  +41%
 1024/     1/   +4%/    0%
 1024/     2/  +27%/  +21%
 1024/     4/  +38%/  +73%
 1024/     8/  +15%/  +24%
 2048/     1/  +10%/   +7%
 2048/     2/  +16%/  +12%
 2048/     4/    0%/   +2%
 2048/     8/    0%/   +2%
 4096/     1/  +36%/  +60%
 4096/     2/  -11%/  -26%
 4096/     4/    0%/  +14%
 4096/     8/    0%/   +4%
16384/     1/   -1%/   +5%
16384/     2/    0%/   +2%
16384/     4/    0%/   -3%
16384/     8/    0%/   +4%
65535/     1/    0%/  +10%
65535/     2/    0%/   +8%
65535/     4/    0%/   +1%
65535/     8/    0%/   +3%

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 174 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 161 insertions(+), 13 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index fb01ce6d981c..dd4e0a301635 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -116,6 +116,8 @@ struct vhost_net_virtqueue {
 	 * For RX, number of batched heads
 	 */
 	int done_idx;
+	/* Number of XDP frames batched */
+	int batched_xdp;
 	/* an array of userspace buffers info */
 	struct ubuf_info *ubuf_info;
 	/* Reference counting for outstanding ubufs.
@@ -123,6 +125,8 @@ struct vhost_net_virtqueue {
 	struct vhost_net_ubuf_ref *ubufs;
 	struct ptr_ring *rx_ring;
 	struct vhost_net_buf rxq;
+	/* Batched XDP buffs */
+	struct xdp_buff *xdp;
 };
 
 struct vhost_net {
@@ -338,6 +342,11 @@ static bool vhost_sock_zcopy(struct socket *sock)
 		sock_flag(sock->sk, SOCK_ZEROCOPY);
 }
 
+static bool vhost_sock_xdp(struct socket *sock)
+{
+	return sock_flag(sock->sk, SOCK_XDP);
+}
+
 /* In case of DMA done not in order in lower device driver for some reason.
  * upend_idx is used to track end of used idx, done_idx is used to track head
  * of used idx. Once lower device DMA done contiguously, we will signal KVM
@@ -444,10 +453,37 @@ static void vhost_net_signal_used(struct vhost_net_virtqueue *nvq)
 	nvq->done_idx = 0;
 }
 
+static void vhost_tx_batch(struct vhost_net *net,
+			   struct vhost_net_virtqueue *nvq,
+			   struct socket *sock,
+			   struct msghdr *msghdr)
+{
+	struct tun_msg_ctl ctl = {
+		.type = TUN_MSG_PTR,
+		.num = nvq->batched_xdp,
+		.ptr = nvq->xdp,
+	};
+	int err;
+
+	if (nvq->batched_xdp == 0)
+		goto signal_used;
+
+	msghdr->msg_control = &ctl;
+	err = sock->ops->sendmsg(sock, msghdr, 0);
+	if (unlikely(err < 0)) {
+		vq_err(&nvq->vq, "Fail to batch sending packets\n");
+		return;
+	}
+
+signal_used:
+	vhost_net_signal_used(nvq);
+	nvq->batched_xdp = 0;
+}
+
 static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
 				    struct vhost_net_virtqueue *nvq,
 				    unsigned int *out_num, unsigned int *in_num,
-				    bool *busyloop_intr)
+				    struct msghdr *msghdr, bool *busyloop_intr)
 {
 	struct vhost_virtqueue *vq = &nvq->vq;
 	unsigned long uninitialized_var(endtime);
@@ -455,8 +491,9 @@ static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
 				  out_num, in_num, NULL, NULL);
 
 	if (r == vq->num && vq->busyloop_timeout) {
+		/* Flush batched packets first */
 		if (!vhost_sock_zcopy(vq->private_data))
-			vhost_net_signal_used(nvq);
+			vhost_tx_batch(net, nvq, vq->private_data, msghdr);
 		preempt_disable();
 		endtime = busy_clock() + vq->busyloop_timeout;
 		while (vhost_can_busy_poll(endtime)) {
@@ -512,7 +549,7 @@ static int get_tx_bufs(struct vhost_net *net,
 	struct vhost_virtqueue *vq = &nvq->vq;
 	int ret;
 
-	ret = vhost_net_tx_get_vq_desc(net, nvq, out, in, busyloop_intr);
+	ret = vhost_net_tx_get_vq_desc(net, nvq, out, in, msg, busyloop_intr);
 
 	if (ret < 0 || ret == vq->num)
 		return ret;
@@ -540,6 +577,80 @@ static bool tx_can_batch(struct vhost_virtqueue *vq, size_t total_len)
 	       !vhost_vq_avail_empty(vq->dev, vq);
 }
 
+#define VHOST_NET_RX_PAD (NET_IP_ALIGN + NET_SKB_PAD)
+
+static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
+			       struct iov_iter *from)
+{
+	struct vhost_virtqueue *vq = &nvq->vq;
+	struct socket *sock = vq->private_data;
+	struct page_frag *alloc_frag = &current->task_frag;
+	struct virtio_net_hdr *gso;
+	struct xdp_buff *xdp = &nvq->xdp[nvq->batched_xdp];
+	struct tun_xdp_hdr *hdr;
+	size_t len = iov_iter_count(from);
+	int headroom = vhost_sock_xdp(sock) ? XDP_PACKET_HEADROOM : 0;
+	int buflen = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	int pad = SKB_DATA_ALIGN(VHOST_NET_RX_PAD + headroom + nvq->sock_hlen);
+	int sock_hlen = nvq->sock_hlen;
+	void *buf;
+	int copied;
+
+	if (unlikely(len < nvq->sock_hlen))
+		return -EFAULT;
+
+	if (SKB_DATA_ALIGN(len + pad) +
+	    SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) > PAGE_SIZE)
+		return -ENOSPC;
+
+	buflen += SKB_DATA_ALIGN(len + pad);
+	alloc_frag->offset = ALIGN((u64)alloc_frag->offset, SMP_CACHE_BYTES);
+	if (unlikely(!skb_page_frag_refill(buflen, alloc_frag, GFP_KERNEL)))
+		return -ENOMEM;
+
+	buf = (char *)page_address(alloc_frag->page) + alloc_frag->offset;
+	copied = copy_page_from_iter(alloc_frag->page,
+				     alloc_frag->offset +
+				     offsetof(struct tun_xdp_hdr, gso),
+				     sock_hlen, from);
+	if (copied != sock_hlen)
+		return -EFAULT;
+
+	hdr = buf;
+	gso = &hdr->gso;
+
+	if ((gso->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
+	    vhost16_to_cpu(vq, gso->csum_start) +
+	    vhost16_to_cpu(vq, gso->csum_offset) + 2 >
+	    vhost16_to_cpu(vq, gso->hdr_len)) {
+		gso->hdr_len = cpu_to_vhost16(vq,
+			       vhost16_to_cpu(vq, gso->csum_start) +
+			       vhost16_to_cpu(vq, gso->csum_offset) + 2);
+
+		if (vhost16_to_cpu(vq, gso->hdr_len) > len)
+			return -EINVAL;
+	}
+
+	len -= sock_hlen;
+	copied = copy_page_from_iter(alloc_frag->page,
+				     alloc_frag->offset + pad,
+				     len, from);
+	if (copied != len)
+		return -EFAULT;
+
+	xdp->data_hard_start = buf;
+	xdp->data = buf + pad;
+	xdp->data_end = xdp->data + len;
+	hdr->buflen = buflen;
+
+	get_page(alloc_frag->page);
+	alloc_frag->offset += buflen;
+
+	++nvq->batched_xdp;
+
+	return 0;
+}
+
 static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 {
 	struct vhost_net_virtqueue *nvq = &net->vqs[VHOST_NET_VQ_TX];
@@ -556,10 +667,14 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 	size_t len, total_len = 0;
 	int err;
 	int sent_pkts = 0;
+	bool sock_can_batch = (sock->sk->sk_sndbuf == INT_MAX);
 
 	for (;;) {
 		bool busyloop_intr = false;
 
+		if (nvq->done_idx == VHOST_NET_BATCH)
+			vhost_tx_batch(net, nvq, sock, &msg);
+
 		head = get_tx_bufs(net, nvq, &msg, &out, &in, &len,
 				   &busyloop_intr);
 		/* On error, stop handling until the next kick. */
@@ -577,14 +692,34 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 			break;
 		}
 
-		vq->heads[nvq->done_idx].id = cpu_to_vhost32(vq, head);
-		vq->heads[nvq->done_idx].len = 0;
-
 		total_len += len;
-		if (tx_can_batch(vq, total_len))
-			msg.msg_flags |= MSG_MORE;
-		else
-			msg.msg_flags &= ~MSG_MORE;
+
+		/* For simplicity, TX batching is only enabled if
+		 * sndbuf is unlimited.
+		 */
+		if (sock_can_batch) {
+			err = vhost_net_build_xdp(nvq, &msg.msg_iter);
+			if (!err) {
+				goto done;
+			} else if (unlikely(err != -ENOSPC)) {
+				vhost_tx_batch(net, nvq, sock, &msg);
+				vhost_discard_vq_desc(vq, 1);
+				vhost_net_enable_vq(net, vq);
+				break;
+			}
+
+			/* We can't build XDP buff, go for single
+			 * packet path but let's flush batched
+			 * packets.
+			 */
+			vhost_tx_batch(net, nvq, sock, &msg);
+			msg.msg_control = NULL;
+		} else {
+			if (tx_can_batch(vq, total_len))
+				msg.msg_flags |= MSG_MORE;
+			else
+				msg.msg_flags &= ~MSG_MORE;
+		}
 
 		/* TODO: Check specific error and bomb out unless ENOBUFS? */
 		err = sock->ops->sendmsg(sock, &msg, len);
@@ -596,15 +731,17 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 		if (err != len)
 			pr_debug("Truncated TX packet: len %d != %zd\n",
 				 err, len);
-		if (++nvq->done_idx >= VHOST_NET_BATCH)
-			vhost_net_signal_used(nvq);
+done:
+		vq->heads[nvq->done_idx].id = cpu_to_vhost32(vq, head);
+		vq->heads[nvq->done_idx].len = 0;
+		++nvq->done_idx;
 		if (vhost_exceeds_weight(++sent_pkts, total_len)) {
 			vhost_poll_queue(&vq->poll);
 			break;
 		}
 	}
 
-	vhost_net_signal_used(nvq);
+	vhost_tx_batch(net, nvq, sock, &msg);
 }
 
 static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
@@ -1081,6 +1218,7 @@ static int vhost_net_open(struct inode *inode, struct file *f)
 	struct vhost_dev *dev;
 	struct vhost_virtqueue **vqs;
 	void **queue;
+	struct xdp_buff *xdp;
 	int i;
 
 	n = kvmalloc(sizeof *n, GFP_KERNEL | __GFP_RETRY_MAYFAIL);
@@ -1101,6 +1239,14 @@ static int vhost_net_open(struct inode *inode, struct file *f)
 	}
 	n->vqs[VHOST_NET_VQ_RX].rxq.queue = queue;
 
+	xdp = kmalloc_array(VHOST_NET_BATCH, sizeof(*xdp), GFP_KERNEL);
+	if (!xdp) {
+		kfree(vqs);
+		kvfree(n);
+		kfree(queue);
+	}
+	n->vqs[VHOST_NET_VQ_TX].xdp = xdp;
+
 	dev = &n->dev;
 	vqs[VHOST_NET_VQ_TX] = &n->vqs[VHOST_NET_VQ_TX].vq;
 	vqs[VHOST_NET_VQ_RX] = &n->vqs[VHOST_NET_VQ_RX].vq;
@@ -1111,6 +1257,7 @@ static int vhost_net_open(struct inode *inode, struct file *f)
 		n->vqs[i].ubuf_info = NULL;
 		n->vqs[i].upend_idx = 0;
 		n->vqs[i].done_idx = 0;
+		n->vqs[i].batched_xdp = 0;
 		n->vqs[i].vhost_hlen = 0;
 		n->vqs[i].sock_hlen = 0;
 		n->vqs[i].rx_ring = NULL;
@@ -1194,6 +1341,7 @@ static int vhost_net_release(struct inode *inode, struct file *f)
 	 * since jobs can re-queue themselves. */
 	vhost_net_flush(n);
 	kfree(n->vqs[VHOST_NET_VQ_RX].rxq.queue);
+	kfree(n->vqs[VHOST_NET_VQ_TX].xdp);
 	kfree(n->dev.vqs);
 	kvfree(n);
 	return 0;
-- 
2.17.1

