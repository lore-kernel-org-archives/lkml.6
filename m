Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752985AbeDEUho (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 16:37:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751679AbeDEUaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 16:30:00 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 04/20] afs: Prospectively look up extra files when doing a
 single lookup
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Apr 2018 21:29:58 +0100
Message-ID: <152296019803.31027.7928578603468288192.stgit@warthog.procyon.org.uk>
In-Reply-To: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
References: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When afs_lookup() is called, prospectively look up the next 50 uncached
fids also from that same directory and cache the results, rather than just
looking up the one file requested.

This allows us to use the FS.InlineBulkStatus RPC op to increase efficiency
by fetching up to 50 file statuses at a time.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/afs.h               |   21 ++-
 fs/afs/afs_fs.h            |    2 
 fs/afs/callback.c          |    8 +
 fs/afs/cmservice.c         |   12 +-
 fs/afs/dir.c               |  288 ++++++++++++++++++++++++++++++++++++++------
 fs/afs/fsclient.c          |  272 +++++++++++++++++++++++++++++++++++++++++-
 fs/afs/internal.h          |   10 +-
 include/trace/events/afs.h |    2 
 8 files changed, 552 insertions(+), 63 deletions(-)

diff --git a/fs/afs/afs.h b/fs/afs/afs.h
index b94d0edc2b78..a670bca6d3ba 100644
--- a/fs/afs/afs.h
+++ b/fs/afs/afs.h
@@ -67,10 +67,14 @@ typedef enum {
 } afs_callback_type_t;
 
 struct afs_callback {
-	struct afs_fid		fid;		/* file identifier */
-	unsigned		version;	/* callback version */
-	unsigned		expiry;		/* time at which expires */
-	afs_callback_type_t	type;		/* type of callback */
+	unsigned		version;	/* Callback version */
+	unsigned		expiry;		/* Time at which expires */
+	afs_callback_type_t	type;		/* Type of callback */
+};
+
+struct afs_callback_break {
+	struct afs_fid		fid;		/* File identifier */
+	struct afs_callback	cb;		/* Callback details */
 };
 
 #define AFSCBMAX 50	/* maximum callbacks transferred per bulk op */
@@ -123,21 +127,22 @@ typedef u32 afs_access_t;
  * AFS file status information
  */
 struct afs_file_status {
+	u64			size;		/* file size */
+	afs_dataversion_t	data_version;	/* current data version */
+	time_t			mtime_client;	/* last time client changed data */
+	time_t			mtime_server;	/* last time server changed data */
 	unsigned		if_version;	/* interface version */
 #define AFS_FSTATUS_VERSION	1
+	unsigned		abort_code;	/* Abort if bulk-fetching this failed */
 
 	afs_file_type_t		type;		/* file type */
 	unsigned		nlink;		/* link count */
-	u64			size;		/* file size */
-	afs_dataversion_t	data_version;	/* current data version */
 	u32			author;		/* author ID */
 	kuid_t			owner;		/* owner ID */
 	kgid_t			group;		/* group ID */
 	afs_access_t		caller_access;	/* access rights for authenticated caller */
 	afs_access_t		anon_access;	/* access rights for unauthenticated caller */
 	umode_t			mode;		/* UNIX mode */
-	time_t			mtime_client;	/* last time client changed data */
-	time_t			mtime_server;	/* last time server changed data */
 	s32			lock_count;	/* file lock count (0=UNLK -1=WRLCK +ve=#RDLCK */
 };
 
