Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752500AbeDEUan (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 16:30:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752367AbeDEUai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 16:30:38 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 10/20] afs: Make it possible to get the data version in
 readpage
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Apr 2018 21:30:36 +0100
Message-ID: <152296023632.31027.804096668688218827.stgit@warthog.procyon.org.uk>
In-Reply-To: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
References: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store the data version number indicated by an FS.FetchData op into the read
request structure so that it's accessible by the page reader.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/flock.c    |    2 +
 fs/afs/fsclient.c |   83 +++++++++++++++++++++++++++++++----------------------
 fs/afs/inode.c    |    8 +++--
 fs/afs/internal.h |    8 +++--
 fs/afs/security.c |    2 +
 5 files changed, 59 insertions(+), 44 deletions(-)

diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index c40ba2fe3cbe..7a0e017070ec 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -613,7 +613,7 @@ static int afs_do_getlk(struct file *file, struct file_lock *fl)
 	posix_test_lock(file, fl);
 	if (fl->fl_type == F_UNLCK) {
 		/* no local locks; consult the server */
-		ret = afs_fetch_status(vnode, key);
+		ret = afs_fetch_status(vnode, key, false);
 		if (ret < 0)
 			goto error;
 
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 90aa3eb2c893..015bbbba0858 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -69,9 +69,9 @@ static void xdr_dump_bad(const __be32 *bp)
 static void xdr_decode_AFSFetchStatus(const __be32 **_bp,
 				      struct afs_file_status *status,
 				      struct afs_vnode *vnode,
-				      afs_dataversion_t *store_version)
+				      const afs_dataversion_t *expected_version,
+				      afs_dataversion_t *_version)
 {
-	afs_dataversion_t expected_version;
 	const __be32 *bp = *_bp;
 	umode_t mode;
 	u64 data_version, size;
@@ -136,6 +136,8 @@ static void xdr_decode_AFSFetchStatus(const __be32 **_bp,
 		changed |= true;
 	}
 	status->mode &= S_IALLUGO;
+	if (_version)
+		*_version = data_version;
 
 	_debug("vnode time %lx, %lx",
 	       status->mtime_client, status->mtime_server);
@@ -162,12 +164,8 @@ static void xdr_decode_AFSFetchStatus(const __be32 **_bp,
 		inode_set_iversion_raw(&vnode->vfs_inode, data_version);
 	}
 
-	expected_version = status->data_version;
-	if (store_version)
-		expected_version = *store_version;
-
-	if (expected_version != data_version) {
-		status->data_version = data_version;
+	status->data_version = data_version;
+	if (expected_version && *expected_version != data_version) {
 		if (vnode && !test_bit(AFS_VNODE_UNSET, &vnode->flags)) {
 			_debug("vnode modified %llx on {%x:%u}",
 			       (unsigned long long) data_version,
@@ -175,8 +173,6 @@ static void xdr_decode_AFSFetchStatus(const __be32 **_bp,
 			set_bit(AFS_VNODE_DIR_MODIFIED, &vnode->flags);
 			set_bit(AFS_VNODE_ZAP_DATA, &vnode->flags);
 		}
-	} else if (store_version) {
-		status->data_version = data_version;
 	}
 
 out:
@@ -323,7 +319,8 @@ static int afs_deliver_fs_fetch_status_vnode(struct afs_call *call)
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode, NULL);
+	xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode,
+				  &call->expected_version, NULL);
 	xdr_decode_AFSCallBack(call, vnode, &bp);
 	if (call->reply[1])
 		xdr_decode_AFSVolSync(&bp, call->reply[1]);
@@ -345,7 +342,8 @@ static const struct afs_call_type afs_RXFSFetchStatus_vnode = {
 /*
  * fetch the status information for a file
  */
-int afs_fs_fetch_file_status(struct afs_fs_cursor *fc, struct afs_volsync *volsync)
+int afs_fs_fetch_file_status(struct afs_fs_cursor *fc, struct afs_volsync *volsync,
+			     bool new_inode)
 {
 	struct afs_vnode *vnode = fc->vnode;
 	struct afs_call *call;
@@ -365,6 +363,7 @@ int afs_fs_fetch_file_status(struct afs_fs_cursor *fc, struct afs_volsync *volsy
 	call->key = fc->key;
 	call->reply[0] = vnode;
 	call->reply[1] = volsync;
+	call->expected_version = new_inode ? 1 : vnode->status.data_version;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -500,7 +499,9 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 			return ret;
 
 		bp = call->buffer;
-		xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode, NULL);
+		xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode,
+					  &vnode->status.data_version,
+					  &req->new_version);
 		xdr_decode_AFSCallBack(call, vnode, &bp);
 		if (call->reply[1])
 			xdr_decode_AFSVolSync(&bp, call->reply[1]);
@@ -570,6 +571,7 @@ static int afs_fs_fetch_data64(struct afs_fs_cursor *fc, struct afs_read *req)
 	call->reply[0] = vnode;
 	call->reply[1] = NULL; /* volsync */
 	call->reply[2] = req;
+	call->expected_version = vnode->status.data_version;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -614,6 +616,7 @@ int afs_fs_fetch_data(struct afs_fs_cursor *fc, struct afs_read *req)
 	call->reply[0] = vnode;
 	call->reply[1] = NULL; /* volsync */
 	call->reply[2] = req;
+	call->expected_version = vnode->status.data_version;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -649,8 +652,9 @@ static int afs_deliver_fs_create_vnode(struct afs_call *call)
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
 	xdr_decode_AFSFid(&bp, call->reply[1]);
-	xdr_decode_AFSFetchStatus(&bp, call->reply[2], NULL, NULL);
-	xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode, NULL);
+	xdr_decode_AFSFetchStatus(&bp, call->reply[2], NULL, NULL, NULL);
+	xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode,
+				  &call->expected_version, NULL);
 	xdr_decode_AFSCallBack_raw(&bp, call->reply[3]);
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
@@ -708,6 +712,7 @@ int afs_fs_create(struct afs_fs_cursor *fc,
 	call->reply[1] = newfid;
 	call->reply[2] = newstatus;
 	call->reply[3] = newcb;
+	call->expected_version = vnode->status.data_version;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -751,7 +756,8 @@ static int afs_deliver_fs_remove(struct afs_call *call)
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode, NULL);
+	xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode,
+				  &call->expected_version, NULL);
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
 	_leave(" = 0 [done]");
