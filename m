Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753266AbeE3LRK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:17:10 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:32841 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752607AbeE3LHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:09 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Paolo Abeni" <pabeni@redhat.com>,
        syzbot+a4c2dc980ac1af699b36@syzkaller.appspotmail.com,
        "Pablo Neira Ayuso" <pablo@netfilter.org>,
        "Florian Westphal" <fw@strlen.de>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.805379714@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 068/153] netfilter: on sockopt() acquire sock lock
 only in the required scope
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.2: Drop changes to ipv6_getorigdst()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1030,11 +1030,8 @@ int ip_setsockopt(struct sock *sk, int l
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
@@ -1059,12 +1056,9 @@ int compat_ip_setsockopt(struct sock *sk
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
@@ -258,15 +258,19 @@ getorigdst(struct sock *sk, int optval,
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
@@ -841,12 +841,8 @@ int ipv6_setsockopt(struct sock *sk, int
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
@@ -877,12 +873,9 @@ int compat_ipv6_setsockopt(struct sock *
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
