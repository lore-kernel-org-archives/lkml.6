Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD70FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9402080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9402080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbeKLGFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:05:16 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53058 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731042AbeKLGFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:05:15 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt4-0000oN-4Q; Sun, 11 Nov 2018 19:59:14 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsR-0001WB-9u; Sun, 11 Nov 2018 19:58:35 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Guillaume Nault" <g.nault@alphalink.fr>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.916252727@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 116/366] l2tp: fix refcount leakage on PPPoL2TP sockets
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

From: Guillaume Nault <g.nault@alphalink.fr>

commit 3d609342cc04129ff7568e19316ce3d7451a27e8 upstream.

Commit d02ba2a6110c ("l2tp: fix race in pppol2tp_release with session
object destroy") tried to fix a race condition where a PPPoL2TP socket
would disappear while the L2TP session was still using it. However, it
missed the root issue which is that an L2TP session may accept to be
reconnected if its associated socket has entered the release process.

The tentative fix makes the session hold the socket it is connected to.
That saves the kernel from crashing, but introduces refcount leakage,
preventing the socket from completing the release process. Once stalled,
everything the socket depends on can't be released anymore, including
the L2TP session and the l2tp_ppp module.

The root issue is that, when releasing a connected PPPoL2TP socket, the
session's ->sk pointer (RCU-protected) is reset to NULL and we have to
wait for a grace period before destroying the socket. The socket drops
the session in its ->sk_destruct callback function, so the session
will exist until the last reference on the socket is dropped.
Therefore, there is a time frame where pppol2tp_connect() may accept
reconnecting a session, as it only checks ->sk to figure out if the
session is connected. This time frame is shortened by the fact that
pppol2tp_release() calls l2tp_session_delete(), making the session
unreachable before resetting ->sk. However, pppol2tp_connect() may
grab the session before it gets unhashed by l2tp_session_delete(), but
it may test ->sk after the later got reset. The race is not so hard to
trigger and syzbot found a pretty reliable reproducer:
https://syzkaller.appspot.com/bug?id=418578d2a4389074524e04d641eacb091961b2cf

Before d02ba2a6110c, another race could let pppol2tp_release()
overwrite the ->__sk pointer of an L2TP session, thus tricking
pppol2tp_put_sk() into calling sock_put() on a socket that is different
than the one for which pppol2tp_release() was originally called. To get
there, we had to trigger the race described above, therefore having one
PPPoL2TP socket being released, while the session it is connected to is
reconnecting to a different PPPoL2TP socket. When releasing this new
socket fast enough, pppol2tp_release() overwrites the session's
->__sk pointer with the address of the new socket, before the first
pppol2tp_put_sk() call gets scheduled. Then the pppol2tp_put_sk() call
invoked by the original socket will sock_put() the new socket,
potentially dropping its last reference. When the second
pppol2tp_put_sk() finally runs, its socket has already been freed.

With d02ba2a6110c, the session takes a reference on both sockets.
Furthermore, the session's ->sk pointer is reset in the
pppol2tp_session_close() callback function rather than in
pppol2tp_release(). Therefore, ->__sk can't be overwritten and
pppol2tp_put_sk() is called only once (l2tp_session_delete() will only
run pppol2tp_session_close() once, to protect the session against
concurrent deletion requests). Now pppol2tp_put_sk() will properly
sock_put() the original socket, but the new socket will remain, as
l2tp_session_delete() prevented the release process from completing.
Here, we don't depend on the ->__sk race to trigger the bug. Getting
into the pppol2tp_connect() race is enough to leak the reference, no
matter when new socket is released.

So it all boils down to pppol2tp_connect() failing to realise that the
session has already been connected. This patch drops the unneeded extra
reference counting (mostly reverting d02ba2a6110c) and checks that
neither ->sk nor ->__sk is set before allowing a session to be
connected.

Fixes: d02ba2a6110c ("l2tp: fix race in pppol2tp_release with session object destroy")
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/l2tp/l2tp_ppp.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -449,16 +449,6 @@ static void pppol2tp_put_sk(struct rcu_h
  */
 static void pppol2tp_session_close(struct l2tp_session *session)
 {
-	struct pppol2tp_session *ps;
-
-	ps = l2tp_session_priv(session);
-	mutex_lock(&ps->sk_lock);
-	ps->__sk = rcu_dereference_protected(ps->sk,
-					     lockdep_is_held(&ps->sk_lock));
-	RCU_INIT_POINTER(ps->sk, NULL);
-	if (ps->__sk)
-		call_rcu(&ps->rcu, pppol2tp_put_sk);
-	mutex_unlock(&ps->sk_lock);
 }
 
 /* Really kill the session socket. (Called from sock_put() if
@@ -501,15 +491,24 @@ static int pppol2tp_release(struct socke
 	sock_orphan(sk);
 	sock->sk = NULL;
 
-	/* If the socket is associated with a session,
-	 * l2tp_session_delete will call pppol2tp_session_close which
-	 * will drop the session's ref on the socket.
-	 */
 	session = pppol2tp_sock_to_session(sk);
 	if (session) {
+		struct pppol2tp_session *ps;
+
 		l2tp_session_delete(session);
-		/* drop the ref obtained by pppol2tp_sock_to_session */
-		sock_put(sk);
+
+		ps = l2tp_session_priv(session);
+		mutex_lock(&ps->sk_lock);
+		ps->__sk = rcu_dereference_protected(ps->sk,
+						     lockdep_is_held(&ps->sk_lock));
+		RCU_INIT_POINTER(ps->sk, NULL);
+		mutex_unlock(&ps->sk_lock);
+		call_rcu(&ps->rcu, pppol2tp_put_sk);
+
+		/* Rely on the sock_put() call at the end of the function for
+		 * dropping the reference held by pppol2tp_sock_to_session().
+		 * The last reference will be dropped by pppol2tp_put_sk().
+		 */
 	}
 
 	release_sock(sk);
@@ -764,7 +763,8 @@ static int pppol2tp_connect(struct socke
 		 */
 		mutex_lock(&ps->sk_lock);
 		if (rcu_dereference_protected(ps->sk,
-					      lockdep_is_held(&ps->sk_lock))) {
+					      lockdep_is_held(&ps->sk_lock)) ||
+		    ps->__sk) {
 			mutex_unlock(&ps->sk_lock);
 			error = -EEXIST;
 			goto end;
@@ -832,7 +832,6 @@ static int pppol2tp_connect(struct socke
 
 out_no_ppp:
 	/* This is how we get the session context from the socket. */
-	sock_hold(sk);
 	sk->sk_user_data = session;
 	rcu_assign_pointer(ps->sk, sk);
 	mutex_unlock(&ps->sk_lock);

