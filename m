Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06DCC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A803F208A2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A803F208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388556AbeG0Lsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:48:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42284 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730340AbeG0Lsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:48:52 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 23839CD1;
        Fri, 27 Jul 2018 10:27:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Neal Cardwell <ncardwell@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 15/27] tcp: do not cancel delay-AcK on DCTCP special ACK
Date:   Fri, 27 Jul 2018 12:26:52 +0200
Message-Id: <20180727102649.604870193@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727102649.049641021@linuxfoundation.org>
References: <20180727102649.049641021@linuxfoundation.org>
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

From: Yuchung Cheng <ycheng@google.com>

[ Upstream commit 27cde44a259c380a3c09066fc4b42de7dde9b1ad ]

Currently when a DCTCP receiver delays an ACK and receive a
data packet with a different CE mark from the previous one's, it
sends two immediate ACKs acking previous and latest sequences
respectly (for ECN accounting).

Previously sending the first ACK may mark off the delayed ACK timer
(tcp_event_ack_sent). This may subsequently prevent sending the
second ACK to acknowledge the latest sequence (tcp_ack_snd_check).
The culprit is that tcp_send_ack() assumes it always acknowleges
the latest sequence, which is not true for the first special ACK.

The fix is to not make the assumption in tcp_send_ack and check the
actual ack sequence before cancelling the delayed ACK. Further it's
safer to pass the ack sequence number as a local variable into
tcp_send_ack routine, instead of intercepting tp->rcv_nxt to avoid
future bugs like this.

Reported-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/tcp.h     |    1 +
 net/ipv4/tcp_dctcp.c  |   34 ++++------------------------------
 net/ipv4/tcp_output.c |   11 ++++++++---
 3 files changed, 13 insertions(+), 33 deletions(-)

--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -530,6 +530,7 @@ int tcp_send_synack(struct sock *);
 bool tcp_syn_flood_action(struct sock *sk, const struct sk_buff *skb,
 			  const char *proto);
 void tcp_push_one(struct sock *, unsigned int mss_now);
+void __tcp_send_ack(struct sock *sk, u32 rcv_nxt);
 void tcp_send_ack(struct sock *sk);
 void tcp_send_delayed_ack(struct sock *sk);
 void tcp_send_loss_probe(struct sock *sk);
--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -132,21 +132,8 @@ static void dctcp_ce_state_0_to_1(struct
 	 * ACK has not sent yet.
 	 */
 	if (!ca->ce_state &&
-	    inet_csk(sk)->icsk_ack.pending & ICSK_ACK_TIMER) {
-		u32 tmp_rcv_nxt;
-
-		/* Save current rcv_nxt. */
-		tmp_rcv_nxt = tp->rcv_nxt;
-
-		/* Generate previous ack with CE=0. */
-		tp->ecn_flags &= ~TCP_ECN_DEMAND_CWR;
-		tp->rcv_nxt = ca->prior_rcv_nxt;
-
-		tcp_send_ack(sk);
-
-		/* Recover current rcv_nxt. */
-		tp->rcv_nxt = tmp_rcv_nxt;
-	}
+	    inet_csk(sk)->icsk_ack.pending & ICSK_ACK_TIMER)
+		__tcp_send_ack(sk, ca->prior_rcv_nxt);
 
 	ca->prior_rcv_nxt = tp->rcv_nxt;
 	ca->ce_state = 1;
@@ -163,21 +150,8 @@ static void dctcp_ce_state_1_to_0(struct
 	 * ACK has not sent yet.
 	 */
 	if (ca->ce_state &&
-	    inet_csk(sk)->icsk_ack.pending & ICSK_ACK_TIMER) {
-		u32 tmp_rcv_nxt;
-
-		/* Save current rcv_nxt. */
-		tmp_rcv_nxt = tp->rcv_nxt;
-
-		/* Generate previous ack with CE=1. */
-		tp->ecn_flags |= TCP_ECN_DEMAND_CWR;
-		tp->rcv_nxt = ca->prior_rcv_nxt;
-
-		tcp_send_ack(sk);
-
-		/* Recover current rcv_nxt. */
-		tp->rcv_nxt = tmp_rcv_nxt;
-	}
+	    inet_csk(sk)->icsk_ack.pending & ICSK_ACK_TIMER)
+		__tcp_send_ack(sk, ca->prior_rcv_nxt);
 
 	ca->prior_rcv_nxt = tp->rcv_nxt;
 	ca->ce_state = 0;
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -183,8 +183,13 @@ static void tcp_event_data_sent(struct t
 }
 
 /* Account for an ACK we sent. */
-static inline void tcp_event_ack_sent(struct sock *sk, unsigned int pkts)
+static inline void tcp_event_ack_sent(struct sock *sk, unsigned int pkts,
+				      u32 rcv_nxt)
 {
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (unlikely(rcv_nxt != tp->rcv_nxt))
+		return;  /* Special ACK sent by DCTCP to reflect ECN */
 	tcp_dec_quickack_mode(sk, pkts);
 	inet_csk_clear_xmit_timer(sk, ICSK_TIME_DACK);
 }
@@ -990,7 +995,7 @@ static int __tcp_transmit_skb(struct soc
 	icsk->icsk_af_ops->send_check(sk, skb);
 
 	if (likely(tcb->tcp_flags & TCPHDR_ACK))
-		tcp_event_ack_sent(sk, tcp_skb_pcount(skb));
+		tcp_event_ack_sent(sk, tcp_skb_pcount(skb), rcv_nxt);
 
 	if (skb->len != tcp_header_size)
 		tcp_event_data_sent(tp, sk);
@@ -3258,12 +3263,12 @@ void __tcp_send_ack(struct sock *sk, u32
 	skb_mstamp_get(&buff->skb_mstamp);
 	__tcp_transmit_skb(sk, buff, 0, sk_gfp_atomic(sk, GFP_ATOMIC), rcv_nxt);
 }
+EXPORT_SYMBOL_GPL(__tcp_send_ack);
 
 void tcp_send_ack(struct sock *sk)
 {
 	__tcp_send_ack(sk, tcp_sk(sk)->rcv_nxt);
 }
-EXPORT_SYMBOL_GPL(tcp_send_ack);
 
 /* This routine sends a packet with an out of date sequence
  * number. It assumes the other end will try to ack it.


