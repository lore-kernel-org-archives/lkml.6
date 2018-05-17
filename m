Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752542AbeEQPrl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 11:47:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752385AbeEQPrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 11:47:39 -0400
From: Jeff Layton <jlayton@kernel.org>
To: viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] vfs: remove iterate_supers_type
Date: Thu, 17 May 2018 11:47:37 -0400
Message-Id: <20180517154737.18877-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

Nothing calls this.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/super.c         | 36 ------------------------------------
 include/linux/fs.h |  2 --
 2 files changed, 38 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 30b7490bd049..456276033e59 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -631,42 +631,6 @@ void iterate_supers(void (*f)(struct super_block *, int), int arg)
 	spin_unlock(&sb_lock);
 }
 
-/**
- *	iterate_supers_type - call function for superblocks of given type
- *	@type: fs type
- *	@f: function to call
- *	@arg: argument to pass to it
- *
- *	Scans the superblock list and calls given function, passing it
- *	locked superblock and given argument.
- */
-void iterate_supers_type(struct file_system_type *type,
-	void (*f)(struct super_block *, void *), void *arg)
-{
-	struct super_block *sb, *p = NULL;
-
-	spin_lock(&sb_lock);
-	hlist_for_each_entry(sb, &type->fs_supers, s_instances) {
-		sb->s_count++;
-		spin_unlock(&sb_lock);
-
-		down_read(&sb->s_umount);
-		if (sb->s_root && (sb->s_flags & SB_BORN))
-			f(sb, arg);
-		up_read(&sb->s_umount);
-
-		spin_lock(&sb_lock);
-		if (p)
-			__put_super(p);
-		p = sb;
-	}
-	if (p)
-		__put_super(p);
-	spin_unlock(&sb_lock);
-}
-
-EXPORT_SYMBOL(iterate_supers_type);
-
 static struct super_block *__get_super(struct block_device *bdev, bool excl)
 {
 	struct super_block *sb;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7107d291d853..c4761eba3b44 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3116,8 +3116,6 @@ extern struct super_block *get_active_super(struct block_device *bdev);
 extern void drop_super(struct super_block *sb);
 extern void drop_super_exclusive(struct super_block *sb);
 extern void iterate_supers(void (*)(struct super_block *, int), int);
-extern void iterate_supers_type(struct file_system_type *,
-			        void (*)(struct super_block *, void *), void *);
 
 extern int dcache_dir_open(struct inode *, struct file *);
 extern int dcache_dir_close(struct inode *, struct file *);
-- 
2.17.0
