Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763BEC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F754208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F754208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391007AbeHGVPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:15:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35102 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389775AbeHGVPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:15:34 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6A0FF3EE;
        Tue,  7 Aug 2018 18:59:49 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 69/85] tcp: add max_quickacks param to tcp_incr_quickack and tcp_enter_quickack_mode
Date:   Tue,  7 Aug 2018 20:52:11 +0200
Message-Id: <20180807172359.919158701@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172357.357252052@linuxfoundation.org>
References: <20180807172357.357252052@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 9a9c9b51e54618861420093ae6e9b50a961914c5 ]

We want to add finer control of the number of ACK packets sent after
ECN events.

This patch is not changing current behavior, it only enables following
change.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/tcp.h    |    2 +-
 net/ipv4/tcp_dctcp.c |    4 ++--
 net/ipv4/tcp_input.c |   24 +++++++++++++-----------
 3 files changed, 16 insertions(+), 14 deletions(-)

--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -372,7 +372,7 @@ ssize_t tcp_splice_read(struct socket *s
 			struct pipe_inode_info *pipe, size_t len,
 			unsigned int flags);
 
-void tcp_enter_quickack_mode(struct sock *sk);
+void tcp_enter_quickack_mode(struct sock *sk, unsigned int max_quickacks);
 static inline void tcp_dec_quickack_mode(struct sock *sk,
 					 const unsigned int pkts)
 {
--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -135,7 +135,7 @@ static void dctcp_ce_state_0_to_1(struct
 		 */
 		if (inet_csk(sk)->icsk_ack.pending & ICSK_ACK_TIMER)
 			__tcp_send_ack(sk, ca->prior_rcv_nxt);
-		tcp_enter_quickack_mode(sk);
+		tcp_enter_quickack_mode(sk, 1);
 	}
 
 	ca->prior_rcv_nxt = tp->rcv_nxt;
@@ -156,7 +156,7 @@ static void dctcp_ce_state_1_to_0(struct
 		 */
 		if (inet_csk(sk)->icsk_ack.pending & ICSK_ACK_TIMER)
 			__tcp_send_ack(sk, ca->prior_rcv_nxt);
-		tcp_enter_quickack_mode(sk);
+		tcp_enter_quickack_mode(sk, 1);
 	}
 
 	ca->prior_rcv_nxt = tp->rcv_nxt;
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -171,21 +171,23 @@ static void tcp_measure_rcv_mss(struct s
 	}
 }
 
-static void tcp_incr_quickack(struct sock *sk)
+static void tcp_incr_quickack(struct sock *sk, unsigned int max_quickacks)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	unsigned int quickacks = tcp_sk(sk)->rcv_wnd / (2 * icsk->icsk_ack.rcv_mss);
 
 	if (quickacks == 0)
 		quickacks = 2;
+	quickacks = min(quickacks, max_quickacks);
 	if (quickacks > icsk->icsk_ack.quick)
-		icsk->icsk_ack.quick = min(quickacks, TCP_MAX_QUICKACKS);
+		icsk->icsk_ack.quick = quickacks;
 }
 
-void tcp_enter_quickack_mode(struct sock *sk)
+void tcp_enter_quickack_mode(struct sock *sk, unsigned int max_quickacks)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
-	tcp_incr_quickack(sk);
+
+	tcp_incr_quickack(sk, max_quickacks);
 	icsk->icsk_ack.pingpong = 0;
 	icsk->icsk_ack.ato = TCP_ATO_MIN;
 }
@@ -228,7 +230,7 @@ static void __tcp_ecn_check_ce(struct tc
 		 * it is probably a retransmit.
 		 */
 		if (tp->ecn_flags & TCP_ECN_SEEN)
-			tcp_enter_quickack_mode((struct sock *)tp);
+			tcp_enter_quickack_mode((struct sock *)tp, TCP_MAX_QUICKACKS);
 		break;
 	case INET_ECN_CE:
 		if (tcp_ca_needs_ecn((struct sock *)tp))
@@ -236,7 +238,7 @@ static void __tcp_ecn_check_ce(struct tc
 
 		if (!(tp->ecn_flags & TCP_ECN_DEMAND_CWR)) {
 			/* Better not delay acks, sender can have a very low cwnd */
-			tcp_enter_quickack_mode((struct sock *)tp);
+			tcp_enter_quickack_mode((struct sock *)tp, TCP_MAX_QUICKACKS);
 			tp->ecn_flags |= TCP_ECN_DEMAND_CWR;
 		}
 		tp->ecn_flags |= TCP_ECN_SEEN;
@@ -644,7 +646,7 @@ static void tcp_event_data_recv(struct s
 		/* The _first_ data packet received, initialize
 		 * delayed ACK engine.
 		 */
-		tcp_incr_quickack(sk);
+		tcp_incr_quickack(sk, TCP_MAX_QUICKACKS);
 		icsk->icsk_ack.ato = TCP_ATO_MIN;
 	} else {
 		int m = now - icsk->icsk_ack.lrcvtime;
@@ -660,7 +662,7 @@ static void tcp_event_data_recv(struct s
 			/* Too long gap. Apparently sender failed to
 			 * restart window, so that we send ACKs quickly.
 			 */
-			tcp_incr_quickack(sk);
+			tcp_incr_quickack(sk, TCP_MAX_QUICKACKS);
 			sk_mem_reclaim(sk);
 		}
 	}
@@ -4001,7 +4003,7 @@ static void tcp_send_dupack(struct sock
 	if (TCP_SKB_CB(skb)->end_seq != TCP_SKB_CB(skb)->seq &&
 	    before(TCP_SKB_CB(skb)->seq, tp->rcv_nxt)) {
 		NET_INC_STATS_BH(sock_net(sk), LINUX_MIB_DELAYEDACKLOST);
-		tcp_enter_quickack_mode(sk);
+		tcp_enter_quickack_mode(sk, TCP_MAX_QUICKACKS);
 
 		if (tcp_is_sack(tp) && sysctl_tcp_dsack) {
 			u32 end_seq = TCP_SKB_CB(skb)->end_seq;
@@ -4501,7 +4503,7 @@ queue_and_out:
 		tcp_dsack_set(sk, TCP_SKB_CB(skb)->seq, TCP_SKB_CB(skb)->end_seq);
 
 out_of_window:
-		tcp_enter_quickack_mode(sk);
+		tcp_enter_quickack_mode(sk, TCP_MAX_QUICKACKS);
 		inet_csk_schedule_ack(sk);
 drop:
 		__kfree_skb(skb);
@@ -5521,7 +5523,7 @@ static int tcp_rcv_synsent_state_process
 			 * to stand against the temptation 8)     --ANK
 			 */
 			inet_csk_schedule_ack(sk);
-			tcp_enter_quickack_mode(sk);
+			tcp_enter_quickack_mode(sk, TCP_MAX_QUICKACKS);
 			inet_csk_reset_xmit_timer(sk, ICSK_TIME_DACK,
 						  TCP_DELACK_MAX, TCP_RTO_MAX);
 


