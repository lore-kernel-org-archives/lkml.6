Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755759AbeEHSGA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:06:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:54115 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755721AbeEHSFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:55 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 46/76] fs/kernfs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:06 -0700
Message-Id: <20180508180436.716-47-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/kernfs/dir.c   | 4 ++--
 fs/kernfs/inode.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 89d1dc19340b..1239244e826a 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1059,7 +1059,7 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	mutex_lock(&kernfs_mutex);
 
 	if (kernfs_ns_enabled(parent))
-		ns = kernfs_info(dir->i_sb)->ns;
+		ns = kernfs_info(inode_sb(dir))->ns;
 
 	kn = kernfs_find_ns(parent, dentry->d_name.name, ns);
 
@@ -1070,7 +1070,7 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	}
 
 	/* attach dentry and inode */
-	inode = kernfs_get_inode(dir->i_sb, kn);
+	inode = kernfs_get_inode(inode_sb(dir), kn);
 	if (!inode) {
 		ret = ERR_PTR(-ENOMEM);
 		goto out_unlock;
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index a34303981deb..7b005800d815 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -173,7 +173,7 @@ static inline void set_default_inode_attr(struct inode *inode, umode_t mode)
 
 static inline void set_inode_attr(struct inode *inode, struct iattr *iattr)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	inode->i_uid = iattr->ia_uid;
 	inode->i_gid = iattr->ia_gid;
 	inode->i_atime = timespec_trunc(iattr->ia_atime, sb->s_time_gran);
-- 
2.15.1
