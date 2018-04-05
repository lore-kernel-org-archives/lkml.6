Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751933AbeDEUaJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 16:30:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40926 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751772AbeDEUaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 16:30:06 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 05/20] afs: Implement @sys substitution handling
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Apr 2018 21:30:04 +0100
Message-ID: <152296020457.31027.11109314533967989357.stgit@warthog.procyon.org.uk>
In-Reply-To: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
References: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the AFS feature by which @sys at the end of a pathname component
may be substituted for one of a list of values, typically naming the
operating system.  Up to 16 alternatives may be specified and these are
tried in turn until one works.  Each network namespace has[*] a separate
independent list.

Upon creation of a new network namespace, the list of values is
initialised[*] to a single OpenAFS-compatible string representing arch type
plus "_linux26".  For example, on x86_64, the sysname is "amd64_linux26".

[*] Or will, once network namespace support is finalised in kAFS.

The list may be set by:

	# for i in foo bar linux-x86_64; do echo $i; done >/proc/fs/afs/sysname

for which separate writes to the same fd are amalgamated and applied on
close.  The LF character may be used as a separator to specify multiple
items in the same write() call.

The list may be cleared by:

	# echo >/proc/fs/afs/sysname

and read by:

	# cat /proc/fs/afs/sysname
	foo
	bar
	linux-x86_64

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/filesystems/afs.txt |   28 +++++
 fs/afs/dir.c                      |   78 ++++++++++++++
 fs/afs/internal.h                 |   13 ++
 fs/afs/main.c                     |   42 +++++++
 fs/afs/proc.c                     |  211 +++++++++++++++++++++++++++++++++++++
 5 files changed, 369 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/afs.txt b/Documentation/filesystems/afs.txt
index c5254f6d234d..8c6ea7b41048 100644
--- a/Documentation/filesystems/afs.txt
+++ b/Documentation/filesystems/afs.txt
@@ -11,7 +11,7 @@ Contents:
  - Proc filesystem.
  - The cell database.
  - Security.
- - Examples.
+ - The @sys substitution.
 
 
 ========
@@ -230,3 +230,29 @@ If a file is opened with a particular key and then the file descriptor is
 passed to a process that doesn't have that key (perhaps over an AF_UNIX
 socket), then the operations on the file will be made with key that was used to
 open the file.
+
+
+=====================
+THE @SYS SUBSTITUTION
+=====================
+
+The list of up to 16 @sys substitutions for the current network namespace can
+be configured by writing a list to /proc/fs/afs/sysname:
+
+	[root@andromeda ~]# echo foo amd64_linux_26 >/proc/fs/afs/sysname
+
+or cleared entirely by writing an empty list:
+
+	[root@andromeda ~]# echo >/proc/fs/afs/sysname
+
+The current list for current network namespace can be retrieved by:
+
+	[root@andromeda ~]# cat /proc/fs/afs/sysname
+	foo
+	amd64_linux_26
+
+When @sys is being substituted for, each element of the list is tried in the
+order given.
+
+By default, the list will contain one item that conforms to the pattern
+"<arch>_linux_26", amd64 being the name for x86_64.
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 63f7b37e1e71..9bac606725ee 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -589,7 +589,7 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry,
 	inode = ilookup5(dir->i_sb, cookie->fids[0].vnode, afs_iget5_test, &data);
 	if (inode)
 		goto out;
