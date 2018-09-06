Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6C4C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 04:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA6F2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 04:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA6F2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeIFIjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 04:39:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727993AbeIFIjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 04:39:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 137A4402332F;
        Thu,  6 Sep 2018 04:06:16 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-125.pek2.redhat.com [10.72.12.125])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33F7E101041E;
        Thu,  6 Sep 2018 04:06:10 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        mst@redhat.com, jasowang@redhat.com
Subject: [PATCH net-next 09/11] tuntap: accept an array of XDP buffs through sendmsg()
Date:   Thu,  6 Sep 2018 12:05:24 +0800
Message-Id: <20180906040526.22518-10-jasowang@redhat.com>
In-Reply-To: <20180906040526.22518-1-jasowang@redhat.com>
References: <20180906040526.22518-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 06 Sep 2018 04:06:16 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 06 Sep 2018 04:06:16 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implement TUN_MSG_PTR msg_control type. This type allows
the caller to pass an array of XDP buffs to tuntap through ptr field
of the tun_msg_control. If an XDP program is attached, tuntap can run
XDP program directly. If not, tuntap will build skb and do a fast
receiving since part of the work has been done by vhost_net.

This will avoid lots of indirect calls thus improves the icache
utilization and allows to do XDP batched flushing when doing XDP
redirection.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 103 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 100 insertions(+), 3 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index c839a4bdcbd9..069db2e5dd08 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2424,22 +2424,119 @@ static void tun_sock_write_space(struct sock *sk)
 	kill_fasync(&tfile->fasync, SIGIO, POLL_OUT);
 }
 
+static int tun_xdp_one(struct tun_struct *tun,
+		       struct tun_file *tfile,
+		       struct xdp_buff *xdp, int *flush)
+{
+	struct virtio_net_hdr *gso = xdp->data_hard_start + sizeof(int);
+	struct tun_pcpu_stats *stats;
+	struct bpf_prog *xdp_prog;
+	struct sk_buff *skb = NULL;
+	u32 rxhash = 0, act;
+	int buflen = *(int *)xdp->data_hard_start;
+	int err = 0;
+	bool skb_xdp = false;
+
+	xdp_prog = rcu_dereference(tun->xdp_prog);
+	if (xdp_prog) {
+		if (gso->gso_type) {
+			skb_xdp = true;
+			goto build;
+		}
+		xdp_set_data_meta_invalid(xdp);
+		xdp->rxq = &tfile->xdp_rxq;
+		act = tun_do_xdp(tun, tfile, xdp_prog, xdp, &err);
+		if (err)
+			goto out;
+		if (act == XDP_REDIRECT)
+			*flush = true;
+		if (act != XDP_PASS)
+			goto out;
+	}
+
+build:
+	skb = build_skb(xdp->data_hard_start, buflen);
+	if (!skb) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	skb_reserve(skb, xdp->data - xdp->data_hard_start);
+	skb_put(skb, xdp->data_end - xdp->data);
+
+	if (virtio_net_hdr_to_skb(skb, gso, tun_is_little_endian(tun))) {
+		this_cpu_inc(tun->pcpu_stats->rx_frame_errors);
+		kfree_skb(skb);
+		err = -EINVAL;
+		goto out;
+	}
+
+	skb->protocol = eth_type_trans(skb, tun->dev);
+	skb_reset_network_header(skb);
+	skb_probe_transport_header(skb, 0);
+
+	if (skb_xdp) {
+		err = do_xdp_generic(xdp_prog, skb);
+		if (err != XDP_PASS)
+			goto out;
+	}
+
+	if (!rcu_dereference(tun->steering_prog))
+		rxhash = __skb_get_hash_symmetric(skb);
+
+	netif_receive_skb(skb);
+
+	stats = get_cpu_ptr(tun->pcpu_stats);
+	u64_stats_update_begin(&stats->syncp);
+	stats->rx_packets++;
+	stats->rx_bytes += skb->len;
+	u64_stats_update_end(&stats->syncp);
+	put_cpu_ptr(stats);
+
+	if (rxhash)
+		tun_flow_update(tun, rxhash, tfile);
+
+out:
+	return err;
+}
+
 static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 {
-	int ret;
+	int ret, i;
 	struct tun_file *tfile = container_of(sock, struct tun_file, socket);
 	struct tun_struct *tun = tun_get(tfile);
 	struct tun_msg_ctl *ctl = m->msg_control;
+	struct xdp_buff *xdp;
 
 	if (!tun)
 		return -EBADFD;
 
-	if (ctl && ctl->type != TUN_MSG_UBUF)
-		return -EINVAL;
+	if (ctl && ((ctl->type & 0xF) == TUN_MSG_PTR)) {
+		int n = ctl->type >> 16;
+		int flush = 0;
+
+		local_bh_disable();
+		rcu_read_lock();
+
+		for (i = 0; i < n; i++) {
+			xdp = &((struct xdp_buff *)ctl->ptr)[i];
+			tun_xdp_one(tun, tfile, xdp, &flush);
+		}
+
+		if (flush)
+			xdp_do_flush_map();
+
+		rcu_read_unlock();
+		local_bh_enable();
+
+		ret = total_len;
+		goto out;
+	}
 
 	ret = tun_get_user(tun, tfile, ctl ? ctl->ptr : NULL, &m->msg_iter,
 			   m->msg_flags & MSG_DONTWAIT,
 			   m->msg_flags & MSG_MORE);
+out:
 	tun_put(tun);
 	return ret;
 }
-- 
2.17.1

