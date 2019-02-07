Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B438C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACC92190C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549539806;
	bh=kumJb13zqZB4efZMCLaf8NKGpFOWCQhlWfjfV6UMt5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yzhUEphwBga28qBchmiql7hiULmnT1YyX/WM4LGsOebhZZCyIEa/HJYN2no5u1AtW
	 EwX8PRBW31McEzSVqNeVsrWsqOD6/WmO3/DcvuXE6Srw0gdBenv5P8YnF/YzGR6nn9
	 vnkto+DxhkhGOmjXcMzfYsAtVCHkc1qAnbzCXsSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfBGLnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:43:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:33600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727423AbfBGLnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:43:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C33E32190A;
        Thu,  7 Feb 2019 11:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549539802;
        bh=kumJb13zqZB4efZMCLaf8NKGpFOWCQhlWfjfV6UMt5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b+hbFPfeqxNOkYgZGk+rxOmgjXWMktZZ4L0BWH8lkZ1/SVnj7p6TtbJzQVVwh4bfE
         0gFre+wi41HIFrTe0RQpdJE/oHRekCPejxm7qeRnNSkbbXLyLW0BQaJ25eCm6cET6y
         qW9UawfJLIEBy/t2gzCh080ckWRoDCghuFvg0QwQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mao Wenan <maowenan@huawei.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 13/34] inet: frags: get rif of inet_frag_evicting()
Date:   Thu,  7 Feb 2019 12:41:55 +0100
Message-Id: <20190207113026.099380300@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207113025.552605181@linuxfoundation.org>
References: <20190207113025.552605181@linuxfoundation.org>
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
[bwh: Backported to 4.4: adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
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
@@ -143,8 +143,11 @@ static bool frag_expire_skip_icmp(u32 us
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
@@ -158,45 +161,41 @@ static void ip_expire(unsigned long arg)
 	ipq_kill(qp);
 	IP_INC_STATS_BH(net, IPSTATS_MIB_REASMFAILS);
 
-	if (!inet_frag_evicting(&qp->q)) {
-		struct sk_buff *clone, *head = qp->q.fragments;
-		const struct iphdr *iph;
-		int err;
+	head = qp->q.fragments;
 
-		IP_INC_STATS_BH(net, IPSTATS_MIB_REASMTIMEOUT);
+	IP_INC_STATS_BH(net, IPSTATS_MIB_REASMTIMEOUT);
 
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
 
 	IP6_INC_STATS_BH(net, __in6_dev_get(dev), IPSTATS_MIB_REASMFAILS);
-
-	if (inet_frag_evicting(&fq->q))
-		goto out_rcu_unlock;
-
 	IP6_INC_STATS_BH(net, __in6_dev_get(dev), IPSTATS_MIB_REASMTIMEOUT);
 
 	/* Don't send error if the first segment did not arrive. */


