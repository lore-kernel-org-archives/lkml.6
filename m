Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53608C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2859620449
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865155;
	bh=HzuiJ78a6rUQPxcJ+XhtYmBD55oMqoY+MM7A7N8qSRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ml17Nk4ZOe0hGev2f+BF4LU15HzuAhNyPIhZFkUK+Cax9oGhtp5aWCYFYIhlX4Ouf
	 dRz/9Dkq1v0lK2Q50JgQB6qU7aXfOdIfdaXUF+DvOezQvkoNn8O9gqxYDtferFXCbi
	 lIRayrHZsGhpLdK3/a7O0Y/jIrcSofos5d0YXbZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbfAGMpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:45:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:35398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728940AbfAGMpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:45:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDB3820449;
        Mon,  7 Jan 2019 12:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865148;
        bh=HzuiJ78a6rUQPxcJ+XhtYmBD55oMqoY+MM7A7N8qSRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rs9xtJt+2n7/b7zhNbxG0ZKomB2nQw3WgZam33gL/VebD2ts8tzILDn9gmJZbvxZn
         4oShxofOaKyma1DVU/o8xC4T8/38GQEfXTIg9QZUmsRxyTFAp7I+Y7W7yycYgVoKFV
         0Y+4eCm1Ca6x1xwV3lFTorXzMT/mL/M/q9o6pA98=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+0bf2e01269f1274b4b03@syzkaller.appspotmail.com,
        syzbot+e3132895630f957306bc@syzkaller.appspotmail.com,
        Myungho Jung <mhjungk@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 019/170] net/smc: fix TCP fallback socket release
Date:   Mon,  7 Jan 2019 13:30:46 +0100
Message-Id: <20190107104455.323825988@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Myungho Jung <mhjungk@gmail.com>

[ Upstream commit 78abe3d0dfad196959b1246003366e2610775ea6 ]

clcsock can be released while kernel_accept() references it in TCP
listen worker. Also, clcsock needs to wake up before released if TCP
fallback is used and the clcsock is blocked by accept. Add a lock to
safely release clcsock and call kernel_sock_shutdown() to wake up
clcsock from accept in smc_release().

Reported-by: syzbot+0bf2e01269f1274b4b03@syzkaller.appspotmail.com
Reported-by: syzbot+e3132895630f957306bc@syzkaller.appspotmail.com
Signed-off-by: Myungho Jung <mhjungk@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/smc/af_smc.c |   14 ++++++++++++--
 net/smc/smc.h    |    4 ++++
 2 files changed, 16 insertions(+), 2 deletions(-)

--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -145,8 +145,14 @@ static int smc_release(struct socket *so
 		sk->sk_shutdown |= SHUTDOWN_MASK;
 	}
 	if (smc->clcsock) {
+		if (smc->use_fallback && sk->sk_state == SMC_LISTEN) {
+			/* wake up clcsock accept */
+			rc = kernel_sock_shutdown(smc->clcsock, SHUT_RDWR);
+		}
+		mutex_lock(&smc->clcsock_release_lock);
 		sock_release(smc->clcsock);
 		smc->clcsock = NULL;
+		mutex_unlock(&smc->clcsock_release_lock);
 	}
 	if (smc->use_fallback) {
 		if (sk->sk_state != SMC_LISTEN && sk->sk_state != SMC_INIT)
@@ -203,6 +209,7 @@ static struct sock *smc_sock_alloc(struc
 	spin_lock_init(&smc->conn.send_lock);
 	sk->sk_prot->hash(sk);
 	sk_refcnt_debug_inc(sk);
+	mutex_init(&smc->clcsock_release_lock);
 
 	return sk;
 }
@@ -818,7 +825,7 @@ static int smc_clcsock_accept(struct smc
 	struct socket *new_clcsock = NULL;
 	struct sock *lsk = &lsmc->sk;
 	struct sock *new_sk;
-	int rc;
+	int rc = -EINVAL;
 
 	release_sock(lsk);
 	new_sk = smc_sock_alloc(sock_net(lsk), NULL, lsk->sk_protocol);
@@ -831,7 +838,10 @@ static int smc_clcsock_accept(struct smc
 	}
 	*new_smc = smc_sk(new_sk);
 
-	rc = kernel_accept(lsmc->clcsock, &new_clcsock, 0);
+	mutex_lock(&lsmc->clcsock_release_lock);
+	if (lsmc->clcsock)
+		rc = kernel_accept(lsmc->clcsock, &new_clcsock, 0);
+	mutex_unlock(&lsmc->clcsock_release_lock);
 	lock_sock(lsk);
 	if  (rc < 0)
 		lsk->sk_err = -rc;
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -219,6 +219,10 @@ struct smc_sock {				/* smc sock contain
 						 * started, waiting for unsent
 						 * data to be sent
 						 */
+	struct mutex            clcsock_release_lock;
+						/* protects clcsock of a listen
+						 * socket
+						 * */
 };
 
 static inline struct smc_sock *smc_sk(const struct sock *sk)