-	
+
 	/* Need space for examining all the selected files */
 	inode = ERR_PTR(-ENOMEM);
 	cookie->statuses = kcalloc(cookie->nr_fids, sizeof(struct afs_file_status),
@@ -766,6 +766,75 @@ static struct inode *afs_try_auto_mntpt(struct dentry *dentry, struct inode *dir
 	return ERR_PTR(ret);
 }
 
+/*
+ * Look up an entry in a directory with @sys substitution.
+ */
+static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry,
+				       struct key *key)
+{
+	struct afs_sysnames *subs;
+	struct afs_net *net = afs_i2net(dir);
+	struct dentry *parent, *ret;
+	char *buf, *p, *name;
+	int len, i;
+
+	_enter("");
+
+	parent = dget_parent(dentry);
+
+	ret = ERR_PTR(-ENOMEM);
+	p = buf = kmalloc(AFSNAMEMAX, GFP_KERNEL);
+	if (!buf)
+		goto out_p;
+	if (dentry->d_name.len > 4) {
+		memcpy(p, dentry->d_name.name, dentry->d_name.len - 4);
+		p += dentry->d_name.len - 4;
+	}
+
+	/* There is an ordered list of substitutes that we have to try */
+	for (i = 0; i < AFS_NR_SYSNAME; i++) {
+		read_lock(&net->sysnames_lock);
+		subs = net->sysnames;
+		if (!subs || i >= subs->nr) {
+			read_unlock(&net->sysnames_lock);
+			goto noent;
+		}
+
+		name = subs->subs[i];
+		if (!name) {
+			read_unlock(&net->sysnames_lock);
+			goto noent;
+		}
+
+		len = dentry->d_name.len - 4 + strlen(name);
+		if (len >= AFSNAMEMAX) {
+			read_unlock(&net->sysnames_lock);
+			ret = ERR_PTR(-ENAMETOOLONG);
+			goto out_b;
+		}
+
+		strcpy(p, name);
+		read_unlock(&net->sysnames_lock);
+
+		ret = lookup_one_len(buf, parent, len);
+		if (IS_ERR(ret) || d_is_positive(ret))
+			goto out_b;
+		dput(ret);
+	}
+
+noent:
+	/* We don't want to d_add() the @sys dentry here as we don't want to
+	 * the cached dentry to hide changes to the sysnames list.
+	 */
+	ret = NULL;
+out_b:
+	kfree(buf);
+out_p:
+	dput(parent);
+	key_put(key);
+	return ret;
+}
+
 /*
  * look up an entry in a directory
  */
@@ -805,6 +874,13 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 		return ERR_PTR(ret);
 	}
 
+	if (dentry->d_name.len >= 4 &&
+	    dentry->d_name.name[dentry->d_name.len - 4] == '@' &&
+	    dentry->d_name.name[dentry->d_name.len - 3] == 's' &&
+	    dentry->d_name.name[dentry->d_name.len - 2] == 'y' &&
+	    dentry->d_name.name[dentry->d_name.len - 1] == 's')
+		return afs_lookup_atsys(dir, dentry, key);
+
 	inode = afs_do_lookup(dir, dentry, key);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 55b07e818400..c584d6e4c2f5 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -198,6 +198,16 @@ static inline struct afs_super_info *AFS_FS_S(struct super_block *sb)
 
 extern struct file_system_type afs_fs_type;
 
+/*
+ * Set of substitutes for @sys.
+ */
+struct afs_sysnames {
+#define AFS_NR_SYSNAME 16
+	char		*subs[AFS_NR_SYSNAME];
+	unsigned short	nr;
+	short		error;
+};
+
 /*
  * AFS network namespace record.
  */
@@ -246,8 +256,11 @@ struct afs_net {
 
 	/* Misc */
 	struct proc_dir_entry	*proc_afs;		/* /proc/net/afs directory */
+	struct afs_sysnames	*sysnames;
+	rwlock_t		sysnames_lock;
 };
 
