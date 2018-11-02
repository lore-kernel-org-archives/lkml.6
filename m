Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43FBC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58FB82082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wl+wSgUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58FB82082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbeKCDpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:45:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbeKCDpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:45:38 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E01B82081B;
        Fri,  2 Nov 2018 18:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541183846;
        bh=RoJiZTqKf0yAWBl2Zd5jgZNvGRdUNt2rCa73eXZitkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wl+wSgUDZmPVFAJagfqtxnfeRMnYXz+OYIVDXWhBmust8K+tazZPU8W/dWjZha03n
         z6sLIgrbrX2iaUPsUQ+a/M5rXDKvYCRS9+mEC/8k7gd/ZA70OcXhtzQoG3Aqi9Lbyl
         GrQ8+hhTbNmn2bFCCoPvUA8PzZoEolZw6/Wo5zgo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 07/24] Revert "net: simplify sock_poll_wait"
Date:   Fri,  2 Nov 2018 19:34:40 +0100
Message-Id: <20181102182840.877098602@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182839.725385066@linuxfoundation.org>
References: <20181102182839.725385066@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Karsten Graul <kgraul@linux.ibm.com>

[ Upstream commit 89ab066d4229acd32e323f1569833302544a4186 ]

This reverts commit dd979b4df817e9976f18fb6f9d134d6bc4a3c317.

This broke tcp_poll for SMC fallback: An AF_SMC socket establishes an
internal TCP socket for the initial handshake with the remote peer.
Whenever the SMC connection can not be established this TCP socket is
used as a fallback. All socket operations on the SMC socket are then
forwarded to the TCP socket. In case of poll, the file->private_data
pointer references the SMC socket because the TCP socket has no file
assigned. This causes tcp_poll to wait on the wrong socket.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 crypto/af_alg.c        |    2 +-
 include/net/sock.h     |   12 +++++++++---
 net/atm/common.c       |    2 +-
 net/caif/caif_socket.c |    2 +-
 net/core/datagram.c    |    2 +-
 net/dccp/proto.c       |    2 +-
 net/ipv4/tcp.c         |    2 +-
 net/iucv/af_iucv.c     |    2 +-
 net/nfc/llcp_sock.c    |    2 +-
 net/rxrpc/af_rxrpc.c   |    2 +-
 net/smc/af_smc.c       |    2 +-
 net/tipc/socket.c      |    2 +-
 net/unix/af_unix.c     |    4 ++--
 13 files changed, 22 insertions(+), 16 deletions(-)

