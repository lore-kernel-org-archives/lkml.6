Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E89C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9072098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWyj8Nwz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB9072098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732041AbeJQBRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:17:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730396AbeJQBRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:17:00 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A8DF2145D;
        Tue, 16 Oct 2018 17:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710733;
        bh=JCcPMTJPInPRntepfdhUE5go5oQCoyNodp4PLWzH4sI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sWyj8NwzoEkeHRzOt1ARX6m43UHPMXLHR0q3/lAsvT5BKVuSkJwFv44LLJ65WGyfy
         w6KLorEEfBshphJY5rZIRPVuq8cBcKIf6wCuSX7peyosN0J2rxDCQMLp35lGWdF0TW
         qRERzvr/LNfhYWkFAWmcrvabFbtODBzSPillPdQY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
        Peter Oskolkov <posk@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 69/71] ip: process in-order fragments efficiently
Date:   Tue, 16 Oct 2018 19:10:06 +0200
Message-Id: <20181016170542.857918296@linuxfoundation.org>
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

From: Peter Oskolkov <posk@google.com>

This patch changes the runtime behavior of IP defrag queue:
incoming in-order fragments are added to the end of the current
list/"run" of in-order fragments at the tail.

On some workloads, UDP stream performance is substantially improved:

RX: ./udp_stream -F 10 -T 2 -l 60
TX: ./udp_stream -c -H <host> -F 10 -T 5 -l 60

with this patchset applied on a 10Gbps receiver:

  throughput=9524.18
  throughput_units=Mbit/s

upstream (net-next):

  throughput=4608.93
  throughput_units=Mbit/s

Reported-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Peter Oskolkov <posk@google.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Florian Westphal <fw@strlen.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit a4fd284a1f8fd4b6c59aa59db2185b1e17c5c11c)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/inet_fragment.c |    2 
 net/ipv4/ip_fragment.c   |  110 +++++++++++++++++++++++++++++------------------
 2 files changed, 70 insertions(+), 42 deletions(-)

--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -145,7 +145,7 @@ void inet_frag_destroy(struct inet_frag_
 			fp = xp;
 		} while (fp);
 	} else {
-		sum_truesize = skb_rbtree_purge(&q->rb_fragments);
+		sum_truesize = inet_frag_rbtree_purge(&q->rb_fragments);
 	}
 	sum = sum_truesize + f->qsize;
 
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -125,8 +125,8 @@ static u8 ip4_frag_ecn(u8 tos)
 
 static struct inet_frags ip4_frags;
 
-static int ip_frag_reasm(struct ipq *qp, struct sk_buff *prev,
-			 struct net_device *dev);
+static int ip_frag_reasm(struct ipq *qp, struct sk_buff *skb,
+			 struct sk_buff *prev_tail, struct net_device *dev);
 
 
 static void ip4_frag_init(struct inet_frag_queue *q, const void *a)
@@ -217,7 +217,12 @@ static void ip_expire(unsigned long arg)
 		head = skb_rb_first(&qp->q.rb_fragments);
 		if (!head)
 			goto out;
-		rb_erase(&head->rbnode, &qp->q.rb_fragments);
+		if (FRAG_CB(head)->next_frag)
+			rb_replace_node(&head->rbnode,
+					&FRAG_CB(head)->next_frag->rbnode,
+					&qp->q.rb_fragments);
+		else
+			rb_erase(&head->rbnode, &qp->q.rb_fragments);
 		memset(&head->rbnode, 0, sizeof(head->rbnode));
 		barrier();
 	}
@@ -318,7 +323,7 @@ static int ip_frag_reinit(struct ipq *qp
 		return -ETIMEDOUT;
 	}
 
-	sum_truesize = skb_rbtree_purge(&qp->q.rb_fragments);
+	sum_truesize = inet_frag_rbtree_purge(&qp->q.rb_fragments);
 	sub_frag_mem_limit(qp->q.net, sum_truesize);
 
 	qp->q.flags = 0;
