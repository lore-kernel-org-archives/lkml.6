Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52103C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B03E2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="OAn+5MZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbfBNBMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 20:12:42 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:3631 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfBNBMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 20:12:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1550106757; x=1581642757;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7CKt1jUkf7woufYoigbPSEV2un4B4i5D1Bw3TCbbn+Q=;
  b=OAn+5MZ3asSOon8nYe51aUOybaQj0syjoCg1yrN545di1jH3pup2TZ/9
   Wj2HRa7yVm959bf5LumXllaxNkdQFGqqTVM1LR1O+KuQ0+qHUI7f75phF
   CwCUxFymFCklLj3EYdJAVhiL0NuBsyUmSFOpbCbAhQISThmx+33FcGkw2
   w=;
X-IronPort-AV: E=Sophos;i="5.58,367,1544486400"; 
   d="scan'208";a="782771587"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Feb 2019 01:12:17 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x1E1CEui017016
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 14 Feb 2019 01:12:14 GMT
Received: from EX13D17UWC003.ant.amazon.com (10.43.162.206) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 14 Feb 2019 01:12:14 +0000
Received: from dev-dsk-alakeshh-2c-f8a3e6e0.us-west-2.amazon.com
 (10.43.161.164) by EX13D17UWC003.ant.amazon.com (10.43.162.206) with
 Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 14 Feb 2019 01:12:13 +0000
Date:   Thu, 14 Feb 2019 01:12:08 +0000
From:   Alakesh Haloi <alakeshh@amazon.com>
To:     <stable@vger.kernel.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "Eric Dumazet" <edumazet@google.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] tcp: Namespace-ify sysctl_tcp_rmem and sysctl_tcp_wmem
Message-ID: <20190214011159.GA35034@dev-dsk-alakeshh-2c-f8a3e6e0.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.43.161.164]
X-ClientProxiedBy: EX13D11UWC002.ant.amazon.com (10.43.162.174) To
 EX13D17UWC003.ant.amazon.com (10.43.162.206)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 356d1833b638bd465672aefeb71def3ab93fc17d ]

Note that when a new netns is created, it inherits its
sysctl_tcp_rmem and sysctl_tcp_wmem from initial netns.

This change is needed so that we can refine TCP rcvbuf autotuning,
to take RTT into consideration.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Wei Wang <weiwan@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[alakeshh: backport to v4.14: The patch does not apply to v4.14
directly and hence needed manual backport. Function signature for
the function tcp_select_initial_window had to be changed to be able
to pass pointer to struct sock.]
Signed-off-by: Alakesh Haloi <alakeshh@amazon.com>
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: <stable@vger.kernel.org> # 4.14.x
---
 include/net/netns/ipv4.h   |  2 ++
 include/net/sock.h         |  3 +++
 include/net/tcp.h          |  5 ++---
 net/ipv4/syncookies.c      |  2 +-
 net/ipv4/sysctl_net_ipv4.c | 34 +++++++++++++++++-----------------
 net/ipv4/tcp.c             | 21 ++++++++-------------
 net/ipv4/tcp_input.c       | 17 +++++++++++------
 net/ipv4/tcp_ipv4.c        | 12 ++++++++++--
 net/ipv4/tcp_minisocks.c   |  2 +-
 net/ipv4/tcp_output.c      |  7 ++++---
 net/ipv6/syncookies.c      |  2 +-
 net/ipv6/tcp_ipv6.c        |  4 ++--
 12 files changed, 62 insertions(+), 49 deletions(-)

diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 8fcff2837484..ea48e5b8dbda 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -126,6 +126,8 @@ struct netns_ipv4 {
 	int sysctl_tcp_sack;
 	int sysctl_tcp_window_scaling;
 	int sysctl_tcp_timestamps;
+	int sysctl_tcp_wmem[3];
+	int sysctl_tcp_rmem[3];
 	struct inet_timewait_death_row tcp_death_row;
 	int sysctl_max_syn_backlog;
 
diff --git a/include/net/sock.h b/include/net/sock.h
index 4280e96d4b46..cec9b63a482a 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1095,8 +1095,11 @@ struct proto {
 	 */
 	unsigned long		*memory_pressure;
 	long			*sysctl_mem;
+
 	int			*sysctl_wmem;
 	int			*sysctl_rmem;
+	u32                     sysctl_wmem_offset;
+	u32                     sysctl_rmem_offset;
 	int			max_header;
 	bool			no_autobind;
 
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 0c828aac7e04..a234f0d83184 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -251,8 +251,6 @@ extern int sysctl_tcp_reordering;
 extern int sysctl_tcp_max_reordering;
 extern int sysctl_tcp_dsack;
 extern long sysctl_tcp_mem[3];
-extern int sysctl_tcp_wmem[3];
-extern int sysctl_tcp_rmem[3];
 extern int sysctl_tcp_app_win;
 extern int sysctl_tcp_adv_win_scale;
 extern int sysctl_tcp_frto;
@@ -1322,7 +1320,8 @@ static inline void tcp_slow_start_after_idle_check(struct sock *sk)
 }
 
 /* Determine a window scaling and initial window to offer. */
-void tcp_select_initial_window(int __space, __u32 mss, __u32 *rcv_wnd,
+void tcp_select_initial_window(const struct sock *sk, int __space, __u32 mss,
+			       __u32 *rcv_wnd,
 			       __u32 *window_clamp, int wscale_ok,
 			       __u8 *rcv_wscale, __u32 init_rcv_wnd);
 
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 77cf32a80952..fda37f2862c9 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -385,7 +385,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	/* Try to redo what tcp_v4_send_synack did. */
 	req->rsk_window_clamp = tp->window_clamp ? :dst_metric(&rt->dst, RTAX_WINDOW);
 
-	tcp_select_initial_window(tcp_full_space(sk), req->mss,
+	tcp_select_initial_window(sk, tcp_full_space(sk), req->mss,
 				  &req->rsk_rcv_wnd, &req->rsk_window_clamp,
 				  ireq->wscale_ok, &rcv_wscale,
 				  dst_metric(&rt->dst, RTAX_INITRWND));
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index d82e8344fc54..0a518d3fdd5a 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -508,22 +508,6 @@ static struct ctl_table ipv4_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
 	},
-	{
-		.procname	= "tcp_wmem",
-		.data		= &sysctl_tcp_wmem,
-		.maxlen		= sizeof(sysctl_tcp_wmem),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
-	},
-	{
-		.procname	= "tcp_rmem",
-		.data		= &sysctl_tcp_rmem,
-		.maxlen		= sizeof(sysctl_tcp_rmem),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
-	},
 	{
 		.procname	= "tcp_app_win",
 		.data		= &sysctl_tcp_app_win,
@@ -1152,7 +1136,23 @@ static struct ctl_table ipv4_net_table[] = {
 		.data		= &init_net.ipv4.sysctl_tcp_timestamps,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "tcp_wmem",
+		.data		= &init_net.ipv4.sysctl_tcp_wmem,
+		.maxlen		= sizeof(init_net.ipv4.sysctl_tcp_wmem),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &one,
+	},
+	{
+		.procname	= "tcp_rmem",
+		.data		= &init_net.ipv4.sysctl_tcp_rmem,
+		.maxlen		= sizeof(init_net.ipv4.sysctl_tcp_rmem),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &one,
 	},
 	{ }
 };
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index fd14501ac3af..57db728ec5f7 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -290,12 +290,8 @@ struct percpu_counter tcp_orphan_count;
 EXPORT_SYMBOL_GPL(tcp_orphan_count);
 
 long sysctl_tcp_mem[3] __read_mostly;
-int sysctl_tcp_wmem[3] __read_mostly;
-int sysctl_tcp_rmem[3] __read_mostly;
 
 EXPORT_SYMBOL(sysctl_tcp_mem);
-EXPORT_SYMBOL(sysctl_tcp_rmem);
-EXPORT_SYMBOL(sysctl_tcp_wmem);
 
 atomic_long_t tcp_memory_allocated;	/* Current allocated memory. */
 EXPORT_SYMBOL(tcp_memory_allocated);
@@ -449,9 +445,8 @@ void tcp_init_sock(struct sock *sk)
 
 	icsk->icsk_sync_mss = tcp_sync_mss;
 
-	sk->sk_sndbuf = sysctl_tcp_wmem[1];
-	sk->sk_rcvbuf = sysctl_tcp_rmem[1];
-
+	sk->sk_sndbuf = sock_net(sk)->ipv4.sysctl_tcp_wmem[1];
+	sk->sk_rcvbuf = sock_net(sk)->ipv4.sysctl_tcp_rmem[1];
 	sk_sockets_allocated_inc(sk);
 }
 EXPORT_SYMBOL(tcp_init_sock);
@@ -3538,13 +3533,13 @@ void __init tcp_init(void)
 	max_wshare = min(4UL*1024*1024, limit);
 	max_rshare = min(6UL*1024*1024, limit);
 
-	sysctl_tcp_wmem[0] = SK_MEM_QUANTUM;
-	sysctl_tcp_wmem[1] = 16*1024;
-	sysctl_tcp_wmem[2] = max(64*1024, max_wshare);
+	init_net.ipv4.sysctl_tcp_wmem[0] = SK_MEM_QUANTUM;
+	init_net.ipv4.sysctl_tcp_wmem[1] = 16 * 1024;
+	init_net.ipv4.sysctl_tcp_wmem[2] = max(64 * 1024, max_wshare);
 
-	sysctl_tcp_rmem[0] = SK_MEM_QUANTUM;
-	sysctl_tcp_rmem[1] = 87380;
-	sysctl_tcp_rmem[2] = max(87380, max_rshare);
+	init_net.ipv4.sysctl_tcp_rmem[0] = SK_MEM_QUANTUM;
+	init_net.ipv4.sysctl_tcp_rmem[1] = 87380;
+	init_net.ipv4.sysctl_tcp_rmem[2] = max(87380, max_rshare);
 
 	pr_info("Hash tables configured (established %u bind %u)\n",
 		tcp_hashinfo.ehash_mask + 1, tcp_hashinfo.bhash_size);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e24c0d7adf65..19b59488d4d5 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -340,7 +340,8 @@ static void tcp_sndbuf_expand(struct sock *sk)
 	sndmem *= nr_segs * per_mss;
 
 	if (sk->sk_sndbuf < sndmem)
-		sk->sk_sndbuf = min(sndmem, sysctl_tcp_wmem[2]);
+		sk->sk_sndbuf = min(sndmem,
+				    sock_net(sk)->ipv4.sysctl_tcp_wmem[2]);
 }
 
 /* 2. Tuning advertised window (window_clamp, rcv_ssthresh)
@@ -372,9 +373,10 @@ static void tcp_sndbuf_expand(struct sock *sk)
 static int __tcp_grow_window(const struct sock *sk, const struct sk_buff *skb)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
+	struct net *net = sock_net(sk);
 	/* Optimize this! */
 	int truesize = tcp_win_from_space(skb->truesize) >> 1;
