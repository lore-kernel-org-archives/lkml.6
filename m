Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99E1ECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3AE214C2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3AE214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbeJTJVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 05:21:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbeJTJVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 05:21:02 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 69A2C90C88;
        Sat, 20 Oct 2018 01:12:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 633DF194A8;
        Sat, 20 Oct 2018 01:12:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 15/24] afs: Implement the YFS cache manager service
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 20 Oct 2018 02:12:26 +0100
Message-ID: <153999794660.866.12219513217767399118.stgit@warthog.procyon.org.uk>
In-Reply-To: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
References: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sat, 20 Oct 2018 01:12:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the YFS cache manager service which gives extra capabilities on
top of AFS.  This is done by listening for an additional service on the
same port and indicating that anyone requesting an upgrade should be
upgraded to the YFS port.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/cmservice.c    |  103 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/afs/protocol_yfs.h |   57 +++++++++++++++++++++++++++
 fs/afs/rxrpc.c        |   15 +++++++
 3 files changed, 174 insertions(+), 1 deletion(-)
 create mode 100644 fs/afs/protocol_yfs.h

diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index fc0010d800a0..8cf8d10daa6c 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -16,6 +16,7 @@
 #include <linux/ip.h>
 #include "internal.h"
 #include "afs_cm.h"
+#include "protocol_yfs.h"
 
 static int afs_deliver_cb_init_call_back_state(struct afs_call *);
 static int afs_deliver_cb_init_call_back_state3(struct afs_call *);
@@ -30,6 +31,8 @@ static void SRXAFSCB_Probe(struct work_struct *);
 static void SRXAFSCB_ProbeUuid(struct work_struct *);
 static void SRXAFSCB_TellMeAboutYourself(struct work_struct *);
 
+static int afs_deliver_yfs_cb_callback(struct afs_call *);
+
 #define CM_NAME(name) \
 	const char afs_SRXCB##name##_name[] __tracepoint_string =	\
 		"CB." #name
@@ -100,13 +103,24 @@ static const struct afs_call_type afs_SRXCBTellMeAboutYourself = {
 	.work		= SRXAFSCB_TellMeAboutYourself,
 };
 
+/*
+ * YFS CB.CallBack operation type
+ */
+static CM_NAME(YFS_CallBack);
+static const struct afs_call_type afs_SRXYFSCB_CallBack = {
+	.name		= afs_SRXCBYFS_CallBack_name,
+	.deliver	= afs_deliver_yfs_cb_callback,
+	.destructor	= afs_cm_destructor,
+	.work		= SRXAFSCB_CallBack,
+};
+
 /*
  * route an incoming cache manager call
  * - return T if supported, F if not
  */
 bool afs_cm_incoming_call(struct afs_call *call)
 {
-	_enter("{CB.OP %u}", call->operation_ID);
+	_enter("{%u, CB.OP %u}", call->service_id, call->operation_ID);
 
 	switch (call->operation_ID) {
 	case CBCallBack:
@@ -127,6 +141,11 @@ bool afs_cm_incoming_call(struct afs_call *call)
 	case CBTellMeAboutYourself:
 		call->type = &afs_SRXCBTellMeAboutYourself;
 		return true;
+	case YFSCBCallBack:
+		if (call->service_id != YFS_CM_SERVICE)
+			return false;
+		call->type = &afs_SRXYFSCB_CallBack;
+		return true;
 	default:
 		return false;
 	}
@@ -570,3 +589,85 @@ static int afs_deliver_cb_tell_me_about_yourself(struct afs_call *call)
 
 	return afs_queue_call_work(call);
 }
