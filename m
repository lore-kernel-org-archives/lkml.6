Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbeDFJE1 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 05:04:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751278AbeDFJEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 05:04:25 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180406065118.GZ30522@ZenIV.linux.org.uk>
References: <20180406065118.GZ30522@ZenIV.linux.org.uk> <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk> <152296020457.31027.11109314533967989357.stgit@warthog.procyon.org.uk>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: dhowells@redhat.com, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/20] afs: Implement @sys substitution handling
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19687.1523005463.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date: Fri, 06 Apr 2018 10:04:23 +0100
Message-ID: <19688.1523005463@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How about the attached changes?

Note that I've put the checks for ".", ".." and names containing '/' in the
functions where the strings for @sys and @cell are set.

David
---
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index a14ea4280590..5e3a0ed2043f 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -760,6 +760,55 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry,
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
+	this.name = name;
+	this.len = len;
+	this.hash = full_name_hash(dir, name, len);
+
+	if (unlikely(IS_DEADDIR(inode)))
+		return ERR_PTR(-ESTALE);
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
@@ -810,7 +859,7 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry,
 		strcpy(p, name);
 		read_unlock(&net->sysnames_lock);
 
-		ret = lookup_one_len(buf, parent, len);
+		ret = afs_lookup_rec(parent, buf, len);
 		if (IS_ERR(ret) || d_is_positive(ret))
 			goto out_b;
 		dput(ret);
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
index 70dd41e06363..1dbcdafb25a0 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -682,6 +682,7 @@ extern const struct inode_operations afs_dir_inode_operations;
 extern const struct address_space_operations afs_dir_aops;
 extern const struct dentry_operations afs_fs_dentry_operations;
 
+extern struct dentry *afs_lookup_rec(struct dentry *, const char *, int);
 extern void afs_d_release(struct dentry *);
 
 /*
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 870b0bad03d0..47a0ac21ee44 100644
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
@@ -775,27 +782,28 @@ static ssize_t afs_proc_sysname_write(struct file *file,
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
@@ -815,6 +823,12 @@ static ssize_t afs_proc_sysname_write(struct file *file,
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
