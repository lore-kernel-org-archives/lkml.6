Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BF0C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193CB2075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276922;
	bh=SbD1Vd2x9aPmmYEoWXpjhJIx1pmoocUS0gfDC98yLEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vLsh2jq5tdue/kC8WFghgbJP7PcfU/Gn+UauBPUw8Re8vB1toiGkbZ0J7M829+XmA
	 aNA9OR09qTB94V5IMKyw1qVRexaf10GIQ5RwiLJ9LwoCB+AUrjeZ/is0ouRd3kSX7K
	 rFb8A2FPfO/yvIMevH1sBgNB1VKO0uTMko3/gE9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbfBDKmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:42:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:39884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730420AbfBDKl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:41:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39DAF217D6;
        Mon,  4 Feb 2019 10:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276916;
        bh=SbD1Vd2x9aPmmYEoWXpjhJIx1pmoocUS0gfDC98yLEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Et3IO5J1lI32OeAxjFYQGXmGBhwvYMmKG9shQyfvigeM2hCBReiqjg8dOLsY+MbSL
         85qHk58lQvqz4KMRvG/QIgfSlWHpqtfUPXDdOa69PHJ+/1ueo69R83iHowNl2yua9e
         Njm+QUnr6wzAHvkDjiTWI0sVzTJs7iBb37wbVt/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mao Wenan <maowenan@huawei.com>
Subject: [PATCH 4.4 58/65] inet: frags: get rif of inet_frag_evicting()
Date:   Mon,  4 Feb 2019 11:36:51 +0100
Message-Id: <20190204103620.032469364@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103610.583715954@linuxfoundation.org>
References: <20190204103610.583715954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 399d1404be660d355192ff4df5ccc3f4159ec1e4 upstream.

This refactors ip_expire() since one indentation level is removed.

Note: in the future, we should try hard to avoid the skb_clone()
since this is a serious performance cost.
Under DDOS, the ICMP message wont be sent because of rate limits.

Fact that ip6_expire_frag_queue() does not use skb_clone() is
disturbing too. Presumably IPv6 should have the same
issue than the one we fixed in commit ec4fbd64751d
("inet: frag: release spinlock before calling icmp_send()")

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Mao Wenan <maowenan@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/net/inet_frag.h |    5 ---
 net/ipv4/ip_fragment.c  |   66 +++++++++++++++++++++++-------------------------
 net/ipv6/reassembly.c   |    4 --
 3 files changed, 32 insertions(+), 43 deletions(-)

--- a/include/net/inet_frag.h
+++ b/include/net/inet_frag.h
@@ -123,11 +123,6 @@ static inline void inet_frag_put(struct
 		inet_frag_destroy(q, f);
 }
 
-static inline bool inet_frag_evicting(struct inet_frag_queue *q)
-{
-	return !hlist_unhashed(&q->list_evictor);
-}
-
 /* Memory Tracking Functions. */
 
 static inline int frag_mem_limit(struct netns_frags *nf)
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -194,8 +194,11 @@ static bool frag_expire_skip_icmp(u32 us
  */
 static void ip_expire(unsigned long arg)
 {
-	struct ipq *qp;
+	struct sk_buff *clone, *head;
+	const struct iphdr *iph;
 	struct net *net;
+	struct ipq *qp;
+	int err;
 
 	qp = container_of((struct inet_frag_queue *) arg, struct ipq, q);
 	net = container_of(qp->q.net, struct net, ipv4.frags);
@@ -209,45 +212,40 @@ static void ip_expire(unsigned long arg)
 	ipq_kill(qp);
 	IP_INC_STATS_BH(net, IPSTATS_MIB_REASMFAILS);
 
-	if (!inet_frag_evicting(&qp->q)) {
-		struct sk_buff *clone, *head = qp->q.fragments;
-		const struct iphdr *iph;
-		int err;
-
-		IP_INC_STATS_BH(net, IPSTATS_MIB_REASMTIMEOUT);
+	head = qp->q.fragments;
 
-		if (!(qp->q.flags & INET_FRAG_FIRST_IN) || !qp->q.fragments)
-			goto out;
+	IP_INC_STATS_BH(net, IPSTATS_MIB_REASMTIMEOUT);
 
-		head->dev = dev_get_by_index_rcu(net, qp->iif);
-		if (!head->dev)
-			goto out;
+	if (!(qp->q.flags & INET_FRAG_FIRST_IN) || !head)
+		goto out;
 
+	head->dev = dev_get_by_index_rcu(net, qp->iif);
+	if (!head->dev)
+		goto out;
 
-		/* skb has no dst, perform route lookup again */
-		iph = ip_hdr(head);
-		err = ip_route_input_noref(head, iph->daddr, iph->saddr,
+	/* skb has no dst, perform route lookup again */
+	iph = ip_hdr(head);
+	err = ip_route_input_noref(head, iph->daddr, iph->saddr,
 					   iph->tos, head->dev);
-		if (err)
-			goto out;
+	if (err)
+		goto out;
+
+	/* Only an end host needs to send an ICMP
+	 * "Fragment Reassembly Timeout" message, per RFC792.
+	 */
+	if (frag_expire_skip_icmp(qp->user) &&
+	    (skb_rtable(head)->rt_type != RTN_LOCAL))
+		goto out;
+
+	clone = skb_clone(head, GFP_ATOMIC);
 
-		/* Only an end host needs to send an ICMP
-		 * "Fragment Reassembly Timeout" message, per RFC792.
-		 */
-		if (frag_expire_skip_icmp(qp->user) &&
-		    (skb_rtable(head)->rt_type != RTN_LOCAL))
-			goto out;
-
-		clone = skb_clone(head, GFP_ATOMIC);
-
-		/* Send an ICMP "Fragment Reassembly Timeout" message. */
-		if (clone) {
-			spin_unlock(&qp->q.lock);
-			icmp_send(clone, ICMP_TIME_EXCEEDED,
-				  ICMP_EXC_FRAGTIME, 0);
-			consume_skb(clone);
-			goto out_rcu_unlock;
-		}
+	/* Send an ICMP "Fragment Reassembly Timeout" message. */
+	if (clone) {
+		spin_unlock(&qp->q.lock);
+		icmp_send(clone, ICMP_TIME_EXCEEDED,
+			  ICMP_EXC_FRAGTIME, 0);
+		consume_skb(clone);
+		goto out_rcu_unlock;
 	}
 out:
 	spin_unlock(&qp->q.lock);
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -146,10 +146,6 @@ void ip6_expire_frag_queue(struct net *n
 		goto out_rcu_unlock;
 
 	IP6_INC_STATS_BH(net, __in6_dev_get(dev), IPSTATS_MIB_REASMFAILS);
-
-	if (inet_frag_evicting(&fq->q))
-		goto out_rcu_unlock;
-
 	IP6_INC_STATS_BH(net, __in6_dev_get(dev), IPSTATS_MIB_REASMTIMEOUT);
 
 	/* Don't send error if the first segment did not arrive. */


