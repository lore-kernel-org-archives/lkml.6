Return-Path: <nautsch2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523444570; cv=none;
        d=google.com; s=arc-20160816;
        b=JuvkkKK0D3cx3yW6wMDjbrVeuZwF++DW/K8NMWhzo0emCgfc4T4dMfbSsJpFj3DUwp
         qCESSK9/WOhzRNWq9z9E7CmJ/UNpgDmo4E4G1K0QVs+AEixrLn4+8t5SKfmZOVR3zIcw
         bj2x74J84wEJ6n1eejj1n6DwCrfcyqUCWlxSzfT8xa1A2Nke+Jt01yqWLiGQqKqE75Iw
         qZ49KO0jRMigQ6RVDqjEmWPkLeFGKyoTTQoXSSizUUFXqNj7mFB8vBG4qi22zhOuVpos
         tDZJc6dJY6wwZgusIlk2H2NKR6KXsBhh1zDAr49pQF6llLC4dUNjH39Ya3DgrqYXrStz
         c4qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:to:dkim-signature
         :arc-authentication-results;
        bh=zuEyFsibXJc7YOP1A65vpobqYcepSYKKzuhg6X3jZnM=;
        b=z1wecu/quEIxrHQ6vbGMl33r+PKi9LvY/VNc3w9/IGp8u1DEROPQaYzwBGcwBaAL7Q
         pKZiSG3oCspwmE/4tZNhnMM/hNFkMY04oHoJ4fF/rVCG7mpUHtktT6MXCKA1JDwDzLUl
         wsXSOBikIyZX+pAQAj9J/7tko37pV3pGh6gZMRlwnxTAeUevuxCGrZZNp+YymkMYPLHz
         Cy7syhDy8FUytX3xO0ND7QmbgA9Ft1Y4b2KmB+30xOVKUpFMPVYL9ZGD/SPUQhZM2uZe
         Kn7wEsVInLSkXJ4DhDNhkFklQ1/9L8oJvPNCifAif2AgLb8XJyBajLdlQ1gO2bR1IqxV
         ei5w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HtLc+ddt;
       spf=pass (google.com: domain of nautsch2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=nautsch2@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HtLc+ddt;
       spf=pass (google.com: domain of nautsch2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=nautsch2@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+C/MyLa6FTE4RitFpuV4G5xV2iExBHkVipqU1L5Avi0TSl4ubd2Mvm0JZ9oX8P0XJ1w8YZ+A==
To: "David S. Miller" <davem@davemloft.net>,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, David Ahern
 <dsahern@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andre Naujoks <nautsch2@gmail.com>, =?UTF-8?Q?Maciej_=c5=bbenczykowski?=
 <maze@google.com>, Shaohua Li <shli@fb.com>, Paolo Abeni
 <pabeni@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
From: Andre Naujoks <nautsch2@gmail.com>
Subject: [RFC/PATCH] Add a socketoption IPV6_MULTICAST_ALL analogue to the
 IPV4 version
Message-ID: <b49554c1-f988-b80f-30eb-9472f1f595b4@gmail.com>
Date: Wed, 11 Apr 2018 13:02:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597447414006786054?=
X-GMAIL-MSGID: =?utf-8?q?1597447414006786054?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi.

I was running into a problem, when trying to join multiple multicast groups
on a single socket and thus binding to the any-address on said socket. I
received traffic from multicast groups, I did not join on that socket and
was at first surprised by that. After reading some old e-mails/threads,
which came to the conclusion "It is, as it is."
(e.g https://marc.info/?l=linux-kernel&m=115815686626791&w=2), I discovered
the IPv4 socketoption IP_MULTICAST_ALL, which, when disabled, does exactly
what I would expect from a socket by default.

I propose a socket option for IPv6, which does the same and has the same
default as the IPv4 version. My first thought was, to just apply
IP_MULTICAST_ALL to a ipv6 socket, but that would change the behavior of
current applications and would probably be a big no-no.

Regards
  Andre


>From 473653086c05a3de839c3504885053f6254c7bc5 Mon Sep 17 00:00:00 2001
From: Andre Naujoks <nautsch2@gmail.com>
Date: Wed, 11 Apr 2018 12:38:28 +0200
Subject: [PATCH] Add a socketoption IPV6_MULTICAST_ALL analogue to the IPV4
 version

The socket option will be enabled by default to ensure current behaviour
is not changed. This is the same for the IPv4 version.

A socket bound to in6addr_any and a specific port will receive all traffic
on that port. Analogue to IP_MULTICAST_ALL, disable this behaviour, if
one or more multicast groups were joined (using said socket) and only
pass on multicast traffic from groups, which were explicitly joined via
this socket.

Without this option disabled a socket (system even) joined to multiple
multicast groups is very hard to get right. Filtering by destination
address has to take place in user space to avoid receiving multicast
traffic from other multicast groups, which might have traffic on the same
port.

The extension of the IP_MULTICAST_ALL socketoption to just apply to ipv6,
too, is not done to avoid changing the behaviour of current applications.

Signed-off-by: Andre Naujoks <nautsch2@gmail.com>
---
 include/linux/ipv6.h     |  3 ++-
 include/uapi/linux/in6.h |  1 +
 net/ipv6/af_inet6.c      |  1 +
 net/ipv6/ipv6_sockglue.c | 11 +++++++++++
 net/ipv6/mcast.c         |  2 +-
 5 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 8415bf1a9776..495e834c1367 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -274,7 +274,8 @@ struct ipv6_pinfo {
 						 */
 				dontfrag:1,
 				autoflowlabel:1,
-				autoflowlabel_set:1;
+				autoflowlabel_set:1,
+				mc_all:1;
 	__u8			min_hopcount;
 	__u8			tclass;
 	__be32			rcv_flowinfo;
diff --git a/include/uapi/linux/in6.h b/include/uapi/linux/in6.h
index ed291e55f024..71d82fe15b03 100644
--- a/include/uapi/linux/in6.h
+++ b/include/uapi/linux/in6.h
@@ -177,6 +177,7 @@ struct in6_flowlabel_req {
 #define IPV6_V6ONLY		26
 #define IPV6_JOIN_ANYCAST	27
 #define IPV6_LEAVE_ANYCAST	28
+#define IPV6_MULTICAST_ALL	29
 
 /* IPV6_MTU_DISCOVER values */
 #define IPV6_PMTUDISC_DONT		0
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 8da0b513f188..7844cd9d2f10 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -209,6 +209,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	np->hop_limit	= -1;
 	np->mcast_hops	= IPV6_DEFAULT_MCASTHOPS;
 	np->mc_loop	= 1;
+	np->mc_all	= 1;
 	np->pmtudisc	= IPV6_PMTUDISC_WANT;
 	np->repflow	= net->ipv6.sysctl.flowlabel_reflect;
 	sk->sk_ipv6only	= net->ipv6.sysctl.bindv6only;
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 4d780c7f0130..b2bc1942a2ee 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -664,6 +664,13 @@ static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 			retv = ipv6_sock_ac_drop(sk, mreq.ipv6mr_ifindex, &mreq.ipv6mr_acaddr);
 		break;
 	}
+	case IPV6_MULTICAST_ALL:
+		if (optlen < sizeof(int))
+			goto e_inval;
+		np->mc_all = valbool;
+		retv = 0;
+		break;
+
 	case MCAST_JOIN_GROUP:
 	case MCAST_LEAVE_GROUP:
 	{
@@ -1255,6 +1262,10 @@ static int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		val = np->mcast_oif;
 		break;
 
+	case IPV6_MULTICAST_ALL:
+		val = np->mc_all;
+		break;
+
 	case IPV6_UNICAST_IF:
 		val = (__force int)htonl((__u32) np->ucast_oif);
 		break;
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 793159d77d8a..623ad00eb3c2 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -622,7 +622,7 @@ bool inet6_mc_check(struct sock *sk, const struct in6_addr *mc_addr,
 	}
 	if (!mc) {
 		rcu_read_unlock();
-		return true;
+		return np->mc_all;
 	}
 	read_lock(&mc->sflock);
 	psl = mc->sflist;
-- 
2.17.0
