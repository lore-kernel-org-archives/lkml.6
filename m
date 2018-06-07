Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id S9eGLQQ/GVtrUAAAmS7hNA
	; Thu, 07 Jun 2018 14:19:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A9039608BA; Thu,  7 Jun 2018 14:19:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id ADF16602FC;
	Thu,  7 Jun 2018 14:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ADF16602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933541AbeFGOTc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:19:32 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39492 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933084AbeFGOJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:13 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbC-0005hK-Uu; Thu, 07 Jun 2018 15:09:11 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb9-00038m-VT; Thu, 07 Jun 2018 15:09:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Guillaume Nault" <g.nault@alphalink.fr>,
        "David S. Miller" <davem@davemloft.net>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.884713559@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 289/410] l2tp: avoid using ->tunnel_sock for getting
 session's parent tunnel
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

From: Guillaume Nault <g.nault@alphalink.fr>

commit 7198c77aa05560c257ee377ec1f4796812121580 upstream.

Sessions don't need to use l2tp_sock_to_tunnel(xxx->tunnel_sock) for
accessing their parent tunnel. They have the .tunnel field in the
l2tp_session structure for that. Furthermore, in all these cases, the
session is registered, so we're guaranteed that .tunnel isn't NULL and
that the session properly holds a reference on the tunnel.

Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/l2tp/l2tp_ppp.c | 66 +++++++++------------------------------------
 1 file changed, 12 insertions(+), 54 deletions(-)

