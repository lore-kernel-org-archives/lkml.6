Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964883AbeCGUfN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 15:35:13 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934887AbeCGUfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 15:35:09 -0500
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Waiman Long <longman@redhat.com>
Subject: [PATCH 4/5] proc/sysctl: Handle CTL_FLAGS_SHOW_RANGE ctl_table flag
Date: Wed,  7 Mar 2018 15:34:28 -0500
Message-Id: <1520454869-13871-5-git-send-email-longman@redhat.com>
In-Reply-To: <1520454869-13871-1-git-send-email-longman@redhat.com>
References: <1520454869-13871-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When registering ctl_table entries with CTL_FLAGS_SHOW_RANGE flag set,
it will populate the reserved range table entries with the proper
sysctl parameters to show the range the those ctl_table entries.

When unregistering the ctl_table, we also need to clear the reserved
range table entries to avoid referencing memory that will be freed.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 fs/proc/proc_sysctl.c  | 99 +++++++++++++++++++++++++++++++++++++++++++++++---
 include/linux/sysctl.h |  1 +
 2 files changed, 95 insertions(+), 5 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 493c975..5f8fde97 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -304,6 +304,16 @@ static void proc_sys_prune_dcache(struct ctl_table_header *head)
 static void start_unregistering(struct ctl_table_header *p)
 {
 	/*
+	 * Clear reserved range table entries before freeing.
+	 */
+	if (p->roffset) {
+		struct ctl_table *entry = p->ctl_table + p->roffset;
+
+		for (; entry->proc_handler == proc_show_minmax; entry++)
+			entry->procname = NULL;
+	}
+
+	/*
 	 * if p->used is 0, nobody will ever touch that entry again;
 	 * we'll eliminate all paths to it before dropping sysctl_lock
 	 */
@@ -1206,7 +1216,6 @@ static int insert_links(struct ctl_table_header *head)
 
 	if (head->set == root_set)
 		return 0;
-
 	core_parent = xlate_dir(root_set, head->parent);
 	if (IS_ERR(core_parent))
 		return 0;
@@ -1238,6 +1247,19 @@ static int insert_links(struct ctl_table_header *head)
 	return err;
 }
 
+static bool sysctl_show_range(struct ctl_table *entry)
+{
+	if (!(entry->flags & CTL_FLAGS_SHOW_RANGE))
+		return false;
+
+	if ((entry->maxlen == sizeof(int)) || (entry->maxlen == sizeof(long)))
+		return true;
+
+	pr_warn("Warning: ctl_table entry \"%s\" doesn't support CTL_FLAGS_SHOW_RANGE\n",
+		entry->procname);
+	return false;
+}
+
 /**
  * __register_sysctl_table - register a leaf sysctl table
  * @set: Sysctl tree to register on
@@ -1291,16 +1313,67 @@ struct ctl_table_header *__register_sysctl_table(
 	struct ctl_table *entry;
 	struct ctl_node *node;
 	int nr_entries = 0;
+	int nr_ranges = 0;	/* # of entries with CTL_FLAGS_SHOW_RANGE */
+	int namelen = 0;
+	int i, j;
 
-	for (entry = table; entry->procname; entry++)
+	for (entry = table; entry->procname; entry++) {
 		nr_entries++;
+		if (sysctl_show_range(entry)) {
+			nr_ranges++;
+			/* procname + "_range\0" suffix */
+			namelen += strlen(entry->procname) + 7;
+		}
+	}
+
+	if (nr_ranges) {
+		for (i = 0; entry->proc_handler == proc_show_minmax; entry++)
+			i++;
+
+		if (i < nr_ranges) {
+			pr_err("Error: Insufficient reserved ctl_table range entries (\"%s\")!\n",
+				table->procname);
+			return NULL;
+		} else if (i > nr_ranges) {
+			pr_warn("Warning: Too many reserved ctl_table range entries (\"%s\")!\n",
+				table->procname);
+		}
+	}
 
 	header = kzalloc(sizeof(struct ctl_table_header) +
-			 sizeof(struct ctl_node)*nr_entries, GFP_KERNEL);
+			 sizeof(struct ctl_node)*(nr_entries + nr_ranges) +
+			 namelen, GFP_KERNEL);
 	if (!header)
 		return NULL;
-
 	node = (struct ctl_node *)(header + 1);
+
+	/*
+	 * Fill up reserved range entries for showing the ranges of those
+	 * sysctl parameters that have the CTL_FLAGS_SHOW_RANGE flag set.
+	 */
+	if (nr_ranges) {
+		int len;
+		char *namebuf = (char *)(node + nr_entries + nr_ranges);
+
+		header->roffset = nr_entries;
+		for (i = 0, j = nr_entries ; i < nr_entries; i++) {
+			if (!sysctl_show_range(&table[i]))
+				continue;
+
+			len = strlen(table[i].procname);
+			memcpy(namebuf, table[i].procname, len);
+			memcpy(namebuf + len, "_range\0", 7);
+			table[j].procname = namebuf;
+			table[j].data = (void *)&table[i];
+			table[j].mode = table[i].mode & 0444;	/* Read only */
+
+			namebuf += len + 7;
+			namelen -= len + 7;
+			j++;
+		}
+		WARN_ON((j != nr_entries + nr_ranges) || namelen);
+	}
+
 	init_header(header, root, set, node, table);
 	if (sysctl_check_table(path, table))
 		goto fail;
@@ -1313,7 +1386,6 @@ struct ctl_table_header *__register_sysctl_table(
 
 	/* Find the directory for the ctl_table */
 	for (name = path; name; name = nextname) {
-		int namelen;
 		nextname = strchr(name, '/');
 		if (nextname) {
 			namelen = nextname - name;
@@ -1342,6 +1414,13 @@ struct ctl_table_header *__register_sysctl_table(
 	drop_sysctl_table(&dir->header);
 	spin_unlock(&sysctl_lock);
 fail:
+	if (nr_ranges) {
+		/*
+		 * Clear procname of the reserved range table entries.
+		 */
+		for (i = nr_entries; i < nr_entries + nr_ranges; i++)
+			table[i].procname = NULL;
+	}
 	kfree(header);
 	dump_stack();
 	return NULL;
@@ -1654,6 +1733,16 @@ void unregister_sysctl_table(struct ctl_table_header * header)
 			unregister_sysctl_table(subh);
 			kfree(table);
 		}
+		/*
+		 * Clear reserved range table entries before freeing.
+		 */
+		if (header->roffset) {
+			struct ctl_table *entry = header->ctl_table +
+						  header->roffset;
+
+			for (; entry->proc_handler == proc_show_minmax; entry++)
+				entry->procname = NULL;
+		}
 		kfree(header);
 		return;
 	}
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index ca64d66..e922ee3 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -202,6 +202,7 @@ struct ctl_table_header
 			int used;
 			int count;
 			int nreg;
+			int roffset;	/* Offset of reserved range entries */
 		};
 		struct rcu_head rcu;
 	};
-- 
1.8.3.1
