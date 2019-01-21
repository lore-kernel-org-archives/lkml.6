Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9778EC2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA3220989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078400;
	bh=Wb/rXivMzo/YDCAVn80J6WdRN40V776XI5B5WvIjZBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lFkYUDKL2mQc8nowvETzZy64AH/tIFBGTC6cGPvo765OHjz7t/9oPA723c1Z554LH
	 0ET7So11OxPulGLIBgHAbL9oY4HxBoVSUZvF5QvD9aSQnNjwbSwFrkdCRL1Xd1T3ZD
	 SBtgp3dqzA++SiLFRPdkCEjIbcWskSuUsCGfBnVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbfAUNqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:46:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:55470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729254AbfAUNqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:46:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33D0120989;
        Mon, 21 Jan 2019 13:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078395;
        bh=Wb/rXivMzo/YDCAVn80J6WdRN40V776XI5B5WvIjZBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lGsM/ikbMAtRYICMW/FG6qDgm0auDuhDKsP7EO3mZt/TqB1O494ua95vf7BCSJd55
         +A8MTF4Owf5cf/ao2CXKMmKKdWhKQL0ymoJepzLwulAFh+Bp3kjClvciEusLFD10Lh
         Uhz/ZDKA+CHrLYSt+F4GwiZ3Idyihw5iGdak7Cwk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 017/111] ipv6: fix kernel-infoleak in ipv6_local_error()
Date:   Mon, 21 Jan 2019 14:42:11 +0100
Message-Id: <20190121122457.641171092@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 7d033c9f6a7fd3821af75620a0257db87c2b552a ]

This patch makes sure the flow label in the IPv6 header
forged in ipv6_local_error() is initialized.

BUG: KMSAN: kernel-infoleak in _copy_to_user+0x16b/0x1f0 lib/usercopy.c:32
CPU: 1 PID: 24675 Comm: syz-executor1 Not tainted 4.20.0-rc7+ #4
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x173/0x1d0 lib/dump_stack.c:113
 kmsan_report+0x12e/0x2a0 mm/kmsan/kmsan.c:613
 kmsan_internal_check_memory+0x455/0xb00 mm/kmsan/kmsan.c:675
 kmsan_copy_to_user+0xab/0xc0 mm/kmsan/kmsan_hooks.c:601
 _copy_to_user+0x16b/0x1f0 lib/usercopy.c:32
 copy_to_user include/linux/uaccess.h:177 [inline]
 move_addr_to_user+0x2e9/0x4f0 net/socket.c:227
 ___sys_recvmsg+0x5d7/0x1140 net/socket.c:2284
 __sys_recvmsg net/socket.c:2327 [inline]
 __do_sys_recvmsg net/socket.c:2337 [inline]
 __se_sys_recvmsg+0x2fa/0x450 net/socket.c:2334
 __x64_sys_recvmsg+0x4a/0x70 net/socket.c:2334
 do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:291
 entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x457ec9
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f8750c06c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002f
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457ec9
RDX: 0000000000002000 RSI: 0000000020000400 RDI: 0000000000000005
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f8750c076d4
R13: 00000000004c4a60 R14: 00000000004d8140 R15: 00000000ffffffff

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:204 [inline]
 kmsan_save_stack mm/kmsan/kmsan.c:219 [inline]
 kmsan_internal_chain_origin+0x134/0x230 mm/kmsan/kmsan.c:439
 __msan_chain_origin+0x70/0xe0 mm/kmsan/kmsan_instr.c:200
 ipv6_recv_error+0x1e3f/0x1eb0 net/ipv6/datagram.c:475
 udpv6_recvmsg+0x398/0x2ab0 net/ipv6/udp.c:335
 inet_recvmsg+0x4fb/0x600 net/ipv4/af_inet.c:830
 sock_recvmsg_nosec net/socket.c:794 [inline]
 sock_recvmsg+0x1d1/0x230 net/socket.c:801
 ___sys_recvmsg+0x4d5/0x1140 net/socket.c:2278
 __sys_recvmsg net/socket.c:2327 [inline]
 __do_sys_recvmsg net/socket.c:2337 [inline]
 __se_sys_recvmsg+0x2fa/0x450 net/socket.c:2334
 __x64_sys_recvmsg+0x4a/0x70 net/socket.c:2334
 do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:291
 entry_SYSCALL_64_after_hwframe+0x63/0xe7

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:204 [inline]
 kmsan_internal_poison_shadow+0x92/0x150 mm/kmsan/kmsan.c:158
 kmsan_kmalloc+0xa6/0x130 mm/kmsan/kmsan_hooks.c:176
 kmsan_slab_alloc+0xe/0x10 mm/kmsan/kmsan_hooks.c:185
 slab_post_alloc_hook mm/slab.h:446 [inline]
 slab_alloc_node mm/slub.c:2759 [inline]
 __kmalloc_node_track_caller+0xe18/0x1030 mm/slub.c:4383
 __kmalloc_reserve net/core/skbuff.c:137 [inline]
 __alloc_skb+0x309/0xa20 net/core/skbuff.c:205
 alloc_skb include/linux/skbuff.h:998 [inline]
 ipv6_local_error+0x1a7/0x9e0 net/ipv6/datagram.c:334
 __ip6_append_data+0x129f/0x4fd0 net/ipv6/ip6_output.c:1311
 ip6_make_skb+0x6cc/0xcf0 net/ipv6/ip6_output.c:1775
 udpv6_sendmsg+0x3f8e/0x45d0 net/ipv6/udp.c:1384
 inet_sendmsg+0x54a/0x720 net/ipv4/af_inet.c:798
 sock_sendmsg_nosec net/socket.c:621 [inline]
 sock_sendmsg net/socket.c:631 [inline]
 __sys_sendto+0x8c4/0xac0 net/socket.c:1788
 __do_sys_sendto net/socket.c:1800 [inline]
 __se_sys_sendto+0x107/0x130 net/socket.c:1796
 __x64_sys_sendto+0x6e/0x90 net/socket.c:1796
 do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:291
 entry_SYSCALL_64_after_hwframe+0x63/0xe7

Bytes 4-7 of 28 are uninitialized
Memory access of size 28 starts at ffff8881937bfce0
Data copied to user address 0000000020000000

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/datagram.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -341,6 +341,7 @@ void ipv6_local_error(struct sock *sk, i
 	skb_reset_network_header(skb);
 	iph = ipv6_hdr(skb);
 	iph->daddr = fl6->daddr;
+	ip6_flow_hdr(iph, 0, 0);
 
 	serr = SKB_EXT_ERR(skb);
 	serr->ee.ee_errno = err;