diff --git a/fs/afs/afs_fs.h b/fs/afs/afs_fs.h
index d47b6d01e4c0..ddfa88a7a9c0 100644
--- a/fs/afs/afs_fs.h
+++ b/fs/afs/afs_fs.h
@@ -31,10 +31,12 @@ enum AFS_FS_Operations {
 	FSGETVOLUMEINFO		= 148,	/* AFS Get information about a volume */
 	FSGETVOLUMESTATUS	= 149,	/* AFS Get volume status information */
 	FSGETROOTVOLUME		= 151,	/* AFS Get root volume name */
+	FSBULKSTATUS		= 155,	/* AFS Fetch multiple file statuses */
 	FSSETLOCK		= 156,	/* AFS Request a file lock */
 	FSEXTENDLOCK		= 157,	/* AFS Extend a file lock */
 	FSRELEASELOCK		= 158,	/* AFS Release a file lock */
 	FSLOOKUP		= 161,	/* AFS lookup file in directory */
+	FSINLINEBULKSTATUS	= 65536, /* AFS Fetch multiple file statuses with inline errors */
 	FSFETCHDATA64		= 65537, /* AFS Fetch file data */
 	FSSTOREDATA64		= 65538, /* AFS Store file data */
 	FSGIVEUPALLCALLBACKS	= 65539, /* AFS Give up all outstanding callbacks on a server */
diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index bf082c719645..6049ca837498 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -187,7 +187,7 @@ static void afs_break_one_callback(struct afs_server *server,
  * allow the fileserver to break callback promises
  */
 void afs_break_callbacks(struct afs_server *server, size_t count,
-			 struct afs_callback callbacks[])
+			 struct afs_callback_break *callbacks)
 {
 	_enter("%p,%zu,", server, count);
 
@@ -199,9 +199,9 @@ void afs_break_callbacks(struct afs_server *server, size_t count,
 		       callbacks->fid.vid,
 		       callbacks->fid.vnode,
 		       callbacks->fid.unique,
-		       callbacks->version,
-		       callbacks->expiry,
-		       callbacks->type
+		       callbacks->cb.version,
+		       callbacks->cb.expiry,
+		       callbacks->cb.type
 		       );
 		afs_break_one_callback(server, &callbacks->fid);
 	}
diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index 83ff283979a4..fa07f83e9f29 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -178,8 +178,8 @@ static void SRXAFSCB_CallBack(struct work_struct *work)
  */
 static int afs_deliver_cb_callback(struct afs_call *call)
 {
+	struct afs_callback_break *cb;
 	struct sockaddr_rxrpc srx;
-	struct afs_callback *cb;
 	struct afs_server *server;
 	__be32 *bp;
 	int ret, loop;
@@ -218,7 +218,7 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 
 		_debug("unmarshall FID array");
 		call->request = kcalloc(call->count,
-					sizeof(struct afs_callback),
+					sizeof(struct afs_callback_break),
 					GFP_KERNEL);
 		if (!call->request)
 			return -ENOMEM;
@@ -229,7 +229,7 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 			cb->fid.vid	= ntohl(*bp++);
 			cb->fid.vnode	= ntohl(*bp++);
 			cb->fid.unique	= ntohl(*bp++);
-			cb->type	= AFSCM_CB_UNTYPED;
+			cb->cb.type	= AFSCM_CB_UNTYPED;
 		}
 
 		call->offset = 0;
@@ -260,9 +260,9 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 		cb = call->request;
 		bp = call->buffer;
 		for (loop = call->count2; loop > 0; loop--, cb++) {
-			cb->version	= ntohl(*bp++);
-			cb->expiry	= ntohl(*bp++);
-			cb->type	= ntohl(*bp++);
+			cb->cb.version	= ntohl(*bp++);
+			cb->cb.expiry	= ntohl(*bp++);
+			cb->cb.type	= ntohl(*bp++);
 		}
 
 		call->offset = 0;
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index ba2b458b36d1..63f7b37e1e71 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -29,8 +29,10 @@ static int afs_readdir(struct file *file, struct dir_context *ctx);
 static int afs_d_revalidate(struct dentry *dentry, unsigned int flags);
 static int afs_d_delete(const struct dentry *dentry);
 static void afs_d_release(struct dentry *dentry);
-static int afs_lookup_filldir(struct dir_context *ctx, const char *name, int nlen,
+static int afs_lookup_one_filldir(struct dir_context *ctx, const char *name, int nlen,
 				  loff_t fpos, u64 ino, unsigned dtype);
+static int afs_lookup_filldir(struct dir_context *ctx, const char *name, int nlen,
+			      loff_t fpos, u64 ino, unsigned dtype);
 static int afs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 		      bool excl);
 static int afs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode);
@@ -134,11 +136,22 @@ struct afs_dir_page {
 	union afs_dir_block blocks[PAGE_SIZE / sizeof(union afs_dir_block)];
 };
 
+struct afs_lookup_one_cookie {
+	struct dir_context	ctx;
+	struct qstr		name;
+	bool			found;
+	struct afs_fid		fid;
+};
+
 struct afs_lookup_cookie {
-	struct dir_context ctx;
-	struct afs_fid	fid;
-	struct qstr name;
-	int		found;
+	struct dir_context	ctx;
+	struct qstr		name;
+	bool			found;
+	bool			one_only;
+	unsigned short		nr_fids;
+	struct afs_file_status	*statuses;
+	struct afs_callback	*callbacks;
+	struct afs_fid		fids[50];
 };
 
 /*
@@ -330,7 +343,8 @@ static int afs_dir_iterate_block(struct dir_context *ctx,
 		/* found the next entry */
 		if (!dir_emit(ctx, dire->u.name, nlen,
 			      ntohl(dire->u.vnode),
-			      ctx->actor == afs_lookup_filldir ?
+			      (ctx->actor == afs_lookup_filldir ||
+			       ctx->actor == afs_lookup_one_filldir)?
 			      ntohl(dire->u.unique) : DT_UNKNOWN)) {
 			_leave(" = 0 [full]");
 			return 0;
@@ -414,15 +428,15 @@ static int afs_readdir(struct file *file, struct dir_context *ctx)
 }
 
 /*
- * search the directory for a name
+ * Search the directory for a single name
  * - if afs_dir_iterate_block() spots this function, it'll pass the FID
  *   uniquifier through dtype
  */
