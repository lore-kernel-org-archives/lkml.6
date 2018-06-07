Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id YJuZI1g/GVuFWQAAmS7hNA
	; Thu, 07 Jun 2018 14:21:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7F0D96089E; Thu,  7 Jun 2018 14:21:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C0EA86063F;
	Thu,  7 Jun 2018 14:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C0EA86063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933436AbeFGOTV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:19:21 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39504 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933087AbeFGOJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:13 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbD-0005Zp-7d; Thu, 07 Jun 2018 15:09:11 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbA-000397-3M; Thu, 07 Jun 2018 15:09:08 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "James Chapman" <jchapman@katalix.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.510344523@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 293/410] l2tp: fix race in pppol2tp_release with
 session object destroy
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

commit d02ba2a6110c530a32926af8ad441111774d2893 upstream.

pppol2tp_release uses call_rcu to put the final ref on its socket. But
the session object doesn't hold a ref on the session socket so may be
freed while the pppol2tp_put_sk RCU callback is scheduled. Fix this by
having the session hold a ref on its socket until the session is
destroyed. It is this ref that is dropped via call_rcu.

Sessions are also deleted via l2tp_tunnel_closeall. This must now also put
the final ref via call_rcu. So move the call_rcu call site into
pppol2tp_session_close so that this happens in both destroy paths. A
common destroy path should really be implemented, perhaps with
l2tp_tunnel_closeall calling l2tp_session_delete like pppol2tp_release
does, but this will be looked at later.

ODEBUG: activate active (active state 1) object type: rcu_head hint:           (null)
WARNING: CPU: 3 PID: 13407 at lib/debugobjects.c:291 debug_print_object+0x166/0x220
Modules linked in:
CPU: 3 PID: 13407 Comm: syzbot_19c09769 Not tainted 4.16.0-rc2+ #38
Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
RIP: 0010:debug_print_object+0x166/0x220
RSP: 0018:ffff880013647a00 EFLAGS: 00010082
RAX: dffffc0000000008 RBX: 0000000000000003 RCX: ffffffff814d3333
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff88001a59f6d0
RBP: ffff880013647a40 R08: 0000000000000000 R09: 0000000000000001
R10: ffff8800136479a8 R11: 0000000000000000 R12: 0000000000000001
R13: ffffffff86161420 R14: ffffffff85648b60 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88001a580000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020e77000 CR3: 0000000006022000 CR4: 00000000000006e0
Call Trace:
 debug_object_activate+0x38b/0x530
 ? debug_object_assert_init+0x3b0/0x3b0
 ? __mutex_unlock_slowpath+0x85/0x8b0
 ? pppol2tp_session_destruct+0x110/0x110
 __call_rcu.constprop.66+0x39/0x890
 ? __call_rcu.constprop.66+0x39/0x890
 call_rcu_sched+0x17/0x20
 pppol2tp_release+0x2c7/0x440
 ? fcntl_setlk+0xca0/0xca0
 ? sock_alloc_file+0x340/0x340
 sock_release+0x92/0x1e0
 sock_close+0x1b/0x20
 __fput+0x296/0x6e0
 ____fput+0x1a/0x20
 task_work_run+0x127/0x1a0
 do_exit+0x7f9/0x2ce0
 ? SYSC_connect+0x212/0x310
 ? mm_update_next_owner+0x690/0x690
 ? up_read+0x1f/0x40
 ? __do_page_fault+0x3c8/0xca0
 do_group_exit+0x10d/0x330
 ? do_group_exit+0x330/0x330
 SyS_exit_group+0x22/0x30
 do_syscall_64+0x1e0/0x730
 ? trace_hardirqs_off_thunk+0x1a/0x1c
 entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x7f362e471259
