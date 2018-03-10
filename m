Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751990AbeCJSbo (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:31:44 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36175 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932668AbeCJSVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:21:19 -0500
X-Google-Smtp-Source: AG47ELtI3phqD3D59xfPW1ErXrAqBnA83Gs4QJEifM2RWuqm74YiFNR6aHvJliVyXsFRhCIzWYWuLA==
From: Andiry Xu <jix024@eng.ucsd.edu>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
Subject: [RFC v2 52/83] Rebuild: file inode.
Date: Sat, 10 Mar 2018 10:18:33 -0800
Message-Id: <1520705944-6723-53-git-send-email-jix024@eng.ucsd.edu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andiry Xu <jix024@cs.ucsd.edu>

Rebuild file inode metadata and radix tree on read_inode.

Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
---
 fs/nova/log.h     |   4 ++
 fs/nova/rebuild.c | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+)

diff --git a/fs/nova/log.h b/fs/nova/log.h
index 87ce5f9..bdb85eb 100644
--- a/fs/nova/log.h
+++ b/fs/nova/log.h
@@ -385,6 +385,10 @@ int nova_inplace_update_write_entry(struct super_block *sb,
 int nova_append_file_write_entry(struct super_block *sb, struct nova_inode *pi,
 	struct inode *inode, struct nova_file_write_item *item,
 	struct nova_inode_update *update);
+int nova_assign_write_entry(struct super_block *sb,
+	struct nova_inode_info_header *sih,
+	struct nova_file_write_entry *entry,
+	bool free);
 int nova_invalidate_dentries(struct super_block *sb,
 	struct nova_inode_update *update);
 int nova_inplace_update_dentry(struct super_block *sb,
diff --git a/fs/nova/rebuild.c b/fs/nova/rebuild.c
index 9a1327d..07cf6e3 100644
--- a/fs/nova/rebuild.c
+++ b/fs/nova/rebuild.c
@@ -156,6 +156,126 @@ static int nova_rebuild_inode_finish(struct super_block *sb,
 	return 0;
 }
 
+static void nova_rebuild_handle_write_entry(struct super_block *sb,
+	struct nova_inode_info_header *sih, struct nova_inode_rebuild *reb,
+	struct nova_file_write_entry *entry)
+{
+	if (entry->num_pages != entry->invalid_pages) {
+		/*
+		 * The overlaped blocks are already freed.
+		 * Don't double free them, just re-assign the pointers.
+		 */
+		nova_assign_write_entry(sb, sih, entry, false);
+	}
+
+	if (entry->trans_id >= sih->trans_id) {
+		nova_rebuild_file_time_and_size(sb, reb,
+					entry->mtime, entry->mtime,
+					entry->size);
+		reb->trans_id = entry->trans_id;
+	}
+
+	/* Update sih->i_size for setattr apply operations */
+	sih->i_size = le64_to_cpu(reb->i_size);
+}
+
+static int nova_rebuild_file_inode_tree(struct super_block *sb,
+	struct nova_inode *pi, u64 pi_addr,
+	struct nova_inode_info_header *sih)
+{
+	struct nova_file_write_entry *entry = NULL;
+	struct nova_setattr_logentry *attr_entry = NULL;
+	struct nova_link_change_entry *link_change_entry = NULL;
+	struct nova_inode_rebuild rebuild, *reb;
+	unsigned int data_bits = blk_type_to_shift[sih->i_blk_type];
+	u64 ino = pi->nova_ino;
+	timing_t rebuild_time;
+	void *addr, *entryc = NULL;
+	u64 curr_p;
+	u8 type;
+	int ret;
+
+	NOVA_START_TIMING(rebuild_file_t, rebuild_time);
+	nova_dbg_verbose("Rebuild file inode %llu tree\n", ino);
+
+	reb = &rebuild;
+	ret = nova_rebuild_inode_start(sb, pi, sih, reb, pi_addr);
+	if (ret)
+		goto out;
+
+	curr_p = sih->log_head;
+	if (curr_p == 0 && sih->log_tail == 0)
+		goto out;
+
+//	nova_print_nova_log(sb, sih);
+
+	while (curr_p != sih->log_tail) {
+		if (goto_next_page(sb, curr_p)) {
+			sih->log_pages++;
+			curr_p = next_log_page(sb, curr_p);
+		}
+
+		if (curr_p == 0) {
+			nova_err(sb, "File inode %llu log is NULL!\n", ino);
+			ret = -EIO;
+			goto out;
+		}
+
+		addr = (void *)nova_get_block(sb, curr_p);
+
+		entryc = addr;
+
+		type = nova_get_entry_type(entryc);
+
+		switch (type) {
+		case SET_ATTR:
+			attr_entry = (struct nova_setattr_logentry *)entryc;
+			nova_apply_setattr_entry(sb, reb, sih, attr_entry);
+			sih->last_setattr = curr_p;
+			if (attr_entry->trans_id >= reb->trans_id) {
+				nova_rebuild_file_time_and_size(sb, reb,
+							attr_entry->mtime,
+							attr_entry->ctime,
+							attr_entry->size);
+				reb->trans_id = attr_entry->trans_id;
+			}
+
+			/* Update sih->i_size for setattr operation */
+			sih->i_size = le64_to_cpu(reb->i_size);
+			curr_p += sizeof(struct nova_setattr_logentry);
+			break;
+		case LINK_CHANGE:
+			link_change_entry =
+				(struct nova_link_change_entry *)entryc;
+			nova_apply_link_change_entry(sb, reb,
+						link_change_entry);
+			sih->last_link_change = curr_p;
+			curr_p += sizeof(struct nova_link_change_entry);
+			break;
+		case FILE_WRITE:
+			entry = (struct nova_file_write_entry *)addr;
+			nova_rebuild_handle_write_entry(sb, sih, reb,
+						entryc);
+			curr_p += sizeof(struct nova_file_write_entry);
+			break;
+		default:
+			nova_err(sb, "unknown type %d, 0x%llx\n", type, curr_p);
+			NOVA_ASSERT(0);
+			curr_p += sizeof(struct nova_file_write_entry);
+			break;
+		}
+
+	}
+
+	ret = nova_rebuild_inode_finish(sb, pi, sih, reb, curr_p);
+	sih->i_blocks = sih->log_pages + (sih->i_size >> data_bits);
+
+out:
+//	nova_print_inode_log_page(sb, inode);
+	NOVA_END_TIMING(rebuild_file_t, rebuild_time);
+	return ret;
+}
+
 /******************* Directory rebuild *********************/
 
 static inline void nova_rebuild_dir_time_and_size(struct super_block *sb,
@@ -360,12 +480,16 @@ int nova_rebuild_inode(struct super_block *sb, struct nova_inode_info *si,
 		/* Treat symlink files as normal files */
 		/* Fall through */
 	case S_IFREG:
+		nova_rebuild_file_inode_tree(sb, pi, pi_addr, sih);
 		break;
 	case S_IFDIR:
 		if (rebuild_dir)
 			nova_rebuild_dir_inode_tree(sb, pi, pi_addr, sih);
 		break;
 	default:
+		/* In case of special inode, walk the log */
+		if (pi->log_head)
+			nova_rebuild_file_inode_tree(sb, pi, pi_addr, sih);
 		sih->pi_addr = pi_addr;
 		break;
 	}
-- 
2.7.4