--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -1071,7 +1071,7 @@ __poll_t af_alg_poll(struct file *file,
 	struct af_alg_ctx *ctx = ask->private;
 	__poll_t mask;
 
-	sock_poll_wait(file, wait);
+	sock_poll_wait(file, sock, wait);
 	mask = 0;
 
 	if (!ctx->more || ctx->used)
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2057,14 +2057,20 @@ static inline bool skwq_has_sleeper(stru
 /**
  * sock_poll_wait - place memory barrier behind the poll_wait call.
  * @filp:           file
+ * @sock:           socket to wait on
  * @p:              poll_table
  *
  * See the comments in the wq_has_sleeper function.
+ *
+ * Do not derive sock from filp->private_data here. An SMC socket establishes
+ * an internal TCP socket that is used in the fallback case. All socket
+ * operations on the SMC socket are then forwarded to the TCP socket. In case of
+ * poll, the filp->private_data pointer references the SMC socket because the
+ * TCP socket has no file assigned.
  */
-static inline void sock_poll_wait(struct file *filp, poll_table *p)
+static inline void sock_poll_wait(struct file *filp, struct socket *sock,
+				  poll_table *p)
 {
-	struct socket *sock = filp->private_data;
-
 	if (!poll_does_not_wait(p)) {
 		poll_wait(filp, &sock->wq->wait, p);
 		/* We need to be sure we are in sync with the
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -653,7 +653,7 @@ __poll_t vcc_poll(struct file *file, str
 	struct atm_vcc *vcc;
 	__poll_t mask;
 
-	sock_poll_wait(file, wait);
+	sock_poll_wait(file, sock, wait);
 	mask = 0;
 
 	vcc = ATM_SD(sock);
--- a/net/caif/caif_socket.c
+++ b/net/caif/caif_socket.c
@@ -941,7 +941,7 @@ static __poll_t caif_poll(struct file *f
 	__poll_t mask;
 	struct caifsock *cf_sk = container_of(sk, struct caifsock, sk);
 
-	sock_poll_wait(file, wait);
+	sock_poll_wait(file, sock, wait);
 	mask = 0;
 
 	/* exceptional events? */
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -838,7 +838,7 @@ __poll_t datagram_poll(struct file *file
 	struct sock *sk = sock->sk;
 	__poll_t mask;
 
-	sock_poll_wait(file, wait);
+	sock_poll_wait(file, sock, wait);
 	mask = 0;
 
 	/* exceptional events? */
--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -325,7 +325,7 @@ __poll_t dccp_poll(struct file *file, st
 	__poll_t mask;
 	struct sock *sk = sock->sk;
 
-	sock_poll_wait(file, wait);
+	sock_poll_wait(file, sock, wait);
 	if (sk->sk_state == DCCP_LISTEN)
 		return inet_csk_listen_poll(sk);
 
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -507,7 +507,7 @@ __poll_t tcp_poll(struct file *file, str
 	const struct tcp_sock *tp = tcp_sk(sk);
 	int state;
 
-	sock_poll_wait(file, wait);
+	sock_poll_wait(file, sock, wait);
 
 	state = inet_sk_state_load(sk);
 	if (state == TCP_LISTEN)
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -1505,7 +1505,7 @@ __poll_t iucv_sock_poll(struct file *fil
 	struct sock *sk = sock->sk;
 	__poll_t mask = 0;
 
-	sock_poll_wait(file, wait);
+	sock_poll_wait(file, sock, wait);
 
 	if (sk->sk_state == IUCV_LISTEN)
 		return iucv_accept_poll(sk);
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -556,7 +556,7 @@ static __poll_t llcp_sock_poll(struct fi
 
 	pr_debug("%p\n", sk);
 
-	sock_poll_wait(file, wait);
+	sock_poll_wait(file, sock, wait);
 
 	if (sk->sk_state == LLCP_LISTEN)
 		return llcp_accept_poll(sk);
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -741,7 +741,7 @@ static __poll_t rxrpc_poll(struct file *
 	struct rxrpc_sock *rx = rxrpc_sk(sk);
 	__poll_t mask;
 
-	sock_poll_wait(file, wait);
+	sock_poll_wait(file, sock, wait);
 	mask = 0;
 
 	/* the socket is readable if there are any messages waiting on the Rx
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1543,7 +1543,7 @@ static __poll_t smc_poll(struct file *fi
 			mask |= EPOLLERR;
 	} else {
 		if (sk->sk_state != SMC_CLOSED)
-			sock_poll_wait(file, wait);
+			sock_poll_wait(file, sock, wait);
 		if (sk->sk_err)
 			mask |= EPOLLERR;
 		if ((sk->sk_shutdown == SHUTDOWN_MASK) ||
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -715,7 +715,7 @@ static __poll_t tipc_poll(struct file *f
 	struct tipc_sock *tsk = tipc_sk(sk);
 	__poll_t revents = 0;
 
-	sock_poll_wait(file, wait);
+	sock_poll_wait(file, sock, wait);
 
 	if (sk->sk_shutdown & RCV_SHUTDOWN)
 		revents |= EPOLLRDHUP | EPOLLIN | EPOLLRDNORM;
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2640,7 +2640,7 @@ static __poll_t unix_poll(struct file *f
 	struct sock *sk = sock->sk;
 	__poll_t mask;
 
-	sock_poll_wait(file, wait);
+	sock_poll_wait(file, sock, wait);
 	mask = 0;
 
 	/* exceptional events? */
@@ -2677,7 +2677,7 @@ static __poll_t unix_dgram_poll(struct f
 	unsigned int writable;
 	__poll_t mask;
 
-	sock_poll_wait(file, wait);
+	sock_poll_wait(file, sock, wait);
 	mask = 0;
 
 	/* exceptional events? */


