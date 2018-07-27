Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355DAC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F082089E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F082089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389557AbeG0Ldk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:33:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37022 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729547AbeG0Ldj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:33:39 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D7110CB5;
        Fri, 27 Jul 2018 10:12:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuchung Cheng <ycheng@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 08/23] tcp: do not delay ACK in DCTCP upon CE status change
Date:   Fri, 27 Jul 2018 12:09:09 +0200
Message-Id: <20180727100845.494206831@linuxfoundation.org>
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

From: Yuchung Cheng <ycheng@google.com>

[ Upstream commit a0496ef2c23b3b180902dd185d0d63ccbc624cf8 ]

Per DCTCP RFC8257 (Section 3.2) the ACK reflecting the CE status change
has to be sent immediately so the sender can respond quickly:

""" When receiving packets, the CE codepoint MUST be processed as follows:

   1.  If the CE codepoint is set and DCTCP.CE is false, set DCTCP.CE to
       true and send an immediate ACK.

   2.  If the CE codepoint is not set and DCTCP.CE is true, set DCTCP.CE
       to false and send an immediate ACK.
"""

Previously DCTCP implementation may continue to delay the ACK. This
patch fixes that to implement the RFC by forcing an immediate ACK.

Tested with this packetdrill script provided by Larry Brakmo

0.000 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
0.000 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
0.000 setsockopt(3, SOL_TCP, TCP_CONGESTION, "dctcp", 5) = 0
0.000 bind(3, ..., ...) = 0
0.000 listen(3, 1) = 0

0.100 < [ect0] SEW 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
0.100 > SE. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
0.110 < [ect0] . 1:1(0) ack 1 win 257
0.200 accept(3, ..., ...) = 4
   +0 setsockopt(4, SOL_SOCKET, SO_DEBUG, [1], 4) = 0

0.200 < [ect0] . 1:1001(1000) ack 1 win 257
0.200 > [ect01] . 1:1(0) ack 1001

0.200 write(4, ..., 1) = 1
0.200 > [ect01] P. 1:2(1) ack 1001

0.200 < [ect0] . 1001:2001(1000) ack 2 win 257
+0.005 < [ce] . 2001:3001(1000) ack 2 win 257

+0.000 > [ect01] . 2:2(0) ack 2001
// Previously the ACK below would be delayed by 40ms
+0.000 > [ect01] E. 2:2(0) ack 3001

+0.500 < F. 9501:9501(0) ack 4 win 257

Signed-off-by: Yuchung Cheng <ycheng@google.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/tcp.h    |    1 +
 net/ipv4/tcp_dctcp.c |   30 ++++++++++++++++++------------
 net/ipv4/tcp_input.c |    3 ++-
 3 files changed, 21 insertions(+), 13 deletions(-)

--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -376,6 +376,7 @@ ssize_t tcp_splice_read(struct socket *s
 			struct pipe_inode_info *pipe, size_t len,
 			unsigned int flags);
 
+void tcp_enter_quickack_mode(struct sock *sk);
 static inline void tcp_dec_quickack_mode(struct sock *sk,
 					 const unsigned int pkts)
 {
--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -131,12 +131,15 @@ static void dctcp_ce_state_0_to_1(struct
 	struct dctcp *ca = inet_csk_ca(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
 
-	/* State has changed from CE=0 to CE=1 and delayed
-	 * ACK has not sent yet.
-	 */
-	if (!ca->ce_state &&
-	    inet_csk(sk)->icsk_ack.pending & ICSK_ACK_TIMER)
-		__tcp_send_ack(sk, ca->prior_rcv_nxt);
+	if (!ca->ce_state) {
+		/* State has changed from CE=0 to CE=1, force an immediate
+		 * ACK to reflect the new CE state. If an ACK was delayed,
+		 * send that first to reflect the prior CE state.
+		 */
+		if (inet_csk(sk)->icsk_ack.pending & ICSK_ACK_TIMER)
+			__tcp_send_ack(sk, ca->prior_rcv_nxt);
+		tcp_enter_quickack_mode(sk);
+	}
 
 	ca->prior_rcv_nxt = tp->rcv_nxt;
 	ca->ce_state = 1;
@@ -149,12 +152,15 @@ static void dctcp_ce_state_1_to_0(struct
 	struct dctcp *ca = inet_csk_ca(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
 
-	/* State has changed from CE=1 to CE=0 and delayed
-	 * ACK has not sent yet.
-	 */
-	if (ca->ce_state &&
-	    inet_csk(sk)->icsk_ack.pending & ICSK_ACK_TIMER)
-		__tcp_send_ack(sk, ca->prior_rcv_nxt);
+	if (ca->ce_state) {
+		/* State has changed from CE=1 to CE=0, force an immediate
+		 * ACK to reflect the new CE state. If an ACK was delayed,
+		 * send that first to reflect the prior CE state.
+		 */
+		if (inet_csk(sk)->icsk_ack.pending & ICSK_ACK_TIMER)
+			__tcp_send_ack(sk, ca->prior_rcv_nxt);
+		tcp_enter_quickack_mode(sk);
+	}
 
 	ca->prior_rcv_nxt = tp->rcv_nxt;
 	ca->ce_state = 0;
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -187,13 +187,14 @@ static void tcp_incr_quickack(struct soc
 		icsk->icsk_ack.quick = min(quickacks, TCP_MAX_QUICKACKS);
 }
 
-static void tcp_enter_quickack_mode(struct sock *sk)
+void tcp_enter_quickack_mode(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	tcp_incr_quickack(sk);
 	icsk->icsk_ack.pingpong = 0;
 	icsk->icsk_ack.ato = TCP_ATO_MIN;
 }
+EXPORT_SYMBOL(tcp_enter_quickack_mode);
 
 /* Send ACKs quickly, if "quick" count is not exhausted
  * and the session is not interactive.


