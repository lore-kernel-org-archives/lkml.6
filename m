Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864FDECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C8F20867
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C8F20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbeIREfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:35:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49336 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730673AbeIREfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:35:03 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 47CB6C49;
        Mon, 17 Sep 2018 23:05:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 109/126] inet: frags: get rid of ipfrag_skb_cb/FRAG_CB
Date:   Tue, 18 Sep 2018 00:42:37 +0200
Message-Id: <20180917211711.127328288@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
References: <20180917211703.481236999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

ip_defrag uses skb->cb[] to store the fragment offset, and unfortunately
this integer is currently in a different cache line than skb->next,
meaning that we use two cache lines per skb when finding the insertion point.

By aliasing skb->ip_defrag_offset and skb->dev, we pack all the fields
in a single cache line and save precious memory bandwidth.

Note that after the fast path added by Changli Gao in commit
d6bebca92c66 ("fragment: add fast path for in-order fragments")
this change wont help the fast path, since we still need
to access prev->len (2nd cache line), but will show great
benefits when slow path is entered, since we perform
a linear scan of a potentially long list.

Also, note that this potential long list is an attack vector,
we might consider also using an rb-tree there eventually.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit bf66337140c64c27fa37222b7abca7e49d63fb57)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/skbuff.h |    1 +
 net/ipv4/ip_fragment.c |   35 ++++++++++++++---------------------
 2 files changed, 15 insertions(+), 21 deletions(-)

--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -678,6 +678,7 @@ struct sk_buff {
 		 * UDP receive path is one user.
 		 */
 		unsigned long		dev_scratch;
+		int			ip_defrag_offset;
 	};
 	/*
 	 * This is the control buffer. It is free to use for every
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -57,14 +57,6 @@
  */
 static const char ip_frag_cache_name[] = "ip4-frags";
 
-struct ipfrag_skb_cb
-{
-	struct inet_skb_parm	h;
-	int			offset;
-};
-
-#define FRAG_CB(skb)	((struct ipfrag_skb_cb *)((skb)->cb))
-
 /* Describe an entry in the "incomplete datagrams" queue. */
 struct ipq {
 	struct inet_frag_queue q;
@@ -353,13 +345,13 @@ static int ip_frag_queue(struct ipq *qp,
 	 * this fragment, right?
 	 */
 	prev = qp->q.fragments_tail;
-	if (!prev || FRAG_CB(prev)->offset < offset) {
+	if (!prev || prev->ip_defrag_offset < offset) {
 		next = NULL;
 		goto found;
 	}
 	prev = NULL;
 	for (next = qp->q.fragments; next != NULL; next = next->next) {
-		if (FRAG_CB(next)->offset >= offset)
+		if (next->ip_defrag_offset >= offset)
 			break;	/* bingo! */
 		prev = next;
 	}
@@ -370,7 +362,7 @@ found:
 	 * any overlaps are eliminated.
 	 */
 	if (prev) {
-		int i = (FRAG_CB(prev)->offset + prev->len) - offset;
+		int i = (prev->ip_defrag_offset + prev->len) - offset;
 
 		if (i > 0) {
 			offset += i;
@@ -387,8 +379,8 @@ found:
 
 	err = -ENOMEM;
 
-	while (next && FRAG_CB(next)->offset < end) {
-		int i = end - FRAG_CB(next)->offset; /* overlap is 'i' bytes */
+	while (next && next->ip_defrag_offset < end) {
+		int i = end - next->ip_defrag_offset; /* overlap is 'i' bytes */
 
 		if (i < next->len) {
 			int delta = -next->truesize;
@@ -401,7 +393,7 @@ found:
 			delta += next->truesize;
 			if (delta)
 				add_frag_mem_limit(qp->q.net, delta);
-			FRAG_CB(next)->offset += i;
+			next->ip_defrag_offset += i;
 			qp->q.meat -= i;
 			if (next->ip_summed != CHECKSUM_UNNECESSARY)
 				next->ip_summed = CHECKSUM_NONE;
@@ -425,7 +417,13 @@ found:
 		}
 	}
 
-	FRAG_CB(skb)->offset = offset;
+	/* Note : skb->ip_defrag_offset and skb->dev share the same location */
+	dev = skb->dev;
+	if (dev)
+		qp->iif = dev->ifindex;
+	/* Makes sure compiler wont do silly aliasing games */
+	barrier();
+	skb->ip_defrag_offset = offset;
 
 	/* Insert this fragment in the chain of fragments. */
 	skb->next = next;
@@ -436,11 +434,6 @@ found:
 	else
 		qp->q.fragments = skb;
 
-	dev = skb->dev;
-	if (dev) {
-		qp->iif = dev->ifindex;
-		skb->dev = NULL;
-	}
 	qp->q.stamp = skb->tstamp;
 	qp->q.meat += skb->len;
 	qp->ecn |= ecn;
@@ -516,7 +509,7 @@ static int ip_frag_reasm(struct ipq *qp,
 	}
 
 	WARN_ON(!head);
-	WARN_ON(FRAG_CB(head)->offset != 0);
+	WARN_ON(head->ip_defrag_offset != 0);
 
 	/* Allocate a new buffer for the datagram. */
 	ihlen = ip_hdrlen(head);


