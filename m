Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2AAC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006042075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276809;
	bh=iUjzIbvDqiUPUu6N1gJJpZ7Vm0h3G46a1gAyMDsab3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aX3mIpVam7EtKYh2Q1GMIWV7gjmpv69Kuo0p0njUceHIwRPyC76R3PdsWh3Kn8cNd
	 fxmEdfSy7HhmFRkGQr3rY5+cxF3ImNOmGq9MGRserZ+1JLcRIEvUA+QpXRFSKmAGLE
	 HqZKeNRjYraUTPcQdvCxw+2aQTuSU7HNaCqXAGEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfBDKkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:40:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:38054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729167AbfBDKkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:40:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41B942070C;
        Mon,  4 Feb 2019 10:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276803;
        bh=iUjzIbvDqiUPUu6N1gJJpZ7Vm0h3G46a1gAyMDsab3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C0yyKH8sXHnuN6vO46YJUHvvamOYSWL7dhRNItpzYUJSbK2utKHHY3C7ul1SfuGMH
         rl/5OGwafL97G1N0a7DuIhW5GIgONbXOmGgERO1+Yxa9Vu7aIjsHoIoflCDUvJ9NVx
         7gV/T7H8wqZrnTTPbwyZwkO8DrfHea6FbH+2d74M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 03/65] net: ipv4: Fix memory leak in network namespace dismantle
Date:   Mon,  4 Feb 2019 11:35:56 +0100
Message-Id: <20190204103611.151852346@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103610.583715954@linuxfoundation.org>
References: <20190204103610.583715954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit f97f4dd8b3bb9d0993d2491e0f22024c68109184 ]

IPv4 routing tables are flushed in two cases:

1. In response to events in the netdev and inetaddr notification chains
2. When a network namespace is being dismantled

In both cases only routes associated with a dead nexthop group are
flushed. However, a nexthop group will only be marked as dead in case it
is populated with actual nexthops using a nexthop device. This is not
the case when the route in question is an error route (e.g.,
'blackhole', 'unreachable').

Therefore, when a network namespace is being dismantled such routes are
not flushed and leaked [1].

To reproduce:
# ip netns add blue
# ip -n blue route add unreachable 192.0.2.0/24
# ip netns del blue

Fix this by not skipping error routes that are not marked with
RTNH_F_DEAD when flushing the routing tables.

To prevent the flushing of such routes in case #1, add a parameter to
fib_table_flush() that indicates if the table is flushed as part of
namespace dismantle or not.

Note that this problem does not exist in IPv6 since error routes are
associated with the loopback device.

