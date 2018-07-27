Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F789C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3E120891
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3E120891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388794AbeG0LKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:10:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52672 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730395AbeG0LKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:10:04 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5454DC03;
        Fri, 27 Jul 2018 09:48:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 44/66] tcp: detect malicious patterns in tcp_collapse_ofo_queue()
Date:   Fri, 27 Jul 2018 11:45:37 +0200
Message-Id: <20180727093814.040292244@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727093809.043856530@linuxfoundation.org>
References: <20180727093809.043856530@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4834,6 +4834,7 @@ end:
 static void tcp_collapse_ofo_queue(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
+	u32 range_truesize, sum_tiny = 0;
 	struct sk_buff *skb, *head;
 	u32 start, end;
 
@@ -4845,6 +4846,7 @@ new_range:
 	}
 	start = TCP_SKB_CB(skb)->seq;
 	end = TCP_SKB_CB(skb)->end_seq;
+	range_truesize = skb->truesize;
 
 	for (head = skb;;) {
 		skb = skb_rb_next(skb);
@@ -4855,11 +4857,20 @@ new_range:
 		if (!skb ||
 		    after(TCP_SKB_CB(skb)->seq, end) ||
 		    before(TCP_SKB_CB(skb)->end_seq, start)) {
-			tcp_collapse(sk, NULL, &tp->out_of_order_queue,
-				     head, skb, start, end);
+			/* Do not attempt collapsing tiny skbs */
+			if (range_truesize != head->truesize ||
+			    end - start >= SKB_WITH_OVERHEAD(SK_MEM_QUANTUM)) {
+				tcp_collapse(sk, NULL, &tp->out_of_order_queue,
+					     head, skb, start, end);
+			} else {
+				sum_tiny += range_truesize;
+				if (sum_tiny > sk->sk_rcvbuf >> 3)
+					return;
+			}
 			goto new_range;
 		}
 
+		range_truesize += skb->truesize;
 		if (unlikely(before(TCP_SKB_CB(skb)->seq, start)))
 			start = TCP_SKB_CB(skb)->seq;
 		if (after(TCP_SKB_CB(skb)->end_seq, end))


