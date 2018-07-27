Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C7CC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239902089E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239902089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389338AbeG0Lcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:32:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36732 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730866AbeG0Lci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:32:38 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F3BEBCBA;
        Fri, 27 Jul 2018 10:11:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 10/23] tcp: detect malicious patterns in tcp_collapse_ofo_queue()
Date:   Fri, 27 Jul 2018 12:09:11 +0200
Message-Id: <20180727100845.566992497@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727100845.054377089@linuxfoundation.org>
References: <20180727100845.054377089@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 3d4bf93ac12003f9b8e1e2de37fe27983deebdcf ]

In case an attacker feeds tiny packets completely out of order,
tcp_collapse_ofo_queue() might scan the whole rb-tree, performing
expensive copies, but not changing socket memory usage at all.

1) Do not attempt to collapse tiny skbs.
2) Add logic to exit early when too many tiny skbs are detected.

We prefer not doing aggressive collapsing (which copies packets)
for pathological flows, and revert to tcp_prune_ofo_queue() which
will be less expensive.

In the future, we might add the possibility of terminating flows
that are proven to be malicious.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_input.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4789,6 +4789,7 @@ restart:
 static void tcp_collapse_ofo_queue(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
+	u32 range_truesize, sum_tiny = 0;
 	struct sk_buff *skb = skb_peek(&tp->out_of_order_queue);
 	struct sk_buff *head;
 	u32 start, end;
@@ -4798,6 +4799,7 @@ static void tcp_collapse_ofo_queue(struc
 
 	start = TCP_SKB_CB(skb)->seq;
 	end = TCP_SKB_CB(skb)->end_seq;
+	range_truesize = skb->truesize;
 	head = skb;
 
 	for (;;) {
@@ -4812,8 +4814,17 @@ static void tcp_collapse_ofo_queue(struc
 		if (!skb ||
 		    after(TCP_SKB_CB(skb)->seq, end) ||
 		    before(TCP_SKB_CB(skb)->end_seq, start)) {
-			tcp_collapse(sk, &tp->out_of_order_queue,
-				     head, skb, start, end);
+			/* Do not attempt collapsing tiny skbs */
+			if (range_truesize != head->truesize ||
+			    end - start >= SKB_WITH_OVERHEAD(SK_MEM_QUANTUM)) {
+				tcp_collapse(sk, &tp->out_of_order_queue,
+					     head, skb, start, end);
+			} else {
+				sum_tiny += range_truesize;
+				if (sum_tiny > sk->sk_rcvbuf >> 3)
+					return;
+			}
+
 			head = skb;
 			if (!skb)
 				break;