@@ -327,6 +332,7 @@ static int ip_frag_reinit(struct ipq *qp
 	qp->q.fragments = NULL;
 	qp->q.rb_fragments = RB_ROOT;
 	qp->q.fragments_tail = NULL;
+	qp->q.last_run_head = NULL;
 	qp->iif = 0;
 	qp->ecn = 0;
 
@@ -338,7 +344,7 @@ static int ip_frag_queue(struct ipq *qp,
 {
 	struct net *net = container_of(qp->q.net, struct net, ipv4.frags);
 	struct rb_node **rbn, *parent;
-	struct sk_buff *skb1;
+	struct sk_buff *skb1, *prev_tail;
 	struct net_device *dev;
 	unsigned int fragsize;
 	int flags, offset;
@@ -416,38 +422,41 @@ static int ip_frag_queue(struct ipq *qp,
 	 */
 
 	/* Find out where to put this fragment.  */
-	skb1 = qp->q.fragments_tail;
-	if (!skb1) {
-		/* This is the first fragment we've received. */
-		rb_link_node(&skb->rbnode, NULL, &qp->q.rb_fragments.rb_node);
-		qp->q.fragments_tail = skb;
-	} else if ((skb1->ip_defrag_offset + skb1->len) < end) {
-		/* This is the common/special case: skb goes to the end. */
+	prev_tail = qp->q.fragments_tail;
+	if (!prev_tail)
+		ip4_frag_create_run(&qp->q, skb);  /* First fragment. */
+	else if (prev_tail->ip_defrag_offset + prev_tail->len < end) {
+		/* This is the common case: skb goes to the end. */
 		/* Detect and discard overlaps. */
-		if (offset < (skb1->ip_defrag_offset + skb1->len))
+		if (offset < prev_tail->ip_defrag_offset + prev_tail->len)
 			goto discard_qp;
-		/* Insert after skb1. */
-		rb_link_node(&skb->rbnode, &skb1->rbnode, &skb1->rbnode.rb_right);
-		qp->q.fragments_tail = skb;
+		if (offset == prev_tail->ip_defrag_offset + prev_tail->len)
+			ip4_frag_append_to_last_run(&qp->q, skb);
+		else
+			ip4_frag_create_run(&qp->q, skb);
 	} else {
-		/* Binary search. Note that skb can become the first fragment, but
-		 * not the last (covered above). */
+		/* Binary search. Note that skb can become the first fragment,
+		 * but not the last (covered above).
+		 */
 		rbn = &qp->q.rb_fragments.rb_node;
 		do {
 			parent = *rbn;
 			skb1 = rb_to_skb(parent);
 			if (end <= skb1->ip_defrag_offset)
 				rbn = &parent->rb_left;
-			else if (offset >= skb1->ip_defrag_offset + skb1->len)
+			else if (offset >= skb1->ip_defrag_offset +
+						FRAG_CB(skb1)->frag_run_len)
 				rbn = &parent->rb_right;
 			else /* Found an overlap with skb1. */
 				goto discard_qp;
 		} while (*rbn);
 		/* Here we have parent properly set, and rbn pointing to
-		 * one of its NULL left/right children. Insert skb. */
+		 * one of its NULL left/right children. Insert skb.
+		 */
+		ip4_frag_init_run(skb);
 		rb_link_node(&skb->rbnode, parent, rbn);
+		rb_insert_color(&skb->rbnode, &qp->q.rb_fragments);
 	}
-	rb_insert_color(&skb->rbnode, &qp->q.rb_fragments);
 
 	if (dev)
 		qp->iif = dev->ifindex;
@@ -474,7 +483,7 @@ static int ip_frag_queue(struct ipq *qp,
 		unsigned long orefdst = skb->_skb_refdst;
 
 		skb->_skb_refdst = 0UL;
-		err = ip_frag_reasm(qp, skb, dev);
+		err = ip_frag_reasm(qp, skb, prev_tail, dev);
 		skb->_skb_refdst = orefdst;
 		return err;
 	}
@@ -493,7 +502,7 @@ err:
 
 /* Build a new IP datagram from all its fragments. */
 static int ip_frag_reasm(struct ipq *qp, struct sk_buff *skb,
-			 struct net_device *dev)
+			 struct sk_buff *prev_tail, struct net_device *dev)
 {
 	struct net *net = container_of(qp->q.net, struct net, ipv4.frags);
 	struct iphdr *iph;
@@ -517,10 +526,16 @@ static int ip_frag_reasm(struct ipq *qp,
 		fp = skb_clone(skb, GFP_ATOMIC);
 		if (!fp)
 			goto out_nomem;
-		rb_replace_node(&skb->rbnode, &fp->rbnode, &qp->q.rb_fragments);
+		FRAG_CB(fp)->next_frag = FRAG_CB(skb)->next_frag;
+		if (RB_EMPTY_NODE(&skb->rbnode))
+			FRAG_CB(prev_tail)->next_frag = fp;
+		else
+			rb_replace_node(&skb->rbnode, &fp->rbnode,
+					&qp->q.rb_fragments);
 		if (qp->q.fragments_tail == skb)
 			qp->q.fragments_tail = fp;
 		skb_morph(skb, head);
+		FRAG_CB(skb)->next_frag = FRAG_CB(head)->next_frag;
 		rb_replace_node(&head->rbnode, &skb->rbnode,
 				&qp->q.rb_fragments);
 		consume_skb(head);
@@ -556,7 +571,7 @@ static int ip_frag_reasm(struct ipq *qp,
 		for (i = 0; i < skb_shinfo(head)->nr_frags; i++)
 			plen += skb_frag_size(&skb_shinfo(head)->frags[i]);
 		clone->len = clone->data_len = head->data_len - plen;
-		skb->truesize += clone->truesize;
+		head->truesize += clone->truesize;
 		clone->csum = 0;
 		clone->ip_summed = head->ip_summed;
 		add_frag_mem_limit(qp->q.net, clone->truesize);
@@ -569,24 +584,36 @@ static int ip_frag_reasm(struct ipq *qp,
 	skb_push(head, head->data - skb_network_header(head));
 
 	/* Traverse the tree in order, to build frag_list. */
+	fp = FRAG_CB(head)->next_frag;
 	rbn = rb_next(&head->rbnode);
 	rb_erase(&head->rbnode, &qp->q.rb_fragments);
-	while (rbn) {
-		struct rb_node *rbnext = rb_next(rbn);
-		fp = rb_to_skb(rbn);
-		rb_erase(rbn, &qp->q.rb_fragments);
-		rbn = rbnext;
-		*nextp = fp;
-		nextp = &fp->next;
-		fp->prev = NULL;
-		memset(&fp->rbnode, 0, sizeof(fp->rbnode));
-		head->data_len += fp->len;
-		head->len += fp->len;
-		if (head->ip_summed != fp->ip_summed)
-			head->ip_summed = CHECKSUM_NONE;
-		else if (head->ip_summed == CHECKSUM_COMPLETE)
-			head->csum = csum_add(head->csum, fp->csum);
-		head->truesize += fp->truesize;
+	while (rbn || fp) {
+		/* fp points to the next sk_buff in the current run;
+		 * rbn points to the next run.
+		 */
+		/* Go through the current run. */
+		while (fp) {
+			*nextp = fp;
+			nextp = &fp->next;
+			fp->prev = NULL;
+			memset(&fp->rbnode, 0, sizeof(fp->rbnode));
+			head->data_len += fp->len;
+			head->len += fp->len;
+			if (head->ip_summed != fp->ip_summed)
+				head->ip_summed = CHECKSUM_NONE;
+			else if (head->ip_summed == CHECKSUM_COMPLETE)
+				head->csum = csum_add(head->csum, fp->csum);
+			head->truesize += fp->truesize;
+			fp = FRAG_CB(fp)->next_frag;
+		}
+		/* Move to the next run. */
+		if (rbn) {
+			struct rb_node *rbnext = rb_next(rbn);
+
+			fp = rb_to_skb(rbn);
+			rb_erase(rbn, &qp->q.rb_fragments);
+			rbn = rbnext;
+		}
 	}
 	sub_frag_mem_limit(qp->q.net, head->truesize);
 
@@ -622,6 +649,7 @@ static int ip_frag_reasm(struct ipq *qp,
 	qp->q.fragments = NULL;
 	qp->q.rb_fragments = RB_ROOT;
 	qp->q.fragments_tail = NULL;
+	qp->q.last_run_head = NULL;
 	return 0;
 
 out_nomem:


