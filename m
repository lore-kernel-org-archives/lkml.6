Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv8UmIIrkfnHR+NXb9/20PopxDZQJvHewwNZvXnQDtPBerEIolBJ0R4dtuYb9Qh8mRtGdLt
ARC-Seal: i=1; a=rsa-sha256; t=1519412247; cv=none;
        d=google.com; s=arc-20160816;
        b=ltggsfv5glT2zXQpQ/8HFLfc/vps0EYB56szsdP95BCgXFiKEJkW7e5hNTO+WSE5St
         XF8PBTAKxdntQJjmfvjj0KnfgX7Bu1ka4791di+HPXHo7itJeIPRPDLkkxQwl5xZAM1w
         7xVK2ExtCW3WZhK4wVknlDU0Coq00gcAjbWVPBaw82ve8S0Mo2CdrQkhRpXMSzq6r0w5
         4xAimSQc7FiqLgkL94Y7H3D4zsXw+89GcEZi7lujMbgm+Fd7nUR8cHFyX9SDKH4rUGCg
         LP9DMY4Fpk4Lq/pMW5adAZ58h7vONYW+0F/iEWhlEFcCCddLA57DkwoaaAa5+rZFQYGd
         Jxlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fBIO8Gc75Kmz/mt8TIrYpFkZWy5c77KnMp/Zm1GldWQ=;
        b=ZhSBw6JjRqvRiKe13F7bFuzSUC0dplcWMFVuzSDQlbfVj1o2zyhkPNs9dkE7aFxVRi
         ORzSkVaOv1g4W4/YE68mMuOxYVOueCPefFue20b78KgjuUiWx2cEnkvc9itjngFIR0Ek
         LxdPmOd0UP71DLCRvRSaT61+vwBn/PPYJCp0N1Exm3aMUcTIJYrp/R6xlGj+7hI0uYfX
         9ZRxr9meSDGvY3zUWPm+EKIZbPxDlfF6PJcQyr104B2F4ZnJP1koDEIvQ0kOFugygVTO
         nZvLv6z5bLcoth559fO3tUHEMNA62fvmrOLnUtOyQxcXrBPYOA3MKevg1MHWhfbCB1+X
         dDQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+a4c2dc980ac1af699b36@syzkaller.appspotmail.com,
	Florian Westphal <fw@strlen.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.15 16/45] netfilter: on sockopt() acquire sock lock only in the required scope
Date: Fri, 23 Feb 2018 19:28:55 +0100
Message-Id: <20180223170717.905934336@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217543770768506?=
X-GMAIL-MSGID: =?utf-8?q?1593219217118024677?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/ip_sockglue.c                         |   14 ++++----------
 net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c |    6 +++++-
 net/ipv6/ipv6_sockglue.c                       |   17 +++++------------
 net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.c |   18 ++++++++++++------
 4 files changed, 26 insertions(+), 29 deletions(-)

--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1251,11 +1251,8 @@ int ip_setsockopt(struct sock *sk, int l
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
@@ -1280,12 +1277,9 @@ int compat_ip_setsockopt(struct sock *sk
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
@@ -218,15 +218,19 @@ getorigdst(struct sock *sk, int optval,
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
@@ -923,12 +923,8 @@ int ipv6_setsockopt(struct sock *sk, int
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
@@ -958,12 +954,9 @@ int compat_ipv6_setsockopt(struct sock *
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
@@ -226,20 +226,27 @@ static const struct nf_hook_ops ipv6_con
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
@@ -257,14 +264,13 @@ ipv6_getorigdst(struct sock *sk, int opt
 
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
 
