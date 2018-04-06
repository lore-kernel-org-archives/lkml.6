Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49C7z2tnjn+XGflgnM/T81GXOiV4fYzMubGZXF15UfAFYQh3IhfbKekGFya2mXILts7QPoG
ARC-Seal: i=1; a=rsa-sha256; t=1523021917; cv=none;
        d=google.com; s=arc-20160816;
        b=HQihE5EIojnxUHSy/qRj05hHK/vp3ghyGzKrTC2PTziFMJz6h2k4lFrl1EiGWIRlX8
         eAaJiA+luDEudXo+T97MkzyTu7AaYm13J2lyq0VynKIbawMDycRj0+G1MwpiTZ6JiDK4
         HiCs3n3Qb9ZDCkYFehv1DjGKvlz5XH8xok5BB20HdHIJVXlzoWfZzOQNT8EUN1Cxecwy
         lp4f2+j2Mf0UZa1V73tFGRgObj26ff8FoCpmxc1GJmxyOuD9f77gkMxIW1d1Wl5rQA/U
         bBGei7LG6jnUwFG9SVTmn3IqN11N1+rpgfs5LFkvqBKXu9kkMEGW4t+mI7YqQqsiKgNT
         aGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GtgN52UC6wvHahfAIpLVQZ8slopGrRkTU4bOmWCVTDA=;
        b=jy7R1NzjvwhZEd6NJU2yYQV+03eoE0NdEjWTaey87/xEYPy4xFUVJRWJ8xqakm5Sj9
         D3M/3AUz/ka42sIIAZYwJ5sITW78k9ZpKgptAPkHNNCpu3Hts/do1bH0BXX83ouALY5C
         Zc+Mmn7EPlzKEoAm5To3KvRHSh1n2ZPxRBN/UB/S0Zgwbwwhrbdhtj+gxByt3GF9+2jN
         GDQdX1N2q5ZaE5INAgfCzJ9oVegQ1Y9TgIhLTFDvbd1xfgrWn4ul4Tevw6c3NNQzLtML
         x77WHqr+YkvsE0SUz8cHYqICD/lXwbxh/mPs5wyfXHg1fvt9cJ3xWijKLOugj2rJqwJ7
         fIsw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 31/67] l2tp: fix races with ipv4-mapped ipv6 addresses
Date: Fri,  6 Apr 2018 15:24:01 +0200
Message-Id: <20180406084345.455656043@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004230645835593?=
X-GMAIL-MSGID: =?utf-8?q?1597004230645835593?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

commit b954f94023dcc61388c8384f0f14eb8e42c863c5 upstream.

The l2tp_tunnel_create() function checks for v4mapped ipv6
sockets and cache that flag, so that l2tp core code can
reusing it at xmit time.

If the socket is provided by the userspace, the connection
status of the tunnel sockets can change between the tunnel
creation and the xmit call, so that syzbot is able to
trigger the following splat:

BUG: KASAN: use-after-free in ip6_dst_idev include/net/ip6_fib.h:192
[inline]
BUG: KASAN: use-after-free in ip6_xmit+0x1f76/0x2260
net/ipv6/ip6_output.c:264
Read of size 8 at addr ffff8801bd949318 by task syz-executor4/23448

CPU: 0 PID: 23448 Comm: syz-executor4 Not tainted 4.16.0-rc4+ #65
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x194/0x24d lib/dump_stack.c:53
  print_address_description+0x73/0x250 mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report+0x23c/0x360 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  ip6_dst_idev include/net/ip6_fib.h:192 [inline]
  ip6_xmit+0x1f76/0x2260 net/ipv6/ip6_output.c:264
  inet6_csk_xmit+0x2fc/0x580 net/ipv6/inet6_connection_sock.c:139
  l2tp_xmit_core net/l2tp/l2tp_core.c:1053 [inline]
  l2tp_xmit_skb+0x105f/0x1410 net/l2tp/l2tp_core.c:1148
  pppol2tp_sendmsg+0x470/0x670 net/l2tp/l2tp_ppp.c:341
  sock_sendmsg_nosec net/socket.c:630 [inline]
  sock_sendmsg+0xca/0x110 net/socket.c:640
  ___sys_sendmsg+0x767/0x8b0 net/socket.c:2046
  __sys_sendmsg+0xe5/0x210 net/socket.c:2080
  SYSC_sendmsg net/socket.c:2091 [inline]
  SyS_sendmsg+0x2d/0x50 net/socket.c:2087
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x453e69
RSP: 002b:00007f819593cc68 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f819593d6d4 RCX: 0000000000453e69
RDX: 0000000000000081 RSI: 000000002037ffc8 RDI: 0000000000000004
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000004c3 R14: 00000000006f72e8 R15: 0000000000000000

