Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ZjGSEkPzG1vfYwAAmS7hNA
	; Sat, 09 Jun 2018 15:33:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 093F8608BF; Sat,  9 Jun 2018 15:33:53 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxSlQGIM"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3C24F606FA;
	Sat,  9 Jun 2018 15:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3C24F606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932456AbeFIPdt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:33:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932755AbeFIPdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:33:45 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DF9D204EC;
        Sat,  9 Jun 2018 15:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558425;
        bh=+TytJBhtKIEuNTh1vWhtnWG1R0UsvjXzeDLxFlRwoWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FxSlQGIMWhmFrGlIR3A36E/qGYmumZKFiQ2Q3kgRt09OUr4hLwYms+cUN+/LDj4zE
         2JKGAbOOQmKYNEIFurMqm9oTNZqmqEoTsZq377PakOuV+rhg6YfmAohPoJpSSpRPge
         IdKHQkra4eSH3kwSoDhrjuuoMfk0w48BF9RP8n6M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 47/48] vhost_net: flush batched heads before trying to busy polling
Date: Sat,  9 Jun 2018 17:29:59 +0200
Message-Id: <20180609145950.955667847@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609145947.679103414@linuxfoundation.org>
References: <20180609145947.679103414@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Wang <jasowang@redhat.com>

[ Upstream commit f5a4941aa6d190e676065e8f4ed35999f52a01c3 ]

After commit e2b3b35eb989 ("vhost_net: batch used ring update in rx"),
we tend to batch updating used heads. But it doesn't flush batched
heads before trying to do busy polling, this will cause vhost to wait
for guest TX which waits for the used RX. Fixing by flush batched
heads before busy loop.

1 byte TCP_RR performance recovers from 13107.83 to 50402.65.

Fixes: e2b3b35eb989 ("vhost_net: batch used ring update in rx")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vhost/net.c |   37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -101,7 +101,9 @@ struct vhost_net_virtqueue {
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
@@ -620,6 +622,18 @@ static int sk_has_rx_data(struct sock *s
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
@@ -629,6 +643,8 @@ static int vhost_net_rx_peek_head_len(st
 	int len = peek_head_len(rvq, sk);
 
 	if (!len && vq->busyloop_timeout) {
+		/* Flush batched heads first */
+		vhost_rx_signal_used(rvq);
 		/* Both tx vq and rx socket were polled here */
 		mutex_lock_nested(&vq->mutex, 1);
 		vhost_disable_notify(&net->dev, vq);
@@ -756,7 +772,7 @@ static void handle_rx(struct vhost_net *
 	};
 	size_t total_len = 0;
 	int err, mergeable;
-	s16 headcount, nheads = 0;
+	s16 headcount;
 	size_t vhost_hlen, sock_hlen;
 	size_t vhost_len, sock_len;
 	struct socket *sock;
@@ -784,8 +800,8 @@ static void handle_rx(struct vhost_net *
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
@@ -856,12 +872,9 @@ static void handle_rx(struct vhost_net *
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
@@ -872,9 +885,7 @@ static void handle_rx(struct vhost_net *
 	}
 	vhost_net_enable_vq(net, vq);
 out:
-	if (nheads)
-		vhost_add_used_and_signal_n(&net->dev, vq, vq->heads,
-					    nheads);
+	vhost_rx_signal_used(nvq);
 	mutex_unlock(&vq->mutex);
 }
 
