Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932496AbeCJSU7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:20:59 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35947 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932374AbeCJSUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:20:53 -0500
X-Google-Smtp-Source: AG47ELsuAu7CNftMQr1Q+LKTqKOLt60OYaQ3O3bJpQNUIaYGkt53L+VSyIll5cvpQhbF+PuzEN7y5Q==
From: Andiry Xu <jix024@eng.ucsd.edu>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
Subject: [RFC v2 30/83] New NOVA inode allocation.
Date: Sat, 10 Mar 2018 10:18:11 -0800
Message-Id: <1520705944-6723-31-git-send-email-jix024@eng.ucsd.edu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andiry Xu <jix024@cs.ucsd.edu>

Allocate the new inode in a round-robin way.
Extend the inode table if needed.

Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
---
 fs/nova/inode.c | 40 ++++++++++++++++++++++++++++++++++++++++
 fs/nova/inode.h |  1 +
 2 files changed, 41 insertions(+)

diff --git a/fs/nova/inode.c b/fs/nova/inode.c
index 29d172a..e4b8960 100644
--- a/fs/nova/inode.c
+++ b/fs/nova/inode.c
@@ -489,6 +489,46 @@ int nova_free_inuse_inode(struct super_block *sb, unsigned long ino)
 	return ret;
 }
 
+/* Returns 0 on failure */
+u64 nova_new_nova_inode(struct super_block *sb, u64 *pi_addr)
+{
+	struct nova_sb_info *sbi = NOVA_SB(sb);
+	struct inode_map *inode_map;
+	unsigned long free_ino = 0;
+	int map_id;
+	u64 ino = 0;
+	int ret;
+	timing_t new_inode_time;
+
+	NOVA_START_TIMING(new_nova_inode_t, new_inode_time);
+	map_id = sbi->map_id;
+	sbi->map_id = (sbi->map_id + 1) % sbi->cpus;
+
+	inode_map = &sbi->inode_maps[map_id];
+
+	mutex_lock(&inode_map->inode_table_mutex);
+	ret = nova_alloc_unused_inode(sb, map_id, &free_ino);
+	if (ret) {
+		nova_dbg("%s: alloc inode number failed %d\n", __func__, ret);
+		mutex_unlock(&inode_map->inode_table_mutex);
+		return 0;
+	}
+
+	ret = nova_get_inode_address(sb, free_ino, pi_addr, 1);
+	if (ret) {
+		nova_dbg("%s: get inode address failed %d\n", __func__, ret);
+		mutex_unlock(&inode_map->inode_table_mutex);
+		return 0;
+	}
+
+	mutex_unlock(&inode_map->inode_table_mutex);
+
+	ino = free_ino;
+
+	NOVA_END_TIMING(new_nova_inode_t, new_inode_time);
+	return ino;
+}
+
 int nova_write_inode(struct inode *inode, struct writeback_control *wbc)
 {
 	/* write_inode should never be called because we always keep our inodes
diff --git a/fs/nova/inode.h b/fs/nova/inode.h
index f9f5c14..fc1876c 100644
--- a/fs/nova/inode.h
+++ b/fs/nova/inode.h
@@ -229,6 +229,7 @@ int nova_get_inode_address(struct super_block *sb, u64 ino,
 struct inode *nova_iget(struct super_block *sb, unsigned long ino);
 inline int nova_insert_inodetree(struct nova_sb_info *sbi,
 	struct nova_range_node *new_node, int cpu);
+u64 nova_new_nova_inode(struct super_block *sb, u64 *pi_addr);
 extern int nova_write_inode(struct inode *inode, struct writeback_control *wbc);
 extern void nova_dirty_inode(struct inode *inode, int flags);
 
-- 
2.7.4
