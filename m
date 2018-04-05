Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753420AbeDEUgE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 16:36:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752424AbeDEUap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 16:30:45 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 11/20] afs: Rearrange status mapping
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Apr 2018 21:30:43 +0100
Message-ID: <152296024317.31027.302795624755677382.stgit@warthog.procyon.org.uk>
In-Reply-To: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
References: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rearrange the AFSFetchStatus to inode attribute mapping code in a number of
ways:

 (1) Use an XDR structure rather than a series of incremented pointer
     accesses when decoding an AFSFetchStatus object.  This allows
     out-of-order decode.

 (2) Don't store the if_version value but rather just check it and abort if
     it's not something we can handle.

 (3) Store the owner and group in the status record as raw values rather
     than converting them to kuid/kgid.  Do that when they're mapped into
     i_uid/i_gid.

 (4) Validate the type and abort code up front and abort if they're wrong.

 (5) Split the inode attribute setting out into its own function from the
     XDR decode of an AFSFetchStatus object.  This allows it to be called
     from elsewhere too.

 (6) Differentiate changes to data from changes to metadata.

 (7) Use the split-out attribute mapping function from afs_iget().

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/afs.h      |    6 -
 fs/afs/fsclient.c |  270 ++++++++++++++++++++++++++++++++---------------------
 fs/afs/inode.c    |   23 +----
 fs/afs/internal.h |    6 +
 fs/afs/xdr_fs.h   |   40 ++++++++
 5 files changed, 216 insertions(+), 129 deletions(-)
 create mode 100644 fs/afs/xdr_fs.h

diff --git a/fs/afs/afs.h b/fs/afs/afs.h
index a670bca6d3ba..b4ff1f7ae4ab 100644
--- a/fs/afs/afs.h
+++ b/fs/afs/afs.h
@@ -131,15 +131,13 @@ struct afs_file_status {
 	afs_dataversion_t	data_version;	/* current data version */
 	time_t			mtime_client;	/* last time client changed data */
 	time_t			mtime_server;	/* last time server changed data */
-	unsigned		if_version;	/* interface version */
-#define AFS_FSTATUS_VERSION	1
 	unsigned		abort_code;	/* Abort if bulk-fetching this failed */
 
 	afs_file_type_t		type;		/* file type */
 	unsigned		nlink;		/* link count */
 	u32			author;		/* author ID */
-	kuid_t			owner;		/* owner ID */
-	kgid_t			group;		/* group ID */
+	u32			owner;		/* owner ID */
+	u32			group;		/* group ID */
 	afs_access_t		caller_access;	/* access rights for authenticated caller */
 	afs_access_t		anon_access;	/* access rights for unauthenticated caller */
 	umode_t			mode;		/* UNIX mode */
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 015bbbba0858..ff87fc6bb27f 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -16,6 +16,7 @@
 #include <linux/iversion.h>
 #include "internal.h"
 #include "afs_fs.h"
+#include "xdr_fs.h"
 
 static const struct afs_fid afs_zero_fid;
 
@@ -64,120 +65,160 @@ static void xdr_dump_bad(const __be32 *bp)
 }
 
 /*
- * decode an AFSFetchStatus block
+ * Update the core inode struct from a returned status record.
  */
