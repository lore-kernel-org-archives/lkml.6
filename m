Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id s2p6FaE+GVuoSQAAmS7hNA
	; Thu, 07 Jun 2018 14:19:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 10B35608BF; Thu,  7 Jun 2018 14:19:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4C716602FC;
	Thu,  7 Jun 2018 14:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C716602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933493AbeFGOT1 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:19:27 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39501 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933088AbeFGOJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:13 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbD-0005Zm-08; Thu, 07 Jun 2018 15:09:11 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbA-00038x-19; Thu, 07 Jun 2018 15:09:08 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "James Chapman" <jchapman@katalix.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.867536872@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 291/410] l2tp: don't use inet_shutdown on ppp session
 destroy
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

commit 225eb26489d05c679a4c4197ffcb81c81e9dcaf4 upstream.

Previously, if a ppp session was closed, we called inet_shutdown to mark
the socket as unconnected such that userspace would get errors and
then close the socket. This could race with userspace closing the
socket. Instead, leave userspace to close the socket in its own time
(our session will be detached anyway).

BUG: KASAN: use-after-free in inet_shutdown+0x5d/0x1c0
Read of size 4 at addr ffff880010ea3ac0 by task syzbot_347bd5ac/8296

CPU: 3 PID: 8296 Comm: syzbot_347bd5ac Not tainted 4.16.0-rc1+ #91
Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
Call Trace:
 dump_stack+0x101/0x157
 ? inet_shutdown+0x5d/0x1c0
 print_address_description+0x78/0x260
 ? inet_shutdown+0x5d/0x1c0
 kasan_report+0x240/0x360
 __asan_load4+0x78/0x80
 inet_shutdown+0x5d/0x1c0
 ? pppol2tp_show+0x80/0x80
 pppol2tp_session_close+0x68/0xb0
 l2tp_tunnel_closeall+0x199/0x210
 ? udp_v6_flush_pending_frames+0x90/0x90
 l2tp_udp_encap_destroy+0x6b/0xc0
 ? l2tp_tunnel_del_work+0x2e0/0x2e0
 udpv6_destroy_sock+0x8c/0x90
 sk_common_release+0x47/0x190
 udp_lib_close+0x15/0x20
 inet_release+0x85/0xd0
 inet6_release+0x43/0x60
 sock_release+0x53/0x100
 ? sock_alloc_file+0x260/0x260
 sock_close+0x1b/0x20
 __fput+0x19f/0x380
 ____fput+0x1a/0x20
 task_work_run+0xd2/0x110
 exit_to_usermode_loop+0x18d/0x190
 do_syscall_64+0x389/0x3b0
 entry_SYSCALL_64_after_hwframe+0x26/0x9b
RIP: 0033:0x7fe240a45259
RSP: 002b:00007fe241132df8 EFLAGS: 00000297 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fe240a45259
RDX: 00007fe240a45259 RSI: 0000000000000000 RDI: 00000000000000a5
RBP: 00007fe241132e20 R08: 00007fe241133700 R09: 0000000000000000
R10: 00007fe241133700 R11: 0000000000000297 R12: 0000000000000000
R13: 00007ffc49aff84f R14: 0000000000000000 R15: 00007fe241141040

Allocated by task 8331:
 save_stack+0x43/0xd0
 kasan_kmalloc+0xad/0xe0
 kasan_slab_alloc+0x12/0x20
 kmem_cache_alloc+0x144/0x3e0
 sock_alloc_inode+0x22/0x130
 alloc_inode+0x3d/0xf0
 new_inode_pseudo+0x1c/0x90
 sock_alloc+0x30/0x110
 __sock_create+0xaa/0x4c0
 SyS_socket+0xbe/0x130
 do_syscall_64+0x128/0x3b0
 entry_SYSCALL_64_after_hwframe+0x26/0x9b

Freed by task 8314:
 save_stack+0x43/0xd0
 __kasan_slab_free+0x11a/0x170
 kasan_slab_free+0xe/0x10
 kmem_cache_free+0x88/0x2b0
 sock_destroy_inode+0x49/0x50
 destroy_inode+0x77/0xb0
 evict+0x285/0x340
 iput+0x429/0x530
 dentry_unlink_inode+0x28c/0x2c0
 __dentry_kill+0x1e3/0x2f0
 dput.part.21+0x500/0x560
 dput+0x24/0x30
 __fput+0x2aa/0x380
 ____fput+0x1a/0x20
 task_work_run+0xd2/0x110
 exit_to_usermode_loop+0x18d/0x190
 do_syscall_64+0x389/0x3b0
 entry_SYSCALL_64_after_hwframe+0x26/0x9b

Fixes: fd558d186df2c ("l2tp: Split pppol2tp patch into separate l2tp and ppp parts")
Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/l2tp/l2tp_ppp.c | 10 ----------
 1 file changed, 10 deletions(-)

--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -441,16 +441,6 @@ abort:
  */
 static void pppol2tp_session_close(struct l2tp_session *session)
 {
-	struct sock *sk;
-
-	BUG_ON(session->magic != L2TP_SESSION_MAGIC);
-
-	sk = pppol2tp_session_get_sock(session);
-	if (sk) {
-		if (sk->sk_socket)
-			inet_shutdown(sk->sk_socket, SEND_SHUTDOWN);
-		sock_put(sk);
-	}
 }
 
 /* Really kill the session socket. (Called from sock_put() if
