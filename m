Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5E7ECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81845214C4
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81845214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbeJTJTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 05:19:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbeJTJTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 05:19:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B68E930BAC6A;
        Sat, 20 Oct 2018 01:11:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6BC9E100195E;
        Sat, 20 Oct 2018 01:11:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 04/24] afs: Better tracing of protocol errors
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 20 Oct 2018 02:11:06 +0100
Message-ID: <153999786662.866.987004254324526521.stgit@warthog.procyon.org.uk>
In-Reply-To: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
References: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Sat, 20 Oct 2018 01:11:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include the site of detection of AFS protocol errors in trace lines to
better be able to determine what went wrong.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/cmservice.c         |    6 ++
 fs/afs/fsclient.c          |  117 +++++++++++++++++++++++++++-----------------
 fs/afs/inode.c             |    2 -
 fs/afs/internal.h          |    2 -
 fs/afs/rxrpc.c             |    5 +-
 fs/afs/vlclient.c          |   30 ++++++++---
 include/trace/events/afs.h |   54 +++++++++++++++++---
 7 files changed, 146 insertions(+), 70 deletions(-)

diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index 9e51d6fe7e8f..58f79301a716 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -189,7 +189,8 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 		call->count = ntohl(call->tmp);
 		_debug("FID count: %u", call->count);
 		if (call->count > AFSCBMAX)
-			return afs_protocol_error(call, -EBADMSG);
+			return afs_protocol_error(call, -EBADMSG,
+						  afs_eproto_cb_fid_count);
 
 		call->buffer = kmalloc(array3_size(call->count, 3, 4),
 				       GFP_KERNEL);
@@ -234,7 +235,8 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 		call->count2 = ntohl(call->tmp);
 		_debug("CB count: %u", call->count2);
 		if (call->count2 != call->count && call->count2 != 0)
