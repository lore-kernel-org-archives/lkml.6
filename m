Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0518AC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DD7217C5
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5DD7217C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389602AbeHDLNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:13:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50546 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388913AbeHDLNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:13:04 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4A84289C;
        Sat,  4 Aug 2018 09:13:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yousuk Seung <ysseung@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 112/124] tcp: refactor tcp_ecn_check_ce to remove sk type cast
Date:   Sat,  4 Aug 2018 11:01:41 +0200
Message-Id: <20180804082706.657368504@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082702.434482435@linuxfoundation.org>
References: <20180804082702.434482435@linuxfoundation.org>
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

From: Yousuk Seung <ysseung@google.com>

[ Upstream commit f4c9f85f3b2cb7669830cd04d0be61192a4d2436 ]

Refactor tcp_ecn_check_ce and __tcp_ecn_check_ce to accept struct sock*
instead of tcp_sock* to clean up type casts. This is a pure refactor
patch.

Signed-off-by: Yousuk Seung <ysseung@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_input.c |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -228,8 +228,10 @@ static void tcp_ecn_withdraw_cwr(struct
 	tp->ecn_flags &= ~TCP_ECN_DEMAND_CWR;
 }
 
-static void __tcp_ecn_check_ce(struct tcp_sock *tp, const struct sk_buff *skb)
+static void __tcp_ecn_check_ce(struct sock *sk, const struct sk_buff *skb)
 {
+	struct tcp_sock *tp = tcp_sk(sk);
+
 	switch (TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK) {
 	case INET_ECN_NOT_ECT:
 		/* Funny extension: if ECT is not set on a segment,
@@ -237,31 +239,31 @@ static void __tcp_ecn_check_ce(struct tc
 		 * it is probably a retransmit.
 		 */
 		if (tp->ecn_flags & TCP_ECN_SEEN)
-			tcp_enter_quickack_mode((struct sock *)tp, 1);
+			tcp_enter_quickack_mode(sk, 1);
 		break;
 	case INET_ECN_CE:
-		if (tcp_ca_needs_ecn((struct sock *)tp))
-			tcp_ca_event((struct sock *)tp, CA_EVENT_ECN_IS_CE);
+		if (tcp_ca_needs_ecn(sk))
+			tcp_ca_event(sk, CA_EVENT_ECN_IS_CE);
 
 		if (!(tp->ecn_flags & TCP_ECN_DEMAND_CWR)) {
 			/* Better not delay acks, sender can have a very low cwnd */
-			tcp_enter_quickack_mode((struct sock *)tp, 1);
+			tcp_enter_quickack_mode(sk, 1);
 			tp->ecn_flags |= TCP_ECN_DEMAND_CWR;
 		}
 		tp->ecn_flags |= TCP_ECN_SEEN;
 		break;
 	default:
-		if (tcp_ca_needs_ecn((struct sock *)tp))
-			tcp_ca_event((struct sock *)tp, CA_EVENT_ECN_NO_CE);
+		if (tcp_ca_needs_ecn(sk))
+			tcp_ca_event(sk, CA_EVENT_ECN_NO_CE);
 		tp->ecn_flags |= TCP_ECN_SEEN;
 		break;
 	}
 }
 
-static void tcp_ecn_check_ce(struct tcp_sock *tp, const struct sk_buff *skb)
+static void tcp_ecn_check_ce(struct sock *sk, const struct sk_buff *skb)
 {
-	if (tp->ecn_flags & TCP_ECN_OK)
-		__tcp_ecn_check_ce(tp, skb);
+	if (tcp_sk(sk)->ecn_flags & TCP_ECN_OK)
+		__tcp_ecn_check_ce(sk, skb);
 }
 
 static void tcp_ecn_rcv_synack(struct tcp_sock *tp, const struct tcphdr *th)
@@ -675,7 +677,7 @@ static void tcp_event_data_recv(struct s
 	}
 	icsk->icsk_ack.lrcvtime = now;
 
-	tcp_ecn_check_ce(tp, skb);
+	tcp_ecn_check_ce(sk, skb);
 
 	if (skb->len >= 128)
 		tcp_grow_window(sk, skb);
@@ -4366,7 +4368,7 @@ static void tcp_data_queue_ofo(struct so
 	struct sk_buff *skb1;
 	u32 seq, end_seq;
 
-	tcp_ecn_check_ce(tp, skb);
+	tcp_ecn_check_ce(sk, skb);
 
 	if (unlikely(tcp_try_rmem_schedule(sk, skb, skb->truesize))) {
 		NET_INC_STATS_BH(sock_net(sk), LINUX_MIB_TCPOFODROP);


