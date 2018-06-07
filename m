Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 80VIM7c9GVu0RAAAmS7hNA
	; Thu, 07 Jun 2018 14:14:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B006C608B8; Thu,  7 Jun 2018 14:14:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EE1AA6063F;
	Thu,  7 Jun 2018 14:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EE1AA6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933350AbeFGON4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:13:56 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39504 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933159AbeFGOJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:39 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbI-0005Zs-Bl; Thu, 07 Jun 2018 15:09:16 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbF-0003Kn-O2; Thu, 07 Jun 2018 15:09:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <eric.dumazet@gmail.com>,
        "Toshiaki Makita" <makita.toshiaki@lab.ntt.co.jp>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.783608984@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 410/410] net: Fix untag for vlan packets without
 ethernet header
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>

commit ae4745730cf8e693d354ccd4dbaf59ea440c09a9 upstream.

In some situation vlan packets do not have ethernet headers. One example
is packets from tun devices. Users can specify vlan protocol in tun_pi
field instead of IP protocol, and skb_vlan_untag() attempts to untag such
packets.

skb_vlan_untag() (more precisely, skb_reorder_vlan_header() called by it)
however did not expect packets without ethernet headers, so in such a case
size argument for memmove() underflowed and triggered crash.

====
BUG: unable to handle kernel paging request at ffff8801cccb8000
IP: __memmove+0x24/0x1a0 arch/x86/lib/memmove_64.S:43
PGD 9cee067 P4D 9cee067 PUD 1d9401063 PMD 1cccb7063 PTE 2810100028101
Oops: 000b [#1] SMP KASAN
Dumping ftrace buffer:
   (ftrace buffer empty)
Modules linked in:
CPU: 1 PID: 17663 Comm: syz-executor2 Not tainted 4.16.0-rc7+ #368
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__memmove+0x24/0x1a0 arch/x86/lib/memmove_64.S:43
RSP: 0018:ffff8801cc046e28 EFLAGS: 00010287
RAX: ffff8801ccc244c4 RBX: fffffffffffffffe RCX: fffffffffff6c4c2
RDX: fffffffffffffffe RSI: ffff8801cccb7ffc RDI: ffff8801cccb8000
RBP: ffff8801cc046e48 R08: ffff8801ccc244be R09: ffffed0039984899
R10: 0000000000000001 R11: ffffed0039984898 R12: ffff8801ccc244c4
R13: ffff8801ccc244c0 R14: ffff8801d96b7c06 R15: ffff8801d96b7b40
FS:  00007febd562d700(0000) GS:ffff8801db300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8801cccb8000 CR3: 00000001ccb2f006 CR4: 00000000001606e0
DR0: 0000000020000000 DR1: 0000000020000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
 memmove include/linux/string.h:360 [inline]
 skb_reorder_vlan_header net/core/skbuff.c:5031 [inline]
 skb_vlan_untag+0x470/0xc40 net/core/skbuff.c:5061
 __netif_receive_skb_core+0x119c/0x3460 net/core/dev.c:4460
 __netif_receive_skb+0x2c/0x1b0 net/core/dev.c:4627
 netif_receive_skb_internal+0x10b/0x670 net/core/dev.c:4701
 netif_receive_skb+0xae/0x390 net/core/dev.c:4725
 tun_rx_batched.isra.50+0x5ee/0x870 drivers/net/tun.c:1555
 tun_get_user+0x299e/0x3c20 drivers/net/tun.c:1962
 tun_chr_write_iter+0xb9/0x160 drivers/net/tun.c:1990
 call_write_iter include/linux/fs.h:1782 [inline]
 new_sync_write fs/read_write.c:469 [inline]
 __vfs_write+0x684/0x970 fs/read_write.c:482
 vfs_write+0x189/0x510 fs/read_write.c:544
 SYSC_write fs/read_write.c:589 [inline]
 SyS_write+0xef/0x220 fs/read_write.c:581
 do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x454879
RSP: 002b:00007febd562cc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007febd562d6d4 RCX: 0000000000454879
RDX: 0000000000000157 RSI: 0000000020000180 RDI: 0000000000000014
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000006b0 R14: 00000000006fc120 R15: 0000000000000000
Code: 90 90 90 90 90 90 90 48 89 f8 48 83 fa 20 0f 82 03 01 00 00 48 39 fe 7d 0f 49 89 f0 49 01 d0 49 39 f8 0f 8f 9f 00 00 00 48 89 d1 <f3> a4 c3 48 81 fa a8 02 00 00 72 05 40 38 fe 74 3b 48 83 ea 20
RIP: __memmove+0x24/0x1a0 arch/x86/lib/memmove_64.S:43 RSP: ffff8801cc046e28
CR2: ffff8801cccb8000
====

We don't need to copy headers for packets which do not have preceding
headers of vlan headers, so skip memmove() in that case.

Fixes: 4bbb3e0e8239 ("net: Fix vlan untag for bridge and vlan_dev with reorder_hdr off")
Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/core/skbuff.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4002,8 +4002,10 @@ static struct sk_buff *skb_reorder_vlan_
 	}
 
 	mac_len = skb->data - skb_mac_header(skb);
-	memmove(skb_mac_header(skb) + VLAN_HLEN, skb_mac_header(skb),
-		mac_len - VLAN_HLEN - ETH_TLEN);
+	if (likely(mac_len > VLAN_HLEN + ETH_TLEN)) {
+		memmove(skb_mac_header(skb) + VLAN_HLEN, skb_mac_header(skb),
+			mac_len - VLAN_HLEN - ETH_TLEN);
+	}
 	skb->mac_header += VLAN_HLEN;
 	return skb;
 }
