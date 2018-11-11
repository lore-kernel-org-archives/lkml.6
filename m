Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E9AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B1E2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B1E2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbeKLF5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:57:39 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52248 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730690AbeKLF5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:57:38 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt4-0000oG-38; Sun, 11 Nov 2018 19:59:14 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsR-0001WM-CL; Sun, 11 Nov 2018 19:58:35 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Eric Dumazet" <edumazet@google.com>,
        "David Ahern" <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "syzbot" <syzkaller@googlegroups.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.794920738@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 118/366] net: metrics: add proper netlink validation
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 5b5e7a0de2bbf2a1afcd9f49e940010e9fb80d53 upstream.

Before using nla_get_u32(), better make sure the attribute
is of the proper size.

Code recently was changed, but bug has been there from beginning
of git.

BUG: KMSAN: uninit-value in rtnetlink_put_metrics+0x553/0x960 net/core/rtnetlink.c:746
CPU: 1 PID: 14139 Comm: syz-executor6 Not tainted 4.17.0-rc5+ #103
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:113
 kmsan_report+0x149/0x260 mm/kmsan/kmsan.c:1084
 __msan_warning_32+0x6e/0xc0 mm/kmsan/kmsan_instr.c:686
 rtnetlink_put_metrics+0x553/0x960 net/core/rtnetlink.c:746
 fib_dump_info+0xc42/0x2190 net/ipv4/fib_semantics.c:1361
 rtmsg_fib+0x65f/0x8c0 net/ipv4/fib_semantics.c:419
 fib_table_insert+0x2314/0x2b50 net/ipv4/fib_trie.c:1287
 inet_rtm_newroute+0x210/0x340 net/ipv4/fib_frontend.c:779
 rtnetlink_rcv_msg+0xa32/0x1560 net/core/rtnetlink.c:4646
 netlink_rcv_skb+0x378/0x600 net/netlink/af_netlink.c:2448
 rtnetlink_rcv+0x50/0x60 net/core/rtnetlink.c:4664
 netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
 netlink_unicast+0x1678/0x1750 net/netlink/af_netlink.c:1336
 netlink_sendmsg+0x104f/0x1350 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:629 [inline]
 sock_sendmsg net/socket.c:639 [inline]
 ___sys_sendmsg+0xec0/0x1310 net/socket.c:2117
 __sys_sendmsg net/socket.c:2155 [inline]
 __do_sys_sendmsg net/socket.c:2164 [inline]
 __se_sys_sendmsg net/socket.c:2162 [inline]
 __x64_sys_sendmsg+0x331/0x460 net/socket.c:2162
 do_syscall_64+0x152/0x230 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x455a09
RSP: 002b:00007faae5fd8c68 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007faae5fd96d4 RCX: 0000000000455a09
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000013
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000005d0 R14: 00000000006fdc20 R15: 0000000000000000

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:279 [inline]
 kmsan_save_stack mm/kmsan/kmsan.c:294 [inline]
 kmsan_internal_chain_origin+0x12b/0x210 mm/kmsan/kmsan.c:685
 __msan_chain_origin+0x69/0xc0 mm/kmsan/kmsan_instr.c:529
 fib_convert_metrics net/ipv4/fib_semantics.c:1056 [inline]
 fib_create_info+0x2d46/0x9dc0 net/ipv4/fib_semantics.c:1150
 fib_table_insert+0x3e4/0x2b50 net/ipv4/fib_trie.c:1146
 inet_rtm_newroute+0x210/0x340 net/ipv4/fib_frontend.c:779
 rtnetlink_rcv_msg+0xa32/0x1560 net/core/rtnetlink.c:4646
 netlink_rcv_skb+0x378/0x600 net/netlink/af_netlink.c:2448
 rtnetlink_rcv+0x50/0x60 net/core/rtnetlink.c:4664
 netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
 netlink_unicast+0x1678/0x1750 net/netlink/af_netlink.c:1336
 netlink_sendmsg+0x104f/0x1350 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:629 [inline]
 sock_sendmsg net/socket.c:639 [inline]
 ___sys_sendmsg+0xec0/0x1310 net/socket.c:2117
 __sys_sendmsg net/socket.c:2155 [inline]
 __do_sys_sendmsg net/socket.c:2164 [inline]
 __se_sys_sendmsg net/socket.c:2162 [inline]
 __x64_sys_sendmsg+0x331/0x460 net/socket.c:2162
 do_syscall_64+0x152/0x230 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:279 [inline]
 kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:189
 kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:315
 kmsan_slab_alloc+0x10/0x20 mm/kmsan/kmsan.c:322
 slab_post_alloc_hook mm/slab.h:446 [inline]
 slab_alloc_node mm/slub.c:2753 [inline]
 __kmalloc_node_track_caller+0xb32/0x11b0 mm/slub.c:4395
 __kmalloc_reserve net/core/skbuff.c:138 [inline]
 __alloc_skb+0x2cb/0x9e0 net/core/skbuff.c:206
 alloc_skb include/linux/skbuff.h:988 [inline]
 netlink_alloc_large_skb net/netlink/af_netlink.c:1182 [inline]
 netlink_sendmsg+0x76e/0x1350 net/netlink/af_netlink.c:1876
 sock_sendmsg_nosec net/socket.c:629 [inline]
 sock_sendmsg net/socket.c:639 [inline]
 ___sys_sendmsg+0xec0/0x1310 net/socket.c:2117
 __sys_sendmsg net/socket.c:2155 [inline]
 __do_sys_sendmsg net/socket.c:2164 [inline]
 __se_sys_sendmsg net/socket.c:2162 [inline]
 __x64_sys_sendmsg+0x331/0x460 net/socket.c:2162
 do_syscall_64+0x152/0x230 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: a919525ad832 ("net: Move fib_convert_metrics to metrics file")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: Metrics are parsed in fib_create_info()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -862,6 +862,8 @@ struct fib_info *fib_create_info(struct
 
 				if (type > RTAX_MAX)
 					goto err_inval;
+				if (nla_len(nla) != sizeof(u32))
+					goto err_inval;
 				val = nla_get_u32(nla);
 				if (type == RTAX_ADVMSS && val > 65535 - 40)
 					val = 65535 - 40;

