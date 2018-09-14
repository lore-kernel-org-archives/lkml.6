Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3356FFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E125820882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E125820882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbeINN1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:27:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12128 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726898AbeINN1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:27:53 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A24AF736E6713;
        Fri, 14 Sep 2018 16:14:29 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Fri, 14 Sep 2018 16:14:22 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <netdev@vger.kernel.org>, <gregkh@linux-foundation.org>,
        <dwmw2@infradead.org>, <eric.dumazet@gmail.com>,
        <davem@davemloft.net>, <stable@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <maowenan@huawei.com>
Subject: [PATCH stable 4.4 V2 1/6] tcp: increment sk_drops for dropped rx packets
Date:   Fri, 14 Sep 2018 16:24:05 +0800
Message-ID: <1536913450-12380-2-git-send-email-maowenan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1536913450-12380-1-git-send-email-maowenan@huawei.com>
References: <1536913450-12380-1-git-send-email-maowenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 532182cd610782db8c18230c2747626562032205 ]

Now ss can report sk_drops, we can instruct TCP to increment
this per socket counter when it drops an incoming frame, to refine
monitoring and debugging.

Following patch takes care of listeners drops.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 include/net/sock.h   |  7 +++++++
 net/ipv4/tcp_input.c | 33 ++++++++++++++++++++-------------
 net/ipv4/tcp_ipv4.c  |  1 +
 net/ipv6/tcp_ipv6.c  |  1 +
 4 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 3d5ff74..5770757 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2139,6 +2139,13 @@ sock_skb_set_dropcount(const struct sock *sk, struct sk_buff *skb)
 	SOCK_SKB_CB(skb)->dropcount = atomic_read(&sk->sk_drops);
 }
 
+static inline void sk_drops_add(struct sock *sk, const struct sk_buff *skb)
+{
+	int segs = max_t(u16, 1, skb_shinfo(skb)->gso_segs);
+
+	atomic_add(segs, &sk->sk_drops);
+}
+
 void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 			   struct sk_buff *skb);
 void __sock_recv_wifi_status(struct msghdr *msg, struct sock *sk,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 9c4c6cd..9df4cbb 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4296,6 +4296,12 @@ static bool tcp_try_coalesce(struct sock *sk,
 	return true;
 }
 
+static void tcp_drop(struct sock *sk, struct sk_buff *skb)
+{
+	sk_drops_add(sk, skb);
+	__kfree_skb(skb);
+}
+
 /* This one checks to see if we can put data from the
  * out_of_order queue into the receive_queue.
  */
@@ -4320,7 +4326,7 @@ static void tcp_ofo_queue(struct sock *sk)
 		__skb_unlink(skb, &tp->out_of_order_queue);
 		if (!after(TCP_SKB_CB(skb)->end_seq, tp->rcv_nxt)) {
 			SOCK_DEBUG(sk, "ofo packet was already received\n");
-			__kfree_skb(skb);
+			tcp_drop(sk, skb);
 			continue;
 		}
 		SOCK_DEBUG(sk, "ofo requeuing : rcv_next %X seq %X - %X\n",
@@ -4372,7 +4378,7 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
 
 	if (unlikely(tcp_try_rmem_schedule(sk, skb, skb->truesize))) {
 		NET_INC_STATS_BH(sock_net(sk), LINUX_MIB_TCPOFODROP);
-		__kfree_skb(skb);
+		tcp_drop(sk, skb);
 		return;
 	}
 
@@ -4436,7 +4442,7 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
 		if (!after(end_seq, TCP_SKB_CB(skb1)->end_seq)) {
 			/* All the bits are present. Drop. */
 			NET_INC_STATS_BH(sock_net(sk), LINUX_MIB_TCPOFOMERGE);
-			__kfree_skb(skb);
+			tcp_drop(sk, skb);
 			skb = NULL;
 			tcp_dsack_set(sk, seq, end_seq);
 			goto add_sack;
@@ -4475,7 +4481,7 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
 		tcp_dsack_extend(sk, TCP_SKB_CB(skb1)->seq,
 				 TCP_SKB_CB(skb1)->end_seq);
 		NET_INC_STATS_BH(sock_net(sk), LINUX_MIB_TCPOFOMERGE);
-		__kfree_skb(skb1);
+		tcp_drop(sk, skb1);
 	}
 
 add_sack:
@@ -4558,12 +4564,13 @@ err:
 static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
-	int eaten = -1;
 	bool fragstolen = false;
+	int eaten = -1;
 
-	if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq)
-		goto drop;
-
+	if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq) {
+		__kfree_skb(skb);
+		return;
+	}
 	skb_dst_drop(skb);
 	__skb_pull(skb, tcp_hdr(skb)->doff * 4);
 
@@ -4645,7 +4652,7 @@ out_of_window:
 		tcp_enter_quickack_mode(sk, TCP_MAX_QUICKACKS);
 		inet_csk_schedule_ack(sk);
 drop:
-		__kfree_skb(skb);
+		tcp_drop(sk, skb);
 		return;
 	}
 
@@ -5236,7 +5243,7 @@ syn_challenge:
 	return true;
 
 discard:
-	__kfree_skb(skb);
+	tcp_drop(sk, skb);
 	return false;
 }
 
@@ -5454,7 +5461,7 @@ csum_error:
 	TCP_INC_STATS_BH(sock_net(sk), TCP_MIB_INERRS);
 
 discard:
-	__kfree_skb(skb);
+	tcp_drop(sk, skb);
 }
 EXPORT_SYMBOL(tcp_rcv_established);
 
@@ -5684,7 +5691,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 						  TCP_DELACK_MAX, TCP_RTO_MAX);
 
 discard:
-			__kfree_skb(skb);
+			tcp_drop(sk, skb);
 			return 0;
 		} else {
 			tcp_send_ack(sk);
@@ -6041,7 +6048,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 
 	if (!queued) {
 discard:
-		__kfree_skb(skb);
+		tcp_drop(sk, skb);
 	}
 	return 0;
 }
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index eeda67c..01715fc 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1716,6 +1716,7 @@ discard_it:
 	return 0;
 
 discard_and_relse:
+	sk_drops_add(sk, skb);
 	sock_put(sk);
 	goto discard_it;
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 90abe88..d6c1911 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1505,6 +1505,7 @@ discard_it:
 	return 0;
 
 discard_and_relse:
+	sk_drops_add(sk, skb);
 	sock_put(sk);
 	goto discard_it;
 
-- 
1.8.3.1

