Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDACC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47ED820876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47ED820876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbeJNXbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:31:22 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37400 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728546AbeJNXbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:31:21 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiM6-0004cm-9L; Sun, 14 Oct 2018 16:30:58 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLR-0000JD-Mm; Sun, 14 Oct 2018 16:30:17 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Vlad Yasevich" <vyasevich@gmail.com>,
        "syzbot" <syzkaller@googlegroups.com>,
        "Neil Horman" <nhorman@tuxdriver.com>,
        "Eric Dumazet" <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.674755289@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 124/366] sctp: do not leak kernel memory to user space
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

commit 6780db244d6b1537d139dea0ec8aad10cf9e4adb upstream.

syzbot produced a nice report [1]

Issue here is that a recvmmsg() managed to leak 8 bytes of kernel memory
to user space, because sin_zero (padding field) was not properly cleared.

[1]
BUG: KMSAN: uninit-value in copy_to_user include/linux/uaccess.h:184 [inline]
BUG: KMSAN: uninit-value in move_addr_to_user+0x32e/0x530 net/socket.c:227
CPU: 1 PID: 3586 Comm: syzkaller481044 Not tainted 4.16.0+ #82
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:53
 kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
 kmsan_internal_check_memory+0x164/0x1d0 mm/kmsan/kmsan.c:1176
 kmsan_copy_to_user+0x69/0x160 mm/kmsan/kmsan.c:1199
 copy_to_user include/linux/uaccess.h:184 [inline]
 move_addr_to_user+0x32e/0x530 net/socket.c:227
 ___sys_recvmsg+0x4e2/0x810 net/socket.c:2211
 __sys_recvmmsg+0x54e/0xdb0 net/socket.c:2313
 SYSC_recvmmsg+0x29b/0x3e0 net/socket.c:2394
 SyS_recvmmsg+0x76/0xa0 net/socket.c:2378
 do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x4401c9
RSP: 002b:00007ffc56f73098 EFLAGS: 00000217 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004401c9
RDX: 0000000000000001 RSI: 0000000020003ac0 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000020003bc0 R09: 0000000000000010
R10: 0000000000000000 R11: 0000000000000217 R12: 0000000000401af0
R13: 0000000000401b80 R14: 0000000000000000 R15: 0000000000000000

Local variable description: ----addr@___sys_recvmsg
Variable was created at:
 ___sys_recvmsg+0xd5/0x810 net/socket.c:2172
 __sys_recvmmsg+0x54e/0xdb0 net/socket.c:2313

Bytes 8-15 of 16 are uninitialized

==================================================================
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 3586 Comm: syzkaller481044 Tainted: G    B            4.16.0+ #82
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:53
 panic+0x39d/0x940 kernel/panic.c:183
 kmsan_report+0x238/0x240 mm/kmsan/kmsan.c:1083
 kmsan_internal_check_memory+0x164/0x1d0 mm/kmsan/kmsan.c:1176
 kmsan_copy_to_user+0x69/0x160 mm/kmsan/kmsan.c:1199
 copy_to_user include/linux/uaccess.h:184 [inline]
 move_addr_to_user+0x32e/0x530 net/socket.c:227
 ___sys_recvmsg+0x4e2/0x810 net/socket.c:2211
 __sys_recvmmsg+0x54e/0xdb0 net/socket.c:2313
 SYSC_recvmmsg+0x29b/0x3e0 net/socket.c:2394
 SyS_recvmmsg+0x76/0xa0 net/socket.c:2378
 do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc:	Vlad Yasevich <vyasevich@gmail.com>
Cc:	Neil Horman <nhorman@tuxdriver.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/sctp/ipv6.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -700,8 +700,10 @@ static int sctp_v6_addr_to_user(struct s
 			sctp_v6_map_v4(addr);
 	}
 
-	if (addr->sa.sa_family == AF_INET)
+	if (addr->sa.sa_family == AF_INET) {
+		memset(addr->v4.sin_zero, 0, sizeof(addr->v4.sin_zero));
 		return sizeof(struct sockaddr_in);
+	}
 	return sizeof(struct sockaddr_in6);
 }
 

