Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A741FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FC720873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sW5xT60h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6FC720873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbeG3JTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:19:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53166 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbeG3JTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sVmSDIxiVteT+wzbqHuZwYuRl87KN+1UbVRszeS7AS4=; b=sW5xT60hGrN75WPBh5ddzuoSo
        KDQ+OV4tf1rAgutF1/k3N2vxClPEOoMXMPEVwyMCUtpumrdVG4Rzyoo+m2Vxw4MwZtzQUkRy0VuYR
        NdVjFCCfbk9uzXXln23t0M9nQzfolNjk7qyaATTMk/36aRfvE8LIiOPJrxFaN3H/uFMTbBywIf1Q6
        c7jY130zy+ZO63PvOVhXHaMIeLYCLgsV0DKNWc8H9iDf/GCItZb/5OLhqtnuSHHbYpOXlDwRvbCSI
        V4BOqE2C8ZKLus4U+e7JzHJ2S6dJ2SoVYRraNHDOQYpZTvpjTMam6xmFNn9wHZjAKPCGtLdXbjGyn
        KUU9bK3UA==;
Received: from 089144213232.atnat0022.highway.a1.net ([89.144.213.232] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fk2rj-0004Dm-Nc; Mon, 30 Jul 2018 07:45:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Dumazet <edumazet@google.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] net: remove bogus RCU annotations on socket.wq
Date:   Mon, 30 Jul 2018 09:45:07 +0200
Message-Id: <20180730074507.17037-2-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180730074507.17037-1-hch@lst.de>
References: <20180730074507.17037-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We never use RCU protection for it, just a lot of cargo-cult
rcu_deference_protects calls.

Note that we do keep the kfree_rcu call for it, as the references through
struct sock are RCU protected and thus might require a grace period before
freeing.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/net.h |  2 +-
 include/net/sock.h  |  2 +-
 net/socket.c        | 10 ++++------
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index 6554d3ba4396..e0930678c8bf 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -114,7 +114,7 @@ struct socket {
 
 	unsigned long		flags;
 
-	struct socket_wq __rcu	*wq;
+	struct socket_wq	*wq;
 
 	struct file		*file;
 	struct sock		*sk;
diff --git a/include/net/sock.h b/include/net/sock.h
index 7927541101a8..9b6011912691 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1725,7 +1725,7 @@ static inline void sock_graft(struct sock *sk, struct socket *parent)
 {
 	WARN_ON(parent->sk);
 	write_lock_bh(&sk->sk_callback_lock);
-	sk->sk_wq = parent->wq;
+	rcu_assign_pointer(sk->sk_wq, parent->wq);
 	parent->sk = sk;
 	sk_set_socket(sk, parent);
 	sk->sk_uid = SOCK_INODE(parent)->i_uid;
diff --git a/net/socket.c b/net/socket.c
index 5b7df6695f4f..475247e347ae 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -251,7 +251,7 @@ static struct inode *sock_alloc_inode(struct super_block *sb)
 	init_waitqueue_head(&wq->wait);
 	wq->fasync_list = NULL;
 	wq->flags = 0;
-	RCU_INIT_POINTER(ei->socket.wq, wq);
+	ei->socket.wq = wq;
 
 	ei->socket.state = SS_UNCONNECTED;
 	ei->socket.flags = 0;
@@ -265,11 +265,9 @@ static struct inode *sock_alloc_inode(struct super_block *sb)
 static void sock_destroy_inode(struct inode *inode)
 {
 	struct socket_alloc *ei;
-	struct socket_wq *wq;
 
 	ei = container_of(inode, struct socket_alloc, vfs_inode);
-	wq = rcu_dereference_protected(ei->socket.wq, 1);
-	kfree_rcu(wq, rcu);
+	kfree_rcu(ei->socket.wq, rcu);
 	kmem_cache_free(sock_inode_cachep, ei);
 }
 
@@ -603,7 +601,7 @@ static void __sock_release(struct socket *sock, struct inode *inode)
 		module_put(owner);
 	}
 
-	if (rcu_dereference_protected(sock->wq, 1)->fasync_list)
+	if (sock->wq->fasync_list)
 		pr_err("%s: fasync list not empty!\n", __func__);
 
 	if (!sock->file) {
@@ -1181,7 +1179,7 @@ static int sock_fasync(int fd, struct file *filp, int on)
 		return -EINVAL;
 
 	lock_sock(sk);
-	wq = rcu_dereference_protected(sock->wq, lockdep_sock_is_held(sk));
+	wq = sock->wq;
 	fasync_helper(fd, filp, on, &wq->fasync_list);
 
 	if (!wq->fasync_list)
-- 
2.18.0

