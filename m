Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id PJ1NBxT0G1ubaAAAmS7hNA
	; Sat, 09 Jun 2018 15:36:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 01FDF608C1; Sat,  9 Jun 2018 15:36:52 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiCktNGI"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 22FD3608B8;
	Sat,  9 Jun 2018 15:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 22FD3608B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933260AbeFIPgt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:36:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933229AbeFIPgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:36:25 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 007B82087B;
        Sat,  9 Jun 2018 15:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558584;
        bh=4o57Sp14C/EeRTmROCsgQo1OdCdapWis/fTE8R8ovs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kiCktNGIb0b/lNg8GHlu/pnRSX0YjNFEvozsvIWZFDgB8W2UGWdLvdQ+3EYD4cyFI
         7jPtkVBL8VNovR02Xj5rjwN+9pGQsOTmARHuNHtCCvXxvF4f65TrnhYYSrpT+wWy0Z
         b4AWXPQLD7UIRWLozW8eKcLOWHBIrV+j7R2XQ4mw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 39/41] rtnetlink: validate attributes in do_setlink()
Date: Sat,  9 Jun 2018 17:30:11 +0200
Message-Id: <20180609152928.546313343@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609152926.389750182@linuxfoundation.org>
References: <20180609152926.389750182@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 644c7eebbfd59e72982d11ec6cc7d39af12450ae ]

It seems that rtnl_group_changelink() can call do_setlink
while a prior call to validate_linkmsg(dev = NULL, ...) could
not validate IFLA_ADDRESS / IFLA_BROADCAST

Make sure do_setlink() calls validate_linkmsg() instead
of letting its callers having this responsibility.

With help from Dmitry Vyukov, thanks a lot !

BUG: KMSAN: uninit-value in is_valid_ether_addr include/linux/etherdevice.h:199 [inline]
BUG: KMSAN: uninit-value in eth_prepare_mac_addr_change net/ethernet/eth.c:275 [inline]
BUG: KMSAN: uninit-value in eth_mac_addr+0x203/0x2b0 net/ethernet/eth.c:308
CPU: 1 PID: 8695 Comm: syz-executor3 Not tainted 4.17.0-rc5+ #103
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:113
 kmsan_report+0x149/0x260 mm/kmsan/kmsan.c:1084
 __msan_warning_32+0x6e/0xc0 mm/kmsan/kmsan_instr.c:686
 is_valid_ether_addr include/linux/etherdevice.h:199 [inline]
 eth_prepare_mac_addr_change net/ethernet/eth.c:275 [inline]
 eth_mac_addr+0x203/0x2b0 net/ethernet/eth.c:308
 dev_set_mac_address+0x261/0x530 net/core/dev.c:7157
 do_setlink+0xbc3/0x5fc0 net/core/rtnetlink.c:2317
 rtnl_group_changelink net/core/rtnetlink.c:2824 [inline]
 rtnl_newlink+0x1fe9/0x37a0 net/core/rtnetlink.c:2976
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
RSP: 002b:00007fc07480ec68 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fc07480f6d4 RCX: 0000000000455a09
RDX: 0000000000000000 RSI: 00000000200003c0 RDI: 0000000000000014
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000005d0 R14: 00000000006fdc20 R15: 0000000000000000

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:279 [inline]
 kmsan_save_stack mm/kmsan/kmsan.c:294 [inline]
 kmsan_internal_chain_origin+0x12b/0x210 mm/kmsan/kmsan.c:685
 kmsan_memcpy_origins+0x11d/0x170 mm/kmsan/kmsan.c:527
 __msan_memcpy+0x109/0x160 mm/kmsan/kmsan_instr.c:478
 do_setlink+0xb84/0x5fc0 net/core/rtnetlink.c:2315
 rtnl_group_changelink net/core/rtnetlink.c:2824 [inline]
 rtnl_newlink+0x1fe9/0x37a0 net/core/rtnetlink.c:2976
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

Fixes: e7ed828f10bd ("netlink: support setting devgroup parameters")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/rtnetlink.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1958,6 +1958,10 @@ static int do_setlink(const struct sk_bu
 	const struct net_device_ops *ops = dev->netdev_ops;
 	int err;
 
+	err = validate_linkmsg(dev, tb);
+	if (err < 0)
+		return err;
+
 	if (tb[IFLA_NET_NS_PID] || tb[IFLA_NET_NS_FD]) {
 		struct net *net = rtnl_link_get_net(dev_net(dev), tb);
 		if (IS_ERR(net)) {
@@ -2296,10 +2300,6 @@ static int rtnl_setlink(struct sk_buff *
 		goto errout;
 	}
 
-	err = validate_linkmsg(dev, tb);
-	if (err < 0)
-		goto errout;
-
 	err = do_setlink(skb, dev, ifm, extack, tb, ifname, 0);
 errout:
 	return err;
