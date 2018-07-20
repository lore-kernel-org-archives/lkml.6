Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BE2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8A720673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8A720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbeGTBB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 21:01:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37738 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731446AbeGTBBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 21:01:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B9D4A400B45C;
        Fri, 20 Jul 2018 00:15:51 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-42.pek2.redhat.com [10.72.12.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C891C2026D6B;
        Fri, 20 Jul 2018 00:15:48 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, netdev@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 6/9] vhost_net: split out datacopy logic
Date:   Fri, 20 Jul 2018 08:15:18 +0800
Message-Id: <1532045721-4958-7-git-send-email-jasowang@redhat.com>
In-Reply-To: <1532045721-4958-1-git-send-email-jasowang@redhat.com>
References: <1532045721-4958-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 20 Jul 2018 00:15:51 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 20 Jul 2018 00:15:51 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of mixing zerocopy and datacopy logics, this patch tries to
split datacopy logic out. This results for a more compact code and
ad-hoc optimization could be done on top more easily.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 110 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 90 insertions(+), 20 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index f59b615..9cef0b2 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -520,9 +520,7 @@ static bool tx_can_batch(struct vhost_virtqueue *vq, size_t total_len)
 	       !vhost_vq_avail_empty(vq->dev, vq);
 }
 
-/* Expects to be always run from workqueue - which acts as
- * read-size critical section for our kind of RCU. */
-static void handle_tx(struct vhost_net *net)
+static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 {
 	struct vhost_net_virtqueue *nvq = &net->vqs[VHOST_NET_VQ_TX];
 	struct vhost_virtqueue *vq = &nvq->vq;
@@ -537,30 +535,76 @@ static void handle_tx(struct vhost_net *net)
 	};
 	size_t len, total_len = 0;
 	int err;
-	struct socket *sock;
-	struct vhost_net_ubuf_ref *uninitialized_var(ubufs);
-	bool zcopy, zcopy_used;
 	int sent_pkts = 0;
 
-	mutex_lock(&vq->mutex);
-	sock = vq->private_data;
-	if (!sock)
-		goto out;
+	for (;;) {
+		bool busyloop_intr = false;
 
-	if (!vq_iotlb_prefetch(vq))
-		goto out;
+		head = get_tx_bufs(net, nvq, &msg, &out, &in, &len,
+				   &busyloop_intr);
+		/* On error, stop handling until the next kick. */
+		if (unlikely(head < 0))
+			break;
+		/* Nothing new?  Wait for eventfd to tell us they refilled. */
+		if (head == vq->num) {
+			if (unlikely(busyloop_intr)) {
+				vhost_poll_queue(&vq->poll);
+			} else if (unlikely(vhost_enable_notify(&net->dev,
+								vq))) {
+				vhost_disable_notify(&net->dev, vq);
+				continue;
+			}
+			break;
+		}
 
-	vhost_disable_notify(&net->dev, vq);
-	vhost_net_disable_vq(net, vq);
+		total_len += len;
+		if (tx_can_batch(vq, total_len))
+			msg.msg_flags |= MSG_MORE;
+		else
+			msg.msg_flags &= ~MSG_MORE;
+
+		/* TODO: Check specific error and bomb out unless ENOBUFS? */
+		err = sock->ops->sendmsg(sock, &msg, len);
+		if (unlikely(err < 0)) {
+			vhost_discard_vq_desc(vq, 1);
+			vhost_net_enable_vq(net, vq);
+			break;
+		}
+		if (err != len)
+			pr_debug("Truncated TX packet: len %d != %zd\n",
+				 err, len);
+		vhost_add_used_and_signal(&net->dev, vq, head, 0);
+		if (vhost_exceeds_weight(++sent_pkts, total_len)) {
+			vhost_poll_queue(&vq->poll);
+			break;
+		}
+	}
+}
 
-	zcopy = nvq->ubufs;
+static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
+{
+	struct vhost_net_virtqueue *nvq = &net->vqs[VHOST_NET_VQ_TX];
+	struct vhost_virtqueue *vq = &nvq->vq;
+	unsigned out, in;
+	int head;
+	struct msghdr msg = {
+		.msg_name = NULL,
+		.msg_namelen = 0,
+		.msg_control = NULL,
+		.msg_controllen = 0,
+		.msg_flags = MSG_DONTWAIT,
+	};
+	size_t len, total_len = 0;
+	int err;
+	struct vhost_net_ubuf_ref *uninitialized_var(ubufs);
+	bool zcopy_used;
+	int sent_pkts = 0;
 
 	for (;;) {
 		bool busyloop_intr;
 
 		/* Release DMAs done buffers first */
-		if (zcopy)
-			vhost_zerocopy_signal_used(net, vq);
+		vhost_zerocopy_signal_used(net, vq);
 
 		busyloop_intr = false;
 		head = get_tx_bufs(net, nvq, &msg, &out, &in, &len,
@@ -579,9 +623,9 @@ static void handle_tx(struct vhost_net *net)
 			break;
 		}
 
-		zcopy_used = zcopy && len >= VHOST_GOODCOPY_LEN
-				   && !vhost_exceeds_maxpend(net)
-				   && vhost_net_tx_select_zcopy(net);
+		zcopy_used = len >= VHOST_GOODCOPY_LEN
+			     && !vhost_exceeds_maxpend(net)
+			     && vhost_net_tx_select_zcopy(net);
 
 		/* use msg_control to pass vhost zerocopy ubuf info to skb */
 		if (zcopy_used) {
@@ -636,6 +680,32 @@ static void handle_tx(struct vhost_net *net)
 			break;
 		}
 	}
+}
+
+/* Expects to be always run from workqueue - which acts as
+ * read-size critical section for our kind of RCU. */
+static void handle_tx(struct vhost_net *net)
+{
+	struct vhost_net_virtqueue *nvq = &net->vqs[VHOST_NET_VQ_TX];
+	struct vhost_virtqueue *vq = &nvq->vq;
+	struct socket *sock;
+
+	mutex_lock(&vq->mutex);
+	sock = vq->private_data;
+	if (!sock)
+		goto out;
+
+	if (!vq_iotlb_prefetch(vq))
+		goto out;
+
+	vhost_disable_notify(&net->dev, vq);
+	vhost_net_disable_vq(net, vq);
+
+	if (vhost_sock_zcopy(sock))
+		handle_tx_zerocopy(net, sock);
+	else
+		handle_tx_copy(net, sock);
+
 out:
 	mutex_unlock(&vq->mutex);
 }
-- 
2.7.4