@@ -800,6 +806,7 @@ int afs_fs_remove(struct afs_fs_cursor *fc, const char *name, bool isdir)
 
 	call->key = fc->key;
 	call->reply[0] = vnode;
+	call->expected_version = vnode->status.data_version;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -837,8 +844,9 @@ static int afs_deliver_fs_link(struct afs_call *call)
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode, NULL);
-	xdr_decode_AFSFetchStatus(&bp, &dvnode->status, dvnode, NULL);
+	xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode, NULL, NULL);
+	xdr_decode_AFSFetchStatus(&bp, &dvnode->status, dvnode,
+				  &call->expected_version, NULL);
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
 	_leave(" = 0 [done]");
@@ -880,6 +888,7 @@ int afs_fs_link(struct afs_fs_cursor *fc, struct afs_vnode *vnode,
 	call->key = fc->key;
 	call->reply[0] = dvnode;
 	call->reply[1] = vnode;
+	call->expected_version = vnode->status.data_version;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -921,8 +930,9 @@ static int afs_deliver_fs_symlink(struct afs_call *call)
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
 	xdr_decode_AFSFid(&bp, call->reply[1]);
-	xdr_decode_AFSFetchStatus(&bp, call->reply[2], NULL, NULL);
-	xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode, NULL);
+	xdr_decode_AFSFetchStatus(&bp, call->reply[2], NULL, NULL, NULL);
+	xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode,
+				  &call->expected_version, NULL);
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
 	_leave(" = 0 [done]");
@@ -973,6 +983,7 @@ int afs_fs_symlink(struct afs_fs_cursor *fc,
 	call->reply[0] = vnode;
 	call->reply[1] = newfid;
 	call->reply[2] = newstatus;
+	call->expected_version = vnode->status.data_version;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -1023,10 +1034,11 @@ static int afs_deliver_fs_rename(struct afs_call *call)
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	xdr_decode_AFSFetchStatus(&bp, &orig_dvnode->status, orig_dvnode, NULL);
+	xdr_decode_AFSFetchStatus(&bp, &orig_dvnode->status, orig_dvnode,
+				  &call->expected_version, NULL);
 	if (new_dvnode != orig_dvnode)
 		xdr_decode_AFSFetchStatus(&bp, &new_dvnode->status, new_dvnode,
-					  NULL);
+					  &call->expected_version_2, NULL);
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
 	_leave(" = 0 [done]");
