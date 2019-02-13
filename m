Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71204C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9512190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026782;
	bh=MGQHZtkt+QAOVM/NcWJx4rguVDOQp4la1Q+auPcfvCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S7VcHSCqp4PDsLQjNBW2CHPVqFrlnYFxdiOGkksfoKtPaLE9VKXIxNA/SgLMAYJlD
	 6x3248VQtDArcmBT1uGbGBL717tTy0qI/5vO74vC2Az68gCa2fpFooiJ7pZM3t5MVe
	 1+xGw7+Gmerp9Y40Yf4b26jc7T7S0TP1iwsYgrM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390225AbfBMC7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:59:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:39882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732128AbfBMCgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:36:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95E53206B6;
        Wed, 13 Feb 2019 02:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025376;
        bh=MGQHZtkt+QAOVM/NcWJx4rguVDOQp4la1Q+auPcfvCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Av9PzEQ2UD1wSdJfZ9+aqKtoZSRiWjXXeH6bLEkULtzMF8r1zMvejL6bkPXgm257e
         Lk4kcjyZjgAIiyDLZY4kV2c0seLdNYAbG5MmNe9r5NxgToJaXka4j1gv8dsx7RxJYW
         J3Uk34+RRo7mHSbhfBNNtehztdw+ZoXK1PRqLaPw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-afs@lists.infradead.org
Subject: [PATCH AUTOSEL 4.20 086/105] afs: Fix key refcounting in file locking code
Date:   Tue, 12 Feb 2019 21:33:17 -0500
Message-Id: <20190213023336.19019-86-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

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
index 0568fd986821..e432bd27a2e7 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -208,7 +208,7 @@ again:
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
index 211343831c30..1a4ce07fb406 100644
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

