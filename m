Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F209FC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B52D82504B
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B52D82504B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755830AbeFXPkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:40:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59882 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755228AbeFXPkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:40:07 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DB52A92F;
        Sun, 24 Jun 2018 15:40:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        shankarapailoor <shankarapailoor@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Lorenzo Colitti <lorenzo@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 11/70] socket: close race condition between sock_close() and sockfs_setattr()
Date:   Sun, 24 Jun 2018 23:22:03 +0800
Message-Id: <20180624142741.179636849@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142740.481662434@linuxfoundation.org>
References: <20180624142740.481662434@linuxfoundation.org>
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

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 6d8c50dcb029872b298eea68cc6209c866fd3e14 ]

fchownat() doesn't even hold refcnt of fd until it figures out
fd is really needed (otherwise is ignored) and releases it after
it resolves the path. This means sock_close() could race with
sockfs_setattr(), which leads to a NULL pointer dereference
since typically we set sock->sk to NULL in ->release().

As pointed out by Al, this is unique to sockfs. So we can fix this
in socket layer by acquiring inode_lock in sock_close() and
checking against NULL in sockfs_setattr().

sock_release() is called in many places, only the sock_close()
path matters here. And fortunately, this should not affect normal
sock_close() as it is only called when the last fd refcnt is gone.
It only affects sock_close() with a parallel sockfs_setattr() in
progress, which is not common.

Fixes: 86741ec25462 ("net: core: Add a UID field to struct sock.")
Reported-by: shankarapailoor <shankarapailoor@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/socket.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

--- a/net/socket.c
+++ b/net/socket.c
@@ -537,7 +537,10 @@ static int sockfs_setattr(struct dentry
 	if (!err && (iattr->ia_valid & ATTR_UID)) {
 		struct socket *sock = SOCKET_I(d_inode(dentry));
 
-		sock->sk->sk_uid = iattr->ia_uid;
+		if (sock->sk)
+			sock->sk->sk_uid = iattr->ia_uid;
+		else
+			err = -ENOENT;
 	}
 
 	return err;
@@ -586,12 +589,16 @@ EXPORT_SYMBOL(sock_alloc);
  *	an inode not a file.
  */
 
-void sock_release(struct socket *sock)
+static void __sock_release(struct socket *sock, struct inode *inode)
 {
 	if (sock->ops) {
 		struct module *owner = sock->ops->owner;
 
+		if (inode)
+			inode_lock(inode);
 		sock->ops->release(sock);
+		if (inode)
+			inode_unlock(inode);
 		sock->ops = NULL;
 		module_put(owner);
 	}
@@ -605,6 +612,11 @@ void sock_release(struct socket *sock)
 	}
 	sock->file = NULL;
 }
+
+void sock_release(struct socket *sock)
+{
+	__sock_release(sock, NULL);
+}
 EXPORT_SYMBOL(sock_release);
 
 void __sock_tx_timestamp(__u16 tsflags, __u8 *tx_flags)
@@ -1146,7 +1158,7 @@ static int sock_mmap(struct file *file,
 
 static int sock_close(struct inode *inode, struct file *filp)
 {
-	sock_release(SOCKET_I(inode));
+	__sock_release(SOCKET_I(inode), inode);
 	return 0;
 }
 


