Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9BEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B5B2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131459;
	bh=p2iQ5btBdV/saWdi8PfgZPgfk8Lfb/752UKXqY6Glnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rL6H7q9eLsyU2K2Ar+m01E2qjRIQhQXI9LNrJnFbXoWSH92+hSUBgJ427HgD9S9Zr
	 phl94bbFUuZbzMMrhMOvGMLtu0rFykp+Y+K9WGo8F6/SbHMQOD/TX2inNofLnDjds/
	 ju6CfKpuLKVPZ4tSYT9+YGC5o2egBnMdm6h6J7zk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbfBYVu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:50:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:58450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730689AbfBYVX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:23:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78DA121734;
        Mon, 25 Feb 2019 21:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129838;
        bh=p2iQ5btBdV/saWdi8PfgZPgfk8Lfb/752UKXqY6Glnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VrbWR5NO20BRinC5kBWlc3BNRbjdCsyc3iwByUMXBv+nvy1toaR48lzqCsdxt09YW
         1n8WZdYoPLhCuTUKC0lb6HgE/LXE6QVYy80K11byfz45+0tR77QfaqCbFIopU+5WFw
         mfxNwdSHE3Wzw3X+Zu2SNk8hSdvlpZPE451uYfA8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 083/152] afs: Fix key refcounting in file locking code
Date:   Mon, 25 Feb 2019 22:11:15 +0100
Message-Id: <20190225195048.785215783@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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
index dc62d15a964b8..1bb300ef362b0 100644
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
index 26aa2d111a28f..0726e40db0f8b 100644
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



