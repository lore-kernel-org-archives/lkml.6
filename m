Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754762AbeE3EJD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 00:09:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbeE3EJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 00:09:01 -0400
Date: Tue, 29 May 2018 21:09:00 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 3/3] f2fs: clean up symbol namespace
Message-ID: <20180530040859.GC39056@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180529162041.16005-1-chao@kernel.org>
 <20180529162041.16005-3-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529162041.16005-3-chao@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

Thank you for the work.
I resolved some conflicts and modified some function names.
Please take a look at this.

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev-test

---
 fs/f2fs/checkpoint.c |  8 ++++----
 fs/f2fs/dir.c        |  6 +++---
 fs/f2fs/f2fs.h       | 10 +++++-----
 fs/f2fs/file.c       |  2 +-
 fs/f2fs/gc.c         |  4 ++--
 fs/f2fs/namei.c      |  4 ++--
 fs/f2fs/recovery.c   |  2 +-
 7 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 078c2d5c5b2e..8eb184c3de84 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -24,7 +24,7 @@
 #include <trace/events/f2fs.h>
 
 static struct kmem_cache *ino_entry_slab;
-struct kmem_cache *inode_entry_slab;
+struct kmem_cache *f2fs_inode_entry_slab;
 
 void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io)
 {
@@ -1490,9 +1490,9 @@ int __init f2fs_create_checkpoint_caches(void)
 			sizeof(struct ino_entry));
 	if (!ino_entry_slab)
 		return -ENOMEM;
