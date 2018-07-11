Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57852C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F5320B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFIQ8W7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F5320B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387805AbeGKNVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:21:41 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44550 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732311AbeGKNVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:21:40 -0400
Received: by mail-pl0-f67.google.com with SMTP id m16-v6so9164154pls.11;
        Wed, 11 Jul 2018 06:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vh6qL5b9mArx8DeH3W78oXUdke7aI+wHrb8zTDRZYbg=;
        b=lFIQ8W7E5A3GRxNRlV9zon1LmR8eWv7ABnHfJatf/zJBKZAsvnDVQXezqka7Zpj6rC
         0Ydez5GyFsDqBGJX5/AcBIsp8kmhb9Ev6dVJG5IhTAndqQNGIxZC3+84wuNsRf065d/0
         hJH4Qnwy+ug2jA6lvSjL8DvcnZ6IGRCuYJOkS3cbboT/pWRf5iLaQ/IhTpjSRAgBMcW6
         Oc+7xcN99jVP1bUf0eDyj+d8OE3p/RaZVvmR/T/PNTqbrNrgOwxhhW6pO8srx60OF0aZ
         YaunwBFmsjRhvvj33W30Cok7NxcVTc/TpGVN1MXk77D1J+Ae+DXddf/pdt75WVKruOS+
         C+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vh6qL5b9mArx8DeH3W78oXUdke7aI+wHrb8zTDRZYbg=;
        b=Tmo57qrdJnOWw7U/gI05lvn+VZTFIF6y6YFNTRpazAbmj21BgjzbWd4g5+LPIBz6kf
         pk/rXtQX+pNs50TLonwjIaGICTahMQAx4b5QLAMTrPk83Dmijj06SUpavSibrMVXeyaN
         giW9SPUKnHL/wrRJ6CBCV1T5xBGb/bbiHntl3IHBttJa9KSAjdgHmjGX3aAjmYlC8BSM
         e2G2krbLx3iSSZ/Tj2qAO+om6YntXEDhmusc7rCtWVpmwQ276vPqFLaVAHam4VrMD/pD
         8fgm6hku6rI1hc9s+PsvOn/EB9KeESaGfUJg8ZRjpZDXOtgRnuIW2x9vTNeMDY/Jlaxd
         4Mtw==
X-Gm-Message-State: APt69E3Iwgy1tpJje28TX+Z0nKal8kDG6hy6CmfNYw1qCzLeFui7AQbf
        03L8hn8JrlB3OdcA4NfrTi2JPxlw
X-Google-Smtp-Source: AAOMgpe9WhG3FZ6lbzeJYiuM9i1XDtJYknSRlKNgC22BBAehMCQQs0crN2sEuDoQGPoyisDPt+gnBw==
X-Received: by 2002:a17:902:8607:: with SMTP id f7-v6mr28895603plo.138.1531315042130;
        Wed, 11 Jul 2018 06:17:22 -0700 (PDT)
Received: from bogon.didichuxing.com ([168.63.150.120])
        by smtp.gmail.com with ESMTPSA id r87-v6sm50285737pfb.1.2018.07.11.06.17.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 06:17:21 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     davem@davemloft.net, edumazet@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaoyafang@didichuxing.com, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH net-next 2/2] tcp: refactor tcp_queue_rcv
Date:   Wed, 11 Jul 2018 09:16:59 -0400
Message-Id: <1531315019-3553-2-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1531315019-3553-1-git-send-email-laoar.shao@gmail.com>
References: <1531315019-3553-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There're are some code similar to tcp_queue_rcv() in tcp_ofo_queue(),
so refactor tcp_queue_rcv() to make it be used in tcp_ofo_queue().

After this change, skb->sk is set when skb is moved from ofo queue into
receive queue instead of when queued into ofo queue.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 net/ipv4/tcp_input.c | 52 ++++++++++++++++++++++------------------------------
 1 file changed, 22 insertions(+), 30 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 3a54faf..92d4499 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4367,6 +4367,21 @@ static void tcp_drop(struct sock *sk, struct sk_buff *skb)
 	__kfree_skb(skb);
 }
 
