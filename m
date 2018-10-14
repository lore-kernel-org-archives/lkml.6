Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4006CC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB99420645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB99420645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeJNXkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:40:52 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35901 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727427AbeJNXLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:50 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLd-0004cI-4Q; Sun, 14 Oct 2018 16:30:29 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLa-0000k5-Oe; Sun, 14 Oct 2018 16:30:26 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Julian Anastasov" <ja@ssi.bg>,
        "Simon Horman" <horms+renesas@verge.net.au>,
        "Pablo Neira Ayuso" <pablo@netfilter.org>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.925128461@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 343/366] ipvs: fix buffer overflow with sync daemon
 and service
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Anastasov <ja@ssi.bg>

commit 52f96757905bbf0edef47f3ee6c7c784e7f8ff8a upstream.

syzkaller reports for buffer overflow for interface name
when starting sync daemons [1]

What we do is that we copy user structure into larger stack
buffer but later we search NUL past the stack buffer.
The same happens for sched_name when adding/editing virtual server.

We are restricted by IP_VS_SCHEDNAME_MAXLEN and IP_VS_IFNAME_MAXLEN
being used as size in include/uapi/linux/ip_vs.h, so they
include the space for NUL.

As using strlcpy is wrong for unsafe source, replace it with
strscpy and add checks to return EINVAL if source string is not
NUL-terminated. The incomplete strlcpy fix comes from 2.6.13.

For the netlink interface reduce the len parameter for
IPVS_DAEMON_ATTR_MCAST_IFN and IPVS_SVC_ATTR_SCHED_NAME,
so that we get proper EINVAL.

[1]
kernel BUG at lib/string.c:1052!
invalid opcode: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 1 PID: 373 Comm: syz-executor936 Not tainted 4.17.0-rc4+ #45
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 01/01/2011
RIP: 0010:fortify_panic+0x13/0x20 lib/string.c:1051
RSP: 0018:ffff8801c976f800 EFLAGS: 00010282
RAX: 0000000000000022 RBX: 0000000000000040 RCX: 0000000000000000
RDX: 0000000000000022 RSI: ffffffff8160f6f1 RDI: ffffed00392edef6
RBP: ffff8801c976f800 R08: ffff8801cf4c62c0 R09: ffffed003b5e4fb0
R10: ffffed003b5e4fb0 R11: ffff8801daf27d87 R12: ffff8801c976fa20
R13: ffff8801c976fae4 R14: ffff8801c976fae0 R15: 000000000000048b
FS:  00007fd99f75e700(0000) GS:ffff8801daf00000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200001c0 CR3: 00000001d6843000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  strlen include/linux/string.h:270 [inline]
  strlcpy include/linux/string.h:293 [inline]
  do_ip_vs_set_ctl+0x31c/0x1d00 net/netfilter/ipvs/ip_vs_ctl.c:2388
  nf_sockopt net/netfilter/nf_sockopt.c:106 [inline]
  nf_setsockopt+0x7d/0xd0 net/netfilter/nf_sockopt.c:115
  ip_setsockopt+0xd8/0xf0 net/ipv4/ip_sockglue.c:1253
  udp_setsockopt+0x62/0xa0 net/ipv4/udp.c:2487
  ipv6_setsockopt+0x149/0x170 net/ipv6/ipv6_sockglue.c:917
  tcp_setsockopt+0x93/0xe0 net/ipv4/tcp.c:3057
  sock_common_setsockopt+0x9a/0xe0 net/core/sock.c:3046
  __sys_setsockopt+0x1bd/0x390 net/socket.c:1903
  __do_sys_setsockopt net/socket.c:1914 [inline]
  __se_sys_setsockopt net/socket.c:1911 [inline]
  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1911
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x447369
RSP: 002b:00007fd99f75dda8 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00000000006e39e4 RCX: 0000000000447369
RDX: 000000000000048b RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000018 R09: 0000000000000000
R10: 00000000200001c0 R11: 0000000000000246 R12: 00000000006e39e0
R13: 75a1ff93f0896195 R14: 6f745f3168746576 R15: 0000000000000001
Code: 08 5b 41 5c 41 5d 41 5e 41 5f 5d c3 0f 0b 48 89 df e8 d2 8f 48 fa eb
de 55 48 89 fe 48 c7 c7 60 65 64 88 48 89 e5 e8 91 dd f3 f9 <0f> 0b 90 90
90 90 90 90 90 90 90 90 90 55 48 89 e5 41 57 41 56
RIP: fortify_panic+0x13/0x20 lib/string.c:1051 RSP: ffff8801c976f800

