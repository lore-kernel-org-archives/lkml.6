Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755958AbeEHS0i (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:26:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:54135 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755673AbeEHSF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:56 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 47/76] fs/lockd: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:07 -0700
Message-Id: <20180508180436.716-48-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/lockd/svclock.c | 8 ++++----
 fs/lockd/svcsubs.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 3701bccab478..d13892c7bd89 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -405,7 +405,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 	__be32			ret;
 
 	dprintk("lockd: nlmsvc_lock(%s/%ld, ty=%d, pi=%d, %Ld-%Ld, bl=%d)\n",
-				file_inode(file->f_file)->i_sb->s_id,
+				inode_sb(file_inode(file->f_file))->s_id,
 				file_inode(file->f_file)->i_ino,
 				lock->fl.fl_type, lock->fl.fl_pid,
 				(long long)lock->fl.fl_start,
@@ -511,7 +511,7 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 	__be32			ret;
 
 	dprintk("lockd: nlmsvc_testlock(%s/%ld, ty=%d, %Ld-%Ld)\n",
-				file_inode(file->f_file)->i_sb->s_id,
+				inode_sb(file_inode(file->f_file))->s_id,
 				file_inode(file->f_file)->i_ino,
 				lock->fl.fl_type,
 				(long long)lock->fl.fl_start,
@@ -566,7 +566,7 @@ nlmsvc_unlock(struct net *net, struct nlm_file *file, struct nlm_lock *lock)
 	int	error;
 
 	dprintk("lockd: nlmsvc_unlock(%s/%ld, pi=%d, %Ld-%Ld)\n",
-				file_inode(file->f_file)->i_sb->s_id,
+				inode_sb(file_inode(file->f_file))->s_id,
 				file_inode(file->f_file)->i_ino,
 				lock->fl.fl_pid,
 				(long long)lock->fl.fl_start,
@@ -595,7 +595,7 @@ nlmsvc_cancel_blocked(struct net *net, struct nlm_file *file, struct nlm_lock *l
 	int status = 0;
 
 	dprintk("lockd: nlmsvc_cancel(%s/%ld, pi=%d, %Ld-%Ld)\n",
-				file_inode(file->f_file)->i_sb->s_id,
+				inode_sb(file_inode(file->f_file))->s_id,
 				file_inode(file->f_file)->i_ino,
 				lock->fl.fl_pid,
 				(long long)lock->fl.fl_start,
diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index 4ec3d6e03e76..d29444c19cdc 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -47,7 +47,7 @@ static inline void nlm_debug_print_file(char *msg, struct nlm_file *file)
 	struct inode *inode = file_inode(file->f_file);
 
 	dprintk("lockd: %s %s/%ld\n",
-		msg, inode->i_sb->s_id, inode->i_ino);
+		msg, inode_sb(inode)->s_id, inode->i_ino);
 }
 #else
 static inline void nlm_debug_print_fh(char *msg, struct nfs_fh *f)
@@ -414,7 +414,7 @@ nlmsvc_match_sb(void *datap, struct nlm_file *file)
 {
 	struct super_block *sb = datap;
 
-	return sb == file_inode(file->f_file)->i_sb;
+	return sb == inode_sb(file_inode(file->f_file));
 }
 
 /**
-- 
2.15.1
