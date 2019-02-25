Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F0AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7210821852
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130506;
	bh=bWM/iRotfI9CwntaFzSTbXCJXR9aajbYZ/AUOFx9vLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UXMlbKKu90tdgQJsWwr9CgKINiwmnv+mkA2oVMdvYWFLMlUePez3NfcRu4tZtZvER
	 2xfLGmguvVvzrtfwT85lysyGqFaQ6WxmNghKtYt4HzAy0c1QMmEhwsEjmf3zxpnL5H
	 j8gF4nC9jYNttvhm0Q42K5A+YBhodZ7c6GTML4v8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732924AbfBYVfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:35:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:41180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732683AbfBYVfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:35:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD141217F5;
        Mon, 25 Feb 2019 21:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130502;
        bh=bWM/iRotfI9CwntaFzSTbXCJXR9aajbYZ/AUOFx9vLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0baghM+DcRlXEKCuyc4pavkzIa3nWY3s2ydXKV95sMaFvUxJ2/8HqxytCWrFEgydH
         4dLzQRv7OGBoYhkPl7JNafO9L/Ru/TDAbWDMI9BPo734oLzLHN5MzleFPdgENqZtjE
         tu9u7y2Iv73+DBN7PInsX0zAgyZ62wlDmEB10nhM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 103/183] afs: Fix key refcounting in file locking code
Date:   Mon, 25 Feb 2019 22:11:16 +0100
Message-Id: <20190225195112.060193596@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 59d49076ae3e6912e6d7df2fd68e2337f3d02036 ]

Fix the refcounting of the authentication keys in the file locking code.
The vnode->lock_key member points to a key on which it expects to be
holding a ref, but it isn't always given an extra ref, however.

Fixes: 0fafdc9f888b ("afs: Fix file locking")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/flock.c | 4 ++--
 fs/afs/inode.c | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index 0568fd9868210..e432bd27a2e7b 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -208,7 +208,7 @@ void afs_lock_work(struct work_struct *work)
 		/* The new front of the queue now owns the state variables. */
 		next = list_entry(vnode->pending_locks.next,
 				  struct file_lock, fl_u.afs.link);
-		vnode->lock_key = afs_file_key(next->fl_file);
+		vnode->lock_key = key_get(afs_file_key(next->fl_file));
 		vnode->lock_type = (next->fl_type == F_RDLCK) ? AFS_LOCK_READ : AFS_LOCK_WRITE;
 		vnode->lock_state = AFS_VNODE_LOCK_WAITING_FOR_CB;
 		goto again;
@@ -413,7 +413,7 @@ static void afs_dequeue_lock(struct afs_vnode *vnode, struct file_lock *fl)
 	/* The new front of the queue now owns the state variables. */
 	next = list_entry(vnode->pending_locks.next,
 			  struct file_lock, fl_u.afs.link);
-	vnode->lock_key = afs_file_key(next->fl_file);
+	vnode->lock_key = key_get(afs_file_key(next->fl_file));
 	vnode->lock_type = (next->fl_type == F_RDLCK) ? AFS_LOCK_READ : AFS_LOCK_WRITE;
 	vnode->lock_state = AFS_VNODE_LOCK_WAITING_FOR_CB;
 	afs_lock_may_be_available(vnode);
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 211343831c304..1a4ce07fb406d 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -545,6 +545,8 @@ void afs_evict_inode(struct inode *inode)
 #endif
 
 	afs_put_permits(rcu_access_pointer(vnode->permit_cache));
+	key_put(vnode->lock_key);
+	vnode->lock_key = NULL;
 	_leave("");
 }
 
-- 
2.19.1



