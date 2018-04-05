Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753611AbeDEUcd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 16:32:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46254 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751439AbeDEUbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 16:31:31 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 18/20] afs: Trace protocol errors
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Apr 2018 21:31:29 +0100
Message-ID: <152296028992.31027.16648675315284171719.stgit@warthog.procyon.org.uk>
In-Reply-To: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
References: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trace protocol errors detected in afs.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/cmservice.c         |    4 +--
 fs/afs/fsclient.c          |   68 +++++++++++++++++++++++---------------------
 fs/afs/inode.c             |    2 +
 fs/afs/internal.h          |    1 +
 fs/afs/rxrpc.c             |    9 ++++++
 fs/afs/vlclient.c          |   20 ++++++-------
 include/trace/events/afs.h |   21 ++++++++++++++
 7 files changed, 79 insertions(+), 46 deletions(-)

diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index fa07f83e9f29..357de908df3a 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -201,7 +201,7 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 		call->count = ntohl(call->tmp);
 		_debug("FID count: %u", call->count);
 		if (call->count > AFSCBMAX)
-			return -EBADMSG;
+			return afs_protocol_error(call, -EBADMSG);
 
 		call->buffer = kmalloc(call->count * 3 * 4, GFP_KERNEL);
 		if (!call->buffer)
@@ -245,7 +245,7 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 		call->count2 = ntohl(call->tmp);
 		_debug("CB count: %u", call->count2);
 		if (call->count2 != call->count && call->count2 != 0)
