Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbeEUJFd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 05:05:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751368AbeEUJFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 05:05:21 -0400
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 09/12] tuntap: split out XDP logic
Date: Mon, 21 May 2018 17:04:30 +0800
Message-Id: <1526893473-20128-10-git-send-email-jasowang@redhat.com>
In-Reply-To: <1526893473-20128-1-git-send-email-jasowang@redhat.com>
References: <1526893473-20128-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch split out XDP logic into a single function. This make it to
be reused by XDP batching path in the following patch.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 85 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 34 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index ed04291..2560378 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1605,6 +1605,44 @@ static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
 	return true;
 }
 
+static u32 tun_do_xdp(struct tun_struct *tun,
+		      struct tun_file *tfile,
+		      struct bpf_prog *xdp_prog,
+		      struct xdp_buff *xdp,
+		      int *err)
+{
+	u32 act = bpf_prog_run_xdp(xdp_prog, xdp);
+
+	switch (act) {
+	case XDP_REDIRECT:
+		*err = xdp_do_redirect(tun->dev, xdp, xdp_prog);
+		xdp_do_flush_map();
+		if (*err)
+			break;
+		goto out;
+	case XDP_TX:
+		*err = tun_xdp_tx(tun->dev, xdp);
+		if (*err)
+			break;
+		tun_xdp_flush(tun->dev);
+		goto out;
+	case XDP_PASS:
+		goto out;
+	default:
+		bpf_warn_invalid_xdp_action(act);
+		/* fall through */
+	case XDP_ABORTED:
+		trace_xdp_exception(tun->dev, xdp_prog, act);
+		/* fall through */
+	case XDP_DROP:
+		break;
+	}
+
+	put_page(virt_to_head_page(xdp->data_hard_start));
+out:
+	return act;
+}
+
 static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 				     struct tun_file *tfile,
 				     struct iov_iter *from,
@@ -1615,10 +1653,10 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	struct sk_buff *skb = NULL;
 	struct bpf_prog *xdp_prog;
 	int buflen = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-	unsigned int delta = 0;
 	char *buf;
 	size_t copied;
-	int err, pad = TUN_RX_PAD;
+	int pad = TUN_RX_PAD;
+	int err = 0;
 
 	rcu_read_lock();
 	xdp_prog = rcu_dereference(tun->xdp_prog);
@@ -1655,9 +1693,8 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	preempt_disable();
 	rcu_read_lock();
 	xdp_prog = rcu_dereference(tun->xdp_prog);
-	if (xdp_prog && !*skb_xdp) {
+	if (xdp_prog) {
 		struct xdp_buff xdp;
-		void *orig_data;
 		u32 act;
 
 		xdp.data_hard_start = buf;
@@ -1665,34 +1702,14 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 		xdp_set_data_meta_invalid(&xdp);
 		xdp.data_end = xdp.data + len;
 		xdp.rxq = &tfile->xdp_rxq;
-		orig_data = xdp.data;
-		act = bpf_prog_run_xdp(xdp_prog, &xdp);
-
-		switch (act) {
-		case XDP_REDIRECT:
-			err = xdp_do_redirect(tun->dev, &xdp, xdp_prog);
-			xdp_do_flush_map();
-			if (err)
-				goto err_xdp;
-			goto out;
-		case XDP_TX:
-			if (tun_xdp_tx(tun->dev, &xdp))
-				goto err_xdp;
-			tun_xdp_flush(tun->dev);
-			goto out;
-		case XDP_PASS:
-			delta = orig_data - xdp.data;
-			len = xdp.data_end - xdp.data;
-			break;
-		default:
-			bpf_warn_invalid_xdp_action(act);
-			/* fall through */
-		case XDP_ABORTED:
-			trace_xdp_exception(tun->dev, xdp_prog, act);
-			/* fall through */
-		case XDP_DROP:
+		act = tun_do_xdp(tun, tfile, xdp_prog, &xdp, &err);
+		if (err)
 			goto err_xdp;
-		}
+		if (act != XDP_PASS)
+			goto out;
+
+		pad = xdp.data - xdp.data_hard_start;
+		len = xdp.data_end - xdp.data;
 	}
 	rcu_read_unlock();
 	preempt_enable();
@@ -1700,18 +1717,18 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 build:
 	skb = build_skb(buf, buflen);
 	if (!skb) {
+		put_page(alloc_frag->page);
 		skb = ERR_PTR(-ENOMEM);
 		goto out;
 	}
 
-	skb_reserve(skb, pad - delta);
+	skb_reserve(skb, pad);
 	skb_put(skb, len);
 
 	return skb;
 
 err_xdp:
-	alloc_frag->offset -= buflen;
-	put_page(alloc_frag->page);
+	this_cpu_inc(tun->pcpu_stats->rx_dropped);
 out:
 	rcu_read_unlock();
 	preempt_enable();
-- 
2.7.4
