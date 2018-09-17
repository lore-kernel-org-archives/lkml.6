Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8E9ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D52A214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D52A214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbeIREer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:34:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49294 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbeIREeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:34:46 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C1569C77;
        Mon, 17 Sep 2018 23:05:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 105/126] inet: frags: do not clone skb in ip_expire()
Date:   Tue, 18 Sep 2018 00:42:33 +0200
Message-Id: <20180917211710.857213194@linuxfoundation.org>
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

An skb_clone() was added in commit ec4fbd64751d ("inet: frag: release
spinlock before calling icmp_send()")

While fixing the bug at that time, it also added a very high cost
for DDOS frags, as the ICMP rate limit is applied after this
expensive operation (skb_clone() + consume_skb(), implying memory
allocations, copy, and freeing)

We can use skb_get(head) here, all we want is to make sure skb wont
be freed by another cpu.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 1eec5d5670084ee644597bd26c25e22c69b9f748)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_fragment.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -143,8 +143,8 @@ static bool frag_expire_skip_icmp(u32 us
 static void ip_expire(struct timer_list *t)
 {
 	struct inet_frag_queue *frag = from_timer(frag, t, timer);
-	struct sk_buff *clone, *head;
 	const struct iphdr *iph;
+	struct sk_buff *head;
 	struct net *net;
 	struct ipq *qp;
 	int err;
@@ -187,16 +187,12 @@ static void ip_expire(struct timer_list
 	    (skb_rtable(head)->rt_type != RTN_LOCAL))
 		goto out;
 
-	clone = skb_clone(head, GFP_ATOMIC);
+	skb_get(head);
+	spin_unlock(&qp->q.lock);
+	icmp_send(head, ICMP_TIME_EXCEEDED, ICMP_EXC_FRAGTIME, 0);
+	kfree_skb(head);
+	goto out_rcu_unlock;
 
-	/* Send an ICMP "Fragment Reassembly Timeout" message. */
-	if (clone) {
-		spin_unlock(&qp->q.lock);
-		icmp_send(clone, ICMP_TIME_EXCEEDED,
-			  ICMP_EXC_FRAGTIME, 0);
-		consume_skb(clone);
-		goto out_rcu_unlock;
-	}
 out:
 	spin_unlock(&qp->q.lock);
 out_rcu_unlock:


