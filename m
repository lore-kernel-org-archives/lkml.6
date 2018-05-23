Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932069AbeEWMUC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 08:20:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932534AbeEWMRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 08:17:02 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 3/8] afs: Rearrange fs/afs/proc.c to move the show routines
 up
From: David Howells <dhowells@redhat.com>
To: viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Wed, 23 May 2018 13:17:00 +0100
Message-ID: <152707782047.27887.15439187207028313024.stgit@warthog.procyon.org.uk>
In-Reply-To: <152707780120.27887.10118775145086304138.stgit@warthog.procyon.org.uk>
References: <152707780120.27887.10118775145086304138.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rearrange fs/afs/proc.c to move the show routines up to the top of each
block so the order is show, iteration, ops, file ops, fops.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/proc.c |  150 +++++++++++++++++++++++++++++----------------------------
 1 file changed, 75 insertions(+), 75 deletions(-)

diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 22ce99df3208..b20098b7b7ee 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -91,6 +91,25 @@ static const struct seq_operations afs_proc_sysname_ops = {
 	.show	= afs_proc_sysname_show,
 };
 
+/*
+ * display a header line followed by a load of cell lines
+ */
+static int afs_proc_cells_show(struct seq_file *m, void *v)
+{
+	struct afs_cell *cell = list_entry(v, struct afs_cell, proc_link);
+	struct afs_net *net = afs_seq2net(m);
+
+	if (v == &net->proc_cells) {
+		/* display header on line 1 */
+		seq_puts(m, "USE NAME\n");
+		return 0;
+	}
+
+	/* display one cell per line on subsequent lines */
+	seq_printf(m, "%3u %s\n", atomic_read(&cell->usage), cell->name);
+	return 0;
+}
+
 /*
  * set up the iterator to start reading from the cells list and return the
  * first item
@@ -123,25 +142,6 @@ static void afs_proc_cells_stop(struct seq_file *m, void *v)
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
-
 /*
  * handle writes to /proc/fs/afs/cells
  * - to add cells: echo "add <cellname> <IP>[:<IP>][:<IP>]"
@@ -319,6 +319,33 @@ static const struct file_operations afs_proc_rootcell_fops = {
 	.llseek		= no_llseek,
 };
 
+static const char afs_vol_types[3][3] = {
+	[AFSVL_RWVOL]	= "RW",
+	[AFSVL_ROVOL]	= "RO",
+	[AFSVL_BACKVOL]	= "BK",
+};
+
+/*
+ * display a header line followed by a load of volume lines
+ */
+static int afs_proc_cell_volumes_show(struct seq_file *m, void *v)
+{
+	struct afs_cell *cell = PDE_DATA(file_inode(m->file));
+	struct afs_volume *vol = list_entry(v, struct afs_volume, proc_link);
+
+	/* Display header on line 1 */
+	if (v == &cell->proc_volumes) {
+		seq_puts(m, "USE VID      TY\n");
+		return 0;
+	}
+
+	seq_printf(m, "%3d %08x %s\n",
+		   atomic_read(&vol->usage), vol->vid,
+		   afs_vol_types[vol->type]);
+
+	return 0;
+}
+
 /*
  * set up the iterator to start reading from the cells list and return the
  * first item
@@ -357,30 +384,21 @@ static void afs_proc_cell_volumes_stop(struct seq_file *p, void *v)
 	read_unlock(&cell->proc_lock);
 }
 
-static const char afs_vol_types[3][3] = {
-	[AFSVL_RWVOL]	= "RW",
-	[AFSVL_ROVOL]	= "RO",
-	[AFSVL_BACKVOL]	= "BK",
-};
-
 /*
  * display a header line followed by a load of volume lines
  */
