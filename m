Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933115AbeEHSGh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:06:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:54289 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933046AbeEHSGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:06:35 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 73/76] vfs: Move s_dev to to struct fs_view
Date: Tue,  8 May 2018 11:04:33 -0700
Message-Id: <20180508180436.716-74-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many places where a dev_t:ino_t pair are passed to userspace
to uniquely describe an inode.  Some file systems, like btrfs, have
multiple inode namespace internally and use a separate dev_t to make the
distinction between them.

The kernel typically uses sb->s_dev for the inode device. Most filesystems
are fine with that but btrfs needs to use the device beloning to the root
which that inode resides on. By moving s_dev into the fs_view we allow btrfs
and any similar filesystems to set this field on a per inode basis.

This patch adds a dev_t field to struct fs_view, v_dev and removes s_dev
from struct super_block. I also include a helper, inode_view() to make
referencing inode->i_view fields less clunky.

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 include/linux/fs.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5d4bb19b2a43..c93486505084 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1351,6 +1351,7 @@ struct sb_writers {
  */
 struct fs_view {
 	struct super_block	*v_sb;
+	dev_t			v_dev;		/* search index; _not_ kdev_t */
 };
 
 static inline struct super_block *inode_sb(const struct inode *inode)
@@ -1358,9 +1359,13 @@ static inline struct super_block *inode_sb(const struct inode *inode)
 	return inode->i_view->v_sb;
 }
 
+static inline struct fs_view *inode_view(const struct inode *inode)
+{
+	return inode->i_view;
+}
+
 struct super_block {
 	struct list_head	s_list;		/* Keep this first */
-	dev_t			s_dev;		/* search index; _not_ kdev_t */
 	unsigned char		s_blocksize_bits;
 	unsigned long		s_blocksize;
 	loff_t			s_maxbytes;	/* Max file size */
-- 
2.15.1
