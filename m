Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932400AbeCJSUp (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:20:45 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39984 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932374AbeCJSUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:20:42 -0500
X-Google-Smtp-Source: AG47ELuk4zAKNt8Buqk4FCt8bk86FO8tAmYFS8u5EJZfZ6jZQkuc81sesl+DuF0Y4xyPvqyy3msOwQ==
From: Andiry Xu <jix024@eng.ucsd.edu>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
Subject: [RFC v2 21/83] Add log structure.
Date: Sat, 10 Mar 2018 10:18:02 -0800
Message-Id: <1520705944-6723-22-git-send-email-jix024@eng.ucsd.edu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andiry Xu <jix024@cs.ucsd.edu>

NOVA log is a singly linked list of 4KB pmem pages.
Each log page consists of two parts: 4064 bytes for log entries,
and 32 bytes for page tail structure. Page tail contains metadata
about the log page and the address of the next log page in the
linked list.

Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
---
 fs/nova/log.h  | 187 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nova/nova.h |   1 +
 2 files changed, 188 insertions(+)
 create mode 100644 fs/nova/log.h

diff --git a/fs/nova/log.h b/fs/nova/log.h
new file mode 100644
index 0000000..61586a3
--- /dev/null
+++ b/fs/nova/log.h
@@ -0,0 +1,187 @@
+#ifndef __LOG_H
+#define __LOG_H
+
+#include "balloc.h"
+#include "inode.h"
+
+/* ======================= Log entry ========================= */
+/* Inode entry in the log */
+
+#define	MAIN_LOG	0
+#define	ALTER_LOG	1
+
+#define	PAGE_OFFSET_MASK	4095
+#define	BLOCK_OFF(p)	((p) & ~PAGE_OFFSET_MASK)
+
+#define	ENTRY_LOC(p)	((p) & PAGE_OFFSET_MASK)
+
+#define	LOG_BLOCK_TAIL	4064
+#define	PAGE_TAIL(p)	(BLOCK_OFF(p) + LOG_BLOCK_TAIL)
+
+/*
+ * Log page state and pointers to next page and the replica page
+ */
+struct nova_inode_page_tail {
+	__le32	invalid_entries;
+	__le32	num_entries;
+	__le64	epoch_id;	/* For snapshot list page */
+	__le64	padding;
+	__le64	next_page;
+} __attribute((__packed__));
+
+/* Fit in PAGE_SIZE */
+struct	nova_inode_log_page {
+	char padding[LOG_BLOCK_TAIL];
+	struct nova_inode_page_tail page_tail;
+} __attribute((__packed__));
+
+
+enum nova_entry_type {
+	FILE_WRITE = 1,
+	DIR_LOG,
+	SET_ATTR,
+	LINK_CHANGE,
+	NEXT_PAGE,
+};
+
+static inline u8 nova_get_entry_type(void *p)
+{
+	u8 type;
+	int rc;
+
+	rc = memcpy_mcsafe(&type, p, sizeof(u8));
+	if (rc)
+		return rc;
+
+	return type;
+}
+
+static inline void nova_set_entry_type(void *p, enum nova_entry_type type)
+{
+	*(u8 *)p = type;
+}
+
+static inline u64 next_log_page(struct super_block *sb, u64 curr)
+{
+	struct nova_inode_log_page *curr_page;
+	u64 next = 0;
+	int rc;
+
+	curr = BLOCK_OFF(curr);
+	curr_page = (struct nova_inode_log_page *)nova_get_block(sb, curr);
+	rc = memcpy_mcsafe(&next, &curr_page->page_tail.next_page,
+				sizeof(u64));
+	if (rc)
+		return rc;
+
+	return next;
+}
+
+static inline void nova_set_next_page_flag(struct super_block *sb, u64 curr_p)
+{
+	void *p;
+
+	if (ENTRY_LOC(curr_p) >= LOG_BLOCK_TAIL)
+		return;
+
+	p = nova_get_block(sb, curr_p);
+	nova_set_entry_type(p, NEXT_PAGE);
+	nova_flush_buffer(p, CACHELINE_SIZE, 1);
+}
+
+static inline void nova_set_next_page_address(struct super_block *sb,
+	struct nova_inode_log_page *curr_page, u64 next_page, int fence)
+{
+	curr_page->page_tail.next_page = next_page;
+	nova_flush_buffer(&curr_page->page_tail,
+				sizeof(struct nova_inode_page_tail), 0);
+	if (fence)
+		PERSISTENT_BARRIER();
+}
+
+static inline void nova_set_page_num_entries(struct super_block *sb,
+	struct nova_inode_log_page *curr_page, int num, int flush)
+{
+	curr_page->page_tail.num_entries = num;
+	if (flush)
+		nova_flush_buffer(&curr_page->page_tail,
+				sizeof(struct nova_inode_page_tail), 0);
+}
+
+static inline void nova_set_page_invalid_entries(struct super_block *sb,
+	struct nova_inode_log_page *curr_page, int num, int flush)
+{
+	curr_page->page_tail.invalid_entries = num;
+	if (flush)
+		nova_flush_buffer(&curr_page->page_tail,
+				sizeof(struct nova_inode_page_tail), 0);
+}
+
+static inline void nova_inc_page_num_entries(struct super_block *sb,
+	u64 curr)
+{
+	struct nova_inode_log_page *curr_page;
+
+	curr = BLOCK_OFF(curr);
+	curr_page = (struct nova_inode_log_page *)nova_get_block(sb, curr);
+
+	curr_page->page_tail.num_entries++;
+	nova_flush_buffer(&curr_page->page_tail,
+				sizeof(struct nova_inode_page_tail), 0);
+}
+
+static inline void nova_inc_page_invalid_entries(struct super_block *sb,
+	u64 curr)
+{
+	struct nova_inode_log_page *curr_page;
+
+	curr = BLOCK_OFF(curr);
+	curr_page = (struct nova_inode_log_page *)nova_get_block(sb, curr);
+
+	curr_page->page_tail.invalid_entries++;
+	if (curr_page->page_tail.invalid_entries >
+			curr_page->page_tail.num_entries) {
+		nova_dbg("Page 0x%llx has %u entries, %u invalid\n",
+				curr,
+				curr_page->page_tail.num_entries,
+				curr_page->page_tail.invalid_entries);
+	}
+
+	nova_flush_buffer(&curr_page->page_tail,
+				sizeof(struct nova_inode_page_tail), 0);
+}
+
+static inline bool is_last_entry(u64 curr_p, size_t size)
+{
+	unsigned int entry_end;
+
+	entry_end = ENTRY_LOC(curr_p) + size;
+
+	return entry_end > LOG_BLOCK_TAIL;
+}
+
+static inline bool goto_next_page(struct super_block *sb, u64 curr_p)
+{
+	void *addr;
+	u8 type;
+	int rc;
+
+	/* Each kind of entry takes at least 32 bytes */
+	if (ENTRY_LOC(curr_p) + 32 > LOG_BLOCK_TAIL)
+		return true;
+
+	addr = nova_get_block(sb, curr_p);
+	rc = memcpy_mcsafe(&type, addr, sizeof(u8));
+
+	if (rc < 0)
+		return true;
+
+	if (type == NEXT_PAGE)
+		return true;
+
+	return false;
+}
+
+
+
+#endif
diff --git a/fs/nova/nova.h b/fs/nova/nova.h
index 0992f50..f5b4ec8 100644
--- a/fs/nova/nova.h
+++ b/fs/nova/nova.h
@@ -301,6 +301,7 @@ static inline u64 nova_get_epoch_id(struct super_block *sb)
 }
 
 #include "inode.h"
+#include "log.h"
 
 /* A node in the RB tree representing a range of pages */
 struct nova_range_node {
-- 
2.7.4