RSP: 002b:00007ffe389abe08 EFLAGS: 00000202 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f362e471259
RDX: 00007f362e471259 RSI: 000000000000002e RDI: 0000000000000000
RBP: 00007ffe389abe30 R08: 0000000000000000 R09: 00007f362e944270
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000400b60
R13: 00007ffe389abf50 R14: 0000000000000000 R15: 0000000000000000
Code: 8d 3c dd a0 8f 64 85 48 89 fa 48 c1 ea 03 80 3c 02 00 75 7b 48 8b 14 dd a0 8f 64 85 4c 89 f6 48 c7 c7 20 85 64 85 e
8 2a 55 14 ff <0f> 0b 83 05 ad 2a 68 04 01 48 83 c4 18 5b 41 5c 41 5d 41 5e 41

Fixes: ee40fb2e1eb5b ("l2tp: protect sock pointer of struct pppol2tp_session with RCU")
Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/l2tp/l2tp_ppp.c | 52 +++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -437,10 +437,28 @@ abort:
  * Session (and tunnel control) socket create/destroy.
  *****************************************************************************/
 
+static void pppol2tp_put_sk(struct rcu_head *head)
+{
+	struct pppol2tp_session *ps;
+
+	ps = container_of(head, typeof(*ps), rcu);
+	sock_put(ps->__sk);
+}
+
 /* Called by l2tp_core when a session socket is being closed.
  */
 static void pppol2tp_session_close(struct l2tp_session *session)
 {
+	struct pppol2tp_session *ps;
+
+	ps = l2tp_session_priv(session);
+	mutex_lock(&ps->sk_lock);
+	ps->__sk = rcu_dereference_protected(ps->sk,
+					     lockdep_is_held(&ps->sk_lock));
+	RCU_INIT_POINTER(ps->sk, NULL);
+	if (ps->__sk)
+		call_rcu(&ps->rcu, pppol2tp_put_sk);
+	mutex_unlock(&ps->sk_lock);
 }
 
 /* Really kill the session socket. (Called from sock_put() if
@@ -460,14 +478,6 @@ static void pppol2tp_session_destruct(st
 	}
 }
 
-static void pppol2tp_put_sk(struct rcu_head *head)
-{
-	struct pppol2tp_session *ps;
-
-	ps = container_of(head, typeof(*ps), rcu);
-	sock_put(ps->__sk);
-}
-
 /* Called when the PPPoX socket (session) is closed.
  */
 static int pppol2tp_release(struct socket *sock)
@@ -491,26 +501,17 @@ static int pppol2tp_release(struct socke
 	sock_orphan(sk);
 	sock->sk = NULL;
 
+	/* If the socket is associated with a session,
+	 * l2tp_session_delete will call pppol2tp_session_close which
+	 * will drop the session's ref on the socket.
+	 */
 	session = pppol2tp_sock_to_session(sk);
-
-	if (session != NULL) {
-		struct pppol2tp_session *ps;
-
+	if (session) {
 		l2tp_session_delete(session);
-
-		ps = l2tp_session_priv(session);
-		mutex_lock(&ps->sk_lock);
-		ps->__sk = rcu_dereference_protected(ps->sk,
-						     lockdep_is_held(&ps->sk_lock));
-		RCU_INIT_POINTER(ps->sk, NULL);
-		mutex_unlock(&ps->sk_lock);
-		call_rcu(&ps->rcu, pppol2tp_put_sk);
-
-		/* Rely on the sock_put() call at the end of the function for
-		 * dropping the reference held by pppol2tp_sock_to_session().
-		 * The last reference will be dropped by pppol2tp_put_sk().
-		 */
+		/* drop the ref obtained by pppol2tp_sock_to_session */
+		sock_put(sk);
 	}
+
 	release_sock(sk);
 
 	/* This will delete the session context via
@@ -815,6 +816,7 @@ static int pppol2tp_connect(struct socke
 
 out_no_ppp:
 	/* This is how we get the session context from the socket. */
+	sock_hold(sk);
 	sk->sk_user_data = session;
 	rcu_assign_pointer(ps->sk, sk);
 	mutex_unlock(&ps->sk_lock);