+extern const char afs_init_sysname[];
 extern struct afs_net __afs_net;// Dummy AFS network namespace; TODO: replace with real netns
 
 enum afs_cell_state {
diff --git a/fs/afs/main.c b/fs/afs/main.c
index 15a02a05ff40..01a55d25d064 100644
--- a/fs/afs/main.c
+++ b/fs/afs/main.c
@@ -34,11 +34,42 @@ MODULE_PARM_DESC(rootcell, "root AFS cell name and VL server IP addr list");
 struct workqueue_struct *afs_wq;
 struct afs_net __afs_net;
 
+#if defined(CONFIG_ALPHA)
+const char afs_init_sysname[] = "alpha_linux26";
+#elif defined(CONFIG_X86_64)
+const char afs_init_sysname[] = "amd64_linux26";
+#elif defined(CONFIG_ARM)
+const char afs_init_sysname[] = "arm_linux26";
+#elif defined(CONFIG_ARM64)
+const char afs_init_sysname[] = "aarch64_linux26";
+#elif defined(CONFIG_X86_32)
+const char afs_init_sysname[] = "i386_linux26";
+#elif defined(CONFIG_IA64)
+const char afs_init_sysname[] = "ia64_linux26";
+#elif defined(CONFIG_PPC64)
+const char afs_init_sysname[] = "ppc64_linux26";
+#elif defined(CONFIG_PPC32)
+const char afs_init_sysname[] = "ppc_linux26";
+#elif defined(CONFIG_S390)
+#ifdef CONFIG_64BIT
+const char afs_init_sysname[] = "s390x_linux26";
+#else
+const char afs_init_sysname[] = "s390_linux26";
+#endif
+#elif defined(CONFIG_SPARC64)
+const char afs_init_sysname[] = "sparc64_linux26";
+#elif defined(CONFIG_SPARC32)
+const char afs_init_sysname[] = "sparc_linux26";
+#else
+const char afs_init_sysname[] = "unknown_linux26";
+#endif
+
 /*
  * Initialise an AFS network namespace record.
  */
 static int __net_init afs_net_init(struct afs_net *net)
 {
+	struct afs_sysnames *sysnames;
 	int ret;
 
 	net->live = true;
@@ -67,6 +98,15 @@ static int __net_init afs_net_init(struct afs_net *net)
 	INIT_WORK(&net->fs_manager, afs_manage_servers);
 	timer_setup(&net->fs_timer, afs_servers_timer, 0);
 
+	ret = -ENOMEM;
+	sysnames = kzalloc(sizeof(*sysnames), GFP_KERNEL);
+	if (!sysnames)
+		goto error_sysnames;
+	sysnames->subs[0] = (char *)&afs_init_sysname;
+	sysnames->nr = 1;
+	net->sysnames = sysnames;
+	rwlock_init(&net->sysnames_lock);
+
 	/* Register the /proc stuff */
 	ret = afs_proc_init(net);
 	if (ret < 0)
@@ -92,6 +132,8 @@ static int __net_init afs_net_init(struct afs_net *net)
 	net->live = false;
 	afs_proc_cleanup(net);
 error_proc:
+	kfree(net->sysnames);
+error_sysnames:
 	net->live = false;
 	return ret;
 }
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 2f04d37eeef0..7e9d6b2f9734 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -126,6 +126,32 @@ static const struct file_operations afs_proc_servers_fops = {
 	.release	= seq_release,
 };
 
+static int afs_proc_sysname_open(struct inode *inode, struct file *file);
+static int afs_proc_sysname_release(struct inode *inode, struct file *file);
+static void *afs_proc_sysname_start(struct seq_file *p, loff_t *pos);
+static void *afs_proc_sysname_next(struct seq_file *p, void *v,
+					loff_t *pos);
+static void afs_proc_sysname_stop(struct seq_file *p, void *v);
+static int afs_proc_sysname_show(struct seq_file *m, void *v);
+static ssize_t afs_proc_sysname_write(struct file *file,
+				      const char __user *buf,
+				      size_t size, loff_t *_pos);
+
+static const struct seq_operations afs_proc_sysname_ops = {
+	.start	= afs_proc_sysname_start,
+	.next	= afs_proc_sysname_next,
+	.stop	= afs_proc_sysname_stop,
+	.show	= afs_proc_sysname_show,
+};
+
+static const struct file_operations afs_proc_sysname_fops = {
+	.open		= afs_proc_sysname_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= afs_proc_sysname_release,
+	.write		= afs_proc_sysname_write,
+};
+
 /*
  * initialise the /proc/fs/afs/ directory
  */
@@ -139,7 +165,8 @@ int afs_proc_init(struct afs_net *net)
 
 	if (!proc_create("cells", 0644, net->proc_afs, &afs_proc_cells_fops) ||
 	    !proc_create("rootcell", 0644, net->proc_afs, &afs_proc_rootcell_fops) ||
-	    !proc_create("servers", 0644, net->proc_afs, &afs_proc_servers_fops))
+	    !proc_create("servers", 0644, net->proc_afs, &afs_proc_servers_fops) ||
+	    !proc_create("sysname", 0644, net->proc_afs, &afs_proc_sysname_fops))
 		goto error_tree;
 
 	_leave(" = 0");
@@ -635,3 +662,185 @@ static int afs_proc_servers_show(struct seq_file *m, void *v)
 		   &alist->addrs[alist->index].transport);
 	return 0;
 }
