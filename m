Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756717AbeEJGy1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 02:54:27 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41599 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753693AbeEJGy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 02:54:26 -0400
X-Google-Smtp-Source: AB8JxZrk2Uj2NBXrXz8TMG8iYn3HpkDbjlpbaqZt0A7pVzYtqOfYGbdSWHvM7dFgHsqBWlvHey9voQ==
From: Jon Maxwell <jmaxwell37@gmail.com>
To: davem@davemloft.net
Cc: kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmaxwell@redhat.com
Subject: [PATCH net-next v2] tcp: Add mark for TIMEWAIT sockets
Date: Thu, 10 May 2018 16:53:51 +1000
Message-Id: <20180510065351.22535-1-jmaxwell37@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This version has some suggestions by Eric Dumazet:

- Use a local variable for the mark in IPv6 instead of ctl_sk to avoid SMP 
races. 
- Use the more elegant "IP4_REPLY_MARK(net, skb->mark) ?: sk->sk_mark"
statement. 
- Factorize code as sk_fullsock() check is not necessary.

Aidan McGurn from Openwave Mobility systems reported the following bug:

"Marked routing is broken on customer deployment. Its effects are large 
increase in Uplink retransmissions caused by the client never receiving 
the final ACK to their FINACK - this ACK misses the mark and routes out 
of the incorrect route."

Currently marks are added to sk_buffs for replies when the "fwmark_reflect" 
sysctl is enabled. But not for TW sockets that had sk->sk_mark set via 
setsockopt(SO_MARK..).  

Fix this in IPv4/v6 by adding tw->tw_mark for TIME_WAIT sockets. Copy the the 
original sk->sk_mark in __inet_twsk_hashdance() to the new tw->tw_mark location. 
Then progate this so that the skb gets sent with the correct mark. Do the same 
for resets. Give the "fwmark_reflect" sysctl precedence over sk->sk_mark so that
netfilter rules are still honored.

Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
---
 include/net/inet_timewait_sock.h |  1 +
 net/ipv4/ip_output.c             |  2 +-
 net/ipv4/tcp_ipv4.c              | 16 ++++++++++++++--
 net/ipv4/tcp_minisocks.c         |  1 +
 net/ipv6/tcp_ipv6.c              |  6 +++++-
 5 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_sock.h
index c7be1ca8e562..659d8ed5a3bc 100644
--- a/include/net/inet_timewait_sock.h
+++ b/include/net/inet_timewait_sock.h
@@ -62,6 +62,7 @@ struct inet_timewait_sock {
 #define tw_dr			__tw_common.skc_tw_dr
 
 	int			tw_timeout;
+	__u32			tw_mark;
 	volatile unsigned char	tw_substate;
 	unsigned char		tw_rcv_wscale;
 
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 95adb171f852..b5e21eb198d8 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1561,7 +1561,7 @@ void ip_send_unicast_reply(struct sock *sk, struct sk_buff *skb,
 		oif = skb->skb_iif;
 
 	flowi4_init_output(&fl4, oif,
-			   IP4_REPLY_MARK(net, skb->mark),
+			   IP4_REPLY_MARK(net, skb->mark) ?: sk->sk_mark,
 			   RT_TOS(arg->tos),
 			   RT_SCOPE_UNIVERSE, ip_hdr(skb)->protocol,
 			   ip_reply_arg_flowi_flags(arg),
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index f70586b50838..caf23de88f8a 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -621,6 +621,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 	struct sock *sk1 = NULL;
 #endif
 	struct net *net;
+	struct sock *ctl_sk;
 
 	/* Never send a reset in response to a reset. */
 	if (th->rst)
@@ -723,11 +724,16 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 	arg.tos = ip_hdr(skb)->tos;
 	arg.uid = sock_net_uid(net, sk && sk_fullsock(sk) ? sk : NULL);
 	local_bh_disable();
-	ip_send_unicast_reply(*this_cpu_ptr(net->ipv4.tcp_sk),
+	ctl_sk = *this_cpu_ptr(net->ipv4.tcp_sk);
+	if (sk)
+		ctl_sk->sk_mark = (sk->sk_state == TCP_TIME_WAIT) ?
+				   inet_twsk(sk)->tw_mark : sk->sk_mark;
+	ip_send_unicast_reply(ctl_sk,
 			      skb, &TCP_SKB_CB(skb)->header.h4.opt,
 			      ip_hdr(skb)->saddr, ip_hdr(skb)->daddr,
 			      &arg, arg.iov[0].iov_len);
 
+	ctl_sk->sk_mark = 0;
 	__TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
 	__TCP_INC_STATS(net, TCP_MIB_OUTRSTS);
 	local_bh_enable();
@@ -759,6 +765,7 @@ static void tcp_v4_send_ack(const struct sock *sk,
 	} rep;
 	struct net *net = sock_net(sk);
 	struct ip_reply_arg arg;
+	struct sock *ctl_sk;
 
 	memset(&rep.th, 0, sizeof(struct tcphdr));
 	memset(&arg, 0, sizeof(arg));
@@ -809,11 +816,16 @@ static void tcp_v4_send_ack(const struct sock *sk,
 	arg.tos = tos;
 	arg.uid = sock_net_uid(net, sk_fullsock(sk) ? sk : NULL);
 	local_bh_disable();
-	ip_send_unicast_reply(*this_cpu_ptr(net->ipv4.tcp_sk),
+	ctl_sk = *this_cpu_ptr(net->ipv4.tcp_sk);
+	if (sk)
+		ctl_sk->sk_mark = (sk->sk_state == TCP_TIME_WAIT) ?
+				   inet_twsk(sk)->tw_mark : sk->sk_mark;
+	ip_send_unicast_reply(ctl_sk,
 			      skb, &TCP_SKB_CB(skb)->header.h4.opt,
 			      ip_hdr(skb)->saddr, ip_hdr(skb)->daddr,
 			      &arg, arg.iov[0].iov_len);
 
+	ctl_sk->sk_mark = 0;
 	__TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
 	local_bh_enable();
 }
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 57b5468b5139..f867658b4b30 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -263,6 +263,7 @@ void tcp_time_wait(struct sock *sk, int state, int timeo)
 		struct inet_sock *inet = inet_sk(sk);
 
 		tw->tw_transparent	= inet->transparent;
+		tw->tw_mark		= sk->sk_mark;
 		tw->tw_rcv_wscale	= tp->rx_opt.rcv_wscale;
 		tcptw->tw_rcv_nxt	= tp->rcv_nxt;
 		tcptw->tw_snd_nxt	= tp->snd_nxt;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 6d664d83cd16..7d47c2b550a9 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -803,6 +803,7 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 	unsigned int tot_len = sizeof(struct tcphdr);
 	struct dst_entry *dst;
 	__be32 *topt;
+	__u32 mark = 0;
 
 	if (tsecr)
 		tot_len += TCPOLEN_TSTAMP_ALIGNED;
@@ -871,7 +872,10 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 		fl6.flowi6_oif = oif;
 	}
 
-	fl6.flowi6_mark = IP6_REPLY_MARK(net, skb->mark);
+	if (sk)
+		mark = (sk->sk_state == TCP_TIME_WAIT) ?
+			inet_twsk(sk)->tw_mark : sk->sk_mark;
+	fl6.flowi6_mark = IP6_REPLY_MARK(net, skb->mark) ?: mark;
 	fl6.fl6_dport = t1->dest;
 	fl6.fl6_sport = t1->source;
 	fl6.flowi6_uid = sock_net_uid(net, sk && sk_fullsock(sk) ? sk : NULL);
-- 
2.13.6
