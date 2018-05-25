Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971938AbeEYAIm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 20:08:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60498 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965178AbeEYAIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 20:08:34 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 29/32] vfs: Don't mix FMODE_* flags with O_* flags [ver #8]
From: David Howells <dhowells@redhat.com>
To: viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 25 May 2018 01:08:31 +0100
Message-ID: <152720691165.9073.9962220747176324753.stgit@warthog.procyon.org.uk>
In-Reply-To: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

build_open_flags() has a weird bit in it:

	/* Must never be set by userspace */
	flags &= ~FMODE_NONOTIFY & ~O_CLOEXEC;

This didn't used to have the O_CLOEXEC removal in it, but just used to be:

	/* Must never be set by userspace */
	flags &= ~FMODE_NONOTIFY;

but this flag should be only from file->f_mode and should have nothing to
do with the O_* flags.

Further, this check is redundant with:

	flags &= VALID_OPEN_FLAGS;

a few lines above.

Fix this by splitting the f_mode flags (FMODE_*) from the f_flags flags
(O_*) internally.

Fixes: ecf081d1a73b ("vfs: introduce FMODE_NONOTIFY")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Paris <eparis@redhat.com>
---

 drivers/dma-buf/dma-buf.c                     |    2 +-
 drivers/dma-buf/sync_file.c                   |    2 +-
 drivers/gpu/drm/drm_syncobj.c                 |    2 +-
 drivers/staging/lustre/lustre/mdc/mdc_lib.c   |    2 +-
 drivers/staging/lustre/lustre/mdc/mdc_locks.c |    2 +-
 drivers/tty/pty.c                             |    4 ++--
 fs/anon_inodes.c                              |   20 +++++++++++--------
 fs/autofs4/dev-ioctl.c                        |    2 +-
 fs/cachefiles/rdwr.c                          |    2 +-
 fs/eventfd.c                                  |    2 +-
 fs/eventpoll.c                                |    2 +-
 fs/exec.c                                     |    6 ++++--
 fs/exportfs/expfs.c                           |    2 +-
 fs/fcntl.c                                    |    6 ++----
 fs/internal.h                                 |    1 +
 fs/namei.c                                    |    1 +
 fs/namespace.c                                |    2 +-
 fs/nfs/dir.c                                  |   15 ++++++++------
 fs/nfs/nfs4proc.c                             |    9 +++------
 fs/notify/fanotify/fanotify_user.c            |   10 ++++++----
 fs/notify/inotify/inotify_user.c              |    2 +-
 fs/nsfs.c                                     |    2 +-
 fs/open.c                                     |   24 +++++++++++++++--------
 fs/signalfd.c                                 |    3 ++-
 fs/timerfd.c                                  |    2 +-
 fs/xfs/xfs_ioctl.c                            |    2 +-
 include/linux/anon_inodes.h                   |    6 +++---
 include/linux/fs.h                            |   26 ++++++++++++++++++-------
 include/linux/fsnotify.h                      |    8 ++++----
 include/linux/nfs_fs.h                        |    3 ++-
 include/uapi/asm-generic/fcntl.h              |    1 -
 ipc/mqueue.c                                  |    6 ++----
 kernel/bpf/syscall.c                          |    6 +++---
 kernel/events/core.c                          |    2 +-
 net/unix/af_unix.c                            |    2 +-
 security/apparmor/file.c                      |    2 +-
 security/keys/big_key.c                       |    2 +-
 security/selinux/hooks.c                      |    2 +-
 38 files changed, 109 insertions(+), 86 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index d78d5fc173dc..93445178d5c1 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -436,7 +436,7 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
 	dmabuf->resv = resv;
 
 	file = anon_inode_getfile("dmabuf", &dma_buf_fops, dmabuf,
-					exp_info->flags);
+				  exp_info->flags, 0);
 	if (IS_ERR(file)) {
 		ret = PTR_ERR(file);
 		goto err_dmabuf;
diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
index 35dd06479867..b92125e9be40 100644
--- a/drivers/dma-buf/sync_file.c
+++ b/drivers/dma-buf/sync_file.c
@@ -37,7 +37,7 @@ static struct sync_file *sync_file_alloc(void)
 		return NULL;
 
 	sync_file->file = anon_inode_getfile("sync_file", &sync_file_fops,
-					     sync_file, 0);
+					     sync_file, 0, 0);
 	if (IS_ERR(sync_file->file))
 		goto err;
 
diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index d4f4ce484529..10eb9b6d7d6a 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -419,7 +419,7 @@ int drm_syncobj_get_fd(struct drm_syncobj *syncobj, int *p_fd)
 
 	file = anon_inode_getfile("syncobj_file",
 				  &drm_syncobj_file_fops,
-				  syncobj, 0);
+				  syncobj, 0, 0);
 	if (IS_ERR(file)) {
 		put_unused_fd(fd);
 		return PTR_ERR(file);
diff --git a/drivers/staging/lustre/lustre/mdc/mdc_lib.c b/drivers/staging/lustre/lustre/mdc/mdc_lib.c
index 46eefdc09e3a..092d5be903cc 100644
--- a/drivers/staging/lustre/lustre/mdc/mdc_lib.c
+++ b/drivers/staging/lustre/lustre/mdc/mdc_lib.c
@@ -176,7 +176,7 @@ static inline __u64 mds_pack_open_flags(__u64 flags)
 		cr_flags |= MDS_OPEN_SYNC;
 	if (flags & O_DIRECTORY)
 		cr_flags |= MDS_OPEN_DIRECTORY;
-	if (flags & __FMODE_EXEC)
+	if (flags & FMODE_EXEC)
 		cr_flags |= MDS_FMODE_EXEC;
 	if (cl_is_lov_delay_create(flags))
 		cr_flags |= MDS_OPEN_DELAY_CREATE;
diff --git a/drivers/staging/lustre/lustre/mdc/mdc_locks.c b/drivers/staging/lustre/lustre/mdc/mdc_locks.c
index 695ef44532cf..7520e9dafffc 100644
--- a/drivers/staging/lustre/lustre/mdc/mdc_locks.c
+++ b/drivers/staging/lustre/lustre/mdc/mdc_locks.c
@@ -257,7 +257,7 @@ mdc_intent_open_pack(struct obd_export *exp, struct lookup_intent *it,
 		} else {
 			if (it->it_flags & (FMODE_WRITE | MDS_OPEN_TRUNC))
 				mode = LCK_CW;
-			else if (it->it_flags & __FMODE_EXEC)
+			else if (it->it_flags & FMODE_EXEC)
 				mode = LCK_PR;
 			else
 				mode = LCK_CR;
diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 6c7151edd715..91a0df8dc4a7 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -636,7 +636,7 @@ int ptm_open_peer(struct file *master, struct tty_struct *tty, int flags)
 	}
 	path.dentry = tty->link->driver_data;
 
-	filp = dentry_open(&path, flags, current_cred());
+	filp = dentry_open(&path, flags, 0, current_cred());
 	mntput(path.mnt);
 	if (IS_ERR(filp)) {
 		retval = PTR_ERR(filp);
@@ -806,7 +806,7 @@ static int ptmx_open(struct inode *inode, struct file *filp)
 	nonseekable_open(inode, filp);
 
 	/* We refuse fsnotify events on ptmx, since it's a shared resource */
-	filp->f_mode |= FMODE_NONOTIFY;
+	filp->f_mode |= FMODE_DONT_NOTIFY;
 
 	retval = tty_alloc_file(filp);
 	if (retval)
diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 13c06a7e0b85..2b50a274f885 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -60,7 +60,8 @@ static struct file_system_type anon_inode_fs_type = {
  * @name:    [in]    name of the "class" of the new file
  * @fops:    [in]    file operations for the new file
  * @priv:    [in]    private data for the new file (will be file's private_data)
- * @flags:   [in]    flags
+ * @f_flags: [in]    O_* flags
+ * @f_mode:  [in]    FMODE_* flags
  *
  * Creates a new file by hooking it on a single inode. This is useful for files
  * that do not need to have a full-fledged inode in order to operate correctly.
@@ -69,8 +70,8 @@ static struct file_system_type anon_inode_fs_type = {
  * setup.  Returns the newly created file* or an error pointer.
  */
 struct file *anon_inode_getfile(const char *name,
-				const struct file_operations *fops,
-				void *priv, int flags)
+				const struct file_operations *fops, void *priv,
+				unsigned int f_flags, fmode_t f_mode)
 {
 	struct qstr this;
 	struct path path;
@@ -103,12 +104,12 @@ struct file *anon_inode_getfile(const char *name,
 
 	d_instantiate(path.dentry, anon_inode_inode);
 
-	file = alloc_file(&path, OPEN_FMODE(flags), fops);
+	file = alloc_file(&path, f_mode | OPEN_FMODE(f_flags), fops);
 	if (IS_ERR(file))
 		goto err_dput;
 	file->f_mapping = anon_inode_inode->i_mapping;
 
-	file->f_flags = flags & (O_ACCMODE | O_NONBLOCK);
+	file->f_flags = f_flags & (O_ACCMODE | O_NONBLOCK);
 	file->private_data = priv;
 
 	return file;
@@ -129,7 +130,8 @@ EXPORT_SYMBOL_GPL(anon_inode_getfile);
  * @name:    [in]    name of the "class" of the new file
  * @fops:    [in]    file operations for the new file
  * @priv:    [in]    private data for the new file (will be file's private_data)
- * @flags:   [in]    flags
+ * @f_flags: [in]    O_* flags
+ * @f_mode:  [in]    FMODE_* flags
  *
  * Creates a new file by hooking it on a single inode. This is useful for files
  * that do not need to have a full-fledged inode in order to operate correctly.
@@ -138,17 +140,17 @@ EXPORT_SYMBOL_GPL(anon_inode_getfile);
  * setup.  Returns new descriptor or an error code.
  */
 int anon_inode_getfd(const char *name, const struct file_operations *fops,
-		     void *priv, int flags)
+		     void *priv, unsigned int f_flags, fmode_t f_mode)
 {
 	int error, fd;
 	struct file *file;
 
-	error = get_unused_fd_flags(flags);
+	error = get_unused_fd_flags(f_flags);
 	if (error < 0)
 		return error;
 	fd = error;
 
-	file = anon_inode_getfile(name, fops, priv, flags);
+	file = anon_inode_getfile(name, fops, priv, f_flags, f_mode);
 	if (IS_ERR(file)) {
 		error = PTR_ERR(file);
 		goto err_put_unused_fd;
diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index 26f6b4f41ce6..8e93d4e07aac 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -258,7 +258,7 @@ static int autofs_dev_ioctl_open_mountpoint(const char *name, dev_t devid)
 		if (err)
 			goto out;
 
-		filp = dentry_open(&path, O_RDONLY, current_cred());
+		filp = dentry_open(&path, O_RDONLY, 0, current_cred());
 		path_put(&path);
 		if (IS_ERR(filp)) {
 			err = PTR_ERR(filp);
diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
index 5082c8a49686..0d20db389405 100644
--- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -910,7 +910,7 @@ int cachefiles_write_page(struct fscache_storage *op, struct page *page)
 	 * own time */
 	path.mnt = cache->mnt;
 	path.dentry = object->backer;
-	file = dentry_open(&path, O_RDWR | O_LARGEFILE, cache->cache_cred);
+	file = dentry_open(&path, O_RDWR | O_LARGEFILE, 0, cache->cache_cred);
 	if (IS_ERR(file)) {
 		ret = PTR_ERR(file);
 		goto error_2;
diff --git a/fs/eventfd.c b/fs/eventfd.c
index 08d3bd602f73..fb4c5912a982 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -402,7 +402,7 @@ static int do_eventfd(unsigned int count, int flags)
 	ctx->flags = flags;
 
 	fd = anon_inode_getfd("[eventfd]", &eventfd_fops, ctx,
-			      O_RDWR | (flags & EFD_SHARED_FCNTL_FLAGS));
+			      O_RDWR | (flags & EFD_SHARED_FCNTL_FLAGS), 0);
 	if (fd < 0)
 		eventfd_free_ctx(ctx);
 
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 602ca4285b2e..e8052eb1e0dd 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1963,7 +1963,7 @@ static int do_epoll_create(int flags)
 		goto out_free_ep;
 	}
 	file = anon_inode_getfile("[eventpoll]", &eventpoll_fops, ep,
-				 O_RDWR | (flags & O_CLOEXEC));
+				  O_RDWR | (flags & O_CLOEXEC), 0);
 	if (IS_ERR(file)) {
 		error = PTR_ERR(file);
 		goto out_free_fd;
diff --git a/fs/exec.c b/fs/exec.c
index 183059c427b9..7ca13cc0b7f9 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -124,7 +124,8 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
 	struct filename *tmp = getname(library);
 	int error = PTR_ERR(tmp);
 	static const struct open_flags uselib_flags = {
-		.open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
+		.open_flag = O_LARGEFILE | O_RDONLY,
+		.f_mode = FMODE_EXEC,
 		.acc_mode = MAY_READ | MAY_EXEC,
 		.intent = LOOKUP_OPEN,
 		.lookup_flags = LOOKUP_FOLLOW,
@@ -838,7 +839,8 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 	struct file *file;
 	int err;
 	struct open_flags open_exec_flags = {
-		.open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
+		.open_flag = O_LARGEFILE | O_RDONLY,
+		.f_mode = FMODE_EXEC,
 		.acc_mode = MAY_EXEC,
 		.intent = LOOKUP_OPEN,
 		.lookup_flags = LOOKUP_FOLLOW,
diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 645158dc33f1..ec8f68277ce7 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -308,7 +308,7 @@ static int get_name(const struct path *path, char *name, struct dentry *child)
 	/*
 	 * Open the directory ...
 	 */
-	file = dentry_open(path, O_RDONLY, cred);
+	file = dentry_open(path, O_RDONLY, 0, cred);
 	error = PTR_ERR(file);
 	if (IS_ERR(file))
 		goto out;
diff --git a/fs/fcntl.c b/fs/fcntl.c
index d737ff082472..60bc5bf2f4cf 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1028,10 +1028,8 @@ static int __init fcntl_init(void)
 	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
 	 * is defined as O_NONBLOCK on some platforms and not on others.
 	 */
-	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
-		HWEIGHT32(
-			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
-			__FMODE_EXEC | __FMODE_NONOTIFY));
+	BUILD_BUG_ON(19 - 1 /* for O_RDONLY being 0 */ !=
+		     HWEIGHT32(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)));
 
 	fasync_cache = kmem_cache_create("fasync_cache",
 		sizeof(struct fasync_struct), 0, SLAB_PANIC, NULL);
diff --git a/fs/internal.h b/fs/internal.h
index f47ede6ace5a..c29552e0522f 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -110,6 +110,7 @@ struct open_flags {
 	int open_flag;
 	umode_t mode;
 	int acc_mode;
+	fmode_t f_mode;
 	int intent;
 	int lookup_flags;
 };
diff --git a/fs/namei.c b/fs/namei.c
index 819d6ee71b46..5cbd980b4031 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3481,6 +3481,7 @@ static struct file *path_openat(struct nameidata *nd,
 		return file;
 
 	file->f_flags = op->open_flag;
+	file->f_mode = op->f_mode;
 
 	if (unlikely(file->f_flags & __O_TMPFILE)) {
 		error = do_tmpfile(nd, flags, op, file, &opened);
diff --git a/fs/namespace.c b/fs/namespace.c
index 03ade803b948..dba680aa1ea4 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3309,7 +3309,7 @@ SYSCALL_DEFINE5(fsmount, int, fs_fd, unsigned int, flags, unsigned int, ms_flags
 	/* Attach to an apparent O_PATH fd with a note that we need to unmount
 	 * it, not just simply put it.
 	 */
-	file = dentry_open(&newmount, O_PATH, fc->cred);
+	file = dentry_open(&newmount, O_PATH, 0, fc->cred);
 	if (IS_ERR(file))
 		goto err_path;
 	file->f_mode |= FMODE_NEED_UNMOUNT;
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 73f8b43d988c..f8eeea255651 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1395,9 +1395,9 @@ const struct dentry_operations nfs4_dentry_operations = {
 };
 EXPORT_SYMBOL_GPL(nfs4_dentry_operations);
 
-static fmode_t flags_to_mode(int flags)
+static fmode_t flags_to_mode(int flags, fmode_t f_mode)
 {
-	fmode_t res = (__force fmode_t)flags & FMODE_EXEC;
+	fmode_t res = f_mode & FMODE_EXEC;
 	if ((flags & O_ACCMODE) != O_WRONLY)
 		res |= FMODE_READ;
 	if ((flags & O_ACCMODE) != O_RDONLY)
@@ -1407,7 +1407,7 @@ static fmode_t flags_to_mode(int flags)
 
 static struct nfs_open_context *create_nfs_open_context(struct dentry *dentry, int open_flags, struct file *filp)
 {
-	return alloc_nfs_open_context(dentry, flags_to_mode(open_flags), filp);
+	return alloc_nfs_open_context(dentry, flags_to_mode(open_flags, filp->f_mode), filp);
 }
 
 static int do_open(struct inode *inode, struct file *filp)
@@ -2441,11 +2441,11 @@ static int nfs_do_access(struct inode *inode, struct rpc_cred *cred, int mask)
 	return status;
 }
 
-static int nfs_open_permission_mask(int openflags)
+static int nfs_open_permission_mask(fmode_t f_mode, int openflags)
 {
 	int mask = 0;
 
-	if (openflags & __FMODE_EXEC) {
+	if (f_mode & FMODE_EXEC) {
 		/* ONLY check exec rights */
 		mask = MAY_EXEC;
 	} else {
@@ -2458,9 +2458,10 @@ static int nfs_open_permission_mask(int openflags)
 	return mask;
 }
 
-int nfs_may_open(struct inode *inode, struct rpc_cred *cred, int openflags)
+int nfs_may_open(struct inode *inode, struct rpc_cred *cred, fmode_t f_mode,
+		 int openflags)
 {
-	return nfs_do_access(inode, cred, nfs_open_permission_mask(openflags));
+	return nfs_do_access(inode, cred, nfs_open_permission_mask(f_mode, openflags));
 }
 EXPORT_SYMBOL_GPL(nfs_may_open);
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index b71757e85066..6b30118c0507 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1712,7 +1712,8 @@ static struct nfs4_state *nfs4_try_open_cached(struct nfs4_opendata *opendata)
 		rcu_read_unlock();
 		nfs_release_seqid(opendata->o_arg.seqid);
 		if (!opendata->is_recover) {
-			ret = nfs_may_open(state->inode, state->owner->so_cred, open_mode);
+			ret = nfs_may_open(state->inode, state->owner->so_cred,
+					   fmode, open_mode);
 			if (ret != 0)
 				goto out;
 		}
@@ -2414,11 +2415,7 @@ static int nfs4_opendata_access(struct rpc_cred *cred,
 		return 0;
 
 	mask = 0;
-	/*
-	 * Use openflags to check for exec, because fmode won't
-	 * always have FMODE_EXEC set when file open for exec.
-	 */
-	if (openflags & __FMODE_EXEC) {
+	if (fmode & FMODE_EXEC) {
 		/* ONLY check for exec rights */
 		if (S_ISDIR(state->inode->i_mode))
 			mask = NFS4_ACCESS_LOOKUP;
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index ec4d8c59d0e3..a84fb5390e85 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -32,7 +32,7 @@
  *
  * Internal and external open flags are stored together in field f_flags of
  * struct file. Only external open flags shall be allowed in event_f_flags.
- * Internal flags like FMODE_NONOTIFY, FMODE_EXEC, FMODE_NOCMTIME shall be
+ * Internal flags like FMODE_DONT_NOTIFY, FMODE_EXEC, FMODE_NOCMTIME shall be
  * excluded.
  */
 #define	FANOTIFY_INIT_ALL_EVENT_F_BITS				( \
@@ -92,7 +92,8 @@ static int create_fd(struct fsnotify_group *group,
 	 * are NULL;  That's fine, just don't call dentry open */
 	if (event->path.dentry && event->path.mnt)
 		new_file = dentry_open(&event->path,
-				       group->fanotify_data.f_flags | FMODE_NONOTIFY,
+				       group->fanotify_data.f_flags,
+				       FMODE_DONT_NOTIFY,
 				       current_cred());
 	else
 		new_file = ERR_PTR(-EOVERFLOW);
@@ -741,7 +742,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 		return -EMFILE;
 	}
 
-	f_flags = O_RDWR | FMODE_NONOTIFY;
+	f_flags = O_RDWR;
 	if (flags & FAN_CLOEXEC)
 		f_flags |= O_CLOEXEC;
 	if (flags & FAN_NONBLOCK)
@@ -809,7 +810,8 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 		group->fanotify_data.audit = true;
 	}
 
-	fd = anon_inode_getfd("[fanotify]", &fanotify_fops, group, f_flags);
+	fd = anon_inode_getfd("[fanotify]", &fanotify_fops, group, f_flags,
+			      FMODE_DONT_NOTIFY);
 	if (fd < 0)
 		goto out_destroy_group;
 
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index ef32f3657958..b8fd9ade776e 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -667,7 +667,7 @@ static int do_inotify_init(int flags)
 		return PTR_ERR(group);
 
 	ret = anon_inode_getfd("inotify", &inotify_fops, group,
-				  O_RDONLY | flags);
+			       O_RDONLY | flags, 0);
 	if (ret < 0)
 		fsnotify_destroy_group(group);
 
diff --git a/fs/nsfs.c b/fs/nsfs.c
index f069eb6495b0..93886ec2540c 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -174,7 +174,7 @@ int open_related_ns(struct ns_common *ns,
 		return PTR_ERR(err);
 	}
 
-	f = dentry_open(&path, O_RDONLY, current_cred());
+	f = dentry_open(&path, O_RDONLY, 0, current_cred());
 	path_put(&path);
 	if (IS_ERR(f)) {
 		put_unused_fd(fd);
diff --git a/fs/open.c b/fs/open.c
index c5ee7cd60424..79a8a1bd740d 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -34,6 +34,13 @@
 
 #include "internal.h"
 
+const u8 acc_mode[O_ACCMODE + 1] = {
+	[O_RDONLY]	= MAY_READ,
+	[O_WRONLY]	= MAY_WRITE,
+	[O_RDWR]	= MAY_READ | MAY_WRITE,
+	[3]		= MAY_READ | MAY_WRITE,
+};
+
 int do_truncate(struct dentry *dentry, loff_t length, unsigned int time_attrs,
 	struct file *filp)
 {
@@ -732,9 +739,6 @@ static int do_dentry_open(struct file *f,
 	static const struct file_operations empty_fops = {};
 	int error;
 
-	f->f_mode = OPEN_FMODE(f->f_flags) | FMODE_LSEEK |
-				FMODE_PREAD | FMODE_PWRITE;
-
 	path_get(&f->f_path);
 	f->f_inode = inode;
 	f->f_mapping = inode->i_mapping;
@@ -743,11 +747,14 @@ static int do_dentry_open(struct file *f,
 	f->f_wb_err = filemap_sample_wb_err(f->f_mapping);
 
 	if (unlikely(f->f_flags & O_PATH)) {
-		f->f_mode = FMODE_PATH;
+		f->f_mode |= FMODE_PATH;
 		f->f_op = &empty_fops;
 		goto done;
 	}
 
+	f->f_mode |= OPEN_FMODE(f->f_flags) | FMODE_LSEEK |
+				FMODE_PREAD | FMODE_PWRITE;
+
 	if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mode)) {
 		error = get_write_access(inode);
 		if (unlikely(error))
@@ -906,8 +913,8 @@ int vfs_open(const struct path *path, struct file *file,
 	return do_dentry_open(file, d_backing_inode(dentry), NULL, cred);
 }
 
-struct file *dentry_open(const struct path *path, int flags,
-			 const struct cred *cred)
+struct file *dentry_open(const struct path *path, unsigned int flags,
+			 fmode_t f_mode, const struct cred *cred)
 {
 	int error;
 	struct file *f;
@@ -941,14 +948,15 @@ static inline int build_open_flags(int flags, umode_t mode, struct open_flags *o
 	 * them in fcntl(F_GETFD) or similar interfaces.
 	 */
 	flags &= VALID_OPEN_FLAGS;
+	op->f_mode = 0;
 
 	if (flags & (O_CREAT | __O_TMPFILE))
 		op->mode = (mode & S_IALLUGO) | S_IFREG;
 	else
 		op->mode = 0;
 
-	/* Must never be set by userspace */
-	flags &= ~FMODE_NONOTIFY & ~O_CLOEXEC;
+	/* Don't leak O_CLOEXEC into ->f_flags */
+	flags &= ~O_CLOEXEC;
 
 	/*
 	 * O_SYNC is implemented as __O_SYNC|O_DSYNC.  As many places only
diff --git a/fs/signalfd.c b/fs/signalfd.c
index d2187a813376..885122c786de 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -287,7 +287,8 @@ static int do_signalfd4(int ufd, sigset_t __user *user_mask, size_t sizemask,
 		 * anon_inode_getfd() will install the fd.
 		 */
 		ufd = anon_inode_getfd("[signalfd]", &signalfd_fops, ctx,
-				       O_RDWR | (flags & (O_CLOEXEC | O_NONBLOCK)));
+				       O_RDWR | (flags & (O_CLOEXEC | O_NONBLOCK)),
+				       0);
 		if (ufd < 0)
 			kfree(ctx);
 	} else {
diff --git a/fs/timerfd.c b/fs/timerfd.c
index cdad49da3ff7..6de8ea9737d7 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -425,7 +425,7 @@ SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flags)
 	ctx->moffs = ktime_mono_to_real(0);
 
 	ufd = anon_inode_getfd("[timerfd]", &timerfd_fops, ctx,
-			       O_RDWR | (flags & TFD_SHARED_FCNTL_FLAGS));
+			       O_RDWR | (flags & TFD_SHARED_FCNTL_FLAGS), 0);
 	if (ufd < 0)
 		kfree(ctx);
 
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 89fb1eb80aae..6c3c7ff271df 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -255,7 +255,7 @@ xfs_open_by_handle(
 
 	path.mnt = parfilp->f_path.mnt;
 	path.dentry = dentry;
-	filp = dentry_open(&path, hreq->oflags, cred);
+	filp = dentry_open(&path, hreq->oflags, 0, cred);
 	dput(dentry);
 	if (IS_ERR(filp)) {
 		put_unused_fd(fd);
diff --git a/include/linux/anon_inodes.h b/include/linux/anon_inodes.h
index d0d7d96261ad..a1a190beb068 100644
--- a/include/linux/anon_inodes.h
+++ b/include/linux/anon_inodes.h
@@ -12,10 +12,10 @@
 struct file_operations;
 
 struct file *anon_inode_getfile(const char *name,
-				const struct file_operations *fops,
-				void *priv, int flags);
+				const struct file_operations *fops, void *priv,
+				unsigned int f_flags, fmode_t f_mode);
 int anon_inode_getfd(const char *name, const struct file_operations *fops,
-		     void *priv, int flags);
+		     void *priv, unsigned int f_flags, fmode_t f_mode);
 
 #endif /* _LINUX_ANON_INODES_H */
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ba571c18e236..40890e3359f0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -149,7 +149,7 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 #define FMODE_CAN_WRITE         ((__force fmode_t)0x40000)
 
 /* File was opened by fanotify and shouldn't generate fanotify events */
-#define FMODE_NONOTIFY		((__force fmode_t)0x4000000)
+#define FMODE_DONT_NOTIFY	((__force fmode_t)0x4000000)
 
 /* File is capable of returning -EAGAIN if I/O will block */
 #define FMODE_NOWAIT		((__force fmode_t)0x8000000)
@@ -2413,7 +2413,8 @@ extern struct file *file_open_name(struct filename *, int, umode_t);
 extern struct file *filp_open(const char *, int, umode_t);
 extern struct file *file_open_root(struct dentry *, struct vfsmount *,
 				   const char *, int, umode_t);
-extern struct file * dentry_open(const struct path *, int, const struct cred *);
+extern struct file * dentry_open(const struct path *, unsigned int, fmode_t,
+				 const struct cred *);
 extern int filp_close(struct file *, fl_owner_t id);
 
 extern struct filename *getname_flags(const char __user *, int, int *);
@@ -3349,12 +3350,23 @@ int proc_nr_inodes(struct ctl_table *table, int write,
 		   void __user *buffer, size_t *lenp, loff_t *ppos);
 int __init get_filesystem_list(char *buf);
 
-#define __FMODE_EXEC		((__force int) FMODE_EXEC)
-#define __FMODE_NONOTIFY	((__force int) FMODE_NONOTIFY)
+extern const u8 acc_mode[O_ACCMODE + 1];
 
-#define ACC_MODE(x) ("\004\002\006\006"[(x)&O_ACCMODE])
-#define OPEN_FMODE(flag) ((__force fmode_t)(((flag + 1) & O_ACCMODE) | \
-					    (flag & __FMODE_NONOTIFY)))
+/*
+ * Turn { O_RDONLY, O_WRONLY, O_RDWD, 3 } into MAY_READ and/or MAY_WRITE
+ */
+static inline unsigned int ACC_MODE(int x)
+{
+	return acc_mode[(x) & O_ACCMODE];
+}
+
+/*
+ * Turn { O_RDONLY, O_WRONLY, O_RDWD, 3 } into FMODE_READ and/or FMODE_WRITE
+ */
+static inline fmode_t OPEN_FMODE(unsigned int O_flags)
+{
+	return (__force fmode_t)((O_flags + 1) & O_ACCMODE);
+}
 
 static inline bool is_sxid(umode_t mode)
 {
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index bdaf22582f6e..67c3f9e3f371 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -38,7 +38,7 @@ static inline int fsnotify_perm(struct file *file, int mask)
 	__u32 fsnotify_mask = 0;
 	int ret;
 
-	if (file->f_mode & FMODE_NONOTIFY)
+	if (file->f_mode & FMODE_DONT_NOTIFY)
 		return 0;
 	if (!(mask & (MAY_READ | MAY_OPEN)))
 		return 0;
@@ -184,7 +184,7 @@ static inline void fsnotify_access(struct file *file)
 	if (S_ISDIR(inode->i_mode))
 		mask |= FS_ISDIR;
 
-	if (!(file->f_mode & FMODE_NONOTIFY)) {
+	if (!(file->f_mode & FMODE_DONT_NOTIFY)) {
 		fsnotify_parent(path, NULL, mask);
 		fsnotify(inode, mask, path, FSNOTIFY_EVENT_PATH, NULL, 0);
 	}
@@ -202,7 +202,7 @@ static inline void fsnotify_modify(struct file *file)
 	if (S_ISDIR(inode->i_mode))
 		mask |= FS_ISDIR;
 
-	if (!(file->f_mode & FMODE_NONOTIFY)) {
+	if (!(file->f_mode & FMODE_DONT_NOTIFY)) {
 		fsnotify_parent(path, NULL, mask);
 		fsnotify(inode, mask, path, FSNOTIFY_EVENT_PATH, NULL, 0);
 	}
@@ -237,7 +237,7 @@ static inline void fsnotify_close(struct file *file)
 	if (S_ISDIR(inode->i_mode))
 		mask |= FS_ISDIR;
 
-	if (!(file->f_mode & FMODE_NONOTIFY)) {
+	if (!(file->f_mode & FMODE_DONT_NOTIFY)) {
 		fsnotify_parent(path, NULL, mask);
 		fsnotify(inode, mask, path, FSNOTIFY_EVENT_PATH, NULL, 0);
 	}
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 2f129bbfaae8..a13508c0fe88 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -477,7 +477,8 @@ extern const struct dentry_operations nfs_dentry_operations;
 extern void nfs_force_lookup_revalidate(struct inode *dir);
 extern int nfs_instantiate(struct dentry *dentry, struct nfs_fh *fh,
 			struct nfs_fattr *fattr, struct nfs4_label *label);
-extern int nfs_may_open(struct inode *inode, struct rpc_cred *cred, int openflags);
+extern int nfs_may_open(struct inode *inode, struct rpc_cred *cred,
+			fmode_t mode, int openflags);
 extern void nfs_access_zap_cache(struct inode *inode);
 
 /*
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 9dc0bf0c5a6e..0b1c7e35090c 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -6,7 +6,6 @@
 
 /*
  * FMODE_EXEC is 0x20
- * FMODE_NONOTIFY is 0x4000000
  * These cannot be used by userspace O_* until internal and external open
  * flags are split.
  * -Eric Paris
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 934ccdc48a1d..de7548442c94 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -791,8 +791,6 @@ static int prepare_open(struct dentry *dentry, int oflag, int ro,
 			umode_t mode, struct filename *name,
 			struct mq_attr *attr)
 {
-	static const int oflag2acc[O_ACCMODE] = { MAY_READ, MAY_WRITE,
-						  MAY_READ | MAY_WRITE };
 	int acc;
 
 	if (d_really_is_negative(dentry)) {
@@ -810,7 +808,7 @@ static int prepare_open(struct dentry *dentry, int oflag, int ro,
 		return -EEXIST;
 	if ((oflag & O_ACCMODE) == (O_RDWR | O_WRONLY))
 		return -EINVAL;
-	acc = oflag2acc[oflag & O_ACCMODE];
+	acc = ACC_MODE(oflag);
 	return inode_permission(d_inode(dentry), acc);
 }
 
@@ -843,7 +841,7 @@ static int do_mq_open(const char __user *u_name, int oflag, umode_t mode,
 	path.mnt = mntget(mnt);
 	error = prepare_open(path.dentry, oflag, ro, mode, name, attr);
 	if (!error) {
-		struct file *file = dentry_open(&path, oflag, current_cred());
+		struct file *file = dentry_open(&path, oflag, 0, current_cred());
 		if (!IS_ERR(file))
 			fd_install(fd, file);
 		else
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 016ef9025827..5018d399eed9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -373,7 +373,7 @@ int bpf_map_new_fd(struct bpf_map *map, int flags)
 		return ret;
 
 	return anon_inode_getfd("bpf-map", &bpf_map_fops, map,
-				flags | O_CLOEXEC);
+				flags | O_CLOEXEC, 0);
 }
 
 int bpf_get_file_flag(int flags)
@@ -1068,7 +1068,7 @@ int bpf_prog_new_fd(struct bpf_prog *prog)
 		return ret;
 
 	return anon_inode_getfd("bpf-prog", &bpf_prog_fops, prog,
-				O_RDWR | O_CLOEXEC);
+				O_RDWR | O_CLOEXEC, 0);
 }
 
 static struct bpf_prog *____bpf_prog_get(struct fd f)
@@ -1445,7 +1445,7 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
 
 	raw_tp->prog = prog;
 	tp_fd = anon_inode_getfd("bpf-raw-tracepoint", &bpf_raw_tp_fops, raw_tp,
-				 O_CLOEXEC);
+				 O_CLOEXEC, 0);
 	if (tp_fd < 0) {
 		bpf_probe_unregister(raw_tp->btp, prog);
 		err = tp_fd;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 67612ce359ad..0e0fcb1f946f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10612,7 +10612,7 @@ SYSCALL_DEFINE5(perf_event_open,
 	}
 
 	event_file = anon_inode_getfile("[perf_event]", &perf_fops, event,
-					f_flags);
+					f_flags, 0);
 	if (IS_ERR(event_file)) {
 		err = PTR_ERR(event_file);
 		event_file = NULL;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index e5473c03d667..6813b51d1baf 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2588,7 +2588,7 @@ static int unix_open_file(struct sock *sk)
 	if (fd < 0)
 		goto out;
 
-	f = dentry_open(&path, O_PATH, current_cred());
+	f = dentry_open(&path, O_PATH, 0, current_cred());
 	if (IS_ERR(f)) {
 		put_unused_fd(fd);
 		fd = PTR_ERR(f);
diff --git a/security/apparmor/file.c b/security/apparmor/file.c
index 224b2fef93ca..392398f6254e 100644
--- a/security/apparmor/file.c
+++ b/security/apparmor/file.c
@@ -692,7 +692,7 @@ void aa_inherit_files(const struct cred *cred, struct files_struct *files)
 	if (!n) /* none found? */
 		goto out;
 
-	devnull = dentry_open(&aa_null, O_RDWR, cred);
+	devnull = dentry_open(&aa_null, O_RDWR, 0, cred);
 	if (IS_ERR(devnull))
 		devnull = NULL;
 	/* replace all the matching ones with this */
diff --git a/security/keys/big_key.c b/security/keys/big_key.c
index 933623784ccd..d29381f22cde 100644
--- a/security/keys/big_key.c
+++ b/security/keys/big_key.c
@@ -374,7 +374,7 @@ long big_key_read(const struct key *key, char __user *buffer, size_t buflen)
 		if (!buf)
 			return -ENOMEM;
 
-		file = dentry_open(path, O_RDONLY, current_cred());
+		file = dentry_open(path, O_RDONLY, 0, current_cred());
 		if (IS_ERR(file)) {
 			ret = PTR_ERR(file);
 			goto error;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9c5d60308136..098a541b76e0 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2625,7 +2625,7 @@ static inline void flush_unauthorized_files(const struct cred *cred,
 	if (!n) /* none found? */
 		return;
 
-	devnull = dentry_open(&selinux_null, O_RDWR, cred);
+	devnull = dentry_open(&selinux_null, O_RDWR, 0, cred);
 	if (IS_ERR(devnull))
 		devnull = NULL;
 	/* replace all the matching ones with this */
