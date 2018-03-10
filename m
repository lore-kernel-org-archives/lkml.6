Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbeCJSiL (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:38:11 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45285 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932275AbeCJSUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:20:50 -0500
X-Google-Smtp-Source: AG47ELtI78Mc2a9/94ThLjXFl0c6rWYNxLwb2ftUZPJ7g7L/GYFBI0l1MOOp9H/kXpMA6aht4ZDpRg==
From: Andiry Xu <jix024@eng.ucsd.edu>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
Subject: [RFC v2 28/83] Add NOVA address space operations
Date: Sat, 10 Mar 2018 10:18:09 -0800
Message-Id: <1520705944-6723-29-git-send-email-jix024@eng.ucsd.edu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andiry Xu <jix024@cs.ucsd.edu>

direct_IO and writepages support.

Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
---
 fs/nova/inode.c | 24 ++++++++++++++++++++++++
 fs/nova/inode.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/fs/nova/inode.c b/fs/nova/inode.c
index 7c10d0e..a30b6aa 100644
--- a/fs/nova/inode.c
+++ b/fs/nova/inode.c
@@ -175,6 +175,7 @@ static int nova_read_inode(struct super_block *sb, struct inode *inode,
 	}
 
 	inode->i_blocks = sih->i_blocks;
+	inode->i_mapping->a_ops = &nova_aops_dax;
 
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFREG:
@@ -488,3 +489,26 @@ int nova_free_inuse_inode(struct super_block *sb, unsigned long ino)
 	return ret;
 }
 
+static ssize_t nova_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
+{
+	/* DAX does not support direct IO */
+	return -EIO;
+}
+
+static int nova_writepages(struct address_space *mapping,
+	struct writeback_control *wbc)
+{
+	int ret;
+	timing_t wp_time;
+
+	NOVA_START_TIMING(write_pages_t, wp_time);
+	ret = dax_writeback_mapping_range(mapping,
+			mapping->host->i_sb->s_bdev, wbc);
+	NOVA_END_TIMING(write_pages_t, wp_time);
+	return ret;
+}
+
+const struct address_space_operations nova_aops_dax = {
+	.writepages		= nova_writepages,
+	.direct_IO		= nova_direct_IO,
+};
diff --git a/fs/nova/inode.h b/fs/nova/inode.h
index 497343d..e00b3b9 100644
--- a/fs/nova/inode.h
+++ b/fs/nova/inode.h
@@ -221,6 +221,7 @@ static inline int nova_persist_inode(struct nova_inode *pi)
 }
 
 
+extern const struct address_space_operations nova_aops_dax;
 int nova_init_inode_inuse_list(struct super_block *sb);
 int nova_init_inode_table(struct super_block *sb);
 int nova_get_inode_address(struct super_block *sb, u64 ino,
-- 
2.7.4
