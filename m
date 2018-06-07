Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +PsUAyk/GVvBVwAAmS7hNA
	; Thu, 07 Jun 2018 14:20:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 29603608BA; Thu,  7 Jun 2018 14:20:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 873126063F;
	Thu,  7 Jun 2018 14:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 873126063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933468AbeFGOT2 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:19:28 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39498 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933086AbeFGOJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:13 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbC-0005hL-Vo; Thu, 07 Jun 2018 15:09:11 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb9-00038s-WF; Thu, 07 Jun 2018 15:09:08 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "James Chapman" <jchapman@katalix.com>,
        "David S. Miller" <davem@davemloft.net>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.837512026@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 290/410] l2tp: don't use inet_shutdown on tunnel destroy
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

From: James Chapman <jchapman@katalix.com>

commit 76a6abdb2513ad4ea0ded55d2c66160491f2e848 upstream.

Previously, if a tunnel was closed, we called inet_shutdown to mark
the socket as unconnected such that userspace would get errors and
then close the socket. This could race with userspace closing the
socket. Instead, leave userspace to close the socket in its own time
(our tunnel will be detached anyway).

BUG: unable to handle kernel NULL pointer dereference at 00000000000000a0
IP: __lock_acquire+0x263/0x1630
PGD 0 P4D 0
Oops: 0000 [#1] SMP KASAN
Modules linked in:
CPU: 2 PID: 42 Comm: kworker/u8:2 Not tainted 4.15.0-rc7+ #129
Workqueue: l2tp l2tp_tunnel_del_work
RIP: 0010:__lock_acquire+0x263/0x1630
RSP: 0018:ffff88001a37fc70 EFLAGS: 00010002
RAX: 0000000000000001 RBX: 0000000000000088 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88001a37fd18 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 00000000000076fd R12: 00000000000000a0
R13: ffff88001a3722c0 R14: 0000000000000001 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88001ad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000000a0 CR3: 000000001730b000 CR4: 00000000000006e0
Call Trace:
 ? __lock_acquire+0xc77/0x1630
 ? console_trylock+0x11/0xa0
 lock_acquire+0x117/0x230
 ? lock_sock_nested+0x3a/0xa0
 _raw_spin_lock_bh+0x3a/0x50
 ? lock_sock_nested+0x3a/0xa0
 lock_sock_nested+0x3a/0xa0
 inet_shutdown+0x33/0xf0
 l2tp_tunnel_del_work+0x60/0xef
 process_one_work+0x1ea/0x5f0
 ? process_one_work+0x162/0x5f0
 worker_thread+0x48/0x3e0
 ? trace_hardirqs_on+0xd/0x10
 kthread+0x108/0x140
 ? process_one_work+0x5f0/0x5f0
 ? kthread_stop+0x2a0/0x2a0
 ret_from_fork+0x24/0x30
Code: 00 41 81 ff ff 1f 00 00 0f 87 7a 13 00 00 45 85 f6 49 8b 85
68 08 00 00 0f 84 ae 03 00 00 c7 44 24 18 00 00 00 00 e9 f0 00 00 00 <49> 81 3c
24 80 93 3f 83 b8 00 00 00 00 44 0f 44 c0 83 fe 01 0f
RIP: __lock_acquire+0x263/0x1630 RSP: ffff88001a37fc70
CR2: 00000000000000a0

Fixes: 309795f4bec2d ("l2tp: Add netlink control API for L2TP")
Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/l2tp/l2tp_core.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1415,17 +1415,10 @@ static void l2tp_tunnel_del_work(struct
 
 	sock = sk->sk_socket;
 
-	/* If the tunnel socket was created by userspace, then go through the
-	 * inet layer to shut the socket down, and let userspace close it.
-	 * Otherwise, if we created the socket directly within the kernel, use
+	/* If the tunnel socket was created within the kernel, use
 	 * the sk API to release it here.
-	 * In either case the tunnel resources are freed in the socket
-	 * destructor when the tunnel socket goes away.
 	 */
-	if (tunnel->fd >= 0) {
-		if (sock)
-			inet_shutdown(sock, 2);
-	} else {
+	if (tunnel->fd < 0) {
 		if (sock)
 			kernel_sock_shutdown(sock, SHUT_RDWR);
 		sk_release_kernel(sk);
