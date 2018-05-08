Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933330AbeEHS2c (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:28:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:54053 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755650AbeEHSFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:48 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 41/76] fs/hugetlbfs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:01 -0700
Message-Id: <20180508180436.716-42-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/hugetlbfs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index b9a254dcc0e7..31d2a6051bea 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -791,7 +791,7 @@ static int hugetlbfs_mknod(struct inode *dir,
 	struct inode *inode;
 	int error = -ENOSPC;
 
-	inode = hugetlbfs_get_inode(dir->i_sb, dir, mode, dev);
+	inode = hugetlbfs_get_inode(inode_sb(dir), dir, mode, dev);
 	if (inode) {
 		dir->i_ctime = dir->i_mtime = current_time(dir);
 		d_instantiate(dentry, inode);
@@ -820,7 +820,7 @@ static int hugetlbfs_symlink(struct inode *dir,
 	struct inode *inode;
 	int error = -ENOSPC;
 
-	inode = hugetlbfs_get_inode(dir->i_sb, dir, S_IFLNK|S_IRWXUGO, 0);
+	inode = hugetlbfs_get_inode(inode_sb(dir), dir, S_IFLNK|S_IRWXUGO, 0);
 	if (inode) {
 		int l = strlen(symname)+1;
 		error = page_symlink(inode, symname, l);
@@ -1021,7 +1021,7 @@ static void hugetlbfs_i_callback(struct rcu_head *head)
 
 static void hugetlbfs_destroy_inode(struct inode *inode)
 {
-	hugetlbfs_inc_free_inodes(HUGETLBFS_SB(inode->i_sb));
+	hugetlbfs_inc_free_inodes(HUGETLBFS_SB(inode_sb(inode)));
 	mpol_free_shared_policy(&HUGETLBFS_I(inode)->policy);
 	call_rcu(&inode->i_rcu, hugetlbfs_i_callback);
 }
-- 
2.15.1
