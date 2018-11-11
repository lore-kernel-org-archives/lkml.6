Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14152C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44C82080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D44C82080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbeKLFyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:54:25 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51740 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730738AbeKLFyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:54:21 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt4-0000oP-W2; Sun, 11 Nov 2018 19:59:15 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsR-0001Vh-3p; Sun, 11 Nov 2018 19:58:35 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Eric Dumazet" <edumazet@google.com>,
        "syzbot" <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.739487297@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 111/366] net/packet: refine check for priv area size
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

commit eb73190f4fbeedf762394e92d6a4ec9ace684c88 upstream.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/packet/af_packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3898,7 +3898,7 @@ static int packet_set_ring(struct sock *
 			goto out;
 		if (po->tp_version >= TPACKET_V3 &&
 		    req->tp_block_size <=
-			  BLK_PLUS_PRIV((u64)req_u->req3.tp_sizeof_priv))
+		    BLK_PLUS_PRIV((u64)req_u->req3.tp_sizeof_priv) + sizeof(struct tpacket3_hdr))
 			goto out;
 		if (unlikely(req->tp_frame_size < po->tp_hdrlen +
 					po->tp_reserve))

