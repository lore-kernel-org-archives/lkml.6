Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8ADC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD9F222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025568;
	bh=31Vu5vXHoW36MXU/r7LH8OcnPrEHU0wtOvOnidOif2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RUOGi5xoPjVz5/Rl0BSOxiUwPanR6EjZYSWCfWGKf/vx+tvLcPyBqMoDRQidTnzju
	 FY0VVdq+jZOHYZU/az5Kcz3lVeuEiR9e6rAYh6Eql1gj9nrKyJ6r3/q6hkAWhljlGA
	 qZA4XvfghfBZIBKyZYWBN2uyizIgwWaHsU7ESFf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388711AbfBMCj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:39:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:42934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388672AbfBMCjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:39:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 250AE2175B;
        Wed, 13 Feb 2019 02:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025562;
        bh=31Vu5vXHoW36MXU/r7LH8OcnPrEHU0wtOvOnidOif2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MZs+9LazMdhOxozm7Tletme5im6R5VdpArX5MJ5GDuTVPnpgkeNkwbsEr3JU+OtZg
         eOtpDHA3C2E5NyOxp9+Lb9pYmuqEt1R8zgjANKfmeDbP+g6PO44dZDyrmLGMc0LMTq
         oIzktdR7ZjuVlysFg2GebREULrQGZhTOg7QljVgY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-afs@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 69/83] afs: Fix key refcounting in file locking code
Date:   Tue, 12 Feb 2019 21:36:47 -0500
Message-Id: <20190213023701.20286-69-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
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
index dc62d15a964b..1bb300ef362b 100644
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
index 26aa2d111a28..0726e40db0f8 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -542,6 +542,8 @@ void afs_evict_inode(struct inode *inode)
 #endif
 
 	afs_put_permits(rcu_access_pointer(vnode->permit_cache));
+	key_put(vnode->lock_key);
+	vnode->lock_key = NULL;
 	_leave("");
 }
 
-- 
2.19.1