-			return afs_protocol_error(call, -EBADMSG);
+			return afs_protocol_error(call, -EBADMSG,
+						  afs_eproto_cb_count);
 		call->offset = 0;
 		call->unmarshall++;
 
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 50929cb91732..d9a5815945dc 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -233,7 +233,7 @@ static int xdr_decode_AFSFetchStatus(struct afs_call *call,
 
 bad:
 	xdr_dump_bad(*_bp);
-	return afs_protocol_error(call, -EBADMSG);
+	return afs_protocol_error(call, -EBADMSG, afs_eproto_bad_status);
 }
 
 /*
@@ -399,9 +399,10 @@ static int afs_deliver_fs_fetch_status_vnode(struct afs_call *call)
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	if (afs_decode_status(call, &bp, &vnode->status, vnode,
-			      &call->expected_version, NULL) < 0)
-		return afs_protocol_error(call, -EBADMSG);
+	ret = afs_decode_status(call, &bp, &vnode->status, vnode,
+				&call->expected_version, NULL);
+	if (ret < 0)
+		return ret;
 	xdr_decode_AFSCallBack(call, vnode, &bp);
 	if (call->reply[1])
 		xdr_decode_AFSVolSync(&bp, call->reply[1]);
@@ -580,9 +581,10 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 			return ret;
 
 		bp = call->buffer;
-		if (afs_decode_status(call, &bp, &vnode->status, vnode,
-				      &vnode->status.data_version, req) < 0)
-			return afs_protocol_error(call, -EBADMSG);
+		ret = afs_decode_status(call, &bp, &vnode->status, vnode,
+					&vnode->status.data_version, req);
+		if (ret < 0)
+			return ret;
 		xdr_decode_AFSCallBack(call, vnode, &bp);
 		if (call->reply[1])
 			xdr_decode_AFSVolSync(&bp, call->reply[1]);
@@ -733,10 +735,13 @@ static int afs_deliver_fs_create_vnode(struct afs_call *call)
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
 	xdr_decode_AFSFid(&bp, call->reply[1]);
-	if (afs_decode_status(call, &bp, call->reply[2], NULL, NULL, NULL) < 0 ||
-	    afs_decode_status(call, &bp, &vnode->status, vnode,
-			      &call->expected_version, NULL) < 0)
-		return afs_protocol_error(call, -EBADMSG);
+	ret = afs_decode_status(call, &bp, call->reply[2], NULL, NULL, NULL);
+	if (ret < 0)
+		return ret;
+	ret = afs_decode_status(call, &bp, &vnode->status, vnode,
+				&call->expected_version, NULL);
+	if (ret < 0)
+		return ret;
 	xdr_decode_AFSCallBack_raw(&bp, call->reply[3]);
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
@@ -839,9 +844,10 @@ static int afs_deliver_fs_remove(struct afs_call *call)
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	if (afs_decode_status(call, &bp, &vnode->status, vnode,
-			      &call->expected_version, NULL) < 0)
-		return afs_protocol_error(call, -EBADMSG);
+	ret = afs_decode_status(call, &bp, &vnode->status, vnode,
+				&call->expected_version, NULL);
+	if (ret < 0)
+		return ret;
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
 	_leave(" = 0 [done]");
@@ -929,10 +935,13 @@ static int afs_deliver_fs_link(struct afs_call *call)
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	if (afs_decode_status(call, &bp, &vnode->status, vnode, NULL, NULL) < 0 ||
-	    afs_decode_status(call, &bp, &dvnode->status, dvnode,
-			      &call->expected_version, NULL) < 0)
-		return afs_protocol_error(call, -EBADMSG);
+	ret = afs_decode_status(call, &bp, &vnode->status, vnode, NULL, NULL);
+	if (ret < 0)
+		return ret;
+	ret = afs_decode_status(call, &bp, &dvnode->status, dvnode,
+				&call->expected_version, NULL);
+	if (ret < 0)
+		return ret;
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
 	_leave(" = 0 [done]");
@@ -1016,10 +1025,13 @@ static int afs_deliver_fs_symlink(struct afs_call *call)
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
 	xdr_decode_AFSFid(&bp, call->reply[1]);
-	if (afs_decode_status(call, &bp, call->reply[2], NULL, NULL, NULL) ||
-	    afs_decode_status(call, &bp, &vnode->status, vnode,
-			      &call->expected_version, NULL) < 0)
-		return afs_protocol_error(call, -EBADMSG);
+	ret = afs_decode_status(call, &bp, call->reply[2], NULL, NULL, NULL);
+	if (ret < 0)
+		return ret;
+	ret = afs_decode_status(call, &bp, &vnode->status, vnode,
+				&call->expected_version, NULL);
+	if (ret < 0)
+		return ret;
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
 	_leave(" = 0 [done]");
@@ -1122,13 +1134,16 @@ static int afs_deliver_fs_rename(struct afs_call *call)
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	if (afs_decode_status(call, &bp, &orig_dvnode->status, orig_dvnode,
-			      &call->expected_version, NULL) < 0)
-		return afs_protocol_error(call, -EBADMSG);
-	if (new_dvnode != orig_dvnode &&
-	    afs_decode_status(call, &bp, &new_dvnode->status, new_dvnode,
-			      &call->expected_version_2, NULL) < 0)
-		return afs_protocol_error(call, -EBADMSG);
+	ret = afs_decode_status(call, &bp, &orig_dvnode->status, orig_dvnode,
+				&call->expected_version, NULL);
+	if (ret < 0)
+		return ret;
+	if (new_dvnode != orig_dvnode) {
+		ret = afs_decode_status(call, &bp, &new_dvnode->status, new_dvnode,
+					&call->expected_version_2, NULL);
+		if (ret < 0)
+			return ret;
+	}
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
 	_leave(" = 0 [done]");
@@ -1231,9 +1246,10 @@ static int afs_deliver_fs_store_data(struct afs_call *call)
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	if (afs_decode_status(call, &bp, &vnode->status, vnode,
-			      &call->expected_version, NULL) < 0)
-		return afs_protocol_error(call, -EBADMSG);
+	ret = afs_decode_status(call, &bp, &vnode->status, vnode,
+				&call->expected_version, NULL);
+	if (ret < 0)
+		return ret;
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
 	afs_pages_written_back(vnode, call);
@@ -1407,9 +1423,10 @@ static int afs_deliver_fs_store_status(struct afs_call *call)
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	if (afs_decode_status(call, &bp, &vnode->status, vnode,
-			      &call->expected_version, NULL) < 0)
-		return afs_protocol_error(call, -EBADMSG);
+	ret = afs_decode_status(call, &bp, &vnode->status, vnode,
+				&call->expected_version, NULL);
+	if (ret < 0)
+		return ret;
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
 	_leave(" = 0 [done]");
@@ -1612,7 +1629,8 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		call->count = ntohl(call->tmp);
 		_debug("volname length: %u", call->count);
 		if (call->count >= AFSNAMEMAX)
-			return afs_protocol_error(call, -EBADMSG);
+			return afs_protocol_error(call, -EBADMSG,
+						  afs_eproto_volname_len);
 		call->offset = 0;
 		call->unmarshall++;
 
@@ -1659,7 +1677,8 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		call->count = ntohl(call->tmp);
 		_debug("offline msg length: %u", call->count);
 		if (call->count >= AFSNAMEMAX)
-			return afs_protocol_error(call, -EBADMSG);
+			return afs_protocol_error(call, -EBADMSG,
+						  afs_eproto_offline_msg_len);
 		call->offset = 0;
 		call->unmarshall++;
 
@@ -1706,7 +1725,8 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		call->count = ntohl(call->tmp);
 		_debug("motd length: %u", call->count);
 		if (call->count >= AFSNAMEMAX)
-			return afs_protocol_error(call, -EBADMSG);
+			return afs_protocol_error(call, -EBADMSG,
+						  afs_eproto_motd_len);
 		call->offset = 0;
 		call->unmarshall++;
 
@@ -2109,8 +2129,10 @@ static int afs_deliver_fs_fetch_status(struct afs_call *call)
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	afs_decode_status(call, &bp, status, vnode,
-			  &call->expected_version, NULL);
+	ret = afs_decode_status(call, &bp, status, vnode,
+				&call->expected_version, NULL);
+	if (ret < 0)
+		return ret;
 	callback[call->count].version	= ntohl(bp[0]);
 	callback[call->count].expiry	= ntohl(bp[1]);
 	callback[call->count].type	= ntohl(bp[2]);
@@ -2206,7 +2228,8 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		tmp = ntohl(call->tmp);
 		_debug("status count: %u/%u", tmp, call->count2);
 		if (tmp != call->count2)
-			return afs_protocol_error(call, -EBADMSG);
+			return afs_protocol_error(call, -EBADMSG,
+						  afs_eproto_ibulkst_count);
 
 		call->count = 0;
 		call->unmarshall++;
@@ -2221,10 +2244,11 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 
 		bp = call->buffer;
 		statuses = call->reply[1];
-		if (afs_decode_status(call, &bp, &statuses[call->count],
-				      call->count == 0 ? vnode : NULL,
-				      NULL, NULL) < 0)
-			return afs_protocol_error(call, -EBADMSG);
+		ret = afs_decode_status(call, &bp, &statuses[call->count],
+					call->count == 0 ? vnode : NULL,
+					NULL, NULL);
+		if (ret < 0)
+			return ret;
 
 		call->count++;
 		if (call->count < call->count2)
@@ -2244,7 +2268,8 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		tmp = ntohl(call->tmp);
 		_debug("CB count: %u", tmp);
 		if (tmp != call->count2)
-			return afs_protocol_error(call, -EBADMSG);
+			return afs_protocol_error(call, -EBADMSG,
+						  afs_eproto_ibulkst_cb_count);
 		call->count = 0;
 		call->unmarshall++;
 	more_cbs:
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 479b7fdda124..ab4e7a15c205 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -82,7 +82,7 @@ static int afs_inode_init_from_status(struct afs_vnode *vnode, struct key *key)
 	default:
 		printk("kAFS: AFS vnode with undefined type\n");
 		read_sequnlock_excl(&vnode->cb_lock);
-		return afs_protocol_error(NULL, -EBADMSG);
+		return afs_protocol_error(NULL, -EBADMSG, afs_eproto_file_type);
 	}
 
 	inode->i_blocks		= 0;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 72de1f157d20..73770a2a2311 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -931,7 +931,7 @@ extern void afs_flat_call_destructor(struct afs_call *);
 extern void afs_send_empty_reply(struct afs_call *);
 extern void afs_send_simple_reply(struct afs_call *, const void *, size_t);
 extern int afs_extract_data(struct afs_call *, void *, size_t, bool);
-extern int afs_protocol_error(struct afs_call *, int);
+extern int afs_protocol_error(struct afs_call *, int, enum afs_eproto_cause);
 
 static inline int afs_transfer_reply(struct afs_call *call)
 {
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 639c16882e93..9757c2d953f1 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -939,8 +939,9 @@ int afs_extract_data(struct afs_call *call, void *buf, size_t count,
 /*
  * Log protocol error production.
  */