-			return -EBADMSG;
+			return afs_protocol_error(call, -EBADMSG);
 		call->offset = 0;
 		call->unmarshall++;
 
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 20d6304a0d3e..efacdb7c1dee 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -126,7 +126,8 @@ void afs_update_inode_from_status(struct afs_vnode *vnode,
 /*
  * decode an AFSFetchStatus block
  */
-static int xdr_decode_AFSFetchStatus(const __be32 **_bp,
+static int xdr_decode_AFSFetchStatus(struct afs_call *call,
+				     const __be32 **_bp,
 				     struct afs_file_status *status,
 				     struct afs_vnode *vnode,
 				     const afs_dataversion_t *expected_version,
@@ -167,6 +168,7 @@ static int xdr_decode_AFSFetchStatus(const __be32 **_bp,
 	case AFS_FTYPE_INVALID:
 		if (abort_code != 0) {
 			status->abort_code = abort_code;
+			ret = 0;
 			goto out;
 		}
 		/* Fall through */
@@ -229,7 +231,7 @@ static int xdr_decode_AFSFetchStatus(const __be32 **_bp,
 
 bad:
 	xdr_dump_bad(*_bp);
-	ret = -EBADMSG;
+	ret = afs_protocol_error(call, -EBADMSG);
 	goto out;
 }
 
@@ -372,9 +374,9 @@ static int afs_deliver_fs_fetch_status_vnode(struct afs_call *call)
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	if (xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode,
+	if (xdr_decode_AFSFetchStatus(call, &bp, &vnode->status, vnode,
 				      &call->expected_version, NULL) < 0)
-		return -EBADMSG;
+		return afs_protocol_error(call, -EBADMSG);
 	xdr_decode_AFSCallBack(call, vnode, &bp);
 	if (call->reply[1])
 		xdr_decode_AFSVolSync(&bp, call->reply[1]);
@@ -553,9 +555,9 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 			return ret;
 
 		bp = call->buffer;
-		if (xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode,
+		if (xdr_decode_AFSFetchStatus(call, &bp, &vnode->status, vnode,
 					      &vnode->status.data_version, req) < 0)
-			return -EBADMSG;
+			return afs_protocol_error(call, -EBADMSG);
 		xdr_decode_AFSCallBack(call, vnode, &bp);
 		if (call->reply[1])
 			xdr_decode_AFSVolSync(&bp, call->reply[1]);
@@ -706,10 +708,10 @@ static int afs_deliver_fs_create_vnode(struct afs_call *call)
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
 	xdr_decode_AFSFid(&bp, call->reply[1]);
-	if (xdr_decode_AFSFetchStatus(&bp, call->reply[2], NULL, NULL, NULL) < 0 ||
-	    xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode,
+	if (xdr_decode_AFSFetchStatus(call, &bp, call->reply[2], NULL, NULL, NULL) < 0 ||
+	    xdr_decode_AFSFetchStatus(call, &bp, &vnode->status, vnode,
 				      &call->expected_version, NULL) < 0)
-		return -EBADMSG;
+		return afs_protocol_error(call, -EBADMSG);
 	xdr_decode_AFSCallBack_raw(&bp, call->reply[3]);
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
@@ -812,9 +814,9 @@ static int afs_deliver_fs_remove(struct afs_call *call)
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	if (xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode,
+	if (xdr_decode_AFSFetchStatus(call, &bp, &vnode->status, vnode,
 				      &call->expected_version, NULL) < 0)
-		return -EBADMSG;
+		return afs_protocol_error(call, -EBADMSG);
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
 	_leave(" = 0 [done]");
@@ -902,10 +904,10 @@ static int afs_deliver_fs_link(struct afs_call *call)
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	if (xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode, NULL, NULL) < 0 ||
-	    xdr_decode_AFSFetchStatus(&bp, &dvnode->status, dvnode,
+	if (xdr_decode_AFSFetchStatus(call, &bp, &vnode->status, vnode, NULL, NULL) < 0 ||
+	    xdr_decode_AFSFetchStatus(call, &bp, &dvnode->status, dvnode,
 				      &call->expected_version, NULL) < 0)
-		return -EBADMSG;
+		return afs_protocol_error(call, -EBADMSG);
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
 	_leave(" = 0 [done]");
@@ -989,10 +991,10 @@ static int afs_deliver_fs_symlink(struct afs_call *call)
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
 	xdr_decode_AFSFid(&bp, call->reply[1]);
-	if (xdr_decode_AFSFetchStatus(&bp, call->reply[2], NULL, NULL, NULL) ||
-	    xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode,
+	if (xdr_decode_AFSFetchStatus(call, &bp, call->reply[2], NULL, NULL, NULL) ||
+	    xdr_decode_AFSFetchStatus(call, &bp, &vnode->status, vnode,
 				      &call->expected_version, NULL) < 0)
-		return -EBADMSG;
+		return afs_protocol_error(call, -EBADMSG);
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
 	_leave(" = 0 [done]");
@@ -1095,13 +1097,13 @@ static int afs_deliver_fs_rename(struct afs_call *call)
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	if (xdr_decode_AFSFetchStatus(&bp, &orig_dvnode->status, orig_dvnode,
+	if (xdr_decode_AFSFetchStatus(call, &bp, &orig_dvnode->status, orig_dvnode,
 				      &call->expected_version, NULL) < 0)
-		return -EBADMSG;
+		return afs_protocol_error(call, -EBADMSG);
 	if (new_dvnode != orig_dvnode &&
-	    xdr_decode_AFSFetchStatus(&bp, &new_dvnode->status, new_dvnode,
+	    xdr_decode_AFSFetchStatus(call, &bp, &new_dvnode->status, new_dvnode,
 				      &call->expected_version_2, NULL) < 0)
-		return -EBADMSG;
+		return afs_protocol_error(call, -EBADMSG);
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
 	_leave(" = 0 [done]");
@@ -1204,9 +1206,9 @@ static int afs_deliver_fs_store_data(struct afs_call *call)
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	if (xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode,
+	if (xdr_decode_AFSFetchStatus(call, &bp, &vnode->status, vnode,
 				      &call->expected_version, NULL) < 0)
-		return -EBADMSG;
+		return afs_protocol_error(call, -EBADMSG);
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
 	afs_pages_written_back(vnode, call);
@@ -1380,9 +1382,9 @@ static int afs_deliver_fs_store_status(struct afs_call *call)
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	if (xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode,
+	if (xdr_decode_AFSFetchStatus(call, &bp, &vnode->status, vnode,
 				      &call->expected_version, NULL) < 0)
-		return -EBADMSG;
+		return afs_protocol_error(call, -EBADMSG);
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
 	_leave(" = 0 [done]");
@@ -1585,7 +1587,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		call->count = ntohl(call->tmp);
 		_debug("volname length: %u", call->count);
 		if (call->count >= AFSNAMEMAX)
-			return -EBADMSG;
+			return afs_protocol_error(call, -EBADMSG);
 		call->offset = 0;
 		call->unmarshall++;
 
@@ -1632,7 +1634,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		call->count = ntohl(call->tmp);
 		_debug("offline msg length: %u", call->count);
 		if (call->count >= AFSNAMEMAX)
-			return -EBADMSG;
+			return afs_protocol_error(call, -EBADMSG);
 		call->offset = 0;
 		call->unmarshall++;
 
@@ -1679,7 +1681,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		call->count = ntohl(call->tmp);
 		_debug("motd length: %u", call->count);
 		if (call->count >= AFSNAMEMAX)
-			return -EBADMSG;
+			return afs_protocol_error(call, -EBADMSG);
 		call->offset = 0;
 		call->unmarshall++;
 
@@ -2082,7 +2084,7 @@ static int afs_deliver_fs_fetch_status(struct afs_call *call)
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	xdr_decode_AFSFetchStatus(&bp, status, vnode,
+	xdr_decode_AFSFetchStatus(call, &bp, status, vnode,
 				  &call->expected_version, NULL);
 	callback[call->count].version	= ntohl(bp[0]);
 	callback[call->count].expiry	= ntohl(bp[1]);
@@ -2179,7 +2181,7 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		tmp = ntohl(call->tmp);
 		_debug("status count: %u/%u", tmp, call->count2);
 		if (tmp != call->count2)
-			return -EBADMSG;
+			return afs_protocol_error(call, -EBADMSG);
 
 		call->count = 0;
 		call->unmarshall++;
@@ -2194,10 +2196,10 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 
 		bp = call->buffer;
 		statuses = call->reply[1];
-		if (xdr_decode_AFSFetchStatus(&bp, &statuses[call->count],
+		if (xdr_decode_AFSFetchStatus(call, &bp, &statuses[call->count],
 					      call->count == 0 ? vnode : NULL,
 					      NULL, NULL) < 0)
-			return -EBADMSG;
+			return afs_protocol_error(call, -EBADMSG);
 
 		call->count++;
 		if (call->count < call->count2)
@@ -2217,7 +2219,7 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		tmp = ntohl(call->tmp);
 		_debug("CB count: %u", tmp);
 		if (tmp != call->count2)
-			return -EBADMSG;
+			return afs_protocol_error(call, -EBADMSG);
 		call->count = 0;
 		call->unmarshall++;
 	more_cbs:
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 3808dcbbac6d..06194cfe9724 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -82,7 +82,7 @@ static int afs_inode_init_from_status(struct afs_vnode *vnode, struct key *key)
 	default:
 		printk("kAFS: AFS vnode with undefined type\n");
 		read_sequnlock_excl(&vnode->cb_lock);
-		return -EBADMSG;
+		return afs_protocol_error(NULL, -EBADMSG);
 	}
 
 	inode->i_blocks		= 0;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index b4d2fac46fe8..901c11521662 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -872,6 +872,7 @@ extern void afs_flat_call_destructor(struct afs_call *);
 extern void afs_send_empty_reply(struct afs_call *);
 extern void afs_send_simple_reply(struct afs_call *, const void *, size_t);
 extern int afs_extract_data(struct afs_call *, void *, size_t, bool);
+extern int afs_protocol_error(struct afs_call *, int);
 
 static inline int afs_transfer_reply(struct afs_call *call)
 {
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index f7ae54b6a393..5c6263972ec9 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -926,3 +926,12 @@ int afs_extract_data(struct afs_call *call, void *buf, size_t count,
 	afs_set_call_complete(call, ret, remote_abort);
 	return ret;
 }
+
+/*
+ * Log protocol error production.
+ */
+noinline int afs_protocol_error(struct afs_call *call, int error)
+{
+	trace_afs_protocol_error(call, error, __builtin_return_address(0));
+	return error;
+}
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index f9d89795e41b..1ed7e2fd2f35 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -450,7 +450,7 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		call->count2	= ntohl(*bp); /* Type or next count */
 
 		if (call->count > YFS_MAXENDPOINTS)
-			return -EBADMSG;
+			return afs_protocol_error(call, -EBADMSG);
 
 		alist = afs_alloc_addrlist(call->count, FS_SERVICE, AFS_FS_PORT);
 		if (!alist)
@@ -474,7 +474,7 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 			size = sizeof(__be32) * (1 + 4 + 1);
 			break;
 		default:
-			return -EBADMSG;
+			return afs_protocol_error(call, -EBADMSG);
 		}
 
 		size += sizeof(__be32);
@@ -487,18 +487,18 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		switch (call->count2) {
 		case YFS_ENDPOINT_IPV4:
 			if (ntohl(bp[0]) != sizeof(__be32) * 2)
-				return -EBADMSG;
+				return afs_protocol_error(call, -EBADMSG);
 			afs_merge_fs_addr4(alist, bp[1], ntohl(bp[2]));
 			bp += 3;
 			break;
 		case YFS_ENDPOINT_IPV6:
 			if (ntohl(bp[0]) != sizeof(__be32) * 5)
-				return -EBADMSG;
+				return afs_protocol_error(call, -EBADMSG);
 			afs_merge_fs_addr6(alist, bp + 1, ntohl(bp[5]));
 			bp += 6;
 			break;
 		default:
-			return -EBADMSG;
+			return afs_protocol_error(call, -EBADMSG);
 		}
 
 		/* Got either the type of the next entry or the count of
@@ -517,7 +517,7 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		if (!call->count)
 			goto end;
 		if (call->count > YFS_MAXENDPOINTS)
-			return -EBADMSG;
+			return afs_protocol_error(call, -EBADMSG);
 
 		call->unmarshall = 3;
 
@@ -545,7 +545,7 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 			size = sizeof(__be32) * (1 + 4 + 1);
 			break;
 		default:
-			return -EBADMSG;
+			return afs_protocol_error(call, -EBADMSG);
 		}
 
 		if (call->count > 1)
@@ -558,16 +558,16 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		switch (call->count2) {
 		case YFS_ENDPOINT_IPV4:
 			if (ntohl(bp[0]) != sizeof(__be32) * 2)
-				return -EBADMSG;
+				return afs_protocol_error(call, -EBADMSG);
 			bp += 3;
 			break;
 		case YFS_ENDPOINT_IPV6:
 			if (ntohl(bp[0]) != sizeof(__be32) * 5)
-				return -EBADMSG;
+				return afs_protocol_error(call, -EBADMSG);
 			bp += 6;
 			break;
 		default:
-			return -EBADMSG;
+			return afs_protocol_error(call, -EBADMSG);
 		}
 
 		/* Got either the type of the next entry or the count of
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index f46dee0f5ced..f0820554caa9 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -554,6 +554,27 @@ TRACE_EVENT(afs_edit_dir,
 		      __entry->name)
 	    );
 
+TRACE_EVENT(afs_protocol_error,
+	    TP_PROTO(struct afs_call *call, int error, const void *where),
+
+	    TP_ARGS(call, error, where),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	call		)
+		    __field(int,		error		)
+		    __field(const void *,	where		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->call = call ? call->debug_id : 0;
+		    __entry->error = error;
+		    __entry->where = where;
+			   ),
+
+	    TP_printk("c=%08x r=%d sp=%pSR",
+		      __entry->call, __entry->error, __entry->where)
+	    );
+
 #endif /* _TRACE_AFS_H */
 
 /* This part must be outside protection */