This change addresses the issues:
* explicitly checking for TCP_ESTABLISHED for user space provided sockets
* dropping the v4mapped flag usage - it can become outdated - and
  explicitly invoking ipv6_addr_v4mapped() instead

The issue is apparently there since ancient times.

v1 -> v2: (many thanks to Guillaume)
 - with csum issue introduced in v1
 - replace pr_err with pr_debug
 - fix build issue with IPV6 disabled
 - move l2tp_sk_is_v4mapped in l2tp_core.c

v2 -> v3:
 - don't update inet_daddr for v4mapped address, unneeded
 - drop rendundant check at creation time

Reported-and-tested-by: syzbot+92fa328176eb07e4ac1a@syzkaller.appspotmail.com
Fixes: 3557baabf280 ("[L2TP]: PPP over L2TP driver core")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/l2tp/l2tp_core.c |   38 ++++++++++++++++++--------------------
 net/l2tp/l2tp_core.h |    3 ---
 2 files changed, 18 insertions(+), 23 deletions(-)

--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -113,6 +113,13 @@ struct l2tp_net {
 	spinlock_t l2tp_session_hlist_lock;
 };
 
+#if IS_ENABLED(CONFIG_IPV6)
+static bool l2tp_sk_is_v6(struct sock *sk)
+{
+	return sk->sk_family == PF_INET6 &&
+	       !ipv6_addr_v4mapped(&sk->sk_v6_daddr);
+}
+#endif
 
 static inline struct l2tp_tunnel *l2tp_tunnel(struct sock *sk)
 {
@@ -1130,7 +1137,7 @@ static int l2tp_xmit_core(struct l2tp_se
 	/* Queue the packet to IP for output */
 	skb->ignore_df = 1;
 #if IS_ENABLED(CONFIG_IPV6)
-	if (tunnel->sock->sk_family == PF_INET6 && !tunnel->v4mapped)
+	if (l2tp_sk_is_v6(tunnel->sock))
 		error = inet6_csk_xmit(tunnel->sock, skb, NULL);
 	else
 #endif
@@ -1193,6 +1200,15 @@ int l2tp_xmit_skb(struct l2tp_session *s
 		goto out_unlock;
 	}
 
+	/* The user-space may change the connection status for the user-space
+	 * provided socket at run time: we must check it under the socket lock
+	 */
+	if (tunnel->fd >= 0 && sk->sk_state != TCP_ESTABLISHED) {
+		kfree_skb(skb);
+		ret = NET_XMIT_DROP;
+		goto out_unlock;
+	}
+
 	/* Get routing info from the tunnel socket */
 	skb_dst_drop(skb);
 	skb_dst_set(skb, dst_clone(__sk_dst_check(sk, 0)));
@@ -1212,7 +1228,7 @@ int l2tp_xmit_skb(struct l2tp_session *s
 
 		/* Calculate UDP checksum if configured to do so */
 #if IS_ENABLED(CONFIG_IPV6)
-		if (sk->sk_family == PF_INET6 && !tunnel->v4mapped)
+		if (l2tp_sk_is_v6(sk))
 			udp6_set_csum(udp_get_no_check6_tx(sk),
 				      skb, &inet6_sk(sk)->saddr,
 				      &sk->sk_v6_daddr, udp_len);
@@ -1616,24 +1632,6 @@ int l2tp_tunnel_create(struct net *net,
 	if (cfg != NULL)
 		tunnel->debug = cfg->debug;
 
-#if IS_ENABLED(CONFIG_IPV6)
-	if (sk->sk_family == PF_INET6) {
-		struct ipv6_pinfo *np = inet6_sk(sk);
-
-		if (ipv6_addr_v4mapped(&np->saddr) &&
-		    ipv6_addr_v4mapped(&sk->sk_v6_daddr)) {
-			struct inet_sock *inet = inet_sk(sk);
-
-			tunnel->v4mapped = true;
-			inet->inet_saddr = np->saddr.s6_addr32[3];
-			inet->inet_rcv_saddr = sk->sk_v6_rcv_saddr.s6_addr32[3];
-			inet->inet_daddr = sk->sk_v6_daddr.s6_addr32[3];
-		} else {
-			tunnel->v4mapped = false;
-		}
-	}
-#endif
-
 	/* Mark socket as an encapsulation socket. See net/ipv4/udp.c */
 	tunnel->encap = encap;
 	if (encap == L2TP_ENCAPTYPE_UDP) {
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -195,9 +195,6 @@ struct l2tp_tunnel {
 	struct sock		*sock;		/* Parent socket */
 	int			fd;		/* Parent fd, if tunnel socket
 						 * was created by userspace */
-#if IS_ENABLED(CONFIG_IPV6)
-	bool			v4mapped;
-#endif
 
 	struct work_struct	del_work;
 
