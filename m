Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbeDPPdy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 11:33:54 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35038 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752120AbeDPPdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 11:33:52 -0400
X-Google-Smtp-Source: AIpwx4/lL+G9Q3KoXuPD0hLWiOgil9vivjk9dUsrLWnZO/MbOQdTMtR56wICH1QYKT8rICHKYpQkqA==
From: Yafang Shao <laoar.shao@gmail.com>
To: davem@davemloft.net
Cc: kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, songliubraving@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH net-next] net: introduce a new tracepoint for tcp_rcv_space_adjust
Date: Mon, 16 Apr 2018 23:33:38 +0800
Message-Id: <1523892818-12820-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tcp_rcv_space_adjust is called every time data is copied to user space,
introducing a tcp tracepoint for which could show us when the packet is
copied to user.
This could help us figure out whether there's latency in user process.

When a tcp packet arrives, tcp_rcv_established() will be called and with
the existed tracepoint tcp_probe we could get the time when this packet
arrives.
Then this packet will be copied to user, and tcp_rcv_space_adjust will
be called and with this new introduced tracepoint we could get the time
when this packet is copied to user.

	arrives time : user process time    => latency caused by user
	tcp_probe      tcp_rcv_space_adjust

Hence in the prink message, sk is printed as a key to connect these two
tracepoints.

Maybe we could export sockfd in this new tracepoint as well, then we
could connect this new tracepoint with epoll/read/recv* tracepoint, and
finally that could show us the whole lifespan of this packet. But we
could also implement that with pid as these functions are executed in
process context.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/trace/events/tcp.h | 21 +++++++++++++++------
 net/ipv4/tcp_input.c       |  2 ++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 878b2be..65a6d22 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -146,10 +146,11 @@
 			       sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);
 	),
 
-	TP_printk("sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c",
+	TP_printk("sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c sock=0x%p",
 		  __entry->sport, __entry->dport,
 		  __entry->saddr, __entry->daddr,
-		  __entry->saddr_v6, __entry->daddr_v6)
+		  __entry->saddr_v6, __entry->daddr_v6,
+		  __entry->skaddr)
 );
 
 DEFINE_EVENT(tcp_event_sk, tcp_receive_reset,
@@ -166,6 +167,13 @@
 	TP_ARGS(sk)
 );
 
+DEFINE_EVENT(tcp_event_sk, tcp_rcv_space_adjust,
+
+	TP_PROTO(const struct sock *sk),
+
+	TP_ARGS(sk)
+);
+
 TRACE_EVENT(tcp_set_state,
 
 	TP_PROTO(const struct sock *sk, const int oldstate, const int newstate),
@@ -265,6 +273,7 @@
 	TP_ARGS(sk, skb),
 
 	TP_STRUCT__entry(
+		__field(const void *, skaddr)
 		/* sockaddr_in6 is always bigger than sockaddr_in */
 		__array(__u8, saddr, sizeof(struct sockaddr_in6))
 		__array(__u8, daddr, sizeof(struct sockaddr_in6))
@@ -285,6 +294,8 @@
 		const struct tcp_sock *tp = tcp_sk(sk);
 		const struct inet_sock *inet = inet_sk(sk);
 
+		__entry->skaddr = sk;
+
 		memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
 		memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
 
@@ -305,13 +316,11 @@
 		__entry->srtt = tp->srtt_us >> 3;
 	),
 
-	TP_printk("src=%pISpc dest=%pISpc mark=%#x length=%d snd_nxt=%#x "
-		  "snd_una=%#x snd_cwnd=%u ssthresh=%u snd_wnd=%u srtt=%u "
-		  "rcv_wnd=%u",
+	TP_printk("src=%pISpc dest=%pISpc mark=%#x length=%d snd_nxt=%#x snd_una=%#x snd_cwnd=%u ssthresh=%u snd_wnd=%u srtt=%u rcv_wnd=%u sock=0x%p",
 		  __entry->saddr, __entry->daddr, __entry->mark,
 		  __entry->length, __entry->snd_nxt, __entry->snd_una,
 		  __entry->snd_cwnd, __entry->ssthresh, __entry->snd_wnd,
-		  __entry->srtt, __entry->rcv_wnd)
+		  __entry->srtt, __entry->rcv_wnd, __entry->skaddr)
 );
 
 #endif /* _TRACE_TCP_H */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 367def6..4b4d6b9 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -582,6 +582,8 @@ void tcp_rcv_space_adjust(struct sock *sk)
 	u32 copied;
 	int time;
 
+	trace_tcp_rcv_space_adjust(sk);
+
 	tcp_mstamp_refresh(tp);
 	time = tcp_stamp_us_delta(tp->tcp_mstamp, tp->rcvq_space.time);
 	if (time < (tp->rcv_rtt_est.rtt_us >> 3) || tp->rcv_rtt_est.rtt_us == 0)
-- 
1.8.3.1
