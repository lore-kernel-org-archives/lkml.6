Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC16ECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD25214C2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:12:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD25214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeJTJVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 05:21:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39712 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbeJTJVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 05:21:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 45AD283F4C;
        Sat, 20 Oct 2018 01:12:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FEF35B82D;
        Sat, 20 Oct 2018 01:12:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 17/24] afs: Calc callback expiry in op reply delivery
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 20 Oct 2018 02:12:41 +0100
Message-ID: <153999796149.866.692817507594344722.stgit@warthog.procyon.org.uk>
In-Reply-To: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
References: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Sat, 20 Oct 2018 01:12:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calculate the callback expiration time at the point of operation reply
delivery, using the reply time queried from AF_RXRPC on that call as a
base.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/afs.h      |    2 +-
 fs/afs/fsclient.c |   22 +++++++++++++++++-----
 fs/afs/inode.c    |    4 ++--
 fs/afs/internal.h |    2 ++
 fs/afs/rxrpc.c    |    6 ++++++
 5 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/fs/afs/afs.h b/fs/afs/afs.h
index fb9bcb8758ea..417cd23529c5 100644
--- a/fs/afs/afs.h
+++ b/fs/afs/afs.h
@@ -68,8 +68,8 @@ typedef enum {
 } afs_callback_type_t;
 
 struct afs_callback {
+	time64_t		expires_at;	/* Time at which expires */
 	unsigned		version;	/* Callback version */
-	unsigned		expiry;		/* Time at which expires */
 	afs_callback_type_t	type;		/* Type of callback */
 };
 
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index f758750e81d8..6105cdb17163 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -287,13 +287,19 @@ static void xdr_decode_AFSCallBack(struct afs_call *call,
 	*_bp = bp;
 }
 
