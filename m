Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CD6C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E2D20700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895736;
	bh=iCW2KEFq4AH5UUEFSlO+RY0fpm4QhOj9FaCtFGK1x6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gr0krgyGgBqBZiZYn6aX37H077krI2a37dNEplFvWo3mhb0Ev/ggeeFvyzVfU3FL0
	 fBxgu6E0ENddkOqg2SsZ+mueLa3WJNmNUVI/+BMmABl6srGnOQXG7RVqQIlVE2XBH9
	 FIt1cCcKl1vQu8G453f/VuV+KCct7lZafzGTIA1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbfBKOff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:35:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:44148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731033AbfBKOfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:35:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0518E204EC;
        Mon, 11 Feb 2019 14:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895729;
        bh=iCW2KEFq4AH5UUEFSlO+RY0fpm4QhOj9FaCtFGK1x6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xdo0gNX/fAeGFilQ/LnxV/A8pqd4RM8qP8DWHAdGu+Enb08KOXxoCXKGUEnGaMM63
         Wt7mXRT6c/4+Acyk7PKf5NLEaZi276Mf/bloeDQgLN358dnCX2y2p5uJZqOL31L/Pd
         gpQUEugOdafBFZqtEFQZLOTgezpDszEjcRwQTgcE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        David Howells <dhowells@redhat.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 303/352] rxrpc: bad unlock balance in rxrpc_recvmsg
Date:   Mon, 11 Feb 2019 15:18:50 +0100
Message-Id: <20190211141906.151706537@linuxfoundation.org>
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
@@ -596,6 +596,7 @@ error_requeue_call:
 	}
 error_no_call:
 	release_sock(&rx->sk);
+error_trace:
 	trace_rxrpc_recvmsg(call, rxrpc_recvmsg_return, 0, 0, 0, ret);
 	return ret;
 
@@ -604,7 +605,7 @@ wait_interrupted:
 wait_error:
 	finish_wait(sk_sleep(&rx->sk), &wait);
 	call = NULL;
-	goto error_no_call;
+	goto error_trace;
 }
 
 /**