-static int afs_proc_cell_volumes_show(struct seq_file *m, void *v)
+static int afs_proc_cell_vlservers_show(struct seq_file *m, void *v)
 {
-	struct afs_cell *cell = PDE_DATA(file_inode(m->file));
-	struct afs_volume *vol = list_entry(v, struct afs_volume, proc_link);
+	struct sockaddr_rxrpc *addr = v;
 
-	/* Display header on line 1 */
-	if (v == &cell->proc_volumes) {
-		seq_puts(m, "USE VID      TY\n");
+	/* display header on line 1 */
+	if (v == (void *)1) {
+		seq_puts(m, "ADDRESS\n");
 		return 0;
 	}
 
-	seq_printf(m, "%3d %08x %s\n",
-		   atomic_read(&vol->usage), vol->vid,
-		   afs_vol_types[vol->type]);
-
+	/* display one cell per line on subsequent lines */
+	seq_printf(m, "%pISp\n", &addr->transport);
 	return 0;
 }
 
@@ -442,18 +460,22 @@ static void afs_proc_cell_vlservers_stop(struct seq_file *p, void *v)
 /*
  * display a header line followed by a load of volume lines
  */
-static int afs_proc_cell_vlservers_show(struct seq_file *m, void *v)
+static int afs_proc_servers_show(struct seq_file *m, void *v)
 {
-	struct sockaddr_rxrpc *addr = v;
+	struct afs_server *server;
+	struct afs_addr_list *alist;
 
-	/* display header on line 1 */
-	if (v == (void *)1) {
-		seq_puts(m, "ADDRESS\n");
+	if (v == SEQ_START_TOKEN) {
+		seq_puts(m, "UUID                                 USE ADDR\n");
 		return 0;
 	}
 
-	/* display one cell per line on subsequent lines */
-	seq_printf(m, "%pISp\n", &addr->transport);
+	server = list_entry(v, struct afs_server, proc_link);
+	alist = rcu_dereference(server->addresses);
+	seq_printf(m, "%pU %3d %pISp\n",
+		   &server->uuid,
+		   atomic_read(&server->usage),
+		   &alist->addrs[alist->index].transport);
 	return 0;
 }
 
@@ -489,28 +511,6 @@ static void afs_proc_servers_stop(struct seq_file *p, void *v)
 	rcu_read_unlock();
 }
 
-/*
- * display a header line followed by a load of volume lines
- */
-static int afs_proc_servers_show(struct seq_file *m, void *v)
-{
-	struct afs_server *server;
-	struct afs_addr_list *alist;
-
-	if (v == SEQ_START_TOKEN) {
-		seq_puts(m, "UUID                                 USE ADDR\n");
-		return 0;
-	}
-
-	server = list_entry(v, struct afs_server, proc_link);
-	alist = rcu_dereference(server->addresses);
-	seq_printf(m, "%pU %3d %pISp\n",
-		   &server->uuid,
-		   atomic_read(&server->usage),
-		   &alist->addrs[alist->index].transport);
-	return 0;
-}
-
 void afs_put_sysnames(struct afs_sysnames *sysnames)
 {
 	int i;
@@ -663,6 +663,17 @@ static int afs_proc_sysname_release(struct inode *inode, struct file *file)
 	return seq_release(inode, file);
 }
 
+static int afs_proc_sysname_show(struct seq_file *m, void *v)
+{
+	struct afs_net *net = afs_seq2net(m);
+	struct afs_sysnames *sysnames = net->sysnames;
+	unsigned int i = (unsigned long)v - 1;
+
+	if (i < sysnames->nr)
+		seq_printf(m, "%s\n", sysnames->subs[i]);
+	return 0;
+}
+
 static void *afs_proc_sysname_start(struct seq_file *m, loff_t *pos)
 	__acquires(&net->sysnames_lock)
 {
@@ -695,17 +706,6 @@ static void afs_proc_sysname_stop(struct seq_file *m, void *v)
 	read_unlock(&net->sysnames_lock);
 }
 
-static int afs_proc_sysname_show(struct seq_file *m, void *v)
-{
-	struct afs_net *net = afs_seq2net(m);
-	struct afs_sysnames *sysnames = net->sysnames;
-	unsigned int i = (unsigned long)v - 1;
-
-	if (i < sysnames->nr)
-		seq_printf(m, "%s\n", sysnames->subs[i]);
-	return 0;
-}
-
 static const struct file_operations afs_proc_sysname_fops = {
 	.open		= afs_proc_sysname_open,
 	.read		= seq_read,