-static void xdr_decode_AFSCallBack_raw(const __be32 **_bp,
+static ktime_t xdr_decode_expiry(struct afs_call *call, u32 expiry)
+{
+	return ktime_add_ns(call->reply_time, expiry * NSEC_PER_SEC);
+}
+
+static void xdr_decode_AFSCallBack_raw(struct afs_call *call,
+				       const __be32 **_bp,
 				       struct afs_callback *cb)
 {
 	const __be32 *bp = *_bp;
 
 	cb->version	= ntohl(*bp++);
-	cb->expiry	= ntohl(*bp++);
+	cb->expires_at	= xdr_decode_expiry(call, ntohl(*bp++));
 	cb->type	= ntohl(*bp++);
 	*_bp = bp;
 }
@@ -440,6 +446,7 @@ int afs_fs_fetch_file_status(struct afs_fs_cursor *fc, struct afs_volsync *volsy
 	call->reply[0] = vnode;
 	call->reply[1] = volsync;
 	call->expected_version = new_inode ? 1 : vnode->status.data_version;
+	call->want_reply_time = true;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -627,6 +634,7 @@ static int afs_fs_fetch_data64(struct afs_fs_cursor *fc, struct afs_read *req)
 	call->reply[1] = NULL; /* volsync */
 	call->reply[2] = req;
 	call->expected_version = vnode->status.data_version;
+	call->want_reply_time = true;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -672,6 +680,7 @@ int afs_fs_fetch_data(struct afs_fs_cursor *fc, struct afs_read *req)
 	call->reply[1] = NULL; /* volsync */
 	call->reply[2] = req;
 	call->expected_version = vnode->status.data_version;
+	call->want_reply_time = true;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -714,7 +723,7 @@ static int afs_deliver_fs_create_vnode(struct afs_call *call)
 				&call->expected_version, NULL);
 	if (ret < 0)
 		return ret;
-	xdr_decode_AFSCallBack_raw(&bp, call->reply[3]);
+	xdr_decode_AFSCallBack_raw(call, &bp, call->reply[3]);
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
 	_leave(" = 0 [done]");
@@ -773,6 +782,7 @@ int afs_fs_create(struct afs_fs_cursor *fc,
 	call->reply[2] = newstatus;
 	call->reply[3] = newcb;
 	call->expected_version = current_data_version + 1;
+	call->want_reply_time = true;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -2042,7 +2052,7 @@ static int afs_deliver_fs_fetch_status(struct afs_call *call)
 				&call->expected_version, NULL);
 	if (ret < 0)
 		return ret;
-	xdr_decode_AFSCallBack_raw(&bp, callback);
+	xdr_decode_AFSCallBack_raw(call, &bp, callback);
 	if (volsync)
 		xdr_decode_AFSVolSync(&bp, volsync);
 
@@ -2088,6 +2098,7 @@ int afs_fs_fetch_status(struct afs_fs_cursor *fc,
 	call->reply[2] = callback;
 	call->reply[3] = volsync;
 	call->expected_version = 1; /* vnode->status.data_version */
+	call->want_reply_time = true;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -2188,7 +2199,7 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		bp = call->buffer;
 		callbacks = call->reply[2];
 		callbacks[call->count].version	= ntohl(bp[0]);
-		callbacks[call->count].expiry	= ntohl(bp[1]);
+		callbacks[call->count].expires_at = xdr_decode_expiry(call, ntohl(bp[1]));
 		callbacks[call->count].type	= ntohl(bp[2]);
 		statuses = call->reply[1];
 		if (call->count == 0 && vnode && statuses[0].abort_code == 0)
@@ -2261,6 +2272,7 @@ int afs_fs_inline_bulk_status(struct afs_fs_cursor *fc,
 	call->reply[2] = callbacks;
 	call->reply[3] = volsync;
 	call->count2 = nr_fids;
+	call->want_reply_time = true;
 
 	/* marshall the parameters */
 	bp = call->request;
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 4ba47efe9668..4c6d8e1112c2 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -317,11 +317,11 @@ struct inode *afs_iget(struct super_block *sb, struct key *key,
 			 * didn't give us a callback) */
 			vnode->cb_version = 0;
 			vnode->cb_type = 0;
-			vnode->cb_expires_at = 0;
+			vnode->cb_expires_at = ktime_get();
 		} else {
 			vnode->cb_version = cb->version;
 			vnode->cb_type = cb->type;
-			vnode->cb_expires_at = cb->expiry;
+			vnode->cb_expires_at = cb->expires_at;
 			vnode->cb_interest = afs_get_cb_interest(cbi);
 			set_bit(AFS_VNODE_CB_PROMISED, &vnode->flags);
 		}
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 28d08aac515d..78065af05153 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -131,6 +131,7 @@ struct afs_call {
 	bool			async;		/* T if asynchronous */
 	bool			ret_reply0;	/* T if should return reply[0] on success */
 	bool			upgrade;	/* T to request service upgrade */
+	bool			want_reply_time;	/* T if want reply_time */
 	u16			service_id;	/* Actual service ID (after upgrade) */
 	unsigned int		debug_id;	/* Trace ID */
 	u32			operation_ID;	/* operation ID for an incoming call */
@@ -144,6 +145,7 @@ struct afs_call {
 	};
 	afs_dataversion_t	expected_version; /* Updated version expected from store */
 	afs_dataversion_t	expected_version_2; /* 2nd updated version expected from store */
+	ktime_t			reply_time;	/* Time of first reply packet */
 };
 
 struct afs_call_type {
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index ce98e133caa6..444ba0d511ef 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -499,6 +499,12 @@ static void afs_deliver_to_call(struct afs_call *call)
 			return;
 		}
 
+		if (call->want_reply_time &&
+		    rxrpc_kernel_get_reply_time(call->net->socket,
+						call->rxcall,
+						&call->reply_time))
+			call->want_reply_time = false;
+
 		ret = call->type->deliver(call);
 		state = READ_ONCE(call->state);
 		switch (ret) {

