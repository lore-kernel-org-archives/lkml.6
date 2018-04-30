Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755500AbeD3XUc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 19:20:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752614AbeD3XU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 19:20:29 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/3] afs: Rearrange fs/afs/proc.c
From: David Howells <dhowells@redhat.com>
To: hch@lst.de
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Tue, 01 May 2018 00:20:27 +0100
Message-ID: <152513042709.13808.18264656656070061524.stgit@warthog.procyon.org.uk>
In-Reply-To: <152513042072.13808.9692322366778075206.stgit@warthog.procyon.org.uk>
References: <152513042072.13808.9692322366778075206.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rearrange fs/afs/proc.c to get rid of all the predeclarations.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/proc.c |  765 +++++++++++++++++++++++++--------------------------------
 1 file changed, 330 insertions(+), 435 deletions(-)

diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 839a22280606..363383e9961f 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -27,237 +27,49 @@ static inline struct afs_net *afs_seq2net(struct seq_file *m)
 	return &__afs_net; // TODO: use seq_file_net(m)
 }
 
-static int afs_proc_cells_open(struct inode *inode, struct file *file);
-static void *afs_proc_cells_start(struct seq_file *p, loff_t *pos);
-static void *afs_proc_cells_next(struct seq_file *p, void *v, loff_t *pos);
-static void afs_proc_cells_stop(struct seq_file *p, void *v);
-static int afs_proc_cells_show(struct seq_file *m, void *v);
-static ssize_t afs_proc_cells_write(struct file *file, const char __user *buf,
-				    size_t size, loff_t *_pos);
-
-static const struct seq_operations afs_proc_cells_ops = {
-	.start	= afs_proc_cells_start,
-	.next	= afs_proc_cells_next,
-	.stop	= afs_proc_cells_stop,
-	.show	= afs_proc_cells_show,
-};
-
-static const struct file_operations afs_proc_cells_fops = {
-	.open		= afs_proc_cells_open,
-	.read		= seq_read,
-	.write		= afs_proc_cells_write,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
-static ssize_t afs_proc_rootcell_read(struct file *file, char __user *buf,
-				      size_t size, loff_t *_pos);
-static ssize_t afs_proc_rootcell_write(struct file *file,
-				       const char __user *buf,
-				       size_t size, loff_t *_pos);
-
-static const struct file_operations afs_proc_rootcell_fops = {
-	.read		= afs_proc_rootcell_read,
-	.write		= afs_proc_rootcell_write,
-	.llseek		= no_llseek,
-};
-
-static int afs_proc_cell_volumes_open(struct inode *inode, struct file *file);
-static void *afs_proc_cell_volumes_start(struct seq_file *p, loff_t *pos);
-static void *afs_proc_cell_volumes_next(struct seq_file *p, void *v,
-					loff_t *pos);
-static void afs_proc_cell_volumes_stop(struct seq_file *p, void *v);
-static int afs_proc_cell_volumes_show(struct seq_file *m, void *v);
-
-static const struct seq_operations afs_proc_cell_volumes_ops = {
-	.start	= afs_proc_cell_volumes_start,
-	.next	= afs_proc_cell_volumes_next,
-	.stop	= afs_proc_cell_volumes_stop,
-	.show	= afs_proc_cell_volumes_show,
-};
-
-static const struct file_operations afs_proc_cell_volumes_fops = {
-	.open		= afs_proc_cell_volumes_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
-static int afs_proc_cell_vlservers_open(struct inode *inode,
-					struct file *file);
-static void *afs_proc_cell_vlservers_start(struct seq_file *p, loff_t *pos);
-static void *afs_proc_cell_vlservers_next(struct seq_file *p, void *v,
-					  loff_t *pos);
-static void afs_proc_cell_vlservers_stop(struct seq_file *p, void *v);
-static int afs_proc_cell_vlservers_show(struct seq_file *m, void *v);
-
-static const struct seq_operations afs_proc_cell_vlservers_ops = {
-	.start	= afs_proc_cell_vlservers_start,
-	.next	= afs_proc_cell_vlservers_next,
-	.stop	= afs_proc_cell_vlservers_stop,
-	.show	= afs_proc_cell_vlservers_show,
-};
-
-static const struct file_operations afs_proc_cell_vlservers_fops = {
-	.open		= afs_proc_cell_vlservers_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
-static int afs_proc_servers_open(struct inode *inode, struct file *file);
-static void *afs_proc_servers_start(struct seq_file *p, loff_t *pos);
-static void *afs_proc_servers_next(struct seq_file *p, void *v,
-					loff_t *pos);
-static void afs_proc_servers_stop(struct seq_file *p, void *v);
-static int afs_proc_servers_show(struct seq_file *m, void *v);
-
-static const struct seq_operations afs_proc_servers_ops = {
-	.start	= afs_proc_servers_start,
-	.next	= afs_proc_servers_next,
-	.stop	= afs_proc_servers_stop,
-	.show	= afs_proc_servers_show,
-};
-
-static const struct file_operations afs_proc_servers_fops = {
-	.open		= afs_proc_servers_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
-static int afs_proc_sysname_open(struct inode *inode, struct file *file);
-static int afs_proc_sysname_release(struct inode *inode, struct file *file);
-static void *afs_proc_sysname_start(struct seq_file *p, loff_t *pos);
-static void *afs_proc_sysname_next(struct seq_file *p, void *v,
-					loff_t *pos);
-static void afs_proc_sysname_stop(struct seq_file *p, void *v);
-static int afs_proc_sysname_show(struct seq_file *m, void *v);
-static ssize_t afs_proc_sysname_write(struct file *file,
-				      const char __user *buf,
-				      size_t size, loff_t *_pos);
-
-static const struct seq_operations afs_proc_sysname_ops = {
-	.start	= afs_proc_sysname_start,
-	.next	= afs_proc_sysname_next,
-	.stop	= afs_proc_sysname_stop,
-	.show	= afs_proc_sysname_show,
-};
-
-static const struct file_operations afs_proc_sysname_fops = {
-	.open		= afs_proc_sysname_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= afs_proc_sysname_release,
-	.write		= afs_proc_sysname_write,
-};
-
-static const struct file_operations afs_proc_stats_fops;
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
-	    !proc_create("servers", 0644, net->proc_afs, &afs_proc_servers_fops) ||
-	    !proc_create("stats", 0644, net->proc_afs, &afs_proc_stats_fops) ||
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
- * open "/proc/fs/afs/cells" which provides a summary of extant cells
+ * Display the list of cells known to the namespace.
  */
-static int afs_proc_cells_open(struct inode *inode, struct file *file)
+static int afs_proc_cells_show(struct seq_file *m, void *v)
 {
-	struct seq_file *m;
-	int ret;
+	struct afs_cell *cell = list_entry(v, struct afs_cell, proc_link);
+	struct afs_net *net = afs_seq2net(m);
 
-	ret = seq_open(file, &afs_proc_cells_ops);
-	if (ret < 0)
-		return ret;
+	if (v == &net->proc_cells) {
+		/* display header on line 1 */
+		seq_puts(m, "USE NAME\n");
+		return 0;
+	}
 
-	m = file->private_data;
-	m->private = PDE_DATA(inode);
+	/* display one cell per line on subsequent lines */
+	seq_printf(m, "%3u %s\n", atomic_read(&cell->usage), cell->name);
 	return 0;
 }
 
-/*
- * set up the iterator to start reading from the cells list and return the
- * first item
- */
 static void *afs_proc_cells_start(struct seq_file *m, loff_t *_pos)
 	__acquires(rcu)
 {
-	struct afs_net *net = afs_seq2net(m);
-
 	rcu_read_lock();
-	return seq_list_start_head(&net->proc_cells, *_pos);
+	return seq_list_start_head(&afs_seq2net(m)->proc_cells, *_pos);
 }
 
-/*
- * move to next cell in cells list
- */
 static void *afs_proc_cells_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	struct afs_net *net = afs_seq2net(m);
-
-	return seq_list_next(v, &net->proc_cells, pos);
+	return seq_list_next(v, &afs_seq2net(m)->proc_cells, pos);
 }
 
-/*
- * clean up after reading from the cells list
- */
 static void afs_proc_cells_stop(struct seq_file *m, void *v)
 	__releases(rcu)
 {
 	rcu_read_unlock();
 }
 
-/*
- * display a header line followed by a load of cell lines
- */
-static int afs_proc_cells_show(struct seq_file *m, void *v)
-{
-	struct afs_cell *cell = list_entry(v, struct afs_cell, proc_link);
-	struct afs_net *net = afs_seq2net(m);
-
-	if (v == &net->proc_cells) {
-		/* display header on line 1 */
-		seq_puts(m, "USE NAME\n");
-		return 0;
-	}
-
-	/* display one cell per line on subsequent lines */
-	seq_printf(m, "%3u %s\n", atomic_read(&cell->usage), cell->name);
-	return 0;
-}
+static const struct seq_operations afs_proc_cells_ops = {
+	.start	= afs_proc_cells_start,
+	.next	= afs_proc_cells_next,
+	.stop	= afs_proc_cells_stop,
+	.show	= afs_proc_cells_show,
+};
 
 /*
  * handle writes to /proc/fs/afs/cells
@@ -334,6 +146,31 @@ static ssize_t afs_proc_cells_write(struct file *file, const char __user *buf,
 	goto done;
 }
 
+static int afs_proc_cells_open(struct inode *inode, struct file *file)
+{
+	struct seq_file *m;
+	int ret;
+
+	ret = seq_open(file, &afs_proc_cells_ops);
+	if (ret < 0)
+		return ret;
+
+	m = file->private_data;
+	m->private = PDE_DATA(inode);
+	return 0;
+}
+
+static const struct file_operations afs_proc_cells_fops = {
+	.open		= afs_proc_cells_open,
+	.read		= seq_read,
+	.write		= afs_proc_cells_write,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+/*
+ * Read the name of the current workstation cell.
+ */
 static ssize_t afs_proc_rootcell_read(struct file *file, char __user *buf,
 				      size_t size, loff_t *_pos)
 {
@@ -374,8 +211,10 @@ static ssize_t afs_proc_rootcell_read(struct file *file, char __user *buf,
 }
 
 /*
- * handle writes to /proc/fs/afs/rootcell
- * - to initialize rootcell: echo "cell.name:192.168.231.14"
+ * Set the current workstation cell and optionally supply its list of volume
+ * location servers.
+ *
+ *	echo "cell.name:192.168.231.14" >/proc/fs/afs/rootcell
  */
 static ssize_t afs_proc_rootcell_write(struct file *file,
 				       const char __user *buf,
@@ -417,100 +256,56 @@ static ssize_t afs_proc_rootcell_write(struct file *file,
 	return ret;
 }
 
+static const struct file_operations afs_proc_rootcell_fops = {
+	.read		= afs_proc_rootcell_read,
+	.write		= afs_proc_rootcell_write,
+	.llseek		= no_llseek,
+};
+
+static const char afs_vol_types[3][3] = {
+	[AFSVL_RWVOL]	= "RW",
+	[AFSVL_ROVOL]	= "RO",
+	[AFSVL_BACKVOL]	= "BK",
+};
+
 /*
- * initialise /proc/fs/afs/<cell>/
+ * Display the list of volumes known to a cell.
  */
-int afs_proc_cell_setup(struct afs_net *net, struct afs_cell *cell)
+static int afs_proc_cell_volumes_show(struct seq_file *m, void *v)
 {
-	struct proc_dir_entry *dir;
-
-	_enter("%p{%s},%p", cell, cell->name, net->proc_afs);
+	struct afs_cell *cell = m->private;
+	struct afs_volume *vol = list_entry(v, struct afs_volume, proc_link);
 
-	dir = proc_mkdir(cell->name, net->proc_afs);
-	if (!dir)
-		goto error_dir;
+	/* Display header on line 1 */
+	if (v == &cell->proc_volumes) {
+		seq_puts(m, "USE VID      TY\n");
+		return 0;
+	}
 
-	if (!proc_create_data("vlservers", 0, dir,
-			      &afs_proc_cell_vlservers_fops, cell) ||
-	    !proc_create_data("volumes", 0, dir,
-			      &afs_proc_cell_volumes_fops, cell))
-		goto error_tree;
+	seq_printf(m, "%3d %08x %s\n",
+		   atomic_read(&vol->usage), vol->vid,
+		   afs_vol_types[vol->type]);
 
-	_leave(" = 0");
 	return 0;
-
-error_tree:
-	remove_proc_subtree(cell->name, net->proc_afs);
-error_dir:
-	_leave(" = -ENOMEM");
-	return -ENOMEM;
 }
 
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
-/*
- * open "/proc/fs/afs/<cell>/volumes" which provides a summary of extant cells
- */
-static int afs_proc_cell_volumes_open(struct inode *inode, struct file *file)
-{
-	struct afs_cell *cell;
-	struct seq_file *m;
-	int ret;
-
-	cell = PDE_DATA(inode);
-	if (!cell)
-		return -ENOENT;
-
-	ret = seq_open(file, &afs_proc_cell_volumes_ops);
-	if (ret < 0)
-		return ret;
-
-	m = file->private_data;
-	m->private = cell;
-
-	return 0;
-}
-
-/*
- * set up the iterator to start reading from the cells list and return the
- * first item
- */
-static void *afs_proc_cell_volumes_start(struct seq_file *m, loff_t *_pos)
-	__acquires(cell->proc_lock)
+static void *afs_proc_cell_volumes_start(struct seq_file *m, loff_t *_pos)
+	__acquires(cell->proc_lock)
 {
 	struct afs_cell *cell = m->private;
 
-	_enter("cell=%p pos=%Ld", cell, *_pos);
-
 	read_lock(&cell->proc_lock);
 	return seq_list_start_head(&cell->proc_volumes, *_pos);
 }
 
-/*
- * move to next cell in cells list
- */
 static void *afs_proc_cell_volumes_next(struct seq_file *p, void *v,
 					loff_t *_pos)
 {
 	struct afs_cell *cell = p->private;
 
-	_enter("cell=%p pos=%Ld", cell, *_pos);
 	return seq_list_next(v, &cell->proc_volumes, _pos);
 }
 
-/*
- * clean up after reading from the cells list
- */
 static void afs_proc_cell_volumes_stop(struct seq_file *p, void *v)
 	__releases(cell->proc_lock)
 {
@@ -519,38 +314,14 @@ static void afs_proc_cell_volumes_stop(struct seq_file *p, void *v)
 	read_unlock(&cell->proc_lock);
 }
 
-static const char afs_vol_types[3][3] = {
-	[AFSVL_RWVOL]	= "RW",
-	[AFSVL_ROVOL]	= "RO",
-	[AFSVL_BACKVOL]	= "BK",
+static const struct seq_operations afs_proc_cell_volumes_ops = {
+	.start	= afs_proc_cell_volumes_start,
+	.next	= afs_proc_cell_volumes_next,
+	.stop	= afs_proc_cell_volumes_stop,
+	.show	= afs_proc_cell_volumes_show,
 };
 
-/*
- * display a header line followed by a load of volume lines
- */
-static int afs_proc_cell_volumes_show(struct seq_file *m, void *v)
-{
-	struct afs_cell *cell = m->private;
-	struct afs_volume *vol = list_entry(v, struct afs_volume, proc_link);
-
-	/* Display header on line 1 */
-	if (v == &cell->proc_volumes) {
-		seq_puts(m, "USE VID      TY\n");
-		return 0;
-	}
-
-	seq_printf(m, "%3d %08x %s\n",
-		   atomic_read(&vol->usage), vol->vid,
-		   afs_vol_types[vol->type]);
-
-	return 0;
-}
-
-/*
- * open "/proc/fs/afs/<cell>/vlservers" which provides a list of volume
- * location server
- */
-static int afs_proc_cell_vlservers_open(struct inode *inode, struct file *file)
+static int afs_proc_cell_volumes_open(struct inode *inode, struct file *file)
 {
 	struct afs_cell *cell;
 	struct seq_file *m;
@@ -560,8 +331,8 @@ static int afs_proc_cell_vlservers_open(struct inode *inode, struct file *file)
 	if (!cell)
 		return -ENOENT;
 
-	ret = seq_open(file, &afs_proc_cell_vlservers_ops);
-	if (ret<0)
+	ret = seq_open(file, &afs_proc_cell_volumes_ops);
+	if (ret < 0)
 		return ret;
 
 	m = file->private_data;
@@ -570,10 +341,31 @@ static int afs_proc_cell_vlservers_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static const struct file_operations afs_proc_cell_volumes_fops = {
+	.open		= afs_proc_cell_volumes_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
 /*
- * set up the iterator to start reading from the cells list and return the
- * first item
+ * Display the list of Volume Location servers we're using for a cell.
  */
+static int afs_proc_cell_vlservers_show(struct seq_file *m, void *v)
+{
+	struct sockaddr_rxrpc *addr = v;
+
+	/* display header on line 1 */
+	if (v == (void *)1) {
+		seq_puts(m, "ADDRESS\n");
+		return 0;
+	}
+
+	/* display one cell per line on subsequent lines */
+	seq_printf(m, "%pISp\n", &addr->transport);
+	return 0;
+}
+
 static void *afs_proc_cell_vlservers_start(struct seq_file *m, loff_t *_pos)
 	__acquires(rcu)
 {
@@ -596,9 +388,6 @@ static void *afs_proc_cell_vlservers_start(struct seq_file *m, loff_t *_pos)
 	return alist->addrs + pos;
 }
 
-/*
- * move to next cell in cells list
- */
 static void *afs_proc_cell_vlservers_next(struct seq_file *p, void *v,
 					  loff_t *_pos)
 {
@@ -616,140 +405,161 @@ static void *afs_proc_cell_vlservers_next(struct seq_file *p, void *v,
 	return alist->addrs + pos;
 }
 
-/*
- * clean up after reading from the cells list
- */
 static void afs_proc_cell_vlservers_stop(struct seq_file *p, void *v)
 	__releases(rcu)
 {
 	rcu_read_unlock();
 }
 
-/*
- * display a header line followed by a load of volume lines
- */
-static int afs_proc_cell_vlservers_show(struct seq_file *m, void *v)
+static const struct seq_operations afs_proc_cell_vlservers_ops = {
+	.start	= afs_proc_cell_vlservers_start,
+	.next	= afs_proc_cell_vlservers_next,
+	.stop	= afs_proc_cell_vlservers_stop,
+	.show	= afs_proc_cell_vlservers_show,
+};
+
+static int afs_proc_cell_vlservers_open(struct inode *inode, struct file *file)
 {
-	struct sockaddr_rxrpc *addr = v;
+	struct afs_cell *cell;
+	struct seq_file *m;
+	int ret;
 
-	/* display header on line 1 */
-	if (v == (void *)1) {
-		seq_puts(m, "ADDRESS\n");
-		return 0;
-	}
+	cell = PDE_DATA(inode);
+	if (!cell)
+		return -ENOENT;
+
+	ret = seq_open(file, &afs_proc_cell_vlservers_ops);
+	if (ret<0)
+		return ret;
+
+	m = file->private_data;
+	m->private = cell;
 
-	/* display one cell per line on subsequent lines */
-	seq_printf(m, "%pISp\n", &addr->transport);
 	return 0;
 }
 
+static const struct file_operations afs_proc_cell_vlservers_fops = {
+	.open		= afs_proc_cell_vlservers_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
 /*
- * open "/proc/fs/afs/servers" which provides a summary of active
- * servers
+ * Display the list of fileservers we're using within a namespace.
  */
-static int afs_proc_servers_open(struct inode *inode, struct file *file)
+static int afs_proc_servers_show(struct seq_file *m, void *v)
 {
-	return seq_open(file, &afs_proc_servers_ops);
+	struct afs_server *server;
+	struct afs_addr_list *alist;
+
+	if (v == SEQ_START_TOKEN) {
+		seq_puts(m, "UUID                                 USE ADDR\n");
+		return 0;
+	}
+
+	server = list_entry(v, struct afs_server, proc_link);
+	alist = rcu_dereference(server->addresses);
+	seq_printf(m, "%pU %3d %pISp\n",
+		   &server->uuid,
+		   atomic_read(&server->usage),
+		   &alist->addrs[alist->index].transport);
+	return 0;
 }
 
-/*
- * Set up the iterator to start reading from the server list and return the
- * first item.
- */
 static void *afs_proc_servers_start(struct seq_file *m, loff_t *_pos)
 	__acquires(rcu)
 {
-	struct afs_net *net = afs_seq2net(m);
-
 	rcu_read_lock();
-	return seq_hlist_start_head_rcu(&net->fs_proc, *_pos);
+	return seq_hlist_start_head_rcu(&afs_seq2net(m)->fs_proc, *_pos);
 }
 
-/*
- * move to next cell in cells list
- */
 static void *afs_proc_servers_next(struct seq_file *m, void *v, loff_t *_pos)
 {
-	struct afs_net *net = afs_seq2net(m);
-
-	return seq_hlist_next_rcu(v, &net->fs_proc, _pos);
+	return seq_hlist_next_rcu(v, &afs_seq2net(m)->fs_proc, _pos);
 }
 
-/*
- * clean up after reading from the cells list
- */
 static void afs_proc_servers_stop(struct seq_file *p, void *v)
 	__releases(rcu)
 {
 	rcu_read_unlock();
 }
 
+static const struct seq_operations afs_proc_servers_ops = {
+	.start	= afs_proc_servers_start,
+	.next	= afs_proc_servers_next,
+	.stop	= afs_proc_servers_stop,
+	.show	= afs_proc_servers_show,
+};
+
+static int afs_proc_servers_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &afs_proc_servers_ops);
+}
+
+static const struct file_operations afs_proc_servers_fops = {
+	.open		= afs_proc_servers_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
 /*
- * display a header line followed by a load of volume lines
+ * Display the list of strings that may be substituted for the @sys pathname
+ * macro.
  */
-static int afs_proc_servers_show(struct seq_file *m, void *v)
+static int afs_proc_sysname_show(struct seq_file *m, void *v)
 {
-	struct afs_server *server;
-	struct afs_addr_list *alist;
-
-	if (v == SEQ_START_TOKEN) {
-		seq_puts(m, "UUID                                 USE ADDR\n");
-		return 0;
-	}
+	struct afs_net *net = afs_seq2net(m);
+	struct afs_sysnames *sysnames = net->sysnames;
+	unsigned int i = (unsigned long)v - 1;
 
-	server = list_entry(v, struct afs_server, proc_link);
-	alist = rcu_dereference(server->addresses);
-	seq_printf(m, "%pU %3d %pISp\n",
-		   &server->uuid,
-		   atomic_read(&server->usage),
-		   &alist->addrs[alist->index].transport);
+	if (i < sysnames->nr)
+		seq_printf(m, "%s\n", sysnames->subs[i]);
 	return 0;
 }
 
-void afs_put_sysnames(struct afs_sysnames *sysnames)
+static void *afs_proc_sysname_start(struct seq_file *m, loff_t *pos)
+	__acquires(&net->sysnames_lock)
 {
-	int i;
+	struct afs_net *net = afs_seq2net(m);
+	struct afs_sysnames *names = net->sysnames;
 
-	if (sysnames && refcount_dec_and_test(&sysnames->usage)) {
-		for (i = 0; i < sysnames->nr; i++)
-			if (sysnames->subs[i] != afs_init_sysname &&
-			    sysnames->subs[i] != sysnames->blank)
-				kfree(sysnames->subs[i]);
-	}
+	read_lock(&net->sysnames_lock);
+
+	if (*pos >= names->nr)
+		return NULL;
+	return (void *)(unsigned long)(*pos + 1);
 }
 
-/*
- * Handle opening of /proc/fs/afs/sysname.  If it is opened for writing, we
- * assume the caller wants to change the substitution list and we allocate a
- * buffer to hold the list.
- */
-static int afs_proc_sysname_open(struct inode *inode, struct file *file)
+static void *afs_proc_sysname_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	struct afs_sysnames *sysnames;
-	struct seq_file *m;
-	int ret;
-
-	ret = seq_open(file, &afs_proc_sysname_ops);
-	if (ret < 0)
-		return ret;
+	struct afs_net *net = afs_seq2net(m);
+	struct afs_sysnames *names = net->sysnames;
 
-	if (file->f_mode & FMODE_WRITE) {
-		sysnames = kzalloc(sizeof(*sysnames), GFP_KERNEL);
-		if (!sysnames) {
-			seq_release(inode, file);
-			return -ENOMEM;
-		}
+	*pos += 1;
+	if (*pos >= names->nr)
+		return NULL;
+	return (void *)(unsigned long)(*pos + 1);
+}
 
-		refcount_set(&sysnames->usage, 1);
-		m = file->private_data;
-		m->private = sysnames;
-	}
+static void afs_proc_sysname_stop(struct seq_file *m, void *v)
+	__releases(&net->sysnames_lock)
+{
+	struct afs_net *net = afs_seq2net(m);
 
-	return 0;
+	read_unlock(&net->sysnames_lock);
 }
 
+static const struct seq_operations afs_proc_sysname_ops = {
+	.start	= afs_proc_sysname_start,
+	.next	= afs_proc_sysname_next,
+	.stop	= afs_proc_sysname_stop,
+	.show	= afs_proc_sysname_show,
+};
+
 /*
- * Handle writes to /proc/fs/afs/sysname to set the @sys substitution.
+ * Allow the @sys substitution to be configured.
  */
 static ssize_t afs_proc_sysname_write(struct file *file,
 				      const char __user *buf,
@@ -833,6 +643,18 @@ static ssize_t afs_proc_sysname_write(struct file *file,
 	goto out;
 }
 
+void afs_put_sysnames(struct afs_sysnames *sysnames)
+{
+	int i;
+
+	if (sysnames && refcount_dec_and_test(&sysnames->usage)) {
+		for (i = 0; i < sysnames->nr; i++)
+			if (sysnames->subs[i] != afs_init_sysname &&
+			    sysnames->subs[i] != sysnames->blank)
+				kfree(sysnames->subs[i]);
+	}
+}
+
 static int afs_proc_sysname_release(struct inode *inode, struct file *file)
 {
 	struct afs_sysnames *sysnames, *kill = NULL;
@@ -858,51 +680,46 @@ static int afs_proc_sysname_release(struct inode *inode, struct file *file)
 	return seq_release(inode, file);
 }
 
-static void *afs_proc_sysname_start(struct seq_file *m, loff_t *pos)
-	__acquires(&net->sysnames_lock)
-{
-	struct afs_net *net = afs_seq2net(m);
-	struct afs_sysnames *names = net->sysnames;
-
-	read_lock(&net->sysnames_lock);
-
-	if (*pos >= names->nr)
-		return NULL;
-	return (void *)(unsigned long)(*pos + 1);
-}
-
-static void *afs_proc_sysname_next(struct seq_file *m, void *v, loff_t *pos)
+/*
+ * Handle opening of /proc/fs/afs/sysname.  If it is opened for writing, we
+ * assume the caller wants to change the substitution list and we allocate a
+ * buffer to hold the list.
+ */
+static int afs_proc_sysname_open(struct inode *inode, struct file *file)
 {
-	struct afs_net *net = afs_seq2net(m);
-	struct afs_sysnames *names = net->sysnames;
-
-	*pos += 1;
-	if (*pos >= names->nr)
-		return NULL;
-	return (void *)(unsigned long)(*pos + 1);
-}
+	struct afs_sysnames *sysnames;
+	struct seq_file *m;
+	int ret;
 
-static void afs_proc_sysname_stop(struct seq_file *m, void *v)
-	__releases(&net->sysnames_lock)
-{
-	struct afs_net *net = afs_seq2net(m);
+	ret = seq_open(file, &afs_proc_sysname_ops);
+	if (ret < 0)
+		return ret;
 
-	read_unlock(&net->sysnames_lock);
-}
+	if (file->f_mode & FMODE_WRITE) {
+		sysnames = kzalloc(sizeof(*sysnames), GFP_KERNEL);
+		if (!sysnames) {
+			seq_release(inode, file);
+			return -ENOMEM;
+		}
 
-static int afs_proc_sysname_show(struct seq_file *m, void *v)
-{
-	struct afs_net *net = afs_seq2net(m);
-	struct afs_sysnames *sysnames = net->sysnames;
-	unsigned int i = (unsigned long)v - 1;
+		refcount_set(&sysnames->usage, 1);
+		m = file->private_data;
+		m->private = sysnames;
+	}
 
-	if (i < sysnames->nr)
-		seq_printf(m, "%s\n", sysnames->subs[i]);
 	return 0;
 }
 
+static const struct file_operations afs_proc_sysname_fops = {
+	.open		= afs_proc_sysname_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= afs_proc_sysname_release,
+	.write		= afs_proc_sysname_write,
+};
+
 /*
- * Display general per-net namespace statistics
+ * Display general per-net namespace statistics.
  */
 static int afs_proc_stats_show(struct seq_file *m, void *v)
 {
@@ -946,3 +763,81 @@ static const struct file_operations afs_proc_stats_fops = {
 	.llseek		= seq_lseek,
 	.release        = single_release,
 };
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
+	if (!proc_create_data("vlservers", 0, dir,
+			      &afs_proc_cell_vlservers_fops, cell) ||
+	    !proc_create_data("volumes", 0, dir,
+			      &afs_proc_cell_volumes_fops, cell))
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
+	    !proc_create("servers", 0644, net->proc_afs, &afs_proc_servers_fops) ||
+	    !proc_create("stats", 0644, net->proc_afs, &afs_proc_stats_fops) ||
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
