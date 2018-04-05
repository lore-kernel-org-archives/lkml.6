Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752000AbeDEUaQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 16:30:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40932 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751315AbeDEUaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 16:30:13 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 06/20] afs: Implement @cell substitution handling
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Apr 2018 21:30:11 +0100
Message-ID: <152296021112.31027.9052230341534673006.stgit@warthog.procyon.org.uk>
In-Reply-To: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
References: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement @cell substitution handling such that if @cell is seen as a name
in a dynamic root mount, then the name of the root cell for that network
namespace will be substituted for @cell during lookup.

The substitution of @cell for the current net namespace is set by writing
the cell name to /proc/fs/afs/rootcell.  The value can be obtained by
reading the file.

For example:

	# mount -t afs none /kafs -o dyn
	# echo grand.central.org >/proc/fs/afs/rootcell
	# ls /kafs/@cell
	archive/  cvs/  doc/  local/  project/  service/  software/  user/  www/
	# cat /proc/fs/afs/rootcell
	grand.central.org

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/cell.c |    2 ++
 fs/afs/dir.c  |   60 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/afs/proc.c |   35 ++++++++++++++++++++++++++++++++-
 3 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 721425b98b31..fdf4c36cff79 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -130,6 +130,8 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 		_leave(" = -ENAMETOOLONG");
 		return ERR_PTR(-ENAMETOOLONG);
 	}
+	if (namelen == 5 && memcmp(name, "@cell", 5) == 0)
+		return ERR_PTR(-EINVAL);
 
 	_enter("%*.*s,%s", namelen, namelen, name, vllist);
 
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 9bac606725ee..4f5e5c15ed6f 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -921,6 +921,62 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 	return NULL;
 }
 
+/*
+ * Look up @cell in a dynroot directory.  This is a substitution for the
+ * local cell name for the net namespace.
+ */
+static struct dentry *afs_lookup_atcell(struct dentry *dentry)
+{
+	struct afs_cell *cell;
+	struct afs_net *net = afs_d2net(dentry);
+	struct dentry *parent, *ret;
+	unsigned int seq = 0;
+	char *name;
+	int len;
+
+	if (!net->ws_cell)
+		return ERR_PTR(-ENOENT);
+
+	parent = dget_parent(dentry);
+
+	ret = ERR_PTR(-ENOMEM);
+	name = kmalloc(AFS_MAXCELLNAME + 1, GFP_KERNEL);
+	if (!name)
+		goto out_p;
+
+	rcu_read_lock();
+	do {
+		read_seqbegin_or_lock(&net->cells_lock, &seq);
+		cell = rcu_dereference_raw(net->ws_cell);
+		if (cell) {
+			len = cell->name_len;
+			memcpy(name, cell->name, len + 1);
+		}
+	} while (need_seqretry(&net->cells_lock, seq));
+	done_seqretry(&net->cells_lock, seq);
+	rcu_read_unlock();
+
+	ret = ERR_PTR(-ENOENT);
+	if (!cell)
+		goto out_n;
+
+	ret = lookup_one_len(name, parent, len);
+	if (IS_ERR(ret) || d_is_positive(ret))
+		goto out_n;
+
+	/* We don't want to d_add() the @cell dentry here as we don't want to
+	 * the cached dentry to hide changes to the local cell name.
+	 */
+	dput(ret);
+	ret = NULL;
+
+out_n:
+	kfree(name);
+out_p:
+	dput(parent);
+	return ret;
+}
+
 /*
  * Look up an entry in a dynroot directory.
  */
@@ -942,6 +998,10 @@ static struct dentry *afs_dynroot_lookup(struct inode *dir, struct dentry *dentr
 		return ERR_PTR(-ENAMETOOLONG);
 	}
 
+	if (dentry->d_name.len == 5 &&
+	    memcmp(dentry->d_name.name, "@cell", 5) == 0)
+		return afs_lookup_atcell(dentry);
+
 	inode = afs_try_auto_mntpt(dentry, dir);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 7e9d6b2f9734..f28719c8d153 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -334,7 +334,40 @@ static ssize_t afs_proc_cells_write(struct file *file, const char __user *buf,
 static ssize_t afs_proc_rootcell_read(struct file *file, char __user *buf,
 				      size_t size, loff_t *_pos)
 {
-	return 0;
+	struct afs_cell *cell;
+	struct afs_net *net = afs_proc2net(file);
+	unsigned int seq = 0;
+	char name[AFS_MAXCELLNAME + 1];
+	int len;
+
+	if (*_pos > 0)
+		return 0;
+	if (!net->ws_cell)
+		return 0;
+
+	rcu_read_lock();
+	do {
+		read_seqbegin_or_lock(&net->cells_lock, &seq);
+		len = 0;
+		cell = rcu_dereference_raw(net->ws_cell);
+		if (cell) {
+			len = cell->name_len;
+			memcpy(name, cell->name, len);
+		}
+	} while (need_seqretry(&net->cells_lock, seq));
+	done_seqretry(&net->cells_lock, seq);
+	rcu_read_unlock();
+
+	if (!len)
+		return 0;
+
+	name[len++] = '\n';
+	if (len > size)
+		len = size;
+	if (copy_to_user(buf, name, len) != 0)
+		return -EFAULT;
+	*_pos = 1;
+	return len;
 }
 
 /*
