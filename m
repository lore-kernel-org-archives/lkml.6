Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371E8C04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 03:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFACD2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 03:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFACD2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbeILIUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 04:20:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40112 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728125AbeILIUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 04:20:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1E5BA40216F7;
        Wed, 12 Sep 2018 03:17:50 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-130.pek2.redhat.com [10.72.12.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D0E22027EA4;
        Wed, 12 Sep 2018 03:17:46 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        mst@redhat.com, jasowang@redhat.com
Subject: [PATCH net-next V2 06/11] tuntap: split out XDP logic
Date:   Wed, 12 Sep 2018 11:17:04 +0800
Message-Id: <20180912031709.14112-7-jasowang@redhat.com>
In-Reply-To: <20180912031709.14112-1-jasowang@redhat.com>
References: <20180912031709.14112-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 12 Sep 2018 03:17:50 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 12 Sep 2018 03:17:50 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch split out XDP logic into a single function. This make it to
be reused by XDP batching path in the following patch.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 88 +++++++++++++++++++++++++++--------------------
 1 file changed, 51 insertions(+), 37 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 946c6148ed75..14fe94098180 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1636,14 +1636,14 @@ static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
 }
 
 static struct sk_buff *__tun_build_skb(struct page_frag *alloc_frag, char *buf,
-				       int buflen, int len, int pad, int delta)
+				       int buflen, int len, int pad)
 {
 	struct sk_buff *skb = build_skb(buf, buflen);
 
 	if (!skb)
 		return ERR_PTR(-ENOMEM);
 
-	skb_reserve(skb, pad - delta);
+	skb_reserve(skb, pad);
 	skb_put(skb, len);
 
 	get_page(alloc_frag->page);
@@ -1652,6 +1652,39 @@ static struct sk_buff *__tun_build_skb(struct page_frag *alloc_frag, char *buf,
 	return skb;
 }
 
+static int tun_xdp_act(struct tun_struct *tun, struct bpf_prog *xdp_prog,
+		       struct xdp_buff *xdp, u32 act)
+{
+	int err;
+
+	switch (act) {
+	case XDP_REDIRECT:
+		err = xdp_do_redirect(tun->dev, xdp, xdp_prog);
+		xdp_do_flush_map();
+		if (err)
+			return err;
+		break;
+	case XDP_TX:
+		err = tun_xdp_tx(tun->dev, xdp);
+		if (err < 0)
+			return err;
+		break;
+	case XDP_PASS:
+		break;
+	default:
+		bpf_warn_invalid_xdp_action(act);
+		/* fall through */
+	case XDP_ABORTED:
+		trace_xdp_exception(tun->dev, xdp_prog, act);
+		/* fall through */
+	case XDP_DROP:
+		this_cpu_inc(tun->pcpu_stats->rx_dropped);
+		break;
+	}
+
+	return act;
+}
+
 static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 				     struct tun_file *tfile,
 				     struct iov_iter *from,
@@ -1661,10 +1694,10 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	struct page_frag *alloc_frag = &current->task_frag;
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
@@ -1690,7 +1723,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	 */
 	if (hdr->gso_type || !xdp_prog) {
 		*skb_xdp = 1;
-		return __tun_build_skb(alloc_frag, buf, buflen, len, pad, delta);
+		return __tun_build_skb(alloc_frag, buf, buflen, len, pad);
 	}
 
 	*skb_xdp = 0;
@@ -1698,9 +1731,8 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	local_bh_disable();
 	rcu_read_lock();
 	xdp_prog = rcu_dereference(tun->xdp_prog);
-	if (xdp_prog && !*skb_xdp) {
+	if (xdp_prog) {
 		struct xdp_buff xdp;
-		void *orig_data;
 		u32 act;
 
 		xdp.data_hard_start = buf;
@@ -1708,49 +1740,31 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 		xdp_set_data_meta_invalid(&xdp);
 		xdp.data_end = xdp.data + len;
 		xdp.rxq = &tfile->xdp_rxq;
-		orig_data = xdp.data;
-		act = bpf_prog_run_xdp(xdp_prog, &xdp);
 
-		switch (act) {
-		case XDP_REDIRECT:
-			get_page(alloc_frag->page);
-			alloc_frag->offset += buflen;
-			err = xdp_do_redirect(tun->dev, &xdp, xdp_prog);
-			xdp_do_flush_map();
-			if (err)
-				goto err_redirect;
-			goto out;
-		case XDP_TX:
+		act = bpf_prog_run_xdp(xdp_prog, &xdp);
+		if (act == XDP_REDIRECT || act == XDP_TX) {
 			get_page(alloc_frag->page);
 			alloc_frag->offset += buflen;
-			if (tun_xdp_tx(tun->dev, &xdp) < 0)
-				goto err_redirect;
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
-			goto out;
 		}
+		err = tun_xdp_act(tun, xdp_prog, &xdp, act);
+		if (err < 0)
+			goto err_xdp;
+		if (err != XDP_PASS)
+			goto out;
+
+		pad = xdp.data - xdp.data_hard_start;
+		len = xdp.data_end - xdp.data;
 	}
 	rcu_read_unlock();
 	local_bh_enable();
 
-	return __tun_build_skb(alloc_frag, buf, buflen, len, pad, delta);
+	return __tun_build_skb(alloc_frag, buf, buflen, len, pad);
 
-err_redirect:
+err_xdp:
 	put_page(alloc_frag->page);
 out:
 	rcu_read_unlock();
 	local_bh_enable();
-	this_cpu_inc(tun->pcpu_stats->rx_dropped);
 	return NULL;
 }
 
-- 
2.17.1

