Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id VtiRNzlDGVvhBQAAmS7hNA
	; Thu, 07 Jun 2018 14:37:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CDDB76089E; Thu,  7 Jun 2018 14:37:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9C778601D2;
	Thu,  7 Jun 2018 14:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9C778601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934148AbeFGOhn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:37:43 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40446 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934059AbeFGOhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:37:39 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbk-0005Zm-3g; Thu, 07 Jun 2018 15:09:44 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb4-0002xw-Uz; Thu, 07 Jun 2018 15:09:02 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        syzbot+a4c2dc980ac1af699b36@syzkaller.appspotmail.com,
        "Pablo Neira Ayuso" <pablo@netfilter.org>,
        "Florian Westphal" <fw@strlen.de>,
        "Paolo Abeni" <pabeni@redhat.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.94336751@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 181/410] netfilter: on sockopt() acquire sock lock
 only in the required scope
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

commit 3f34cfae1238848fd53f25e5c8fd59da57901f4b upstream.

Syzbot reported several deadlocks in the netfilter area caused by
rtnl lock and socket lock being acquired with a different order on
different code paths, leading to backtraces like the following one:

======================================================
WARNING: possible circular locking dependency detected
4.15.0-rc9+ #212 Not tainted
------------------------------------------------------
syzkaller041579/3682 is trying to acquire lock:
  (sk_lock-AF_INET6){+.+.}, at: [<000000008775e4dd>] lock_sock
include/net/sock.h:1463 [inline]
  (sk_lock-AF_INET6){+.+.}, at: [<000000008775e4dd>]
do_ipv6_setsockopt.isra.8+0x3c5/0x39d0 net/ipv6/ipv6_sockglue.c:167

but task is already holding lock:
  (rtnl_mutex){+.+.}, at: [<000000004342eaa9>] rtnl_lock+0x17/0x20
net/core/rtnetlink.c:74

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (rtnl_mutex){+.+.}:
        __mutex_lock_common kernel/locking/mutex.c:756 [inline]
        __mutex_lock+0x16f/0x1a80 kernel/locking/mutex.c:893
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
        rtnl_lock+0x17/0x20 net/core/rtnetlink.c:74
        register_netdevice_notifier+0xad/0x860 net/core/dev.c:1607
        tee_tg_check+0x1a0/0x280 net/netfilter/xt_TEE.c:106
        xt_check_target+0x22c/0x7d0 net/netfilter/x_tables.c:845
        check_target net/ipv6/netfilter/ip6_tables.c:538 [inline]
        find_check_entry.isra.7+0x935/0xcf0
net/ipv6/netfilter/ip6_tables.c:580
        translate_table+0xf52/0x1690 net/ipv6/netfilter/ip6_tables.c:749
        do_replace net/ipv6/netfilter/ip6_tables.c:1165 [inline]
        do_ip6t_set_ctl+0x370/0x5f0 net/ipv6/netfilter/ip6_tables.c:1691
        nf_sockopt net/netfilter/nf_sockopt.c:106 [inline]
        nf_setsockopt+0x67/0xc0 net/netfilter/nf_sockopt.c:115
        ipv6_setsockopt+0x115/0x150 net/ipv6/ipv6_sockglue.c:928
        udpv6_setsockopt+0x45/0x80 net/ipv6/udp.c:1422
        sock_common_setsockopt+0x95/0xd0 net/core/sock.c:2978
        SYSC_setsockopt net/socket.c:1849 [inline]
        SyS_setsockopt+0x189/0x360 net/socket.c:1828
        entry_SYSCALL_64_fastpath+0x29/0xa0

-> #0 (sk_lock-AF_INET6){+.+.}:
        lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:3914
        lock_sock_nested+0xc2/0x110 net/core/sock.c:2780
        lock_sock include/net/sock.h:1463 [inline]
        do_ipv6_setsockopt.isra.8+0x3c5/0x39d0 net/ipv6/ipv6_sockglue.c:167
        ipv6_setsockopt+0xd7/0x150 net/ipv6/ipv6_sockglue.c:922
        udpv6_setsockopt+0x45/0x80 net/ipv6/udp.c:1422
        sock_common_setsockopt+0x95/0xd0 net/core/sock.c:2978
        SYSC_setsockopt net/socket.c:1849 [inline]
        SyS_setsockopt+0x189/0x360 net/socket.c:1828
        entry_SYSCALL_64_fastpath+0x29/0xa0

