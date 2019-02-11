Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FCCC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49EF7222B6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900505;
	bh=aFhXaMktWEHHYZoDlzM7G71BIMMYhNnetHdKDF8WNrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rEpngHNjGC3y/L/SDRnALXl+M/5u9Fp7X2MRYAPQA77hINnm7NL0jaOYBh2Um5wgE
	 ncb4eVnd9AH1xkrWDk1z+BhOEunghV1UjpFNUlC7ZuoBktN+uAPbeNikxrZ3tZgNLo
	 l+MoU9KxAO5hbscXNA3b6RZigZHPgLPg11yjpEm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731836AbfBKPzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:55:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:44042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731010AbfBKOfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:35:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBF72204EC;
        Mon, 11 Feb 2019 14:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895723;
        bh=aFhXaMktWEHHYZoDlzM7G71BIMMYhNnetHdKDF8WNrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rmplunq4DmsVnzP08JLHj/wTPyo82t/NwQC3C5/HvWJUiYWslA3+tTGOsldLct5cT
         xdAzOYxA63z4E8A/OVdRePgHTiCGME/o5I/IAllwVBKhQLzIp/etPI2URVCCiiOe/x
         t6+sXBgQ9Z6O7zXSOGw4LBlhQQ2rkGDBKbppHTu8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Sowmini Varadhan <sowmini.varadhan@oracle.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        rds-devel@oss.oracle.com, Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 301/352] rds: fix refcount bug in rds_sock_addref
Date:   Mon, 11 Feb 2019 15:18:48 +0100
Message-Id: <20190211141906.024771207@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

[ Upstream commit 6fa19f5637a6c22bc0999596bcc83bdcac8a4fa6 ]

syzbot was able to catch a bug in rds [1]

The issue here is that the socket might be found in a hash table
but that its refcount has already be set to 0 by another cpu.

We need to use refcount_inc_not_zero() to be safe here.

[1]

refcount_t: increment on 0; use-after-free.
WARNING: CPU: 1 PID: 23129 at lib/refcount.c:153 refcount_inc_checked lib/refcount.c:153 [inline]
WARNING: CPU: 1 PID: 23129 at lib/refcount.c:153 refcount_inc_checked+0x61/0x70 lib/refcount.c:151
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 23129 Comm: syz-executor3 Not tainted 5.0.0-rc4+ #53
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
 panic+0x2cb/0x65c kernel/panic.c:214
 __warn.cold+0x20/0x48 kernel/panic.c:571
 report_bug+0x263/0x2b0 lib/bug.c:186
 fixup_bug arch/x86/kernel/traps.c:178 [inline]
 fixup_bug arch/x86/kernel/traps.c:173 [inline]
 do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
 do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
 invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:refcount_inc_checked lib/refcount.c:153 [inline]
RIP: 0010:refcount_inc_checked+0x61/0x70 lib/refcount.c:151
Code: 1d 51 63 c8 06 31 ff 89 de e8 eb 1b f2 fd 84 db 75 dd e8 a2 1a f2 fd 48 c7 c7 60 9f 81 88 c6 05 31 63 c8 06 01 e8 af 65 bb fd <0f> 0b eb c1 90 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 41 54 49
RSP: 0018:ffff8880a0cbf1e8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc90006113000
RDX: 000000000001047d RSI: ffffffff81685776 RDI: 0000000000000005
RBP: ffff8880a0cbf1f8 R08: ffff888097c9e100 R09: ffffed1015ce5021
R10: ffffed1015ce5020 R11: ffff8880ae728107 R12: ffff8880723c20c0
R13: ffff8880723c24b0 R14: dffffc0000000000 R15: ffffed1014197e64
 sock_hold include/net/sock.h:647 [inline]
 rds_sock_addref+0x19/0x20 net/rds/af_rds.c:675
 rds_find_bound+0x97c/0x1080 net/rds/bind.c:82
 rds_recv_incoming+0x3be/0x1430 net/rds/recv.c:362
 rds_loop_xmit+0xf3/0x2a0 net/rds/loop.c:96
 rds_send_xmit+0x1355/0x2a10 net/rds/send.c:355
 rds_sendmsg+0x323c/0x44e0 net/rds/send.c:1368
 sock_sendmsg_nosec net/socket.c:621 [inline]
 sock_sendmsg+0xdd/0x130 net/socket.c:631
 __sys_sendto+0x387/0x5f0 net/socket.c:1788
 __do_sys_sendto net/socket.c:1800 [inline]
 __se_sys_sendto net/socket.c:1796 [inline]
 __x64_sys_sendto+0xe1/0x1a0 net/socket.c:1796
 do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458089
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fc266df8c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 0000000000458089
RDX: 0000000000000000 RSI: 00000000204b3fff RDI: 0000000000000005
RBP: 000000000073bf00 R08: 00000000202b4000 R09: 0000000000000010
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc266df96d4
R13: 00000000004c56e4 R14: 00000000004d94a8 R15: 00000000ffffffff

Fixes: cc4dfb7f70a3 ("rds: fix two RCU related problems")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Cc: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc: rds-devel@oss.oracle.com
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rds/bind.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/net/rds/bind.c
+++ b/net/rds/bind.c
@@ -78,10 +78,10 @@ struct rds_sock *rds_find_bound(const st
 	__rds_create_bind_key(key, addr, port, scope_id);
 	rcu_read_lock();
 	rs = rhashtable_lookup(&bind_hash_table, key, ht_parms);
-	if (rs && !sock_flag(rds_rs_to_sk(rs), SOCK_DEAD))
-		rds_sock_addref(rs);
-	else
+	if (rs && (sock_flag(rds_rs_to_sk(rs), SOCK_DEAD) ||
+		   !refcount_inc_not_zero(&rds_rs_to_sk(rs)->sk_refcnt)))
 		rs = NULL;
+
 	rcu_read_unlock();
 
 	rdsdebug("returning rs %p for %pI6c:%u\n", rs, addr,