-noinline int afs_protocol_error(struct afs_call *call, int error)
+noinline int afs_protocol_error(struct afs_call *call, int error,
+				enum afs_eproto_cause cause)
 {
-	trace_afs_protocol_error(call, error, __builtin_return_address(0));
+	trace_afs_protocol_error(call, error, cause);
 	return error;
 }
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index c3b740813fc7..d0f95c4ab05e 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -451,7 +451,8 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		call->count2	= ntohl(*bp); /* Type or next count */
 
 		if (call->count > YFS_MAXENDPOINTS)
-			return afs_protocol_error(call, -EBADMSG);
+			return afs_protocol_error(call, -EBADMSG,
+						  afs_eproto_yvl_fsendpt_num);
 
 		alist = afs_alloc_addrlist(call->count, FS_SERVICE, AFS_FS_PORT);
 		if (!alist)
@@ -475,7 +476,8 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 			size = sizeof(__be32) * (1 + 4 + 1);
 			break;
 		default:
-			return afs_protocol_error(call, -EBADMSG);
+			return afs_protocol_error(call, -EBADMSG,
+						  afs_eproto_yvl_fsendpt_type);
 		}
 
 		size += sizeof(__be32);
@@ -488,18 +490,21 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		switch (call->count2) {
 		case YFS_ENDPOINT_IPV4:
 			if (ntohl(bp[0]) != sizeof(__be32) * 2)
-				return afs_protocol_error(call, -EBADMSG);
+				return afs_protocol_error(call, -EBADMSG,
+							  afs_eproto_yvl_fsendpt4_len);
 			afs_merge_fs_addr4(alist, bp[1], ntohl(bp[2]));
 			bp += 3;
 			break;
 		case YFS_ENDPOINT_IPV6:
 			if (ntohl(bp[0]) != sizeof(__be32) * 5)
-				return afs_protocol_error(call, -EBADMSG);
+				return afs_protocol_error(call, -EBADMSG,
+							  afs_eproto_yvl_fsendpt6_len);
 			afs_merge_fs_addr6(alist, bp + 1, ntohl(bp[5]));
 			bp += 6;
 			break;
 		default:
-			return afs_protocol_error(call, -EBADMSG);
+			return afs_protocol_error(call, -EBADMSG,
+						  afs_eproto_yvl_fsendpt_type);
 		}
 
 		/* Got either the type of the next entry or the count of
@@ -518,7 +523,8 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		if (!call->count)
 			goto end;
 		if (call->count > YFS_MAXENDPOINTS)
-			return afs_protocol_error(call, -EBADMSG);
+			return afs_protocol_error(call, -EBADMSG,
+						  afs_eproto_yvl_vlendpt_type);
 
 		call->unmarshall = 3;
 
@@ -546,7 +552,8 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 			size = sizeof(__be32) * (1 + 4 + 1);
 			break;
 		default:
-			return afs_protocol_error(call, -EBADMSG);
+			return afs_protocol_error(call, -EBADMSG,
+						  afs_eproto_yvl_vlendpt_type);
 		}
 
 		if (call->count > 1)
@@ -559,16 +566,19 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		switch (call->count2) {
 		case YFS_ENDPOINT_IPV4:
 			if (ntohl(bp[0]) != sizeof(__be32) * 2)
-				return afs_protocol_error(call, -EBADMSG);
+				return afs_protocol_error(call, -EBADMSG,
+							  afs_eproto_yvl_vlendpt4_len);
 			bp += 3;
 			break;
 		case YFS_ENDPOINT_IPV6:
 			if (ntohl(bp[0]) != sizeof(__be32) * 5)
-				return afs_protocol_error(call, -EBADMSG);
+				return afs_protocol_error(call, -EBADMSG,
+							  afs_eproto_yvl_vlendpt6_len);
 			bp += 6;
 			break;
 		default:
-			return afs_protocol_error(call, -EBADMSG);
+			return afs_protocol_error(call, -EBADMSG,
+						  afs_eproto_yvl_vlendpt_type);
 		}
 
 		/* Got either the type of the next entry or the count of
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index d0a341bc4540..5c60ade2c7d8 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -84,6 +84,25 @@ enum afs_edit_dir_reason {
 	afs_edit_dir_for_unlink,
 };
 
+enum afs_eproto_cause {
+	afs_eproto_bad_status,
+	afs_eproto_cb_count,
+	afs_eproto_cb_fid_count,
+	afs_eproto_file_type,
+	afs_eproto_ibulkst_cb_count,
+	afs_eproto_ibulkst_count,
+	afs_eproto_motd_len,
+	afs_eproto_offline_msg_len,
+	afs_eproto_volname_len,
+	afs_eproto_yvl_fsendpt4_len,
+	afs_eproto_yvl_fsendpt6_len,
+	afs_eproto_yvl_fsendpt_num,
+	afs_eproto_yvl_fsendpt_type,
+	afs_eproto_yvl_vlendpt4_len,
+	afs_eproto_yvl_vlendpt6_len,
+	afs_eproto_yvl_vlendpt_type,
+};
+
 #endif /* end __AFS_DECLARE_TRACE_ENUMS_ONCE_ONLY */
 
 /*
@@ -146,6 +165,24 @@ enum afs_edit_dir_reason {
 	EM(afs_edit_dir_for_symlink,		"Symlnk") \
 	E_(afs_edit_dir_for_unlink,		"Unlink")
 
+#define afs_eproto_causes			\
+	EM(afs_eproto_bad_status,	"BadStatus") \
+	EM(afs_eproto_cb_count,		"CbCount") \
+	EM(afs_eproto_cb_fid_count,	"CbFidCount") \
+	EM(afs_eproto_file_type,	"FileTYpe") \
+	EM(afs_eproto_ibulkst_cb_count,	"IBS.CbCount") \
+	EM(afs_eproto_ibulkst_count,	"IBS.FidCount") \
+	EM(afs_eproto_motd_len,		"MotdLen") \
+	EM(afs_eproto_offline_msg_len,	"OfflineMsgLen") \
+	EM(afs_eproto_volname_len,	"VolNameLen") \
+	EM(afs_eproto_yvl_fsendpt4_len,	"YVL.FsEnd4Len") \
+	EM(afs_eproto_yvl_fsendpt6_len,	"YVL.FsEnd6Len") \
+	EM(afs_eproto_yvl_fsendpt_num,	"YVL.FsEndCount") \
+	EM(afs_eproto_yvl_fsendpt_type,	"YVL.FsEndType") \
+	EM(afs_eproto_yvl_vlendpt4_len,	"YVL.VlEnd4Len") \
+	EM(afs_eproto_yvl_vlendpt6_len,	"YVL.VlEnd6Len") \
+	E_(afs_eproto_yvl_vlendpt_type,	"YVL.VlEndType")
+
 
 /*
  * Export enum symbols via userspace.
@@ -555,24 +592,25 @@ TRACE_EVENT(afs_edit_dir,
 	    );
 
 TRACE_EVENT(afs_protocol_error,
-	    TP_PROTO(struct afs_call *call, int error, const void *where),
+	    TP_PROTO(struct afs_call *call, int error, enum afs_eproto_cause cause),
 
-	    TP_ARGS(call, error, where),
+	    TP_ARGS(call, error, cause),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,	call		)
-		    __field(int,		error		)
-		    __field(const void *,	where		)
+		    __field(unsigned int,		call		)
+		    __field(int,			error		)
+		    __field(enum afs_eproto_cause,	cause		)
 			     ),
 
 	    TP_fast_assign(
 		    __entry->call = call ? call->debug_id : 0;
 		    __entry->error = error;
-		    __entry->where = where;
+		    __entry->cause = cause;
 			   ),
 
-	    TP_printk("c=%08x r=%d sp=%pSR",
-		      __entry->call, __entry->error, __entry->where)
+	    TP_printk("c=%08x r=%d %s",
+		      __entry->call, __entry->error,
+		      __print_symbolic(__entry->cause, afs_eproto_causes))
 	    );
 
 TRACE_EVENT(afs_cm_no_server,

