Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6ECC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFFA21736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866077;
	bh=lUWo0EtSXupqH0UIsVqEbeM/sokqqcCiTWQsMvuhFvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x+idaieGCeka9lr+UqUSrLKbAEyFHeJxjsTlDidfw+M+dSLmydLNdEQzEZQYMtuvN
	 HMbF1le4uQAFnPGaG1DDLH+27in26VpU1/7NAgfHmmHl37f1YJmEDw+Cp8snHnX/jr
	 KqwMCYmyaatk64guuSM5q4rvjxvPO/A5cHdn6J+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbfAGNBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:01:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:48698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730553AbfAGNBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:01:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 055A12089F;
        Mon,  7 Jan 2019 13:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866071;
        bh=lUWo0EtSXupqH0UIsVqEbeM/sokqqcCiTWQsMvuhFvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M3fFAWL+Crq60t12GPF1GPpIF3BDwF1VJ4wb4p/Tf4vQpoup1SM0hUaQx9aNVgErl
         SZ54lurqDlRVW3s23MEuE17IB5nMyuxCiBEEn/H9XPFgJhk2z5blJCe5F+GMQgartU
         ke515eBZ486t6R/sToHkb6E04Y7g/wO5gGDeHgfI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+0bf2e01269f1274b4b03@syzkaller.appspotmail.com,
        syzbot+e3132895630f957306bc@syzkaller.appspotmail.com,
        Myungho Jung <mhjungk@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 035/101] net/smc: fix TCP fallback socket release
Date:   Mon,  7 Jan 2019 13:32:23 +0100
Message-Id: <20190107105334.842604218@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -133,8 +133,14 @@ static int smc_release(struct socket *so
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
 
 	/* detach socket */
@@ -184,6 +190,7 @@ static struct sock *smc_sock_alloc(struc
 	INIT_DELAYED_WORK(&smc->sock_put_work, smc_close_sock_put_work);
 	sk->sk_prot->hash(sk);
 	sk_refcnt_debug_inc(sk);
+	mutex_init(&smc->clcsock_release_lock);
 
 	return sk;
 }
@@ -577,7 +584,7 @@ static int smc_clcsock_accept(struct smc
 	struct sock *sk = &lsmc->sk;
 	struct socket *new_clcsock;
 	struct sock *new_sk;
-	int rc;
+	int rc = -EINVAL;
 
 	release_sock(&lsmc->sk);
 	new_sk = smc_sock_alloc(sock_net(sk), NULL);
@@ -590,7 +597,10 @@ static int smc_clcsock_accept(struct smc
 	}
 	*new_smc = smc_sk(new_sk);
 
-	rc = kernel_accept(lsmc->clcsock, &new_clcsock, 0);
+	mutex_lock(&lsmc->clcsock_release_lock);
+	if (lsmc->clcsock)
+		rc = kernel_accept(lsmc->clcsock, &new_clcsock, 0);
+	mutex_unlock(&lsmc->clcsock_release_lock);
 	lock_sock(&lsmc->sk);
 	if  (rc < 0) {
 		lsmc->sk.sk_err = -rc;
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -185,6 +185,10 @@ struct smc_sock {				/* smc sock contain
 						 * started, waiting for unsent
 						 * data to be sent
 						 */
+	struct mutex            clcsock_release_lock;
+						/* protects clcsock of a listen
+						 * socket
+						 * */
 };
 
 static inline struct smc_sock *smc_sk(const struct sock *sk)


