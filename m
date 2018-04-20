Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755461AbeDTPSl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 11:18:41 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37847 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755357AbeDTPSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 11:18:39 -0400
X-Google-Smtp-Source: AIpwx4/7x1MQJQ/ElELAlUIIlfCkKxlE+14R2XfBlid5fSrctsOXuxo7npB0PZxqRaXUOzizbjb0Tw==
From: Yafang Shao <laoar.shao@gmail.com>
To: eric.dumazet@gmail.com, alexei.starovoitov@gmail.com,
        songliubraving@fb.com, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 net-next] net: introduce a new tracepoint for tcp_rcv_space_adjust
Date: Fri, 20 Apr 2018 23:18:26 +0800
Message-Id: <1524237506-11011-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tcp_rcv_space_adjust is called every time data is copied to user space,
introducing a tcp tracepoint for which could show us when the packet is
copied to user.

When a tcp packet arrives, tcp_rcv_established() will be called and with
the existed tracepoint tcp_probe we could get the time when this packet
arrives.
Then this packet will be copied to user, and tcp_rcv_space_adjust will
be called and with this new introduced tracepoint we could get the time
when this packet is copied to user.
With these two tracepoints, we could figure out whether the user program
processes this packet immediately or there's latency.

Hence in the printk message, sk_cookie is printed as a key to relate
tcp_rcv_space_adjust with tcp_probe.

Maybe we could export sockfd in this new tracepoint as well, then we
could relate this new tracepoint with epoll/read/recv* tracepoints, and
finally that could show us the whole lifespan of this packet. But we
could also implement that with pid as these functions are executed in
process context.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

---
v2 -> v3: use sock_gen_cookie in tcp_event_sk as well.
          Maybe we could init sk_cookie in the stack then in other code
          path we just read it other than set it. If that is needed I
          will do it in another new patch.
v1 -> v2: use sk_cookie as a key suggested by Eric.
---
 include/trace/events/tcp.h | 30 +++++++++++++++++++++---------
 net/ipv4/tcp_input.c       |  2 ++
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 3dd6802..c1a5284 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -10,6 +10,7 @@
 #include <linux/tracepoint.h>
 #include <net/ipv6.h>
 #include <net/tcp.h>
+#include <linux/sock_diag.h>
 
 #define TP_STORE_V4MAPPED(__entry, saddr, daddr)		\
 	do {							\
@@ -113,7 +114,7 @@
  */
 DECLARE_EVENT_CLASS(tcp_event_sk,
 
-	TP_PROTO(const struct sock *sk),
+	TP_PROTO(struct sock *sk),
 
 	TP_ARGS(sk),
 
@@ -125,6 +126,7 @@
 		__array(__u8, daddr, 4)
 		__array(__u8, saddr_v6, 16)
 		__array(__u8, daddr_v6, 16)
+		__field(__u64, sock_cookie)
 	),
 
 	TP_fast_assign(
@@ -144,24 +146,34 @@
 
 		TP_STORE_ADDRS(__entry, inet->inet_saddr, inet->inet_daddr,
 			       sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);
+
+		__entry->sock_cookie = sock_gen_cookie(sk);
 	),
 
-	TP_printk("sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c",
+	TP_printk("sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c sock_cookie=%llx",
 		  __entry->sport, __entry->dport,
 		  __entry->saddr, __entry->daddr,
-		  __entry->saddr_v6, __entry->daddr_v6)
+		  __entry->saddr_v6, __entry->daddr_v6,
+		  __entry->sock_cookie)
 );
 
 DEFINE_EVENT(tcp_event_sk, tcp_receive_reset,
 
-	TP_PROTO(const struct sock *sk),
+	TP_PROTO(struct sock *sk),
 
 	TP_ARGS(sk)
 );
 
 DEFINE_EVENT(tcp_event_sk, tcp_destroy_sock,
 
-	TP_PROTO(const struct sock *sk),
+	TP_PROTO(struct sock *sk),
+
+	TP_ARGS(sk)
+);
+
+DEFINE_EVENT(tcp_event_sk, tcp_rcv_space_adjust,
+
+	TP_PROTO(struct sock *sk),
 
 	TP_ARGS(sk)
 );
@@ -232,6 +244,7 @@
 		__field(__u32, snd_wnd)
 		__field(__u32, srtt)
 		__field(__u32, rcv_wnd)
+		__field(__u64, sock_cookie)
 	),
 
 	TP_fast_assign(
@@ -256,15 +269,14 @@
 		__entry->rcv_wnd = tp->rcv_wnd;
 		__entry->ssthresh = tcp_current_ssthresh(sk);
 		__entry->srtt = tp->srtt_us >> 3;
+		__entry->sock_cookie = sock_gen_cookie(sk);
 	),
 
-	TP_printk("src=%pISpc dest=%pISpc mark=%#x length=%d snd_nxt=%#x "
-		  "snd_una=%#x snd_cwnd=%u ssthresh=%u snd_wnd=%u srtt=%u "
-		  "rcv_wnd=%u",
+	TP_printk("src=%pISpc dest=%pISpc mark=%#x length=%d snd_nxt=%#x snd_una=%#x snd_cwnd=%u ssthresh=%u snd_wnd=%u srtt=%u rcv_wnd=%u sock_cookie=%llx",
 		  __entry->saddr, __entry->daddr, __entry->mark,
 		  __entry->length, __entry->snd_nxt, __entry->snd_una,
 		  __entry->snd_cwnd, __entry->ssthresh, __entry->snd_wnd,
-		  __entry->srtt, __entry->rcv_wnd)
+		  __entry->srtt, __entry->rcv_wnd, __entry->sock_cookie)
 );
 
 #endif /* _TRACE_TCP_H */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index f93687f..43ad468 100644
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
