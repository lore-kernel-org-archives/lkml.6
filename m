Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932121AbeEWMQ4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 08:16:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60710 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754588AbeEWMQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 08:16:49 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/8] afs: Move /proc management functions to the end of the
 file
From: David Howells <dhowells@redhat.com>
To: viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Wed, 23 May 2018 13:16:47 +0100
Message-ID: <152707780776.27887.9678675851308301587.stgit@warthog.procyon.org.uk>
In-Reply-To: <152707780120.27887.10118775145086304138.stgit@warthog.procyon.org.uk>
References: <152707780120.27887.10118775145086304138.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In fs/afs/proc.c, move functions that create and remove /proc files to the
end of the source file as a first stage in getting rid of all the forward
declarations.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/proc.c |  160 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 79 insertions(+), 81 deletions(-)

diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 3aad32762989..4bb612b04f3c 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -127,45 +127,6 @@ static const struct file_operations afs_proc_sysname_fops = {
 	.write		= afs_proc_sysname_write,
 };
 
-static int afs_proc_stats_show(struct seq_file *m, void *v);
-
-/*
- * initialise the /proc/fs/afs/ directory
- */
-int afs_proc_init(struct afs_net *net)
-{
-	_enter("");
-
-	net->proc_afs = proc_mkdir("fs/afs", NULL);
-	if (!net->proc_afs)
-		goto error_dir;
-
-	if (!proc_create("cells", 0644, net->proc_afs, &afs_proc_cells_fops) ||
-	    !proc_create("rootcell", 0644, net->proc_afs, &afs_proc_rootcell_fops) ||
-	    !proc_create_seq("servers", 0644, net->proc_afs, &afs_proc_servers_ops) ||
-	    !proc_create_single("stats", 0644, net->proc_afs, afs_proc_stats_show) ||
-	    !proc_create("sysname", 0644, net->proc_afs, &afs_proc_sysname_fops))
-		goto error_tree;
-
-	_leave(" = 0");
-	return 0;
-
-error_tree:
-	proc_remove(net->proc_afs);
-error_dir:
-	_leave(" = -ENOMEM");
-	return -ENOMEM;
-}
-
-/*
- * clean up the /proc/fs/afs/ directory
- */
-void afs_proc_cleanup(struct afs_net *net)
-{
-	proc_remove(net->proc_afs);
-	net->proc_afs = NULL;
-}
-
 /*
  * open "/proc/fs/afs/cells" which provides a summary of extant cells
  */
@@ -383,48 +344,6 @@ static ssize_t afs_proc_rootcell_write(struct file *file,
 	return ret;
 }
 
-/*
- * initialise /proc/fs/afs/<cell>/
- */
-int afs_proc_cell_setup(struct afs_net *net, struct afs_cell *cell)
-{
-	struct proc_dir_entry *dir;
-
-	_enter("%p{%s},%p", cell, cell->name, net->proc_afs);
-
-	dir = proc_mkdir(cell->name, net->proc_afs);
-	if (!dir)
-		goto error_dir;
-
-	if (!proc_create_seq_data("vlservers", 0, dir,
-			&afs_proc_cell_vlservers_ops, cell))
-		goto error_tree;
-	if (!proc_create_seq_data("volumes", 0, dir, &afs_proc_cell_volumes_ops,
-			cell))
-		goto error_tree;
-
-	_leave(" = 0");
-	return 0;
-
-error_tree:
-	remove_proc_subtree(cell->name, net->proc_afs);
-error_dir:
-	_leave(" = -ENOMEM");
-	return -ENOMEM;
-}
-
-/*
- * remove /proc/fs/afs/<cell>/
- */
-void afs_proc_cell_remove(struct afs_net *net, struct afs_cell *cell)
-{
-	_enter("");
-
-	remove_proc_subtree(cell->name, net->proc_afs);
-
-	_leave("");
-}
-
 /*
  * set up the iterator to start reading from the cells list and return the
  * first item
@@ -842,3 +761,82 @@ static int afs_proc_stats_show(struct seq_file *m, void *v)
 		   atomic_long_read(&net->n_store_bytes));
 	return 0;
 }
+
+/*
+ * initialise /proc/fs/afs/<cell>/
+ */
+int afs_proc_cell_setup(struct afs_net *net, struct afs_cell *cell)
+{
+	struct proc_dir_entry *dir;
+
+	_enter("%p{%s},%p", cell, cell->name, net->proc_afs);
+
+	dir = proc_mkdir(cell->name, net->proc_afs);
+	if (!dir)
+		goto error_dir;
+
+	if (!proc_create_seq_data("vlservers", 0, dir,
+				  &afs_proc_cell_vlservers_ops, cell))
+		goto error_tree;
+	if (!proc_create_seq_data("volumes", 0, dir,
+				  &afs_proc_cell_volumes_ops, cell))
+		goto error_tree;
+
+	_leave(" = 0");
+	return 0;
+
+error_tree:
+	remove_proc_subtree(cell->name, net->proc_afs);
+error_dir:
+	_leave(" = -ENOMEM");
+	return -ENOMEM;
+}
+
+/*
+ * remove /proc/fs/afs/<cell>/
+ */
+void afs_proc_cell_remove(struct afs_net *net, struct afs_cell *cell)
+{
+	_enter("");
+
+	remove_proc_subtree(cell->name, net->proc_afs);
+
+	_leave("");
+}
+
+/*
+ * initialise the /proc/fs/afs/ directory
+ */
+int afs_proc_init(struct afs_net *net)
+{
+	_enter("");
+
+	net->proc_afs = proc_mkdir("fs/afs", NULL);
+	if (!net->proc_afs)
+		goto error_dir;
+
+	if (!proc_create("cells", 0644, net->proc_afs, &afs_proc_cells_fops) ||
+	    !proc_create("rootcell", 0644, net->proc_afs, &afs_proc_rootcell_fops) ||
+	    !proc_create_seq("servers", 0644, net->proc_afs, &afs_proc_servers_ops) ||
+	    !proc_create_single("stats", 0644, net->proc_afs, afs_proc_stats_show) ||
+	    !proc_create("sysname", 0644, net->proc_afs, &afs_proc_sysname_fops))
+		goto error_tree;
+
+	_leave(" = 0");
+	return 0;
+
+error_tree:
+	proc_remove(net->proc_afs);
+error_dir:
+	_leave(" = -ENOMEM");
+	return -ENOMEM;
+}
+
+/*
+ * clean up the /proc/fs/afs/ directory
+ */
+void afs_proc_cleanup(struct afs_net *net)
+{
+	proc_remove(net->proc_afs);
+	net->proc_afs = NULL;
+}
