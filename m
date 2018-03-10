Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbeCJShU (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:37:20 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38391 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932452AbeCJSUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:20:55 -0500
X-Google-Smtp-Source: AG47ELueUk/5O1Pl31vmNTnB6P83H24Z1aZsWcCzJjQr7ZwQqPiSh/g3wXbRrNEcYVrWc79eQGaTLA==
From: Andiry Xu <jix024@eng.ucsd.edu>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
Subject: [RFC v2 32/83] Add log entry definitions.
Date: Sat, 10 Mar 2018 10:18:13 -0800
Message-Id: <1520705944-6723-33-git-send-email-jix024@eng.ucsd.edu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andiry Xu <jix024@cs.ucsd.edu>

NOVA appends log entries to the inode log upon metadata change.

NOVA has four kinds of log entries:

File write entry describes a write to a contiguous range of pmem pages,
Dentry describes a file/directory being added or removed from a directory,
Setattr entry is used for updating inode attributes,
Link change entry describes link changes to an inode, e.g. link/unlink.
All of them are aligned to 8 bytes.

Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
---
 fs/nova/log.h | 180 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 180 insertions(+)

diff --git a/fs/nova/log.h b/fs/nova/log.h
index 2bc131f..6b4a085 100644
--- a/fs/nova/log.h
+++ b/fs/nova/log.h
@@ -62,6 +62,175 @@ static inline void nova_set_entry_type(void *p, enum nova_entry_type type)
 	*(u8 *)p = type;
 }
 
