Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53E4C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 03:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980012183C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 03:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980012183C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbeHMF6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 01:58:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727798AbeHMF6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 01:58:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DFAAE401B3BC;
        Mon, 13 Aug 2018 03:17:58 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-183.pek2.redhat.com [10.72.12.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D51992156712;
        Mon, 13 Aug 2018 03:17:55 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, jbrouer@redhat.com,
        mst@redhat.com, Jason Wang <jasowang@redhat.com>
Subject: [RFC PATCH net-next V2 6/6] virtio-net: support XDP rx handler
Date:   Mon, 13 Aug 2018 11:17:30 +0800
Message-Id: <1534130250-5302-7-git-send-email-jasowang@redhat.com>
In-Reply-To: <1534130250-5302-1-git-send-email-jasowang@redhat.com>
References: <1534130250-5302-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 13 Aug 2018 03:17:58 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 13 Aug 2018 03:17:58 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tries to add the support of XDP rx handler to
virtio-net. This is straight-forward, just call xdp_do_pass() and
behave depends on its return value.

Test was done by using XDP_DROP (xdp1) for macvlan on top of
virtio-net. PPS of SKB mode was ~1.2Mpps while PPS of native XDP mode
was ~2.2Mpps. About 83% improvement was measured.

Notes: for RFC, only mergeable buffer case was implemented.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 62311dd..1e22ad9 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -777,6 +777,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	rcu_read_lock();
 	xdp_prog = rcu_dereference(rq->xdp_prog);
 	if (xdp_prog) {
+		rx_xdp_handler_result_t ret;
 		struct xdp_frame *xdpf;
 		struct page *xdp_page;
 		struct xdp_buff xdp;
@@ -825,6 +826,15 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 
 		switch (act) {
 		case XDP_PASS:
+			ret = xdp_do_pass(&xdp);
+			if (ret == RX_XDP_HANDLER_DROP)
+				goto drop;
+			if (ret != RX_XDP_HANDLER_FALLBACK) {
+				if (unlikely(xdp_page != page))
+					put_page(page);
+				rcu_read_unlock();
+				goto xdp_xmit;
+			}
 			/* recalculate offset to account for any header
 			 * adjustments. Note other cases do not build an
 			 * skb and avoid using offset
@@ -881,6 +891,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 		case XDP_ABORTED:
 			trace_xdp_exception(vi->dev, xdp_prog, act);
 			/* fall through */
+drop:
 		case XDP_DROP:
 			if (unlikely(xdp_page != page))
 				__free_pages(xdp_page, 0);
-- 
2.7.4

