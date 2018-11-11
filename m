Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D375C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3200320869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3200320869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbeKLG30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:29:26 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49500 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729530AbeKLFsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:07 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsT-0000oG-55; Sun, 11 Nov 2018 19:58:37 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsS-0001ZH-Pq; Sun, 11 Nov 2018 19:58:36 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Steffen Klassert" <steffen.klassert@secunet.com>,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "Eric Dumazet" <edumazet@google.com>,
        "syzbot" <syzkaller@googlegroups.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.557097256@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 154/366] xfrm_user: prevent leaking 2 bytes of kernel
 memory
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

commit 45c180bc29babbedd6b8c01b975780ef44d9d09c upstream.

struct xfrm_userpolicy_type has two holes, so we should not
use C99 style initializer.

KMSAN report:

BUG: KMSAN: kernel-infoleak in copyout lib/iov_iter.c:140 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_iter+0x1b14/0x2800 lib/iov_iter.c:571
CPU: 1 PID: 4520 Comm: syz-executor841 Not tainted 4.17.0+ #5
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:113
 kmsan_report+0x188/0x2a0 mm/kmsan/kmsan.c:1117
 kmsan_internal_check_memory+0x138/0x1f0 mm/kmsan/kmsan.c:1211
 kmsan_copy_to_user+0x7a/0x160 mm/kmsan/kmsan.c:1253
 copyout lib/iov_iter.c:140 [inline]
 _copy_to_iter+0x1b14/0x2800 lib/iov_iter.c:571
 copy_to_iter include/linux/uio.h:106 [inline]
 skb_copy_datagram_iter+0x422/0xfa0 net/core/datagram.c:431
 skb_copy_datagram_msg include/linux/skbuff.h:3268 [inline]
 netlink_recvmsg+0x6f1/0x1900 net/netlink/af_netlink.c:1959
 sock_recvmsg_nosec net/socket.c:802 [inline]
 sock_recvmsg+0x1d6/0x230 net/socket.c:809
 ___sys_recvmsg+0x3fe/0x810 net/socket.c:2279
 __sys_recvmmsg+0x58e/0xe30 net/socket.c:2391
 do_sys_recvmmsg+0x2a6/0x3e0 net/socket.c:2472
 __do_sys_recvmmsg net/socket.c:2485 [inline]
 __se_sys_recvmmsg net/socket.c:2481 [inline]
 __x64_sys_recvmmsg+0x15d/0x1c0 net/socket.c:2481
 do_syscall_64+0x15b/0x230 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446ce9
RSP: 002b:00007fc307918db8 EFLAGS: 00000293 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00000000006dbc24 RCX: 0000000000446ce9
RDX: 000000000000000a RSI: 0000000020005040 RDI: 0000000000000003
RBP: 00000000006dbc20 R08: 0000000020004e40 R09: 0000000000000000
R10: 0000000040000000 R11: 0000000000000293 R12: 0000000000000000
R13: 00007ffc8d2df32f R14: 00007fc3079199c0 R15: 0000000000000001

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:279 [inline]
 kmsan_save_stack mm/kmsan/kmsan.c:294 [inline]
 kmsan_internal_chain_origin+0x12b/0x210 mm/kmsan/kmsan.c:685
 kmsan_memcpy_origins+0x11d/0x170 mm/kmsan/kmsan.c:527
 __msan_memcpy+0x109/0x160 mm/kmsan/kmsan_instr.c:413
 __nla_put lib/nlattr.c:569 [inline]
 nla_put+0x276/0x340 lib/nlattr.c:627
 copy_to_user_policy_type net/xfrm/xfrm_user.c:1678 [inline]
 dump_one_policy+0xbe1/0x1090 net/xfrm/xfrm_user.c:1708
 xfrm_policy_walk+0x45a/0xd00 net/xfrm/xfrm_policy.c:1013
 xfrm_dump_policy+0x1c0/0x2a0 net/xfrm/xfrm_user.c:1749
 netlink_dump+0x9b5/0x1550 net/netlink/af_netlink.c:2226
 __netlink_dump_start+0x1131/0x1270 net/netlink/af_netlink.c:2323
 netlink_dump_start include/linux/netlink.h:214 [inline]
 xfrm_user_rcv_msg+0x8a3/0x9b0 net/xfrm/xfrm_user.c:2577
 netlink_rcv_skb+0x37e/0x600 net/netlink/af_netlink.c:2448
 xfrm_netlink_rcv+0xb2/0xf0 net/xfrm/xfrm_user.c:2598
 netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
 netlink_unicast+0x1680/0x1750 net/netlink/af_netlink.c:1336
 netlink_sendmsg+0x104f/0x1350 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:629 [inline]
 sock_sendmsg net/socket.c:639 [inline]
 ___sys_sendmsg+0xec8/0x1320 net/socket.c:2117
 __sys_sendmsg net/socket.c:2155 [inline]
 __do_sys_sendmsg net/socket.c:2164 [inline]
 __se_sys_sendmsg net/socket.c:2162 [inline]
 __x64_sys_sendmsg+0x331/0x460 net/socket.c:2162
 do_syscall_64+0x15b/0x230 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
Local variable description: ----upt.i@dump_one_policy
Variable was created at:
 dump_one_policy+0x78/0x1090 net/xfrm/xfrm_user.c:1689
 xfrm_policy_walk+0x45a/0xd00 net/xfrm/xfrm_policy.c:1013

Byte 130 of 137 is uninitialized
Memory access starts at ffff88019550407f

Fixes: c0144beaeca42 ("[XFRM] netlink: Use nla_put()/NLA_PUT() variantes")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/xfrm/xfrm_user.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1515,9 +1515,11 @@ static inline size_t userpolicy_type_att
 #ifdef CONFIG_XFRM_SUB_POLICY
 static int copy_to_user_policy_type(u8 type, struct sk_buff *skb)
 {
-	struct xfrm_userpolicy_type upt = {
-		.type = type,
-	};
+	struct xfrm_userpolicy_type upt;
+
+	/* Sadly there are two holes in struct xfrm_userpolicy_type */
+	memset(&upt, 0, sizeof(upt));
+	upt.type = type;
 
 	return nla_put(skb, XFRMA_POLICY_TYPE, sizeof(upt), &upt);
 }

