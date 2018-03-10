Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932522AbeCJSVC (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:21:02 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34766 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932406AbeCJSVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:21:00 -0500
X-Google-Smtp-Source: AG47ELuNkiox9Au7t6z5w6OmURuaVB+JqOBYLFZetjSu7qdqIOE0jNBXCKDAuy2uGGvHxPsgxXKjzw==
From: Andiry Xu <jix024@eng.ucsd.edu>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
Subject: [RFC v2 36/83] Journal: Lite journal recovery.
Date: Sat, 10 Mar 2018 10:18:17 -0800
Message-Id: <1520705944-6723-37-git-send-email-jix024@eng.ucsd.edu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andiry Xu <jix024@cs.ucsd.edu>

Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
---
 fs/nova/journal.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/fs/nova/journal.c b/fs/nova/journal.c
index 75d590f..f31de97 100644
--- a/fs/nova/journal.c
+++ b/fs/nova/journal.c
@@ -106,3 +106,58 @@ static int nova_check_journal_entries(struct super_block *sb,
 
 	return 0;
 }
+
+/**************************** Journal Recovery ******************************/
+
+static void nova_undo_journal_entry(struct super_block *sb,
+	struct nova_lite_journal_entry *entry)
+{
+	u64 addr, value;
+
+	addr = le64_to_cpu(entry->data1);
+	value = le64_to_cpu(entry->data2);
+
+	*(u64 *)nova_get_block(sb, addr) = (u64)value;
+	nova_flush_buffer((void *)nova_get_block(sb, addr), CACHELINE_SIZE, 0);
+}
+
+static void nova_undo_lite_journal_entry(struct super_block *sb,
+	struct nova_lite_journal_entry *entry)
+{
+	u64 type;
+
+	type = le64_to_cpu(entry->type);
+
+	switch (type) {
+	case JOURNAL_INODE:
+		/* Currently unused */
+		break;
+	case JOURNAL_ENTRY:
+		nova_undo_journal_entry(sb, entry);
+		break;
+	default:
+		nova_dbg("%s: unknown data type %llu\n", __func__, type);
+		break;
+	}
+}
+
+/* Roll back all journal enries */
+static int nova_recover_lite_journal(struct super_block *sb,
+	struct journal_ptr_pair *pair)
+{
+	struct nova_lite_journal_entry *entry;
+	u64 temp;
+
+	temp = pair->journal_head;
+	while (temp != pair->journal_tail) {
+		entry = (struct nova_lite_journal_entry *)nova_get_block(sb,
+									temp);
+		nova_undo_lite_journal_entry(sb, entry);
+		temp = next_lite_journal(temp);
+	}
+
+	pair->journal_tail = pair->journal_head;
+	nova_flush_buffer(&pair->journal_head, CACHELINE_SIZE, 1);
+
+	return 0;
+}
-- 
2.7.4