-	int window = tcp_win_from_space(sysctl_tcp_rmem[2]) >> 1;
+	int window = tcp_win_from_space(net->ipv4.sysctl_tcp_rmem[2]) >> 1;
 
 	while (tp->rcv_ssthresh <= window) {
 		if (truesize <= skb->len)
@@ -417,6 +419,7 @@ static void tcp_grow_window(struct sock *sk, const struct sk_buff *skb)
 static void tcp_fixup_rcvbuf(struct sock *sk)
 {
 	u32 mss = tcp_sk(sk)->advmss;
+	struct net *net = sock_net(sk);
 	int rcvmem;
 
 	rcvmem = 2 * SKB_TRUESIZE(mss + MAX_TCP_HEADER) *
@@ -429,7 +432,7 @@ static void tcp_fixup_rcvbuf(struct sock *sk)
 		rcvmem <<= 2;
 
 	if (sk->sk_rcvbuf < rcvmem)
-		sk->sk_rcvbuf = min(rcvmem, sysctl_tcp_rmem[2]);
+		sk->sk_rcvbuf = min(rcvmem, net->ipv4.sysctl_tcp_rmem[2]);
 }
 
 /* 4. Try to fixup all. It is made immediately after connection enters
@@ -476,15 +479,16 @@ static void tcp_clamp_window(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct inet_connection_sock *icsk = inet_csk(sk);
+	struct net *net = sock_net(sk);
 
 	icsk->icsk_ack.quick = 0;
 
-	if (sk->sk_rcvbuf < sysctl_tcp_rmem[2] &&
+	if (sk->sk_rcvbuf < net->ipv4.sysctl_tcp_rmem[2] &&
 	    !(sk->sk_userlocks & SOCK_RCVBUF_LOCK) &&
 	    !tcp_under_memory_pressure(sk) &&
 	    sk_memory_allocated(sk) < sk_prot_mem_limits(sk, 0)) {
 		sk->sk_rcvbuf = min(atomic_read(&sk->sk_rmem_alloc),
-				    sysctl_tcp_rmem[2]);
+				    net->ipv4.sysctl_tcp_rmem[2]);
 	}
 	if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
 		tp->rcv_ssthresh = min(tp->window_clamp, 2U * tp->advmss);
@@ -647,7 +651,8 @@ void tcp_rcv_space_adjust(struct sock *sk)
 			rcvmem += 128;
 
 		do_div(rcvwin, tp->advmss);
-		rcvbuf = min_t(u64, rcvwin * rcvmem, sysctl_tcp_rmem[2]);
+		rcvbuf = min_t(u64, rcvwin * rcvmem,
+			       sock_net(sk)->ipv4.sysctl_tcp_rmem[2]);
 		if (rcvbuf > sk->sk_rcvbuf) {
 			sk->sk_rcvbuf = rcvbuf;
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 31b34c0c2d5f..ae7409861b7d 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2428,8 +2428,8 @@ struct proto tcp_prot = {
 	.memory_allocated	= &tcp_memory_allocated,
 	.memory_pressure	= &tcp_memory_pressure,
 	.sysctl_mem		= sysctl_tcp_mem,
-	.sysctl_wmem		= sysctl_tcp_wmem,
-	.sysctl_rmem		= sysctl_tcp_rmem,
+	.sysctl_wmem_offset	= offsetof(struct net, ipv4.sysctl_tcp_wmem),
+	.sysctl_rmem_offset	= offsetof(struct net, ipv4.sysctl_tcp_rmem),
 	.max_header		= MAX_TCP_HEADER,
 	.obj_size		= sizeof(struct tcp_sock),
 	.slab_flags		= SLAB_TYPESAFE_BY_RCU,
@@ -2509,6 +2509,14 @@ static int __net_init tcp_sk_init(struct net *net)
 	net->ipv4.sysctl_tcp_sack = 1;
 	net->ipv4.sysctl_tcp_window_scaling = 1;
 	net->ipv4.sysctl_tcp_timestamps = 1;
+	if (net != &init_net) {
+		memcpy(net->ipv4.sysctl_tcp_rmem,
+		       init_net.ipv4.sysctl_tcp_rmem,
+		       sizeof(init_net.ipv4.sysctl_tcp_rmem));
+		memcpy(net->ipv4.sysctl_tcp_wmem,
+		       init_net.ipv4.sysctl_tcp_wmem,
+		       sizeof(init_net.ipv4.sysctl_tcp_wmem));
+	}
 
 	return 0;
 fail:
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 61584638dba7..e50139d51ed2 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -378,7 +378,7 @@ void tcp_openreq_init_rwin(struct request_sock *req,
 		full_space = rcv_wnd * mss;
 
 	/* tcp_full_space because it is guaranteed to be the first packet */
-	tcp_select_initial_window(full_space,
+	tcp_select_initial_window(sk_listener, full_space,
 		mss - (ireq->tstamp_ok ? TCPOLEN_TSTAMP_ALIGNED : 0),
 		&req->rsk_rcv_wnd,
 		&req->rsk_window_clamp,
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 24bad638c2ec..a87d44a80c7d 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -208,12 +208,13 @@ u32 tcp_default_init_rwnd(u32 mss)
  * be a multiple of mss if possible. We assume here that mss >= 1.
  * This MUST be enforced by all callers.
  */
-void tcp_select_initial_window(int __space, __u32 mss,
+void tcp_select_initial_window(const struct sock *sk, int __space, __u32 mss,
 			       __u32 *rcv_wnd, __u32 *window_clamp,
 			       int wscale_ok, __u8 *rcv_wscale,
 			       __u32 init_rcv_wnd)
 {
 	unsigned int space = (__space < 0 ? 0 : __space);
+	struct net *net = sock_net(sk);
 
 	/* If no clamp set the clamp to the max possible scaled window */
 	if (*window_clamp == 0)
@@ -240,7 +241,7 @@ void tcp_select_initial_window(int __space, __u32 mss,
 	(*rcv_wscale) = 0;
 	if (wscale_ok) {
 		/* Set window scaling on max possible window */
-		space = max_t(u32, space, sysctl_tcp_rmem[2]);
+		space = max_t(u32, space, net->ipv4.sysctl_tcp_rmem[2]);
 		space = max_t(u32, space, sysctl_rmem_max);
 		space = min_t(u32, space, *window_clamp);
 		while (space > U16_MAX && (*rcv_wscale) < TCP_MAX_WSCALE) {
@@ -3331,7 +3332,7 @@ static void tcp_connect_init(struct sock *sk)
 	if (rcv_wnd == 0)
 		rcv_wnd = dst_metric(dst, RTAX_INITRWND);
 
-	tcp_select_initial_window(tcp_full_space(sk),
+	tcp_select_initial_window(sk, tcp_full_space(sk),
 				  tp->advmss - (tp->rx_opt.ts_recent_stamp ? tp->tcp_header_len - sizeof(struct tcphdr) : 0),
 				  &tp->rcv_wnd,
 				  &tp->window_clamp,
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 4e7817abc0b9..e7a3a6b6cf56 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -244,7 +244,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	}
 
 	req->rsk_window_clamp = tp->window_clamp ? :dst_metric(dst, RTAX_WINDOW);
-	tcp_select_initial_window(tcp_full_space(sk), req->mss,
+	tcp_select_initial_window(sk, tcp_full_space(sk), req->mss,
 				  &req->rsk_rcv_wnd, &req->rsk_window_clamp,
 				  ireq->wscale_ok, &rcv_wscale,
 				  dst_metric(dst, RTAX_INITRWND));
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index ba8586aadffa..de89bcee62d7 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1940,8 +1940,8 @@ struct proto tcpv6_prot = {
 	.memory_pressure	= &tcp_memory_pressure,
 	.orphan_count		= &tcp_orphan_count,
 	.sysctl_mem		= sysctl_tcp_mem,
-	.sysctl_wmem		= sysctl_tcp_wmem,
-	.sysctl_rmem		= sysctl_tcp_rmem,
+	.sysctl_wmem_offset	= offsetof(struct net, ipv4.sysctl_tcp_wmem),
+	.sysctl_rmem_offset	= offsetof(struct net, ipv4.sysctl_tcp_rmem),
 	.max_header		= MAX_TCP_HEADER,
 	.obj_size		= sizeof(struct tcp6_sock),
 	.slab_flags		= SLAB_TYPESAFE_BY_RCU,
-- 
2.17.1

