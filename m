Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA872C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCFC2089F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCFC2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389541AbeG0Ldc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:33:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37006 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729547AbeG0Ldc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:33:32 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3174CCB5;
        Fri, 27 Jul 2018 10:12:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuchung Cheng <ycheng@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 06/23] tcp: helpers to send special DCTCP ack
Date:   Fri, 27 Jul 2018 12:09:07 +0200
Message-Id: <20180727100845.421883210@linuxfoundation.org>
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
@@ -901,8 +901,8 @@ out:
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
@@ -962,7 +962,7 @@ static int tcp_transmit_skb(struct sock
 	th->source		= inet->inet_sport;
 	th->dest		= inet->inet_dport;
 	th->seq			= htonl(tcb->seq);
-	th->ack_seq		= htonl(tp->rcv_nxt);
+	th->ack_seq		= htonl(rcv_nxt);
 	*(((__be16 *)th) + 6)	= htons(((tcp_header_size >> 2) << 12) |
 					tcb->tcp_flags);
 
@@ -1036,6 +1036,13 @@ static int tcp_transmit_skb(struct sock
 	return net_xmit_eval(err);
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
@@ -3354,7 +3361,7 @@ void tcp_send_delayed_ack(struct sock *s
 }
 
 /* This routine sends an ack and also updates the window. */
-void tcp_send_ack(struct sock *sk)
+void __tcp_send_ack(struct sock *sk, u32 rcv_nxt)
 {
 	struct sk_buff *buff;
 
@@ -3391,7 +3398,12 @@ void tcp_send_ack(struct sock *sk)
 
 	/* Send it off, this clears delayed acks for us. */
 	skb_mstamp_get(&buff->skb_mstamp);
-	tcp_transmit_skb(sk, buff, 0, sk_gfp_atomic(sk, GFP_ATOMIC));
+	__tcp_transmit_skb(sk, buff, 0, sk_gfp_atomic(sk, GFP_ATOMIC), rcv_nxt);
+}
+
+void tcp_send_ack(struct sock *sk)
+{
+	__tcp_send_ack(sk, tcp_sk(sk)->rcv_nxt);
 }
 EXPORT_SYMBOL_GPL(tcp_send_ack);
 