[1]
unreferenced object 0xffff888066650338 (size 56):
  comm "ip", pid 1206, jiffies 4294786063 (age 26.235s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 b0 1c 62 61 80 88 ff ff  ..........ba....
    e8 8b a1 64 80 88 ff ff 00 07 00 08 fe 00 00 00  ...d............
  backtrace:
    [<00000000856ed27d>] inet_rtm_newroute+0x129/0x220
    [<00000000fcdfc00a>] rtnetlink_rcv_msg+0x397/0xa20
    [<00000000cb85801a>] netlink_rcv_skb+0x132/0x380
    [<00000000ebc991d2>] netlink_unicast+0x4c0/0x690
    [<0000000014f62875>] netlink_sendmsg+0x929/0xe10
    [<00000000bac9d967>] sock_sendmsg+0xc8/0x110
    [<00000000223e6485>] ___sys_sendmsg+0x77a/0x8f0
    [<000000002e94f880>] __sys_sendmsg+0xf7/0x250
    [<00000000ccb1fa72>] do_syscall_64+0x14d/0x610
    [<00000000ffbe3dae>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
    [<000000003a8b605b>] 0xffffffffffffffff
unreferenced object 0xffff888061621c88 (size 48):
  comm "ip", pid 1206, jiffies 4294786063 (age 26.235s)
  hex dump (first 32 bytes):
    6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
    6b 6b 6b 6b 6b 6b 6b 6b d8 8e 26 5f 80 88 ff ff  kkkkkkkk..&_....
  backtrace:
    [<00000000733609e3>] fib_table_insert+0x978/0x1500
    [<00000000856ed27d>] inet_rtm_newroute+0x129/0x220
    [<00000000fcdfc00a>] rtnetlink_rcv_msg+0x397/0xa20
    [<00000000cb85801a>] netlink_rcv_skb+0x132/0x380
    [<00000000ebc991d2>] netlink_unicast+0x4c0/0x690
    [<0000000014f62875>] netlink_sendmsg+0x929/0xe10
    [<00000000bac9d967>] sock_sendmsg+0xc8/0x110
    [<00000000223e6485>] ___sys_sendmsg+0x77a/0x8f0
    [<000000002e94f880>] __sys_sendmsg+0xf7/0x250
    [<00000000ccb1fa72>] do_syscall_64+0x14d/0x610
    [<00000000ffbe3dae>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
    [<000000003a8b605b>] 0xffffffffffffffff

Fixes: 8cced9eff1d4 ("[NETNS]: Enable routing configuration in non-initial namespace.")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/ip_fib.h    |    2 +-
 net/ipv4/fib_frontend.c |    4 ++--
 net/ipv4/fib_trie.c     |   14 ++++++++++++--
 3 files changed, 15 insertions(+), 5 deletions(-)

--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -200,7 +200,7 @@ int fib_table_insert(struct fib_table *,
 int fib_table_delete(struct fib_table *, struct fib_config *);
 int fib_table_dump(struct fib_table *table, struct sk_buff *skb,
 		   struct netlink_callback *cb);
-int fib_table_flush(struct fib_table *table);
+int fib_table_flush(struct fib_table *table, bool flush_all);
 struct fib_table *fib_trie_unmerge(struct fib_table *main_tb);
 void fib_table_flush_external(struct fib_table *table);
 void fib_free_table(struct fib_table *tb);
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -187,7 +187,7 @@ static void fib_flush(struct net *net)
 		struct fib_table *tb;
 
 		hlist_for_each_entry_safe(tb, tmp, head, tb_hlist)
-			flushed += fib_table_flush(tb);
+			flushed += fib_table_flush(tb, false);
 	}
 
 	if (flushed)
@@ -1277,7 +1277,7 @@ static void ip_fib_net_exit(struct net *
 
 		hlist_for_each_entry_safe(tb, tmp, head, tb_hlist) {
 			hlist_del(&tb->tb_hlist);
-			fib_table_flush(tb);
+			fib_table_flush(tb, true);
 			fib_free_table(tb);
 		}
 	}
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -1806,7 +1806,7 @@ void fib_table_flush_external(struct fib
 }
 
 /* Caller must hold RTNL. */
-int fib_table_flush(struct fib_table *tb)
+int fib_table_flush(struct fib_table *tb, bool flush_all)
 {
 	struct trie *t = (struct trie *)tb->tb_data;
 	struct key_vector *pn = t->kv;
@@ -1850,7 +1850,17 @@ int fib_table_flush(struct fib_table *tb
 		hlist_for_each_entry_safe(fa, tmp, &n->leaf, fa_list) {
 			struct fib_info *fi = fa->fa_info;
 
-			if (!fi || !(fi->fib_flags & RTNH_F_DEAD)) {
+			if (!fi ||
+			    (!(fi->fib_flags & RTNH_F_DEAD) &&
+			     !fib_props[fa->fa_type].error)) {
+				slen = fa->fa_slen;
+				continue;
+			}
+
+			/* Do not flush error routes if network namespace is
+			 * not being dismantled
+			 */
+			if (!flush_all && fib_props[fa->fa_type].error) {
 				slen = fa->fa_slen;
 				continue;
 			}


