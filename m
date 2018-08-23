Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7DDC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF18F208CC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF18F208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388849AbeHWMcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:32:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56124 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbeHWMco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:32:44 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DC2D9C93;
        Thu, 23 Aug 2018 09:04:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuchung Cheng <ycheng@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Lawrence Brakmo <brakmo@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 260/324] tcp: remove DELAYED ACK events in DCTCP
Date:   Thu, 23 Aug 2018 09:55:26 +0200
Message-Id: <20180823075009.025943270@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
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

From: Yuchung Cheng <ycheng@google.com>

[ Upstream commit a69258f7aa2623e0930212f09c586fd06674ad79 ]

After fixing the way DCTCP tracking delayed ACKs, the delayed-ACK
related callbacks are no longer needed

Signed-off-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Acked-by: Lawrence Brakmo <brakmo@fb.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/tcp.h     |    2 --
 net/ipv4/tcp_dctcp.c  |   25 -------------------------
 net/ipv4/tcp_output.c |    4 ----
 3 files changed, 31 deletions(-)

--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -907,8 +907,6 @@ enum tcp_ca_event {
 	CA_EVENT_LOSS,		/* loss timeout */
 	CA_EVENT_ECN_NO_CE,	/* ECT set, but not CE marked */
 	CA_EVENT_ECN_IS_CE,	/* received CE marked IP packet */
-	CA_EVENT_DELAYED_ACK,	/* Delayed ack is sent */
-	CA_EVENT_NON_DELAYED_ACK,
 };
 
 /* Information about inbound ACK, passed to cong_ops->in_ack_event() */
--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -55,7 +55,6 @@ struct dctcp {
 	u32 dctcp_alpha;
 	u32 next_seq;
 	u32 ce_state;
-	u32 delayed_ack_reserved;
 	u32 loss_cwnd;
 };
 
@@ -96,7 +95,6 @@ static void dctcp_init(struct sock *sk)
 
 		ca->dctcp_alpha = min(dctcp_alpha_on_init, DCTCP_MAX_ALPHA);
 
-		ca->delayed_ack_reserved = 0;
 		ca->loss_cwnd = 0;
 		ca->ce_state = 0;
 
@@ -230,25 +228,6 @@ static void dctcp_state(struct sock *sk,
 	}
 }
 
-static void dctcp_update_ack_reserved(struct sock *sk, enum tcp_ca_event ev)
-{
-	struct dctcp *ca = inet_csk_ca(sk);
-
-	switch (ev) {
-	case CA_EVENT_DELAYED_ACK:
-		if (!ca->delayed_ack_reserved)
-			ca->delayed_ack_reserved = 1;
-		break;
-	case CA_EVENT_NON_DELAYED_ACK:
-		if (ca->delayed_ack_reserved)
-			ca->delayed_ack_reserved = 0;
-		break;
-	default:
-		/* Don't care for the rest. */
-		break;
-	}
-}
-
 static void dctcp_cwnd_event(struct sock *sk, enum tcp_ca_event ev)
 {
 	switch (ev) {
@@ -258,10 +237,6 @@ static void dctcp_cwnd_event(struct sock
 	case CA_EVENT_ECN_NO_CE:
 		dctcp_ce_state_1_to_0(sk);
 		break;
-	case CA_EVENT_DELAYED_ACK:
-	case CA_EVENT_NON_DELAYED_ACK:
-		dctcp_update_ack_reserved(sk, ev);
-		break;
 	default:
 		/* Don't care for the rest. */
 		break;
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3545,8 +3545,6 @@ void tcp_send_delayed_ack(struct sock *s
 	int ato = icsk->icsk_ack.ato;
 	unsigned long timeout;
 
-	tcp_ca_event(sk, CA_EVENT_DELAYED_ACK);
-
 	if (ato > TCP_DELACK_MIN) {
 		const struct tcp_sock *tp = tcp_sk(sk);
 		int max_ato = HZ / 2;
@@ -3603,8 +3601,6 @@ void __tcp_send_ack(struct sock *sk, u32
 	if (sk->sk_state == TCP_CLOSE)
 		return;
 
-	tcp_ca_event(sk, CA_EVENT_NON_DELAYED_ACK);
-
 	/* We are not putting this on the write queue, so
 	 * tcp_transmit_skb() will set the ownership to this
 	 * sock.