+static int __must_check
+tcp_queue_rcv(struct sock *sk, struct sk_buff *skb, bool *fragstolen)
+{
+	int eaten;
+	struct sk_buff *tail = skb_peek_tail(&sk->sk_receive_queue);
+
+	eaten = tail && tcp_try_coalesce(sk, tail, skb, fragstolen);
+	tcp_rcv_nxt_update(tcp_sk(sk), TCP_SKB_CB(skb)->end_seq);
+	if (!eaten) {
+		__skb_queue_tail(&sk->sk_receive_queue, skb);
+		skb_set_owner_r(skb, sk);
+	}
+	return eaten;
+}
+
 /* This one checks to see if we can put data from the
  * out_of_order queue into the receive_queue.
  */
@@ -4375,7 +4390,7 @@ static void tcp_ofo_queue(struct sock *sk)
 	struct tcp_sock *tp = tcp_sk(sk);
 	__u32 dsack_high = tp->rcv_nxt;
 	bool fin, fragstolen, eaten;
-	struct sk_buff *skb, *tail;
+	struct sk_buff *skb;
 	struct rb_node *p;
 
 	p = rb_first(&tp->out_of_order_queue);
@@ -4402,13 +4417,9 @@ static void tcp_ofo_queue(struct sock *sk)
 			   tp->rcv_nxt, TCP_SKB_CB(skb)->seq,
 			   TCP_SKB_CB(skb)->end_seq);
 
-		tail = skb_peek_tail(&sk->sk_receive_queue);
-		eaten = tail && tcp_try_coalesce(sk, tail, skb, &fragstolen);
-		tcp_rcv_nxt_update(tp, TCP_SKB_CB(skb)->end_seq);
+		eaten = tcp_queue_rcv(sk, skb, &fragstolen);
 		fin = TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN;
-		if (!eaten)
-			__skb_queue_tail(&sk->sk_receive_queue, skb);
-		else
+		if (eaten)
 			kfree_skb_partial(skb, fragstolen);
 
 		if (unlikely(fin)) {
@@ -4573,28 +4584,9 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
 	if (skb) {
 		tcp_grow_window(sk, skb);
 		skb_condense(skb);
-		skb_set_owner_r(skb, sk);
 	}
 }
 
-static int __must_check tcp_queue_rcv(struct sock *sk, struct sk_buff *skb, int hdrlen,
-		  bool *fragstolen)
-{
-	int eaten;
-	struct sk_buff *tail = skb_peek_tail(&sk->sk_receive_queue);
-
-	__skb_pull(skb, hdrlen);
-	eaten = (tail &&
-		 tcp_try_coalesce(sk, tail,
-				  skb, fragstolen)) ? 1 : 0;
-	tcp_rcv_nxt_update(tcp_sk(sk), TCP_SKB_CB(skb)->end_seq);
-	if (!eaten) {
-		__skb_queue_tail(&sk->sk_receive_queue, skb);
-		skb_set_owner_r(skb, sk);
-	}
-	return eaten;
-}
-
 int tcp_send_rcvq(struct sock *sk, struct msghdr *msg, size_t size)
 {
 	struct sk_buff *skb;
@@ -4634,7 +4626,7 @@ int tcp_send_rcvq(struct sock *sk, struct msghdr *msg, size_t size)
 	TCP_SKB_CB(skb)->end_seq = TCP_SKB_CB(skb)->seq + size;
 	TCP_SKB_CB(skb)->ack_seq = tcp_sk(sk)->snd_una - 1;
 
-	if (tcp_queue_rcv(sk, skb, 0, &fragstolen)) {
+	if (tcp_queue_rcv(sk, skb, &fragstolen)) {
 		WARN_ON_ONCE(fragstolen); /* should not happen */
 		__kfree_skb(skb);
 	}
@@ -4694,7 +4686,7 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 			goto drop;
 		}
 
-		eaten = tcp_queue_rcv(sk, skb, 0, &fragstolen);
+		eaten = tcp_queue_rcv(sk, skb, &fragstolen);
 		if (skb->len)
 			tcp_event_data_recv(sk, skb);
 		if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)
@@ -5529,8 +5521,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPHPHITS);
 
 			/* Bulk data transfer: receiver */
-			eaten = tcp_queue_rcv(sk, skb, tcp_header_len,
-					      &fragstolen);
+			__skb_pull(skb, tcp_header_len);
+			eaten = tcp_queue_rcv(sk, skb, &fragstolen);
 
 			tcp_event_data_recv(sk, skb);
 
-- 
1.8.3.1