-	inode_entry_slab = f2fs_kmem_cache_create("f2fs_inode_entry",
+	f2fs_inode_entry_slab = f2fs_kmem_cache_create("f2fs_inode_entry",
 			sizeof(struct inode_entry));
-	if (!inode_entry_slab) {
+	if (!f2fs_inode_entry_slab) {
 		kmem_cache_destroy(ino_entry_slab);
 		return -ENOMEM;
 	}
@@ -1502,5 +1502,5 @@ int __init f2fs_create_checkpoint_caches(void)
 void f2fs_destroy_checkpoint_caches(void)
 {
 	kmem_cache_destroy(ino_entry_slab);
-	kmem_cache_destroy(inode_entry_slab);
+	kmem_cache_destroy(f2fs_inode_entry_slab);
 }
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index eedfa2a13786..7f955c4e86a4 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -586,7 +586,7 @@ int f2fs_add_regular_entry(struct inode *dir, const struct qstr *new_name,
 	return err;
 }
 
-int __f2fs_do_add_link(struct inode *dir, struct fscrypt_name *fname,
+int f2fs_add_dentry(struct inode *dir, struct fscrypt_name *fname,
 				struct inode *inode, nid_t ino, umode_t mode)
 {
 	struct qstr new_name;
@@ -610,7 +610,7 @@ int __f2fs_do_add_link(struct inode *dir, struct fscrypt_name *fname,
  * Caller should grab and release a rwsem by calling f2fs_lock_op() and
  * f2fs_unlock_op().
  */
-int __f2fs_add_link(struct inode *dir, const struct qstr *name,
+int f2fs_do_add_link(struct inode *dir, const struct qstr *name,
 				struct inode *inode, nid_t ino, umode_t mode)
 {
 	struct fscrypt_name fname;
@@ -639,7 +639,7 @@ int __f2fs_add_link(struct inode *dir, const struct qstr *name,
 	} else if (IS_ERR(page)) {
 		err = PTR_ERR(page);
 	} else {
-		err = __f2fs_do_add_link(dir, &fname, inode, ino, mode);
+		err = f2fs_add_dentry(dir, &fname, inode, ino, mode);
 	}
 	fscrypt_free_filename(&fname);
 	return err;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ba1063ed39eb..f167d01443fe 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2626,7 +2626,7 @@ static inline int get_inline_xattr_addrs(struct inode *inode)
 	return F2FS_I(inode)->i_inline_xattr_size;
 }
 
-#define get_inode_mode(i) \
+#define f2fs_get_inode_mode(i) \
 	((is_inode_flag_set(i, FI_ACL_MODE)) ? \
 	 (F2FS_I(i)->i_acl_mode) : ((i)->i_mode))
 
@@ -2744,9 +2744,9 @@ void f2fs_update_dentry(nid_t ino, umode_t mode, struct f2fs_dentry_ptr *d,
 int f2fs_add_regular_entry(struct inode *dir, const struct qstr *new_name,
 			const struct qstr *orig_name,
 			struct inode *inode, nid_t ino, umode_t mode);
-int __f2fs_do_add_link(struct inode *dir, struct fscrypt_name *fname,
+int f2fs_add_dentry(struct inode *dir, struct fscrypt_name *fname,
 			struct inode *inode, nid_t ino, umode_t mode);
-int __f2fs_add_link(struct inode *dir, const struct qstr *name,
+int f2fs_do_add_link(struct inode *dir, const struct qstr *name,
 			struct inode *inode, nid_t ino, umode_t mode);
 void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 			struct inode *dir, struct inode *inode);
@@ -2755,7 +2755,7 @@ bool f2fs_empty_dir(struct inode *dir);
 
 static inline int f2fs_add_link(struct dentry *dentry, struct inode *inode)
 {
-	return __f2fs_add_link(d_inode(dentry->d_parent), &dentry->d_name,
+	return f2fs_do_add_link(d_inode(dentry->d_parent), &dentry->d_name,
 				inode, inode->i_ino, inode->i_mode);
 }
 
@@ -3190,7 +3190,7 @@ extern const struct inode_operations f2fs_dir_inode_operations;
 extern const struct inode_operations f2fs_symlink_inode_operations;
 extern const struct inode_operations f2fs_encrypted_symlink_inode_operations;
 extern const struct inode_operations f2fs_special_inode_operations;
-extern struct kmem_cache *inode_entry_slab;
+extern struct kmem_cache *f2fs_inode_entry_slab;
 
 /*
  * inline.c
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 610ecc7e3864..b7b8ae92abbe 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -812,7 +812,7 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 	__setattr_copy(inode, attr);
 
 	if (attr->ia_valid & ATTR_MODE) {
-		err = posix_acl_chmod(inode, get_inode_mode(inode));
+		err = posix_acl_chmod(inode, f2fs_get_inode_mode(inode));
 		if (err || is_inode_flag_set(inode, FI_ACL_MODE)) {
 			inode->i_mode = F2FS_I(inode)->i_acl_mode;
 			clear_inode_flag(inode, FI_ACL_MODE);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index c43eb3902e62..2a97ce7bc91d 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -429,7 +429,7 @@ static void add_gc_inode(struct gc_inode_list *gc_list, struct inode *inode)
 		iput(inode);
 		return;
 	}
-	new_ie = f2fs_kmem_cache_alloc(inode_entry_slab, GFP_NOFS);
+	new_ie = f2fs_kmem_cache_alloc(f2fs_inode_entry_slab, GFP_NOFS);
 	new_ie->inode = inode;
 
 	f2fs_radix_tree_insert(&gc_list->iroot, inode->i_ino, new_ie);
@@ -443,7 +443,7 @@ static void put_gc_inode(struct gc_inode_list *gc_list)
 		radix_tree_delete(&gc_list->iroot, ie->inode->i_ino);
 		iput(ie->inode);
 		list_del(&ie->list);
-		kmem_cache_free(inode_entry_slab, ie);
+		kmem_cache_free(f2fs_inode_entry_slab, ie);
 	}
 }
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index fe90202a95c1..5d2d822092a2 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -401,7 +401,7 @@ static int __recover_dot_dentries(struct inode *dir, nid_t pino)
 		err = PTR_ERR(page);
 		goto out;
 	} else {
-		err = __f2fs_add_link(dir, &dot, NULL, dir->i_ino, S_IFDIR);
+		err = f2fs_do_add_link(dir, &dot, NULL, dir->i_ino, S_IFDIR);
 		if (err)
 			goto out;
 	}
@@ -412,7 +412,7 @@ static int __recover_dot_dentries(struct inode *dir, nid_t pino)
 	else if (IS_ERR(page))
 		err = PTR_ERR(page);
 	else
-		err = __f2fs_add_link(dir, &dotdot, NULL, pino, S_IFDIR);
+		err = f2fs_do_add_link(dir, &dotdot, NULL, pino, S_IFDIR);
 out:
 	if (!err)
 		clear_inode_flag(dir, FI_INLINE_DOTS);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index d7f20af33206..38f25f0b193a 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -173,7 +173,7 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
 	} else if (IS_ERR(page)) {
 		err = PTR_ERR(page);
 	} else {
-		err = __f2fs_do_add_link(dir, &fname, inode,
+		err = f2fs_add_dentry(dir, &fname, inode,
 					inode->i_ino, inode->i_mode);
 	}
 	if (err == -ENOMEM)
-- 
2.17.0.441.gb46fe60e1d-goog
