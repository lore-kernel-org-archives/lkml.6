Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C76FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A74C20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A74C20853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbeINN2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:28:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12129 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726883AbeINN1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:27:54 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9CE095FEF1D92;
        Fri, 14 Sep 2018 16:14:29 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Fri, 14 Sep 2018 16:14:24 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <netdev@vger.kernel.org>, <gregkh@linux-foundation.org>,
        <dwmw2@infradead.org>, <eric.dumazet@gmail.com>,
        <davem@davemloft.net>, <stable@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <maowenan@huawei.com>
Subject: [PATCH stable 4.4 V2 4/6] tcp: free batches of packets in tcp_prune_ofo_queue()
Date:   Fri, 14 Sep 2018 16:24:08 +0800
Message-ID: <1536913450-12380-5-git-send-email-maowenan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1536913450-12380-1-git-send-email-maowenan@huawei.com>
References: <1536913450-12380-1-git-send-email-maowenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 72cd43ba64fc172a443410ce01645895850844c8 ]

Juha-Matti Tilli reported that malicious peers could inject tiny
packets in out_of_order_queue, forcing very expensive calls
to tcp_collapse_ofo_queue() and tcp_prune_ofo_queue() for
every incoming packet. out_of_order_queue rb-tree can contain
thousands of nodes, iterating over all of them is not nice.

Before linux-4.9, we would have pruned all packets in ofo_queue
in one go, every XXXX packets. XXXX depends on sk_rcvbuf and skbs
truesize, but is about 7000 packets with tcp_rmem[2] default of 6 MB.

Since we plan to increase tcp_rmem[2] in the future to cope with
modern BDP, can not revert to the old behavior, without great pain.

Strategy taken in this patch is to purge ~12.5 % of the queue capacity.

Fixes: 36a6503fedda ("tcp: refine tcp_prune_ofo_queue() to not drop all packets")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Juha-Matti Tilli <juha-matti.tilli@iki.fi>
Acked-by: Yuchung Cheng <ycheng@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 net/ipv4/tcp_input.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 4cc0a53..4739a93 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4899,27 +4899,33 @@ new_range:
 
 /*
  * Purge the out-of-order queue.
+ * Drop at least 12.5 % of sk_rcvbuf to avoid malicious attacks.
  * Return true if queue was pruned.
  */
 static bool tcp_prune_ofo_queue(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct rb_node *node, *prev;
+	int goal;
 
 	if (RB_EMPTY_ROOT(&tp->out_of_order_queue))
 		return false;
 
 	NET_INC_STATS_BH(sock_net(sk), LINUX_MIB_OFOPRUNED);
-
+	goal = sk->sk_rcvbuf >> 3;
 	node = &tp->ooo_last_skb->rbnode;
 	do {
 		prev = rb_prev(node);
 		rb_erase(node, &tp->out_of_order_queue);
+		goal -= rb_to_skb(node)->truesize;
 		__kfree_skb(rb_to_skb(node));
-		sk_mem_reclaim(sk);
-		if (atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf &&
-		    !tcp_under_memory_pressure(sk))
-			break;
+		if (!prev || goal <= 0) {
+			sk_mem_reclaim(sk);
+			if (atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf &&
+			    !tcp_under_memory_pressure(sk))
+				break;
+			goal = sk->sk_rcvbuf >> 3;
+		}
 
 		node = prev;
 	} while (node);
-- 
1.8.3.1

