Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971925AbeEYAIb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 20:08:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36048 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965178AbeEYAI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 20:08:27 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 28/32] vfs: Store the fd_cookie in nameidata,
 not the dfd int [ver #8]
From: David Howells <dhowells@redhat.com>
To: viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 25 May 2018 01:08:25 +0100
Message-ID: <152720690524.9073.15509053519638438137.stgit@warthog.procyon.org.uk>
In-Reply-To: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Look up dfd in set_nameidata() if not AT_FDCWD and store the resultant
fd_cookie in struct nameidata.  LOOKUP_AT_FDCWD is set if AT_FDCWD was
supplied.  The fd_cookie is released in restore_nameidata().

This means that where the fd points in a construct like the following:

	set_nameidata(&nd, dfd, name);
	retval = path_lookupat(&nd, flags | LOOKUP_RCU, path);
	if (unlikely(retval == -ECHILD))
		retval = path_lookupat(&nd, flags, path);
	if (unlikely(retval == -ESTALE))
		retval = path_lookupat(&nd, flags | LOOKUP_REVAL, path);

doesn't change between the three calls to path_lookupat() or similar.

It also allows us to fish the fd_cookie out for the upcoming move_mount()
syscall which needs to clear a file flag if successful.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/namei.c |   38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 6f0dc40f88c5..819d6ee71b46 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -53,8 +53,8 @@
  * The new code replaces the old recursive symlink resolution with
  * an iterative one (in case of non-nested symlink chains).  It does
  * this with calls to <fs>_follow_link().
- * As a side effect, dir_namei(), _namei() and follow_link() are now 
- * replaced with a single function lookup_dentry() that can handle all 
+ * As a side effect, dir_namei(), _namei() and follow_link() are now
+ * replaced with a single function lookup_dentry() that can handle all
  * the special cases of the former code.
  *
  * With the new dcache, the pathname is stored at each inode, at least as
@@ -506,25 +506,34 @@ struct nameidata {
 	struct filename	*name;
 	struct nameidata *saved;
 	struct inode	*link_inode;
+	struct fd_cookie *dfd;
+	bool		have_dfd;
 	unsigned	root_seq;
-	int		dfd;
 } __randomize_layout;
 
 static void set_nameidata(struct nameidata *p, int dfd, struct filename *name)
 {
 	struct nameidata *old = current->nameidata;
 	p->stack = p->internal;
-	p->dfd = dfd;
 	p->name = name;
 	p->total_link_count = old ? old->total_link_count : 0;
 	p->saved = old;
 	current->nameidata = p;
+
+	if (likely(dfd == AT_FDCWD)) {
+		p->dfd = NULL;
+		p->have_dfd = false;
+	} else {
+		p->dfd = __fdget_raw(dfd); /* Error are dealt with later */
+		p->have_dfd = true;
+	}
 }
 
 static void restore_nameidata(void)
 {
 	struct nameidata *now = current->nameidata, *old = now->saved;
 
+	__fdput(now->dfd);
 	current->nameidata = old;
 	if (old)
 		old->total_link_count = now->total_link_count;
@@ -2165,7 +2174,7 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 		nd->root.mnt = NULL;
 		rcu_read_unlock();
 		return ERR_PTR(-ECHILD);
-	} else if (nd->dfd == AT_FDCWD) {
+	} else if (!nd->have_dfd) {
 		if (flags & LOOKUP_RCU) {
 			struct fs_struct *fs = current->fs;
 			unsigned seq;
@@ -2185,22 +2194,18 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 		return s;
 	} else {
 		/* Caller must check execute permissions on the starting path component */
-		struct fd f = fdget_raw(nd->dfd);
 		struct dentry *dentry;
+		struct file *file = __fdfile(nd->dfd);
 
-		if (!f.file)
+		if (!nd->dfd)
 			return ERR_PTR(-EBADF);
 
-		dentry = f.file->f_path.dentry;
+		dentry = file->f_path.dentry;
 
-		if (*s) {
-			if (!d_can_lookup(dentry)) {
-				fdput(f);
-				return ERR_PTR(-ENOTDIR);
-			}
-		}
+		if (*s && !d_can_lookup(dentry))
+			return ERR_PTR(-ENOTDIR);
 
-		nd->path = f.file->f_path;
+		nd->path = file->f_path;
 		if (flags & LOOKUP_RCU) {
 			rcu_read_lock();
 			nd->inode = nd->path.dentry->d_inode;
@@ -2209,7 +2214,6 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 			path_get(&nd->path);
 			nd->inode = nd->path.dentry->d_inode;
 		}
-		fdput(f);
 		return s;
 	}
 }
@@ -3557,7 +3561,7 @@ struct file *do_file_open_root(struct dentry *dentry, struct vfsmount *mnt,
 	if (IS_ERR(filename))
 		return ERR_CAST(filename);
 
-	set_nameidata(&nd, -1, filename);
+	set_nameidata(&nd, AT_FDCWD, filename);
 	file = path_openat(&nd, op, flags | LOOKUP_RCU);
 	if (unlikely(file == ERR_PTR(-ECHILD)))
 		file = path_openat(&nd, op, flags);