+
+/*
+ * deliver request data to a YFS CB.CallBack call
+ */
+static int afs_deliver_yfs_cb_callback(struct afs_call *call)
+{
+	struct afs_callback_break *cb;
+	struct sockaddr_rxrpc srx;
+	struct yfs_xdr_YFSFid *bp;
+	size_t size;
+	int ret, loop;
+
+	_enter("{%u}", call->unmarshall);
+
+	switch (call->unmarshall) {
+	case 0:
+		afs_extract_to_tmp(call);
+		call->unmarshall++;
+
+		/* extract the FID array and its count in two steps */
+	case 1:
+		_debug("extract FID count");
+		ret = afs_extract_data(call, true);
+		if (ret < 0)
+			return ret;
+
+		call->count = ntohl(call->tmp);
+		_debug("FID count: %u", call->count);
+		if (call->count > YFSCBMAX)
+			return afs_protocol_error(call, -EBADMSG,
+						  afs_eproto_cb_fid_count);
+
+		size = array_size(call->count, sizeof(struct yfs_xdr_YFSFid));
+		call->buffer = kmalloc(size, GFP_KERNEL);
+		if (!call->buffer)
+			return -ENOMEM;
+		afs_extract_to_buf(call, size);
+		call->unmarshall++;
+
+	case 2:
+		_debug("extract FID array");
+		ret = afs_extract_data(call, false);
+		if (ret < 0)
+			return ret;
+
+		_debug("unmarshall FID array");
+		call->request = kcalloc(call->count,
+					sizeof(struct afs_callback_break),
+					GFP_KERNEL);
+		if (!call->request)
+			return -ENOMEM;
+
+		cb = call->request;
+		bp = call->buffer;
+		for (loop = call->count; loop > 0; loop--, cb++) {
+			cb->fid.vid	= xdr_to_u64(bp->volume);
+			cb->fid.vnode	= xdr_to_u64(bp->vnode.lo);
+			cb->fid.vnode_hi = ntohl(bp->vnode.hi);
+			cb->fid.unique	= ntohl(bp->vnode.unique);
+			bp++;
+		}
+
+		afs_extract_to_tmp(call);
+		call->unmarshall++;
+
+	case 3:
+		break;
+	}
+
+	if (!afs_check_call_state(call, AFS_CALL_SV_REPLYING))
+		return afs_io_error(call, afs_io_error_cm_reply);
+
+	/* We'll need the file server record as that tells us which set of
+	 * vnodes to operate upon.
+	 */
+	rxrpc_kernel_get_peer(call->net->socket, call->rxcall, &srx);
+	call->cm_server = afs_find_server(call->net, &srx);
+	if (!call->cm_server)
+		trace_afs_cm_no_server(call, &srx);
+
+	return afs_queue_call_work(call);
+}
diff --git a/fs/afs/protocol_yfs.h b/fs/afs/protocol_yfs.h
new file mode 100644
index 000000000000..b7b211dd9857
--- /dev/null
+++ b/fs/afs/protocol_yfs.h
@@ -0,0 +1,57 @@
+/* YFS protocol bits
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
+#define YFS_FS_SERVICE	2500
+#define YFS_CM_SERVICE	2501
+
+#define YFSCBMAX 1024
+
+enum YFS_CM_Operations {
+	YFSCBProbe		= 206,	/* probe client */
+	YFSCBGetLock		= 207,	/* get contents of CM lock table */
+	YFSCBXStatsVersion	= 209,	/* get version of extended statistics */
+	YFSCBGetXStats		= 210,	/* get contents of extended statistics data */
+	YFSCBInitCallBackState3	= 213,	/* initialise callback state, version 3 */
+	YFSCBProbeUuid		= 214,	/* check the client hasn't rebooted */
+	YFSCBGetServerPrefs	= 215,
+	YFSCBGetCellServDV	= 216,
+	YFSCBGetLocalCell	= 217,
+	YFSCBGetCacheConfig	= 218,
+	YFSCBGetCellByNum	= 65537,
+	YFSCBTellMeAboutYourself = 65538, /* get client capabilities */
+	YFSCBCallBack		= 64204,
+};
+
+struct yfs_xdr_u64 {
+	__be32			msw;
+	__be32			lsw;
+} __packed;
+
+static inline u64 xdr_to_u64(const struct yfs_xdr_u64 x)
+{
+	return ((u64)ntohl(x.msw) << 32) | ntohl(x.lsw);
+}
+
+static inline struct yfs_xdr_u64 u64_to_xdr(const u64 x)
+{
+	return (struct yfs_xdr_u64){ .msw = htonl(x >> 32), .lsw = htonl(x) };
+}
+
+struct yfs_xdr_vnode {
+	struct yfs_xdr_u64	lo;
+	__be32			hi;
+	__be32			unique;
+} __packed;
+
+struct yfs_xdr_YFSFid {
+	struct yfs_xdr_u64	volume;
+	struct yfs_xdr_vnode	vnode;
+} __packed;
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index e6ab824ab761..ce98e133caa6 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -16,6 +16,7 @@
 #include <net/af_rxrpc.h>
 #include "internal.h"
 #include "afs_cm.h"
+#include "protocol_yfs.h"
 
 struct workqueue_struct *afs_async_calls;
 
@@ -42,6 +43,7 @@ int afs_open_socket(struct afs_net *net)
 	struct sockaddr_rxrpc srx;
 	struct socket *socket;
 	unsigned int min_level;
+	u16 service_upgrade[2];
 	int ret;
 
 	_enter("");
@@ -75,6 +77,19 @@ int afs_open_socket(struct afs_net *net)
 	if (ret < 0)
 		goto error_2;
 
+	srx.srx_service = YFS_CM_SERVICE;
+	ret = kernel_bind(socket, (struct sockaddr *) &srx, sizeof(srx));
+	if (ret < 0)
+		goto error_2;
+
+	service_upgrade[0] = CM_SERVICE;
+	service_upgrade[1] = YFS_CM_SERVICE;
+	ret = kernel_setsockopt(socket, SOL_RXRPC, RXRPC_UPGRADEABLE_SERVICE,
+				(void *)service_upgrade, sizeof(service_upgrade));
+	if (ret < 0)
+		goto error_2;
+
+
 	rxrpc_kernel_new_call_notification(socket, afs_rx_new_call,
 					   afs_rx_discard_new_call);
 

