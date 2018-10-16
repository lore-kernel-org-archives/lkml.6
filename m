Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3956BC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53C22098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wp72JkEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53C22098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732147AbeJQBRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:17:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731313AbeJQBRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:17:17 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E333E2098A;
        Tue, 16 Oct 2018 17:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710751;
        bh=9cIGkkUlzrEU7y5UkRrz0D6OkEhjjG/ETtSY3VdAR30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wp72JkECIsfg9ExvJJNsWtM5Bez8cMPUWr2oQnafoadGLfgdqs7qEC6C3foISpCYp
         bUPoMxEUSXYUwf0PORmfpjAkoJeAX7e0LUI0ZPHL225ok09Dq4ORSPROBWudxBARcH
         P5ncs6V5Ck9wiD1ExT2+WZfSoMx4ut3kysJ4oidM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 52/71] inet: frags: get rif of inet_frag_evicting()
Date:   Tue, 16 Oct 2018 19:09:49 +0200
Message-Id: <20181016170541.975679282@linuxfoundation.org>
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
(cherry picked from commit 399d1404be660d355192ff4df5ccc3f4159ec1e4)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/inet_frag.h |    5 ---
 net/ipv4/ip_fragment.c  |   65 +++++++++++++++++++++++-------------------------
 net/ipv6/reassembly.c   |    4 --
 3 files changed, 32 insertions(+), 42 deletions(-)

--- a/include/net/inet_frag.h
+++ b/include/net/inet_frag.h
@@ -118,11 +118,6 @@ static inline void inet_frag_put(struct
 		inet_frag_destroy(q);
 }
 
-static inline bool inet_frag_evicting(struct inet_frag_queue *q)
-{
-	return false;
-}
-
 /* Memory Tracking Functions. */
 
 static inline int frag_mem_limit(struct netns_frags *nf)
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -141,8 +141,11 @@ static bool frag_expire_skip_icmp(u32 us
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
@@ -156,45 +159,41 @@ static void ip_expire(unsigned long arg)
 	ipq_kill(qp);
 	__IP_INC_STATS(net, IPSTATS_MIB_REASMFAILS);
 
-	if (!inet_frag_evicting(&qp->q)) {
-		struct sk_buff *clone, *head = qp->q.fragments;
-		const struct iphdr *iph;
-		int err;
+	head = qp->q.fragments;
 
-		__IP_INC_STATS(net, IPSTATS_MIB_REASMTIMEOUT);
+	__IP_INC_STATS(net, IPSTATS_MIB_REASMTIMEOUT);
 
-		if (!(qp->q.flags & INET_FRAG_FIRST_IN) || !qp->q.fragments)
-			goto out;
+	if (!(qp->q.flags & INET_FRAG_FIRST_IN) || !head)
+		goto out;
 
-		head->dev = dev_get_by_index_rcu(net, qp->iif);
-		if (!head->dev)
-			goto out;
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
+	if (frag_expire_skip_icmp(qp->q.key.v4.user) &&
+	    (skb_rtable(head)->rt_type != RTN_LOCAL))
+		goto out;
+
+	clone = skb_clone(head, GFP_ATOMIC);
 
-		/* Only an end host needs to send an ICMP
-		 * "Fragment Reassembly Timeout" message, per RFC792.
-		 */
-		if (frag_expire_skip_icmp(qp->q.key.v4.user) &&
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
@@ -106,10 +106,6 @@ void ip6_expire_frag_queue(struct net *n
 		goto out_rcu_unlock;
 
 	__IP6_INC_STATS(net, __in6_dev_get(dev), IPSTATS_MIB_REASMFAILS);
-
-	if (inet_frag_evicting(&fq->q))
-		goto out_rcu_unlock;
-
 	__IP6_INC_STATS(net, __in6_dev_get(dev), IPSTATS_MIB_REASMTIMEOUT);
 
 	/* Don't send error if the first segment did not arrive. */


