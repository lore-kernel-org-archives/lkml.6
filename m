Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeDFKcS convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 06:32:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751434AbeDFKcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 06:32:16 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <19688.1523005463@warthog.procyon.org.uk>
References: <19688.1523005463@warthog.procyon.org.uk> <20180406065118.GZ30522@ZenIV.linux.org.uk> <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk> <152296020457.31027.11109314533967989357.stgit@warthog.procyon.org.uk>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: dhowells@redhat.com, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/20] afs: Implement @sys substitution handling
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13154.1523010734.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date: Fri, 06 Apr 2018 11:32:14 +0100
Message-ID: <13155.1523010734@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

Here's an updated set of changes.

I've improved the sysnames list handling and made it install a list consisting
of a blank name if the names are cleared (I'm told this is what should
happen).

I've also reinstated the "."  and ".." checks in afs_lookup_rec() to catch
substitution creating them by substituting a blank name.

David
---
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index a14ea4280590..45a472f3d368 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -760,6 +760,60 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry,
 	return inode;
 }
 
+/*
+ * Do a parallel recursive lookup.
+ *
+ * Ideally, we'd call lookup_one_len(), but we can't because we'd need to be
+ * holding i_mutex but we only hold i_rwsem for read.
+ */
+struct dentry *afs_lookup_rec(struct dentry *dir, const char *name, int len)
+{
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
+	struct dentry *dentry, *old;
+	struct inode *inode = dir->d_inode;
+	struct qstr this;
+	int ret;
+
+	if (len <= 0)
+		return ERR_PTR(-EINVAL);
+	if (name[0] == '.' &&
+	    (len < 2 || (len == 2 && name[1] == '.')))
+		return ERR_PTR(-EINVAL);
+	if (unlikely(IS_DEADDIR(inode)))
+		return ERR_PTR(-ESTALE);
+
+	this.name = name;
+	this.len = len;
+	this.hash = full_name_hash(dir, name, len);
+
+again:
+	dentry = d_alloc_parallel(dir, &this, &wq);
+	if (IS_ERR(dentry))
+		return ERR_CAST(dentry);
+
+	if (unlikely(!d_in_lookup(dentry))) {
+		ret = dentry->d_op->d_revalidate(dentry, 0);
+		if (unlikely(ret <= 0)) {
+			if (!ret) {
+				d_invalidate(dentry);
+				dput(dentry);
+				goto again;
+			}
+			dput(dentry);
+			dentry = ERR_PTR(ret);
+		}
+	} else {
+		old = inode->i_op->lookup(inode, dentry, 0);
+		d_lookup_done(dentry); /* Clean up wq */
+		if (unlikely(old)) {
+			dput(dentry);
+			dentry = old;
+		}
+	}
+
+	return dentry;
+}
+
 /*
  * Look up an entry in a directory with @sys substitution.
  */
@@ -785,43 +839,33 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry,
 		p += dentry->d_name.len - 4;
 	}
 
