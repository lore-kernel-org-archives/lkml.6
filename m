Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752235AbeDEUa2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 16:30:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751251AbeDEUaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 16:30:25 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 08/20] afs: Introduce a statistics proc file
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Apr 2018 21:30:23 +0100
Message-ID: <152296022372.31027.10126448646609944884.stgit@warthog.procyon.org.uk>
In-Reply-To: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
References: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a proc file that displays a bunch of statistics for the AFS
filesystem in the current network namespace.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/dir.c      |    3 +++
 fs/afs/inode.c    |    3 +++
 fs/afs/internal.h |   15 ++++++++++++++-
 fs/afs/proc.c     |   37 +++++++++++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 4f5e5c15ed6f..0e4945948a41 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -206,6 +206,7 @@ bool afs_dir_check_page(struct inode *dir, struct page *page)
 	}
 
 checked:
+	afs_stat_v(vnode, n_read_dir);
 	SetPageChecked(page);
 	return true;
 
@@ -881,6 +882,7 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 	    dentry->d_name.name[dentry->d_name.len - 1] == 's')
 		return afs_lookup_atsys(dir, dentry, key);
 
+	afs_stat_v(dvnode, n_lookup);
 	inode = afs_do_lookup(dir, dentry, key);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
@@ -1082,6 +1084,7 @@ static int afs_d_revalidate(struct dentry *dentry, unsigned int flags)
 		goto out_valid; /* the dir contents are unchanged */
 
 	_debug("dir modified");
+	afs_stat_v(dir, n_reval);
 
 	/* search the directory for this vnode */
 	ret = afs_do_lookup_one(&dir->vfs_inode, dentry, &fid, key);
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index d5db9dead18c..f4e62964efcb 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -366,6 +366,9 @@ void afs_zap_data(struct afs_vnode *vnode)
 {
 	_enter("{%x:%u}", vnode->fid.vid, vnode->fid.vnode);
 
+	if (S_ISDIR(vnode->vfs_inode.i_mode))
+		afs_stat_v(vnode, n_inval);
+
 #ifdef CONFIG_AFS_FSCACHE
 	fscache_invalidate(vnode->cache);
 #endif
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index c584d6e4c2f5..ebec83017f9a 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -255,9 +255,15 @@ struct afs_net {
 	struct mutex		lock_manager_mutex;
 
 	/* Misc */
-	struct proc_dir_entry	*proc_afs;		/* /proc/net/afs directory */
+	struct proc_dir_entry	*proc_afs;	/* /proc/net/afs directory */
 	struct afs_sysnames	*sysnames;
 	rwlock_t		sysnames_lock;
+
+	/* Statistics counters */
+	atomic_t		n_lookup;	/* Number of lookups done */
+	atomic_t		n_reval;	/* Number of dentries needing revalidation */
+	atomic_t		n_inval;	/* Number of invalidations by the server */
+	atomic_t		n_read_dir;	/* Number of directory pages read */
 };
 
 extern const char afs_init_sysname[];
@@ -775,6 +781,13 @@ static inline void afs_put_net(struct afs_net *net)
 {
 }
 
+static inline void __afs_stat(atomic_t *s)
+{
+	atomic_inc(s);
+}
+
+#define afs_stat_v(vnode, n) __afs_stat(&afs_v2net(vnode)->n)
+
 /*
  * misc.c
  */
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index f28719c8d153..e1e13a568845 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -152,6 +152,8 @@ static const struct file_operations afs_proc_sysname_fops = {
 	.write		= afs_proc_sysname_write,
 };
 
+static const struct file_operations afs_proc_stats_fops;
+
 /*
  * initialise the /proc/fs/afs/ directory
  */
@@ -166,6 +168,7 @@ int afs_proc_init(struct afs_net *net)
 	if (!proc_create("cells", 0644, net->proc_afs, &afs_proc_cells_fops) ||
 	    !proc_create("rootcell", 0644, net->proc_afs, &afs_proc_rootcell_fops) ||
 	    !proc_create("servers", 0644, net->proc_afs, &afs_proc_servers_fops) ||
+	    !proc_create("stats", 0644, net->proc_afs, &afs_proc_stats_fops) ||
 	    !proc_create("sysname", 0644, net->proc_afs, &afs_proc_sysname_fops))
 		goto error_tree;
 
@@ -877,3 +880,37 @@ static int afs_proc_sysname_show(struct seq_file *m, void *v)
 		seq_printf(m, "%s\n", sysnames->subs[i]);
 	return 0;
 }
+
+/*
+ * Display general per-net namespace statistics
+ */
+static int afs_proc_stats_show(struct seq_file *m, void *v)
+{
+	struct afs_net *net = afs_seq2net(m);
+
+	seq_puts(m, "kAFS statistics\n");
+
+	seq_printf(m, "dir-mgmt: look=%u reval=%u inval=%u\n",
+		   atomic_read(&net->n_lookup),
+		   atomic_read(&net->n_reval),
+		   atomic_read(&net->n_inval));
+
+	seq_printf(m, "dir-data: rdpg=%u\n",
+		   atomic_read(&net->n_read_dir));
+	return 0;
+}
+
+/*
+ * Open "/proc/fs/afs/stats" to allow reading of the stat counters.
+ */
+static int afs_proc_stats_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, afs_proc_stats_show, NULL);
+}
+
+static const struct file_operations afs_proc_stats_fops = {
+	.open		= afs_proc_stats_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release        = single_release,
+};
