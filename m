Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A40C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF6120881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BF6120881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732255AbeG2XhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 19:37:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51622 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729378AbeG2Xg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 19:36:57 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fjto7-0003WL-41; Sun, 29 Jul 2018 22:04:55 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 12/16] new helper: inode_fake_hash()
Date:   Sun, 29 Jul 2018 23:04:49 +0100
Message-Id: <20180729220453.13431-12-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180729220453.13431-1-viro@ZenIV.linux.org.uk>
References: <20180729220317.GB30522@ZenIV.linux.org.uk>
 <20180729220453.13431-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

open-coded in a quite a few places...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/hfs/inode.c     |  2 +-
 fs/jfs/jfs_imap.c  |  8 +-------
 fs/jfs/super.c     |  2 +-
 fs/xfs/xfs_iops.c  |  2 +-
 include/linux/fs.h | 11 +++++++++++
 5 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 2a16111d312f..a2dfa1b2a89c 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -541,7 +541,7 @@ static struct dentry *hfs_file_lookup(struct inode *dir, struct dentry *dentry,
 	HFS_I(inode)->rsrc_inode = dir;
 	HFS_I(dir)->rsrc_inode = inode;
 	igrab(dir);
-	hlist_add_fake(&inode->i_hash);
+	inode_fake_hash(inode);
 	mark_inode_dirty(inode);
 	dont_mount(dentry);
 out:
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index f36ef68905a7..93e8c590ff5c 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -491,13 +491,7 @@ struct inode *diReadSpecial(struct super_block *sb, ino_t inum, int secondary)
 	/* release the page */
 	release_metapage(mp);
 
-	/*
-	 * __mark_inode_dirty expects inodes to be hashed.  Since we don't
-	 * want special inodes in the fileset inode space, we make them
-	 * appear hashed, but do not put on any lists.  hlist_del()
-	 * will work fine and require no locking.
-	 */
-	hlist_add_fake(&ip->i_hash);
+	inode_fake_hash(ip);
 
 	return (ip);
 }
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 1b9264fd54b6..5403ece57dba 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -581,7 +581,7 @@ static int jfs_fill_super(struct super_block *sb, void *data, int silent)
 	inode->i_ino = 0;
 	inode->i_size = i_size_read(sb->s_bdev->bd_inode);
 	inode->i_mapping->a_ops = &jfs_metapage_aops;
-	hlist_add_fake(&inode->i_hash);
+	inode_fake_hash(inode);
 	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
 
 	sbi->direct_inode = inode;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 0fa29f39d658..3a75de777843 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1253,7 +1253,7 @@ xfs_setup_inode(
 
 	inode_sb_list_add(inode);
 	/* make the inode look hashed for the writeback code */
-	hlist_add_fake(&inode->i_hash);
+	inode_fake_hash(inode);
 
 	inode->i_uid    = xfs_uid_to_kuid(ip->i_d.di_uid);
 	inode->i_gid    = xfs_gid_to_kgid(ip->i_d.di_gid);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a42600565925..43941e230e2b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -685,6 +685,17 @@ static inline int inode_unhashed(struct inode *inode)
 }
 
 /*
+ * __mark_inode_dirty expects inodes to be hashed.  Since we don't
+ * want special inodes in the fileset inode space, we make them
+ * appear hashed, but do not put on any lists.  hlist_del()
+ * will work fine and require no locking.
+ */
+static inline void inode_fake_hash(struct inode *inode)
+{
+	hlist_add_fake(&inode->i_hash);
+}
+
+/*
  * inode->i_mutex nesting subclasses for the lock validator:
  *
  * 0: the object of the current VFS operation
-- 
2.11.0