-static int afs_lookup_filldir(struct dir_context *ctx, const char *name,
-			      int nlen, loff_t fpos, u64 ino, unsigned dtype)
+static int afs_lookup_one_filldir(struct dir_context *ctx, const char *name,
+				  int nlen, loff_t fpos, u64 ino, unsigned dtype)
 {
-	struct afs_lookup_cookie *cookie =
-		container_of(ctx, struct afs_lookup_cookie, ctx);
+	struct afs_lookup_one_cookie *cookie =
+		container_of(ctx, struct afs_lookup_one_cookie, ctx);
 
 	_enter("{%s,%u},%s,%u,,%llu,%u",
 	       cookie->name.name, cookie->name.len, name, nlen,
@@ -447,15 +461,15 @@ static int afs_lookup_filldir(struct dir_context *ctx, const char *name,
 }
 
 /*
- * do a lookup in a directory
+ * Do a lookup of a single name in a directory
  * - just returns the FID the dentry name maps to if found
  */
-static int afs_do_lookup(struct inode *dir, struct dentry *dentry,
-			 struct afs_fid *fid, struct key *key)
+static int afs_do_lookup_one(struct inode *dir, struct dentry *dentry,
+			     struct afs_fid *fid, struct key *key)
 {
 	struct afs_super_info *as = dir->i_sb->s_fs_info;
-	struct afs_lookup_cookie cookie = {
-		.ctx.actor = afs_lookup_filldir,
+	struct afs_lookup_one_cookie cookie = {
+		.ctx.actor = afs_lookup_one_filldir,
 		.name = dentry->d_name,
 		.fid.vid = as->volume->vid
 	};
@@ -481,6 +495,212 @@ static int afs_do_lookup(struct inode *dir, struct dentry *dentry,
 	return 0;
 }
 
+/*
+ * search the directory for a name
+ * - if afs_dir_iterate_block() spots this function, it'll pass the FID
+ *   uniquifier through dtype
+ */
+static int afs_lookup_filldir(struct dir_context *ctx, const char *name,
+			      int nlen, loff_t fpos, u64 ino, unsigned dtype)
+{
+	struct afs_lookup_cookie *cookie =
+		container_of(ctx, struct afs_lookup_cookie, ctx);
+	int ret;
+
+	_enter("{%s,%u},%s,%u,,%llu,%u",
+	       cookie->name.name, cookie->name.len, name, nlen,
+	       (unsigned long long) ino, dtype);
+
+	/* insanity checks first */
+	BUILD_BUG_ON(sizeof(union afs_dir_block) != 2048);
+	BUILD_BUG_ON(sizeof(union afs_dirent) != 32);
+
+	if (cookie->found) {
+		if (cookie->nr_fids < 50) {
+			cookie->fids[cookie->nr_fids].vnode	= ino;
+			cookie->fids[cookie->nr_fids].unique	= dtype;
+			cookie->nr_fids++;
+		}
+	} else if (cookie->name.len == nlen &&
+		   memcmp(cookie->name.name, name, nlen) == 0) {
+		cookie->fids[0].vnode	= ino;
+		cookie->fids[0].unique	= dtype;
+		cookie->found = 1;
+		if (cookie->one_only)
+			return -1;
+	}
+
+	ret = cookie->nr_fids >= 50 ? -1 : 0;
+	_leave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * Do a lookup in a directory.  We make use of bulk lookup to query a slew of
+ * files in one go and create inodes for them.  The inode of the file we were
+ * asked for is returned.
+ */
+static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry,
+				   struct key *key)
+{
+	struct afs_lookup_cookie *cookie;
+	struct afs_cb_interest *cbi = NULL;
+	struct afs_super_info *as = dir->i_sb->s_fs_info;
+	struct afs_iget_data data;
+	struct afs_fs_cursor fc;
+	struct afs_vnode *dvnode = AFS_FS_I(dir);
+	struct inode *inode = NULL;
+	int ret, i;
+
+	_enter("{%lu},%p{%pd},", dir->i_ino, dentry, dentry);
+
+	cookie = kzalloc(sizeof(struct afs_lookup_cookie), GFP_KERNEL);
+	if (!cookie)
+		return ERR_PTR(-ENOMEM);
+
+	cookie->ctx.actor = afs_lookup_filldir;
+	cookie->name = dentry->d_name;
+	cookie->nr_fids = 1; /* slot 0 is saved for the fid we actually want */
+
+	read_seqlock_excl(&dvnode->cb_lock);
+	if (dvnode->cb_interest &&
+	    dvnode->cb_interest->server &&
+	    test_bit(AFS_SERVER_FL_NO_IBULK, &dvnode->cb_interest->server->flags))
+		cookie->one_only = true;
+	read_sequnlock_excl(&dvnode->cb_lock);
+
+	for (i = 0; i < 50; i++)
+		cookie->fids[i].vid = as->volume->vid;
+
+	/* search the directory */
+	ret = afs_dir_iterate(dir, &cookie->ctx, key);
+	if (ret < 0) {
+		inode = ERR_PTR(ret);
+		goto out;
+	}
+
+	inode = ERR_PTR(-ENOENT);
+	if (!cookie->found)
+		goto out;
+
+	/* Check to see if we already have an inode for the primary fid. */
+	data.volume = dvnode->volume;
+	data.fid = cookie->fids[0];
+	inode = ilookup5(dir->i_sb, cookie->fids[0].vnode, afs_iget5_test, &data);
+	if (inode)
+		goto out;
+	
+	/* Need space for examining all the selected files */
+	inode = ERR_PTR(-ENOMEM);
+	cookie->statuses = kcalloc(cookie->nr_fids, sizeof(struct afs_file_status),
+				   GFP_KERNEL);
+	if (!cookie->statuses)
+		goto out;
+
+	cookie->callbacks = kcalloc(cookie->nr_fids, sizeof(struct afs_callback),
+				    GFP_KERNEL);
+	if (!cookie->callbacks)
+		goto out_s;
+
+	/* Try FS.InlineBulkStatus first.  Abort codes for the individual
+	 * lookups contained therein are stored in the reply without aborting
+	 * the whole operation.
+	 */
+	if (cookie->one_only)
+		goto no_inline_bulk_status;
+
+	inode = ERR_PTR(-ERESTARTSYS);
+	if (afs_begin_vnode_operation(&fc, dvnode, key)) {
+		while (afs_select_fileserver(&fc)) {
+			if (test_bit(AFS_SERVER_FL_NO_IBULK,
+				      &fc.cbi->server->flags)) {
+				fc.ac.abort_code = RX_INVALID_OPERATION;
+				fc.ac.error = -ECONNABORTED;
+				break;
+			}
+			afs_fs_inline_bulk_status(&fc,
+						  afs_v2net(dvnode),
+						  cookie->fids,
+						  cookie->statuses,
+						  cookie->callbacks,
+						  cookie->nr_fids, NULL);
+		}
+
+		if (fc.ac.error == 0)
+			cbi = afs_get_cb_interest(fc.cbi);
+		if (fc.ac.abort_code == RX_INVALID_OPERATION)
+			set_bit(AFS_SERVER_FL_NO_IBULK, &fc.cbi->server->flags);
+		inode = ERR_PTR(afs_end_vnode_operation(&fc));
+	}
+
+	if (!IS_ERR(inode))
+		goto success;
+	if (fc.ac.abort_code != RX_INVALID_OPERATION)
+		goto out_c;
+
+no_inline_bulk_status:
+	/* We could try FS.BulkStatus next, but this aborts the entire op if
+	 * any of the lookups fails - so, for the moment, revert to
+	 * FS.FetchStatus for just the primary fid.
+	 */
+	cookie->nr_fids = 1;
+	inode = ERR_PTR(-ERESTARTSYS);
+	if (afs_begin_vnode_operation(&fc, dvnode, key)) {
+		while (afs_select_fileserver(&fc)) {
+			afs_fs_fetch_status(&fc,
+					    afs_v2net(dvnode),
+					    cookie->fids,
+					    cookie->statuses,
+					    cookie->callbacks,
+					    NULL);
+		}
+
+		if (fc.ac.error == 0)
+			cbi = afs_get_cb_interest(fc.cbi);
+		inode = ERR_PTR(afs_end_vnode_operation(&fc));
+	}
+
+	if (IS_ERR(inode))
+		goto out_c;
+
+	for (i = 0; i < cookie->nr_fids; i++)
+		cookie->statuses[i].abort_code = 0;
+	
+success:
+	/* Turn all the files into inodes and save the first one - which is the
+	 * one we actually want.
+	 */
+	if (cookie->statuses[0].abort_code != 0)
+		inode = ERR_PTR(afs_abort_to_error(cookie->statuses[0].abort_code));
+
+	for (i = 0; i < cookie->nr_fids; i++) {
+		struct inode *ti;
+
+		if (cookie->statuses[i].abort_code != 0)
+			continue;
+
+		ti = afs_iget(dir->i_sb, key, &cookie->fids[i],
+			      &cookie->statuses[i],
+			      &cookie->callbacks[i],
+			      cbi);
+		if (i == 0) {
+			inode = ti;
+		} else {
+			if (!IS_ERR(ti))
+				iput(ti);
+		}
+	}
+
+out_c:
+	afs_put_cb_interest(afs_v2net(dvnode), cbi);
+	kfree(cookie->callbacks);
+out_s:
+	kfree(cookie->statuses);
+out:
+	kfree(cookie);
+	return inode;
+}
+
 /*
  * Probe to see if a cell may exist.  This prevents positive dentries from
  * being created unnecessarily.
@@ -516,8 +736,7 @@ static int afs_probe_cell_name(struct dentry *dentry)
  * Try to auto mount the mountpoint with pseudo directory, if the autocell
  * operation is setted.
  */
-static struct inode *afs_try_auto_mntpt(struct dentry *dentry,
-					struct inode *dir, struct afs_fid *fid)
+static struct inode *afs_try_auto_mntpt(struct dentry *dentry, struct inode *dir)
 {
 	struct afs_vnode *vnode = AFS_FS_I(dir);
 	struct inode *inode;
@@ -539,7 +758,6 @@ static struct inode *afs_try_auto_mntpt(struct dentry *dentry,
 		goto out;
 	}
 
-	*fid = AFS_FS_I(inode)->fid;
 	_leave("= %p", inode);
 	return inode;
 
@@ -554,16 +772,13 @@ static struct inode *afs_try_auto_mntpt(struct dentry *dentry,
 static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 				 unsigned int flags)
 {
-	struct afs_vnode *vnode;
-	struct afs_fid fid;
+	struct afs_vnode *dvnode = AFS_FS_I(dir);
 	struct inode *inode;
 	struct key *key;
 	int ret;
 
-	vnode = AFS_FS_I(dir);
-
 	_enter("{%x:%u},%p{%pd},",
-	       vnode->fid.vid, vnode->fid.vnode, dentry, dentry);
+	       dvnode->fid.vid, dvnode->fid.vnode, dentry, dentry);
 
 	ASSERTCMP(d_inode(dentry), ==, NULL);
 
@@ -572,28 +787,29 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 		return ERR_PTR(-ENAMETOOLONG);
 	}
 
-	if (test_bit(AFS_VNODE_DELETED, &vnode->flags)) {
+	if (test_bit(AFS_VNODE_DELETED, &dvnode->flags)) {
 		_leave(" = -ESTALE");
 		return ERR_PTR(-ESTALE);
 	}
 
-	key = afs_request_key(vnode->volume->cell);
+	key = afs_request_key(dvnode->volume->cell);
 	if (IS_ERR(key)) {
 		_leave(" = %ld [key]", PTR_ERR(key));
 		return ERR_CAST(key);
 	}
 
-	ret = afs_validate(vnode, key);
+	ret = afs_validate(dvnode, key);
 	if (ret < 0) {
 		key_put(key);
 		_leave(" = %d [val]", ret);
 		return ERR_PTR(ret);
 	}
 
-	ret = afs_do_lookup(dir, dentry, &fid, key);
-	if (ret < 0) {
+	inode = afs_do_lookup(dir, dentry, key);
+	if (IS_ERR(inode)) {
+		ret = PTR_ERR(inode);
 		if (ret == -ENOENT) {
-			inode = afs_try_auto_mntpt(dentry, dir, &fid);
+			inode = afs_try_auto_mntpt(dentry, dir);
 			if (!IS_ERR(inode)) {
 				key_put(key);
 				goto success;
@@ -611,10 +827,9 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 		_leave(" = %d [do]", ret);
 		return ERR_PTR(ret);
 	}
-	dentry->d_fsdata = (void *)(unsigned long) vnode->status.data_version;
+	dentry->d_fsdata = (void *)(unsigned long)dvnode->status.data_version;
 
 	/* instantiate the dentry */
-	inode = afs_iget(dir->i_sb, key, &fid, NULL, NULL, NULL);
 	key_put(key);
 	if (IS_ERR(inode)) {
 		_leave(" = %ld", PTR_ERR(inode));
@@ -623,9 +838,7 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 
 success:
 	d_add(dentry, inode);
-	_leave(" = 0 { vn=%u u=%u } -> { ino=%lu v=%u }",
-	       fid.vnode,
-	       fid.unique,
+	_leave(" = 0 { ino=%lu v=%u }",
 	       d_inode(dentry)->i_ino,
 	       d_inode(dentry)->i_generation);
 
@@ -639,7 +852,6 @@ static struct dentry *afs_dynroot_lookup(struct inode *dir, struct dentry *dentr
 					 unsigned int flags)
 {
 	struct afs_vnode *vnode;
-	struct afs_fid fid;
 	struct inode *inode;
 	int ret;
 
@@ -654,7 +866,7 @@ static struct dentry *afs_dynroot_lookup(struct inode *dir, struct dentry *dentr
 		return ERR_PTR(-ENAMETOOLONG);
 	}
 
-	inode = afs_try_auto_mntpt(dentry, dir, &fid);
+	inode = afs_try_auto_mntpt(dentry, dir);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
 		if (ret == -ENOENT) {
@@ -736,7 +948,7 @@ static int afs_d_revalidate(struct dentry *dentry, unsigned int flags)
 	_debug("dir modified");
 
 	/* search the directory for this vnode */
-	ret = afs_do_lookup(&dir->vfs_inode, dentry, &fid, key);
+	ret = afs_do_lookup_one(&dir->vfs_inode, dentry, &fid, key);
 	switch (ret) {
 	case 0:
 		/* the filename maps to something */
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 88ec38c2d83c..75554ee98d02 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -94,7 +94,7 @@ static void xdr_decode_AFSFetchStatus(const __be32 **_bp,
 	data_version |= (u64) ntohl(*bp++) << 32;
 	EXTRACT(status->lock_count);
 	size |= (u64) ntohl(*bp++) << 32;
-	bp++; /* spare 4 */
+	EXTRACT(status->abort_code); /* spare 4 */
 	*_bp = bp;
 
 	if (size != status->size) {
@@ -274,7 +274,7 @@ static void xdr_decode_AFSFetchVolumeStatus(const __be32 **_bp,
 /*
  * deliver reply data to an FS.FetchStatus
  */
-static int afs_deliver_fs_fetch_status(struct afs_call *call)
+static int afs_deliver_fs_fetch_status_vnode(struct afs_call *call)
 {
 	struct afs_vnode *vnode = call->reply[0];
 	const __be32 *bp;
@@ -300,10 +300,10 @@ static int afs_deliver_fs_fetch_status(struct afs_call *call)
 /*
  * FS.FetchStatus operation type
  */
-static const struct afs_call_type afs_RXFSFetchStatus = {
-	.name		= "FS.FetchStatus",
+static const struct afs_call_type afs_RXFSFetchStatus_vnode = {
+	.name		= "FS.FetchStatus(vnode)",
 	.op		= afs_FS_FetchStatus,
-	.deliver	= afs_deliver_fs_fetch_status,
+	.deliver	= afs_deliver_fs_fetch_status_vnode,
 	.destructor	= afs_flat_call_destructor,
 };
 
@@ -320,7 +320,8 @@ int afs_fs_fetch_file_status(struct afs_fs_cursor *fc, struct afs_volsync *volsy
 	_enter(",%x,{%x:%u},,",
 	       key_serial(fc->key), vnode->fid.vid, vnode->fid.vnode);
 
-	call = afs_alloc_flat_call(net, &afs_RXFSFetchStatus, 16, (21 + 3 + 6) * 4);
+	call = afs_alloc_flat_call(net, &afs_RXFSFetchStatus_vnode,
+				   16, (21 + 3 + 6) * 4);
 	if (!call) {
 		fc->ac.error = -ENOMEM;
 		return -ENOMEM;
@@ -1947,3 +1948,262 @@ int afs_fs_get_capabilities(struct afs_net *net,
 	trace_afs_make_fs_call(call, NULL);
 	return afs_make_call(ac, call, GFP_NOFS, false);
 }
+
+/*
+ * Deliver reply data to an FS.FetchStatus with no vnode.
+ */
+static int afs_deliver_fs_fetch_status(struct afs_call *call)
+{
+	struct afs_file_status *status = call->reply[1];
+	struct afs_callback *callback = call->reply[2];
+	struct afs_volsync *volsync = call->reply[3];
+	struct afs_vnode *vnode = call->reply[0];
+	const __be32 *bp;
+	int ret;
+
+	ret = afs_transfer_reply(call);
+	if (ret < 0)
+		return ret;
+
+	_enter("{%x:%u}", vnode->fid.vid, vnode->fid.vnode);
+
+	/* unmarshall the reply once we've received all of it */
+	bp = call->buffer;
+	xdr_decode_AFSFetchStatus(&bp, status, vnode, NULL);
+	callback[call->count].version	= ntohl(bp[0]);
+	callback[call->count].expiry	= ntohl(bp[1]);
+	callback[call->count].type	= ntohl(bp[2]);
+	if (vnode)
+		xdr_decode_AFSCallBack(call, vnode, &bp);
+	else
+		bp += 3;
+	if (volsync)
+		xdr_decode_AFSVolSync(&bp, volsync);
+
+	_leave(" = 0 [done]");
+	return 0;
+}
+
+/*
+ * FS.FetchStatus operation type
+ */
+static const struct afs_call_type afs_RXFSFetchStatus = {
+	.name		= "FS.FetchStatus",
+	.op		= afs_FS_FetchStatus,
+	.deliver	= afs_deliver_fs_fetch_status,
+	.destructor	= afs_flat_call_destructor,
+};
+
+/*
+ * Fetch the status information for a fid without needing a vnode handle.
+ */
+int afs_fs_fetch_status(struct afs_fs_cursor *fc,
+			struct afs_net *net,
+			struct afs_fid *fid,
+			struct afs_file_status *status,
+			struct afs_callback *callback,
+			struct afs_volsync *volsync)
+{
+	struct afs_call *call;
+	__be32 *bp;
+
+	_enter(",%x,{%x:%u},,",
+	       key_serial(fc->key), fid->vid, fid->vnode);
+
+	call = afs_alloc_flat_call(net, &afs_RXFSFetchStatus, 16, (21 + 3 + 6) * 4);
+	if (!call) {
+		fc->ac.error = -ENOMEM;
+		return -ENOMEM;
+	}
+
+	call->key = fc->key;
+	call->reply[0] = NULL; /* vnode for fid[0] */
+	call->reply[1] = status;
+	call->reply[2] = callback;
+	call->reply[3] = volsync;
+
+	/* marshall the parameters */
+	bp = call->request;
+	bp[0] = htonl(FSFETCHSTATUS);
+	bp[1] = htonl(fid->vid);
+	bp[2] = htonl(fid->vnode);
+	bp[3] = htonl(fid->unique);
+
+	call->cb_break = fc->cb_break;
+	afs_use_fs_server(call, fc->cbi);
+	trace_afs_make_fs_call(call, fid);
+	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+}
+
+/*
+ * Deliver reply data to an FS.InlineBulkStatus call
+ */
+static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
+{
+	struct afs_file_status *statuses;
+	struct afs_callback *callbacks;
+	struct afs_vnode *vnode = call->reply[0];
+	const __be32 *bp;
+	u32 tmp;
+	int ret;
+
+	_enter("{%u}", call->unmarshall);
+
+	switch (call->unmarshall) {
+	case 0:
+		call->offset = 0;
+		call->unmarshall++;
+
+		/* Extract the file status count and array in two steps */
+	case 1:
+		_debug("extract status count");
+		ret = afs_extract_data(call, &call->tmp, 4, true);
+		if (ret < 0)
+			return ret;
+
+		tmp = ntohl(call->tmp);
+		_debug("status count: %u/%u", tmp, call->count2);
+		if (tmp != call->count2)
+			return -EBADMSG;
+
+		call->count = 0;
+		call->unmarshall++;
+	more_counts:
+		call->offset = 0;
+
+	case 2:
+		_debug("extract status array %u", call->count);
+		ret = afs_extract_data(call, call->buffer, 21 * 4, true);
+		if (ret < 0)
+			return ret;
+
+		bp = call->buffer;
+		statuses = call->reply[1];
+		xdr_decode_AFSFetchStatus(&bp, &statuses[call->count],
+					  call->count == 0 ? vnode : NULL,
+					  NULL);
+
+		call->count++;
+		if (call->count < call->count2)
+			goto more_counts;
+
+		call->count = 0;
+		call->unmarshall++;
+		call->offset = 0;
+
+		/* Extract the callback count and array in two steps */
+	case 3:
+		_debug("extract CB count");
+		ret = afs_extract_data(call, &call->tmp, 4, true);
+		if (ret < 0)
+			return ret;
+
+		tmp = ntohl(call->tmp);
+		_debug("CB count: %u", tmp);
+		if (tmp != call->count2)
+			return -EBADMSG;
+		call->count = 0;
+		call->unmarshall++;
+	more_cbs:
+		call->offset = 0;
+
+	case 4:
+		_debug("extract CB array");
+		ret = afs_extract_data(call, call->buffer, 3 * 4, true);
+		if (ret < 0)
+			return ret;
+
+		_debug("unmarshall CB array");
+		bp = call->buffer;
+		callbacks = call->reply[2];
+		callbacks[call->count].version	= ntohl(bp[0]);
+		callbacks[call->count].expiry	= ntohl(bp[1]);
+		callbacks[call->count].type	= ntohl(bp[2]);
+		statuses = call->reply[1];
+		if (call->count == 0 && vnode && statuses[0].abort_code == 0)
+			xdr_decode_AFSCallBack(call, vnode, &bp);
+		call->count++;
+		if (call->count < call->count2)
+			goto more_cbs;
+
+		call->offset = 0;
+		call->unmarshall++;
+
+	case 5:
+		ret = afs_extract_data(call, call->buffer, 6 * 4, false);
+		if (ret < 0)
+			return ret;
+
+		bp = call->buffer;
+		if (call->reply[3])
+			xdr_decode_AFSVolSync(&bp, call->reply[3]);
+
+		call->offset = 0;
+		call->unmarshall++;
+
+	case 6:
+		break;
+	}
+
+	_leave(" = 0 [done]");
+	return 0;
+}
+
+/*
+ * FS.InlineBulkStatus operation type
+ */
+static const struct afs_call_type afs_RXFSInlineBulkStatus = {
+	.name		= "FS.InlineBulkStatus",
+	.op		= afs_FS_InlineBulkStatus,
+	.deliver	= afs_deliver_fs_inline_bulk_status,
+	.destructor	= afs_flat_call_destructor,
+};
+
+/*
+ * Fetch the status information for up to 50 files
+ */
+int afs_fs_inline_bulk_status(struct afs_fs_cursor *fc,
+			      struct afs_net *net,
+			      struct afs_fid *fids,
+			      struct afs_file_status *statuses,
+			      struct afs_callback *callbacks,
+			      unsigned int nr_fids,
+			      struct afs_volsync *volsync)
+{
+	struct afs_call *call;
+	__be32 *bp;
+	int i;
+
+	_enter(",%x,{%x:%u},%u",
+	       key_serial(fc->key), fids[0].vid, fids[1].vnode, nr_fids);
+
+	call = afs_alloc_flat_call(net, &afs_RXFSInlineBulkStatus,
+				   (2 + nr_fids * 3) * 4,
+				   21 * 4);
+	if (!call) {
+		fc->ac.error = -ENOMEM;
+		return -ENOMEM;
+	}
+
+	call->key = fc->key;
+	call->reply[0] = NULL; /* vnode for fid[0] */
+	call->reply[1] = statuses;
+	call->reply[2] = callbacks;
+	call->reply[3] = volsync;
+	call->count2 = nr_fids;
+
+	/* marshall the parameters */
+	bp = call->request;
+	*bp++ = htonl(FSINLINEBULKSTATUS);
+	*bp++ = htonl(nr_fids);
+	for (i = 0; i < nr_fids; i++) {
+		*bp++ = htonl(fids[i].vid);
+		*bp++ = htonl(fids[i].vnode);
+		*bp++ = htonl(fids[i].unique);
+	}
+
+	call->cb_break = fc->cb_break;
+	afs_use_fs_server(call, fc->cbi);
+	trace_afs_make_fs_call(call, &fids[0]);
+	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+}
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 135192b7dc04..55b07e818400 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -363,6 +363,7 @@ struct afs_server {
 #define AFS_SERVER_FL_UPDATING	4
 #define AFS_SERVER_FL_PROBED	5		/* The fileserver has been probed */
 #define AFS_SERVER_FL_PROBING	6		/* Fileserver is being probed */
+#define AFS_SERVER_FL_NO_IBULK	7		/* Fileserver doesn't support FS.InlineBulkStatus */
 	atomic_t		usage;
 	u32			addr_version;	/* Address list version */
 
@@ -611,7 +612,7 @@ extern struct fscache_cookie_def afs_vnode_cache_index_def;
  */
 extern void afs_init_callback_state(struct afs_server *);
 extern void afs_break_callback(struct afs_vnode *);
-extern void afs_break_callbacks(struct afs_server *, size_t,struct afs_callback[]);
+extern void afs_break_callbacks(struct afs_server *, size_t, struct afs_callback_break*);
 
 extern int afs_register_server_cb_interest(struct afs_vnode *, struct afs_server_entry *);
 extern void afs_put_cb_interest(struct afs_net *, struct afs_cb_interest *);
@@ -702,6 +703,13 @@ extern int afs_fs_give_up_all_callbacks(struct afs_net *, struct afs_server *,
 					struct afs_addr_cursor *, struct key *);
 extern int afs_fs_get_capabilities(struct afs_net *, struct afs_server *,
 				   struct afs_addr_cursor *, struct key *);
+extern int afs_fs_inline_bulk_status(struct afs_fs_cursor *, struct afs_net *,
+				     struct afs_fid *, struct afs_file_status *,
+				     struct afs_callback *, unsigned int,
+				     struct afs_volsync *);
+extern int afs_fs_fetch_status(struct afs_fs_cursor *, struct afs_net *,
+			       struct afs_fid *, struct afs_file_status *,
+			       struct afs_callback *, struct afs_volsync *);
 
 /*
  * inode.c
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 63815f66b274..0419b7e1e968 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -49,6 +49,7 @@ enum afs_fs_operation {
 	afs_FS_ExtendLock		= 157,	/* AFS Extend a file lock */
 	afs_FS_ReleaseLock		= 158,	/* AFS Release a file lock */
 	afs_FS_Lookup			= 161,	/* AFS lookup file in directory */
+	afs_FS_InlineBulkStatus		= 65536, /* AFS Fetch multiple file statuses with errors */
 	afs_FS_FetchData64		= 65537, /* AFS Fetch file data */
 	afs_FS_StoreData64		= 65538, /* AFS Store file data */
 	afs_FS_GiveUpAllCallBacks	= 65539, /* AFS Give up all our callbacks on a server */
@@ -93,6 +94,7 @@ enum afs_vl_operation {
 	EM(afs_FS_ExtendLock,			"FS.ExtendLock") \
 	EM(afs_FS_ReleaseLock,			"FS.ReleaseLock") \
 	EM(afs_FS_Lookup,			"FS.Lookup") \
+	EM(afs_FS_InlineBulkStatus,		"FS.InlineBulkStatus") \
 	EM(afs_FS_FetchData64,			"FS.FetchData64") \
 	EM(afs_FS_StoreData64,			"FS.StoreData64") \
 	EM(afs_FS_GiveUpAllCallBacks,		"FS.GiveUpAllCallBacks") \
