Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932782AbeEWMR2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 08:17:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932744AbeEWMRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 08:17:21 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 6/8] afs: Fix a Sparse warning in xdr_decode_AFSFetchStatus()
From: David Howells <dhowells@redhat.com>
To: viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Wed, 23 May 2018 13:17:19 +0100
Message-ID: <152707783954.27887.13200491028680328553.stgit@warthog.procyon.org.uk>
In-Reply-To: <152707780120.27887.10118775145086304138.stgit@warthog.procyon.org.uk>
References: <152707780120.27887.10118775145086304138.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse doesn't appear able to handle the conditionally-taken locks in
xdr_decode_AFSFetchStatus(), even though the lock and unlock are both
contingent on the same unvarying function argument.

Deal with this by interpolating a wrapper function that takes the lock if
needed and calls xdr_decode_AFSFetchStatus() on two separate branches, one
with the lock held and one without.

This allows Sparse to work out the locking.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/fsclient.c |   97 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 55 insertions(+), 42 deletions(-)

diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index efacdb7c1dee..b695d9e16c65 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -137,10 +137,6 @@ static int xdr_decode_AFSFetchStatus(struct afs_call *call,
 	u64 data_version, size;
 	u32 type, abort_code;
 	u8 flags = 0;
-	int ret;
-
-	if (vnode)
-		write_seqlock(&vnode->cb_lock);
 
 	if (xdr->if_version != htonl(AFS_FSTATUS_VERSION)) {
 		pr_warn("Unknown AFSFetchStatus version %u\n", ntohl(xdr->if_version));
@@ -168,8 +164,7 @@ static int xdr_decode_AFSFetchStatus(struct afs_call *call,
 	case AFS_FTYPE_INVALID:
 		if (abort_code != 0) {
 			status->abort_code = abort_code;
-			ret = 0;
-			goto out;
+			return 0;
 		}
 		/* Fall through */
 	default:
@@ -222,17 +217,35 @@ static int xdr_decode_AFSFetchStatus(struct afs_call *call,
 					     flags);
 	}
 
-	ret = 0;
-
-out:
-	if (vnode)
-		write_sequnlock(&vnode->cb_lock);
-	return ret;
+	return 0;
 
 bad:
 	xdr_dump_bad(*_bp);
-	ret = afs_protocol_error(call, -EBADMSG);
-	goto out;
+	return afs_protocol_error(call, -EBADMSG);
+}
+
+/*
+ * Decode the file status.  We need to lock the target vnode if we're going to
+ * update its status so that stat() sees the attributes update atomically.
+ */
+static int afs_decode_status(struct afs_call *call,
+			     const __be32 **_bp,
+			     struct afs_file_status *status,
+			     struct afs_vnode *vnode,
+			     const afs_dataversion_t *expected_version,
+			     struct afs_read *read_req)
+{
+	int ret;
+
+	if (!vnode)
+		return xdr_decode_AFSFetchStatus(call, _bp, status, vnode,
+						 expected_version, read_req);
+
+	write_seqlock(&vnode->cb_lock);
+	ret = xdr_decode_AFSFetchStatus(call, _bp, status, vnode,
+					expected_version, read_req);
+	write_sequnlock(&vnode->cb_lock);
+	return ret;
 }
 
 /*
@@ -374,8 +387,8 @@ static int afs_deliver_fs_fetch_status_vnode(struct afs_call *call)
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	if (xdr_decode_AFSFetchStatus(call, &bp, &vnode->status, vnode,
-				      &call->expected_version, NULL) < 0)
+	if (afs_decode_status(call, &bp, &vnode->status, vnode,
+			      &call->expected_version, NULL) < 0)
 		return afs_protocol_error(call, -EBADMSG);
 	xdr_decode_AFSCallBack(call, vnode, &bp);
 	if (call->reply[1])
@@ -555,8 +568,8 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 			return ret;
 
 		bp = call->buffer;
-		if (xdr_decode_AFSFetchStatus(call, &bp, &vnode->status, vnode,
-					      &vnode->status.data_version, req) < 0)
+		if (afs_decode_status(call, &bp, &vnode->status, vnode,
+				      &vnode->status.data_version, req) < 0)
 			return afs_protocol_error(call, -EBADMSG);
 		xdr_decode_AFSCallBack(call, vnode, &bp);
 		if (call->reply[1])
@@ -708,9 +721,9 @@ static int afs_deliver_fs_create_vnode(struct afs_call *call)
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
 	xdr_decode_AFSFid(&bp, call->reply[1]);
-	if (xdr_decode_AFSFetchStatus(call, &bp, call->reply[2], NULL, NULL, NULL) < 0 ||
-	    xdr_decode_AFSFetchStatus(call, &bp, &vnode->status, vnode,
-				      &call->expected_version, NULL) < 0)
+	if (afs_decode_status(call, &bp, call->reply[2], NULL, NULL, NULL) < 0 ||
+	    afs_decode_status(call, &bp, &vnode->status, vnode,
+			      &call->expected_version, NULL) < 0)
 		return afs_protocol_error(call, -EBADMSG);
 	xdr_decode_AFSCallBack_raw(&bp, call->reply[3]);
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
@@ -814,8 +827,8 @@ static int afs_deliver_fs_remove(struct afs_call *call)
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	if (xdr_decode_AFSFetchStatus(call, &bp, &vnode->status, vnode,
-				      &call->expected_version, NULL) < 0)
+	if (afs_decode_status(call, &bp, &vnode->status, vnode,
+			      &call->expected_version, NULL) < 0)
 		return afs_protocol_error(call, -EBADMSG);
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
@@ -904,9 +917,9 @@ static int afs_deliver_fs_link(struct afs_call *call)
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	if (xdr_decode_AFSFetchStatus(call, &bp, &vnode->status, vnode, NULL, NULL) < 0 ||
-	    xdr_decode_AFSFetchStatus(call, &bp, &dvnode->status, dvnode,
-				      &call->expected_version, NULL) < 0)
+	if (afs_decode_status(call, &bp, &vnode->status, vnode, NULL, NULL) < 0 ||
+	    afs_decode_status(call, &bp, &dvnode->status, dvnode,
+			      &call->expected_version, NULL) < 0)
 		return afs_protocol_error(call, -EBADMSG);
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
@@ -991,9 +1004,9 @@ static int afs_deliver_fs_symlink(struct afs_call *call)
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
 	xdr_decode_AFSFid(&bp, call->reply[1]);
-	if (xdr_decode_AFSFetchStatus(call, &bp, call->reply[2], NULL, NULL, NULL) ||
-	    xdr_decode_AFSFetchStatus(call, &bp, &vnode->status, vnode,
-				      &call->expected_version, NULL) < 0)
+	if (afs_decode_status(call, &bp, call->reply[2], NULL, NULL, NULL) ||
+	    afs_decode_status(call, &bp, &vnode->status, vnode,
+			      &call->expected_version, NULL) < 0)
 		return afs_protocol_error(call, -EBADMSG);
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
@@ -1097,12 +1110,12 @@ static int afs_deliver_fs_rename(struct afs_call *call)
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	if (xdr_decode_AFSFetchStatus(call, &bp, &orig_dvnode->status, orig_dvnode,
-				      &call->expected_version, NULL) < 0)
+	if (afs_decode_status(call, &bp, &orig_dvnode->status, orig_dvnode,
+			      &call->expected_version, NULL) < 0)
 		return afs_protocol_error(call, -EBADMSG);
 	if (new_dvnode != orig_dvnode &&
-	    xdr_decode_AFSFetchStatus(call, &bp, &new_dvnode->status, new_dvnode,
-				      &call->expected_version_2, NULL) < 0)
+	    afs_decode_status(call, &bp, &new_dvnode->status, new_dvnode,
+			      &call->expected_version_2, NULL) < 0)
 		return afs_protocol_error(call, -EBADMSG);
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
@@ -1206,8 +1219,8 @@ static int afs_deliver_fs_store_data(struct afs_call *call)
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	if (xdr_decode_AFSFetchStatus(call, &bp, &vnode->status, vnode,
-				      &call->expected_version, NULL) < 0)
+	if (afs_decode_status(call, &bp, &vnode->status, vnode,
+			      &call->expected_version, NULL) < 0)
 		return afs_protocol_error(call, -EBADMSG);
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
@@ -1382,8 +1395,8 @@ static int afs_deliver_fs_store_status(struct afs_call *call)
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	if (xdr_decode_AFSFetchStatus(call, &bp, &vnode->status, vnode,
-				      &call->expected_version, NULL) < 0)
+	if (afs_decode_status(call, &bp, &vnode->status, vnode,
+			      &call->expected_version, NULL) < 0)
 		return afs_protocol_error(call, -EBADMSG);
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
@@ -2084,8 +2097,8 @@ static int afs_deliver_fs_fetch_status(struct afs_call *call)
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	xdr_decode_AFSFetchStatus(call, &bp, status, vnode,
-				  &call->expected_version, NULL);
+	afs_decode_status(call, &bp, status, vnode,
+			  &call->expected_version, NULL);
 	callback[call->count].version	= ntohl(bp[0]);
 	callback[call->count].expiry	= ntohl(bp[1]);
 	callback[call->count].type	= ntohl(bp[2]);
@@ -2196,9 +2209,9 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 
 		bp = call->buffer;
 		statuses = call->reply[1];
-		if (xdr_decode_AFSFetchStatus(call, &bp, &statuses[call->count],
-					      call->count == 0 ? vnode : NULL,
-					      NULL, NULL) < 0)
+		if (afs_decode_status(call, &bp, &statuses[call->count],
+				      call->count == 0 ? vnode : NULL,
+				      NULL, NULL) < 0)
 			return afs_protocol_error(call, -EBADMSG);
 
 		call->count++;