--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -312,7 +312,6 @@ static int pppol2tp_sendmsg(struct kiocb
 	int error;
 	struct l2tp_session *session;
 	struct l2tp_tunnel *tunnel;
-	struct pppol2tp_session *ps;
 	int uhlen;
 
 	error = -ENOTCONN;
@@ -325,10 +324,7 @@ static int pppol2tp_sendmsg(struct kiocb
 	if (session == NULL)
 		goto error;
 
-	ps = l2tp_session_priv(session);
-	tunnel = l2tp_sock_to_tunnel(ps->tunnel_sock);
-	if (tunnel == NULL)
-		goto error_put_sess;
+	tunnel = session->tunnel;
 
 	uhlen = (tunnel->encap == L2TP_ENCAPTYPE_UDP) ? sizeof(struct udphdr) : 0;
 
@@ -339,7 +335,7 @@ static int pppol2tp_sendmsg(struct kiocb
 			   sizeof(ppph) + total_len,
 			   0, GFP_KERNEL);
 	if (!skb)
-		goto error_put_sess_tun;
+		goto error_put_sess;
 
 	/* Reserve space for headers. */
 	skb_reserve(skb, NET_SKB_PAD);
@@ -358,20 +354,17 @@ static int pppol2tp_sendmsg(struct kiocb
 				 total_len);
 	if (error < 0) {
 		kfree_skb(skb);
-		goto error_put_sess_tun;
+		goto error_put_sess;
 	}
 
 	local_bh_disable();
 	l2tp_xmit_skb(session, skb, session->hdr_len);
 	local_bh_enable();
 
-	sock_put(ps->tunnel_sock);
 	sock_put(sk);
 
 	return total_len;
 
-error_put_sess_tun:
-	sock_put(ps->tunnel_sock);
 error_put_sess:
 	sock_put(sk);
 error:
@@ -396,10 +389,8 @@ static int pppol2tp_xmit(struct ppp_chan
 {
 	static const u8 ppph[2] = { 0xff, 0x03 };
 	struct sock *sk = (struct sock *) chan->private;
-	struct sock *sk_tun;
 	struct l2tp_session *session;
 	struct l2tp_tunnel *tunnel;
-	struct pppol2tp_session *ps;
 	int uhlen, headroom;
 
 	if (sock_flag(sk, SOCK_DEAD) || !(sk->sk_state & PPPOX_CONNECTED))
@@ -410,13 +401,7 @@ static int pppol2tp_xmit(struct ppp_chan
 	if (session == NULL)
 		goto abort;
 
-	ps = l2tp_session_priv(session);
-	sk_tun = ps->tunnel_sock;
-	if (sk_tun == NULL)
-		goto abort_put_sess;
-	tunnel = l2tp_sock_to_tunnel(sk_tun);
-	if (tunnel == NULL)
-		goto abort_put_sess;
+	tunnel = session->tunnel;
 
 	uhlen = (tunnel->encap == L2TP_ENCAPTYPE_UDP) ? sizeof(struct udphdr) : 0;
 	headroom = NET_SKB_PAD +
@@ -425,7 +410,7 @@ static int pppol2tp_xmit(struct ppp_chan
 		   session->hdr_len +	/* L2TP header */
 		   sizeof(ppph);	/* PPP header */
 	if (skb_cow_head(skb, headroom))
-		goto abort_put_sess_tun;
+		goto abort_put_sess;
 
 	/* Setup PPP header */
 	__skb_push(skb, sizeof(ppph));
@@ -436,12 +421,10 @@ static int pppol2tp_xmit(struct ppp_chan
 	l2tp_xmit_skb(session, skb, session->hdr_len);
 	local_bh_enable();
 
-	sock_put(sk_tun);
 	sock_put(sk);
+
 	return 1;
 
-abort_put_sess_tun:
-	sock_put(sk_tun);
 abort_put_sess:
 	sock_put(sk);
 abort:
@@ -938,9 +921,7 @@ static int pppol2tp_getname(struct socke
 		goto end;
 
 	pls = l2tp_session_priv(session);
-	tunnel = l2tp_sock_to_tunnel(pls->tunnel_sock);
-	if (tunnel == NULL)
-		goto end_put_sess;
+	tunnel = session->tunnel;
 
 	inet = inet_sk(tunnel->sock);
 	if ((tunnel->version == 2) && (tunnel->sock->sk_family == AF_INET)) {
@@ -1020,8 +1001,6 @@ static int pppol2tp_getname(struct socke
 	*usockaddr_len = len;
 	error = 0;
 
-	sock_put(pls->tunnel_sock);
-end_put_sess:
 	sock_put(sk);
 end:
 	return error;
@@ -1262,7 +1241,6 @@ static int pppol2tp_ioctl(struct socket
 	struct sock *sk = sock->sk;
 	struct l2tp_session *session;
 	struct l2tp_tunnel *tunnel;
-	struct pppol2tp_session *ps;
 	int err;
 
 	if (!sk)
@@ -1286,16 +1264,10 @@ static int pppol2tp_ioctl(struct socket
 	/* Special case: if session's session_id is zero, treat ioctl as a
 	 * tunnel ioctl
 	 */
-	ps = l2tp_session_priv(session);
 	if ((session->session_id == 0) &&
 	    (session->peer_session_id == 0)) {
-		err = -EBADF;
-		tunnel = l2tp_sock_to_tunnel(ps->tunnel_sock);
-		if (tunnel == NULL)
-			goto end_put_sess;
-
+		tunnel = session->tunnel;
 		err = pppol2tp_tunnel_ioctl(tunnel, cmd, arg);
-		sock_put(ps->tunnel_sock);
 		goto end_put_sess;
 	}
 
@@ -1421,7 +1393,6 @@ static int pppol2tp_setsockopt(struct so
 	struct sock *sk = sock->sk;
 	struct l2tp_session *session;
 	struct l2tp_tunnel *tunnel;
-	struct pppol2tp_session *ps;
 	int val;
 	int err;
 
@@ -1446,20 +1417,14 @@ static int pppol2tp_setsockopt(struct so
 
 	/* Special case: if session_id == 0x0000, treat as operation on tunnel
 	 */
-	ps = l2tp_session_priv(session);
 	if ((session->session_id == 0) &&
 	    (session->peer_session_id == 0)) {
-		err = -EBADF;
-		tunnel = l2tp_sock_to_tunnel(ps->tunnel_sock);
-		if (tunnel == NULL)
-			goto end_put_sess;
-
+		tunnel = session->tunnel;
 		err = pppol2tp_tunnel_setsockopt(sk, tunnel, optname, val);
-		sock_put(ps->tunnel_sock);
-	} else
+	} else {
 		err = pppol2tp_session_setsockopt(sk, session, optname, val);
+	}
 
-end_put_sess:
 	sock_put(sk);
 end:
 	return err;
@@ -1547,7 +1512,6 @@ static int pppol2tp_getsockopt(struct so
 	struct l2tp_tunnel *tunnel;
 	int val, len;
 	int err;
-	struct pppol2tp_session *ps;
 
 	if (level != SOL_PPPOL2TP)
 		return -EINVAL;
@@ -1571,16 +1535,10 @@ static int pppol2tp_getsockopt(struct so
 		goto end;
 
 	/* Special case: if session_id == 0x0000, treat as operation on tunnel */
-	ps = l2tp_session_priv(session);
 	if ((session->session_id == 0) &&
 	    (session->peer_session_id == 0)) {
-		err = -EBADF;
-		tunnel = l2tp_sock_to_tunnel(ps->tunnel_sock);
-		if (tunnel == NULL)
-			goto end_put_sess;
-
+		tunnel = session->tunnel;
 		err = pppol2tp_tunnel_getsockopt(sk, tunnel, optname, &val);
-		sock_put(ps->tunnel_sock);
 		if (err)
 			goto end_put_sess;
 	} else {
