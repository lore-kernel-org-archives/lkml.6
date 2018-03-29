Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753280AbeC2LwJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 07:52:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6711 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752717AbeC2LwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 07:52:06 -0400
From: Yufen Yu <yuyufen@huawei.com>
To: <dwmw2@infradead.org>
CC: <Joakim.Tjernlund@infinera.com>, <viro@zeniv.linux.org.uk>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Yufen Yu <yuyufen@huawei.com>
Subject: [PATCH] jffs2: safely remove obsolete dirent from the f->dents list
Date: Thu, 29 Mar 2018 20:00:23 +0800
Message-ID: <20180329120023.33169-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We may delete a bunch of directory entries, operating such as:
getdents(), unlink(), getdents()..., until the end of the directory.
jffs2 handles f_pos on the directory merely as the position on the
f->dents list. So, the next getdents() may skip some entries
before f_pos, if we remove some entries from the list between two
getdents(), resulting in some entries of the directory cannot be deleted.

Commit 15953580e79b is introduced to resolve this bug by not
removing delete entries from the list immediately.

However, when CONFIG_JFFS2_SUMMARY is not set, it can cause the
following issues:

* 'deletion' dirents is always in the f->dents list, wasting memory
    resource. For example:
        There is a file named 'file1'. Then we rename it:
        mv file1 file2;
        mv file2 file3;
        ...
        mv file99999 file1000000

    All of file1~file1000000 dirents always in the f->dents list.

* Though, the list we're traversing is already ordered by CRC,
it could waste much CPU time when the list is very long.

To fix, we define two variables in struct jffs2_inode_info: nr_dir_opening,
obsolete_count, and two new functions: jffs2_dir_open(), jffs2_dir_release().

When open a directory, jffs2_dir_open() will increase nr_dir_opening,
which will be decreased by jffs2_dir_release(). if the value is 0,
it means nobody open the dir and nobody in getdents()/seek() semantics.
Thus, we can remove all obsolete dirent from the list.

When delete a file, jffs2_do_unlink() can remove the dirent directly if
nobody open the directory(i.e. nr_dir_opending == 0). Otherwise, it just
increase obsolete_count, denoting obsolete dirent count of the list.

Fixes: 15953580e79b ("[JFFS2] Improve getdents vs. f_pos handling on NOR flash.")
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 fs/jffs2/dir.c             | 49 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/jffs2/jffs2_fs_i.h      |  6 ++++++
 fs/jffs2/super.c           |  4 ++++
 fs/jffs2/write.c           | 30 +++++++++++++++++++---------
 include/uapi/linux/jffs2.h |  3 +++
 5 files changed, 83 insertions(+), 9 deletions(-)

diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
index 0a754f38462e..3b7d6a5a8d44 100644
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -37,6 +37,8 @@ static int jffs2_mknod (struct inode *,struct dentry *,umode_t,dev_t);
 static int jffs2_rename (struct inode *, struct dentry *,
 			 struct inode *, struct dentry *,
 			 unsigned int);
+static int jffs2_dir_release (struct inode *, struct file *);
+static int jffs2_dir_open (struct inode *, struct file *);
 
 const struct file_operations jffs2_dir_operations =
 {
@@ -45,6 +47,8 @@ const struct file_operations jffs2_dir_operations =
 	.unlocked_ioctl=jffs2_ioctl,
 	.fsync =	jffs2_fsync,
 	.llseek =	generic_file_llseek,
+	.open =		jffs2_dir_open,
+	.release =	jffs2_dir_release,
 };
 
 
@@ -869,3 +873,48 @@ static int jffs2_rename (struct inode *old_dir_i, struct dentry *old_dentry,
 	return 0;
 }
 
