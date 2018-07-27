Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CDDC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8659C20894
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8659C20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388726AbeG0LWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:22:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34118 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730120AbeG0LWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:22:45 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DF993CB8;
        Fri, 27 Jul 2018 10:01:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuchung Cheng <ycheng@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 25/48] tcp: helpers to send special DCTCP ack
Date:   Fri, 27 Jul 2018 12:00:10 +0200
Message-Id: <20180727095921.124249735@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727095918.503549522@linuxfoundation.org>
References: <20180727095918.503549522@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuchung Cheng <ycheng@google.com>

[ Upstream commit 2987babb6982306509380fc11b450227a844493b ]

Refactor and create helpers to send the special ACK in DCTCP.

Signed-off-by: Yuchung Cheng <ycheng@google.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_output.c |   22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -984,8 +984,8 @@ static void tcp_internal_pacing(struct s
  * We are working here with either a clone of the original
  * SKB, or a fresh unique copy made by the retransmit engine.
  */
-static int tcp_transmit_skb(struct sock *sk, struct sk_buff *skb, int clone_it,
-			    gfp_t gfp_mask)
+static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
+			      int clone_it, gfp_t gfp_mask, u32 rcv_nxt)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
 	struct inet_sock *inet;
@@ -1057,7 +1057,7 @@ static int tcp_transmit_skb(struct sock
 	th->source		= inet->inet_sport;
 	th->dest		= inet->inet_dport;
 	th->seq			= htonl(tcb->seq);
-	th->ack_seq		= htonl(tp->rcv_nxt);
+	th->ack_seq		= htonl(rcv_nxt);
 	*(((__be16 *)th) + 6)	= htons(((tcp_header_size >> 2) << 12) |
 					tcb->tcp_flags);
 
@@ -1135,6 +1135,13 @@ static int tcp_transmit_skb(struct sock
 	return err;
 }
 
+static int tcp_transmit_skb(struct sock *sk, struct sk_buff *skb, int clone_it,
+			    gfp_t gfp_mask)
+{
+	return __tcp_transmit_skb(sk, skb, clone_it, gfp_mask,
+				  tcp_sk(sk)->rcv_nxt);
+}
+
 /* This routine just queues the buffer for sending.
  *
  * NOTE: probe0 timer is not checked, do not forget tcp_push_pending_frames,
@@ -3551,7 +3558,7 @@ void tcp_send_delayed_ack(struct sock *s
 }
 
 /* This routine sends an ack and also updates the window. */
-void tcp_send_ack(struct sock *sk)
+void __tcp_send_ack(struct sock *sk, u32 rcv_nxt)
 {
 	struct sk_buff *buff;
 
@@ -3586,7 +3593,12 @@ void tcp_send_ack(struct sock *sk)
 	skb_set_tcp_pure_ack(buff);
 
 	/* Send it off, this clears delayed acks for us. */
-	tcp_transmit_skb(sk, buff, 0, (__force gfp_t)0);
+	__tcp_transmit_skb(sk, buff, 0, (__force gfp_t)0, rcv_nxt);
+}
+
+void tcp_send_ack(struct sock *sk)
+{
+	__tcp_send_ack(sk, tcp_sk(sk)->rcv_nxt);
 }
 EXPORT_SYMBOL_GPL(tcp_send_ack);
 


