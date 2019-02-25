Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21F5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A229920C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129892;
	bh=1BXjosdlJ8/Eo4z9ScXHgbqOg14y0UFkme2WgCdggSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K8gAFyMNIxlzh5r0v8eTFHn3UF7lCmatbxU32XEOKSgkek+8k3IC/vwV4lZpFT0EK
	 WlYV6j3vWkXsr8L7Bk5hjTrwcaGibacKigaRy5fexwKGQ+S5vaKEdHIgkSlOGMTaK9
	 iAg4TEOtTKJg36FBuji+BCBOZga1hY940353zrBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730964AbfBYVYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:24:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:59314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730497AbfBYVYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:24:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3604C2146F;
        Mon, 25 Feb 2019 21:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129887;
        bh=1BXjosdlJ8/Eo4z9ScXHgbqOg14y0UFkme2WgCdggSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tDPacb7MeawVPnAnv7Kx6eVw/Dm3OF+Y4pTAdmcCHWzySwsUFWHKpyNxsa4lBdk0i
         6O3a8Kbzf/3gVGK82swP8fHiBrGDokQRdX8W+GfZKm5BOqmbNQWG0zeEA5qQt3fxzq
         6jUUHn0uQntPq/UHbHwkcRhP8ZEY+0q2epIZNIQc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Antonio Quartulli <a@unstable.cc>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 098/152] batman-adv: fix uninit-value in batadv_interface_tx()
Date:   Mon, 25 Feb 2019 22:11:30 +0100
Message-Id: <20190225195049.722446634@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 4ffcbfac60642f63ae3d80891f573ba7e94a265c ]

KMSAN reported batadv_interface_tx() was possibly using a
garbage value [1]

batadv_get_vid() does have a pskb_may_pull() call
but batadv_interface_tx() does not actually make sure
this did not fail.

[1]
BUG: KMSAN: uninit-value in batadv_interface_tx+0x908/0x1e40 net/batman-adv/soft-interface.c:231
CPU: 0 PID: 10006 Comm: syz-executor469 Not tainted 4.20.0-rc7+ #5
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x173/0x1d0 lib/dump_stack.c:113
 kmsan_report+0x12e/0x2a0 mm/kmsan/kmsan.c:613
 __msan_warning+0x82/0xf0 mm/kmsan/kmsan_instr.c:313
 batadv_interface_tx+0x908/0x1e40 net/batman-adv/soft-interface.c:231
 __netdev_start_xmit include/linux/netdevice.h:4356 [inline]
 netdev_start_xmit include/linux/netdevice.h:4365 [inline]
 xmit_one net/core/dev.c:3257 [inline]
 dev_hard_start_xmit+0x607/0xc40 net/core/dev.c:3273
 __dev_queue_xmit+0x2e42/0x3bc0 net/core/dev.c:3843
 dev_queue_xmit+0x4b/0x60 net/core/dev.c:3876
 packet_snd net/packet/af_packet.c:2928 [inline]
 packet_sendmsg+0x8306/0x8f30 net/packet/af_packet.c:2953
 sock_sendmsg_nosec net/socket.c:621 [inline]
 sock_sendmsg net/socket.c:631 [inline]
 __sys_sendto+0x8c4/0xac0 net/socket.c:1788
 __do_sys_sendto net/socket.c:1800 [inline]
 __se_sys_sendto+0x107/0x130 net/socket.c:1796
 __x64_sys_sendto+0x6e/0x90 net/socket.c:1796
 do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:291
 entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x441889
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 bb 10 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdda6fd468 EFLAGS: 00000216 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 0000000000441889
RDX: 000000000000000e RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000216 R12: 00007ffdda6fd4c0
R13: 00007ffdda6fd4b0 R14: 0000000000000000 R15: 0000000000000000

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
 alloc_skb_with_frags+0x1c7/0xac0 net/core/skbuff.c:5220
 sock_alloc_send_pskb+0xafd/0x10e0 net/core/sock.c:2083
 packet_alloc_skb net/packet/af_packet.c:2781 [inline]
 packet_snd net/packet/af_packet.c:2872 [inline]
 packet_sendmsg+0x661a/0x8f30 net/packet/af_packet.c:2953
 sock_sendmsg_nosec net/socket.c:621 [inline]
 sock_sendmsg net/socket.c:631 [inline]
 __sys_sendto+0x8c4/0xac0 net/socket.c:1788
 __do_sys_sendto net/socket.c:1800 [inline]
 __se_sys_sendto+0x107/0x130 net/socket.c:1796
 __x64_sys_sendto+0x6e/0x90 net/socket.c:1796
 do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:291
 entry_SYSCALL_64_after_hwframe+0x63/0xe7

Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc:	Marek Lindner <mareklindner@neomailbox.ch>
Cc:	Simon Wunderlich <sw@simonwunderlich.de>
Cc:	Antonio Quartulli <a@unstable.cc>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/soft-interface.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -227,6 +227,8 @@ static netdev_tx_t batadv_interface_tx(s
 
 	switch (ntohs(ethhdr->h_proto)) {
 	case ETH_P_8021Q:
+		if (!pskb_may_pull(skb, sizeof(*vhdr)))
+			goto dropped;
 		vhdr = vlan_eth_hdr(skb);
 
 		/* drop batman-in-batman packets to prevent loops */