+static int jffs2_dir_open (struct inode *dir_i, struct file *filp)
+{
+#ifndef CONFIG_JFFS2_SUMMARY
+	struct jffs2_inode_info *dir_f = JFFS2_INODE_INFO(dir_i);
+
+	atomic_inc(&dir_f->nr_dir_opening);
+#endif
+
+	return 0;
+}
+
+static int jffs2_dir_release(struct inode *dir_i, struct file *filp)
+{
+#ifndef CONFIG_JFFS2_SUMMARY
+	struct jffs2_inode_info *dir_f = JFFS2_INODE_INFO(dir_i);
+
+	BUG_ON(atomic_read(&dir_f->nr_dir_opening) <= 0);
+
+	mutex_lock(&dir_f->sem);
+	/* jffs2_dir_open may increase nr_dir_opening after 
+	 * atomic_dec_and_test() returning true.
+	 * However, it cannot traverse the list until hold
+	 * mutex dir_f->sem lock, so that we can go on
+	 * removing.*/
+	if (atomic_dec_and_test(&dir_f->nr_dir_opening) &&
+			dir_f->obsolete_count > JFFS2_INVALID_LIMIT) {
+		struct jffs2_full_dirent **prev = &dir_f->dents;
+
+		/* remove all obsolete dirent from the list, which
+		 * can save memory space and reduce CPU time for
+		 * traverse the list */
+		while((*prev) && (dir_f->obsolete_count--)) {
+			if ((*prev)->raw == NULL && (*prev)->ino == 0) {
+				struct jffs2_full_dirent *this = *prev;
+				*prev = this->next;
+				jffs2_free_full_dirent(this);
+			} else
+				prev = &((*prev)->next);
+		}
+	}
+	mutex_unlock(&dir_f->sem);
+#endif
+
+	return 0;
+}
diff --git a/fs/jffs2/jffs2_fs_i.h b/fs/jffs2/jffs2_fs_i.h
index 2e4a86763c07..99c9debce58d 100644
--- a/fs/jffs2/jffs2_fs_i.h
+++ b/fs/jffs2/jffs2_fs_i.h
@@ -42,6 +42,12 @@ struct jffs2_inode_info {
 	/* Directory entries */
 	struct jffs2_full_dirent *dents;
 
+	/* Directory open refcount */
+	atomic_t nr_dir_opening;
+
+	/* obsolete dirent count in the list of 'dents' */
+	unsigned int obsolete_count;
+
 	/* The target path if this is the inode of a symlink */
 	unsigned char *target;
 
diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index f60dee7faf03..ed4311ca0b65 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -41,6 +41,10 @@ static struct inode *jffs2_alloc_inode(struct super_block *sb)
 	f = kmem_cache_alloc(jffs2_inode_cachep, GFP_KERNEL);
 	if (!f)
 		return NULL;
+
+	atomic_set(&f->nr_dir_opening, 0);
+	f->obsolete_count = 0;
+
 	return &f->vfs_inode;
 }
 
diff --git a/fs/jffs2/write.c b/fs/jffs2/write.c
index cda9a361368e..780b4fd9af51 100644
--- a/fs/jffs2/write.c
+++ b/fs/jffs2/write.c
@@ -600,29 +600,41 @@ int jffs2_do_unlink(struct jffs2_sb_info *c, struct jffs2_inode_info *dir_f,
 	} else {
 		uint32_t nhash = full_name_hash(NULL, name, namelen);
 
-		fd = dir_f->dents;
+		struct jffs2_full_dirent **prev = &dir_f->dents;
+
 		/* We don't actually want to reserve any space, but we do
 		   want to be holding the alloc_sem when we write to flash */
 		mutex_lock(&c->alloc_sem);
 		mutex_lock(&dir_f->sem);
 
-		for (fd = dir_f->dents; fd; fd = fd->next) {
-			if (fd->nhash == nhash &&
-			    !memcmp(fd->name, name, namelen) &&
-			    !fd->name[namelen]) {
+		while((*prev) && (*prev)->nhash <= nhash) {
+			if ((*prev)->nhash == nhash &&
+			    !memcmp((*prev)->name, name, namelen) &&
+			    !(*prev)->name[namelen]) {
 
+				fd = *prev;
 				jffs2_dbg(1, "Marking old dirent node (ino #%u) @%08x obsolete\n",
 					  fd->ino, ref_offset(fd->raw));
 				jffs2_mark_node_obsolete(c, fd->raw);
-				/* We don't want to remove it from the list immediately,
-				   because that screws up getdents()/seek() semantics even
-				   more than they're screwed already. Turn it into a
-				   node-less deletion dirent instead -- a placeholder */
 				fd->raw = NULL;
 				fd->ino = 0;
+
+				/* if nr_dir_openning is 0, we think nobody open the dir, and
+				 * nobody being in getdents()/seek() semantics. Thus, we can
+				 * safely remove this obsolete dirent from the list. Otherwise,
+				 * we just increase obsolete_count, and finally delete it in
+				 * jffs2_dir_release() */
+				if (atomic_read(&dir_f->nr_dir_opening) == 0) {
+					*prev = fd->next;
+					jffs2_free_full_dirent(fd);
+				} else
+					dir_f->obsolete_count++;
+
 				break;
 			}
+			prev = &((*prev)->next);
 		}
+
 		mutex_unlock(&dir_f->sem);
 	}
 
diff --git a/include/uapi/linux/jffs2.h b/include/uapi/linux/jffs2.h
index a18b719f49d4..dbfedecbb7e2 100644
--- a/include/uapi/linux/jffs2.h
+++ b/include/uapi/linux/jffs2.h
@@ -35,6 +35,9 @@
 */
 #define JFFS2_MAX_NAME_LEN 254
 
+/* obsolete dirent of dents list limit */
+#define JFFS2_INVALID_LIMIT 64
+
 /* How small can we sensibly write nodes? */
 #define JFFS2_MIN_DATA_LEN 128
 
-- 
2.13.6
