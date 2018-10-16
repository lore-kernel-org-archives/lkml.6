Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D613DC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A70F2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zk4fyaWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A70F2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbeJQBQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:16:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730396AbeJQBQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:16:52 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E93AD20866;
        Tue, 16 Oct 2018 17:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710725;
        bh=vOhJ1D6vjZoqL54dbtSQkqQUnNfcn4dmJPxGFGDbrEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zk4fyaWxVcq8UYzuvc7t/9cSaO5gaX6HoaxsXgErbQs9OJExb2ZFCSakQImLxEXmb
         aAljI6z16YUkaZarIaDu9aGRgIArSKPcAWDlnnJo+S/X7lXwDVmA4dkKaOMYZpw9oC
         SCkrR3Z3tFOtd0crTdq5KqR8iLQmqYVVT0y/DFpw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 66/71] net: add rb_to_skb() and other rb tree helpers
Date:   Tue, 16 Oct 2018 19:10:03 +0200
Message-Id: <20181016170542.696856866@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
References: <20181016170539.315587743@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

Geeralize private netem_rb_to_skb()

TCP rtx queue will soon be converted to rb-tree,
so we will need skb_rbtree_walk() helpers.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 18a4c0eab2623cc95be98a1e6af1ad18e7695977)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/skbuff.h |   18 ++++++++++++++++++
 net/ipv4/tcp_input.c   |   33 ++++++++++++---------------------
 2 files changed, 30 insertions(+), 21 deletions(-)

