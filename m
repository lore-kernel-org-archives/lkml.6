Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6770EC04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 03:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296492088E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 03:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296492088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbeILIUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 04:20:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728242AbeILIUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 04:20:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6D2B5804B4DB;
        Wed, 12 Sep 2018 03:18:06 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-130.pek2.redhat.com [10.72.12.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB04D2027EB7;
        Wed, 12 Sep 2018 03:18:01 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        mst@redhat.com, jasowang@redhat.com
Subject: [PATCH net-next V2 10/11] tap: accept an array of XDP buffs through sendmsg()
Date:   Wed, 12 Sep 2018 11:17:08 +0800
Message-Id: <20180912031709.14112-11-jasowang@redhat.com>
In-Reply-To: <20180912031709.14112-1-jasowang@redhat.com>
References: <20180912031709.14112-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 12 Sep 2018 03:18:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 12 Sep 2018 03:18:06 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implement TUN_MSG_PTR msg_control type. This type allows
the caller to pass an array of XDP buffs to tuntap through ptr field
of the tun_msg_control. Tap will build skb through those XDP buffers.

This will avoid lots of indirect calls thus improves the icache
utilization and allows to do XDP batched flushing when doing XDP
redirection.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tap.c | 74 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 7996ed7cbf18..a4ab4a791fe7 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1146,14 +1146,84 @@ static const struct file_operations tap_fops = {
 #endif
 };
 
+static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
+{
+	struct tun_xdp_hdr *hdr = xdp->data_hard_start;
+	struct virtio_net_hdr *gso = &hdr->gso;
+	int buflen = hdr->buflen;
+	int vnet_hdr_len = 0;
+	struct tap_dev *tap;
+	struct sk_buff *skb;
+	int err, depth;
+
+	if (q->flags & IFF_VNET_HDR)
+		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
+
+	skb = build_skb(xdp->data_hard_start, buflen);
+	if (!skb) {
+		err = -ENOMEM;
+		goto err;
+	}
+
+	skb_reserve(skb, xdp->data - xdp->data_hard_start);
+	skb_put(skb, xdp->data_end - xdp->data);
+
+	skb_set_network_header(skb, ETH_HLEN);
+	skb_reset_mac_header(skb);
+	skb->protocol = eth_hdr(skb)->h_proto;
+
+	if (vnet_hdr_len) {
+		err = virtio_net_hdr_to_skb(skb, gso, tap_is_little_endian(q));
+		if (err)
+			goto err_kfree;
+	}
+
+	skb_probe_transport_header(skb, ETH_HLEN);
+
+	/* Move network header to the right position for VLAN tagged packets */
+	if ((skb->protocol == htons(ETH_P_8021Q) ||
+	     skb->protocol == htons(ETH_P_8021AD)) &&
+	    __vlan_get_protocol(skb, skb->protocol, &depth) != 0)
+		skb_set_network_header(skb, depth);
+
+	rcu_read_lock();
+	tap = rcu_dereference(q->tap);
+	if (tap) {
+		skb->dev = tap->dev;
+		dev_queue_xmit(skb);
+	} else {
+		kfree_skb(skb);
+	}
+	rcu_read_unlock();
+
+	return 0;
+
+err_kfree:
+	kfree_skb(skb);
+err:
+	rcu_read_lock();
+		tap = rcu_dereference(q->tap);
+	if (tap && tap->count_tx_dropped)
+		tap->count_tx_dropped(tap);
+	rcu_read_unlock();
+	return err;
+}
+
 static int tap_sendmsg(struct socket *sock, struct msghdr *m,
 		       size_t total_len)
 {
 	struct tap_queue *q = container_of(sock, struct tap_queue, sock);
 	struct tun_msg_ctl *ctl = m->msg_control;
+	struct xdp_buff *xdp;
+	int i;
 
-	if (ctl && ctl->type != TUN_MSG_UBUF)
-		return -EINVAL;
+	if (ctl && (ctl->type == TUN_MSG_PTR)) {
+		for (i = 0; i < ctl->num; i++) {
+			xdp = &((struct xdp_buff *)ctl->ptr)[i];
+			tap_get_user_xdp(q, xdp);
+		}
+		return 0;
+	}
 
 	return tap_get_user(q, ctl ? ctl->ptr : NULL, &m->msg_iter,
 			    m->msg_flags & MSG_DONTWAIT);
-- 
2.17.1