+/*
+ * Write log entry.  Records a write to a contiguous range of PMEM pages.
+ *
+ * Documentation/filesystems/nova.txt contains descriptions of some fields.
+ */
+struct nova_file_write_entry {
+	u8	entry_type;
+	u8	reassigned;	/* Data is not latest */
+	u8	padding[2];
+	__le32	num_pages;
+	__le64	block;          /* offset of first block in this write */
+	__le64	pgoff;          /* file offset at the beginning of this write */
+	__le32	invalid_pages;	/* For GC */
+	/* For both ctime and mtime */
+	__le32	mtime;
+	__le64	size;           /* Write size for non-aligned writes */
+	__le64	epoch_id;
+	__le64	trans_id;
+	__le32	csumpadding;
+	__le32	csum;
+} __attribute((__packed__));
+
+#define WENTRY(entry)	((struct nova_file_write_entry *) entry)
+
+/* List of file write entries */
+struct nova_file_write_item {
+	struct nova_file_write_entry	entry;
+	struct list_head		list;
+};
+
+/*
+ * Log entry for adding a file/directory to a directory.
+ *
+ * Update DIR_LOG_REC_LEN if modify this struct!
+ */
+struct nova_dentry {
+	u8	entry_type;
+	u8	name_len;		/* length of the dentry name */
+	u8	reassigned;		/* Currently deleted */
+	u8	invalid;		/* Invalid now? */
+	__le16	de_len;			/* length of this dentry */
+	__le16	links_count;
+	__le32	mtime;			/* For both mtime and ctime */
+	__le32	csum;			/* entry checksum */
+	__le64	ino;			/* inode no pointed to by this entry */
+	__le64	padding;
+	__le64	epoch_id;
+	__le64	trans_id;
+	char	name[NOVA_NAME_LEN + 1];	/* File name */
+} __attribute((__packed__));
+
+#define DENTRY(entry)	((struct nova_dentry *) entry)
+
+#define NOVA_DIR_PAD			8	/* Align to 8 bytes boundary */
+#define NOVA_DIR_ROUND			(NOVA_DIR_PAD - 1)
+#define NOVA_DENTRY_HEADER_LEN		48
+#define NOVA_DIR_LOG_REC_LEN(name_len) \
+	(((name_len + 1) + NOVA_DENTRY_HEADER_LEN \
+	 + NOVA_DIR_ROUND) & ~NOVA_DIR_ROUND)
+
+#define NOVA_MAX_ENTRY_LEN		NOVA_DIR_LOG_REC_LEN(NOVA_NAME_LEN)
+
+/*
+ * Log entry for updating file attributes.
+ */
+struct nova_setattr_logentry {
+	u8	entry_type;
+	u8	attr;       /* bitmap of which attributes to update */
+	__le16	mode;
+	__le32	uid;
+	__le32	gid;
+	__le32	atime;
+	__le32	mtime;
+	__le32	ctime;
+	__le64	size;        /* File size after truncation */
+	__le64	epoch_id;
+	__le64	trans_id;
+	u8	invalid;
+	u8	paddings[3];
+	__le32	csum;
+} __attribute((__packed__));
+
+#define SENTRY(entry)	((struct nova_setattr_logentry *) entry)
+
+/* Link change log entry.
+ *
+ * TODO: Do we need this to be 32 bytes?
+ */
+struct nova_link_change_entry {
+	u8	entry_type;
+	u8	invalid;
+	__le16	links;
+	__le32	ctime;
+	__le32	flags;
+	__le32	generation;    /* for NFS handles */
+	__le64	epoch_id;
+	__le64	trans_id;
+	__le32	csumpadding;
+	__le32	csum;
+} __attribute((__packed__));
+
+#define LCENTRY(entry)	((struct nova_link_change_entry *) entry)
+
+
+/*
+ * Transient DRAM structure that describes changes needed to append a log entry
+ * to an inode
+ */
+struct nova_inode_update {
+	u64 head;
+	u64 tail;
+	u64 curr_entry;
+	struct nova_dentry *create_dentry;
+	struct nova_dentry *delete_dentry;
+};
+
+
+/*
+ * Transient DRAM structure to parameterize the creation of a log entry.
+ */
+struct nova_log_entry_info {
+	enum nova_entry_type type;
+	struct iattr *attr;
+	struct nova_inode_update *update;
+	void *data;	/* struct dentry */
+	u64 epoch_id;
+	u64 trans_id;
+	u64 curr_p;	/* output */
+	u64 file_size;	/* de_len for dentry */
+	u64 ino;
+	u32 time;
+	int link_change;
+	int inplace;	/* For file write entry */
+};
+
+
+
+static inline size_t nova_get_log_entry_size(struct super_block *sb,
+	enum nova_entry_type type)
+{
+	size_t size = 0;
+
+	switch (type) {
+	case FILE_WRITE:
+		size = sizeof(struct nova_file_write_entry);
+		break;
+	case DIR_LOG:
+		size = NOVA_DENTRY_HEADER_LEN;
+		break;
+	case SET_ATTR:
+		size = sizeof(struct nova_setattr_logentry);
+		break;
+	case LINK_CHANGE:
+		size = sizeof(struct nova_link_change_entry);
+		break;
+	default:
+		break;
+	}
+
+	return size;
+}
+
+static inline void nova_persist_entry(void *entry)
+{
+	size_t entry_len = CACHELINE_SIZE;
+
+	nova_flush_buffer(entry, entry_len, 0);
+}
+
 static inline u64 next_log_page(struct super_block *sb, u64 curr)
 {
 	struct nova_inode_log_page *curr_page;
@@ -183,6 +352,17 @@ static inline bool goto_next_page(struct super_block *sb, u64 curr_p)
 	return false;
 }
 
+static inline int is_dir_init_entry(struct super_block *sb,
+	struct nova_dentry *entry)
+{
+	if (entry->name_len == 1 && strncmp(entry->name, ".", 1) == 0)
+		return 1;
+	if (entry->name_len == 2 && strncmp(entry->name, "..", 2) == 0)
+		return 1;
+
+	return 0;
+}
+
 
 int nova_allocate_inode_log_pages(struct super_block *sb,
 	struct nova_inode_info_header *sih, unsigned long num_pages,
-- 
2.7.4