--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2988,6 +2988,12 @@ static inline int __skb_grow_rcsum(struc
 
 #define rb_to_skb(rb) rb_entry_safe(rb, struct sk_buff, rbnode)
 
+#define rb_to_skb(rb) rb_entry_safe(rb, struct sk_buff, rbnode)
+#define skb_rb_first(root) rb_to_skb(rb_first(root))
+#define skb_rb_last(root)  rb_to_skb(rb_last(root))
+#define skb_rb_next(skb)   rb_to_skb(rb_next(&(skb)->rbnode))
+#define skb_rb_prev(skb)   rb_to_skb(rb_prev(&(skb)->rbnode))
+
 #define skb_queue_walk(queue, skb) \
 		for (skb = (queue)->next;					\
 		     skb != (struct sk_buff *)(queue);				\
@@ -3002,6 +3008,18 @@ static inline int __skb_grow_rcsum(struc
 		for (; skb != (struct sk_buff *)(queue);			\
 		     skb = skb->next)
 
+#define skb_rbtree_walk(skb, root)						\
+		for (skb = skb_rb_first(root); skb != NULL;			\
+		     skb = skb_rb_next(skb))
+
+#define skb_rbtree_walk_from(skb)						\
+		for (; skb != NULL;						\
+		     skb = skb_rb_next(skb))
+
+#define skb_rbtree_walk_from_safe(skb, tmp)					\
+		for (; tmp = skb ? skb_rb_next(skb) : NULL, (skb != NULL);	\
+		     skb = tmp)
+
 #define skb_queue_walk_from_safe(queue, skb, tmp)				\
 		for (tmp = skb->next;						\
 		     skb != (struct sk_buff *)(queue);				\
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4406,7 +4406,7 @@ static void tcp_ofo_queue(struct sock *s
 
 	p = rb_first(&tp->out_of_order_queue);
 	while (p) {
-		skb = rb_entry(p, struct sk_buff, rbnode);
+		skb = rb_to_skb(p);
 		if (after(TCP_SKB_CB(skb)->seq, tp->rcv_nxt))
 			break;
 
@@ -4470,7 +4470,7 @@ static int tcp_try_rmem_schedule(struct
 static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
-	struct rb_node **p, *q, *parent;
+	struct rb_node **p, *parent;
 	struct sk_buff *skb1;
 	u32 seq, end_seq;
 	bool fragstolen;
@@ -4529,7 +4529,7 @@ coalesce_done:
 	parent = NULL;
 	while (*p) {
 		parent = *p;
-		skb1 = rb_entry(parent, struct sk_buff, rbnode);
+		skb1 = rb_to_skb(parent);
 		if (before(seq, TCP_SKB_CB(skb1)->seq)) {
 			p = &parent->rb_left;
 			continue;
@@ -4574,9 +4574,7 @@ insert:
 
 merge_right:
 	/* Remove other segments covered by skb. */
-	while ((q = rb_next(&skb->rbnode)) != NULL) {
-		skb1 = rb_entry(q, struct sk_buff, rbnode);
-
+	while ((skb1 = skb_rb_next(skb)) != NULL) {
 		if (!after(end_seq, TCP_SKB_CB(skb1)->seq))
 			break;
 		if (before(end_seq, TCP_SKB_CB(skb1)->end_seq)) {
@@ -4591,7 +4589,7 @@ merge_right:
 		tcp_drop(sk, skb1);
 	}
 	/* If there is no skb after us, we are the last_skb ! */
-	if (!q)
+	if (!skb1)
 		tp->ooo_last_skb = skb;
 
 add_sack:
@@ -4792,7 +4790,7 @@ static struct sk_buff *tcp_skb_next(stru
 	if (list)
 		return !skb_queue_is_last(list, skb) ? skb->next : NULL;
 
-	return rb_entry_safe(rb_next(&skb->rbnode), struct sk_buff, rbnode);
+	return skb_rb_next(skb);
 }
 
 static struct sk_buff *tcp_collapse_one(struct sock *sk, struct sk_buff *skb,
@@ -4821,7 +4819,7 @@ static void tcp_rbtree_insert(struct rb_
 
 	while (*p) {
 		parent = *p;
-		skb1 = rb_entry(parent, struct sk_buff, rbnode);
+		skb1 = rb_to_skb(parent);
 		if (before(TCP_SKB_CB(skb)->seq, TCP_SKB_CB(skb1)->seq))
 			p = &parent->rb_left;
 		else
@@ -4941,19 +4939,12 @@ static void tcp_collapse_ofo_queue(struc
 	struct tcp_sock *tp = tcp_sk(sk);
 	u32 range_truesize, sum_tiny = 0;
 	struct sk_buff *skb, *head;
-	struct rb_node *p;
 	u32 start, end;
 
-	p = rb_first(&tp->out_of_order_queue);
-	skb = rb_entry_safe(p, struct sk_buff, rbnode);
+	skb = skb_rb_first(&tp->out_of_order_queue);
 new_range:
 	if (!skb) {
-		p = rb_last(&tp->out_of_order_queue);
-		/* Note: This is possible p is NULL here. We do not
-		 * use rb_entry_safe(), as ooo_last_skb is valid only
-		 * if rbtree is not empty.
-		 */
-		tp->ooo_last_skb = rb_entry(p, struct sk_buff, rbnode);
+		tp->ooo_last_skb = skb_rb_last(&tp->out_of_order_queue);
 		return;
 	}
 	start = TCP_SKB_CB(skb)->seq;
@@ -4961,7 +4952,7 @@ new_range:
 	range_truesize = skb->truesize;
 
 	for (head = skb;;) {
-		skb = tcp_skb_next(skb, NULL);
+		skb = skb_rb_next(skb);
 
 		/* Range is terminated when we see a gap or when
 		 * we are at the queue end.
@@ -5017,7 +5008,7 @@ static bool tcp_prune_ofo_queue(struct s
 		prev = rb_prev(node);
 		rb_erase(node, &tp->out_of_order_queue);
 		goal -= rb_to_skb(node)->truesize;
-		tcp_drop(sk, rb_entry(node, struct sk_buff, rbnode));
+		tcp_drop(sk, rb_to_skb(node));
 		if (!prev || goal <= 0) {
 			sk_mem_reclaim(sk);
 			if (atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf &&
@@ -5027,7 +5018,7 @@ static bool tcp_prune_ofo_queue(struct s
 		}
 		node = prev;
 	} while (node);
-	tp->ooo_last_skb = rb_entry(prev, struct sk_buff, rbnode);
+	tp->ooo_last_skb = rb_to_skb(prev);
 
 	/* Reset SACK state.  A conforming SACK implementation will
 	 * do the same at a timeout based retransmit.  When a connection


