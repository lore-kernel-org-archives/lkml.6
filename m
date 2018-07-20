Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5172ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE9E2084E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE9E2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731655AbeGTBBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 21:01:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727615AbeGTBBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 21:01:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3159A4059FF7;
        Fri, 20 Jul 2018 00:16:04 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-42.pek2.redhat.com [10.72.12.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4CED2026D6B;
        Fri, 20 Jul 2018 00:16:00 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, netdev@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 9/9] vhost_net: batch update used ring for datacopy TX
Date:   Fri, 20 Jul 2018 08:15:21 +0800
Message-Id: <1532045721-4958-10-git-send-email-jasowang@redhat.com>
In-Reply-To: <1532045721-4958-1-git-send-email-jasowang@redhat.com>
References: <1532045721-4958-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 20 Jul 2018 00:16:04 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 20 Jul 2018 00:16:04 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like commit e2b3b35eb989 ("vhost_net: batch used ring update in rx"),
this patches implements batch used ring update for datacopy TX
(zerocopy has already done some kind of batching).

Testpmd transmission from guest to host (XDP_DROP on tap) shows 25.8%
improvement (from ~3.1Mpps to ~3.9Mpps) on Broadwell i7-5600U CPU @
2.60GHz machine. Netperf TCP tests does not show obvious differences.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 2fd2f0e3..367d802 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -428,16 +428,31 @@ static int vhost_net_enable_vq(struct vhost_net *n,
 	return vhost_poll_start(poll, sock->file);
 }
 
+static void vhost_net_signal_used(struct vhost_net_virtqueue *nvq)
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
 static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
-				    struct vhost_virtqueue *vq,
+				    struct vhost_net_virtqueue *nvq,
 				    unsigned int *out_num, unsigned int *in_num,
 				    bool *busyloop_intr)
 {
+	struct vhost_virtqueue *vq = &nvq->vq;
 	unsigned long uninitialized_var(endtime);
 	int r = vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov),
 				  out_num, in_num, NULL, NULL);
 
 	if (r == vq->num && vq->busyloop_timeout) {
+		if (!vhost_sock_zcopy(vq->private_data))
+			vhost_net_signal_used(nvq);
 		preempt_disable();
 		endtime = busy_clock() + vq->busyloop_timeout;
 		while (vhost_can_busy_poll(endtime)) {
@@ -493,7 +508,8 @@ static int get_tx_bufs(struct vhost_net *net,
 	struct vhost_virtqueue *vq = &nvq->vq;
 	int ret;
 
-	ret = vhost_net_tx_get_vq_desc(net, vq, out, in, busyloop_intr);
+	ret = vhost_net_tx_get_vq_desc(net, nvq, out, in, busyloop_intr);
+
 	if (ret < 0 || ret == vq->num)
 		return ret;
 
@@ -557,6 +573,9 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 			break;
 		}
 
+		vq->heads[nvq->done_idx].id = cpu_to_vhost32(vq, head);
+		vq->heads[nvq->done_idx].len = 0;
+
 		total_len += len;
 		if (tx_can_batch(vq, total_len))
 			msg.msg_flags |= MSG_MORE;
@@ -573,12 +592,15 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 		if (err != len)
 			pr_debug("Truncated TX packet: len %d != %zd\n",
 				 err, len);
-		vhost_add_used_and_signal(&net->dev, vq, head, 0);
+		if (++nvq->done_idx >= VHOST_NET_BATCH)
+			vhost_net_signal_used(nvq);
 		if (vhost_exceeds_weight(++sent_pkts, total_len)) {
 			vhost_poll_queue(&vq->poll);
 			break;
 		}
 	}
+
+	vhost_net_signal_used(nvq);
 }
 
 static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
@@ -741,18 +763,6 @@ static int sk_has_rx_data(struct sock *sk)
 	return skb_queue_empty(&sk->sk_receive_queue);
 }
 
-static void vhost_net_signal_used(struct vhost_net_virtqueue *nvq)
-{
-	struct vhost_virtqueue *vq = &nvq->vq;
-	struct vhost_dev *dev = vq->dev;
-
-	if (!nvq->done_idx)
-		return;
-
-	vhost_add_used_and_signal_n(dev, vq, vq->heads, nvq->done_idx);
-	nvq->done_idx = 0;
-}
-
 static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
 				      bool *busyloop_intr)
 {
-- 
2.7.4

