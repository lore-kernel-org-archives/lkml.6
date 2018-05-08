Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932721AbeEHShl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:37:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:53874 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755547AbeEHSFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:09 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 14/76] fs/afs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:34 -0700
Message-Id: <20180508180436.716-15-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/afs/callback.c | 2 +-
 fs/afs/dir.c      | 8 ++++----
 fs/afs/file.c     | 2 +-
 fs/afs/write.c    | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index f4291b576054..73371c83b646 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -63,7 +63,7 @@ int afs_register_server_cb_interest(struct afs_vnode *vnode,
 			return -ENOMEM;
 
 		refcount_set(&new->usage, 1);
-		new->sb = vnode->vfs_inode.i_sb;
+		new->sb = vnode->vfs_inode.i_view->v_sb;
 		new->vid = vnode->volume->vid;
 		new->server = afs_get_server(server);
 		INIT_LIST_HEAD(&new->cb_link);
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index ba2b458b36d1..1a828b1da90f 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -453,7 +453,7 @@ static int afs_lookup_filldir(struct dir_context *ctx, const char *name,
 static int afs_do_lookup(struct inode *dir, struct dentry *dentry,
 			 struct afs_fid *fid, struct key *key)
 {
-	struct afs_super_info *as = dir->i_sb->s_fs_info;
+	struct afs_super_info *as = inode_sb(dir)->s_fs_info;
 	struct afs_lookup_cookie cookie = {
 		.ctx.actor = afs_lookup_filldir,
 		.name = dentry->d_name,
@@ -533,7 +533,7 @@ static struct inode *afs_try_auto_mntpt(struct dentry *dentry,
 	if (ret < 0)
 		goto out;
 
-	inode = afs_iget_pseudo_dir(dir->i_sb, false);
+	inode = afs_iget_pseudo_dir(inode_sb(dir), false);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
 		goto out;
@@ -614,7 +614,7 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 	dentry->d_fsdata = (void *)(unsigned long) vnode->status.data_version;
 
 	/* instantiate the dentry */
-	inode = afs_iget(dir->i_sb, key, &fid, NULL, NULL, NULL);
+	inode = afs_iget(inode_sb(dir), key, &fid, NULL, NULL, NULL);
 	key_put(key);
 	if (IS_ERR(inode)) {
 		_leave(" = %ld", PTR_ERR(inode));
@@ -861,7 +861,7 @@ static void afs_vnode_new_inode(struct afs_fs_cursor *fc,
 
 	d_drop(new_dentry);
 
-	inode = afs_iget(fc->vnode->vfs_inode.i_sb, fc->key,
+	inode = afs_iget(fc->vnode->vfs_inode.i_view->v_sb, fc->key,
 			 newfid, newstatus, newcb, fc->cbi);
 	if (IS_ERR(inode)) {
 		/* ENOMEM or EINTR at a really inconvenient time - just abandon
diff --git a/fs/afs/file.c b/fs/afs/file.c
index a39192ced99e..1abbe9f37163 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -376,7 +376,7 @@ static int afs_readpage(struct file *file, struct page *page)
 		ret = afs_page_filler(key, page);
 	} else {
 		struct inode *inode = page->mapping->host;
-		key = afs_request_key(AFS_FS_S(inode->i_sb)->cell);
+		key = afs_request_key(AFS_FS_S(inode_sb(inode))->cell);
 		if (IS_ERR(key)) {
 			ret = PTR_ERR(key);
 		} else {
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 9370e2feb999..df5a30e0d46e 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -761,7 +761,7 @@ int afs_page_mkwrite(struct vm_fault *vmf)
 	_enter("{{%x:%u}},{%lx}",
 	       vnode->fid.vid, vnode->fid.vnode, vmf->page->index);
 
-	sb_start_pagefault(inode->i_sb);
+	sb_start_pagefault(inode_sb(inode));
 
 	/* Wait for the page to be written to the cache before we allow it to
 	 * be modified.  We then assume the entire page will need writing back.
@@ -790,7 +790,7 @@ int afs_page_mkwrite(struct vm_fault *vmf)
 	SetPagePrivate(vmf->page);
 	set_page_private(vmf->page, priv);
 
-	sb_end_pagefault(inode->i_sb);
+	sb_end_pagefault(inode_sb(inode));
 	return VM_FAULT_LOCKED;
 }
 
-- 
2.15.1
