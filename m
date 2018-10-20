Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2B6ECDE43
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722BB214C2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 722BB214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbeJTJVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 05:21:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbeJTJVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 05:21:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 82DE29D508;
        Sat, 20 Oct 2018 01:13:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7FC44620DD;
        Sat, 20 Oct 2018 01:13:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 20/24] afs: Implement YFS support in the fs client
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 20 Oct 2018 02:13:02 +0100
Message-ID: <153999798267.866.1610103682726768878.stgit@warthog.procyon.org.uk>
In-Reply-To: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
References: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sat, 20 Oct 2018 01:13:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement support for talking to YFS-variant fileservers in the cache
manager and the filesystem client.  These implement upgraded services on
the same port as their AFS services.

YFS fileservers provide expanded capabilities over AFS.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/Makefile            |    3 
 fs/afs/callback.c          |    9 
 fs/afs/dir.c               |   21 
 fs/afs/fsclient.c          |  104 ++
 fs/afs/internal.h          |   35 +
 fs/afs/protocol_yfs.h      |  106 ++
 fs/afs/server.c            |    8 
 fs/afs/yfsclient.c         | 2184 ++++++++++++++++++++++++++++++++++++++++++++
 include/trace/events/afs.h |   58 +
 9 files changed, 2500 insertions(+), 28 deletions(-)
 create mode 100644 fs/afs/yfsclient.c

diff --git a/fs/afs/Makefile b/fs/afs/Makefile
index 03e9f7afea1b..cc942b790cff 100644
--- a/fs/afs/Makefile
+++ b/fs/afs/Makefile
@@ -33,7 +33,8 @@ kafs-y := \
 	vl_list.o \
 	volume.o \
 	write.o \
-	xattr.o
+	xattr.o \
+	yfsclient.o
 
 kafs-$(CONFIG_PROC_FS) += proc.o
 obj-$(CONFIG_AFS_FS)  := kafs.o
diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index df9bfee698ad..1c7955f5cdaf 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -210,12 +210,10 @@ void afs_init_callback_state(struct afs_server *server)
 /*
  * actually break a callback
  */
-void afs_break_callback(struct afs_vnode *vnode)
+void __afs_break_callback(struct afs_vnode *vnode)
 {
 	_enter("");
 
-	write_seqlock(&vnode->cb_lock);
-
 	clear_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags);
 	if (test_and_clear_bit(AFS_VNODE_CB_PROMISED, &vnode->flags)) {
 		vnode->cb_break++;
@@ -230,7 +228,12 @@ void afs_break_callback(struct afs_vnode *vnode)
 			afs_lock_may_be_available(vnode);
 		spin_unlock(&vnode->lock);
 	}
+}
 
