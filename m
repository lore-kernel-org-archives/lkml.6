Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5019FC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3A921470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1hGC4H5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3A921470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbeJKXJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:09:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeJKXJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:09:51 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDE1720652;
        Thu, 11 Oct 2018 15:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272527;
        bh=i+1pd3Ox7uanChlZLc2EMiDmD/rQz8DrgrlT6SbwlZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1hGC4H5KiFO6gWbpW5ddl08ylSpwD5E5G1rt9yyPi2du/zM4xQ3i+m2Y8lyJr3Rph
         h8sXXy0kex6ZnbkBYEpShzdPYAur3e/j5D6bXqrKEKeH/HtvjjFeaHzWiZ7GX/pBA6
         K2r0pMI6zmiiFJbbQ2HqKsaVgO/EKwnXf0vgUo7A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mao Wenan <maowenan@huawei.com>
Subject: [PATCH 4.4 20/27] tcp: increment sk_drops for dropped rx packets
Date:   Thu, 11 Oct 2018 17:35:07 +0200
Message-Id: <20181011152534.998726678@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152534.014964888@linuxfoundation.org>
References: <20181011152534.014964888@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 532182cd610782db8c18230c2747626562032205 ]

Now ss can report sk_drops, we can instruct TCP to increment
this per socket counter when it drops an incoming frame, to refine
monitoring and debugging.

Following patch takes care of listeners drops.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Mao Wenan <maowenan@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/sock.h   |    7 +++++++
 net/ipv4/tcp_input.c |   33 ++++++++++++++++++++-------------
 net/ipv4/tcp_ipv4.c  |    1 +
 net/ipv6/tcp_ipv6.c  |    1 +
 4 files changed, 29 insertions(+), 13 deletions(-)

--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2139,6 +2139,13 @@ sock_skb_set_dropcount(const struct sock
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
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4296,6 +4296,12 @@ static bool tcp_try_coalesce(struct sock
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
@@ -4320,7 +4326,7 @@ static void tcp_ofo_queue(struct sock *s
 		__skb_unlink(skb, &tp->out_of_order_queue);
 		if (!after(TCP_SKB_CB(skb)->end_seq, tp->rcv_nxt)) {
 			SOCK_DEBUG(sk, "ofo packet was already received\n");
-			__kfree_skb(skb);
+			tcp_drop(sk, skb);
 			continue;
 		}
 		SOCK_DEBUG(sk, "ofo requeuing : rcv_next %X seq %X - %X\n",
@@ -4372,7 +4378,7 @@ static void tcp_data_queue_ofo(struct so
 
 	if (unlikely(tcp_try_rmem_schedule(sk, skb, skb->truesize))) {
 		NET_INC_STATS_BH(sock_net(sk), LINUX_MIB_TCPOFODROP);
-		__kfree_skb(skb);
+		tcp_drop(sk, skb);
 		return;
 	}
 
@@ -4436,7 +4442,7 @@ static void tcp_data_queue_ofo(struct so
 		if (!after(end_seq, TCP_SKB_CB(skb1)->end_seq)) {
 			/* All the bits are present. Drop. */
 			NET_INC_STATS_BH(sock_net(sk), LINUX_MIB_TCPOFOMERGE);
-			__kfree_skb(skb);
+			tcp_drop(sk, skb);
 			skb = NULL;
 			tcp_dsack_set(sk, seq, end_seq);
 			goto add_sack;
@@ -4475,7 +4481,7 @@ static void tcp_data_queue_ofo(struct so
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
 
@@ -5684,7 +5691,7 @@ static int tcp_rcv_synsent_state_process
 						  TCP_DELACK_MAX, TCP_RTO_MAX);
 
 discard:
-			__kfree_skb(skb);
+			tcp_drop(sk, skb);
 			return 0;
 		} else {
 			tcp_send_ack(sk);
@@ -6041,7 +6048,7 @@ int tcp_rcv_state_process(struct sock *s
 
 	if (!queued) {
 discard:
-		__kfree_skb(skb);
+		tcp_drop(sk, skb);
 	}
 	return 0;
 }
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1716,6 +1716,7 @@ discard_it:
 	return 0;
 
 discard_and_relse:
+	sk_drops_add(sk, skb);
 	sock_put(sk);
 	goto discard_it;
 
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1505,6 +1505,7 @@ discard_it:
 	return 0;
 
 discard_and_relse:
+	sk_drops_add(sk, skb);
 	sock_put(sk);
 	goto discard_it;
 


