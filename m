Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F5AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F10222AE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897345;
	bh=2qb+M/skbJ5u9Ww5ysI7/GTNilLZqUw4B4UdT3zov9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=opIHgVvGl57+aGd09RZG0lJNVOR4PbVTugLHL3gV51WG0D16MqWmiZWnKAxBrNnOP
	 SFSjrKNPie+mdTZxrbotfCOzNjoHIetwLpZxckc+kuratGQs1IsuZN3BVd5v6ODV3s
	 s2sIbSw5sI0Y2T1v1CJIKyVYYqNShO1jPfEM3BNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390403AbfBKPCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:02:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:50522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390391AbfBKPCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:02:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BCB7222A7;
        Mon, 11 Feb 2019 15:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897340;
        bh=2qb+M/skbJ5u9Ww5ysI7/GTNilLZqUw4B4UdT3zov9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eqbn8Og+QKmwAtXY9N/lgARUi4JcJby72CS+y1cMx0V/dOwhDmRUyD9MgL7OaZ9oi
         xAthvzCoDvuas8YxHqsM42zBn4HONffbkkEuF0/937dBYff9GurZCgdqcqjdArt+sB
         su/NWJRa8pq4AJyUR45WA1VW5L4GCX35qSZZ07RM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        David Howells <dhowells@redhat.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 169/205] rxrpc: bad unlock balance in rxrpc_recvmsg
Date:   Mon, 11 Feb 2019 15:19:27 +0100
Message-Id: <20190211141839.415424751@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 6dce3c20ac429e7a651d728e375853370c796e8d ]

When either "goto wait_interrupted;" or "goto wait_error;"
paths are taken, socket lock has already been released.

This patch fixes following syzbot splat :

WARNING: bad unlock balance detected!
5.0.0-rc4+ #59 Not tainted
-------------------------------------
syz-executor223/8256 is trying to release lock (sk_lock-AF_RXRPC) at:
[<ffffffff86651353>] rxrpc_recvmsg+0x6d3/0x3099 net/rxrpc/recvmsg.c:598
but there are no more locks to release!

other info that might help us debug this:
1 lock held by syz-executor223/8256:
 #0: 00000000fa9ed0f4 (slock-AF_RXRPC){+...}, at: spin_lock_bh include/linux/spinlock.h:334 [inline]
 #0: 00000000fa9ed0f4 (slock-AF_RXRPC){+...}, at: release_sock+0x20/0x1c0 net/core/sock.c:2798

stack backtrace:
CPU: 1 PID: 8256 Comm: syz-executor223 Not tainted 5.0.0-rc4+ #59
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x172/0x1f0 lib/dump_stack.c:113
 print_unlock_imbalance_bug kernel/locking/lockdep.c:3391 [inline]
 print_unlock_imbalance_bug.cold+0x114/0x123 kernel/locking/lockdep.c:3368
 __lock_release kernel/locking/lockdep.c:3601 [inline]
 lock_release+0x67e/0xa00 kernel/locking/lockdep.c:3860
 sock_release_ownership include/net/sock.h:1471 [inline]
 release_sock+0x183/0x1c0 net/core/sock.c:2808
 rxrpc_recvmsg+0x6d3/0x3099 net/rxrpc/recvmsg.c:598
 sock_recvmsg_nosec net/socket.c:794 [inline]
 sock_recvmsg net/socket.c:801 [inline]
 sock_recvmsg+0xd0/0x110 net/socket.c:797
 __sys_recvfrom+0x1ff/0x350 net/socket.c:1845
 __do_sys_recvfrom net/socket.c:1863 [inline]
 __se_sys_recvfrom net/socket.c:1859 [inline]
 __x64_sys_recvfrom+0xe1/0x1a0 net/socket.c:1859
 do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446379
Code: e8 2c b3 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 2b 09 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fe5da89fd98 EFLAGS: 00000246 ORIG_RAX: 000000000000002d
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446379
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 0000000000000000 R14: 0000000000000000 R15: 20c49ba5e353f7cf

Fixes: 248f219cb8bc ("rxrpc: Rewrite the data and ack handling code")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: David Howells <dhowells@redhat.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/recvmsg.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -588,6 +588,7 @@ error_requeue_call:
 	}
 error_no_call:
 	release_sock(&rx->sk);
+error_trace:
 	trace_rxrpc_recvmsg(call, rxrpc_recvmsg_return, 0, 0, 0, ret);
 	return ret;
 
@@ -596,7 +597,7 @@ wait_interrupted:
 wait_error:
 	finish_wait(sk_sleep(&rx->sk), &wait);
 	call = NULL;
-	goto error_no_call;
+	goto error_trace;
 }
 
 /**


