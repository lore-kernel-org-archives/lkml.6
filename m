Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFAFC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5F220844
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548761823;
	bh=mILS5QYICiUDtZxRwyTCCWsZkbnp0ZtGwyO3+Dg7WtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bPr6iUW2JqnHC3pselOBicJUEDrmEfheumkBofkreW6zViq0bY2ulRGQCM6qcM2Zc
	 /C4TQejX4P0lfPFnuqdHfNzi6qN6BTkWLZY1XAiXmyw1t9VQ0QHvDQ6+yNqisBRUOS
	 ef6bmnOgjXlSL0cb6w86cL7R1MouFMkUQ+8I6DG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfA2LhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:37:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:53618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728677AbfA2Lg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:36:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAD6E20844;
        Tue, 29 Jan 2019 11:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761818;
        bh=mILS5QYICiUDtZxRwyTCCWsZkbnp0ZtGwyO3+Dg7WtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0hqSuA4ds7gpUTzfKHMvaz5iQcDzRFfpY8Sdw62OpbS+d0/Evu8pXZFguR0lQ7S6m
         DD/1uzHVqbW/MhyE8CMUY1bv6NWuN9Z4LZrGPo36kuK1bREyDO7Toq62c/WO101ZXg
         qTkxoZNp32EMiUTOptNUi5tmoIisw/U2ErwtZ4SI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 012/117] net: ipv4: Fix memory leak in network namespace dismantle
Date:   Tue, 29 Jan 2019 12:34:23 +0100
Message-Id: <20190129113208.182099780@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
 net/ipv4/fib_trie.c     |   15 ++++++++++++---
 3 files changed, 15 insertions(+), 6 deletions(-)

--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -241,7 +241,7 @@ int fib_table_delete(struct net *, struc
 		     struct netlink_ext_ack *extack);
 int fib_table_dump(struct fib_table *table, struct sk_buff *skb,
 		   struct netlink_callback *cb, struct fib_dump_filter *filter);
-int fib_table_flush(struct net *net, struct fib_table *table);
+int fib_table_flush(struct net *net, struct fib_table *table, bool flush_all);
 struct fib_table *fib_trie_unmerge(struct fib_table *main_tb);
 void fib_table_flush_external(struct fib_table *table);
 void fib_free_table(struct fib_table *tb);
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -203,7 +203,7 @@ static void fib_flush(struct net *net)
 		struct fib_table *tb;
 
 		hlist_for_each_entry_safe(tb, tmp, head, tb_hlist)
-			flushed += fib_table_flush(net, tb);
+			flushed += fib_table_flush(net, tb, false);
 	}
 
 	if (flushed)
@@ -1463,7 +1463,7 @@ static void ip_fib_net_exit(struct net *
 
 		hlist_for_each_entry_safe(tb, tmp, head, tb_hlist) {
 			hlist_del(&tb->tb_hlist);
-			fib_table_flush(net, tb);
+			fib_table_flush(net, tb, true);
 			fib_free_table(tb);
 		}
 	}
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -1856,7 +1856,7 @@ void fib_table_flush_external(struct fib
 }
 
 /* Caller must hold RTNL. */
-int fib_table_flush(struct net *net, struct fib_table *tb)
+int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
 {
 	struct trie *t = (struct trie *)tb->tb_data;
 	struct key_vector *pn = t->kv;
@@ -1904,8 +1904,17 @@ int fib_table_flush(struct net *net, str
 		hlist_for_each_entry_safe(fa, tmp, &n->leaf, fa_list) {
 			struct fib_info *fi = fa->fa_info;
 
-			if (!fi || !(fi->fib_flags & RTNH_F_DEAD) ||
-			    tb->tb_id != fa->tb_id) {
+			if (!fi || tb->tb_id != fa->tb_id ||
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