@@ -1077,6 +1089,8 @@ int afs_fs_rename(struct afs_fs_cursor *fc,
 	call->key = fc->key;
 	call->reply[0] = orig_dvnode;
 	call->reply[1] = new_dvnode;
+	call->expected_version = orig_dvnode->status.data_version;
+	call->expected_version_2 = new_dvnode->status.data_version;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -1126,7 +1140,7 @@ static int afs_deliver_fs_store_data(struct afs_call *call)
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
 	xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode,
-				  &call->store_version);
+				  &call->expected_version, NULL);
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
 	afs_pages_written_back(vnode, call);
@@ -1183,7 +1197,7 @@ static int afs_fs_store_data64(struct afs_fs_cursor *fc,
 	call->first_offset = offset;
 	call->last_to = to;
 	call->send_pages = true;
-	call->store_version = vnode->status.data_version + 1;
+	call->expected_version = vnode->status.data_version + 1;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -1258,7 +1272,7 @@ int afs_fs_store_data(struct afs_fs_cursor *fc, struct address_space *mapping,
 	call->first_offset = offset;
 	call->last_to = to;
 	call->send_pages = true;
-	call->store_version = vnode->status.data_version + 1;
+	call->expected_version = vnode->status.data_version + 1;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -1288,7 +1302,6 @@ int afs_fs_store_data(struct afs_fs_cursor *fc, struct address_space *mapping,
  */
 static int afs_deliver_fs_store_status(struct afs_call *call)
 {
-	afs_dataversion_t *store_version;
 	struct afs_vnode *vnode = call->reply[0];
 	const __be32 *bp;
 	int ret;
@@ -1300,12 +1313,9 @@ static int afs_deliver_fs_store_status(struct afs_call *call)
 		return ret;
 
 	/* unmarshall the reply once we've received all of it */
-	store_version = NULL;
-	if (call->operation_ID == FSSTOREDATA)
-		store_version = &call->store_version;
-
 	bp = call->buffer;
-	xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode, store_version);
+	xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode,
+				  &call->expected_version, NULL);
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
 	_leave(" = 0 [done]");
@@ -1360,7 +1370,7 @@ static int afs_fs_setattr_size64(struct afs_fs_cursor *fc, struct iattr *attr)
 
 	call->key = fc->key;
 	call->reply[0] = vnode;
-	call->store_version = vnode->status.data_version + 1;
+	call->expected_version = vnode->status.data_version + 1;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -1409,7 +1419,7 @@ static int afs_fs_setattr_size(struct afs_fs_cursor *fc, struct iattr *attr)
 
 	call->key = fc->key;
 	call->reply[0] = vnode;
-	call->store_version = vnode->status.data_version + 1;
+	call->expected_version = vnode->status.data_version + 1;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -1454,6 +1464,7 @@ int afs_fs_setattr(struct afs_fs_cursor *fc, struct iattr *attr)
 
 	call->key = fc->key;
 	call->reply[0] = vnode;
+	call->expected_version = vnode->status.data_version;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -2004,7 +2015,8 @@ static int afs_deliver_fs_fetch_status(struct afs_call *call)
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	xdr_decode_AFSFetchStatus(&bp, status, vnode, NULL);
+	xdr_decode_AFSFetchStatus(&bp, status, vnode,
+				  &call->expected_version, NULL);
 	callback[call->count].version	= ntohl(bp[0]);
 	callback[call->count].expiry	= ntohl(bp[1]);
 	callback[call->count].type	= ntohl(bp[2]);
@@ -2056,6 +2068,7 @@ int afs_fs_fetch_status(struct afs_fs_cursor *fc,
 	call->reply[1] = status;
 	call->reply[2] = callback;
 	call->reply[3] = volsync;
+	call->expected_version = 1; /* vnode->status.data_version */
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -2116,7 +2129,7 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		statuses = call->reply[1];
 		xdr_decode_AFSFetchStatus(&bp, &statuses[call->count],
 					  call->count == 0 ? vnode : NULL,
-					  NULL);
+					  NULL, NULL);
 
 		call->count++;
 		if (call->count < call->count2)
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index bcaff40b664d..488abd78dc26 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -105,7 +105,7 @@ static int afs_inode_map_status(struct afs_vnode *vnode, struct key *key)
 /*
  * Fetch file status from the volume.
  */
-int afs_fetch_status(struct afs_vnode *vnode, struct key *key)
+int afs_fetch_status(struct afs_vnode *vnode, struct key *key, bool new_inode)
 {
 	struct afs_fs_cursor fc;
 	int ret;
@@ -119,7 +119,7 @@ int afs_fetch_status(struct afs_vnode *vnode, struct key *key)
 	if (afs_begin_vnode_operation(&fc, vnode, key)) {
 		while (afs_select_fileserver(&fc)) {
 			fc.cb_break = vnode->cb_break + vnode->cb_s_break;
-			afs_fs_fetch_file_status(&fc, NULL);
+			afs_fs_fetch_file_status(&fc, NULL, new_inode);
 		}
 
 		afs_check_for_remote_deletion(&fc, fc.vnode);
@@ -307,7 +307,7 @@ struct inode *afs_iget(struct super_block *sb, struct key *key,
 
 	if (!status) {
 		/* it's a remotely extant inode */
-		ret = afs_fetch_status(vnode, key);
+		ret = afs_fetch_status(vnode, key, true);
 		if (ret < 0)
 			goto bad_inode;
 	} else {
@@ -432,7 +432,7 @@ int afs_validate(struct afs_vnode *vnode, struct key *key)
 	 * access */
 	if (!test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags)) {
 		_debug("not promised");
-		ret = afs_fetch_status(vnode, key);
+		ret = afs_fetch_status(vnode, key, false);
 		if (ret < 0) {
 			if (ret == -ENOENT) {
 				set_bit(AFS_VNODE_DELETED, &vnode->flags);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index ebec83017f9a..94dc6007b584 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -122,7 +122,8 @@ struct afs_call {
 	u32			operation_ID;	/* operation ID for an incoming call */
 	u32			count;		/* count for use in unmarshalling */
 	__be32			tmp;		/* place to extract temporary data */
-	afs_dataversion_t	store_version;	/* updated version expected from store */
+	afs_dataversion_t	expected_version; /* Updated version expected from store */
+	afs_dataversion_t	expected_version_2; /* 2nd updated version expected from store */
 };
 
 struct afs_call_type {
@@ -173,6 +174,7 @@ struct afs_read {
 	loff_t			len;		/* How much we're asking for */
 	loff_t			actual_len;	/* How much we're actually getting */
 	loff_t			remain;		/* Amount remaining */
+	afs_dataversion_t	new_version;	/* Version number returned by server */
 	atomic_t		usage;
 	unsigned int		index;		/* Which page we're reading into */
 	unsigned int		nr_pages;
@@ -700,7 +702,7 @@ extern int afs_flock(struct file *, int, struct file_lock *);
 /*
  * fsclient.c
  */
-extern int afs_fs_fetch_file_status(struct afs_fs_cursor *, struct afs_volsync *);
+extern int afs_fs_fetch_file_status(struct afs_fs_cursor *, struct afs_volsync *, bool);
 extern int afs_fs_give_up_callbacks(struct afs_net *, struct afs_server *);
 extern int afs_fs_fetch_data(struct afs_fs_cursor *, struct afs_read *);
 extern int afs_fs_create(struct afs_fs_cursor *, const char *, umode_t,
@@ -733,7 +735,7 @@ extern int afs_fs_fetch_status(struct afs_fs_cursor *, struct afs_net *,
 /*
  * inode.c
  */
-extern int afs_fetch_status(struct afs_vnode *, struct key *);
+extern int afs_fetch_status(struct afs_vnode *, struct key *, bool);
 extern int afs_iget5_test(struct inode *, void *);
 extern struct inode *afs_iget_pseudo_dir(struct super_block *, bool);
 extern struct inode *afs_iget(struct super_block *, struct key *,
diff --git a/fs/afs/security.c b/fs/afs/security.c
index bd82c5bf4a6a..cea2fff313dc 100644
--- a/fs/afs/security.c
+++ b/fs/afs/security.c
@@ -322,7 +322,7 @@ int afs_check_permit(struct afs_vnode *vnode, struct key *key,
 		 */
 		_debug("no valid permit");
 
-		ret = afs_fetch_status(vnode, key);
+		ret = afs_fetch_status(vnode, key, false);
 		if (ret < 0) {
 			*_access = 0;
 			_leave(" = %d", ret);