+void afs_break_callback(struct afs_vnode *vnode)
+{
+	write_seqlock(&vnode->cb_lock);
+	__afs_break_callback(vnode);
 	write_sequnlock(&vnode->cb_lock);
 }
 
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index f2dd48d4363f..43dea3b00c29 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1200,7 +1200,7 @@ static int afs_rmdir(struct inode *dir, struct dentry *dentry)
 	if (afs_begin_vnode_operation(&fc, dvnode, key)) {
 		while (afs_select_fileserver(&fc)) {
 			fc.cb_break = afs_calc_vnode_cb_break(dvnode);
-			afs_fs_remove(&fc, dentry->d_name.name, true,
+			afs_fs_remove(&fc, vnode, dentry->d_name.name, true,
 				      data_version);
 		}
 
@@ -1245,7 +1245,9 @@ static int afs_dir_remove_link(struct dentry *dentry, struct key *key,
 	if (d_really_is_positive(dentry)) {
 		struct afs_vnode *vnode = AFS_FS_I(d_inode(dentry));
 
-		if (dir_valid) {
+		if (test_bit(AFS_VNODE_DELETED, &vnode->flags)) {
+			/* Already done */
+		} else if (dir_valid) {
 			drop_nlink(&vnode->vfs_inode);
 			if (vnode->vfs_inode.i_nlink == 0) {
 				set_bit(AFS_VNODE_DELETED, &vnode->flags);
@@ -1274,7 +1276,7 @@ static int afs_dir_remove_link(struct dentry *dentry, struct key *key,
 static int afs_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct afs_fs_cursor fc;
-	struct afs_vnode *dvnode = AFS_FS_I(dir), *vnode;
+	struct afs_vnode *dvnode = AFS_FS_I(dir), *vnode = NULL;
 	struct key *key;
 	unsigned long d_version = (unsigned long)dentry->d_fsdata;
 	u64 data_version = dvnode->status.data_version;
@@ -1304,7 +1306,18 @@ static int afs_unlink(struct inode *dir, struct dentry *dentry)
 	if (afs_begin_vnode_operation(&fc, dvnode, key)) {
 		while (afs_select_fileserver(&fc)) {
 			fc.cb_break = afs_calc_vnode_cb_break(dvnode);
-			afs_fs_remove(&fc, dentry->d_name.name, false,
+
+			if (test_bit(AFS_SERVER_FL_IS_YFS, &fc.cbi->server->flags) &&
+			    !test_bit(AFS_SERVER_FL_NO_RM2, &fc.cbi->server->flags)) {
+				yfs_fs_remove_file2(&fc, vnode, dentry->d_name.name,
+						    data_version);
+				if (fc.ac.error != -ECONNABORTED ||
+				    fc.ac.abort_code != RXGEN_OPCODE)
+					continue;
+				set_bit(AFS_SERVER_FL_NO_RM2, &fc.cbi->server->flags);
+			}
+
+			afs_fs_remove(&fc, vnode, dentry->d_name.name, false,
 				      data_version);
 		}
 
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 2da65309e0de..3975969719de 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -17,6 +17,7 @@
 #include "internal.h"
 #include "afs_fs.h"
 #include "xdr_fs.h"
+#include "protocol_yfs.h"
 
 static const struct afs_fid afs_zero_fid;
 
@@ -312,14 +313,18 @@ static void xdr_decode_AFSVolSync(const __be32 **_bp,
 				  struct afs_volsync *volsync)
 {
 	const __be32 *bp = *_bp;
+	u32 creation;
 
-	volsync->creation = ntohl(*bp++);
+	creation = ntohl(*bp++);
 	bp++; /* spare2 */
 	bp++; /* spare3 */
 	bp++; /* spare4 */
 	bp++; /* spare5 */
 	bp++; /* spare6 */
 	*_bp = bp;
+
+	if (volsync)
+		volsync->creation = creation;
 }
 
 /*
@@ -380,6 +385,8 @@ static void xdr_decode_AFSFetchVolumeStatus(const __be32 **_bp,
 	vs->blocks_in_use	= ntohl(*bp++);
 	vs->part_blocks_avail	= ntohl(*bp++);
 	vs->part_max_blocks	= ntohl(*bp++);
+	vs->vol_copy_date	= 0;
+	vs->vol_backup_date	= 0;
 	*_bp = bp;
 }
 
@@ -405,8 +412,7 @@ static int afs_deliver_fs_fetch_status_vnode(struct afs_call *call)
 	if (ret < 0)
 		return ret;
 	xdr_decode_AFSCallBack(call, vnode, &bp);
-	if (call->reply[1])
-		xdr_decode_AFSVolSync(&bp, call->reply[1]);
+	xdr_decode_AFSVolSync(&bp, call->reply[1]);
 
 	_leave(" = 0 [done]");
 	return 0;
@@ -433,6 +439,9 @@ int afs_fs_fetch_file_status(struct afs_fs_cursor *fc, struct afs_volsync *volsy
 	struct afs_net *net = afs_v2net(vnode);
 	__be32 *bp;
 
+	if (test_bit(AFS_SERVER_FL_IS_YFS, &fc->cbi->server->flags))
+		return yfs_fs_fetch_file_status(fc, volsync, new_inode);
+
 	_enter(",%x,{%llx:%llu},,",
 	       key_serial(fc->key), vnode->fid.vid, vnode->fid.vnode);
 
@@ -567,8 +576,7 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		if (ret < 0)
 			return ret;
 		xdr_decode_AFSCallBack(call, vnode, &bp);
-		if (call->reply[1])
-			xdr_decode_AFSVolSync(&bp, call->reply[1]);
+		xdr_decode_AFSVolSync(&bp, call->reply[1]);
 
 		call->unmarshall++;
 
@@ -665,6 +673,9 @@ int afs_fs_fetch_data(struct afs_fs_cursor *fc, struct afs_read *req)
 	struct afs_net *net = afs_v2net(vnode);
 	__be32 *bp;
 
+	if (test_bit(AFS_SERVER_FL_IS_YFS, &fc->cbi->server->flags))
+		return yfs_fs_fetch_data(fc, req);
+
 	if (upper_32_bits(req->pos) ||
 	    upper_32_bits(req->len) ||
 	    upper_32_bits(req->pos + req->len))
@@ -765,6 +776,15 @@ int afs_fs_create(struct afs_fs_cursor *fc,
 	size_t namesz, reqsz, padsz;
 	__be32 *bp;
 
+	if (test_bit(AFS_SERVER_FL_IS_YFS, &fc->cbi->server->flags)){
+		if (S_ISDIR(mode))
+			return yfs_fs_make_dir(fc, name, mode, current_data_version,
+					       newfid, newstatus, newcb);
+		else
+			return yfs_fs_create_file(fc, name, mode, current_data_version,
+						  newfid, newstatus, newcb);
+	}
+
 	_enter("");
 
 	namesz = strlen(name);
@@ -857,15 +877,18 @@ static const struct afs_call_type afs_RXFSRemoveDir = {
 /*
  * remove a file or directory
  */
-int afs_fs_remove(struct afs_fs_cursor *fc, const char *name, bool isdir,
-		  u64 current_data_version)
+int afs_fs_remove(struct afs_fs_cursor *fc, struct afs_vnode *vnode,
+		  const char *name, bool isdir, u64 current_data_version)
 {
-	struct afs_vnode *vnode = fc->vnode;
+	struct afs_vnode *dvnode = fc->vnode;
 	struct afs_call *call;
-	struct afs_net *net = afs_v2net(vnode);
+	struct afs_net *net = afs_v2net(dvnode);
 	size_t namesz, reqsz, padsz;
 	__be32 *bp;
 
+	if (test_bit(AFS_SERVER_FL_IS_YFS, &fc->cbi->server->flags))
+		return yfs_fs_remove(fc, vnode, name, isdir, current_data_version);
+
 	_enter("");
 
 	namesz = strlen(name);
@@ -879,15 +902,16 @@ int afs_fs_remove(struct afs_fs_cursor *fc, const char *name, bool isdir,
 		return -ENOMEM;
 
 	call->key = fc->key;
-	call->reply[0] = vnode;
+	call->reply[0] = dvnode;
+	call->reply[1] = vnode;
 	call->expected_version = current_data_version + 1;
 
 	/* marshall the parameters */
 	bp = call->request;
 	*bp++ = htonl(isdir ? FSREMOVEDIR : FSREMOVEFILE);
-	*bp++ = htonl(vnode->fid.vid);
-	*bp++ = htonl(vnode->fid.vnode);
-	*bp++ = htonl(vnode->fid.unique);
+	*bp++ = htonl(dvnode->fid.vid);
+	*bp++ = htonl(dvnode->fid.vnode);
+	*bp++ = htonl(dvnode->fid.unique);
 	*bp++ = htonl(namesz);
 	memcpy(bp, name, namesz);
 	bp = (void *) bp + namesz;
@@ -897,7 +921,7 @@ int afs_fs_remove(struct afs_fs_cursor *fc, const char *name, bool isdir,
 	}
 
 	afs_use_fs_server(call, fc->cbi);
-	trace_afs_make_fs_call(call, &vnode->fid);
+	trace_afs_make_fs_call(call, &dvnode->fid);
 	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
 }
 
@@ -953,6 +977,9 @@ int afs_fs_link(struct afs_fs_cursor *fc, struct afs_vnode *vnode,
 	size_t namesz, reqsz, padsz;
 	__be32 *bp;
 
+	if (test_bit(AFS_SERVER_FL_IS_YFS, &fc->cbi->server->flags))
+		return yfs_fs_link(fc, vnode, name, current_data_version);
+
 	_enter("");
 
 	namesz = strlen(name);
@@ -1047,6 +1074,10 @@ int afs_fs_symlink(struct afs_fs_cursor *fc,
 	size_t namesz, reqsz, padsz, c_namesz, c_padsz;
 	__be32 *bp;
 
+	if (test_bit(AFS_SERVER_FL_IS_YFS, &fc->cbi->server->flags))
+		return yfs_fs_symlink(fc, name, contents, current_data_version,
+				      newfid, newstatus);
+
 	_enter("");
 
 	namesz = strlen(name);
@@ -1159,6 +1190,12 @@ int afs_fs_rename(struct afs_fs_cursor *fc,
 	size_t reqsz, o_namesz, o_padsz, n_namesz, n_padsz;
 	__be32 *bp;
 
+	if (test_bit(AFS_SERVER_FL_IS_YFS, &fc->cbi->server->flags))
+		return yfs_fs_rename(fc, orig_name,
+				     new_dvnode, new_name,
+				     current_orig_data_version,
+				     current_new_data_version);
+
 	_enter("");
 
 	o_namesz = strlen(orig_name);
@@ -1329,6 +1366,9 @@ int afs_fs_store_data(struct afs_fs_cursor *fc, struct address_space *mapping,
 	loff_t size, pos, i_size;
 	__be32 *bp;
 
+	if (test_bit(AFS_SERVER_FL_IS_YFS, &fc->cbi->server->flags))
+		return yfs_fs_store_data(fc, mapping, first, last, offset, to);
+
 	_enter(",%x,{%llx:%llu},,",
 	       key_serial(fc->key), vnode->fid.vid, vnode->fid.vnode);
 
@@ -1544,6 +1584,9 @@ int afs_fs_setattr(struct afs_fs_cursor *fc, struct iattr *attr)
 	struct afs_net *net = afs_v2net(vnode);
 	__be32 *bp;
 
+	if (test_bit(AFS_SERVER_FL_IS_YFS, &fc->cbi->server->flags))
+		return yfs_fs_setattr(fc, attr);
+
 	if (attr->ia_valid & ATTR_SIZE)
 		return afs_fs_setattr_size(fc, attr);
 
@@ -1728,6 +1771,9 @@ int afs_fs_get_volume_status(struct afs_fs_cursor *fc,
 	__be32 *bp;
 	void *tmpbuf;
 
+	if (test_bit(AFS_SERVER_FL_IS_YFS, &fc->cbi->server->flags))
+		return yfs_fs_get_volume_status(fc, vs);
+
 	_enter("");
 
 	tmpbuf = kmalloc(AFSOPAQUEMAX, GFP_KERNEL);
@@ -1817,6 +1863,9 @@ int afs_fs_set_lock(struct afs_fs_cursor *fc, afs_lock_type_t type)
 	struct afs_net *net = afs_v2net(vnode);
 	__be32 *bp;
 
+	if (test_bit(AFS_SERVER_FL_IS_YFS, &fc->cbi->server->flags))
+		return yfs_fs_set_lock(fc, type);
+
 	_enter("");
 
 	call = afs_alloc_flat_call(net, &afs_RXFSSetLock, 5 * 4, 6 * 4);
@@ -1849,6 +1898,9 @@ int afs_fs_extend_lock(struct afs_fs_cursor *fc)
 	struct afs_net *net = afs_v2net(vnode);
 	__be32 *bp;
 
+	if (test_bit(AFS_SERVER_FL_IS_YFS, &fc->cbi->server->flags))
+		return yfs_fs_extend_lock(fc);
+
 	_enter("");
 
 	call = afs_alloc_flat_call(net, &afs_RXFSExtendLock, 4 * 4, 6 * 4);
@@ -1880,6 +1932,9 @@ int afs_fs_release_lock(struct afs_fs_cursor *fc)
 	struct afs_net *net = afs_v2net(vnode);
 	__be32 *bp;
 
+	if (test_bit(AFS_SERVER_FL_IS_YFS, &fc->cbi->server->flags))
+		return yfs_fs_release_lock(fc);
+
 	_enter("");
 
 	call = afs_alloc_flat_call(net, &afs_RXFSReleaseLock, 4 * 4, 6 * 4);
@@ -1951,6 +2006,7 @@ int afs_fs_give_up_all_callbacks(struct afs_net *net,
  */
 static int afs_deliver_fs_get_capabilities(struct afs_call *call)
 {
+	struct afs_server *server = call->reply[0];
 	u32 count;
 	int ret;
 
@@ -1986,6 +2042,11 @@ static int afs_deliver_fs_get_capabilities(struct afs_call *call)
 		break;
 	}
 
+	if (call->service_id == YFS_FS_SERVICE)
+		set_bit(AFS_SERVER_FL_IS_YFS, &server->flags);
+	else
+		clear_bit(AFS_SERVER_FL_IS_YFS, &server->flags);
+
 	_leave(" = 0 [done]");
 	return 0;
 }
@@ -2019,6 +2080,8 @@ int afs_fs_get_capabilities(struct afs_net *net,
 		return -ENOMEM;
 
 	call->key = key;
+	call->reply[0] = server;
+	call->upgrade = true;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -2054,8 +2117,7 @@ static int afs_deliver_fs_fetch_status(struct afs_call *call)
 	if (ret < 0)
 		return ret;
 	xdr_decode_AFSCallBack_raw(call, &bp, callback);
-	if (volsync)
-		xdr_decode_AFSVolSync(&bp, volsync);
+	xdr_decode_AFSVolSync(&bp, volsync);
 
 	_leave(" = 0 [done]");
 	return 0;
@@ -2084,6 +2146,9 @@ int afs_fs_fetch_status(struct afs_fs_cursor *fc,
 	struct afs_call *call;
 	__be32 *bp;
 
+	if (test_bit(AFS_SERVER_FL_IS_YFS, &fc->cbi->server->flags))
+		return yfs_fs_fetch_status(fc, net, fid, status, callback, volsync);
+
 	_enter(",%x,{%llx:%llu},,",
 	       key_serial(fc->key), fid->vid, fid->vnode);
 
@@ -2218,8 +2283,7 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 			return ret;
 
 		bp = call->buffer;
-		if (call->reply[3])
-			xdr_decode_AFSVolSync(&bp, call->reply[3]);
+		xdr_decode_AFSVolSync(&bp, call->reply[3]);
 
 		call->unmarshall++;
 
@@ -2256,6 +2320,10 @@ int afs_fs_inline_bulk_status(struct afs_fs_cursor *fc,
 	__be32 *bp;
 	int i;
 
+	if (test_bit(AFS_SERVER_FL_IS_YFS, &fc->cbi->server->flags))
+		return yfs_fs_inline_bulk_status(fc, net, fids, statuses, callbacks,
+						 nr_fids, volsync);
+
 	_enter(",%x,{%llx:%llu},%u",
 	       key_serial(fc->key), fids[0].vid, fids[1].vnode, nr_fids);
 
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 78065af05153..ce79bd514331 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -459,6 +459,8 @@ struct afs_server {
 #define AFS_SERVER_FL_PROBING	6		/* Fileserver is being probed */
 #define AFS_SERVER_FL_NO_IBULK	7		/* Fileserver doesn't support FS.InlineBulkStatus */
 #define AFS_SERVER_FL_MAY_HAVE_CB 8		/* May have callbacks on this fileserver */
+#define AFS_SERVER_FL_IS_YFS	9		/* Server is YFS not AFS */
+#define AFS_SERVER_FL_NO_RM2	10		/* Fileserver doesn't support YFS.RemoveFile2 */
 	atomic_t		usage;
 	u32			addr_version;	/* Address list version */
 
@@ -751,6 +753,7 @@ extern struct fscache_cookie_def afs_vnode_cache_index_def;
  * callback.c
  */
 extern void afs_init_callback_state(struct afs_server *);
+extern void __afs_break_callback(struct afs_vnode *);
 extern void afs_break_callback(struct afs_vnode *);
 extern void afs_break_callbacks(struct afs_server *, size_t, struct afs_callback_break*);
 
@@ -864,7 +867,7 @@ extern int afs_fs_give_up_callbacks(struct afs_net *, struct afs_server *);
 extern int afs_fs_fetch_data(struct afs_fs_cursor *, struct afs_read *);
 extern int afs_fs_create(struct afs_fs_cursor *, const char *, umode_t, u64,
 			 struct afs_fid *, struct afs_file_status *, struct afs_callback *);
-extern int afs_fs_remove(struct afs_fs_cursor *, const char *, bool, u64);
+extern int afs_fs_remove(struct afs_fs_cursor *, struct afs_vnode *, const char *, bool, u64);
 extern int afs_fs_link(struct afs_fs_cursor *, struct afs_vnode *, const char *, u64);
 extern int afs_fs_symlink(struct afs_fs_cursor *, const char *, const char *, u64,
 			  struct afs_fid *, struct afs_file_status *);
@@ -1228,6 +1231,36 @@ extern int afs_launder_page(struct page *);
 extern const struct xattr_handler *afs_xattr_handlers[];
 extern ssize_t afs_listxattr(struct dentry *, char *, size_t);
 
+/*
+ * yfsclient.c
+ */
+extern int yfs_fs_fetch_file_status(struct afs_fs_cursor *, struct afs_volsync *, bool);
+extern int yfs_fs_fetch_data(struct afs_fs_cursor *, struct afs_read *);
+extern int yfs_fs_create_file(struct afs_fs_cursor *, const char *, umode_t, u64,
+			      struct afs_fid *, struct afs_file_status *, struct afs_callback *);
+extern int yfs_fs_make_dir(struct afs_fs_cursor *, const char *, umode_t, u64,
+			 struct afs_fid *, struct afs_file_status *, struct afs_callback *);
+extern int yfs_fs_remove_file2(struct afs_fs_cursor *, struct afs_vnode *, const char *, u64);
+extern int yfs_fs_remove(struct afs_fs_cursor *, struct afs_vnode *, const char *, bool, u64);
+extern int yfs_fs_link(struct afs_fs_cursor *, struct afs_vnode *, const char *, u64);
+extern int yfs_fs_symlink(struct afs_fs_cursor *, const char *, const char *, u64,
+			  struct afs_fid *, struct afs_file_status *);
+extern int yfs_fs_rename(struct afs_fs_cursor *, const char *,
+			 struct afs_vnode *, const char *, u64, u64);
+extern int yfs_fs_store_data(struct afs_fs_cursor *, struct address_space *,
+			     pgoff_t, pgoff_t, unsigned, unsigned);
+extern int yfs_fs_setattr(struct afs_fs_cursor *, struct iattr *);
+extern int yfs_fs_get_volume_status(struct afs_fs_cursor *, struct afs_volume_status *);
+extern int yfs_fs_set_lock(struct afs_fs_cursor *, afs_lock_type_t);
+extern int yfs_fs_extend_lock(struct afs_fs_cursor *);
+extern int yfs_fs_release_lock(struct afs_fs_cursor *);
+extern int yfs_fs_fetch_status(struct afs_fs_cursor *, struct afs_net *,
+			       struct afs_fid *, struct afs_file_status *,
+			       struct afs_callback *, struct afs_volsync *);
+extern int yfs_fs_inline_bulk_status(struct afs_fs_cursor *, struct afs_net *,
+				     struct afs_fid *, struct afs_file_status *,
+				     struct afs_callback *, unsigned int,
+				     struct afs_volsync *);
 
 /*
  * Miscellaneous inline functions.
diff --git a/fs/afs/protocol_yfs.h b/fs/afs/protocol_yfs.h
index b7b211dd9857..07bc10f076aa 100644
--- a/fs/afs/protocol_yfs.h
+++ b/fs/afs/protocol_yfs.h
@@ -30,6 +30,36 @@ enum YFS_CM_Operations {
 	YFSCBCallBack		= 64204,
 };
 
+enum YFS_FS_Operations {
+	YFSFETCHACL		= 64131, /* YFS Fetch file ACL */
+	YFSFETCHSTATUS		= 64132, /* YFS Fetch file status */
+	YFSSTOREACL		= 64134, /* YFS Store file ACL */
+	YFSSTORESTATUS		= 64135, /* YFS Store file status */
+	YFSREMOVEFILE		= 64136, /* YFS Remove a file */
+	YFSCREATEFILE		= 64137, /* YFS Create a file */
+	YFSRENAME		= 64138, /* YFS Rename or move a file or directory */
+	YFSSYMLINK		= 64139, /* YFS Create a symbolic link */
+	YFSLINK			= 64140, /* YFS Create a hard link */
+	YFSMAKEDIR		= 64141, /* YFS Create a directory */
+	YFSREMOVEDIR		= 64142, /* YFS Remove a directory */
+	YFSGETVOLUMESTATUS	= 64149, /* YFS Get volume status information */
+	YFSSETVOLUMESTATUS	= 64150, /* YFS Set volume status information */
+	YFSSETLOCK		= 64156, /* YFS Request a file lock */
+	YFSEXTENDLOCK		= 64157, /* YFS Extend a file lock */
+	YFSRELEASELOCK		= 64158, /* YFS Release a file lock */
+	YFSLOOKUP		= 64161, /* YFS lookup file in directory */
+	YFSFLUSHCPS		= 64165,
+	YFSFETCHOPAQUEACL	= 64168,
+	YFSWHOAMI		= 64170,
+	YFSREMOVEACL		= 64171,
+	YFSREMOVEFILE2		= 64173,
+	YFSSTOREOPAQUEACL2	= 64174,
+	YFSINLINEBULKSTATUS	= 64536, /* YFS Fetch multiple file statuses with errors */
+	YFSFETCHDATA64		= 64537, /* YFS Fetch file data */
+	YFSSTOREDATA64		= 64538, /* YFS Store file data */
+	YFSUPDATESYMLINK	= 64540,
+};
+
 struct yfs_xdr_u64 {
 	__be32			msw;
 	__be32			lsw;
@@ -55,3 +85,79 @@ struct yfs_xdr_YFSFid {
 	struct yfs_xdr_u64	volume;
 	struct yfs_xdr_vnode	vnode;
 } __packed;
+
+
+struct yfs_xdr_YFSFetchStatus {
+	__be32			type;
+	__be32			nlink;
+	struct yfs_xdr_u64	size;
+	struct yfs_xdr_u64	data_version;
+	struct yfs_xdr_u64	author;
+	struct yfs_xdr_u64	owner;
+	struct yfs_xdr_u64	group;
+	__be32			mode;
+	__be32			caller_access;
+	__be32			anon_access;
+	struct yfs_xdr_vnode	parent;
+	__be32			data_access_protocol;
+	struct yfs_xdr_u64	mtime_client;
+	struct yfs_xdr_u64	mtime_server;
+	__be32			lock_count;
+	__be32			abort_code;
+} __packed;
+
+struct yfs_xdr_YFSCallBack {
+	__be32			version;
+	struct yfs_xdr_u64	expiration_time;
+	__be32			type;
+} __packed;
+
+struct yfs_xdr_YFSStoreStatus {
+	__be32			mask;
+	__be32			mode;
+	struct yfs_xdr_u64	mtime_client;
+	struct yfs_xdr_u64	owner;
+	struct yfs_xdr_u64	group;
+} __packed;
+
+struct yfs_xdr_RPCFlags {
+	__be32			rpc_flags;
+} __packed;
+
+struct yfs_xdr_YFSVolSync {
+	struct yfs_xdr_u64	vol_creation_date;
+	struct yfs_xdr_u64	vol_update_date;
+	struct yfs_xdr_u64	max_quota;
+	struct yfs_xdr_u64	blocks_in_use;
+	struct yfs_xdr_u64	blocks_avail;
+} __packed;
+
+enum yfs_volume_type {
+	yfs_volume_type_ro = 0,
+	yfs_volume_type_rw = 1,
+};
+
+#define yfs_FVSOnline		0x1
+#define yfs_FVSInservice	0x2
+#define yfs_FVSBlessed		0x4
+#define yfs_FVSNeedsSalvage	0x8
+
+struct yfs_xdr_YFSFetchVolumeStatus {
+	struct yfs_xdr_u64	vid;
+	struct yfs_xdr_u64	parent_id;
+	__be32			flags;
+	__be32			type;
+	struct yfs_xdr_u64	max_quota;
+	struct yfs_xdr_u64	blocks_in_use;
+	struct yfs_xdr_u64	part_blocks_avail;
+	struct yfs_xdr_u64	part_max_blocks;
+	struct yfs_xdr_u64	vol_copy_date;
+	struct yfs_xdr_u64	vol_backup_date;
+} __packed;
+
+struct yfs_xdr_YFSStoreVolumeStatus {
+	__be32			mask;
+	struct yfs_xdr_u64	min_quota;
+	struct yfs_xdr_u64	max_quota;
+	struct yfs_xdr_u64	file_quota;
+} __packed;
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 1a087eb8f2d7..aa35cfae5440 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include "afs_fs.h"
 #include "internal.h"
+#include "protocol_yfs.h"
 
 static unsigned afs_server_gc_delay = 10;	/* Server record timeout in seconds */
 static unsigned afs_server_update_delay = 30;	/* Time till VLDB recheck in secs */
@@ -513,6 +514,8 @@ void afs_purge_servers(struct afs_net *net)
  */
 static bool afs_do_probe_fileserver(struct afs_fs_cursor *fc)
 {
+	int i;
+
 	_enter("");
 
 	fc->ac.addr = NULL;
@@ -526,6 +529,11 @@ static bool afs_do_probe_fileserver(struct afs_fs_cursor *fc)
 					&fc->ac, fc->key);
 		switch (fc->ac.error) {
 		case 0:
+			if (test_bit(AFS_SERVER_FL_IS_YFS, &fc->cbi->server->flags)) {
+				for (i = 0; i < fc->ac.alist->nr_addrs; i++)
+					fc->ac.alist->addrs[i].srx_service =
+						YFS_FS_SERVICE;
+			}
 			afs_end_cursor(&fc->ac);
 			set_bit(AFS_SERVER_FL_PROBED, &fc->cbi->server->flags);
 			return true;
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
new file mode 100644
index 000000000000..d5e3f0095040
--- /dev/null
+++ b/fs/afs/yfsclient.c
@@ -0,0 +1,2184 @@
+/* YFS File Server client stubs
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
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/circ_buf.h>
+#include <linux/iversion.h>
+#include "internal.h"
+#include "afs_fs.h"
+#include "xdr_fs.h"
+#include "protocol_yfs.h"
+
+static const struct afs_fid afs_zero_fid;
+
+static inline void afs_use_fs_server(struct afs_call *call, struct afs_cb_interest *cbi)
+{
+	call->cbi = afs_get_cb_interest(cbi);
+}
+
+#define xdr_size(x) (sizeof(*x) / sizeof(__be32))
+
+static void xdr_decode_YFSFid(const __be32 **_bp, struct afs_fid *fid)
+{
+	const struct yfs_xdr_YFSFid *x = (const void *)*_bp;
+
+	fid->vid	= xdr_to_u64(x->volume);
+	fid->vnode	= xdr_to_u64(x->vnode.lo);
+	fid->vnode_hi	= ntohl(x->vnode.hi);
+	fid->unique	= ntohl(x->vnode.unique);
+	*_bp += xdr_size(x);
+}
+
+static __be32 *xdr_encode_u32(__be32 *bp, u32 n)
+{
+	*bp++ = htonl(n);
+	return bp;
+}
+
+static __be32 *xdr_encode_u64(__be32 *bp, u64 n)
+{
+	struct yfs_xdr_u64 *x = (void *)bp;
+
+	*x = u64_to_xdr(n);
+	return bp + xdr_size(x);
+}
+
+static __be32 *xdr_encode_YFSFid(__be32 *bp, struct afs_fid *fid)
+{
+	struct yfs_xdr_YFSFid *x = (void *)bp;
+
+	x->volume	= u64_to_xdr(fid->vid);
+	x->vnode.lo	= u64_to_xdr(fid->vnode);
+	x->vnode.hi	= htonl(fid->vnode_hi);
+	x->vnode.unique	= htonl(fid->unique);
+	return bp + xdr_size(x);
+}
+
+static size_t xdr_strlen(unsigned int len)
+{
+	return sizeof(__be32) + round_up(len, sizeof(__be32));
+}
+
+static __be32 *xdr_encode_string(__be32 *bp, const char *p, unsigned int len)
+{
+	bp = xdr_encode_u32(bp, len);
+	bp = memcpy(bp, p, len);
+	if (len & 3) {
+		unsigned int pad = 4 - (len & 3);
+
+		memset((u8 *)bp + len, 0, pad);
+		len += pad;
+	}
+
+	return bp + len / sizeof(__be32);
+}
+
+static s64 linux_to_yfs_time(const struct timespec64 *t)
+{
+	/* Convert to 100ns intervals. */
+	return (u64)t->tv_sec * 10000000 + t->tv_nsec/100;
+}
+
+static __be32 *xdr_encode_YFSStoreStatus_mode(__be32 *bp, mode_t mode)
+{
+	struct yfs_xdr_YFSStoreStatus *x = (void *)bp;
+
+	x->mask		= htonl(AFS_SET_MODE);
+	x->mode		= htonl(mode & S_IALLUGO);
+	x->mtime_client	= u64_to_xdr(0);
+	x->owner	= u64_to_xdr(0);
+	x->group	= u64_to_xdr(0);
+	return bp + xdr_size(x);
+}
+
+static __be32 *xdr_encode_YFSStoreStatus_mtime(__be32 *bp, const struct timespec64 *t)
+{
+	struct yfs_xdr_YFSStoreStatus *x = (void *)bp;
+	s64 mtime = linux_to_yfs_time(t);
+
+	x->mask		= htonl(AFS_SET_MTIME);
+	x->mode		= htonl(0);
+	x->mtime_client	= u64_to_xdr(mtime);
+	x->owner	= u64_to_xdr(0);
+	x->group	= u64_to_xdr(0);
+	return bp + xdr_size(x);
+}
+
+/*
+ * Convert a signed 100ns-resolution 64-bit time into a timespec.
+ */
+static struct timespec64 yfs_time_to_linux(s64 t)
+{
+	struct timespec64 ts;
+	u64 abs_t;
+
+	/*
+	 * Unfortunately can not use normal 64 bit division on 32 bit arch, but
+	 * the alternative, do_div, does not work with negative numbers so have
+	 * to special case them
+	 */
+	if (t < 0) {
+		abs_t = -t;
+		ts.tv_nsec = (time64_t)(do_div(abs_t, 10000000) * 100);
+		ts.tv_nsec = -ts.tv_nsec;
+		ts.tv_sec = -abs_t;
+	} else {
+		abs_t = t;
+		ts.tv_nsec = (time64_t)do_div(abs_t, 10000000) * 100;
+		ts.tv_sec = abs_t;
+	}
+
+	return ts;
+}
+
+static struct timespec64 xdr_to_time(const struct yfs_xdr_u64 xdr)
+{
+	s64 t = xdr_to_u64(xdr);
+
+	return yfs_time_to_linux(t);
+}
+
+static void yfs_check_req(struct afs_call *call, __be32 *bp)
+{
+	size_t len = (void *)bp - call->request;
+
+	if (len > call->request_size)
+		pr_err("kAFS: %s: Request buffer overflow (%zu>%u)\n",
+		       call->type->name, len, call->request_size);
+	else if (len < call->request_size)
+		pr_warning("kAFS: %s: Request buffer underflow (%zu<%u)\n",
+			   call->type->name, len, call->request_size);
+}
+
+/*
+ * Dump a bad file status record.
+ */
+static void xdr_dump_bad(const __be32 *bp)
+{
+	__be32 x[4];
+	int i;
+
+	pr_notice("YFS XDR: Bad status record\n");
+	for (i = 0; i < 5 * 4 * 4; i += 16) {
+		memcpy(x, bp, 16);
+		bp += 4;
+		pr_notice("%03x: %08x %08x %08x %08x\n",
+			  i, ntohl(x[0]), ntohl(x[1]), ntohl(x[2]), ntohl(x[3]));
+	}
+
+	memcpy(x, bp, 4);
+	pr_notice("0x50: %08x\n", ntohl(x[0]));
+}
+
+/*
+ * Decode a YFSFetchStatus block
+ */
+static int xdr_decode_YFSFetchStatus(struct afs_call *call,
+				     const __be32 **_bp,
+				     struct afs_file_status *status,
+				     struct afs_vnode *vnode,
+				     const afs_dataversion_t *expected_version,
+				     struct afs_read *read_req)
+{
+	const struct yfs_xdr_YFSFetchStatus *xdr = (const void *)*_bp;
+	u32 type;
+	u8 flags = 0;
+
+	status->abort_code = ntohl(xdr->abort_code);
+	if (status->abort_code != 0) {
+		if (vnode && status->abort_code == VNOVNODE) {
+			set_bit(AFS_VNODE_DELETED, &vnode->flags);
+			status->nlink = 0;
+			__afs_break_callback(vnode);
+		}
+		return 0;
+	}
+
+	type = ntohl(xdr->type);
+	switch (type) {
+	case AFS_FTYPE_FILE:
+	case AFS_FTYPE_DIR:
+	case AFS_FTYPE_SYMLINK:
+		if (type != status->type &&
+		    vnode &&
+		    !test_bit(AFS_VNODE_UNSET, &vnode->flags)) {
+			pr_warning("Vnode %llx:%llx:%x changed type %u to %u\n",
+				   vnode->fid.vid,
+				   vnode->fid.vnode,
+				   vnode->fid.unique,
+				   status->type, type);
+			goto bad;
+		}
+		status->type = type;
+		break;
+	default:
+		goto bad;
+	}
+
+#define EXTRACT_M4(FIELD)					\
+	do {							\
+		u32 x = ntohl(xdr->FIELD);			\
+		if (status->FIELD != x) {			\
+			flags |= AFS_VNODE_META_CHANGED;	\
+			status->FIELD = x;			\
+		}						\
+	} while (0)
+
+#define EXTRACT_M8(FIELD)					\
+	do {							\
+		u64 x = xdr_to_u64(xdr->FIELD);			\
+		if (status->FIELD != x) {			\
+			flags |= AFS_VNODE_META_CHANGED;	\
+			status->FIELD = x;			\
+		}						\
+	} while (0)
+
+#define EXTRACT_D8(FIELD)					\
+	do {							\
+		u64 x = xdr_to_u64(xdr->FIELD);			\
+		if (status->FIELD != x) {			\
+			flags |= AFS_VNODE_DATA_CHANGED;	\
+			status->FIELD = x;			\
+		}						\
+	} while (0)
+
+	EXTRACT_M4(nlink);
+	EXTRACT_D8(size);
+	EXTRACT_D8(data_version);
+	EXTRACT_M8(author);
+	EXTRACT_M8(owner);
+	EXTRACT_M8(group);
+	EXTRACT_M4(mode);
+	EXTRACT_M4(caller_access); /* call ticket dependent */
+	EXTRACT_M4(anon_access);
+
+	status->mtime_client = xdr_to_time(xdr->mtime_client);
+	status->mtime_server = xdr_to_time(xdr->mtime_server);
+	status->lock_count   = ntohl(xdr->lock_count);
+
+	if (read_req) {
+		read_req->data_version = status->data_version;
+		read_req->file_size = status->size;
+	}
+
+	*_bp += xdr_size(xdr);
+
+	if (vnode) {
+		if (test_bit(AFS_VNODE_UNSET, &vnode->flags))
+			flags |= AFS_VNODE_NOT_YET_SET;
+		afs_update_inode_from_status(vnode, status, expected_version,
+					     flags);
+	}
+
+	return 0;
+
+bad:
+	xdr_dump_bad(*_bp);
+	return afs_protocol_error(call, -EBADMSG, afs_eproto_bad_status);
+}
+
+/*
+ * Decode the file status.  We need to lock the target vnode if we're going to
+ * update its status so that stat() sees the attributes update atomically.
+ */
+static int yfs_decode_status(struct afs_call *call,
+			     const __be32 **_bp,
+			     struct afs_file_status *status,
+			     struct afs_vnode *vnode,
+			     const afs_dataversion_t *expected_version,
+			     struct afs_read *read_req)
+{
+	int ret;
+
+	if (!vnode)
+		return xdr_decode_YFSFetchStatus(call, _bp, status, vnode,
+						 expected_version, read_req);
+
+	write_seqlock(&vnode->cb_lock);
+	ret = xdr_decode_YFSFetchStatus(call, _bp, status, vnode,
+					expected_version, read_req);
+	write_sequnlock(&vnode->cb_lock);
+	return ret;
+}
+
+/*
+ * Decode a YFSCallBack block
+ */
+static void xdr_decode_YFSCallBack(struct afs_call *call,
+				   struct afs_vnode *vnode,
+				   const __be32 **_bp)
+{
+	struct yfs_xdr_YFSCallBack *xdr = (void *)*_bp;
+	struct afs_cb_interest *old, *cbi = call->cbi;
+	u64 cb_expiry;
+
+	write_seqlock(&vnode->cb_lock);
+
+	if (call->cb_break == afs_cb_break_sum(vnode, cbi)) {
+		cb_expiry = xdr_to_u64(xdr->expiration_time);
+		do_div(cb_expiry, 10 * 1000 * 1000);
+		vnode->cb_version	= ntohl(xdr->version);
+		vnode->cb_type		= ntohl(xdr->type);
+		vnode->cb_expires_at	= cb_expiry + ktime_get_real_seconds();
+		old = vnode->cb_interest;
+		if (old != call->cbi) {
+			vnode->cb_interest = cbi;
+			cbi = old;
+		}
+		set_bit(AFS_VNODE_CB_PROMISED, &vnode->flags);
+	}
+
+	write_sequnlock(&vnode->cb_lock);
+	call->cbi = cbi;
+	*_bp += xdr_size(xdr);
+}
+
+static void xdr_decode_YFSCallBack_raw(const __be32 **_bp,
+				       struct afs_callback *cb)
+{
+	struct yfs_xdr_YFSCallBack *x = (void *)*_bp;
+	u64 cb_expiry;
+
+	cb_expiry = xdr_to_u64(x->expiration_time);
+	do_div(cb_expiry, 10 * 1000 * 1000);
+	cb->version	= ntohl(x->version);
+	cb->type	= ntohl(x->type);
+	cb->expires_at	= cb_expiry + ktime_get_real_seconds();
+
+	*_bp += xdr_size(x);
+}
+
+/*
+ * Decode a YFSVolSync block
+ */
+static void xdr_decode_YFSVolSync(const __be32 **_bp,
+				  struct afs_volsync *volsync)
+{
+	struct yfs_xdr_YFSVolSync *x = (void *)*_bp;
+	u64 creation;
+
+	if (volsync) {
+		creation = xdr_to_u64(x->vol_creation_date);
+		do_div(creation, 10 * 1000 * 1000);
+		volsync->creation = creation;
+	}
+
+	*_bp += xdr_size(x);
+}
+
+/*
+ * Encode the requested attributes into a YFSStoreStatus block
+ */
+static __be32 *xdr_encode_YFS_StoreStatus(__be32 *bp, struct iattr *attr)
+{
+	struct yfs_xdr_YFSStoreStatus *x = (void *)bp;
+	s64 mtime = 0, owner = 0, group = 0;
+	u32 mask = 0, mode = 0;
+
+	mask = 0;
+	if (attr->ia_valid & ATTR_MTIME) {
+		mask |= AFS_SET_MTIME;
+		mtime = linux_to_yfs_time(&attr->ia_mtime);
+	}
+
+	if (attr->ia_valid & ATTR_UID) {
+		mask |= AFS_SET_OWNER;
+		owner = from_kuid(&init_user_ns, attr->ia_uid);
+	}
+
+	if (attr->ia_valid & ATTR_GID) {
+		mask |= AFS_SET_GROUP;
+		group = from_kgid(&init_user_ns, attr->ia_gid);
+	}
+
+	if (attr->ia_valid & ATTR_MODE) {
+		mask |= AFS_SET_MODE;
+		mode = attr->ia_mode & S_IALLUGO;
+	}
+
+	x->mask		= htonl(mask);
+	x->mode		= htonl(mode);
+	x->mtime_client	= u64_to_xdr(mtime);
+	x->owner	= u64_to_xdr(owner);
+	x->group	= u64_to_xdr(group);
+	return bp + xdr_size(x);
+}
+
+/*
+ * Decode a YFSFetchVolumeStatus block.
+ */
+static void xdr_decode_YFSFetchVolumeStatus(const __be32 **_bp,
+					    struct afs_volume_status *vs)
+{
+	const struct yfs_xdr_YFSFetchVolumeStatus *x = (const void *)*_bp;
+	u32 flags;
+
+	vs->vid			= xdr_to_u64(x->vid);
+	vs->parent_id		= xdr_to_u64(x->parent_id);
+	flags			= ntohl(x->flags);
+	vs->online		= flags & yfs_FVSOnline;
+	vs->in_service		= flags & yfs_FVSInservice;
+	vs->blessed		= flags & yfs_FVSBlessed;
+	vs->needs_salvage	= flags & yfs_FVSNeedsSalvage;
+	vs->type		= ntohl(x->type);
+	vs->min_quota		= 0;
+	vs->max_quota		= xdr_to_u64(x->max_quota);
+	vs->blocks_in_use	= xdr_to_u64(x->blocks_in_use);
+	vs->part_blocks_avail	= xdr_to_u64(x->part_blocks_avail);
+	vs->part_max_blocks	= xdr_to_u64(x->part_max_blocks);
+	vs->vol_copy_date	= xdr_to_u64(x->vol_copy_date);
+	vs->vol_backup_date	= xdr_to_u64(x->vol_backup_date);
+	*_bp += sizeof(*x) / sizeof(__be32);
+}
+
+/*
+ * deliver reply data to an FS.FetchStatus
+ */
+static int yfs_deliver_fs_fetch_status_vnode(struct afs_call *call)
+{
+	struct afs_vnode *vnode = call->reply[0];
+	const __be32 *bp;
+	int ret;
+
+	ret = afs_transfer_reply(call);
+	if (ret < 0)
+		return ret;
+
+	_enter("{%llx:%llu}", vnode->fid.vid, vnode->fid.vnode);
+
+	/* unmarshall the reply once we've received all of it */
+	bp = call->buffer;
+	ret = yfs_decode_status(call, &bp, &vnode->status, vnode,
+				&call->expected_version, NULL);
+	if (ret < 0)
+		return ret;
+	xdr_decode_YFSCallBack(call, vnode, &bp);
+	xdr_decode_YFSVolSync(&bp, call->reply[1]);
+
+	_leave(" = 0 [done]");
+	return 0;
+}
+
+/*
+ * YFS.FetchStatus operation type
+ */
+static const struct afs_call_type yfs_RXYFSFetchStatus_vnode = {
+	.name		= "YFS.FetchStatus(vnode)",
+	.op		= yfs_FS_FetchStatus,
+	.deliver	= yfs_deliver_fs_fetch_status_vnode,
+	.destructor	= afs_flat_call_destructor,
+};
+
+/*
+ * Fetch the status information for a file.
+ */
+int yfs_fs_fetch_file_status(struct afs_fs_cursor *fc, struct afs_volsync *volsync,
+			     bool new_inode)
+{
+	struct afs_vnode *vnode = fc->vnode;
+	struct afs_call *call;
+	struct afs_net *net = afs_v2net(vnode);
+	__be32 *bp;
+
+	_enter(",%x,{%llx:%llu},,",
+	       key_serial(fc->key), vnode->fid.vid, vnode->fid.vnode);
+
+	call = afs_alloc_flat_call(net, &yfs_RXYFSFetchStatus_vnode,
+				   sizeof(__be32) * 2 +
+				   sizeof(struct yfs_xdr_YFSFid),
+				   sizeof(struct yfs_xdr_YFSFetchStatus) +
+				   sizeof(struct yfs_xdr_YFSCallBack) +
+				   sizeof(struct yfs_xdr_YFSVolSync));
+	if (!call) {
+		fc->ac.error = -ENOMEM;
+		return -ENOMEM;
+	}
+
+	call->key = fc->key;
+	call->reply[0] = vnode;
+	call->reply[1] = volsync;
+	call->expected_version = new_inode ? 1 : vnode->status.data_version;
+
+	/* marshall the parameters */
+	bp = call->request;
+	bp = xdr_encode_u32(bp, YFSFETCHSTATUS);
+	bp = xdr_encode_u32(bp, 0); /* RPC flags */
+	bp = xdr_encode_YFSFid(bp, &vnode->fid);
+	yfs_check_req(call, bp);
+
+	call->cb_break = fc->cb_break;
+	afs_use_fs_server(call, fc->cbi);
+	trace_afs_make_fs_call(call, &vnode->fid);
+	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+}
+
+/*
+ * Deliver reply data to an YFS.FetchData64.
+ */
+static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
+{
+	struct afs_vnode *vnode = call->reply[0];
+	struct afs_read *req = call->reply[2];
+	const __be32 *bp;
+	unsigned int size;
+	int ret;
+
+	_enter("{%u,%zu/%llu}",
+	       call->unmarshall, iov_iter_count(&call->iter), req->actual_len);
+
+	switch (call->unmarshall) {
+	case 0:
+		req->actual_len = 0;
+		req->index = 0;
+		req->offset = req->pos & (PAGE_SIZE - 1);
+		afs_extract_to_tmp64(call);
+		call->unmarshall++;
+
+		/* extract the returned data length */
+	case 1:
+		_debug("extract data length");
+		ret = afs_extract_data(call, true);
+		if (ret < 0)
+			return ret;
+
+		req->actual_len = be64_to_cpu(call->tmp64);
+		_debug("DATA length: %llu", req->actual_len);
+		req->remain = min(req->len, req->actual_len);
+		if (req->remain == 0)
+			goto no_more_data;
+
+		call->unmarshall++;
+
+	begin_page:
+		ASSERTCMP(req->index, <, req->nr_pages);
+		if (req->remain > PAGE_SIZE - req->offset)
+			size = PAGE_SIZE - req->offset;
+		else
+			size = req->remain;
+		call->bvec[0].bv_len = size;
+		call->bvec[0].bv_offset = req->offset;
+		call->bvec[0].bv_page = req->pages[req->index];
+		iov_iter_bvec(&call->iter, READ, call->bvec, 1, size);
+		ASSERTCMP(size, <=, PAGE_SIZE);
+
+		/* extract the returned data */
+	case 2:
+		_debug("extract data %zu/%llu",
+		       iov_iter_count(&call->iter), req->remain);
+
+		ret = afs_extract_data(call, true);
+		if (ret < 0)
+			return ret;
+		req->remain -= call->bvec[0].bv_len;
+		req->offset += call->bvec[0].bv_len;
+		ASSERTCMP(req->offset, <=, PAGE_SIZE);
+		if (req->offset == PAGE_SIZE) {
+			req->offset = 0;
+			if (req->page_done)
+				req->page_done(call, req);
+			req->index++;
+			if (req->remain > 0)
+				goto begin_page;
+		}
+
+		ASSERTCMP(req->remain, ==, 0);
+		if (req->actual_len <= req->len)
+			goto no_more_data;
+
+		/* Discard any excess data the server gave us */
+		iov_iter_discard(&call->iter, READ, req->actual_len - req->len);
+		call->unmarshall = 3;
+	case 3:
+		_debug("extract discard %zu/%llu",
+		       iov_iter_count(&call->iter), req->actual_len - req->len);
+
+		ret = afs_extract_data(call, true);
+		if (ret < 0)
+			return ret;
+
+	no_more_data:
+		call->unmarshall = 4;
+		afs_extract_to_buf(call,
+				   sizeof(struct yfs_xdr_YFSFetchStatus) +
+				   sizeof(struct yfs_xdr_YFSCallBack) +
+				   sizeof(struct yfs_xdr_YFSVolSync));
+
+		/* extract the metadata */
+	case 4:
+		ret = afs_extract_data(call, false);
+		if (ret < 0)
+			return ret;
+
+		bp = call->buffer;
+		ret = yfs_decode_status(call, &bp, &vnode->status, vnode,
+					&vnode->status.data_version, req);
+		if (ret < 0)
+			return ret;
+		xdr_decode_YFSCallBack(call, vnode, &bp);
+		xdr_decode_YFSVolSync(&bp, call->reply[1]);
+
+		call->unmarshall++;
+
+	case 5:
+		break;
+	}
+
+	for (; req->index < req->nr_pages; req->index++) {
+		if (req->offset < PAGE_SIZE)
+			zero_user_segment(req->pages[req->index],
+					  req->offset, PAGE_SIZE);
+		if (req->page_done)
+			req->page_done(call, req);
+		req->offset = 0;
+	}
+
+	_leave(" = 0 [done]");
+	return 0;
+}
+
+static void yfs_fetch_data_destructor(struct afs_call *call)
+{
+	struct afs_read *req = call->reply[2];
+
+	afs_put_read(req);
+	afs_flat_call_destructor(call);
+}
+
+/*
+ * YFS.FetchData64 operation type
+ */
+static const struct afs_call_type yfs_RXYFSFetchData64 = {
+	.name		= "YFS.FetchData64",
+	.op		= yfs_FS_FetchData64,
+	.deliver	= yfs_deliver_fs_fetch_data64,
+	.destructor	= yfs_fetch_data_destructor,
+};
+
+/*
+ * Fetch data from a file.
+ */
+int yfs_fs_fetch_data(struct afs_fs_cursor *fc, struct afs_read *req)
+{
+	struct afs_vnode *vnode = fc->vnode;
+	struct afs_call *call;
+	struct afs_net *net = afs_v2net(vnode);
+	__be32 *bp;
+
+	_enter(",%x,{%llx:%llu},%llx,%llx",
+	       key_serial(fc->key), vnode->fid.vid, vnode->fid.vnode,
+	       req->pos, req->len);
+
+	call = afs_alloc_flat_call(net, &yfs_RXYFSFetchData64,
+				   sizeof(__be32) * 2 +
+				   sizeof(struct yfs_xdr_YFSFid) +
+				   sizeof(struct yfs_xdr_u64) * 2,
+				   sizeof(struct yfs_xdr_YFSFetchStatus) +
+				   sizeof(struct yfs_xdr_YFSCallBack) +
+				   sizeof(struct yfs_xdr_YFSVolSync));
+	if (!call)
+		return -ENOMEM;
+
+	call->key = fc->key;
+	call->reply[0] = vnode;
+	call->reply[1] = NULL; /* volsync */
+	call->reply[2] = req;
+	call->expected_version = vnode->status.data_version;
+	call->want_reply_time = true;
+
+	/* marshall the parameters */
+	bp = call->request;
+	bp = xdr_encode_u32(bp, YFSFETCHDATA64);
+	bp = xdr_encode_u32(bp, 0); /* RPC flags */
+	bp = xdr_encode_YFSFid(bp, &vnode->fid);
+	bp = xdr_encode_u64(bp, req->pos);
+	bp = xdr_encode_u64(bp, req->len);
+	yfs_check_req(call, bp);
+
+	refcount_inc(&req->usage);
+	call->cb_break = fc->cb_break;
+	afs_use_fs_server(call, fc->cbi);
+	trace_afs_make_fs_call(call, &vnode->fid);
+	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+}
+
+/*
+ * Deliver reply data for YFS.CreateFile or YFS.MakeDir.
+ */
+static int yfs_deliver_fs_create_vnode(struct afs_call *call)
+{
+	struct afs_vnode *vnode = call->reply[0];
+	const __be32 *bp;
+	int ret;
+
+	_enter("{%u}", call->unmarshall);
+
+	ret = afs_transfer_reply(call);
+	if (ret < 0)
+		return ret;
+
+	/* unmarshall the reply once we've received all of it */
+	bp = call->buffer;
+	xdr_decode_YFSFid(&bp, call->reply[1]);
+	ret = yfs_decode_status(call, &bp, call->reply[2], NULL, NULL, NULL);
+	if (ret < 0)
+		return ret;
+	ret = yfs_decode_status(call, &bp, &vnode->status, vnode,
+				&call->expected_version, NULL);
+	if (ret < 0)
+		return ret;
+	xdr_decode_YFSCallBack_raw(&bp, call->reply[3]);
+	xdr_decode_YFSVolSync(&bp, NULL);
+
+	_leave(" = 0 [done]");
+	return 0;
+}
+
+/*
+ * FS.CreateFile and FS.MakeDir operation type
+ */
+static const struct afs_call_type afs_RXFSCreateFile = {
+	.name		= "YFS.CreateFile",
+	.op		= yfs_FS_CreateFile,
+	.deliver	= yfs_deliver_fs_create_vnode,
+	.destructor	= afs_flat_call_destructor,
+};
+
+/*
+ * Create a file.
+ */
+int yfs_fs_create_file(struct afs_fs_cursor *fc,
+		       const char *name,
+		       umode_t mode,
+		       u64 current_data_version,
+		       struct afs_fid *newfid,
+		       struct afs_file_status *newstatus,
+		       struct afs_callback *newcb)
+{
+	struct afs_vnode *vnode = fc->vnode;
+	struct afs_call *call;
+	struct afs_net *net = afs_v2net(vnode);
+	size_t namesz, reqsz, rplsz;
+	__be32 *bp;
+
+	_enter("");
+
+	namesz = strlen(name);
+	reqsz = (sizeof(__be32) +
+		 sizeof(__be32) +
+		 sizeof(struct yfs_xdr_YFSFid) +
+		 xdr_strlen(namesz) +
+		 sizeof(struct yfs_xdr_YFSStoreStatus) +
+		 sizeof(__be32));
+	rplsz = (sizeof(struct yfs_xdr_YFSFid) +
+		 sizeof(struct yfs_xdr_YFSFetchStatus) +
+		 sizeof(struct yfs_xdr_YFSFetchStatus) +
+		 sizeof(struct yfs_xdr_YFSCallBack) +
+		 sizeof(struct yfs_xdr_YFSVolSync));
+
+	call = afs_alloc_flat_call(net, &afs_RXFSCreateFile, reqsz, rplsz);
+	if (!call)
+		return -ENOMEM;
+
+	call->key = fc->key;
+	call->reply[0] = vnode;
+	call->reply[1] = newfid;
+	call->reply[2] = newstatus;
+	call->reply[3] = newcb;
+	call->expected_version = current_data_version + 1;
+
+	/* marshall the parameters */
+	bp = call->request;
+	bp = xdr_encode_u32(bp, YFSCREATEFILE);
+	bp = xdr_encode_u32(bp, 0); /* RPC flags */
+	bp = xdr_encode_YFSFid(bp, &vnode->fid);
+	bp = xdr_encode_string(bp, name, namesz);
+	bp = xdr_encode_YFSStoreStatus_mode(bp, mode);
+	bp = xdr_encode_u32(bp, 0); /* ViceLockType */
+	yfs_check_req(call, bp);
+
+	afs_use_fs_server(call, fc->cbi);
+	trace_afs_make_fs_call(call, &vnode->fid);
+	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+}
+
+static const struct afs_call_type yfs_RXFSMakeDir = {
+	.name		= "YFS.MakeDir",
+	.op		= yfs_FS_MakeDir,
+	.deliver	= yfs_deliver_fs_create_vnode,
+	.destructor	= afs_flat_call_destructor,
+};
+
+/*
+ * Make a directory.
+ */
+int yfs_fs_make_dir(struct afs_fs_cursor *fc,
+		    const char *name,
+		    umode_t mode,
+		    u64 current_data_version,
+		    struct afs_fid *newfid,
+		    struct afs_file_status *newstatus,
+		    struct afs_callback *newcb)
+{
+	struct afs_vnode *vnode = fc->vnode;
+	struct afs_call *call;
+	struct afs_net *net = afs_v2net(vnode);
+	size_t namesz, reqsz, rplsz;
+	__be32 *bp;
+
+	_enter("");
+
+	namesz = strlen(name);
+	reqsz = (sizeof(__be32) +
+		 sizeof(struct yfs_xdr_RPCFlags) +
+		 sizeof(struct yfs_xdr_YFSFid) +
+		 xdr_strlen(namesz) +
+		 sizeof(struct yfs_xdr_YFSStoreStatus));
+	rplsz = (sizeof(struct yfs_xdr_YFSFid) +
+		 sizeof(struct yfs_xdr_YFSFetchStatus) +
+		 sizeof(struct yfs_xdr_YFSFetchStatus) +
+		 sizeof(struct yfs_xdr_YFSCallBack) +
+		 sizeof(struct yfs_xdr_YFSVolSync));
+
+	call = afs_alloc_flat_call(net, &yfs_RXFSMakeDir, reqsz, rplsz);
+	if (!call)
+		return -ENOMEM;
+
+	call->key = fc->key;
+	call->reply[0] = vnode;
+	call->reply[1] = newfid;
+	call->reply[2] = newstatus;
+	call->reply[3] = newcb;
+	call->expected_version = current_data_version + 1;
+
+	/* marshall the parameters */
+	bp = call->request;
+	bp = xdr_encode_u32(bp, YFSMAKEDIR);
+	bp = xdr_encode_u32(bp, 0); /* RPC flags */
+	bp = xdr_encode_YFSFid(bp, &vnode->fid);
+	bp = xdr_encode_string(bp, name, namesz);
+	bp = xdr_encode_YFSStoreStatus_mode(bp, mode);
+	yfs_check_req(call, bp);
+
+	afs_use_fs_server(call, fc->cbi);
+	trace_afs_make_fs_call(call, &vnode->fid);
+	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+}
+
+/*
+ * Deliver reply data to a YFS.RemoveFile2 operation.
+ */
+static int yfs_deliver_fs_remove_file2(struct afs_call *call)
+{
+	struct afs_vnode *dvnode = call->reply[0];
+	struct afs_vnode *vnode = call->reply[1];
+	struct afs_fid fid;
+	const __be32 *bp;
+	int ret;
+
+	_enter("{%u}", call->unmarshall);
+
+	ret = afs_transfer_reply(call);
+	if (ret < 0)
+		return ret;
+
+	/* unmarshall the reply once we've received all of it */
+	bp = call->buffer;
+	ret = yfs_decode_status(call, &bp, &dvnode->status, dvnode,
+				&call->expected_version, NULL);
+	if (ret < 0)
+		return ret;
+
+	xdr_decode_YFSFid(&bp, &fid);
+	ret = yfs_decode_status(call, &bp, &vnode->status, vnode, NULL, NULL);
+	if (ret < 0)
+		return ret;
+	/* Was deleted if vnode->status.abort_code == VNOVNODE. */
+
+	xdr_decode_YFSVolSync(&bp, NULL);
+	return 0;
+}
+
+/*
+ * YFS.RemoveFile2 operation type.
+ */
+static const struct afs_call_type yfs_RXYFSRemoveFile2 = {
+	.name		= "YFS.RemoveFile2",
+	.op		= yfs_FS_RemoveFile2,
+	.deliver	= yfs_deliver_fs_remove_file2,
+	.destructor	= afs_flat_call_destructor,
+};
+
+/*
+ * Remove a file and retrieve new file status.
+ */
+int yfs_fs_remove_file2(struct afs_fs_cursor *fc, struct afs_vnode *vnode,
+			const char *name, u64 current_data_version)
+{
+	struct afs_vnode *dvnode = fc->vnode;
+	struct afs_call *call;
+	struct afs_net *net = afs_v2net(dvnode);
+	size_t namesz;
+	__be32 *bp;
+
+	_enter("");
+
+	namesz = strlen(name);
+
+	call = afs_alloc_flat_call(net, &yfs_RXYFSRemoveFile2,
+				   sizeof(__be32) +
+				   sizeof(struct yfs_xdr_RPCFlags) +
+				   sizeof(struct yfs_xdr_YFSFid) +
+				   xdr_strlen(namesz),
+				   sizeof(struct yfs_xdr_YFSFetchStatus) +
+				   sizeof(struct yfs_xdr_YFSFid) +
+				   sizeof(struct yfs_xdr_YFSFetchStatus) +
+				   sizeof(struct yfs_xdr_YFSVolSync));
+	if (!call)
+		return -ENOMEM;
+
+	call->key = fc->key;
+	call->reply[0] = dvnode;
+	call->reply[1] = vnode;
+	call->expected_version = current_data_version + 1;
+
+	/* marshall the parameters */
+	bp = call->request;
+	bp = xdr_encode_u32(bp, YFSREMOVEFILE2);
+	bp = xdr_encode_u32(bp, 0); /* RPC flags */
+	bp = xdr_encode_YFSFid(bp, &dvnode->fid);
+	bp = xdr_encode_string(bp, name, namesz);
+	yfs_check_req(call, bp);
+
+	afs_use_fs_server(call, fc->cbi);
+	trace_afs_make_fs_call(call, &dvnode->fid);
+	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+}
+
+/*
+ * Deliver reply data to a YFS.RemoveFile or YFS.RemoveDir operation.
+ */
+static int yfs_deliver_fs_remove(struct afs_call *call)
+{
+	struct afs_vnode *dvnode = call->reply[0];
+	const __be32 *bp;
+	int ret;
+
+	_enter("{%u}", call->unmarshall);
+
+	ret = afs_transfer_reply(call);
+	if (ret < 0)
+		return ret;
+
+	/* unmarshall the reply once we've received all of it */
+	bp = call->buffer;
+	ret = yfs_decode_status(call, &bp, &dvnode->status, dvnode,
+				&call->expected_version, NULL);
+	if (ret < 0)
+		return ret;
+
+	xdr_decode_YFSVolSync(&bp, NULL);
+	return 0;
+}
+
+/*
+ * FS.RemoveDir and FS.RemoveFile operation types.
+ */
+static const struct afs_call_type yfs_RXYFSRemoveFile = {
+	.name		= "YFS.RemoveFile",
+	.op		= yfs_FS_RemoveFile,
+	.deliver	= yfs_deliver_fs_remove,
+	.destructor	= afs_flat_call_destructor,
+};
+
+static const struct afs_call_type yfs_RXYFSRemoveDir = {
+	.name		= "YFS.RemoveDir",
+	.op		= yfs_FS_RemoveDir,
+	.deliver	= yfs_deliver_fs_remove,
+	.destructor	= afs_flat_call_destructor,
+};
+
+/*
+ * remove a file or directory
+ */
+int yfs_fs_remove(struct afs_fs_cursor *fc, struct afs_vnode *vnode,
+		  const char *name, bool isdir, u64 current_data_version)
+{
+	struct afs_vnode *dvnode = fc->vnode;
+	struct afs_call *call;
+	struct afs_net *net = afs_v2net(dvnode);
+	size_t namesz;
+	__be32 *bp;
+
+	_enter("");
+
+	namesz = strlen(name);
+	call = afs_alloc_flat_call(
+		net, isdir ? &yfs_RXYFSRemoveDir : &yfs_RXYFSRemoveFile,
+		sizeof(__be32) +
+		sizeof(struct yfs_xdr_RPCFlags) +
+		sizeof(struct yfs_xdr_YFSFid) +
+		xdr_strlen(namesz),
+		sizeof(struct yfs_xdr_YFSFetchStatus) +
+		sizeof(struct yfs_xdr_YFSVolSync));
+	if (!call)
+		return -ENOMEM;
+
+	call->key = fc->key;
+	call->reply[0] = dvnode;
+	call->reply[1] = vnode;
+	call->expected_version = current_data_version + 1;
+
+	/* marshall the parameters */
+	bp = call->request;
+	bp = xdr_encode_u32(bp, isdir ? YFSREMOVEDIR : YFSREMOVEFILE);
+	bp = xdr_encode_u32(bp, 0); /* RPC flags */
+	bp = xdr_encode_YFSFid(bp, &dvnode->fid);
+	bp = xdr_encode_string(bp, name, namesz);
+	yfs_check_req(call, bp);
+
+	afs_use_fs_server(call, fc->cbi);
+	trace_afs_make_fs_call(call, &dvnode->fid);
+	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+}
+
+/*
+ * Deliver reply data to a YFS.Link operation.
+ */
+static int yfs_deliver_fs_link(struct afs_call *call)
+{
+	struct afs_vnode *dvnode = call->reply[0], *vnode = call->reply[1];
+	const __be32 *bp;
+	int ret;
+
+	_enter("{%u}", call->unmarshall);
+
+	ret = afs_transfer_reply(call);
+	if (ret < 0)
+		return ret;
+
+	/* unmarshall the reply once we've received all of it */
+	bp = call->buffer;
+	ret = yfs_decode_status(call, &bp, &vnode->status, vnode, NULL, NULL);
+	if (ret < 0)
+		return ret;
+	ret = yfs_decode_status(call, &bp, &dvnode->status, dvnode,
+				&call->expected_version, NULL);
+	if (ret < 0)
+		return ret;
+	xdr_decode_YFSVolSync(&bp, NULL);
+	_leave(" = 0 [done]");
+	return 0;
+}
+
+/*
+ * YFS.Link operation type.
+ */
+static const struct afs_call_type yfs_RXYFSLink = {
+	.name		= "YFS.Link",
+	.op		= yfs_FS_Link,
+	.deliver	= yfs_deliver_fs_link,
+	.destructor	= afs_flat_call_destructor,
+};
+
+/*
+ * Make a hard link.
+ */
+int yfs_fs_link(struct afs_fs_cursor *fc, struct afs_vnode *vnode,
+		const char *name, u64 current_data_version)
+{
+	struct afs_vnode *dvnode = fc->vnode;
+	struct afs_call *call;
+	struct afs_net *net = afs_v2net(vnode);
+	size_t namesz;
+	__be32 *bp;
+
+	_enter("");
+
+	namesz = strlen(name);
+	call = afs_alloc_flat_call(net, &yfs_RXYFSLink,
+				   sizeof(__be32) +
+				   sizeof(struct yfs_xdr_RPCFlags) +
+				   sizeof(struct yfs_xdr_YFSFid) +
+				   xdr_strlen(namesz) +
+				   sizeof(struct yfs_xdr_YFSFid),
+				   sizeof(struct yfs_xdr_YFSFetchStatus) +
+				   sizeof(struct yfs_xdr_YFSFetchStatus) +
+				   sizeof(struct yfs_xdr_YFSVolSync));
+	if (!call)
+		return -ENOMEM;
+
+	call->key = fc->key;
+	call->reply[0] = dvnode;
+	call->reply[1] = vnode;
+	call->expected_version = current_data_version + 1;
+
+	/* marshall the parameters */
+	bp = call->request;
+	bp = xdr_encode_u32(bp, YFSLINK);
+	bp = xdr_encode_u32(bp, 0); /* RPC flags */
+	bp = xdr_encode_YFSFid(bp, &dvnode->fid);
+	bp = xdr_encode_string(bp, name, namesz);
+	bp = xdr_encode_YFSFid(bp, &vnode->fid);
+	yfs_check_req(call, bp);
+
+	afs_use_fs_server(call, fc->cbi);
+	trace_afs_make_fs_call(call, &vnode->fid);
+	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+}
+
+/*
+ * Deliver reply data to a YFS.Symlink operation.
+ */
+static int yfs_deliver_fs_symlink(struct afs_call *call)
+{
+	struct afs_vnode *vnode = call->reply[0];
+	const __be32 *bp;
+	int ret;
+
+	_enter("{%u}", call->unmarshall);
+
+	ret = afs_transfer_reply(call);
+	if (ret < 0)
+		return ret;
+
+	/* unmarshall the reply once we've received all of it */
+	bp = call->buffer;
+	xdr_decode_YFSFid(&bp, call->reply[1]);
+	ret = yfs_decode_status(call, &bp, call->reply[2], NULL, NULL, NULL);
+	if (ret < 0)
+		return ret;
+	ret = yfs_decode_status(call, &bp, &vnode->status, vnode,
+				&call->expected_version, NULL);
+	if (ret < 0)
+		return ret;
+	xdr_decode_YFSVolSync(&bp, NULL);
+
+	_leave(" = 0 [done]");
+	return 0;
+}
+
+/*
+ * YFS.Symlink operation type
+ */
+static const struct afs_call_type yfs_RXYFSSymlink = {
+	.name		= "YFS.Symlink",
+	.op		= yfs_FS_Symlink,
+	.deliver	= yfs_deliver_fs_symlink,
+	.destructor	= afs_flat_call_destructor,
+};
+
+/*
+ * Create a symbolic link.
+ */
+int yfs_fs_symlink(struct afs_fs_cursor *fc,
+		   const char *name,
+		   const char *contents,
+		   u64 current_data_version,
+		   struct afs_fid *newfid,
+		   struct afs_file_status *newstatus)
+{
+	struct afs_vnode *dvnode = fc->vnode;
+	struct afs_call *call;
+	struct afs_net *net = afs_v2net(dvnode);
+	size_t namesz, contents_sz;
+	__be32 *bp;
+
+	_enter("");
+
+	namesz = strlen(name);
+	contents_sz = strlen(contents);
+	call = afs_alloc_flat_call(net, &yfs_RXYFSSymlink,
+				   sizeof(__be32) +
+				   sizeof(struct yfs_xdr_RPCFlags) +
+				   sizeof(struct yfs_xdr_YFSFid) +
+				   xdr_strlen(namesz) +
+				   xdr_strlen(contents_sz) +
+				   sizeof(struct yfs_xdr_YFSStoreStatus),
+				   sizeof(struct yfs_xdr_YFSFid) +
+				   sizeof(struct yfs_xdr_YFSFetchStatus) +
+				   sizeof(struct yfs_xdr_YFSFetchStatus) +
+				   sizeof(struct yfs_xdr_YFSVolSync));
+	if (!call)
+		return -ENOMEM;
+
+	call->key = fc->key;
+	call->reply[0] = dvnode;
+	call->reply[1] = newfid;
+	call->reply[2] = newstatus;
+	call->expected_version = current_data_version + 1;
+
+	/* marshall the parameters */
+	bp = call->request;
+	bp = xdr_encode_u32(bp, YFSSYMLINK);
+	bp = xdr_encode_u32(bp, 0); /* RPC flags */
+	bp = xdr_encode_YFSFid(bp, &dvnode->fid);
+	bp = xdr_encode_string(bp, name, namesz);
+	bp = xdr_encode_string(bp, contents, contents_sz);
+	bp = xdr_encode_YFSStoreStatus_mode(bp, S_IRWXUGO);
+	yfs_check_req(call, bp);
+
+	afs_use_fs_server(call, fc->cbi);
+	trace_afs_make_fs_call(call, &dvnode->fid);
+	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+}
+
+/*
+ * Deliver reply data to a YFS.Rename operation.
+ */
+static int yfs_deliver_fs_rename(struct afs_call *call)
+{
+	struct afs_vnode *orig_dvnode = call->reply[0];
+	struct afs_vnode *new_dvnode = call->reply[1];
+	const __be32 *bp;
+	int ret;
+
+	_enter("{%u}", call->unmarshall);
+
+	ret = afs_transfer_reply(call);
+	if (ret < 0)
+		return ret;
+
+	/* unmarshall the reply once we've received all of it */
+	bp = call->buffer;
+	ret = yfs_decode_status(call, &bp, &orig_dvnode->status, orig_dvnode,
+				&call->expected_version, NULL);
+	if (ret < 0)
+		return ret;
+	if (new_dvnode != orig_dvnode) {
+		ret = yfs_decode_status(call, &bp, &new_dvnode->status, new_dvnode,
+					&call->expected_version_2, NULL);
+		if (ret < 0)
+			return ret;
+	}
+
+	xdr_decode_YFSVolSync(&bp, NULL);
+	_leave(" = 0 [done]");
+	return 0;
+}
+
+/*
+ * YFS.Rename operation type
+ */
+static const struct afs_call_type yfs_RXYFSRename = {
+	.name		= "FS.Rename",
+	.op		= yfs_FS_Rename,
+	.deliver	= yfs_deliver_fs_rename,
+	.destructor	= afs_flat_call_destructor,
+};
+
+/*
+ * Rename a file or directory.
+ */
+int yfs_fs_rename(struct afs_fs_cursor *fc,
+		  const char *orig_name,
+		  struct afs_vnode *new_dvnode,
+		  const char *new_name,
+		  u64 current_orig_data_version,
+		  u64 current_new_data_version)
+{
+	struct afs_vnode *orig_dvnode = fc->vnode;
+	struct afs_call *call;
+	struct afs_net *net = afs_v2net(orig_dvnode);
+	size_t o_namesz, n_namesz;
+	__be32 *bp;
+
+	_enter("");
+
+	o_namesz = strlen(orig_name);
+	n_namesz = strlen(new_name);
+	call = afs_alloc_flat_call(net, &yfs_RXYFSRename,
+				   sizeof(__be32) +
+				   sizeof(struct yfs_xdr_RPCFlags) +
+				   sizeof(struct yfs_xdr_YFSFid) +
+				   xdr_strlen(o_namesz) +
+				   sizeof(struct yfs_xdr_YFSFid) +
+				   xdr_strlen(n_namesz),
+				   sizeof(struct yfs_xdr_YFSFetchStatus) +
+				   sizeof(struct yfs_xdr_YFSFetchStatus) +
+				   sizeof(struct yfs_xdr_YFSVolSync));
+	if (!call)
+		return -ENOMEM;
+
+	call->key = fc->key;
+	call->reply[0] = orig_dvnode;
+	call->reply[1] = new_dvnode;
+	call->expected_version = current_orig_data_version + 1;
+	call->expected_version_2 = current_new_data_version + 1;
+
+	/* marshall the parameters */
+	bp = call->request;
+	bp = xdr_encode_u32(bp, YFSRENAME);
+	bp = xdr_encode_u32(bp, 0); /* RPC flags */
+	bp = xdr_encode_YFSFid(bp, &orig_dvnode->fid);
+	bp = xdr_encode_string(bp, orig_name, o_namesz);
+	bp = xdr_encode_YFSFid(bp, &new_dvnode->fid);
+	bp = xdr_encode_string(bp, new_name, n_namesz);
+	yfs_check_req(call, bp);
+
+	afs_use_fs_server(call, fc->cbi);
+	trace_afs_make_fs_call(call, &orig_dvnode->fid);
+	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+}
+
+/*
+ * Deliver reply data to a YFS.StoreData64 operation.
+ */
+static int yfs_deliver_fs_store_data(struct afs_call *call)
+{
+	struct afs_vnode *vnode = call->reply[0];
+	const __be32 *bp;
+	int ret;
+
+	_enter("");
+
+	ret = afs_transfer_reply(call);
+	if (ret < 0)
+		return ret;
+
+	/* unmarshall the reply once we've received all of it */
+	bp = call->buffer;
+	ret = yfs_decode_status(call, &bp, &vnode->status, vnode,
+				&call->expected_version, NULL);
+	if (ret < 0)
+		return ret;
+	xdr_decode_YFSVolSync(&bp, NULL);
+
+	afs_pages_written_back(vnode, call);
+
+	_leave(" = 0 [done]");
+	return 0;
+}
+
+/*
+ * YFS.StoreData64 operation type.
+ */
+static const struct afs_call_type yfs_RXYFSStoreData64 = {
+	.name		= "YFS.StoreData64",
+	.op		= yfs_FS_StoreData64,
+	.deliver	= yfs_deliver_fs_store_data,
+	.destructor	= afs_flat_call_destructor,
+};
+
+/*
+ * Store a set of pages to a large file.
+ */
+int yfs_fs_store_data(struct afs_fs_cursor *fc, struct address_space *mapping,
+		      pgoff_t first, pgoff_t last,
+		      unsigned offset, unsigned to)
+{
+	struct afs_vnode *vnode = fc->vnode;
+	struct afs_call *call;
+	struct afs_net *net = afs_v2net(vnode);
+	loff_t size, pos, i_size;
+	__be32 *bp;
+
+	_enter(",%x,{%llx:%llu},,",
+	       key_serial(fc->key), vnode->fid.vid, vnode->fid.vnode);
+
+	size = (loff_t)to - (loff_t)offset;
+	if (first != last)
+		size += (loff_t)(last - first) << PAGE_SHIFT;
+	pos = (loff_t)first << PAGE_SHIFT;
+	pos += offset;
+
+	i_size = i_size_read(&vnode->vfs_inode);
+	if (pos + size > i_size)
+		i_size = size + pos;
+
+	_debug("size %llx, at %llx, i_size %llx",
+	       (unsigned long long)size, (unsigned long long)pos,
+	       (unsigned long long)i_size);
+
+	call = afs_alloc_flat_call(net, &yfs_RXYFSStoreData64,
+				   sizeof(__be32) +
+				   sizeof(__be32) +
+				   sizeof(struct yfs_xdr_YFSFid) +
+				   sizeof(struct yfs_xdr_YFSStoreStatus) +
+				   sizeof(struct yfs_xdr_u64) * 3,
+				   sizeof(struct yfs_xdr_YFSFetchStatus) +
+				   sizeof(struct yfs_xdr_YFSVolSync));
+	if (!call)
+		return -ENOMEM;
+
+	call->key = fc->key;
+	call->mapping = mapping;
+	call->reply[0] = vnode;
+	call->first = first;
+	call->last = last;
+	call->first_offset = offset;
+	call->last_to = to;
+	call->send_pages = true;
+	call->expected_version = vnode->status.data_version + 1;
+
+	/* marshall the parameters */
+	bp = call->request;
+	bp = xdr_encode_u32(bp, YFSSTOREDATA64);
+	bp = xdr_encode_u32(bp, 0); /* RPC flags */
+	bp = xdr_encode_YFSFid(bp, &vnode->fid);
+	bp = xdr_encode_YFSStoreStatus_mtime(bp, &vnode->vfs_inode.i_mtime);
+	bp = xdr_encode_u64(bp, pos);
+	bp = xdr_encode_u64(bp, size);
+	bp = xdr_encode_u64(bp, i_size);
+	yfs_check_req(call, bp);
+
+	afs_use_fs_server(call, fc->cbi);
+	trace_afs_make_fs_call(call, &vnode->fid);
+	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+}
+
+/*
+ * deliver reply data to an FS.StoreStatus
+ */
+static int yfs_deliver_fs_store_status(struct afs_call *call)
+{
+	struct afs_vnode *vnode = call->reply[0];
+	const __be32 *bp;
+	int ret;
+
+	_enter("");
+
+	ret = afs_transfer_reply(call);
+	if (ret < 0)
+		return ret;
+
+	/* unmarshall the reply once we've received all of it */
+	bp = call->buffer;
+	ret = yfs_decode_status(call, &bp, &vnode->status, vnode,
+				&call->expected_version, NULL);
+	if (ret < 0)
+		return ret;
+	xdr_decode_YFSVolSync(&bp, NULL);
+
+	_leave(" = 0 [done]");
+	return 0;
+}
+
+/*
+ * YFS.StoreStatus operation type
+ */
+static const struct afs_call_type yfs_RXYFSStoreStatus = {
+	.name		= "YFS.StoreStatus",
+	.op		= yfs_FS_StoreStatus,
+	.deliver	= yfs_deliver_fs_store_status,
+	.destructor	= afs_flat_call_destructor,
+};
+
+static const struct afs_call_type yfs_RXYFSStoreData64_as_Status = {
+	.name		= "YFS.StoreData64",
+	.op		= yfs_FS_StoreData64,
+	.deliver	= yfs_deliver_fs_store_status,
+	.destructor	= afs_flat_call_destructor,
+};
+
+/*
+ * Set the attributes on a file, using YFS.StoreData64 rather than
+ * YFS.StoreStatus so as to alter the file size also.
+ */
+static int yfs_fs_setattr_size(struct afs_fs_cursor *fc, struct iattr *attr)
+{
+	struct afs_vnode *vnode = fc->vnode;
+	struct afs_call *call;
+	struct afs_net *net = afs_v2net(vnode);
+	__be32 *bp;
+
+	_enter(",%x,{%llx:%llu},,",
+	       key_serial(fc->key), vnode->fid.vid, vnode->fid.vnode);
+
+	call = afs_alloc_flat_call(net, &yfs_RXYFSStoreData64_as_Status,
+				   sizeof(__be32) * 2 +
+				   sizeof(struct yfs_xdr_YFSFid) +
+				   sizeof(struct yfs_xdr_YFSStoreStatus) +
+				   sizeof(struct yfs_xdr_u64) * 3,
+				   sizeof(struct yfs_xdr_YFSFetchStatus) +
+				   sizeof(struct yfs_xdr_YFSVolSync));
+	if (!call)
+		return -ENOMEM;
+
+	call->key = fc->key;
+	call->reply[0] = vnode;
+	call->expected_version = vnode->status.data_version + 1;
+
+	/* marshall the parameters */
+	bp = call->request;
+	bp = xdr_encode_u32(bp, YFSSTOREDATA64);
+	bp = xdr_encode_u32(bp, 0); /* RPC flags */
+	bp = xdr_encode_YFSFid(bp, &vnode->fid);
+	bp = xdr_encode_YFS_StoreStatus(bp, attr);
+	bp = xdr_encode_u64(bp, 0);		/* position of start of write */
+	bp = xdr_encode_u64(bp, 0);		/* size of write */
+	bp = xdr_encode_u64(bp, attr->ia_size);	/* new file length */
+	yfs_check_req(call, bp);
+
+	afs_use_fs_server(call, fc->cbi);
+	trace_afs_make_fs_call(call, &vnode->fid);
+	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+}
+
+/*
+ * Set the attributes on a file, using YFS.StoreData64 if there's a change in
+ * file size, and YFS.StoreStatus otherwise.
+ */
+int yfs_fs_setattr(struct afs_fs_cursor *fc, struct iattr *attr)
+{
+	struct afs_vnode *vnode = fc->vnode;
+	struct afs_call *call;
+	struct afs_net *net = afs_v2net(vnode);
+	__be32 *bp;
+
+	if (attr->ia_valid & ATTR_SIZE)
+		return yfs_fs_setattr_size(fc, attr);
+
+	_enter(",%x,{%llx:%llu},,",
+	       key_serial(fc->key), vnode->fid.vid, vnode->fid.vnode);
+
+	call = afs_alloc_flat_call(net, &yfs_RXYFSStoreStatus,
+				   sizeof(__be32) * 2 +
+				   sizeof(struct yfs_xdr_YFSFid) +
+				   sizeof(struct yfs_xdr_YFSStoreStatus),
+				   sizeof(struct yfs_xdr_YFSFetchStatus) +
+				   sizeof(struct yfs_xdr_YFSVolSync));
+	if (!call)
+		return -ENOMEM;
+
+	call->key = fc->key;
+	call->reply[0] = vnode;
+	call->expected_version = vnode->status.data_version;
+
+	/* marshall the parameters */
+	bp = call->request;
+	bp = xdr_encode_u32(bp, YFSSTORESTATUS);
+	bp = xdr_encode_u32(bp, 0); /* RPC flags */
+	bp = xdr_encode_YFSFid(bp, &vnode->fid);
+	bp = xdr_encode_YFS_StoreStatus(bp, attr);
+	yfs_check_req(call, bp);
+
+	afs_use_fs_server(call, fc->cbi);
+	trace_afs_make_fs_call(call, &vnode->fid);
+	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+}
+
+/*
+ * Deliver reply data to a YFS.GetVolumeStatus operation.
+ */
+static int yfs_deliver_fs_get_volume_status(struct afs_call *call)
+{
+	const __be32 *bp;
+	char *p;
+	u32 size;
+	int ret;
+
+	_enter("{%u}", call->unmarshall);
+
+	switch (call->unmarshall) {
+	case 0:
+		call->unmarshall++;
+		afs_extract_to_buf(call, sizeof(struct yfs_xdr_YFSFetchVolumeStatus));
+
+		/* extract the returned status record */
+	case 1:
+		_debug("extract status");
+		ret = afs_extract_data(call, true);
+		if (ret < 0)
+			return ret;
+
+		bp = call->buffer;
+		xdr_decode_YFSFetchVolumeStatus(&bp, call->reply[1]);
+		call->unmarshall++;
+		afs_extract_to_tmp(call);
+
+		/* extract the volume name length */
+	case 2:
+		ret = afs_extract_data(call, true);
+		if (ret < 0)
+			return ret;
+
+		call->count = ntohl(call->tmp);
+		_debug("volname length: %u", call->count);
+		if (call->count >= AFSNAMEMAX)
+			return afs_protocol_error(call, -EBADMSG,
+						  afs_eproto_volname_len);
+		size = (call->count + 3) & ~3; /* It's padded */
+		afs_extract_begin(call, call->reply[2], size);
+		call->unmarshall++;
+
+		/* extract the volume name */
+	case 3:
+		_debug("extract volname");
+		ret = afs_extract_data(call, true);
+		if (ret < 0)
+			return ret;
+
+		p = call->reply[2];
+		p[call->count] = 0;
+		_debug("volname '%s'", p);
+		afs_extract_to_tmp(call);
+		call->unmarshall++;
+
+		/* extract the offline message length */
+	case 4:
+		ret = afs_extract_data(call, true);
+		if (ret < 0)
+			return ret;
+
+		call->count = ntohl(call->tmp);
+		_debug("offline msg length: %u", call->count);
+		if (call->count >= AFSNAMEMAX)
+			return afs_protocol_error(call, -EBADMSG,
+						  afs_eproto_offline_msg_len);
+		size = (call->count + 3) & ~3; /* It's padded */
+		afs_extract_begin(call, call->reply[2], size);
+		call->unmarshall++;
+
+		/* extract the offline message */
+	case 5:
+		_debug("extract offline");
+		ret = afs_extract_data(call, true);
+		if (ret < 0)
+			return ret;
+
+		p = call->reply[2];
+		p[call->count] = 0;
+		_debug("offline '%s'", p);
+
+		afs_extract_to_tmp(call);
+		call->unmarshall++;
+
+		/* extract the message of the day length */
+	case 6:
+		ret = afs_extract_data(call, true);
+		if (ret < 0)
+			return ret;
+
+		call->count = ntohl(call->tmp);
+		_debug("motd length: %u", call->count);
+		if (call->count >= AFSNAMEMAX)
+			return afs_protocol_error(call, -EBADMSG,
+						  afs_eproto_motd_len);
+		size = (call->count + 3) & ~3; /* It's padded */
+		afs_extract_begin(call, call->reply[2], size);
+		call->unmarshall++;
+
+		/* extract the message of the day */
+	case 7:
+		_debug("extract motd");
+		ret = afs_extract_data(call, false);
+		if (ret < 0)
+			return ret;
+
+		p = call->reply[2];
+		p[call->count] = 0;
+		_debug("motd '%s'", p);
+
+		call->unmarshall++;
+
+	case 8:
+		break;
+	}
+
+	_leave(" = 0 [done]");
+	return 0;
+}
+
+/*
+ * Destroy a YFS.GetVolumeStatus call.
+ */
+static void yfs_get_volume_status_call_destructor(struct afs_call *call)
+{
+	kfree(call->reply[2]);
+	call->reply[2] = NULL;
+	afs_flat_call_destructor(call);
+}
+
+/*
+ * YFS.GetVolumeStatus operation type
+ */
+static const struct afs_call_type yfs_RXYFSGetVolumeStatus = {
+	.name		= "YFS.GetVolumeStatus",
+	.op		= yfs_FS_GetVolumeStatus,
+	.deliver	= yfs_deliver_fs_get_volume_status,
+	.destructor	= yfs_get_volume_status_call_destructor,
+};
+
+/*
+ * fetch the status of a volume
+ */
+int yfs_fs_get_volume_status(struct afs_fs_cursor *fc,
+			     struct afs_volume_status *vs)
+{
+	struct afs_vnode *vnode = fc->vnode;
+	struct afs_call *call;
+	struct afs_net *net = afs_v2net(vnode);
+	__be32 *bp;
+	void *tmpbuf;
+
+	_enter("");
+
+	tmpbuf = kmalloc(AFSOPAQUEMAX, GFP_KERNEL);
+	if (!tmpbuf)
+		return -ENOMEM;
+
+	call = afs_alloc_flat_call(net, &yfs_RXYFSGetVolumeStatus,
+				   sizeof(__be32) * 2 +
+				   sizeof(struct yfs_xdr_u64),
+				   sizeof(struct yfs_xdr_YFSFetchVolumeStatus) +
+				   sizeof(__be32));
+	if (!call) {
+		kfree(tmpbuf);
+		return -ENOMEM;
+	}
+
+	call->key = fc->key;
+	call->reply[0] = vnode;
+	call->reply[1] = vs;
+	call->reply[2] = tmpbuf;
+
+	/* marshall the parameters */
+	bp = call->request;
+	bp = xdr_encode_u32(bp, YFSGETVOLUMESTATUS);
+	bp = xdr_encode_u32(bp, 0); /* RPC flags */
+	bp = xdr_encode_u64(bp, vnode->fid.vid);
+	yfs_check_req(call, bp);
+
+	afs_use_fs_server(call, fc->cbi);
+	trace_afs_make_fs_call(call, &vnode->fid);
+	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+}
+
+/*
+ * Deliver reply data to an YFS.SetLock, YFS.ExtendLock or YFS.ReleaseLock
+ */
+static int yfs_deliver_fs_xxxx_lock(struct afs_call *call)
+{
+	struct afs_vnode *vnode = call->reply[0];
+	const __be32 *bp;
+	int ret;
+
+	_enter("{%u}", call->unmarshall);
+
+	ret = afs_transfer_reply(call);
+	if (ret < 0)
+		return ret;
+
+	/* unmarshall the reply once we've received all of it */
+	bp = call->buffer;
+	ret = yfs_decode_status(call, &bp, &vnode->status, vnode,
+				&call->expected_version, NULL);
+	if (ret < 0)
+		return ret;
+	xdr_decode_YFSVolSync(&bp, NULL);
+
+	_leave(" = 0 [done]");
+	return 0;
+}
+
+/*
+ * YFS.SetLock operation type
+ */
+static const struct afs_call_type yfs_RXYFSSetLock = {
+	.name		= "YFS.SetLock",
+	.op		= yfs_FS_SetLock,
+	.deliver	= yfs_deliver_fs_xxxx_lock,
+	.destructor	= afs_flat_call_destructor,
+};
+
+/*
+ * YFS.ExtendLock operation type
+ */
+static const struct afs_call_type yfs_RXYFSExtendLock = {
+	.name		= "YFS.ExtendLock",
+	.op		= yfs_FS_ExtendLock,
+	.deliver	= yfs_deliver_fs_xxxx_lock,
+	.destructor	= afs_flat_call_destructor,
+};
+
+/*
+ * YFS.ReleaseLock operation type
+ */
+static const struct afs_call_type yfs_RXYFSReleaseLock = {
+	.name		= "YFS.ReleaseLock",
+	.op		= yfs_FS_ReleaseLock,
+	.deliver	= yfs_deliver_fs_xxxx_lock,
+	.destructor	= afs_flat_call_destructor,
+};
+
+/*
+ * Set a lock on a file
+ */
+int yfs_fs_set_lock(struct afs_fs_cursor *fc, afs_lock_type_t type)
+{
+	struct afs_vnode *vnode = fc->vnode;
+	struct afs_call *call;
+	struct afs_net *net = afs_v2net(vnode);
+	__be32 *bp;
+
+	_enter("");
+
+	call = afs_alloc_flat_call(net, &yfs_RXYFSSetLock,
+				   sizeof(__be32) * 2 +
+				   sizeof(struct yfs_xdr_YFSFid) +
+				   sizeof(__be32),
+				   sizeof(struct yfs_xdr_YFSFetchStatus) +
+				   sizeof(struct yfs_xdr_YFSVolSync));
+	if (!call)
+		return -ENOMEM;
+
+	call->key = fc->key;
+	call->reply[0] = vnode;
+
+	/* marshall the parameters */
+	bp = call->request;
+	bp = xdr_encode_u32(bp, YFSSETLOCK);
+	bp = xdr_encode_u32(bp, 0); /* RPC flags */
+	bp = xdr_encode_YFSFid(bp, &vnode->fid);
+	bp = xdr_encode_u32(bp, type);
+	yfs_check_req(call, bp);
+
+	afs_use_fs_server(call, fc->cbi);
+	trace_afs_make_fs_call(call, &vnode->fid);
+	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+}
+
+/*
+ * extend a lock on a file
+ */
+int yfs_fs_extend_lock(struct afs_fs_cursor *fc)
+{
+	struct afs_vnode *vnode = fc->vnode;
+	struct afs_call *call;
+	struct afs_net *net = afs_v2net(vnode);
+	__be32 *bp;
+
+	_enter("");
+
+	call = afs_alloc_flat_call(net, &yfs_RXYFSExtendLock,
+				   sizeof(__be32) * 2 +
+				   sizeof(struct yfs_xdr_YFSFid),
+				   sizeof(struct yfs_xdr_YFSFetchStatus) +
+				   sizeof(struct yfs_xdr_YFSVolSync));
+	if (!call)
+		return -ENOMEM;
+
+	call->key = fc->key;
+	call->reply[0] = vnode;
+
+	/* marshall the parameters */
+	bp = call->request;
+	bp = xdr_encode_u32(bp, YFSEXTENDLOCK);
+	bp = xdr_encode_u32(bp, 0); /* RPC flags */
+	bp = xdr_encode_YFSFid(bp, &vnode->fid);
+	yfs_check_req(call, bp);
+
+	afs_use_fs_server(call, fc->cbi);
+	trace_afs_make_fs_call(call, &vnode->fid);
+	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+}
+
+/*
+ * release a lock on a file
+ */
+int yfs_fs_release_lock(struct afs_fs_cursor *fc)
+{
+	struct afs_vnode *vnode = fc->vnode;
+	struct afs_call *call;
+	struct afs_net *net = afs_v2net(vnode);
+	__be32 *bp;
+
+	_enter("");
+
+	call = afs_alloc_flat_call(net, &yfs_RXYFSReleaseLock,
+				   sizeof(__be32) * 2 +
+				   sizeof(struct yfs_xdr_YFSFid),
+				   sizeof(struct yfs_xdr_YFSFetchStatus) +
+				   sizeof(struct yfs_xdr_YFSVolSync));
+	if (!call)
+		return -ENOMEM;
+
+	call->key = fc->key;
+	call->reply[0] = vnode;
+
+	/* marshall the parameters */
+	bp = call->request;
+	bp = xdr_encode_u32(bp, YFSRELEASELOCK);
+	bp = xdr_encode_u32(bp, 0); /* RPC flags */
+	bp = xdr_encode_YFSFid(bp, &vnode->fid);
+	yfs_check_req(call, bp);
+
+	afs_use_fs_server(call, fc->cbi);
+	trace_afs_make_fs_call(call, &vnode->fid);
+	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+}
+
+/*
+ * Deliver reply data to an FS.FetchStatus with no vnode.
+ */
+static int yfs_deliver_fs_fetch_status(struct afs_call *call)
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
+	_enter("{%llx:%llu}", vnode->fid.vid, vnode->fid.vnode);
+
+	/* unmarshall the reply once we've received all of it */
+	bp = call->buffer;
+	ret = yfs_decode_status(call, &bp, status, vnode,
+				&call->expected_version, NULL);
+	if (ret < 0)
+		return ret;
+	xdr_decode_YFSCallBack_raw(&bp, callback);
+	xdr_decode_YFSVolSync(&bp, volsync);
+
+	_leave(" = 0 [done]");
+	return 0;
+}
+
+/*
+ * YFS.FetchStatus operation type
+ */
+static const struct afs_call_type yfs_RXYFSFetchStatus = {
+	.name		= "YFS.FetchStatus",
+	.op		= yfs_FS_FetchStatus,
+	.deliver	= yfs_deliver_fs_fetch_status,
+	.destructor	= afs_flat_call_destructor,
+};
+
+/*
+ * Fetch the status information for a fid without needing a vnode handle.
+ */
+int yfs_fs_fetch_status(struct afs_fs_cursor *fc,
+			struct afs_net *net,
+			struct afs_fid *fid,
+			struct afs_file_status *status,
+			struct afs_callback *callback,
+			struct afs_volsync *volsync)
+{
+	struct afs_call *call;
+	__be32 *bp;
+
+	_enter(",%x,{%llx:%llu},,",
+	       key_serial(fc->key), fid->vid, fid->vnode);
+
+	call = afs_alloc_flat_call(net, &yfs_RXYFSFetchStatus,
+				   sizeof(__be32) * 2 +
+				   sizeof(struct yfs_xdr_YFSFid),
+				   sizeof(struct yfs_xdr_YFSFetchStatus) +
+				   sizeof(struct yfs_xdr_YFSCallBack) +
+				   sizeof(struct yfs_xdr_YFSVolSync));
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
+	call->expected_version = 1; /* vnode->status.data_version */
+
+	/* marshall the parameters */
+	bp = call->request;
+	bp = xdr_encode_u32(bp, YFSFETCHSTATUS);
+	bp = xdr_encode_u32(bp, 0); /* RPC flags */
+	bp = xdr_encode_YFSFid(bp, fid);
+	yfs_check_req(call, bp);
+
+	call->cb_break = fc->cb_break;
+	afs_use_fs_server(call, fc->cbi);
+	trace_afs_make_fs_call(call, fid);
+	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+}
+
+/*
+ * Deliver reply data to an YFS.InlineBulkStatus call
+ */
+static int yfs_deliver_fs_inline_bulk_status(struct afs_call *call)
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
+		afs_extract_to_tmp(call);
+		call->unmarshall++;
+
+		/* Extract the file status count and array in two steps */
+	case 1:
+		_debug("extract status count");
+		ret = afs_extract_data(call, true);
+		if (ret < 0)
+			return ret;
+
+		tmp = ntohl(call->tmp);
+		_debug("status count: %u/%u", tmp, call->count2);
+		if (tmp != call->count2)
+			return afs_protocol_error(call, -EBADMSG,
+						  afs_eproto_ibulkst_count);
+
+		call->count = 0;
+		call->unmarshall++;
+	more_counts:
+		afs_extract_to_buf(call, sizeof(struct yfs_xdr_YFSFetchStatus));
+
+	case 2:
+		_debug("extract status array %u", call->count);
+		ret = afs_extract_data(call, true);
+		if (ret < 0)
+			return ret;
+
+		bp = call->buffer;
+		statuses = call->reply[1];
+		ret = yfs_decode_status(call, &bp, &statuses[call->count],
+					call->count == 0 ? vnode : NULL,
+					NULL, NULL);
+		if (ret < 0)
+			return ret;
+
+		call->count++;
+		if (call->count < call->count2)
+			goto more_counts;
+
+		call->count = 0;
+		call->unmarshall++;
+		afs_extract_to_tmp(call);
+
+		/* Extract the callback count and array in two steps */
+	case 3:
+		_debug("extract CB count");
+		ret = afs_extract_data(call, true);
+		if (ret < 0)
+			return ret;
+
+		tmp = ntohl(call->tmp);
+		_debug("CB count: %u", tmp);
+		if (tmp != call->count2)
+			return afs_protocol_error(call, -EBADMSG,
+						  afs_eproto_ibulkst_cb_count);
+		call->count = 0;
+		call->unmarshall++;
+	more_cbs:
+		afs_extract_to_buf(call, sizeof(struct yfs_xdr_YFSCallBack));
+
+	case 4:
+		_debug("extract CB array");
+		ret = afs_extract_data(call, true);
+		if (ret < 0)
+			return ret;
+
+		_debug("unmarshall CB array");
+		bp = call->buffer;
+		callbacks = call->reply[2];
+		xdr_decode_YFSCallBack_raw(&bp, &callbacks[call->count]);
+		statuses = call->reply[1];
+		if (call->count == 0 && vnode && statuses[0].abort_code == 0) {
+			bp = call->buffer;
+			xdr_decode_YFSCallBack(call, vnode, &bp);
+		}
+		call->count++;
+		if (call->count < call->count2)
+			goto more_cbs;
+
+		afs_extract_to_buf(call, sizeof(struct yfs_xdr_YFSVolSync));
+		call->unmarshall++;
+
+	case 5:
+		ret = afs_extract_data(call, false);
+		if (ret < 0)
+			return ret;
+
+		bp = call->buffer;
+		xdr_decode_YFSVolSync(&bp, call->reply[3]);
+
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
+static const struct afs_call_type yfs_RXYFSInlineBulkStatus = {
+	.name		= "YFS.InlineBulkStatus",
+	.op		= yfs_FS_InlineBulkStatus,
+	.deliver	= yfs_deliver_fs_inline_bulk_status,
+	.destructor	= afs_flat_call_destructor,
+};
+
+/*
+ * Fetch the status information for up to 1024 files
+ */
+int yfs_fs_inline_bulk_status(struct afs_fs_cursor *fc,
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
+	_enter(",%x,{%llx:%llu},%u",
+	       key_serial(fc->key), fids[0].vid, fids[1].vnode, nr_fids);
+
+	call = afs_alloc_flat_call(net, &yfs_RXYFSInlineBulkStatus,
+				   sizeof(__be32) +
+				   sizeof(__be32) +
+				   sizeof(__be32) +
+				   sizeof(struct yfs_xdr_YFSFid) * nr_fids,
+				   sizeof(struct yfs_xdr_YFSFetchStatus));
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
+	bp = xdr_encode_u32(bp, YFSINLINEBULKSTATUS);
+	bp = xdr_encode_u32(bp, 0); /* RPCFlags */
+	bp = xdr_encode_u32(bp, nr_fids);
+	for (i = 0; i < nr_fids; i++)
+		bp = xdr_encode_YFSFid(bp, &fids[i]);
+	yfs_check_req(call, bp);
+
+	call->cb_break = fc->cb_break;
+	afs_use_fs_server(call, fc->cbi);
+	trace_afs_make_fs_call(call, &fids[0]);
+	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+}
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 8acd56e20a37..ed155042236b 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -54,6 +54,35 @@ enum afs_fs_operation {
 	afs_FS_StoreData64		= 65538, /* AFS Store file data */
 	afs_FS_GiveUpAllCallBacks	= 65539, /* AFS Give up all our callbacks on a server */
 	afs_FS_GetCapabilities		= 65540, /* AFS Get FS server capabilities */
+
+	yfs_FS_FetchData		= 130,	 /* YFS Fetch file data */
+	yfs_FS_FetchACL			= 64131, /* YFS Fetch file ACL */
+	yfs_FS_FetchStatus		= 64132, /* YFS Fetch file status */
+	yfs_FS_StoreACL			= 64134, /* YFS Store file ACL */
+	yfs_FS_StoreStatus		= 64135, /* YFS Store file status */
+	yfs_FS_RemoveFile		= 64136, /* YFS Remove a file */
+	yfs_FS_CreateFile		= 64137, /* YFS Create a file */
+	yfs_FS_Rename			= 64138, /* YFS Rename or move a file or directory */
+	yfs_FS_Symlink			= 64139, /* YFS Create a symbolic link */
+	yfs_FS_Link			= 64140, /* YFS Create a hard link */
+	yfs_FS_MakeDir			= 64141, /* YFS Create a directory */
+	yfs_FS_RemoveDir		= 64142, /* YFS Remove a directory */
+	yfs_FS_GetVolumeStatus		= 64149, /* YFS Get volume status information */
+	yfs_FS_SetVolumeStatus		= 64150, /* YFS Set volume status information */
+	yfs_FS_SetLock			= 64156, /* YFS Request a file lock */
+	yfs_FS_ExtendLock		= 64157, /* YFS Extend a file lock */
+	yfs_FS_ReleaseLock		= 64158, /* YFS Release a file lock */
+	yfs_FS_Lookup			= 64161, /* YFS lookup file in directory */
+	yfs_FS_FlushCPS			= 64165,
+	yfs_FS_FetchOpaqueACL		= 64168,
+	yfs_FS_WhoAmI			= 64170,
+	yfs_FS_RemoveACL		= 64171,
+	yfs_FS_RemoveFile2		= 64173,
+	yfs_FS_StoreOpaqueACL2		= 64174,
+	yfs_FS_InlineBulkStatus		= 64536, /* YFS Fetch multiple file statuses with errors */
+	yfs_FS_FetchData64		= 64537, /* YFS Fetch file data */
+	yfs_FS_StoreData64		= 64538, /* YFS Store file data */
+	yfs_FS_UpdateSymlink		= 64540,
 };
 
 enum afs_vl_operation {
@@ -156,7 +185,34 @@ enum afs_file_error {
 	EM(afs_FS_FetchData64,			"FS.FetchData64") \
 	EM(afs_FS_StoreData64,			"FS.StoreData64") \
 	EM(afs_FS_GiveUpAllCallBacks,		"FS.GiveUpAllCallBacks") \
-	E_(afs_FS_GetCapabilities,		"FS.GetCapabilities")
+	EM(afs_FS_GetCapabilities,		"FS.GetCapabilities") \
+	EM(yfs_FS_FetchACL,			"YFS.FetchACL") \
+	EM(yfs_FS_FetchStatus,			"YFS.FetchStatus") \
+	EM(yfs_FS_StoreACL,			"YFS.StoreACL") \
+	EM(yfs_FS_StoreStatus,			"YFS.StoreStatus") \
+	EM(yfs_FS_RemoveFile,			"YFS.RemoveFile") \
+	EM(yfs_FS_CreateFile,			"YFS.CreateFile") \
+	EM(yfs_FS_Rename,			"YFS.Rename") \
+	EM(yfs_FS_Symlink,			"YFS.Symlink") \
+	EM(yfs_FS_Link,				"YFS.Link") \
+	EM(yfs_FS_MakeDir,			"YFS.MakeDir") \
+	EM(yfs_FS_RemoveDir,			"YFS.RemoveDir") \
+	EM(yfs_FS_GetVolumeStatus,		"YFS.GetVolumeStatus") \
+	EM(yfs_FS_SetVolumeStatus,		"YFS.SetVolumeStatus") \
+	EM(yfs_FS_SetLock,			"YFS.SetLock") \
+	EM(yfs_FS_ExtendLock,			"YFS.ExtendLock") \
+	EM(yfs_FS_ReleaseLock,			"YFS.ReleaseLock") \
+	EM(yfs_FS_Lookup,			"YFS.Lookup") \
+	EM(yfs_FS_FlushCPS,			"YFS.FlushCPS") \
+	EM(yfs_FS_FetchOpaqueACL,		"YFS.FetchOpaqueACL") \
+	EM(yfs_FS_WhoAmI,			"YFS.WhoAmI") \
+	EM(yfs_FS_RemoveACL,			"YFS.RemoveACL") \
+	EM(yfs_FS_RemoveFile2,			"YFS.RemoveFile2") \
+	EM(yfs_FS_StoreOpaqueACL2,		"YFS.StoreOpaqueACL2") \
+	EM(yfs_FS_InlineBulkStatus,		"YFS.InlineBulkStatus") \
+	EM(yfs_FS_FetchData64,			"YFS.FetchData64") \
+	EM(yfs_FS_StoreData64,			"YFS.StoreData64") \
+	E_(yfs_FS_UpdateSymlink,		"YFS.UpdateSymlink")
 
 #define afs_vl_operations \
 	EM(afs_VL_GetEntryByNameU,		"VL.GetEntryByNameU") \