-	/* There is an ordered list of substitutes that we have to try */
-	for (i = 0; i < AFS_NR_SYSNAME; i++) {
-		read_lock(&net->sysnames_lock);
-		subs = net->sysnames;
-		if (!subs || i >= subs->nr) {
-			read_unlock(&net->sysnames_lock);
-			goto noent;
-		}
+	/* There is an ordered list of substitutes that we have to try. */
+	read_lock(&net->sysnames_lock);
+	subs = net->sysnames;
+	refcount_inc(&subs->usage);
+	read_unlock(&net->sysnames_lock);
 
+	for (i = 0; i < subs->nr; i++) {
 		name = subs->subs[i];
-		if (!name) {
-			read_unlock(&net->sysnames_lock);
-			goto noent;
-		}
-
 		len = dentry->d_name.len - 4 + strlen(name);
 		if (len >= AFSNAMEMAX) {
-			read_unlock(&net->sysnames_lock);
 			ret = ERR_PTR(-ENAMETOOLONG);
-			goto out_b;
+			goto out_s;
 		}
 
 		strcpy(p, name);
-		read_unlock(&net->sysnames_lock);
-
-		ret = lookup_one_len(buf, parent, len);
+		ret = afs_lookup_rec(parent, buf, len);
 		if (IS_ERR(ret) || d_is_positive(ret))
-			goto out_b;
+			goto out_s;
 		dput(ret);
 	}
 
-noent:
 	/* We don't want to d_add() the @sys dentry here as we don't want to
 	 * the cached dentry to hide changes to the sysnames list.
 	 */
 	ret = NULL;
-out_b:
+out_s:
+	afs_put_sysnames(subs);
 	kfree(buf);
 out_p:
 	dput(parent);
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index b70380e5d0e3..42d03a80310d 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -125,7 +125,7 @@ static struct dentry *afs_lookup_atcell(struct dentry *dentry)
 	if (!cell)
 		goto out_n;
 
-	ret = lookup_one_len(name, parent, len);
+	ret = afs_lookup_rec(parent, name, len);
 	if (IS_ERR(ret) || d_is_positive(ret))
 		goto out_n;
 
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 70dd41e06363..6e98acc1b43f 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -207,9 +207,11 @@ extern struct file_system_type afs_fs_type;
  */
 struct afs_sysnames {
 #define AFS_NR_SYSNAME 16
-	char		*subs[AFS_NR_SYSNAME];
-	unsigned short	nr;
-	short		error;
+	char			*subs[AFS_NR_SYSNAME];
+	refcount_t		usage;
+	unsigned short		nr;
+	short			error;
+	char			blank[1];
 };
 
 /*
@@ -682,6 +684,7 @@ extern const struct inode_operations afs_dir_inode_operations;
 extern const struct address_space_operations afs_dir_aops;
 extern const struct dentry_operations afs_fs_dentry_operations;
 
+extern struct dentry *afs_lookup_rec(struct dentry *, const char *, int);
 extern void afs_d_release(struct dentry *);
 
 /*
@@ -849,6 +852,7 @@ extern int __net_init afs_proc_init(struct afs_net *);
 extern void __net_exit afs_proc_cleanup(struct afs_net *);
 extern int afs_proc_cell_setup(struct afs_net *, struct afs_cell *);
 extern void afs_proc_cell_remove(struct afs_net *, struct afs_cell *);
+extern void afs_put_sysnames(struct afs_sysnames *);
 
 /*
  * rotate.c
diff --git a/fs/afs/main.c b/fs/afs/main.c
index 01a55d25d064..d7560168b3bf 100644
--- a/fs/afs/main.c
+++ b/fs/afs/main.c
@@ -104,6 +104,7 @@ static int __net_init afs_net_init(struct afs_net *net)
 		goto error_sysnames;
 	sysnames->subs[0] = (char *)&afs_init_sysname;
 	sysnames->nr = 1;
+	refcount_set(&sysnames->usage, 1);
 	net->sysnames = sysnames;
 	rwlock_init(&net->sysnames_lock);
 
@@ -132,7 +133,7 @@ static int __net_init afs_net_init(struct afs_net *net)
 	net->live = false;
 	afs_proc_cleanup(net);
 error_proc:
-	kfree(net->sysnames);
+	afs_put_sysnames(net->sysnames);
 error_sysnames:
 	net->live = false;
 	return ret;
@@ -148,6 +149,7 @@ static void __net_exit afs_net_exit(struct afs_net *net)
 	afs_purge_servers(net);
 	afs_close_socket(net);
 	afs_proc_cleanup(net);
+	afs_put_sysnames(net->sysnames);
 }
 
 /*
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 870b0bad03d0..839a22280606 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -393,6 +393,12 @@ static ssize_t afs_proc_rootcell_write(struct file *file,
 	if (IS_ERR(kbuf))
 		return PTR_ERR(kbuf);
 
+	ret = -EINVAL;
+	if (kbuf[0] == '.')
+		goto out;
+	if (memchr(kbuf, '/', size))
+		goto out;
+
 	/* trim to first NL */
 	s = memchr(kbuf, '\n', size);
 	if (s)
@@ -405,6 +411,7 @@ static ssize_t afs_proc_rootcell_write(struct file *file,
 	if (ret >= 0)
 		ret = size;	/* consume everything, always */
 
+out:
 	kfree(kbuf);
 	_leave(" = %d", ret);
 	return ret;
@@ -699,13 +706,14 @@ static int afs_proc_servers_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static void afs_sysnames_free(struct afs_sysnames *sysnames)
+void afs_put_sysnames(struct afs_sysnames *sysnames)
 {
 	int i;
 
-	if (sysnames) {
+	if (sysnames && refcount_dec_and_test(&sysnames->usage)) {
 		for (i = 0; i < sysnames->nr; i++)
-			if (sysnames->subs[i] != afs_init_sysname)
+			if (sysnames->subs[i] != afs_init_sysname &&
+			    sysnames->subs[i] != sysnames->blank)
 				kfree(sysnames->subs[i]);
 	}
 }
@@ -732,6 +740,7 @@ static int afs_proc_sysname_open(struct inode *inode, struct file *file)
 			return -ENOMEM;
 		}
 
+		refcount_set(&sysnames->usage, 1);
 		m = file->private_data;
 		m->private = sysnames;
 	}
@@ -775,27 +784,28 @@ static ssize_t afs_proc_sysname_write(struct file *file,
 		len = strlen(s);
 		if (len == 0)
 			continue;
-		if (len >= AFSNAMEMAX) {
-			sysnames->error = -ENAMETOOLONG;
-			ret = -ENAMETOOLONG;
-			goto out;
-		}
+		ret = -ENAMETOOLONG;
+		if (len >= AFSNAMEMAX)
+			goto error;
+
 		if (len >= 4 &&
 		    s[len - 4] == '@' &&
 		    s[len - 3] == 's' &&
 		    s[len - 2] == 'y' &&
-		    s[len - 1] == 's') {
+		    s[len - 1] == 's')
 			/* Protect against recursion */
-			sysnames->error = -EINVAL;
-			ret = -EINVAL;
-			goto out;
-		}
+			goto invalid;
+
+		if (s[0] == '.' &&
+		    (len < 2 || (len == 2 && s[1] == '.')))
+			goto invalid;
+
+		if (memchr(s, '/', len))
+			goto invalid;
 
-		if (sysnames->nr >= AFS_NR_SYSNAME) {
-			sysnames->error = -EFBIG;
-			ret = -EFBIG;
+		ret = -EFBIG;
+		if (sysnames->nr >= AFS_NR_SYSNAME)
 			goto out;
-		}
 
 		if (strcmp(s, afs_init_sysname) == 0) {
 			sub = (char *)afs_init_sysname;
@@ -815,6 +825,12 @@ static ssize_t afs_proc_sysname_write(struct file *file,
 	inode_unlock(file_inode(file));
 	kfree(kbuf);
 	return ret;
+
+invalid:
+	ret = -EINVAL;
+error:
+	sysnames->error = ret;
+	goto out;
 }
 
 static int afs_proc_sysname_release(struct inode *inode, struct file *file)
@@ -825,14 +841,18 @@ static int afs_proc_sysname_release(struct inode *inode, struct file *file)
 
 	sysnames = m->private;
 	if (sysnames) {
-		kill = sysnames;
 		if (!sysnames->error) {
+			kill = sysnames;
+			if (sysnames->nr == 0) {
+				sysnames->subs[0] = sysnames->blank;
+				sysnames->nr++;
+			}
 			write_lock(&net->sysnames_lock);
 			kill = net->sysnames;
 			net->sysnames = sysnames;
 			write_unlock(&net->sysnames_lock);
 		}
-		afs_sysnames_free(kill);
+		afs_put_sysnames(kill);
 	}
 
 	return seq_release(inode, file);