+
+static void afs_sysnames_free(struct afs_sysnames *sysnames)
+{
+	int i;
+
+	if (sysnames) {
+		for (i = 0; i < sysnames->nr; i++)
+			if (sysnames->subs[i] != afs_init_sysname)
+				kfree(sysnames->subs[i]);
+	}
+}
+
+/*
+ * Handle opening of /proc/fs/afs/sysname.  If it is opened for writing, we
+ * assume the caller wants to change the substitution list and we allocate a
+ * buffer to hold the list.
+ */
+static int afs_proc_sysname_open(struct inode *inode, struct file *file)
+{
+	struct afs_sysnames *sysnames;
+	struct seq_file *m;
+	int ret;
+
+	ret = seq_open(file, &afs_proc_sysname_ops);
+	if (ret < 0)
+		return ret;
+
+	if (file->f_mode & FMODE_WRITE) {
+		sysnames = kzalloc(sizeof(*sysnames), GFP_KERNEL);
+		if (!sysnames) {
+			seq_release(inode, file);
+			return -ENOMEM;
+		}
+
+		m = file->private_data;
+		m->private = sysnames;
+	}
+
+	return 0;
+}
+
+/*
+ * Handle writes to /proc/fs/afs/sysname to set the @sys substitution.
+ */
+static ssize_t afs_proc_sysname_write(struct file *file,
+				      const char __user *buf,
+				      size_t size, loff_t *_pos)
+{
+	struct afs_sysnames *sysnames;
+	struct seq_file *m = file->private_data;
+	char *kbuf = NULL, *s, *p, *sub;
+	int ret, len;
+
+	sysnames = m->private;
+	if (!sysnames)
+		return -EINVAL;
+	if (sysnames->error)
+		return sysnames->error;
+
+	if (size >= PAGE_SIZE - 1) {
+		sysnames->error = -EINVAL;
+		return -EINVAL;
+	}
+	if (size == 0)
+		return 0;
+
+	kbuf = memdup_user_nul(buf, size);
+	if (IS_ERR(kbuf))
+		return PTR_ERR(kbuf);
+
+	inode_lock(file_inode(file));
+
+	p = kbuf;
+	while ((s = strsep(&p, " \t\n"))) {
+		len = strlen(s);
+		if (len == 0)
+			continue;
+		if (len >= AFSNAMEMAX) {
+			sysnames->error = -ENAMETOOLONG;
+			ret = -ENAMETOOLONG;
+			goto out;
+		}
+		if (len >= 4 &&
+		    s[len - 4] == '@' &&
+		    s[len - 3] == 's' &&
+		    s[len - 2] == 'y' &&
+		    s[len - 1] == 's') {
+			/* Protect against recursion */
+			sysnames->error = -EINVAL;
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (sysnames->nr >= AFS_NR_SYSNAME) {
+			sysnames->error = -EFBIG;
+			ret = -EFBIG;
+			goto out;
+		}
+
+		if (strcmp(s, afs_init_sysname) == 0) {
+			sub = (char *)afs_init_sysname;
+		} else {
+			ret = -ENOMEM;
+			sub = kmemdup(s, len + 1, GFP_KERNEL);
+			if (!sub)
+				goto out;
+		}
+
+		sysnames->subs[sysnames->nr] = sub;
+		sysnames->nr++;
+	}
+
+	ret = size;	/* consume everything, always */
+out:
+	inode_unlock(file_inode(file));
+	kfree(kbuf);
+	return ret;
+}
+
+static int afs_proc_sysname_release(struct inode *inode, struct file *file)
+{
+	struct afs_sysnames *sysnames, *kill = NULL;
+	struct seq_file *m = file->private_data;
+	struct afs_net *net = afs_seq2net(m);
+
+	sysnames = m->private;
+	if (sysnames) {
+		kill = sysnames;
+		if (!sysnames->error) {
+			write_lock(&net->sysnames_lock);
+			kill = net->sysnames;
+			net->sysnames = sysnames;
+			write_unlock(&net->sysnames_lock);
+		}
+		afs_sysnames_free(kill);
+	}
+
+	return seq_release(inode, file);
+}
+
+static void *afs_proc_sysname_start(struct seq_file *m, loff_t *pos)
+	__acquires(&net->sysnames_lock)
+{
+	struct afs_net *net = afs_seq2net(m);
+	struct afs_sysnames *names = net->sysnames;
+
+	read_lock(&net->sysnames_lock);
+
+	if (*pos >= names->nr)
+		return NULL;
+	return (void *)(unsigned long)(*pos + 1);
+}
+
+static void *afs_proc_sysname_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct afs_net *net = afs_seq2net(m);
+	struct afs_sysnames *names = net->sysnames;
+
+	*pos += 1;
+	if (*pos >= names->nr)
+		return NULL;
+	return (void *)(unsigned long)(*pos + 1);
+}
+
+static void afs_proc_sysname_stop(struct seq_file *m, void *v)
+	__releases(&net->sysnames_lock)
+{
+	struct afs_net *net = afs_seq2net(m);
+
+	read_unlock(&net->sysnames_lock);
+}
+
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