other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(rtnl_mutex);
                                lock(sk_lock-AF_INET6);
                                lock(rtnl_mutex);
   lock(sk_lock-AF_INET6);

  *** DEADLOCK ***

1 lock held by syzkaller041579/3682:
  #0:  (rtnl_mutex){+.+.}, at: [<000000004342eaa9>] rtnl_lock+0x17/0x20
net/core/rtnetlink.c:74

The problem, as Florian noted, is that nf_setsockopt() is always
called with the socket held, even if the lock itself is required only
for very tight scopes and only for some operation.

This patch addresses the issues moving the lock_sock() call only
where really needed, namely in ipv*_getorigdst(), so that nf_setsockopt()
does not need anymore to acquire both locks.

Fixes: 22265a5c3c10 ("netfilter: xt_TEE: resolve oif using netdevice notifiers")
Reported-by: syzbot+a4c2dc980ac1af699b36@syzkaller.appspotmail.com
Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv4/ip_sockglue.c                         | 14 ++++----------
 net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c |  6 +++++-
 net/ipv6/ipv6_sockglue.c                       | 17 +++++------------
 net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.c | 18 ++++++++++++------
 4 files changed, 26 insertions(+), 29 deletions(-)

--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1106,11 +1106,8 @@ int ip_setsockopt(struct sock *sk, int l
 	if (err == -ENOPROTOOPT && optname != IP_HDRINCL &&
 			optname != IP_IPSEC_POLICY &&
 			optname != IP_XFRM_POLICY &&
-			!ip_mroute_opt(optname)) {
-		lock_sock(sk);
+			!ip_mroute_opt(optname))
 		err = nf_setsockopt(sk, PF_INET, optname, optval, optlen);
-		release_sock(sk);
-	}
 #endif
 	return err;
 }
@@ -1135,12 +1132,9 @@ int compat_ip_setsockopt(struct sock *sk
 	if (err == -ENOPROTOOPT && optname != IP_HDRINCL &&
 			optname != IP_IPSEC_POLICY &&
 			optname != IP_XFRM_POLICY &&
-			!ip_mroute_opt(optname)) {
-		lock_sock(sk);
-		err = compat_nf_setsockopt(sk, PF_INET, optname,
-					   optval, optlen);
-		release_sock(sk);
-	}
+			!ip_mroute_opt(optname))
+		err = compat_nf_setsockopt(sk, PF_INET, optname, optval,
+					   optlen);
 #endif
 	return err;
 }
