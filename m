Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id oHNKEFP2G1skdQAAmS7hNA
	; Sat, 09 Jun 2018 15:46:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 28599608C1; Sat,  9 Jun 2018 15:46:27 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTurBSn7"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6D083608B8;
	Sat,  9 Jun 2018 15:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6D083608B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753686AbeFIPqY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:46:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932658AbeFIPdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:33:25 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58564208A3;
        Sat,  9 Jun 2018 15:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558405;
        bh=GtV7McukCZfZBtcnGzzyxkmMefrg/jFuZSr3Af/7uxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZTurBSn7rBd+iJ3C28547ysbvpA3OwI02iLSinTegze8ZLxOCFcsQ0ezHUcBBrVX8
         Yk/ougsgUoX4TWqsLTwHvy5SA60+RH0fsDZwkp8wWkNw1JBZoXSqCWKtiwKwtOSAuL
         5GtvlYLNdmODGUCUUnuTYLA5M4/h5O8L0+gD6NO4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 23/48] net/packet: refine check for priv area size
Date: Sat,  9 Jun 2018 17:29:35 +0200
Message-Id: <20180609145949.180235682@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609145947.679103414@linuxfoundation.org>
References: <20180609145947.679103414@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit eb73190f4fbeedf762394e92d6a4ec9ace684c88 ]

syzbot was able to trick af_packet again [1]

Various commits tried to address the problem in the past,
but failed to take into account V3 header size.

[1]

tpacket_rcv: packet too big, clamped from 72 to 4294967224. macoff=96
BUG: KASAN: use-after-free in prb_run_all_ft_ops net/packet/af_packet.c:1016 [inline]
BUG: KASAN: use-after-free in prb_fill_curr_block.isra.59+0x4e5/0x5c0 net/packet/af_packet.c:1039
Write of size 2 at addr ffff8801cb62000e by task kworker/1:2/2106

CPU: 1 PID: 2106 Comm: kworker/1:2 Not tainted 4.17.0-rc7+ #77
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1b9/0x294 lib/dump_stack.c:113
 print_address_description+0x6c/0x20b mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:354 [inline]
 kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
 __asan_report_store2_noabort+0x17/0x20 mm/kasan/report.c:436
 prb_run_all_ft_ops net/packet/af_packet.c:1016 [inline]
 prb_fill_curr_block.isra.59+0x4e5/0x5c0 net/packet/af_packet.c:1039
 __packet_lookup_frame_in_block net/packet/af_packet.c:1094 [inline]
 packet_current_rx_frame net/packet/af_packet.c:1117 [inline]
 tpacket_rcv+0x1866/0x3340 net/packet/af_packet.c:2282
 dev_queue_xmit_nit+0x891/0xb90 net/core/dev.c:2018
 xmit_one net/core/dev.c:3049 [inline]
 dev_hard_start_xmit+0x16b/0xc10 net/core/dev.c:3069
 __dev_queue_xmit+0x2724/0x34c0 net/core/dev.c:3584
 dev_queue_xmit+0x17/0x20 net/core/dev.c:3617
 neigh_resolve_output+0x679/0xad0 net/core/neighbour.c:1358
 neigh_output include/net/neighbour.h:482 [inline]
 ip6_finish_output2+0xc9c/0x2810 net/ipv6/ip6_output.c:120
 ip6_finish_output+0x5fe/0xbc0 net/ipv6/ip6_output.c:154
 NF_HOOK_COND include/linux/netfilter.h:277 [inline]
 ip6_output+0x227/0x9b0 net/ipv6/ip6_output.c:171
 dst_output include/net/dst.h:444 [inline]
 NF_HOOK include/linux/netfilter.h:288 [inline]
 ndisc_send_skb+0x100d/0x1570 net/ipv6/ndisc.c:491
 ndisc_send_ns+0x3c1/0x8d0 net/ipv6/ndisc.c:633
 addrconf_dad_work+0xbef/0x1340 net/ipv6/addrconf.c:4033
 process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
 worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
 kthread+0x345/0x410 kernel/kthread.c:240
 ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

The buggy address belongs to the page:
page:ffffea00072d8800 count:0 mapcount:-127 mapping:0000000000000000 index:0xffff8801cb620e80
flags: 0x2fffc0000000000()
raw: 02fffc0000000000 0000000000000000 ffff8801cb620e80 00000000ffffff80
raw: ffffea00072e3820 ffffea0007132d20 0000000000000002 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8801cb61ff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8801cb61ff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8801cb620000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                      ^
 ffff8801cb620080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8801cb620100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

Fixes: 2b6867c2ce76 ("net/packet: fix overflow in check for priv area size")
Fixes: dc808110bb62 ("packet: handle too big packets for PACKET_V3")
Fixes: f6fb8f100b80 ("af-packet: TPACKET_V3 flexible buffer implementation.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/packet/af_packet.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -4284,7 +4284,7 @@ static int packet_set_ring(struct sock *
 			goto out;
 		if (po->tp_version >= TPACKET_V3 &&
 		    req->tp_block_size <=
-			  BLK_PLUS_PRIV((u64)req_u->req3.tp_sizeof_priv))
+		    BLK_PLUS_PRIV((u64)req_u->req3.tp_sizeof_priv) + sizeof(struct tpacket3_hdr))
 			goto out;
 		if (unlikely(req->tp_frame_size < po->tp_hdrlen +
 					po->tp_reserve))
