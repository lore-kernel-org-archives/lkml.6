Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79F2C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82E720645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82E720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbeJNXWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:22:45 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36196 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728030AbeJNXMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:01 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLo-0004cd-Ak; Sun, 14 Oct 2018 16:30:40 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLX-0000Xm-KI; Sun, 14 Oct 2018 16:30:23 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "syzbot" <syzkaller@googlegroups.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.582488778@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 268/366] llc: better deal with too small mtu
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 2c5d5b13c6eb79f5677e206b8aad59b3a2097f60 upstream.

syzbot loves to set very small mtu on devices, since it brings joy.
We must make llc_ui_sendmsg() fool proof.

usercopy: Kernel memory overwrite attempt detected to wrapped address (offset 0, size 18446612139802320068)!

kernel BUG at mm/usercopy.c:100!
invalid opcode: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
   (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 17464 Comm: syz-executor1 Not tainted 4.17.0-rc3+ #36
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:usercopy_abort+0xbb/0xbd mm/usercopy.c:88
RSP: 0018:ffff8801868bf800 EFLAGS: 00010282
RAX: 000000000000006c RBX: ffffffff87d2fb00 RCX: 0000000000000000
RDX: 000000000000006c RSI: ffffffff81610731 RDI: ffffed0030d17ef6
RBP: ffff8801868bf858 R08: ffff88018daa4200 R09: ffffed003b5c4fb0
R10: ffffed003b5c4fb0 R11: ffff8801dae27d87 R12: ffffffff87d2f8e0
R13: ffffffff87d2f7a0 R14: ffffffff87d2f7a0 R15: ffffffff87d2f7a0
FS:  00007f56a14ac700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2bc21000 CR3: 00000001abeb1000 CR4: 00000000001426f0
DR0: 0000000020000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000030602
Call Trace:
 check_bogus_address mm/usercopy.c:153 [inline]
 __check_object_size+0x5d9/0x5d9 mm/usercopy.c:256
 check_object_size include/linux/thread_info.h:108 [inline]
 check_copy_size include/linux/thread_info.h:139 [inline]
 copy_from_iter_full include/linux/uio.h:121 [inline]
 memcpy_from_msg include/linux/skbuff.h:3305 [inline]
 llc_ui_sendmsg+0x4b1/0x1530 net/llc/af_llc.c:941
 sock_sendmsg_nosec net/socket.c:629 [inline]
 sock_sendmsg+0xd5/0x120 net/socket.c:639
 __sys_sendto+0x3d7/0x670 net/socket.c:1789
 __do_sys_sendto net/socket.c:1801 [inline]
 __se_sys_sendto net/socket.c:1797 [inline]
 __x64_sys_sendto+0xe1/0x1a0 net/socket.c:1797
 do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455979
RSP: 002b:00007f56a14abc68 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f56a14ac6d4 RCX: 0000000000455979
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000018
RBP: 000000000072bea0 R08: 00000000200012c0 R09: 0000000000000010
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000548 R14: 00000000006fbf60 R15: 0000000000000000
Code: 55 c0 e8 c0 55 bb ff ff 75 c8 48 8b 55 c0 4d 89 f9 ff 75 d0 4d 89 e8 48 89 d9 4c 89 e6 41 56 48 c7 c7 80 fa d2 87 e8 a0 0b a3 ff <0f> 0b e8 95 55 bb ff e8 c0 a8 f7 ff 8b 95 14 ff ff ff 4d 89 e8
RIP: usercopy_abort+0xbb/0xbd mm/usercopy.c:88 RSP: ffff8801868bf800

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/llc/af_llc.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -925,6 +925,9 @@ static int llc_ui_sendmsg(struct kiocb *
 	if (size > llc->dev->mtu)
 		size = llc->dev->mtu;
 	copied = size - hdrlen;
+	rc = -EINVAL;
+	if (copied < 0)
+		goto release;
 	release_sock(sk);
 	skb = sock_alloc_send_skb(sk, size, noblock, &rc);
 	lock_sock(sk);