--- a/net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c
+++ b/net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c
@@ -269,15 +269,19 @@ getorigdst(struct sock *sk, int optval,
 	struct nf_conntrack_tuple tuple;
 
 	memset(&tuple, 0, sizeof(tuple));
+
+	lock_sock(sk);
 	tuple.src.u3.ip = inet->inet_rcv_saddr;
 	tuple.src.u.tcp.port = inet->inet_sport;
 	tuple.dst.u3.ip = inet->inet_daddr;
 	tuple.dst.u.tcp.port = inet->inet_dport;
 	tuple.src.l3num = PF_INET;
 	tuple.dst.protonum = sk->sk_protocol;
+	release_sock(sk);
 
 	/* We only do TCP and SCTP at the moment: is there a better way? */
-	if (sk->sk_protocol != IPPROTO_TCP && sk->sk_protocol != IPPROTO_SCTP) {
+	if (tuple.dst.protonum != IPPROTO_TCP &&
+	    tuple.dst.protonum != IPPROTO_SCTP) {
 		pr_debug("SO_ORIGINAL_DST: Not a TCP/SCTP socket\n");
 		return -ENOPROTOOPT;
 	}
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -871,12 +871,8 @@ int ipv6_setsockopt(struct sock *sk, int
 #ifdef CONFIG_NETFILTER
 	/* we need to exclude all possible ENOPROTOOPTs except default case */
 	if (err == -ENOPROTOOPT && optname != IPV6_IPSEC_POLICY &&
-			optname != IPV6_XFRM_POLICY) {
-		lock_sock(sk);
-		err = nf_setsockopt(sk, PF_INET6, optname, optval,
-				optlen);
-		release_sock(sk);
-	}
+			optname != IPV6_XFRM_POLICY)
+		err = nf_setsockopt(sk, PF_INET6, optname, optval, optlen);
 #endif
 	return err;
 }
@@ -907,12 +903,9 @@ int compat_ipv6_setsockopt(struct sock *
 #ifdef CONFIG_NETFILTER
 	/* we need to exclude all possible ENOPROTOOPTs except default case */
 	if (err == -ENOPROTOOPT && optname != IPV6_IPSEC_POLICY &&
-	    optname != IPV6_XFRM_POLICY) {
-		lock_sock(sk);
-		err = compat_nf_setsockopt(sk, PF_INET6, optname,
-					   optval, optlen);
-		release_sock(sk);
-	}
+	    optname != IPV6_XFRM_POLICY)
+		err = compat_nf_setsockopt(sk, PF_INET6, optname, optval,
+					   optlen);
 #endif
 	return err;
 }
--- a/net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.c
+++ b/net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.c
@@ -240,20 +240,27 @@ static struct nf_hook_ops ipv6_conntrack
 static int
 ipv6_getorigdst(struct sock *sk, int optval, void __user *user, int *len)
 {
-	const struct inet_sock *inet = inet_sk(sk);
+	struct nf_conntrack_tuple tuple = { .src.l3num = NFPROTO_IPV6 };
 	const struct ipv6_pinfo *inet6 = inet6_sk(sk);
+	const struct inet_sock *inet = inet_sk(sk);
 	const struct nf_conntrack_tuple_hash *h;
 	struct sockaddr_in6 sin6;
-	struct nf_conntrack_tuple tuple = { .src.l3num = NFPROTO_IPV6 };
 	struct nf_conn *ct;
+	__be32 flow_label;
+	int bound_dev_if;
 
+	lock_sock(sk);
 	tuple.src.u3.in6 = sk->sk_v6_rcv_saddr;
 	tuple.src.u.tcp.port = inet->inet_sport;
 	tuple.dst.u3.in6 = sk->sk_v6_daddr;
 	tuple.dst.u.tcp.port = inet->inet_dport;
 	tuple.dst.protonum = sk->sk_protocol;
+	bound_dev_if = sk->sk_bound_dev_if;
+	flow_label = inet6->flow_label;
+	release_sock(sk);
 
-	if (sk->sk_protocol != IPPROTO_TCP && sk->sk_protocol != IPPROTO_SCTP)
+	if (tuple.dst.protonum != IPPROTO_TCP &&
+	    tuple.dst.protonum != IPPROTO_SCTP)
 		return -ENOPROTOOPT;
 
 	if (*len < 0 || (unsigned int) *len < sizeof(sin6))
@@ -271,14 +278,13 @@ ipv6_getorigdst(struct sock *sk, int opt
 
 	sin6.sin6_family = AF_INET6;
 	sin6.sin6_port = ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.dst.u.tcp.port;
-	sin6.sin6_flowinfo = inet6->flow_label & IPV6_FLOWINFO_MASK;
+	sin6.sin6_flowinfo = flow_label & IPV6_FLOWINFO_MASK;
 	memcpy(&sin6.sin6_addr,
 		&ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.dst.u3.in6,
 					sizeof(sin6.sin6_addr));
 
 	nf_ct_put(ct);
-	sin6.sin6_scope_id = ipv6_iface_scope_id(&sin6.sin6_addr,
-						 sk->sk_bound_dev_if);
+	sin6.sin6_scope_id = ipv6_iface_scope_id(&sin6.sin6_addr, bound_dev_if);
 	return copy_to_user(user, &sin6, sizeof(sin6)) ? -EFAULT : 0;
 }
 
