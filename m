Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B30C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08FF32083B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUJROQNN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbfBLLch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:32:37 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45911 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfBLLcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 06:32:36 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so1105168pgc.12;
        Tue, 12 Feb 2019 03:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tGq8PbA79vpukPsFU9BlWG2NmvxdrhZLKX/FaV6VwZs=;
        b=hUJROQNNlwzkmy4I4CNEK31lPwH3ZAYkJmuWS18XA3VcSyDPU8qYouioQVxii/XNwK
         p/o5qjHlrzxX+9J1too4lr7BXFfBa7c2x+pXirNB0HE2spbaC0o7gYKPgiyoUodi5l2H
         7gHTTzEMRtWgDrarj+mP+w6rmrzoy+NY5Z8Ud0bOFltV9oSzqyxIyUPHZ8IEZY5NuUOu
         cI1m81d9EUvDhNqCQnPvKEUiudtT6ACfTWLSeyUwU638VhUnlUGmFC5P5vEsPy+OB8B2
         Dx49q7h7j4tB7khY5T0ab2aQpZBOn9VBMs/S2BH9FzqhNcvcq1lKA62Ltgbk50kkiPxL
         8m2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tGq8PbA79vpukPsFU9BlWG2NmvxdrhZLKX/FaV6VwZs=;
        b=PtCA37wrBSDny7HZwyMb89vMbNRHK2V5QJFMLQpLBf9JTDFNjt33qUxx4zwtdBqB2Y
         ANpHjSCEkA4RuCli6fC2b9fSbyN51MPB05mbJxVa33/Kn/vdkFQjIXwRV9jkgxZdtPdX
         X+DlwxMLBdRqsuNwS4Tq62S+P9XjGdjP7HzIxj1FIjOlI4yJMjv0dMYXYVU6izwMIhec
         Y8iOsrAfv0sAYYaSbGPC/q4SVRHKV1mZFsJvnJJ3LAZn2BNbGTTZU4oejIiU6Z2+PPX1
         ryDbEPrM8K+JWLzw1xrLvKwDujr30uO2xbBK1gfXQQpHA4uVNop5Y6PQdn9xainXLFWu
         0C9Q==
X-Gm-Message-State: AHQUAuagh7VM+NqCObElwxpHj8dKv6XPrae7aWvMOojjq2TXqDwRJlnH
        iDabPVIILUaRF/Pq/qvrN28=
X-Google-Smtp-Source: AHgI3IamvQyOnsJAMgD7S85Rpf25QobC2JNJughVb3qvdbjdkYkvDAWU6A2mqv8ZeUPLRy1XN4uGtg==
X-Received: by 2002:a62:b15:: with SMTP id t21mr3640481pfi.136.1549971155357;
        Tue, 12 Feb 2019 03:32:35 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id q21sm28701034pfq.138.2019.02.12.03.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 03:32:34 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     daniel@iogearbox.net, ast@kernel.org
Cc:     yhs@fb.com, brakmo@fb.com, edumazet@google.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, shaoyafang@didiglobal.com,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [bpf-next 1/2] tcp: replace SOCK_DEBUG() with tcp_stats()
Date:   Tue, 12 Feb 2019 19:31:36 +0800
Message-Id: <1549971097-12627-2-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1549971097-12627-1-git-send-email-laoar.shao@gmail.com>
References: <1549971097-12627-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SOCK_DEBUG is a very ancient debugging interface, and it's not very useful
for debugging.
So this patch removes the SOCK_DEBUG() and introduce a new function
tcp_stats() to trace this kind of events.
Some MIBs are added for these events.

Regarding the SO_DEBUG in sock_{s,g}etsockopt, I think it is better to
keep as-is, because if we return an errno to tell the application that
this optname isn't supported for TCP, it may break the application.
The application still can use this option but don't take any effect for
TCP.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/uapi/linux/snmp.h |  3 +++
 net/ipv4/proc.c           |  3 +++
 net/ipv4/tcp_input.c      | 26 +++++++++++---------------
 net/ipv6/tcp_ipv6.c       |  2 --
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index 86dc24a..fd5c09c 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -283,6 +283,9 @@ enum
 	LINUX_MIB_TCPACKCOMPRESSED,		/* TCPAckCompressed */
 	LINUX_MIB_TCPZEROWINDOWDROP,		/* TCPZeroWindowDrop */
 	LINUX_MIB_TCPRCVQDROP,			/* TCPRcvQDrop */
+	LINUX_MIB_TCPINVALIDACK,		/* TCPInvalidAck */
+	LINUX_MIB_TCPOLDACK,			/* TCPOldAck */
+	LINUX_MIB_TCPPARTIALPACKET,		/* TCPPartialPacket */
 	__LINUX_MIB_MAX
 };
 
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index c3610b3..1b0320a 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -291,6 +291,9 @@ static int sockstat_seq_show(struct seq_file *seq, void *v)
 	SNMP_MIB_ITEM("TCPAckCompressed", LINUX_MIB_TCPACKCOMPRESSED),
 	SNMP_MIB_ITEM("TCPZeroWindowDrop", LINUX_MIB_TCPZEROWINDOWDROP),
 	SNMP_MIB_ITEM("TCPRcvQDrop", LINUX_MIB_TCPRCVQDROP),