-static void xdr_decode_AFSFetchStatus(const __be32 **_bp,
-				      struct afs_file_status *status,
-				      struct afs_vnode *vnode,
-				      const afs_dataversion_t *expected_version,
-				      afs_dataversion_t *_version)
+void afs_update_inode_from_status(struct afs_vnode *vnode,
+				  struct afs_file_status *status,
+				  const afs_dataversion_t *expected_version,
+				  u8 flags)
 {
-	const __be32 *bp = *_bp;
+	struct timespec t;
 	umode_t mode;
+
+	t.tv_sec = status->mtime_client;
+	t.tv_nsec = 0;
+	vnode->vfs_inode.i_ctime = t;
+	vnode->vfs_inode.i_mtime = t;
+	vnode->vfs_inode.i_atime = t;
+
+	if (flags & (AFS_VNODE_META_CHANGED | AFS_VNODE_NOT_YET_SET)) {
+		vnode->vfs_inode.i_uid = make_kuid(&init_user_ns, status->owner);
+		vnode->vfs_inode.i_gid = make_kgid(&init_user_ns, status->group);
+		set_nlink(&vnode->vfs_inode, status->nlink);
+
+		mode = vnode->vfs_inode.i_mode;
+		mode &= ~S_IALLUGO;
+		mode |= status->mode;
+		barrier();
+		vnode->vfs_inode.i_mode = mode;
+	}
+
+	if (!(flags & AFS_VNODE_NOT_YET_SET)) {
+		if (expected_version &&
+		    *expected_version != status->data_version) {
+			_debug("vnode modified %llx on {%x:%u} [exp %llx]",
+			       (unsigned long long) status->data_version,
+			       vnode->fid.vid, vnode->fid.vnode,
+			       (unsigned long long) *expected_version);
+			set_bit(AFS_VNODE_DIR_MODIFIED, &vnode->flags);
+			set_bit(AFS_VNODE_ZAP_DATA, &vnode->flags);
+		}
+	}
+
+	if (flags & (AFS_VNODE_DATA_CHANGED | AFS_VNODE_NOT_YET_SET)) {
+		inode_set_iversion_raw(&vnode->vfs_inode, status->data_version);
+		i_size_write(&vnode->vfs_inode, status->size);
+	}
+}
+
+/*
+ * decode an AFSFetchStatus block
+ */
+static int xdr_decode_AFSFetchStatus(const __be32 **_bp,
+				     struct afs_file_status *status,
+				     struct afs_vnode *vnode,
+				     const afs_dataversion_t *expected_version,
+				     afs_dataversion_t *_version)
+{
+	const struct afs_xdr_AFSFetchStatus *xdr = (const void *)*_bp;
 	u64 data_version, size;
-	bool changed = false;
-	kuid_t owner;
-	kgid_t group;
+	u32 type, abort_code;
+	u8 flags = 0;
+	int ret;
 
 	if (vnode)
 		write_seqlock(&vnode->cb_lock);
 
-#define EXTRACT(DST)				\
-	do {					\
-		u32 x = ntohl(*bp++);		\
-		if (DST != x)			\
-			changed |= true;	\
-		DST = x;			\
-	} while (0)
-
-	status->if_version = ntohl(*bp++);
-	EXTRACT(status->type);
-	EXTRACT(status->nlink);
-	size = ntohl(*bp++);
-	data_version = ntohl(*bp++);
-	EXTRACT(status->author);
-	owner = make_kuid(&init_user_ns, ntohl(*bp++));
-	changed |= !uid_eq(owner, status->owner);
-	status->owner = owner;
-	EXTRACT(status->caller_access); /* call ticket dependent */
-	EXTRACT(status->anon_access);
-	EXTRACT(status->mode);
-	bp++; /* parent.vnode */
-	bp++; /* parent.unique */
-	bp++; /* seg size */
-	status->mtime_client = ntohl(*bp++);
-	status->mtime_server = ntohl(*bp++);
-	group = make_kgid(&init_user_ns, ntohl(*bp++));
-	changed |= !gid_eq(group, status->group);
-	status->group = group;
-	bp++; /* sync counter */
-	data_version |= (u64) ntohl(*bp++) << 32;
-	EXTRACT(status->lock_count);
-	size |= (u64) ntohl(*bp++) << 32;
-	EXTRACT(status->abort_code); /* spare 4 */
-	*_bp = bp;
+	if (xdr->if_version != htonl(AFS_FSTATUS_VERSION)) {
+		pr_warn("Unknown AFSFetchStatus version %u\n", ntohl(xdr->if_version));
+		goto bad;
+	}
 
-	switch (status->type) {
+	type = ntohl(xdr->type);
+	abort_code = ntohl(xdr->abort_code);
+	switch (type) {
 	case AFS_FTYPE_FILE:
 	case AFS_FTYPE_DIR:
 	case AFS_FTYPE_SYMLINK:
+		if (type != status->type &&
+		    vnode &&
+		    !test_bit(AFS_VNODE_UNSET, &vnode->flags)) {
+			pr_warning("Vnode %x:%x:%x changed type %u to %u\n",
+				   vnode->fid.vid,
+				   vnode->fid.vnode,
+				   vnode->fid.unique,
+				   status->type, type);
+			goto bad;
+		}
+		status->type = type;
 		break;
 	case AFS_FTYPE_INVALID:
-		if (status->abort_code != 0)
+		if (abort_code != 0) {
+			status->abort_code = abort_code;
 			goto out;
+		}
 		/* Fall through */
 	default:
-		xdr_dump_bad(bp - 2);
-		goto out;
+		goto bad;
 	}
 
+#define EXTRACT_M(FIELD)					\
+	do {							\
+		u32 x = ntohl(xdr->FIELD);			\
+		if (status->FIELD != x) {			\
+			flags |= AFS_VNODE_META_CHANGED;	\
+			status->FIELD = x;			\
+		}						\
+	} while (0)
+
+	EXTRACT_M(nlink);
+	EXTRACT_M(author);
+	EXTRACT_M(owner);
+	EXTRACT_M(caller_access); /* call ticket dependent */
+	EXTRACT_M(anon_access);
+	EXTRACT_M(mode);
+	EXTRACT_M(group);
+
+	status->mtime_client = ntohl(xdr->mtime_client);
+	status->mtime_server = ntohl(xdr->mtime_server);
+	status->lock_count   = ntohl(xdr->lock_count);
+
+	size  = (u64)ntohl(xdr->size_lo);
+	size |= (u64)ntohl(xdr->size_hi) << 32;
 	if (size != status->size) {
 		status->size = size;
-		changed |= true;
+		flags |= AFS_VNODE_DATA_CHANGED;
+	}
+
+	data_version  = (u64)ntohl(xdr->data_version_lo);
+	data_version |= (u64)ntohl(xdr->data_version_hi) << 32;
+	if (data_version != status->data_version) {
+		status->data_version = data_version;
+		flags |= AFS_VNODE_DATA_CHANGED;
 	}
-	status->mode &= S_IALLUGO;
 	if (_version)
 		*_version = data_version;
 
-	_debug("vnode time %lx, %lx",
-	       status->mtime_client, status->mtime_server);
+	*_bp = (const void *)*_bp + sizeof(*xdr);
 
 	if (vnode) {
-		if (changed && !test_bit(AFS_VNODE_UNSET, &vnode->flags)) {
-			_debug("vnode changed");
-			i_size_write(&vnode->vfs_inode, size);
-			vnode->vfs_inode.i_uid = status->owner;
-			vnode->vfs_inode.i_gid = status->group;
-			vnode->vfs_inode.i_generation = vnode->fid.unique;
-			set_nlink(&vnode->vfs_inode, status->nlink);
-
-			mode = vnode->vfs_inode.i_mode;
-			mode &= ~S_IALLUGO;
-			mode |= status->mode;
-			barrier();
-			vnode->vfs_inode.i_mode = mode;
-		}
-
-		vnode->vfs_inode.i_ctime.tv_sec	= status->mtime_client;
-		vnode->vfs_inode.i_mtime	= vnode->vfs_inode.i_ctime;
-		vnode->vfs_inode.i_atime	= vnode->vfs_inode.i_ctime;
-		inode_set_iversion_raw(&vnode->vfs_inode, data_version);
+		if (test_bit(AFS_VNODE_UNSET, &vnode->flags))
+			flags |= AFS_VNODE_NOT_YET_SET;
+		afs_update_inode_from_status(vnode, status, expected_version,
+					     flags);
 	}
 
-	status->data_version = data_version;
-	if (expected_version && *expected_version != data_version) {
-		if (vnode && !test_bit(AFS_VNODE_UNSET, &vnode->flags)) {
-			_debug("vnode modified %llx on {%x:%u}",
-			       (unsigned long long) data_version,
-			       vnode->fid.vid, vnode->fid.vnode);
-			set_bit(AFS_VNODE_DIR_MODIFIED, &vnode->flags);
-			set_bit(AFS_VNODE_ZAP_DATA, &vnode->flags);
-		}
-	}
+	ret = 0;
 
 out:
 	if (vnode)
 		write_sequnlock(&vnode->cb_lock);
+	return ret;
+
+bad:
+	xdr_dump_bad(*_bp);
+	ret = -EBADMSG;
+	goto out;
 }
 
 /*
@@ -319,8 +360,9 @@ static int afs_deliver_fs_fetch_status_vnode(struct afs_call *call)
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode,
-				  &call->expected_version, NULL);
+	if (xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode,
+				      &call->expected_version, NULL) < 0)
+		return -EBADMSG;
 	xdr_decode_AFSCallBack(call, vnode, &bp);
 	if (call->reply[1])
 		xdr_decode_AFSVolSync(&bp, call->reply[1]);
@@ -499,9 +541,10 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 			return ret;
 
 		bp = call->buffer;
-		xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode,
-					  &vnode->status.data_version,
-					  &req->new_version);
+		if (xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode,
+					      &vnode->status.data_version,
+					      &req->new_version) < 0)
+			return -EBADMSG;
 		xdr_decode_AFSCallBack(call, vnode, &bp);
 		if (call->reply[1])
 			xdr_decode_AFSVolSync(&bp, call->reply[1]);
@@ -652,9 +695,10 @@ static int afs_deliver_fs_create_vnode(struct afs_call *call)
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
 	xdr_decode_AFSFid(&bp, call->reply[1]);
-	xdr_decode_AFSFetchStatus(&bp, call->reply[2], NULL, NULL, NULL);
-	xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode,
-				  &call->expected_version, NULL);
+	if (xdr_decode_AFSFetchStatus(&bp, call->reply[2], NULL, NULL, NULL) < 0 ||
+	    xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode,
+				      &call->expected_version, NULL) < 0)
+		return -EBADMSG;
 	xdr_decode_AFSCallBack_raw(&bp, call->reply[3]);
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
@@ -756,8 +800,9 @@ static int afs_deliver_fs_remove(struct afs_call *call)
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode,
-				  &call->expected_version, NULL);
+	if (xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode,
+				      &call->expected_version, NULL) < 0)
+		return -EBADMSG;
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
 	_leave(" = 0 [done]");
@@ -844,9 +889,10 @@ static int afs_deliver_fs_link(struct afs_call *call)
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode, NULL, NULL);
-	xdr_decode_AFSFetchStatus(&bp, &dvnode->status, dvnode,
-				  &call->expected_version, NULL);
+	if (xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode, NULL, NULL) < 0 ||
+	    xdr_decode_AFSFetchStatus(&bp, &dvnode->status, dvnode,
+				      &call->expected_version, NULL) < 0)
+		return -EBADMSG;
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
 	_leave(" = 0 [done]");
@@ -930,9 +976,10 @@ static int afs_deliver_fs_symlink(struct afs_call *call)
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
 	xdr_decode_AFSFid(&bp, call->reply[1]);
-	xdr_decode_AFSFetchStatus(&bp, call->reply[2], NULL, NULL, NULL);
-	xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode,
-				  &call->expected_version, NULL);
+	if (xdr_decode_AFSFetchStatus(&bp, call->reply[2], NULL, NULL, NULL) ||
+	    xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode,
+				      &call->expected_version, NULL) < 0)
+		return -EBADMSG;
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
 	_leave(" = 0 [done]");
@@ -1034,11 +1081,13 @@ static int afs_deliver_fs_rename(struct afs_call *call)
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	xdr_decode_AFSFetchStatus(&bp, &orig_dvnode->status, orig_dvnode,
-				  &call->expected_version, NULL);
-	if (new_dvnode != orig_dvnode)
-		xdr_decode_AFSFetchStatus(&bp, &new_dvnode->status, new_dvnode,
-					  &call->expected_version_2, NULL);
+	if (xdr_decode_AFSFetchStatus(&bp, &orig_dvnode->status, orig_dvnode,
+				      &call->expected_version, NULL) < 0)
+		return -EBADMSG;
+	if (new_dvnode != orig_dvnode &&
+	    xdr_decode_AFSFetchStatus(&bp, &new_dvnode->status, new_dvnode,
+				      &call->expected_version_2, NULL) < 0)
+		return -EBADMSG;
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
 	_leave(" = 0 [done]");
@@ -1139,8 +1188,9 @@ static int afs_deliver_fs_store_data(struct afs_call *call)
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode,
-				  &call->expected_version, NULL);
+	if (xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode,
+				      &call->expected_version, NULL) < 0)
+		return -EBADMSG;
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
 	afs_pages_written_back(vnode, call);
@@ -1314,8 +1364,9 @@ static int afs_deliver_fs_store_status(struct afs_call *call)
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode,
-				  &call->expected_version, NULL);
+	if (xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode,
+				      &call->expected_version, NULL) < 0)
+		return -EBADMSG;
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
 	_leave(" = 0 [done]");
@@ -2127,9 +2178,10 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 
 		bp = call->buffer;
 		statuses = call->reply[1];
-		xdr_decode_AFSFetchStatus(&bp, &statuses[call->count],
-					  call->count == 0 ? vnode : NULL,
-					  NULL, NULL);
+		if (xdr_decode_AFSFetchStatus(&bp, &statuses[call->count],
+					      call->count == 0 ? vnode : NULL,
+					      NULL, NULL) < 0)
+			return -EBADMSG;
 
 		call->count++;
 		if (call->count < call->count2)
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 488abd78dc26..2e32d475ec11 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -30,12 +30,11 @@ static const struct inode_operations afs_symlink_inode_operations = {
 };
 
 /*
- * map the AFS file status to the inode member variables
+ * Initialise an inode from the vnode status.
  */
-static int afs_inode_map_status(struct afs_vnode *vnode, struct key *key)
+static int afs_inode_init_from_status(struct afs_vnode *vnode, struct key *key)
 {
 	struct inode *inode = AFS_VNODE_TO_I(vnode);
-	bool changed;
 
 	_debug("FS: ft=%d lk=%d sz=%llu ver=%Lu mod=%hu",
 	       vnode->status.type,
@@ -46,6 +45,9 @@ static int afs_inode_map_status(struct afs_vnode *vnode, struct key *key)
 
 	read_seqlock_excl(&vnode->cb_lock);
 
+	afs_update_inode_from_status(vnode, &vnode->status, NULL,
+				     AFS_VNODE_NOT_YET_SET);
+
 	switch (vnode->status.type) {
 	case AFS_FTYPE_FILE:
 		inode->i_mode	= S_IFREG | vnode->status.mode;
@@ -79,24 +81,13 @@ static int afs_inode_map_status(struct afs_vnode *vnode, struct key *key)
 		return -EBADMSG;
 	}
 
-	changed = (vnode->status.size != inode->i_size);
-
-	set_nlink(inode, vnode->status.nlink);
-	inode->i_uid		= vnode->status.owner;
-	inode->i_gid            = vnode->status.group;
-	inode->i_size		= vnode->status.size;
-	inode->i_ctime.tv_sec	= vnode->status.mtime_client;
-	inode->i_ctime.tv_nsec	= 0;
-	inode->i_atime		= inode->i_mtime = inode->i_ctime;
 	inode->i_blocks		= 0;
-	inode->i_generation	= vnode->fid.unique;
-	inode_set_iversion_raw(inode, vnode->status.data_version);
 	inode->i_mapping->a_ops	= &afs_fs_aops;
 
 	read_sequnlock_excl(&vnode->cb_lock);
 
 #ifdef CONFIG_AFS_FSCACHE
-	if (changed)
+	if (vnode->status.size > 0)
 		fscache_attr_changed(vnode->cache);
 #endif
 	return 0;
@@ -331,7 +322,7 @@ struct inode *afs_iget(struct super_block *sb, struct key *key,
 		vnode->cb_expires_at += ktime_get_real_seconds();
 	}
 
-	ret = afs_inode_map_status(vnode, key);
+	ret = afs_inode_init_from_status(vnode, key);
 	if (ret < 0)
 		goto bad_inode;
 
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 94dc6007b584..8eb0b663b86e 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -702,6 +702,12 @@ extern int afs_flock(struct file *, int, struct file_lock *);
 /*
  * fsclient.c
  */
+#define AFS_VNODE_NOT_YET_SET	0x01
+#define AFS_VNODE_META_CHANGED	0x02
+#define AFS_VNODE_DATA_CHANGED	0x04
+extern void afs_update_inode_from_status(struct afs_vnode *, struct afs_file_status *,
+					 const afs_dataversion_t *, u8);
+
 extern int afs_fs_fetch_file_status(struct afs_fs_cursor *, struct afs_volsync *, bool);
 extern int afs_fs_give_up_callbacks(struct afs_net *, struct afs_server *);
 extern int afs_fs_fetch_data(struct afs_fs_cursor *, struct afs_read *);
diff --git a/fs/afs/xdr_fs.h b/fs/afs/xdr_fs.h
new file mode 100644
index 000000000000..24e23e40c979
--- /dev/null
+++ b/fs/afs/xdr_fs.h
@@ -0,0 +1,40 @@
+/* AFS fileserver XDR types
+ *
+ * Copyright (C) 2018 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#ifndef XDR_FS_H
+#define XDR_FS_H
+
+struct afs_xdr_AFSFetchStatus {
+	__be32	if_version;
+#define AFS_FSTATUS_VERSION	1
+	__be32	type;
+	__be32	nlink;
+	__be32	size_lo;
+	__be32	data_version_lo;
+	__be32	author;
+	__be32	owner;
+	__be32	caller_access;
+	__be32	anon_access;
+	__be32	mode;
+	__be32	parent_vnode;
+	__be32	parent_unique;
+	__be32	seg_size;
+	__be32	mtime_client;
+	__be32	mtime_server;
+	__be32	group;
+	__be32	sync_counter;
+	__be32	data_version_hi;
+	__be32	lock_count;
+	__be32	size_hi;
+	__be32	abort_code;
+} __packed;
+
+#endif /* XDR_FS_H */
