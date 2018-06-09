Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id O1NUJBX3G1uIeQAAmS7hNA
	; Sat, 09 Jun 2018 15:53:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 98B92608C1; Sat,  9 Jun 2018 15:53:09 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNGLtTJI"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C9DBB606FA;
	Sat,  9 Jun 2018 15:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C9DBB606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753522AbeFIPbP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:31:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753503AbeFIPbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:31:09 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B478204EC;
        Sat,  9 Jun 2018 15:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558268;
        bh=X2Cd0iKib/BA1bvvBtjnZIpTd0Kmt6AZ74Ee7eGvzdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CNGLtTJIxVWk3E7AfzlLhYIAwD88Y9YLhxG70wfS4QwlnwXMLgEZR/yOB0OzMuzu9
         Y3oO5XTKN97QOgWxK9FB19tpzlPErB+pm+qGb3udjiR6S7MgXnzBvsqmP33YFERa71
         CbDw24TkEXztmjcHkXsYKgE5yq2oG6glL9TpGKu4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guillaume Nault <g.nault@alphalink.fr>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 05/15] l2tp: fix refcount leakage on PPPoL2TP sockets
Date: Sat,  9 Jun 2018 17:29:40 +0200
Message-Id: <20180609150001.018772501@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609150000.746833461@linuxfoundation.org>
References: <20180609150000.746833461@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guillaume Nault <g.nault@alphalink.fr>

[ Upstream commit 3d609342cc04129ff7568e19316ce3d7451a27e8 ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/l2tp/l2tp_ppp.c |   35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -428,16 +428,6 @@ static void pppol2tp_put_sk(struct rcu_h
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
@@ -480,15 +470,24 @@ static int pppol2tp_release(struct socke
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
@@ -742,7 +741,8 @@ static int pppol2tp_connect(struct socke
 		 */
 		mutex_lock(&ps->sk_lock);
 		if (rcu_dereference_protected(ps->sk,
-					      lockdep_is_held(&ps->sk_lock))) {
+					      lockdep_is_held(&ps->sk_lock)) ||
+		    ps->__sk) {
 			mutex_unlock(&ps->sk_lock);
 			error = -EEXIST;
 			goto end;
@@ -803,7 +803,6 @@ static int pppol2tp_connect(struct socke
 
 out_no_ppp:
 	/* This is how we get the session context from the socket. */
-	sock_hold(sk);
 	sk->sk_user_data = session;
 	rcu_assign_pointer(ps->sk, sk);
 	mutex_unlock(&ps->sk_lock);
