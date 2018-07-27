Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8766FC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439C32089F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439C32089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388650AbeG0LbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:31:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36450 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbeG0LbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:31:09 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0F5BABB6;
        Fri, 27 Jul 2018 10:09:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Juha-Matti Tilli <juha-matti.tilli@iki.fi>,
        Yuchung Cheng <ycheng@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 17/33] tcp: free batches of packets in tcp_prune_ofo_queue()
Date:   Fri, 27 Jul 2018 12:08:58 +0200
Message-Id: <20180727100828.323222556@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727100827.665729981@linuxfoundation.org>
References: <20180727100827.665729981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/skbuff.h |    2 ++
 net/ipv4/tcp_input.c   |   15 +++++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2982,6 +2982,8 @@ static inline int __skb_grow_rcsum(struc
 	return __skb_grow(skb, len);
 }
 
+#define rb_to_skb(rb) rb_entry_safe(rb, struct sk_buff, rbnode)
+
 #define skb_queue_walk(queue, skb) \
 		for (skb = (queue)->next;					\
 		     skb != (struct sk_buff *)(queue);				\
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4965,6 +4965,7 @@ new_range:
  * 2) not add too big latencies if thousands of packets sit there.
  *    (But if application shrinks SO_RCVBUF, we could still end up
  *     freeing whole queue here)
+ * 3) Drop at least 12.5 % of sk_rcvbuf to avoid malicious attacks.
  *
  * Return true if queue has shrunk.
  */
@@ -4972,20 +4973,26 @@ static bool tcp_prune_ofo_queue(struct s
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct rb_node *node, *prev;
+	int goal;
 
 	if (RB_EMPTY_ROOT(&tp->out_of_order_queue))
 		return false;
 
 	NET_INC_STATS(sock_net(sk), LINUX_MIB_OFOPRUNED);
+	goal = sk->sk_rcvbuf >> 3;
 	node = &tp->ooo_last_skb->rbnode;
 	do {
 		prev = rb_prev(node);
 		rb_erase(node, &tp->out_of_order_queue);
+		goal -= rb_to_skb(node)->truesize;
 		tcp_drop(sk, rb_entry(node, struct sk_buff, rbnode));
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
 	tp->ooo_last_skb = rb_entry(prev, struct sk_buff, rbnode);


