Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07017C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF69C2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF69C2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388238AbeKOTu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:50:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58460 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729039AbeKOTu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:50:27 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 382072D811;
        Thu, 15 Nov 2018 09:43:23 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-99.pek2.redhat.com [10.72.12.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9BC701A92F;
        Thu, 15 Nov 2018 09:43:18 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] tuntap: free XDP dropped packets in a batch
Date:   Thu, 15 Nov 2018 17:43:10 +0800
Message-Id: <20181115094310.17307-2-jasowang@redhat.com>
In-Reply-To: <20181115094310.17307-1-jasowang@redhat.com>
References: <20181115094310.17307-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 15 Nov 2018 09:43:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to the batched XDP buffs through msg_control. Instead of
calling put_page() for each page which involves a atomic operation,
let's batch them by record the last page that needs to be freed and
its refcnt count and free them in a batch.

Testpmd(virtio-user + vhost_net) + XDP_DROP shows 3.8% improvement.

Before: 4.71Mpps
After : 4.89Mpps

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index a65779c6d72f..e90a7923a5f6 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -188,6 +188,11 @@ struct tun_file {
 	struct xdp_rxq_info xdp_rxq;
 };
 
+struct tun_page {
+	struct page *page;
+	int count;
+};
+
 struct tun_flow_entry {
 	struct hlist_node hash_link;
 	struct rcu_head rcu;
@@ -2377,9 +2382,16 @@ static void tun_sock_write_space(struct sock *sk)
 	kill_fasync(&tfile->fasync, SIGIO, POLL_OUT);
 }
 
+static void tun_put_page(struct tun_page *tpage)
+{
+	if (tpage->page)
+		__page_frag_cache_drain(tpage->page, tpage->count);
+}
+
 static int tun_xdp_one(struct tun_struct *tun,
 		       struct tun_file *tfile,
-		       struct xdp_buff *xdp, int *flush)
+		       struct xdp_buff *xdp, int *flush,
+		       struct tun_page *tpage)
 {
 	struct tun_xdp_hdr *hdr = xdp->data_hard_start;
 	struct virtio_net_hdr *gso = &hdr->gso;
@@ -2390,6 +2402,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 	int buflen = hdr->buflen;
 	int err = 0;
 	bool skb_xdp = false;
+	struct page *page;
 
 	xdp_prog = rcu_dereference(tun->xdp_prog);
 	if (xdp_prog) {
@@ -2416,7 +2429,14 @@ static int tun_xdp_one(struct tun_struct *tun,
 		case XDP_PASS:
 			break;
 		default:
-			put_page(virt_to_head_page(xdp->data));
+			page = virt_to_head_page(xdp->data);
+			if (tpage->page == page) {
+				++tpage->count;
+			} else {
+				tun_put_page(tpage);
+				tpage->page = page;
+				tpage->count = 1;
+			}
 			return 0;
 		}
 	}
@@ -2480,6 +2500,7 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 		return -EBADFD;
 
 	if (ctl && (ctl->type == TUN_MSG_PTR)) {
+		struct tun_page tpage = {0};
 		int n = ctl->num;
 		int flush = 0;
 
@@ -2488,7 +2509,7 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 
 		for (i = 0; i < n; i++) {
 			xdp = &((struct xdp_buff *)ctl->ptr)[i];
-			tun_xdp_one(tun, tfile, xdp, &flush);
+			tun_xdp_one(tun, tfile, xdp, &flush, &tpage);
 		}
 
 		if (flush)
@@ -2497,6 +2518,8 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 		rcu_read_unlock();
 		local_bh_enable();
 
+		tun_put_page(&tpage);
+
 		ret = total_len;
 		goto out;
 	}
-- 
2.17.1

