Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932636AbeEWMRD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 08:17:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54502 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932087AbeEWMQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 08:16:55 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/8] afs: Rearrange fs/afs/proc.c by moving fops and open
 functions down
From: David Howells <dhowells@redhat.com>
To: viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Wed, 23 May 2018 13:16:54 +0100
Message-ID: <152707781409.27887.10331627111201756585.stgit@warthog.procyon.org.uk>
In-Reply-To: <152707780120.27887.10118775145086304138.stgit@warthog.procyon.org.uk>
References: <152707780120.27887.10118775145086304138.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rearrange fs/afs/proc.c by moving fops and open functions down so as to
remove predeclarations.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/proc.c |   71 ++++++++++++++++++++++-----------------------------------
 1 file changed, 27 insertions(+), 44 deletions(-)

diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 4bb612b04f3c..22ce99df3208 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -27,13 +27,10 @@ static inline struct afs_net *afs_seq2net(struct seq_file *m)
 	return &__afs_net; // TODO: use seq_file_net(m)
 }
 
-static int afs_proc_cells_open(struct inode *inode, struct file *file);
 static void *afs_proc_cells_start(struct seq_file *p, loff_t *pos);
 static void *afs_proc_cells_next(struct seq_file *p, void *v, loff_t *pos);
 static void afs_proc_cells_stop(struct seq_file *p, void *v);
 static int afs_proc_cells_show(struct seq_file *m, void *v);
-static ssize_t afs_proc_cells_write(struct file *file, const char __user *buf,
-				    size_t size, loff_t *_pos);
 
 static const struct seq_operations afs_proc_cells_ops = {
 	.start	= afs_proc_cells_start,
@@ -42,26 +39,6 @@ static const struct seq_operations afs_proc_cells_ops = {
 	.show	= afs_proc_cells_show,
 };
 
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
 static void *afs_proc_cell_volumes_start(struct seq_file *p, loff_t *pos);
 static void *afs_proc_cell_volumes_next(struct seq_file *p, void *v,
 					loff_t *pos);
@@ -101,16 +78,11 @@ static const struct seq_operations afs_proc_servers_ops = {
 	.show	= afs_proc_servers_show,
 };
 
-static int afs_proc_sysname_open(struct inode *inode, struct file *file);
-static int afs_proc_sysname_release(struct inode *inode, struct file *file);
 static void *afs_proc_sysname_start(struct seq_file *p, loff_t *pos);
 static void *afs_proc_sysname_next(struct seq_file *p, void *v,
 					loff_t *pos);
 static void afs_proc_sysname_stop(struct seq_file *p, void *v);
 static int afs_proc_sysname_show(struct seq_file *m, void *v);
-static ssize_t afs_proc_sysname_write(struct file *file,
-				      const char __user *buf,
-				      size_t size, loff_t *_pos);
 
 static const struct seq_operations afs_proc_sysname_ops = {
 	.start	= afs_proc_sysname_start,
@@ -119,22 +91,6 @@ static const struct seq_operations afs_proc_sysname_ops = {
 	.show	= afs_proc_sysname_show,
 };
 
-static const struct file_operations afs_proc_sysname_fops = {
-	.open		= afs_proc_sysname_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= afs_proc_sysname_release,
-	.write		= afs_proc_sysname_write,
-};
-
-/*
- * open "/proc/fs/afs/cells" which provides a summary of extant cells
- */
-static int afs_proc_cells_open(struct inode *inode, struct file *file)
-{
-	return seq_open(file, &afs_proc_cells_ops);
-}
-
 /*
  * set up the iterator to start reading from the cells list and return the
  * first item
@@ -261,6 +217,19 @@ static ssize_t afs_proc_cells_write(struct file *file, const char __user *buf,
 	goto done;
 }
 
+static int afs_proc_cells_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &afs_proc_cells_ops);
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
 static ssize_t afs_proc_rootcell_read(struct file *file, char __user *buf,
 				      size_t size, loff_t *_pos)
 {
@@ -344,6 +313,12 @@ static ssize_t afs_proc_rootcell_write(struct file *file,
 	return ret;
 }
 
+static const struct file_operations afs_proc_rootcell_fops = {
+	.read		= afs_proc_rootcell_read,
+	.write		= afs_proc_rootcell_write,
+	.llseek		= no_llseek,
+};
+
 /*
  * set up the iterator to start reading from the cells list and return the
  * first item
@@ -731,6 +706,14 @@ static int afs_proc_sysname_show(struct seq_file *m, void *v)
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
  * Display general per-net namespace statistics
  */