Reported-and-tested-by: syzbot+aac887f77319868646df@syzkaller.appspotmail.com
Fixes: e4ff67513096 ("ipvs: add sync_maxlen parameter for the sync daemon")
Fixes: 4da62fc70d7c ("[IPVS]: Fix for overflows")
Signed-off-by: Julian Anastasov <ja@ssi.bg>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
[bwh: Backported to 3.16: Interface name is copied in start_sync_thread(),
 not do_ip_vs_set_ctl()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -2417,12 +2417,19 @@ do_ip_vs_set_ctl(struct sock *sk, int cm
 		}
 	}
 
+	if ((cmd == IP_VS_SO_SET_ADD || cmd == IP_VS_SO_SET_EDIT) &&
+	    strnlen(usvc.sched_name, IP_VS_SCHEDNAME_MAXLEN) ==
+	    IP_VS_SCHEDNAME_MAXLEN) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	/* Check for valid protocol: TCP or UDP or SCTP, even for fwmark!=0 */
 	if (usvc.protocol != IPPROTO_TCP && usvc.protocol != IPPROTO_UDP &&
 	    usvc.protocol != IPPROTO_SCTP) {
-		pr_err("set_ctl: invalid protocol: %d %pI4:%d %s\n",
+		pr_err("set_ctl: invalid protocol: %d %pI4:%d\n",
 		       usvc.protocol, &usvc.addr.ip,
-		       ntohs(usvc.port), usvc.sched_name);
+		       ntohs(usvc.port));
 		ret = -EFAULT;
 		goto out_unlock;
 	}
@@ -2845,7 +2852,7 @@ static const struct nla_policy ip_vs_cmd
 static const struct nla_policy ip_vs_daemon_policy[IPVS_DAEMON_ATTR_MAX + 1] = {
 	[IPVS_DAEMON_ATTR_STATE]	= { .type = NLA_U32 },
 	[IPVS_DAEMON_ATTR_MCAST_IFN]	= { .type = NLA_NUL_STRING,
-					    .len = IP_VS_IFNAME_MAXLEN },
+					    .len = IP_VS_IFNAME_MAXLEN - 1 },
 	[IPVS_DAEMON_ATTR_SYNC_ID]	= { .type = NLA_U32 },
 };
 
@@ -2858,7 +2865,7 @@ static const struct nla_policy ip_vs_svc
 	[IPVS_SVC_ATTR_PORT]		= { .type = NLA_U16 },
 	[IPVS_SVC_ATTR_FWMARK]		= { .type = NLA_U32 },
 	[IPVS_SVC_ATTR_SCHED_NAME]	= { .type = NLA_NUL_STRING,
-					    .len = IP_VS_SCHEDNAME_MAXLEN },
+					    .len = IP_VS_SCHEDNAME_MAXLEN - 1 },
 	[IPVS_SVC_ATTR_PE_NAME]		= { .type = NLA_NUL_STRING,
 					    .len = IP_VS_PENAME_MAXLEN },
 	[IPVS_SVC_ATTR_FLAGS]		= { .type = NLA_BINARY,
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1738,8 +1738,9 @@ int start_sync_thread(struct net *net, i
 		if (ipvs->ms)
 			return -EEXIST;
 
-		strlcpy(ipvs->master_mcast_ifn, mcast_ifn,
-			sizeof(ipvs->master_mcast_ifn));
+		if (strscpy(ipvs->master_mcast_ifn, mcast_ifn,
+			    sizeof(ipvs->master_mcast_ifn)) <= 0)
+			return -EINVAL;
 		ipvs->master_syncid = syncid;
 		name = "ipvs-m:%d:%d";
 		threadfn = sync_thread_master;
@@ -1747,8 +1748,9 @@ int start_sync_thread(struct net *net, i
 		if (ipvs->backup_threads)
 			return -EEXIST;
 
-		strlcpy(ipvs->backup_mcast_ifn, mcast_ifn,
-			sizeof(ipvs->backup_mcast_ifn));
+		if (strscpy(ipvs->backup_mcast_ifn, mcast_ifn,
+			    sizeof(ipvs->backup_mcast_ifn)) <= 0)
+			return -EINVAL;
 		ipvs->backup_syncid = syncid;
 		name = "ipvs-b:%d:%d";
 		threadfn = sync_thread_backup;

