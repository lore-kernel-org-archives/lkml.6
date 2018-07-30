Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E29AFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE98220870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xvl9OkvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE98220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbeG3JQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:16:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50062 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbeG3JQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=G2IzqfZ8qR8kCk6B5/qWp9q43CpPWIxowdMHgICkojA=; b=Xvl9OkvDvBFRqzA/Un/XhxXFV
        yIY7iJjG2dKCxvA3PdO0bSEqe2WkR9M/jY63MtQSx6HJ8XGySTD6d123FcpGB61PuPLhbV+LBXUXL
        dszF0YpQiZhV+MkWiNZ7MZi2m81Se4tQPXhEelAlW4qKQtpNHxrpTq6+lns04mOzyWkLKOWylq5BB
        47BECDUljJ77ZcecZFDMbgj2+MJEcMzwyTK7a19zBQ4wS39Gc/GXKkN3BrofgEymivP/2gEwsi+1G
        mY2wHuy/eiHemm+mlbwiuFk+1nU1zkSEZVXowjGnMfv9VBR+uCx4F2DZv4JNJcihjlGY/k/eDwPa6
        fKbJ1f26Q==;
Received: from 089144213232.atnat0022.highway.a1.net ([89.144.213.232] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fk2ow-0002JX-D6; Mon, 30 Jul 2018 07:42:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] net: simplify sock_poll_wait
Date:   Mon, 30 Jul 2018 09:42:10 +0200
Message-Id: <20180730074213.16832-2-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180730074213.16832-1-hch@lst.de>
References: <20180730074213.16832-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wait_address argument is always directly derived from the filp
argument, so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 crypto/af_alg.c        |  2 +-
 include/net/sock.h     | 11 ++++++-----
 net/atm/common.c       |  2 +-
 net/caif/caif_socket.c |  2 +-
 net/core/datagram.c    |  2 +-
 net/dccp/proto.c       |  2 +-
 net/ipv4/tcp.c         |  2 +-
 net/iucv/af_iucv.c     |  2 +-
 net/nfc/llcp_sock.c    |  2 +-
 net/rxrpc/af_rxrpc.c   |  2 +-
 net/smc/af_smc.c       |  2 +-
 net/tipc/socket.c      |  2 +-
 net/unix/af_unix.c     |  4 ++--
 13 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index c166f424871c..b053179e0bc5 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -1071,7 +1071,7 @@ __poll_t af_alg_poll(struct file *file, struct socket *sock,
 	struct af_alg_ctx *ctx = ask->private;
 	__poll_t mask;
 
-	sock_poll_wait(file, sk_sleep(sk), wait);
+	sock_poll_wait(file, wait);
 	mask = 0;
 
 	if (!ctx->more || ctx->used)
diff --git a/include/net/sock.h b/include/net/sock.h
index b3b75419eafe..762069bb0d8c 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1994,16 +1994,17 @@ static inline bool skwq_has_sleeper(struct socket_wq *wq)
 /**
  * sock_poll_wait - place memory barrier behind the poll_wait call.
  * @filp:           file
- * @wait_address:   socket wait queue
  * @p:              poll_table
  *
  * See the comments in the wq_has_sleeper function.
  */
-static inline void sock_poll_wait(struct file *filp,
-		wait_queue_head_t *wait_address, poll_table *p)
+static inline void sock_poll_wait(struct file *filp, poll_table *p)
 {
-	if (!poll_does_not_wait(p) && wait_address) {
-		poll_wait(filp, wait_address, p);
+	struct socket *sock = filp->private_data;
+	wait_queue_head_t *wq = sk_sleep(sock->sk);
+
+	if (!poll_does_not_wait(p) && wq) {
+		poll_wait(filp, wq, p);
 		/* We need to be sure we are in sync with the
 		 * socket flags modification.
 		 *
diff --git a/net/atm/common.c b/net/atm/common.c
index a7a68e509628..9f8cb0d2e71e 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -653,7 +653,7 @@ __poll_t vcc_poll(struct file *file, struct socket *sock, poll_table *wait)
 	struct atm_vcc *vcc;
 	__poll_t mask;
 
-	sock_poll_wait(file, sk_sleep(sk), wait);
+	sock_poll_wait(file, wait);
 	mask = 0;
 
 	vcc = ATM_SD(sock);
diff --git a/net/caif/caif_socket.c b/net/caif/caif_socket.c
index a6fb1b3bcad9..d18965f3291f 100644
--- a/net/caif/caif_socket.c
+++ b/net/caif/caif_socket.c
@@ -941,7 +941,7 @@ static __poll_t caif_poll(struct file *file,
 	__poll_t mask;
 	struct caifsock *cf_sk = container_of(sk, struct caifsock, sk);
 
-	sock_poll_wait(file, sk_sleep(sk), wait);
+	sock_poll_wait(file, wait);
 	mask = 0;
 
 	/* exceptional events? */
diff --git a/net/core/datagram.c b/net/core/datagram.c
index 9938952c5c78..9aac0d63d53e 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -837,7 +837,7 @@ __poll_t datagram_poll(struct file *file, struct socket *sock,
 	struct sock *sk = sock->sk;
 	__poll_t mask;
 
-	sock_poll_wait(file, sk_sleep(sk), wait);
+	sock_poll_wait(file, wait);
 	mask = 0;
 
 	/* exceptional events? */
diff --git a/net/dccp/proto.c b/net/dccp/proto.c
index 0d56e36a6db7..875858c8b059 100644
--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -325,7 +325,7 @@ __poll_t dccp_poll(struct file *file, struct socket *sock,
 	__poll_t mask;
 	struct sock *sk = sock->sk;
 
-	sock_poll_wait(file, sk_sleep(sk), wait);
+	sock_poll_wait(file, wait);
 	if (sk->sk_state == DCCP_LISTEN)
 		return inet_csk_listen_poll(sk);
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 4491faf83f4f..0b93290c9255 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -507,7 +507,7 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
 	const struct tcp_sock *tp = tcp_sk(sk);
 	int state;
 
-	sock_poll_wait(file, sk_sleep(sk), wait);
+	sock_poll_wait(file, wait);
 
 	state = inet_sk_state_load(sk);
 	if (state == TCP_LISTEN)
diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 893a022f9620..e7b93cd14b52 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -1494,7 +1494,7 @@ __poll_t iucv_sock_poll(struct file *file, struct socket *sock,
 	struct sock *sk = sock->sk;
 	__poll_t mask = 0;
 
-	sock_poll_wait(file, sk_sleep(sk), wait);
+	sock_poll_wait(file, wait);
 
 	if (sk->sk_state == IUCV_LISTEN)
 		return iucv_accept_poll(sk);
diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index ea0c0c6f1874..dd4adf8b1167 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -556,7 +556,7 @@ static __poll_t llcp_sock_poll(struct file *file, struct socket *sock,
 
 	pr_debug("%p\n", sk);
 
-	sock_poll_wait(file, sk_sleep(sk), wait);
+	sock_poll_wait(file, wait);
 
 	if (sk->sk_state == LLCP_LISTEN)
 		return llcp_accept_poll(sk);
diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 2b463047dd7b..ac44d8afffb1 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -741,7 +741,7 @@ static __poll_t rxrpc_poll(struct file *file, struct socket *sock,
 	struct rxrpc_sock *rx = rxrpc_sk(sk);
 	__poll_t mask;
 
-	sock_poll_wait(file, sk_sleep(sk), wait);
+	sock_poll_wait(file, wait);
 	mask = 0;
 
 	/* the socket is readable if there are any messages waiting on the Rx
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 05e4ffe5aabd..09df79313f60 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1351,7 +1351,7 @@ static __poll_t smc_poll(struct file *file, struct socket *sock,
 			mask |= EPOLLERR;
 	} else {
 		if (sk->sk_state != SMC_CLOSED)
-			sock_poll_wait(file, sk_sleep(sk), wait);
+			sock_poll_wait(file, wait);
 		if (sk->sk_err)
 			mask |= EPOLLERR;
 		if ((sk->sk_shutdown == SHUTDOWN_MASK) ||
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 930852c54d7a..9a9050131724 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -716,7 +716,7 @@ static __poll_t tipc_poll(struct file *file, struct socket *sock,
 	struct tipc_sock *tsk = tipc_sk(sk);
 	__poll_t revents = 0;
 
-	sock_poll_wait(file, sk_sleep(sk), wait);
+	sock_poll_wait(file, wait);
 
 	if (sk->sk_shutdown & RCV_SHUTDOWN)
 		revents |= EPOLLRDHUP | EPOLLIN | EPOLLRDNORM;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index e5473c03d667..1772a0e32665 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2635,7 +2635,7 @@ static __poll_t unix_poll(struct file *file, struct socket *sock, poll_table *wa
 	struct sock *sk = sock->sk;
 	__poll_t mask;
 
-	sock_poll_wait(file, sk_sleep(sk), wait);
+	sock_poll_wait(file, wait);
 	mask = 0;
 
 	/* exceptional events? */
@@ -2672,7 +2672,7 @@ static __poll_t unix_dgram_poll(struct file *file, struct socket *sock,
 	unsigned int writable;
 	__poll_t mask;
 
-	sock_poll_wait(file, sk_sleep(sk), wait);
+	sock_poll_wait(file, wait);
 	mask = 0;
 
 	/* exceptional events? */
-- 
2.18.0