+	SNMP_MIB_ITEM("TCPInvalidAck", LINUX_MIB_TCPINVALIDACK),
+	SNMP_MIB_ITEM("TCPOldAck", LINUX_MIB_TCPOLDACK),
+	SNMP_MIB_ITEM("TCPPartialPacket", LINUX_MIB_TCPPARTIALPACKET),
 	SNMP_MIB_SENTINEL
 };
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 7a027dec..88deb1f 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3554,6 +3554,11 @@ static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered, int flag)
 	return delivered;
 }
 
+static void tcp_stats(struct sock *sk, int mib_idx)
+{
+	NET_INC_STATS(sock_net(sk), mib_idx);
+}
+
 /* This routine deals with incoming acks, but not outgoing ones. */
 static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 {
@@ -3715,7 +3720,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	return 1;
 
 invalid_ack:
-	SOCK_DEBUG(sk, "Ack %u after %u:%u\n", ack, tp->snd_una, tp->snd_nxt);
+	tcp_stats(sk, LINUX_MIB_TCPINVALIDACK);
 	return -1;
 
 old_ack:
@@ -3731,7 +3736,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 		tcp_xmit_recovery(sk, rexmit);
 	}
 
-	SOCK_DEBUG(sk, "Ack %u before %u:%u\n", ack, tp->snd_una, tp->snd_nxt);
+	tcp_stats(sk, LINUX_MIB_TCPOLDACK);
 	return 0;
 }
 
@@ -4432,13 +4437,10 @@ static void tcp_ofo_queue(struct sock *sk)
 		rb_erase(&skb->rbnode, &tp->out_of_order_queue);
 
 		if (unlikely(!after(TCP_SKB_CB(skb)->end_seq, tp->rcv_nxt))) {
-			SOCK_DEBUG(sk, "ofo packet was already received\n");
+			tcp_stats(sk, LINUX_MIB_TCPOFODROP);
 			tcp_drop(sk, skb);
 			continue;
 		}
-		SOCK_DEBUG(sk, "ofo requeuing : rcv_next %X seq %X - %X\n",
-			   tp->rcv_nxt, TCP_SKB_CB(skb)->seq,
-			   TCP_SKB_CB(skb)->end_seq);
 
 		tail = skb_peek_tail(&sk->sk_receive_queue);
 		eaten = tail && tcp_try_coalesce(sk, tail, skb, &fragstolen);
@@ -4499,11 +4501,9 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
 	tp->pred_flags = 0;
 	inet_csk_schedule_ack(sk);
 
-	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPOFOQUEUE);
 	seq = TCP_SKB_CB(skb)->seq;
 	end_seq = TCP_SKB_CB(skb)->end_seq;
-	SOCK_DEBUG(sk, "out of order segment: rcv_next %X seq %X - %X\n",
-		   tp->rcv_nxt, seq, end_seq);
+	tcp_stats(sk, LINUX_MIB_TCPOFOQUEUE);
 
 	p = &tp->out_of_order_queue.rb_node;
 	if (RB_EMPTY_ROOT(&tp->out_of_order_queue)) {
@@ -4779,9 +4779,7 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 
 	if (before(TCP_SKB_CB(skb)->seq, tp->rcv_nxt)) {
 		/* Partial packet, seq < rcv_next < end_seq */
-		SOCK_DEBUG(sk, "partial packet: rcv_next %X seq %X - %X\n",
-			   tp->rcv_nxt, TCP_SKB_CB(skb)->seq,
-			   TCP_SKB_CB(skb)->end_seq);
+		tcp_stats(sk, LINUX_MIB_TCPPARTIALPACKET);
 
 		tcp_dsack_set(sk, TCP_SKB_CB(skb)->seq, tp->rcv_nxt);
 
@@ -5061,9 +5059,7 @@ static int tcp_prune_queue(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
-	SOCK_DEBUG(sk, "prune_queue: c=%x\n", tp->copied_seq);
-
-	NET_INC_STATS(sock_net(sk), LINUX_MIB_PRUNECALLED);
+	tcp_stats(sk, LINUX_MIB_PRUNECALLED);
 
 	if (atomic_read(&sk->sk_rmem_alloc) >= sk->sk_rcvbuf)
 		tcp_clamp_window(sk);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index e51cda7..57ef69a1 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -220,8 +220,6 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
 		u32 exthdrlen = icsk->icsk_ext_hdr_len;
 		struct sockaddr_in sin;
 
-		SOCK_DEBUG(sk, "connect: ipv4 mapped\n");
-
 		if (__ipv6_only_sock(sk))
 			return -ENETUNREACH;
 
-- 
1.8.3.1

