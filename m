Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1092DC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10132152F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10132152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbeI0PgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:36:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56152 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbeI0PgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:36:02 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C92B01113;
        Thu, 27 Sep 2018 09:18:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+f5f6080811c849739212@syzkaller.appspotmail.com,
        Guillaume Nault <g.nault@alphalink.fr>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 05/64] pppoe: fix reception of frames with no mac header
Date:   Thu, 27 Sep 2018 11:03:22 +0200
Message-Id: <20180927090250.511404087@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090249.801943776@linuxfoundation.org>
References: <20180927090249.801943776@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guillaume Nault <g.nault@alphalink.fr>

[ Upstream commit 8540827ebac6b654ab2f69c8fbce9e4fbd6304a0 ]

pppoe_rcv() needs to look back at the Ethernet header in order to
lookup the PPPoE session. Therefore we need to ensure that the mac
header is big enough to contain an Ethernet header. Otherwise
eth_hdr(skb)->h_source might access invalid data.

==================================================================
BUG: KMSAN: uninit-value in __get_item drivers/net/ppp/pppoe.c:172 [inline]
BUG: KMSAN: uninit-value in get_item drivers/net/ppp/pppoe.c:236 [inline]
BUG: KMSAN: uninit-value in pppoe_rcv+0xcef/0x10e0 drivers/net/ppp/pppoe.c:450
CPU: 0 PID: 4543 Comm: syz-executor355 Not tainted 4.16.0+ #87
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google
01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:53
 kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
 __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:683
 __get_item drivers/net/ppp/pppoe.c:172 [inline]
 get_item drivers/net/ppp/pppoe.c:236 [inline]
 pppoe_rcv+0xcef/0x10e0 drivers/net/ppp/pppoe.c:450
 __netif_receive_skb_core+0x47df/0x4a90 net/core/dev.c:4562
 __netif_receive_skb net/core/dev.c:4627 [inline]
 netif_receive_skb_internal+0x49d/0x630 net/core/dev.c:4701
 netif_receive_skb+0x230/0x240 net/core/dev.c:4725
 tun_rx_batched drivers/net/tun.c:1555 [inline]
 tun_get_user+0x740f/0x7c60 drivers/net/tun.c:1962
 tun_chr_write_iter+0x1d4/0x330 drivers/net/tun.c:1990
 call_write_iter include/linux/fs.h:1782 [inline]
 new_sync_write fs/read_write.c:469 [inline]
 __vfs_write+0x7fb/0x9f0 fs/read_write.c:482
 vfs_write+0x463/0x8d0 fs/read_write.c:544
 SYSC_write+0x172/0x360 fs/read_write.c:589
 SyS_write+0x55/0x80 fs/read_write.c:581
 do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x4447c9
RSP: 002b:00007fff64c8fc28 EFLAGS: 00000297 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004447c9
RDX: 000000000000fd87 RSI: 0000000020000600 RDI: 0000000000000004
RBP: 00000000006cf018 R08: 00007fff64c8fda8 R09: 00007fff00006bda
R10: 0000000000005fe7 R11: 0000000000000297 R12: 00000000004020d0
R13: 0000000000402160 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
 kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:188
 kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:314
 kmsan_slab_alloc+0x11/0x20 mm/kmsan/kmsan.c:321
 slab_post_alloc_hook mm/slab.h:445 [inline]
 slab_alloc_node mm/slub.c:2737 [inline]
 __kmalloc_node_track_caller+0xaed/0x11c0 mm/slub.c:4369
 __kmalloc_reserve net/core/skbuff.c:138 [inline]
 __alloc_skb+0x2cf/0x9f0 net/core/skbuff.c:206
 alloc_skb include/linux/skbuff.h:984 [inline]
 alloc_skb_with_frags+0x1d4/0xb20 net/core/skbuff.c:5234
 sock_alloc_send_pskb+0xb56/0x1190 net/core/sock.c:2085
 tun_alloc_skb drivers/net/tun.c:1532 [inline]
 tun_get_user+0x2242/0x7c60 drivers/net/tun.c:1829
 tun_chr_write_iter+0x1d4/0x330 drivers/net/tun.c:1990
 call_write_iter include/linux/fs.h:1782 [inline]
 new_sync_write fs/read_write.c:469 [inline]
 __vfs_write+0x7fb/0x9f0 fs/read_write.c:482
 vfs_write+0x463/0x8d0 fs/read_write.c:544
 SYSC_write+0x172/0x360 fs/read_write.c:589
 SyS_write+0x55/0x80 fs/read_write.c:581
 do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2
==================================================================

Fixes: 224cf5ad14c0 ("ppp: Move the PPP drivers")
Reported-by: syzbot+f5f6080811c849739212@syzkaller.appspotmail.com
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ppp/pppoe.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -429,6 +429,9 @@ static int pppoe_rcv(struct sk_buff *skb
 	if (!skb)
 		goto out;
 
+	if (skb_mac_header_len(skb) < ETH_HLEN)
+		goto drop;
+
 	if (!pskb_may_pull(skb, sizeof(struct pppoe_hdr)))
 		goto drop;
 


