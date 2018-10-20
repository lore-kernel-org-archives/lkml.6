Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F63BECDE43
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B146214C4
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B146214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeJTJWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 05:22:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbeJTJWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 05:22:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BD4C4307B972;
        Sat, 20 Oct 2018 01:13:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C40F26315B;
        Sat, 20 Oct 2018 01:13:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 24/24] afs: Probe multiple fileservers simultaneously
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 20 Oct 2018 02:13:32 +0100
Message-ID: <153999801194.866.3517526711849418520.stgit@warthog.procyon.org.uk>
In-Reply-To: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
References: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Sat, 20 Oct 2018 01:13:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Send probes to all the unprobed fileservers in a fileserver list on all
addresses simultaneously in an attempt to find out the fastest route whilst
not getting stuck for 20s on any server or address that we don't get a
reply from.

This alleviates the problem whereby attempting to access a new server can
take a long time because the rotation algorithm ends up rotating through
all servers and addresses until it finds one that responds.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/Makefile            |    4 -
 fs/afs/addr_list.c         |   40 ++++--
 fs/afs/cmservice.c         |  129 +++++++++++++++------
 fs/afs/fs_probe.c          |  270 ++++++++++++++++++++++++++++++++++++++++++++
 fs/afs/fsclient.c          |   27 +++-
 fs/afs/internal.h          |   98 +++++++++++++---
 fs/afs/proc.c              |    6 -
 fs/afs/rotate.c            |  174 ++++++++++++++++++----------
 fs/afs/rxrpc.c             |   44 ++++---
 fs/afs/server.c            |  109 +-----------------
 fs/afs/server_list.c       |    6 -
 fs/afs/vl_list.c           |    6 +
 fs/afs/vl_probe.c          |  273 ++++++++++++++++++++++++++++++++++++++++++++
 fs/afs/vl_rotate.c         |  159 +++++++++++++++++---------
 fs/afs/vlclient.c          |   35 +++---
 fs/afs/volume.c            |   16 ---
 include/trace/events/afs.h |    4 -
 17 files changed, 1050 insertions(+), 350 deletions(-)
 create mode 100644 fs/afs/fs_probe.c
 create mode 100644 fs/afs/vl_probe.c

diff --git a/fs/afs/Makefile b/fs/afs/Makefile
index cc942b790cff..0738e2bf5193 100644
--- a/fs/afs/Makefile
+++ b/fs/afs/Makefile
@@ -17,6 +17,7 @@ kafs-y := \
 	file.o \
 	flock.o \
 	fsclient.o \
+	fs_probe.o \
 	inode.o \
 	main.o \
 	misc.o \
@@ -29,8 +30,9 @@ kafs-y := \
 	super.o \
 	netdevices.o \
 	vlclient.o \
-	vl_rotate.o \
 	vl_list.o \
+	vl_probe.o \
+	vl_rotate.o \
 	volume.o \
 	write.o \
 	xattr.o \
diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index 1536d1d21c33..967db336d11a 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -303,6 +303,8 @@ void afs_merge_fs_addr4(struct afs_addr_list *alist, __be32 xdr, u16 port)
 			sizeof(alist->addrs[0]) * (alist->nr_addrs - i));
 
 	srx = &alist->addrs[i];
+	srx->srx_family = AF_RXRPC;
+	srx->transport_type = SOCK_DGRAM;
 	srx->transport_len = sizeof(srx->transport.sin);
 	srx->transport.sin.sin_family = AF_INET;
 	srx->transport.sin.sin_port = htons(port);
@@ -341,6 +343,8 @@ void afs_merge_fs_addr6(struct afs_addr_list *alist, __be32 *xdr, u16 port)
 			sizeof(alist->addrs[0]) * (alist->nr_addrs - i));
 
 	srx = &alist->addrs[i];
+	srx->srx_family = AF_RXRPC;
+	srx->transport_type = SOCK_DGRAM;
 	srx->transport_len = sizeof(srx->transport.sin6);
 	srx->transport.sin6.sin6_family = AF_INET6;
 	srx->transport.sin6.sin6_port = htons(port);
@@ -353,23 +357,32 @@ void afs_merge_fs_addr6(struct afs_addr_list *alist, __be32 *xdr, u16 port)
  */
 bool afs_iterate_addresses(struct afs_addr_cursor *ac)
 {
-	_enter("%hu+%hd", ac->start, (short)ac->index);
+	unsigned long set, failed;
+	int index;
 
 	if (!ac->alist)
 		return false;
 
+	set = ac->alist->responded;
+	failed = ac->alist->failed;
+	_enter("%lx-%lx-%lx,%d", set, failed, ac->tried, ac->index);
+
 	ac->nr_iterations++;
 
-	if (ac->begun) {
-		ac->index++;
-		if (ac->index == ac->alist->nr_addrs)
-			ac->index = 0;
+	set &= ~(failed | ac->tried);
 
-		if (ac->index == ac->start)
-			return false;
-	}
+	if (!set)
+		return false;
+
+	index = READ_ONCE(ac->alist->preferred);
+	if (test_bit(index, &set))
+		goto selected;
+
+	index = __ffs(set);
 
-	ac->begun = true;
+selected:
+	ac->index = index;
+	set_bit(index, &ac->tried);
 	ac->responded = false;
 	return true;
 }
@@ -383,12 +396,13 @@ int afs_end_cursor(struct afs_addr_cursor *ac)
 
 	alist = ac->alist;
 	if (alist) {
-		if (ac->responded && ac->index != ac->start)
-			WRITE_ONCE(alist->index, ac->index);
+		if (ac->responded &&
+		    ac->index != alist->preferred &&
+		    test_bit(ac->alist->preferred, &ac->tried))
+			WRITE_ONCE(alist->preferred, ac->index);
 		afs_put_addrlist(alist);
+		ac->alist = NULL;
 	}
 
-	ac->alist = NULL;
-	ac->begun = false;
 	return ac->error;
 }
diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index 8cf8d10daa6c..8ee5972893ed 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -122,6 +122,8 @@ bool afs_cm_incoming_call(struct afs_call *call)
 {
 	_enter("{%u, CB.OP %u}", call->service_id, call->operation_ID);
 
+	call->epoch = rxrpc_kernel_get_epoch(call->net->socket, call->rxcall);
+
 	switch (call->operation_ID) {
 	case CBCallBack:
 		call->type = &afs_SRXCBCallBack;
@@ -151,6 +153,91 @@ bool afs_cm_incoming_call(struct afs_call *call)
 	}
 }
 
+/*
+ * Record a probe to the cache manager from a server.
+ */
+static int afs_record_cm_probe(struct afs_call *call, struct afs_server *server)
+{
+	_enter("");
+
+	if (test_bit(AFS_SERVER_FL_HAVE_EPOCH, &server->flags) &&
+	    !test_bit(AFS_SERVER_FL_PROBING, &server->flags)) {
+		if (server->cm_epoch == call->epoch)
+			return 0;
+
+		if (!server->probe.said_rebooted) {
+			pr_notice("kAFS: FS rebooted %pU\n", &server->uuid);
+			server->probe.said_rebooted = true;
+		}
+	}
+
+	spin_lock(&server->probe_lock);
+
+	if (!test_bit(AFS_SERVER_FL_HAVE_EPOCH, &server->flags)) {
+		server->cm_epoch = call->epoch;
+		server->probe.cm_epoch = call->epoch;
+		goto out;
+	}
+
+	if (server->probe.cm_probed &&
+	    call->epoch != server->probe.cm_epoch &&
+	    !server->probe.said_inconsistent) {
+		pr_notice("kAFS: FS endpoints inconsistent %pU\n",
+			  &server->uuid);
+		server->probe.said_inconsistent = true;
+	}
+
+	if (!server->probe.cm_probed || call->epoch == server->cm_epoch)
+		server->probe.cm_epoch = server->cm_epoch;
+
+out:
+	server->probe.cm_probed = true;
+	spin_unlock(&server->probe_lock);
+	return 0;
+}
+
+/*
+ * Find the server record by peer address and record a probe to the cache
+ * manager from a server.
+ */
+static int afs_find_cm_server_by_peer(struct afs_call *call)
+{
+	struct sockaddr_rxrpc srx;
+	struct afs_server *server;
+
+	rxrpc_kernel_get_peer(call->net->socket, call->rxcall, &srx);
+
+	server = afs_find_server(call->net, &srx);
+	if (!server) {
+		trace_afs_cm_no_server(call, &srx);
+		return 0;
+	}
+
+	call->cm_server = server;
+	return afs_record_cm_probe(call, server);
+}
+
+/*
+ * Find the server record by server UUID and record a probe to the cache
+ * manager from a server.
+ */
+static int afs_find_cm_server_by_uuid(struct afs_call *call,
+				      struct afs_uuid *uuid)
+{
+	struct afs_server *server;
+
+	rcu_read_lock();
+	server = afs_find_server_by_uuid(call->net, call->request);
+	rcu_read_unlock();
+	if (!server) {
+		trace_afs_cm_no_server_u(call, call->request);
+		return 0;
+	}
+
+	call->cm_server = server;
+	return afs_record_cm_probe(call, server);
+}
+
 /*
  * Clean up a cache manager call.
  */
@@ -187,7 +274,6 @@ static void SRXAFSCB_CallBack(struct work_struct *work)
 static int afs_deliver_cb_callback(struct afs_call *call)
 {
 	struct afs_callback_break *cb;
-	struct sockaddr_rxrpc srx;
 	__be32 *bp;
 	int ret, loop;
 
@@ -276,12 +362,7 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 
 	/* we'll need the file server record as that tells us which set of
 	 * vnodes to operate upon */
-	rxrpc_kernel_get_peer(call->net->socket, call->rxcall, &srx);
-	call->cm_server = afs_find_server(call->net, &srx);
-	if (!call->cm_server)
-		trace_afs_cm_no_server(call, &srx);
-
-	return afs_queue_call_work(call);
+	return afs_find_cm_server_by_peer(call);
 }
 
 /*
@@ -305,13 +386,10 @@ static void SRXAFSCB_InitCallBackState(struct work_struct *work)
  */
 static int afs_deliver_cb_init_call_back_state(struct afs_call *call)
 {
-	struct sockaddr_rxrpc srx;
 	int ret;
 
 	_enter("");
 
-	rxrpc_kernel_get_peer(call->net->socket, call->rxcall, &srx);
-
 	afs_extract_discard(call, 0);
 	ret = afs_extract_data(call, false);
 	if (ret < 0)
@@ -319,11 +397,7 @@ static int afs_deliver_cb_init_call_back_state(struct afs_call *call)
 
 	/* we'll need the file server record as that tells us which set of
 	 * vnodes to operate upon */
-	call->cm_server = afs_find_server(call->net, &srx);
-	if (!call->cm_server)
-		trace_afs_cm_no_server(call, &srx);
-
-	return afs_queue_call_work(call);
+	return afs_find_cm_server_by_peer(call);
 }
 
 /*
@@ -384,13 +458,7 @@ static int afs_deliver_cb_init_call_back_state3(struct afs_call *call)
 
 	/* we'll need the file server record as that tells us which set of
 	 * vnodes to operate upon */
-	rcu_read_lock();
-	call->cm_server = afs_find_server_by_uuid(call->net, call->request);
-	rcu_read_unlock();
-	if (!call->cm_server)
-		trace_afs_cm_no_server_u(call, call->request);
-
-	return afs_queue_call_work(call);
+	return afs_find_cm_server_by_uuid(call, call->request);
 }
 
 /*
@@ -422,8 +490,7 @@ static int afs_deliver_cb_probe(struct afs_call *call)
 
 	if (!afs_check_call_state(call, AFS_CALL_SV_REPLYING))
 		return afs_io_error(call, afs_io_error_cm_reply);
-
-	return afs_queue_call_work(call);
+	return afs_find_cm_server_by_peer(call);
 }
 
 /*
@@ -503,8 +570,7 @@ static int afs_deliver_cb_probe_uuid(struct afs_call *call)
 
 	if (!afs_check_call_state(call, AFS_CALL_SV_REPLYING))
 		return afs_io_error(call, afs_io_error_cm_reply);
-
-	return afs_queue_call_work(call);
+	return afs_find_cm_server_by_uuid(call, call->request);
 }
 
 /*
@@ -586,8 +652,7 @@ static int afs_deliver_cb_tell_me_about_yourself(struct afs_call *call)
 
 	if (!afs_check_call_state(call, AFS_CALL_SV_REPLYING))
 		return afs_io_error(call, afs_io_error_cm_reply);
-
-	return afs_queue_call_work(call);
+	return afs_find_cm_server_by_peer(call);
 }
 
 /*
@@ -596,7 +661,6 @@ static int afs_deliver_cb_tell_me_about_yourself(struct afs_call *call)
 static int afs_deliver_yfs_cb_callback(struct afs_call *call)
 {
 	struct afs_callback_break *cb;
-	struct sockaddr_rxrpc srx;
 	struct yfs_xdr_YFSFid *bp;
 	size_t size;
 	int ret, loop;
@@ -664,10 +728,5 @@ static int afs_deliver_yfs_cb_callback(struct afs_call *call)
 	/* We'll need the file server record as that tells us which set of
 	 * vnodes to operate upon.
 	 */
-	rxrpc_kernel_get_peer(call->net->socket, call->rxcall, &srx);
-	call->cm_server = afs_find_server(call->net, &srx);
-	if (!call->cm_server)
-		trace_afs_cm_no_server(call, &srx);
-
-	return afs_queue_call_work(call);
+	return afs_find_cm_server_by_peer(call);
 }
diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
new file mode 100644
index 000000000000..d049cb459742
--- /dev/null
+++ b/fs/afs/fs_probe.c
@@ -0,0 +1,270 @@
+/* AFS fileserver probing
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
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include "afs_fs.h"
+#include "internal.h"
+#include "protocol_yfs.h"
+
+static bool afs_fs_probe_done(struct afs_server *server)
+{
+	if (!atomic_dec_and_test(&server->probe_outstanding))
+		return false;
+
+	wake_up_var(&server->probe_outstanding);
+	clear_bit_unlock(AFS_SERVER_FL_PROBING, &server->flags);
+	wake_up_bit(&server->flags, AFS_SERVER_FL_PROBING);
+	return true;
+}
+
+/*
+ * Process the result of probing a fileserver.  This is called after successful
+ * or failed delivery of an FS.GetCapabilities operation.
+ */
+void afs_fileserver_probe_result(struct afs_call *call)
+{
+	struct afs_addr_list *alist = call->alist;
+	struct afs_server *server = call->reply[0];
+	unsigned int server_index = (long)call->reply[1];
+	unsigned int index = call->addr_ix;
+	unsigned int rtt = UINT_MAX;
+	bool have_result = false;
+	u64 _rtt;
+	int ret = call->error;
+
+	_enter("%pU,%u", &server->uuid, index);
+
+	spin_lock(&server->probe_lock);
+
+	switch (ret) {
+	case 0:
+		server->probe.error = 0;
+		goto responded;
+	case -ECONNABORTED:
+		if (!server->probe.responded) {
+			server->probe.abort_code = call->abort_code;
+			server->probe.error = ret;
+		}
+		goto responded;
+	case -ENOMEM:
+	case -ENONET:
+		server->probe.local_failure = true;
+		afs_io_error(call, afs_io_error_fs_probe_fail);
+		goto out;
+	case -ECONNRESET: /* Responded, but call expired. */
+	case -ENETUNREACH:
+	case -EHOSTUNREACH:
+	case -ECONNREFUSED:
+	case -ETIMEDOUT:
+	case -ETIME:
+	default:
+		clear_bit(index, &alist->responded);
+		set_bit(index, &alist->failed);
+		if (!server->probe.responded &&
+		    (server->probe.error == 0 ||
+		     server->probe.error == -ETIMEDOUT ||
+		     server->probe.error == -ETIME))
+			server->probe.error = ret;
+		afs_io_error(call, afs_io_error_fs_probe_fail);
+		goto out;
+	}
+
+responded:
+	set_bit(index, &alist->responded);
+	clear_bit(index, &alist->failed);
+
+	if (call->service_id == YFS_FS_SERVICE) {
+		server->probe.is_yfs = true;
+		set_bit(AFS_SERVER_FL_IS_YFS, &server->flags);
+		alist->addrs[index].srx_service = call->service_id;
+	} else {
+		server->probe.not_yfs = true;
+		if (!server->probe.is_yfs) {
+			clear_bit(AFS_SERVER_FL_IS_YFS, &server->flags);
+			alist->addrs[index].srx_service = call->service_id;
+		}
+	}
+
+	/* Get the RTT and scale it to fit into a 32-bit value that represents
+	 * over a minute of time so that we can access it with one instruction
+	 * on a 32-bit system.
+	 */
+	_rtt = rxrpc_kernel_get_rtt(call->net->socket, call->rxcall);
+	_rtt /= 64;
+	rtt = (_rtt > UINT_MAX) ? UINT_MAX : _rtt;
+	if (rtt < server->probe.rtt) {
+		server->probe.rtt = rtt;
+		alist->preferred = index;
+		have_result = true;
+	}
+
+	smp_wmb(); /* Set rtt before responded. */
+	server->probe.responded = true;
+	set_bit(AFS_SERVER_FL_PROBED, &server->flags);
+out:
+	spin_unlock(&server->probe_lock);
+
+	_debug("probe [%u][%u] %pISpc rtt=%u ret=%d",
+	       server_index, index, &alist->addrs[index].transport,
+	       (unsigned int)rtt, ret);
+
+	have_result |= afs_fs_probe_done(server);
+	if (have_result) {
+		server->probe.have_result = true;
+		wake_up_var(&server->probe.have_result);
+		wake_up_all(&server->probe_wq);
+	}
+}
+
+/*
+ * Probe all of a fileserver's addresses to find out the best route and to
+ * query its capabilities.
+ */
+static int afs_do_probe_fileserver(struct afs_net *net,
+				   struct afs_server *server,
+				   struct key *key,
+				   unsigned int server_index)
+{
+	struct afs_addr_cursor ac = {
+		.index = 0,
+	};
+	int ret;
+
+	_enter("%pU", &server->uuid);
+
+	read_lock(&server->fs_lock);
+	ac.alist = rcu_dereference_protected(server->addresses,
+					     lockdep_is_held(&server->fs_lock));
+	read_unlock(&server->fs_lock);
+
+	atomic_set(&server->probe_outstanding, ac.alist->nr_addrs);
+	memset(&server->probe, 0, sizeof(server->probe));
+	server->probe.rtt = UINT_MAX;
+
+	for (ac.index = 0; ac.index < ac.alist->nr_addrs; ac.index++) {
+		ret = afs_fs_get_capabilities(net, server, &ac, key, server_index,
+					      true);
+		if (ret != -EINPROGRESS) {
+			afs_fs_probe_done(server);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Send off probes to all unprobed servers.
+ */
+int afs_probe_fileservers(struct afs_net *net, struct key *key,
+			  struct afs_server_list *list)
+{
+	struct afs_server *server;
+	int i, ret;
+
+	for (i = 0; i < list->nr_servers; i++) {
+		server = list->servers[i].server;
+		if (test_bit(AFS_SERVER_FL_PROBED, &server->flags))
+			continue;
+
+		if (!test_and_set_bit_lock(AFS_SERVER_FL_PROBING, &server->flags)) {
+			ret = afs_do_probe_fileserver(net, server, key, i);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Wait for the first as-yet untried fileserver to respond.
+ */
+int afs_wait_for_fs_probes(struct afs_server_list *slist, unsigned long untried)
+{
+	struct wait_queue_entry *waits;
+	struct afs_server *server;
+	unsigned int rtt = UINT_MAX;
+	bool have_responders = false;
+	int pref = -1, i;
+
+	_enter("%u,%lx", slist->nr_servers, untried);
+
+	/* Only wait for servers that have a probe outstanding. */
+	for (i = 0; i < slist->nr_servers; i++) {
+		if (test_bit(i, &untried)) {
+			server = slist->servers[i].server;
+			if (!test_bit(AFS_SERVER_FL_PROBING, &server->flags))
+				__clear_bit(i, &untried);
+			if (server->probe.responded)
+				have_responders = true;
+		}
+	}
+	if (have_responders || !untried)
+		return 0;
+
+	waits = kmalloc(array_size(slist->nr_servers, sizeof(*waits)), GFP_KERNEL);
+	if (!waits)
+		return -ENOMEM;
+
+	for (i = 0; i < slist->nr_servers; i++) {
+		if (test_bit(i, &untried)) {
+			server = slist->servers[i].server;
+			init_waitqueue_entry(&waits[i], current);
+			add_wait_queue(&server->probe_wq, &waits[i]);
+		}
+	}
+
+	for (;;) {
+		bool still_probing = false;
+
+		set_current_state(TASK_INTERRUPTIBLE);
+		for (i = 0; i < slist->nr_servers; i++) {
+			if (test_bit(i, &untried)) {
+				server = slist->servers[i].server;
+				if (server->probe.responded)
+					goto stop;
+				if (test_bit(AFS_SERVER_FL_PROBING, &server->flags))
+					still_probing = true;
+			}
+		}
+
+		if (!still_probing || unlikely(signal_pending(current)))
+			goto stop;
+		schedule();
+	}
+
+stop:
+	set_current_state(TASK_RUNNING);
+
+	for (i = 0; i < slist->nr_servers; i++) {
+		if (test_bit(i, &untried)) {
+			server = slist->servers[i].server;
+			if (server->probe.responded &&
+			    server->probe.rtt < rtt) {
+				pref = i;
+				rtt = server->probe.rtt;
+			}
+
+			remove_wait_queue(&server->probe_wq, &waits[i]);
+		}
+	}
+
+	kfree(waits);
+
+	if (pref == -1 && signal_pending(current))
+		return -ERESTARTSYS;
+
+	if (pref >= 0)
+		slist->preferred = pref;
+	return 0;
+}
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 7c75a1813321..ca08c83168f5 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -2006,7 +2006,6 @@ int afs_fs_give_up_all_callbacks(struct afs_net *net,
  */
 static int afs_deliver_fs_get_capabilities(struct afs_call *call)
 {
-	struct afs_server *server = call->reply[0];
 	u32 count;
 	int ret;
 
@@ -2042,15 +2041,18 @@ static int afs_deliver_fs_get_capabilities(struct afs_call *call)
 		break;
 	}
 
-	if (call->service_id == YFS_FS_SERVICE)
-		set_bit(AFS_SERVER_FL_IS_YFS, &server->flags);
-	else
-		clear_bit(AFS_SERVER_FL_IS_YFS, &server->flags);
-
 	_leave(" = 0 [done]");
 	return 0;
 }
 
+static void afs_destroy_fs_get_capabilities(struct afs_call *call)
+{
+	struct afs_server *server = call->reply[0];
+
+	afs_put_server(call->net, server);
+	afs_flat_call_destructor(call);
+}
+
 /*
  * FS.GetCapabilities operation type
  */
@@ -2058,7 +2060,8 @@ static const struct afs_call_type afs_RXFSGetCapabilities = {
 	.name		= "FS.GetCapabilities",
 	.op		= afs_FS_GetCapabilities,
 	.deliver	= afs_deliver_fs_get_capabilities,
-	.destructor	= afs_flat_call_destructor,
+	.done		= afs_fileserver_probe_result,
+	.destructor	= afs_destroy_fs_get_capabilities,
 };
 
 /*
@@ -2068,7 +2071,9 @@ static const struct afs_call_type afs_RXFSGetCapabilities = {
 int afs_fs_get_capabilities(struct afs_net *net,
 			    struct afs_server *server,
 			    struct afs_addr_cursor *ac,
-			    struct key *key)
+			    struct key *key,
+			    unsigned int server_index,
+			    bool async)
 {
 	struct afs_call *call;
 	__be32 *bp;
@@ -2080,8 +2085,10 @@ int afs_fs_get_capabilities(struct afs_net *net,
 		return -ENOMEM;
 
 	call->key = key;
-	call->reply[0] = server;
+	call->reply[0] = afs_get_server(server);
+	call->reply[1] = (void *)(long)server_index;
 	call->upgrade = true;
+	call->want_reply_time = true;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -2089,7 +2096,7 @@ int afs_fs_get_capabilities(struct afs_net *net,
 
 	/* Can't take a ref on server */
 	trace_afs_make_fs_call(call, NULL);
-	return afs_make_call(ac, call, GFP_NOFS, false);
+	return afs_make_call(ac, call, GFP_NOFS, async);
 }
 
 /*
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index b60d15212975..5da3b09b7518 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -76,12 +76,13 @@ struct afs_addr_list {
 	u32			version;	/* Version */
 	unsigned char		max_addrs;
 	unsigned char		nr_addrs;
-	unsigned char		index;		/* Address currently in use */
+	unsigned char		preferred;	/* Preferred address */
 	unsigned char		nr_ipv4;	/* Number of IPv4 addresses */
 	enum dns_record_source	source:8;
 	enum dns_lookup_status	status:8;
 	unsigned long		probed;		/* Mask of servers that have been probed */
-	unsigned long		yfs;		/* Mask of servers that are YFS */
+	unsigned long		failed;		/* Mask of addrs that failed locally/ICMP */
+	unsigned long		responded;	/* Mask of addrs that responded */
 	struct sockaddr_rxrpc	addrs[];
 #define AFS_MAX_ADDRESSES ((unsigned int)(sizeof(unsigned long) * 8))
 };
@@ -91,6 +92,7 @@ struct afs_addr_list {
  */
 struct afs_call {
 	const struct afs_call_type *type;	/* type of call */
+	struct afs_addr_list	*alist;		/* Address is alist[addr_ix] */
 	wait_queue_head_t	waitq;		/* processes awaiting completion */
 	struct work_struct	async_work;	/* async I/O processor */
 	struct work_struct	work;		/* actual work processor */
@@ -116,6 +118,7 @@ struct afs_call {
 	spinlock_t		state_lock;
 	int			error;		/* error code */
 	u32			abort_code;	/* Remote abort ID or 0 */
+	u32			epoch;
 	unsigned		request_size;	/* size of request data */
 	unsigned		reply_max;	/* maximum size of reply */
 	unsigned		first_offset;	/* offset into mapping[first] */
@@ -125,13 +128,14 @@ struct afs_call {
 		unsigned	count2;		/* count used in unmarshalling */
 	};
 	unsigned char		unmarshall;	/* unmarshalling phase */
+	unsigned char		addr_ix;	/* Address in ->alist */
 	bool			incoming;	/* T if incoming call */
 	bool			send_pages;	/* T if data from mapping should be sent */
 	bool			need_attention;	/* T if RxRPC poked us */
 	bool			async;		/* T if asynchronous */
 	bool			ret_reply0;	/* T if should return reply[0] on success */
 	bool			upgrade;	/* T to request service upgrade */
-	bool			want_reply_time;	/* T if want reply_time */
+	bool			want_reply_time; /* T if want reply_time */
 	u16			service_id;	/* Actual service ID (after upgrade) */
 	unsigned int		debug_id;	/* Trace ID */
 	u32			operation_ID;	/* operation ID for an incoming call */
@@ -162,6 +166,9 @@ struct afs_call_type {
 
 	/* Work function */
 	void (*work)(struct work_struct *work);
+
+	/* Call done function (gets called immediately on success or failure) */
+	void (*done)(struct afs_call *call);
 };
 
 /*
@@ -376,10 +383,27 @@ struct afs_vlserver {
 	unsigned long		flags;
 #define AFS_VLSERVER_FL_PROBED	0		/* The VL server has been probed */
 #define AFS_VLSERVER_FL_PROBING	1		/* VL server is being probed */
+#define AFS_VLSERVER_FL_IS_YFS	2		/* Server is YFS not AFS */
 	rwlock_t		lock;		/* Lock on addresses */
 	atomic_t		usage;
-	u16			name_len;	/* Length of name */
+
+	/* Probe state */
+	wait_queue_head_t	probe_wq;
+	atomic_t		probe_outstanding;
+	spinlock_t		probe_lock;
+	struct {
+		unsigned int	rtt;		/* RTT as ktime/64 */
+		u32		abort_code;
+		short		error;
+		bool		have_result;
+		bool		responded:1;
+		bool		is_yfs:1;
+		bool		not_yfs:1;
+		bool		local_failure:1;
+	} probe;
+
 	u16			port;
+	u16			name_len;	/* Length of name */
 	char			name[];		/* Server name, case-flattened */
 };
 
@@ -399,6 +423,7 @@ struct afs_vlserver_list {
 	atomic_t		usage;
 	u8			nr_servers;
 	u8			index;		/* Server currently in use */
+	u8			preferred;	/* Preferred server */
 	enum dns_record_source	source:8;
 	enum dns_lookup_status	status:8;
 	rwlock_t		lock;
@@ -461,8 +486,10 @@ struct afs_server {
 #define AFS_SERVER_FL_MAY_HAVE_CB 8		/* May have callbacks on this fileserver */
 #define AFS_SERVER_FL_IS_YFS	9		/* Server is YFS not AFS */
 #define AFS_SERVER_FL_NO_RM2	10		/* Fileserver doesn't support YFS.RemoveFile2 */
+#define AFS_SERVER_FL_HAVE_EPOCH 11		/* ->epoch is valid */
 	atomic_t		usage;
 	u32			addr_version;	/* Address list version */
+	u32			cm_epoch;	/* Server RxRPC epoch */
 
 	/* file service access */
 	rwlock_t		fs_lock;	/* access lock */
@@ -471,6 +498,26 @@ struct afs_server {
 	struct hlist_head	cb_volumes;	/* List of volume interests on this server */
 	unsigned		cb_s_break;	/* Break-everything counter. */
 	rwlock_t		cb_break_lock;	/* Volume finding lock */
+
+	/* Probe state */
+	wait_queue_head_t	probe_wq;
+	atomic_t		probe_outstanding;
+	spinlock_t		probe_lock;
+	struct {
+		unsigned int	rtt;		/* RTT as ktime/64 */
+		u32		abort_code;
+		u32		cm_epoch;
+		short		error;
+		bool		have_result;
+		bool		responded:1;
+		bool		is_yfs:1;
+		bool		not_yfs:1;
+		bool		local_failure:1;
+		bool		no_epoch:1;
+		bool		cm_probed:1;
+		bool		said_rebooted:1;
+		bool		said_inconsistent:1;
+	} probe;
 };
 
 /*
@@ -505,8 +552,8 @@ struct afs_server_entry {
 
 struct afs_server_list {
 	refcount_t		usage;
-	unsigned short		nr_servers;
-	unsigned short		index;		/* Server currently in use */
+	unsigned char		nr_servers;
+	unsigned char		preferred;	/* Preferred server */
 	unsigned short		vnovol_mask;	/* Servers to be skipped due to VNOVOL */
 	unsigned int		seq;		/* Set to ->servers_seq when installed */
 	rwlock_t		lock;
@@ -653,13 +700,12 @@ struct afs_interface {
  */
 struct afs_addr_cursor {
 	struct afs_addr_list	*alist;		/* Current address list (pins ref) */
-	u32			abort_code;
-	unsigned short		start;		/* Starting point in alist->addrs[] */
-	unsigned short		index;		/* Wrapping offset from start to current addr */
-	short			error;
-	bool			begun;		/* T if we've begun iteration */
+	unsigned long		tried;		/* Tried addresses */
+	signed char		index;		/* Current address */
 	bool			responded;	/* T if the current address responded */
 	unsigned short		nr_iterations;	/* Number of address iterations */
+	short			error;
+	u32			abort_code;
 };
 
 /*
@@ -669,9 +715,10 @@ struct afs_vl_cursor {
 	struct afs_addr_cursor	ac;
 	struct afs_cell		*cell;		/* The cell we're querying */
 	struct afs_vlserver_list *server_list;	/* Current server list (pins ref) */
+	struct afs_vlserver	*server;	/* Server on which this resides */
 	struct key		*key;		/* Key for the server */
-	unsigned char		start;		/* Initial index in server list */
-	unsigned char		index;		/* Number of servers tried beyond start */
+	unsigned long		untried;	/* Bitmask of untried servers */
+	short			index;		/* Current server */
 	short			error;
 	unsigned short		flags;
 #define AFS_VL_CURSOR_STOP	0x0001		/* Set to cease iteration */
@@ -689,10 +736,10 @@ struct afs_fs_cursor {
 	struct afs_server_list	*server_list;	/* Current server list (pins ref) */
 	struct afs_cb_interest	*cbi;		/* Server on which this resides (pins ref) */
 	struct key		*key;		/* Key for the server */
+	unsigned long		untried;	/* Bitmask of untried servers */
 	unsigned int		cb_break;	/* cb_break + cb_s_break before the call */
 	unsigned int		cb_break_2;	/* cb_break + cb_s_break (2nd vnode) */
-	unsigned char		start;		/* Initial index in server list */
-	unsigned char		index;		/* Number of servers tried beyond start */
+	short			index;		/* Current server */
 	short			error;
 	unsigned short		flags;
 #define AFS_FS_CURSOR_STOP	0x0001		/* Set to cease iteration */
@@ -888,7 +935,7 @@ extern int afs_fs_release_lock(struct afs_fs_cursor *);
 extern int afs_fs_give_up_all_callbacks(struct afs_net *, struct afs_server *,
 					struct afs_addr_cursor *, struct key *);
 extern int afs_fs_get_capabilities(struct afs_net *, struct afs_server *,
-				   struct afs_addr_cursor *, struct key *);
+				   struct afs_addr_cursor *, struct key *, unsigned int, bool);
 extern int afs_fs_inline_bulk_status(struct afs_fs_cursor *, struct afs_net *,
 				     struct afs_fid *, struct afs_file_status *,
 				     struct afs_callback *, unsigned int,
@@ -897,6 +944,13 @@ extern int afs_fs_fetch_status(struct afs_fs_cursor *, struct afs_net *,
 			       struct afs_fid *, struct afs_file_status *,
 			       struct afs_callback *, struct afs_volsync *);
 
+/*
+ * fs_probe.c
+ */
+extern void afs_fileserver_probe_result(struct afs_call *);
+extern int afs_probe_fileservers(struct afs_net *, struct key *, struct afs_server_list *);
+extern int afs_wait_for_fs_probes(struct afs_server_list *, unsigned long);
+
 /*
  * inode.c
  */
@@ -1013,7 +1067,6 @@ extern int __net_init afs_open_socket(struct afs_net *);
 extern void __net_exit afs_close_socket(struct afs_net *);
 extern void afs_charge_preallocation(struct work_struct *);
 extern void afs_put_call(struct afs_call *);
-extern int afs_queue_call_work(struct afs_call *);
 extern long afs_make_call(struct afs_addr_cursor *, struct afs_call *, gfp_t, bool);
 extern struct afs_call *afs_alloc_flat_call(struct afs_net *,
 					    const struct afs_call_type *,
@@ -1130,7 +1183,6 @@ extern void afs_put_server(struct afs_net *, struct afs_server *);
 extern void afs_manage_servers(struct work_struct *);
 extern void afs_servers_timer(struct timer_list *);
 extern void __net_exit afs_purge_servers(struct afs_net *);
-extern bool afs_probe_fileserver(struct afs_fs_cursor *);
 extern bool afs_check_server_record(struct afs_fs_cursor *, struct afs_server *);
 
 /*
@@ -1160,9 +1212,17 @@ extern void afs_fs_exit(void);
 extern struct afs_vldb_entry *afs_vl_get_entry_by_name_u(struct afs_vl_cursor *,
 							 const char *, int);
 extern struct afs_addr_list *afs_vl_get_addrs_u(struct afs_vl_cursor *, const uuid_t *);
-extern int afs_vl_get_capabilities(struct afs_net *, struct afs_addr_cursor *, struct key *);
+extern int afs_vl_get_capabilities(struct afs_net *, struct afs_addr_cursor *, struct key *,
+				   struct afs_vlserver *, unsigned int, bool);
 extern struct afs_addr_list *afs_yfsvl_get_endpoints(struct afs_vl_cursor *, const uuid_t *);
 
+/*
+ * vl_probe.c
+ */
+extern void afs_vlserver_probe_result(struct afs_call *);
+extern int afs_send_vl_probes(struct afs_net *, struct key *, struct afs_vlserver_list *);
+extern int afs_wait_for_vl_probes(struct afs_vlserver_list *, unsigned long);
+
 /*
  * vl_rotate.c
  */
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index d887f822f4eb..be2ee3bbd0a9 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -312,7 +312,7 @@ static int afs_proc_cell_vlservers_show(struct seq_file *m, void *v)
 	if (alist) {
 		for (i = 0; i < alist->nr_addrs; i++)
 			seq_printf(m, " %c %pISpc\n",
-				   alist->index == i ? '>' : '-',
+				   alist->preferred == i ? '>' : '-',
 				   &alist->addrs[i].transport);
 	}
 	return 0;
@@ -391,11 +391,11 @@ static int afs_proc_servers_show(struct seq_file *m, void *v)
 		   &server->uuid,
 		   atomic_read(&server->usage),
 		   &alist->addrs[0].transport,
-		   alist->index == 0 ? "*" : "");
+		   alist->preferred == 0 ? "*" : "");
 	for (i = 1; i < alist->nr_addrs; i++)
 		seq_printf(m, "                                         %pISpc%s\n",
 			   &alist->addrs[i].transport,
-			   alist->index == i ? "*" : "");
+			   alist->preferred == i ? "*" : "");
 	return 0;
 }
 
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 7c4487781637..00504254c1c2 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -18,14 +18,6 @@
 #include "internal.h"
 #include "afs_fs.h"
 
-/*
- * Initialise a filesystem server cursor for iterating over FS servers.
- */
-static void afs_init_fs_cursor(struct afs_fs_cursor *fc, struct afs_vnode *vnode)
-{
-	memset(fc, 0, sizeof(*fc));
-}
-
 /*
  * Begin an operation on the fileserver.
  *
@@ -35,7 +27,7 @@ static void afs_init_fs_cursor(struct afs_fs_cursor *fc, struct afs_vnode *vnode
 bool afs_begin_vnode_operation(struct afs_fs_cursor *fc, struct afs_vnode *vnode,
 			       struct key *key)
 {
-	afs_init_fs_cursor(fc, vnode);
+	memset(fc, 0, sizeof(*fc));
 	fc->vnode = vnode;
 	fc->key = key;
 	fc->ac.error = SHRT_MAX;
@@ -66,12 +58,15 @@ static bool afs_start_fs_iteration(struct afs_fs_cursor *fc,
 	fc->server_list = afs_get_serverlist(vnode->volume->servers);
 	read_unlock(&vnode->volume->servers_lock);
 
+	fc->untried = (1UL << fc->server_list->nr_servers) - 1;
+	fc->index = READ_ONCE(fc->server_list->preferred);
+
 	cbi = vnode->cb_interest;
 	if (cbi) {
 		/* See if the vnode's preferred record is still available */
 		for (i = 0; i < fc->server_list->nr_servers; i++) {
 			if (fc->server_list->servers[i].cb_interest == cbi) {
-				fc->start = i;
+				fc->index = i;
 				goto found_interest;
 			}
 		}
@@ -95,12 +90,9 @@ static bool afs_start_fs_iteration(struct afs_fs_cursor *fc,
 
 		afs_put_cb_interest(afs_v2net(vnode), cbi);
 		cbi = NULL;
-	} else {
-		fc->start = READ_ONCE(fc->server_list->index);
 	}
 
 found_interest:
-	fc->index = fc->start;
 	return true;
 }
 
@@ -144,11 +136,12 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 	struct afs_addr_list *alist;
 	struct afs_server *server;
 	struct afs_vnode *vnode = fc->vnode;
-	int error = fc->ac.error;
+	u32 rtt, abort_code;
+	int error = fc->ac.error, i;
 
-	_enter("%u/%u,%u/%u,%d,%d",
-	       fc->index, fc->start,
-	       fc->ac.index, fc->ac.start,
+	_enter("%lx[%d],%lx[%d],%d,%d",
+	       fc->untried, fc->index,
+	       fc->ac.tried, fc->ac.index,
 	       error, fc->ac.abort_code);
 
 	if (fc->flags & AFS_FS_CURSOR_STOP) {
@@ -345,8 +338,50 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 	if (!afs_start_fs_iteration(fc, vnode))
 		goto failed;
 
-use_server:
-	_debug("use");
+	_debug("__ VOL %llx __", vnode->volume->vid);
+	error = afs_probe_fileservers(afs_v2net(vnode), fc->key, fc->server_list);
+	if (error < 0)
+		goto failed_set_error;
+
+pick_server:
+	_debug("pick [%lx]", fc->untried);
+
+	error = afs_wait_for_fs_probes(fc->server_list, fc->untried);
+	if (error < 0)
+		goto failed_set_error;
+
+	/* Pick the untried server with the lowest RTT.  If we have outstanding
+	 * callbacks, we stick with the server we're already using if we can.
+	 */
+	if (fc->cbi) {
+		_debug("cbi %u", fc->index);
+		if (test_bit(fc->index, &fc->untried))
+			goto selected_server;
+		afs_put_cb_interest(afs_v2net(vnode), fc->cbi);
+		fc->cbi = NULL;
+		_debug("nocbi");
+	}
+
+	fc->index = -1;
+	rtt = U32_MAX;
+	for (i = 0; i < fc->server_list->nr_servers; i++) {
+		struct afs_server *s = fc->server_list->servers[i].server;
+
+		if (!test_bit(i, &fc->untried) || !s->probe.responded)
+			continue;
+		if (s->probe.rtt < rtt) {
+			fc->index = i;
+			rtt = s->probe.rtt;
+		}
+	}
+
+	if (fc->index == -1)
+		goto no_more_servers;
+
+selected_server:
+	_debug("use %d", fc->index);
+	__clear_bit(fc->index, &fc->untried);
+
 	/* We're starting on a different fileserver from the list.  We need to
 	 * check it, create a callback intercept, find its address list and
 	 * probe its capabilities before we use it.
@@ -379,60 +414,81 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 
 	memset(&fc->ac, 0, sizeof(fc->ac));
 
-	/* Probe the current fileserver if we haven't done so yet. */
-	if (!test_bit(AFS_SERVER_FL_PROBED, &server->flags)) {
-		fc->ac.alist = afs_get_addrlist(alist);
-
-		if (!afs_probe_fileserver(fc)) {
-			switch (fc->ac.error) {
-			case -ENOMEM:
-			case -ERESTARTSYS:
-			case -EINTR:
-				goto failed;
-			default:
-				goto next_server;
-			}
-		}
-	}
-
 	if (!fc->ac.alist)
 		fc->ac.alist = alist;
 	else
 		afs_put_addrlist(alist);
 
-	fc->ac.start = READ_ONCE(alist->index);
-	fc->ac.index = fc->ac.start;
+	fc->ac.index = -1;
 
 iterate_address:
 	ASSERT(fc->ac.alist);
-	_debug("iterate %d/%d", fc->ac.index, fc->ac.alist->nr_addrs);
 	/* Iterate over the current server's address list to try and find an
 	 * address on which it will respond to us.
 	 */
 	if (!afs_iterate_addresses(&fc->ac))
 		goto next_server;
 
+	_debug("address [%u] %u/%u", fc->index, fc->ac.index, fc->ac.alist->nr_addrs);
+
 	_leave(" = t");
 	return true;
 
 next_server:
 	_debug("next");
 	afs_end_cursor(&fc->ac);
-	afs_put_cb_interest(afs_v2net(vnode), fc->cbi);
-	fc->cbi = NULL;
-	fc->index++;
-	if (fc->index >= fc->server_list->nr_servers)
-		fc->index = 0;
-	if (fc->index != fc->start)
-		goto use_server;
+	goto pick_server;
 
+no_more_servers:
 	/* That's all the servers poked to no good effect.  Try again if some
 	 * of them were busy.
 	 */
 	if (fc->flags & AFS_FS_CURSOR_VBUSY)
 		goto restart_from_beginning;
 
-	goto failed;
+	abort_code = 0;
+	error = -EDESTADDRREQ;
+	for (i = 0; i < fc->server_list->nr_servers; i++) {
+		struct afs_server *s = fc->server_list->servers[i].server;
+		int probe_error = READ_ONCE(s->probe.error);
+
+		switch (probe_error) {
+		case 0:
+			continue;
+		default:
+			if (error == -ETIMEDOUT ||
+			    error == -ETIME)
+				continue;
+		case -ETIMEDOUT:
+		case -ETIME:
+			if (error == -ENOMEM ||
+			    error == -ENONET)
+				continue;
+		case -ENOMEM:
+		case -ENONET:
+			if (error == -ENETUNREACH)
+				continue;
+		case -ENETUNREACH:
+			if (error == -EHOSTUNREACH)
+				continue;
+		case -EHOSTUNREACH:
+			if (error == -ECONNREFUSED)
+				continue;
+		case -ECONNREFUSED:
+			if (error == -ECONNRESET)
+				continue;
+		case -ECONNRESET: /* Responded, but call expired. */
+			if (error == -ECONNABORTED)
+				continue;
+		case -ECONNABORTED:
+			abort_code = s->probe.abort_code;
+			error = probe_error;
+			continue;
+		}
+	}
+
+	if (error == -ECONNABORTED)
+		error = afs_abort_to_error(abort_code);
 
 failed_set_error:
 	fc->error = error;
@@ -480,8 +536,7 @@ bool afs_select_current_fileserver(struct afs_fs_cursor *fc)
 
 		memset(&fc->ac, 0, sizeof(fc->ac));
 		fc->ac.alist = alist;
-		fc->ac.start = READ_ONCE(alist->index);
-		fc->ac.index = fc->ac.start;
+		fc->ac.index = -1;
 		goto iterate_address;
 
 	case 0:
@@ -538,13 +593,13 @@ static void afs_dump_edestaddrreq(const struct afs_fs_cursor *fc)
 	pr_notice("EDESTADDR occurred\n");
 	pr_notice("FC: cbb=%x cbb2=%x fl=%hx err=%hd\n",
 		  fc->cb_break, fc->cb_break_2, fc->flags, fc->error);
-	pr_notice("FC: st=%u ix=%u ni=%u\n",
-		  fc->start, fc->index, fc->nr_iterations);
+	pr_notice("FC: ut=%lx ix=%d ni=%u\n",
+		  fc->untried, fc->index, fc->nr_iterations);
 
 	if (fc->server_list) {
 		const struct afs_server_list *sl = fc->server_list;
-		pr_notice("FC: SL nr=%u ix=%u vnov=%hx\n",
-			  sl->nr_servers, sl->index, sl->vnovol_mask);
+		pr_notice("FC: SL nr=%u pr=%u vnov=%hx\n",
+			  sl->nr_servers, sl->preferred, sl->vnovol_mask);
 		for (i = 0; i < sl->nr_servers; i++) {
 			const struct afs_server *s = sl->servers[i].server;
 			pr_notice("FC: server fl=%lx av=%u %pU\n",
@@ -552,22 +607,21 @@ static void afs_dump_edestaddrreq(const struct afs_fs_cursor *fc)
 			if (s->addresses) {
 				const struct afs_addr_list *a =
 					rcu_dereference(s->addresses);
-				pr_notice("FC:  - av=%u nr=%u/%u/%u ax=%u\n",
+				pr_notice("FC:  - av=%u nr=%u/%u/%u pr=%u\n",
 					  a->version,
 					  a->nr_ipv4, a->nr_addrs, a->max_addrs,
-					  a->index);
-				pr_notice("FC:  - pr=%lx yf=%lx\n",
-					  a->probed, a->yfs);
+					  a->preferred);
+				pr_notice("FC:  - pr=%lx R=%lx F=%lx\n",
+					  a->probed, a->responded, a->failed);
 				if (a == fc->ac.alist)
 					pr_notice("FC:  - current\n");
 			}
 		}
 	}
 
-	pr_notice("AC: as=%u ax=%u ac=%d er=%d b=%u r=%u ni=%u\n",
-		  fc->ac.start, fc->ac.index, fc->ac.abort_code, fc->ac.error,
-		  fc->ac.begun, fc->ac.responded, fc->ac.nr_iterations);
-
+	pr_notice("AC: t=%lx ax=%u ac=%d er=%d r=%u ni=%u\n",
+		  fc->ac.tried, fc->ac.index, fc->ac.abort_code, fc->ac.error,
+		  fc->ac.responded, fc->ac.nr_iterations);
 	rcu_read_unlock();
 }
 
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 42e1ea7372e9..59970886690f 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -43,7 +43,6 @@ int afs_open_socket(struct afs_net *net)
 	struct sockaddr_rxrpc srx;
 	struct socket *socket;
 	unsigned int min_level;
-	u16 service_upgrade[2];
 	int ret;
 
 	_enter("");
@@ -82,13 +81,12 @@ int afs_open_socket(struct afs_net *net)
 	if (ret < 0)
 		goto error_2;
 
-	service_upgrade[0] = CM_SERVICE;
-	service_upgrade[1] = YFS_CM_SERVICE;
-	ret = kernel_setsockopt(socket, SOL_RXRPC, RXRPC_UPGRADEABLE_SERVICE,
-				(void *)service_upgrade, sizeof(service_upgrade));
-	if (ret < 0)
-		goto error_2;
-
+	/* Ideally, we'd turn on service upgrade here, but we can't because
+	 * OpenAFS is buggy and leaks the userStatus field from packet to
+	 * packet and between FS packets and CB packets - so if we try to do an
+	 * upgrade on an FS packet, OpenAFS will leak that into the CB packet
+	 * it sends back to us.
+	 */
 
 	rxrpc_kernel_new_call_notification(socket, afs_rx_new_call,
 					   afs_rx_discard_new_call);
@@ -192,6 +190,7 @@ void afs_put_call(struct afs_call *call)
 
 		afs_put_server(call->net, call->cm_server);
 		afs_put_cb_interest(call->net, call->cbi);
+		afs_put_addrlist(call->alist);
 		kfree(call->request);
 
 		trace_afs_call(call, afs_call_trace_free, 0, o,
@@ -205,21 +204,22 @@ void afs_put_call(struct afs_call *call)
 }
 
 /*
- * Queue the call for actual work.  Returns 0 unconditionally for convenience.
+ * Queue the call for actual work.
  */
-int afs_queue_call_work(struct afs_call *call)
+static void afs_queue_call_work(struct afs_call *call)
 {
-	int u = atomic_inc_return(&call->usage);
+	if (call->type->work) {
+		int u = atomic_inc_return(&call->usage);
 
-	trace_afs_call(call, afs_call_trace_work, u,
-		       atomic_read(&call->net->nr_outstanding_calls),
-		       __builtin_return_address(0));
+		trace_afs_call(call, afs_call_trace_work, u,
+			       atomic_read(&call->net->nr_outstanding_calls),
+			       __builtin_return_address(0));
 
-	INIT_WORK(&call->work, call->type->work);
+		INIT_WORK(&call->work, call->type->work);
 
-	if (!queue_work(afs_wq, &call->work))
-		afs_put_call(call);
-	return 0;
+		if (!queue_work(afs_wq, &call->work))
+			afs_put_call(call);
+	}
 }
 
 /*
@@ -376,6 +376,8 @@ long afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call,
 	       atomic_read(&call->net->nr_outstanding_calls));
 
 	call->async = async;
+	call->addr_ix = ac->index;
+	call->alist = afs_get_addrlist(ac->alist);
 
 	/* Work out the length we're going to transmit.  This is awkward for
 	 * calls such as FS.StoreData where there's an extra injection of data
@@ -407,6 +409,7 @@ long afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call,
 					 call->debug_id);
 	if (IS_ERR(rxcall)) {
 		ret = PTR_ERR(rxcall);
+		call->error = ret;
 		goto error_kill_call;
 	}
 
@@ -458,6 +461,8 @@ long afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call,
 	call->error = ret;
 	trace_afs_call_done(call);
 error_kill_call:
+	if (call->type->done)
+		call->type->done(call);
 	afs_put_call(call);
 	ac->error = ret;
 	_leave(" = %d", ret);
@@ -509,6 +514,7 @@ static void afs_deliver_to_call(struct afs_call *call)
 		state = READ_ONCE(call->state);
 		switch (ret) {
 		case 0:
+			afs_queue_call_work(call);
 			if (state == AFS_CALL_CL_PROC_REPLY) {
 				if (call->cbi)
 					set_bit(AFS_SERVER_FL_MAY_HAVE_CB,
@@ -546,6 +552,8 @@ static void afs_deliver_to_call(struct afs_call *call)
 	}
 
 done:
+	if (call->type->done)
+		call->type->done(call);
 	if (state == AFS_CALL_COMPLETE && call->incoming)
 		afs_put_call(call);
 out:
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 7c1be8b4dc9a..642afa2e9783 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -231,6 +231,8 @@ static struct afs_server *afs_alloc_server(struct afs_net *net,
 	rwlock_init(&server->fs_lock);
 	INIT_HLIST_HEAD(&server->cb_volumes);
 	rwlock_init(&server->cb_break_lock);
+	init_waitqueue_head(&server->probe_wq);
+	spin_lock_init(&server->probe_lock);
 
 	afs_inc_servers_outstanding(net);
 	_leave(" = %p", server);
@@ -254,7 +256,7 @@ static struct afs_addr_list *afs_vl_lookup_addrs(struct afs_cell *cell,
 	ret = -ERESTARTSYS;
 	if (afs_begin_vlserver_operation(&vc, cell, key)) {
 		while (afs_select_vlserver(&vc)) {
-			if (test_bit(vc.ac.index, &vc.ac.alist->yfs))
+			if (test_bit(AFS_VLSERVER_FL_IS_YFS, &vc.server->flags))
 				alist = afs_yfsvl_get_endpoints(&vc, uuid);
 			else
 				alist = afs_vl_get_addrs_u(&vc, uuid);
@@ -365,8 +367,7 @@ static void afs_destroy_server(struct afs_net *net, struct afs_server *server)
 	struct afs_addr_list *alist = rcu_access_pointer(server->addresses);
 	struct afs_addr_cursor ac = {
 		.alist	= alist,
-		.start	= alist->index,
-		.index	= 0,
+		.index	= alist->preferred,
 		.error	= 0,
 	};
 	_enter("%p", server);
@@ -374,6 +375,9 @@ static void afs_destroy_server(struct afs_net *net, struct afs_server *server)
 	if (test_bit(AFS_SERVER_FL_MAY_HAVE_CB, &server->flags))
 		afs_fs_give_up_all_callbacks(net, server, &ac, NULL);
 
+	wait_var_event(&server->probe_outstanding,
+		       atomic_read(&server->probe_outstanding) == 0);
+
 	call_rcu(&server->rcu, afs_server_rcu);
 	afs_dec_servers_outstanding(net);
 }
@@ -506,105 +510,6 @@ void afs_purge_servers(struct afs_net *net)
 	_leave("");
 }
 
-/*
- * Probe a fileserver to find its capabilities.
- *
- * TODO: Try service upgrade.
- */
-static bool afs_do_probe_fileserver(struct afs_fs_cursor *fc)
-{
-	int i;
-
-	_enter("");
-
-	fc->ac.start = READ_ONCE(fc->ac.alist->index);
-	fc->ac.index = fc->ac.start;
-	fc->ac.error = 0;
-	fc->ac.begun = false;
-
-	while (afs_iterate_addresses(&fc->ac)) {
-		afs_fs_get_capabilities(afs_v2net(fc->vnode), fc->cbi->server,
-					&fc->ac, fc->key);
-		switch (fc->ac.error) {
-		case 0:
-			if (test_bit(AFS_SERVER_FL_IS_YFS, &fc->cbi->server->flags)) {
-				for (i = 0; i < fc->ac.alist->nr_addrs; i++)
-					fc->ac.alist->addrs[i].srx_service =
-						YFS_FS_SERVICE;
-			}
-			afs_end_cursor(&fc->ac);
-			set_bit(AFS_SERVER_FL_PROBED, &fc->cbi->server->flags);
-			return true;
-		case -ECONNABORTED:
-			fc->ac.error = afs_abort_to_error(fc->ac.abort_code);
-			goto error;
-		case -ENOMEM:
-		case -ENONET:
-			goto error;
-		case -ENETUNREACH:
-		case -EHOSTUNREACH:
-		case -ECONNREFUSED:
-		case -ETIMEDOUT:
-		case -ETIME:
-			break;
-		default:
-			fc->ac.error = afs_io_error(NULL, afs_io_error_fs_probe_fail);
-			goto error;
-		}
-	}
-
-error:
-	afs_end_cursor(&fc->ac);
-	return false;
-}
-
-/*
- * If we haven't already, try probing the fileserver to get its capabilities.
- * We try not to instigate parallel probes, but it's possible that the parallel
- * probes will fail due to authentication failure when ours would succeed.
- *
- * TODO: Try sending an anonymous probe if an authenticated probe fails.
- */
-bool afs_probe_fileserver(struct afs_fs_cursor *fc)
-{
-	bool success;
-	int ret, retries = 0;
-
-	_enter("");
-
-retry:
-	if (test_bit(AFS_SERVER_FL_PROBED, &fc->cbi->server->flags)) {
-		_leave(" = t");
-		return true;
-	}
-
-	if (!test_and_set_bit_lock(AFS_SERVER_FL_PROBING, &fc->cbi->server->flags)) {
-		success = afs_do_probe_fileserver(fc);
-		clear_bit_unlock(AFS_SERVER_FL_PROBING, &fc->cbi->server->flags);
-		wake_up_bit(&fc->cbi->server->flags, AFS_SERVER_FL_PROBING);
-		_leave(" = t");
-		return success;
-	}
-
-	_debug("wait");
-	ret = wait_on_bit(&fc->cbi->server->flags, AFS_SERVER_FL_PROBING,
-			  TASK_INTERRUPTIBLE);
-	if (ret == -ERESTARTSYS) {
-		fc->ac.error = ret;
-		_leave(" = f [%d]", ret);
-		return false;
-	}
-
-	retries++;
-	if (retries == 4) {
-		fc->ac.error = -ESTALE;
-		_leave(" = f [stale]");
-		return false;
-	}
-	_debug("retry");
-	goto retry;
-}
-
 /*
  * Get an update for a server's address list.
  */
diff --git a/fs/afs/server_list.c b/fs/afs/server_list.c
index 8a5760aa5832..95d0761cdb34 100644
--- a/fs/afs/server_list.c
+++ b/fs/afs/server_list.c
@@ -118,11 +118,11 @@ bool afs_annotate_server_list(struct afs_server_list *new,
 	return false;
 
 changed:
-	/* Maintain the same current server as before if possible. */
-	cur = old->servers[old->index].server;
+	/* Maintain the same preferred server as before if possible. */
+	cur = old->servers[old->preferred].server;
 	for (j = 0; j < new->nr_servers; j++) {
 		if (new->servers[j].server == cur) {
-			new->index = j;
+			new->preferred = j;
 			break;
 		}
 	}
diff --git a/fs/afs/vl_list.c b/fs/afs/vl_list.c
index c1e316ba105a..b4f1a84519b9 100644
--- a/fs/afs/vl_list.c
+++ b/fs/afs/vl_list.c
@@ -23,6 +23,8 @@ struct afs_vlserver *afs_alloc_vlserver(const char *name, size_t name_len,
 	if (vlserver) {
 		atomic_set(&vlserver->usage, 1);
 		rwlock_init(&vlserver->lock);
+		init_waitqueue_head(&vlserver->probe_wq);
+		spin_lock_init(&vlserver->probe_lock);
 		vlserver->name_len = name_len;
 		vlserver->port = port;
 		memcpy(vlserver->name, name, name_len);
@@ -141,7 +143,7 @@ static struct afs_addr_list *afs_extract_vl_addrs(const u8 **_b, const u8 *end,
 
 	/* Start with IPv6 if available. */
 	if (alist->nr_ipv4 < alist->nr_addrs)
-		alist->index = alist->nr_ipv4;
+		alist->preferred = alist->nr_ipv4;
 
 	*_b = b;
 	return alist;
@@ -307,6 +309,8 @@ struct afs_vlserver_list *afs_extract_vlserver_list(struct afs_cell *cell,
 				(vllist->nr_servers - j) * sizeof(struct afs_vlserver_entry));
 		}
 
+		clear_bit(AFS_VLSERVER_FL_PROBED, &server->flags);
+
 		vllist->servers[j].priority = bs.priority;
 		vllist->servers[j].weight = bs.weight;
 		vllist->servers[j].server = server;
diff --git a/fs/afs/vl_probe.c b/fs/afs/vl_probe.c
new file mode 100644
index 000000000000..c0f616bd70cb
--- /dev/null
+++ b/fs/afs/vl_probe.c
@@ -0,0 +1,273 @@
+/* AFS vlserver probing
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
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include "afs_fs.h"
+#include "internal.h"
+#include "protocol_yfs.h"
+
+static bool afs_vl_probe_done(struct afs_vlserver *server)
+{
+	if (!atomic_dec_and_test(&server->probe_outstanding))
+		return false;
+
+	wake_up_var(&server->probe_outstanding);
+	clear_bit_unlock(AFS_VLSERVER_FL_PROBING, &server->flags);
+	wake_up_bit(&server->flags, AFS_VLSERVER_FL_PROBING);
+	return true;
+}
+
+/*
+ * Process the result of probing a vlserver.  This is called after successful
+ * or failed delivery of an VL.GetCapabilities operation.
+ */
+void afs_vlserver_probe_result(struct afs_call *call)
+{
+	struct afs_addr_list *alist = call->alist;
+	struct afs_vlserver *server = call->reply[0];
+	unsigned int server_index = (long)call->reply[1];
+	unsigned int index = call->addr_ix;
+	unsigned int rtt = UINT_MAX;
+	bool have_result = false;
+	u64 _rtt;
+	int ret = call->error;
+
+	_enter("%s,%u,%u,%d,%d", server->name, server_index, index, ret, call->abort_code);
+
+	spin_lock(&server->probe_lock);
+
+	switch (ret) {
+	case 0:
+		server->probe.error = 0;
+		goto responded;
+	case -ECONNABORTED:
+		if (!server->probe.responded) {
+			server->probe.abort_code = call->abort_code;
+			server->probe.error = ret;
+		}
+		goto responded;
+	case -ENOMEM:
+	case -ENONET:
+		server->probe.local_failure = true;
+		afs_io_error(call, afs_io_error_vl_probe_fail);
+		goto out;
+	case -ECONNRESET: /* Responded, but call expired. */
+	case -ENETUNREACH:
+	case -EHOSTUNREACH:
+	case -ECONNREFUSED:
+	case -ETIMEDOUT:
+	case -ETIME:
+	default:
+		clear_bit(index, &alist->responded);
+		set_bit(index, &alist->failed);
+		if (!server->probe.responded &&
+		    (server->probe.error == 0 ||
+		     server->probe.error == -ETIMEDOUT ||
+		     server->probe.error == -ETIME))
+			server->probe.error = ret;
+		afs_io_error(call, afs_io_error_vl_probe_fail);
+		goto out;
+	}
+
+responded:
+	set_bit(index, &alist->responded);
+	clear_bit(index, &alist->failed);
+
+	if (call->service_id == YFS_VL_SERVICE) {
+		server->probe.is_yfs = true;
+		set_bit(AFS_VLSERVER_FL_IS_YFS, &server->flags);
+		alist->addrs[index].srx_service = call->service_id;
+	} else {
+		server->probe.not_yfs = true;
+		if (!server->probe.is_yfs) {
+			clear_bit(AFS_VLSERVER_FL_IS_YFS, &server->flags);
+			alist->addrs[index].srx_service = call->service_id;
+		}
+	}
+
+	/* Get the RTT and scale it to fit into a 32-bit value that represents
+	 * over a minute of time so that we can access it with one instruction
+	 * on a 32-bit system.
+	 */
+	_rtt = rxrpc_kernel_get_rtt(call->net->socket, call->rxcall);
+	_rtt /= 64;
+	rtt = (_rtt > UINT_MAX) ? UINT_MAX : _rtt;
+	if (rtt < server->probe.rtt) {
+		server->probe.rtt = rtt;
+		alist->preferred = index;
+		have_result = true;
+	}
+
+	smp_wmb(); /* Set rtt before responded. */
+	server->probe.responded = true;
+	set_bit(AFS_VLSERVER_FL_PROBED, &server->flags);
+out:
+	spin_unlock(&server->probe_lock);
+
+	_debug("probe [%u][%u] %pISpc rtt=%u ret=%d",
+	       server_index, index, &alist->addrs[index].transport,
+	       (unsigned int)rtt, ret);
+
+	have_result |= afs_vl_probe_done(server);
+	if (have_result) {
+		server->probe.have_result = true;
+		wake_up_var(&server->probe.have_result);
+		wake_up_all(&server->probe_wq);
+	}
+}
+
+/*
+ * Probe all of a vlserver's addresses to find out the best route and to
+ * query its capabilities.
+ */
+static int afs_do_probe_vlserver(struct afs_net *net,
+				 struct afs_vlserver *server,
+				 struct key *key,
+				 unsigned int server_index)
+{
+	struct afs_addr_cursor ac = {
+		.index = 0,
+	};
+	int ret;
+
+	_enter("%s", server->name);
+
+	read_lock(&server->lock);
+	ac.alist = rcu_dereference_protected(server->addresses,
+					     lockdep_is_held(&server->lock));
+	read_unlock(&server->lock);
+
+	atomic_set(&server->probe_outstanding, ac.alist->nr_addrs);
+	memset(&server->probe, 0, sizeof(server->probe));
+	server->probe.rtt = UINT_MAX;
+
+	for (ac.index = 0; ac.index < ac.alist->nr_addrs; ac.index++) {
+		ret = afs_vl_get_capabilities(net, &ac, key, server,
+					      server_index, true);
+		if (ret != -EINPROGRESS) {
+			afs_vl_probe_done(server);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Send off probes to all unprobed servers.
+ */
+int afs_send_vl_probes(struct afs_net *net, struct key *key,
+		       struct afs_vlserver_list *vllist)
+{
+	struct afs_vlserver *server;
+	int i, ret;
+
+	for (i = 0; i < vllist->nr_servers; i++) {
+		server = vllist->servers[i].server;
+		if (test_bit(AFS_VLSERVER_FL_PROBED, &server->flags))
+			continue;
+
+		if (!test_and_set_bit_lock(AFS_VLSERVER_FL_PROBING, &server->flags)) {
+			ret = afs_do_probe_vlserver(net, server, key, i);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Wait for the first as-yet untried server to respond.
+ */
+int afs_wait_for_vl_probes(struct afs_vlserver_list *vllist,
+			   unsigned long untried)
+{
+	struct wait_queue_entry *waits;
+	struct afs_vlserver *server;
+	unsigned int rtt = UINT_MAX;
+	bool have_responders = false;
+	int pref = -1, i;
+
+	_enter("%u,%lx", vllist->nr_servers, untried);
+
+	/* Only wait for servers that have a probe outstanding. */
+	for (i = 0; i < vllist->nr_servers; i++) {
+		if (test_bit(i, &untried)) {
+			server = vllist->servers[i].server;
+			if (!test_bit(AFS_VLSERVER_FL_PROBING, &server->flags))
+				__clear_bit(i, &untried);
+			if (server->probe.responded)
+				have_responders = true;
+		}
+	}
+	if (have_responders || !untried)
+		return 0;
+
+	waits = kmalloc(array_size(vllist->nr_servers, sizeof(*waits)), GFP_KERNEL);
+	if (!waits)
+		return -ENOMEM;
+
+	for (i = 0; i < vllist->nr_servers; i++) {
+		if (test_bit(i, &untried)) {
+			server = vllist->servers[i].server;
+			init_waitqueue_entry(&waits[i], current);
+			add_wait_queue(&server->probe_wq, &waits[i]);
+		}
+	}
+
+	for (;;) {
+		bool still_probing = false;
+
+		set_current_state(TASK_INTERRUPTIBLE);
+		for (i = 0; i < vllist->nr_servers; i++) {
+			if (test_bit(i, &untried)) {
+				server = vllist->servers[i].server;
+				if (server->probe.responded)
+					goto stop;
+				if (test_bit(AFS_VLSERVER_FL_PROBING, &server->flags))
+					still_probing = true;
+			}
+		}
+
+		if (!still_probing || unlikely(signal_pending(current)))
+			goto stop;
+		schedule();
+	}
+
+stop:
+	set_current_state(TASK_RUNNING);
+
+	for (i = 0; i < vllist->nr_servers; i++) {
+		if (test_bit(i, &untried)) {
+			server = vllist->servers[i].server;
+			if (server->probe.responded &&
+			    server->probe.rtt < rtt) {
+				pref = i;
+				rtt = server->probe.rtt;
+			}
+
+			remove_wait_queue(&server->probe_wq, &waits[i]);
+		}
+	}
+
+	kfree(waits);
+
+	if (pref == -1 && signal_pending(current))
+		return -ERESTARTSYS;
+
+	if (pref >= 0)
+		vllist->preferred = pref;
+
+	_leave(" = 0 [%u]", pref);
+	return 0;
+}
diff --git a/fs/afs/vl_rotate.c b/fs/afs/vl_rotate.c
index ead6dedbb561..b64a284b99d2 100644
--- a/fs/afs/vl_rotate.c
+++ b/fs/afs/vl_rotate.c
@@ -58,8 +58,8 @@ static bool afs_start_vl_iteration(struct afs_vl_cursor *vc)
 	if (!vc->server_list || !vc->server_list->nr_servers)
 		return false;
 
-	vc->start = READ_ONCE(vc->server_list->index);
-	vc->index = vc->start;
+	vc->untried = (1UL << vc->server_list->nr_servers) - 1;
+	vc->index = -1;
 	return true;
 }
 
@@ -71,11 +71,12 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
 {
 	struct afs_addr_list *alist;
 	struct afs_vlserver *vlserver;
-	int error = vc->ac.error;
+	u32 rtt;
+	int error = vc->ac.error, abort_code, i;
 
-	_enter("%u/%u,%u/%u,%d,%d",
-	       vc->index, vc->start,
-	       vc->ac.index, vc->ac.start,
+	_enter("%lx[%d],%lx[%d],%d,%d",
+	       vc->untried, vc->index,
+	       vc->ac.tried, vc->ac.index,
 	       error, vc->ac.abort_code);
 
 	if (vc->flags & AFS_VL_CURSOR_STOP) {
@@ -145,23 +146,52 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
 start:
 	_debug("start");
 
-	/* TODO: Consider checking the VL server list */
-
 	if (!afs_start_vl_iteration(vc))
 		goto failed;
 
-use_server:
-	_debug("use");
+	error = afs_send_vl_probes(vc->cell->net, vc->key, vc->server_list);
+	if (error < 0)
+		goto failed_set_error;
+
+pick_server:
+	_debug("pick [%lx]", vc->untried);
+
+	error = afs_wait_for_vl_probes(vc->server_list, vc->untried);
+	if (error < 0)
+		goto failed_set_error;
+
+	/* Pick the untried server with the lowest RTT. */
+	vc->index = vc->server_list->preferred;
+	if (test_bit(vc->index, &vc->untried))
+		goto selected_server;
+
+	vc->index = -1;
+	rtt = U32_MAX;
+	for (i = 0; i < vc->server_list->nr_servers; i++) {
+		struct afs_vlserver *s = vc->server_list->servers[i].server;
+
+		if (!test_bit(i, &vc->untried) || !s->probe.responded)
+			continue;
+		if (s->probe.rtt < rtt) {
+			vc->index = i;
+			rtt = s->probe.rtt;
+		}
+	}
+
+	if (vc->index == -1)
+		goto no_more_servers;
+
+selected_server:
+	_debug("use %d", vc->index);
+	__clear_bit(vc->index, &vc->untried);
+
 	/* We're starting on a different vlserver from the list.  We need to
 	 * check it, find its address list and probe its capabilities before we
 	 * use it.
 	 */
 	ASSERTCMP(vc->ac.alist, ==, NULL);
 	vlserver = vc->server_list->servers[vc->index].server;
-
-	// TODO: Check the vlserver occasionally
-	//if (!afs_check_vlserver_record(vc, vlserver))
-	//	goto failed;
+	vc->server = vlserver;
 
 	_debug("USING VLSERVER: %s", vlserver->name);
 
@@ -173,62 +203,84 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
 
 	memset(&vc->ac, 0, sizeof(vc->ac));
 
-	/* Probe the current vlserver if we haven't done so yet. */
-#if 0 // TODO
-	if (!test_bit(AFS_VLSERVER_FL_PROBED, &vlserver->flags)) {
-		vc->ac.alist = afs_get_addrlist(alist);
-
-		if (!afs_probe_vlserver(vc)) {
-			error = vc->ac.error;
-			switch (error) {
-			case -ENOMEM:
-			case -ERESTARTSYS:
-			case -EINTR:
-				goto failed_set_error;
-			default:
-				goto next_server;
-			}
-		}
-	}
-#endif
-
 	if (!vc->ac.alist)
 		vc->ac.alist = alist;
 	else
 		afs_put_addrlist(alist);
 
-	vc->ac.start = READ_ONCE(alist->index);
-	vc->ac.index = vc->ac.start;
+	vc->ac.index = -1;
 
 iterate_address:
 	ASSERT(vc->ac.alist);
-	_debug("iterate %d/%d", vc->ac.index, vc->ac.alist->nr_addrs);
 	/* Iterate over the current server's address list to try and find an
 	 * address on which it will respond to us.
 	 */
 	if (!afs_iterate_addresses(&vc->ac))
 		goto next_server;
 
+	_debug("VL address %d/%d", vc->ac.index, vc->ac.alist->nr_addrs);
+
 	_leave(" = t %pISpc", &vc->ac.alist->addrs[vc->ac.index].transport);
 	return true;
 
 next_server:
 	_debug("next");
 	afs_end_cursor(&vc->ac);
-	vc->index++;
-	if (vc->index >= vc->server_list->nr_servers)
-		vc->index = 0;
-	if (vc->index != vc->start)
-		goto use_server;
+	goto pick_server;
 
+no_more_servers:
 	/* That's all the servers poked to no good effect.  Try again if some
 	 * of them were busy.
 	 */
 	if (vc->flags & AFS_VL_CURSOR_RETRY)
 		goto restart_from_beginning;
 
-	goto failed;
+	abort_code = 0;
+	error = -EDESTADDRREQ;
+	for (i = 0; i < vc->server_list->nr_servers; i++) {
+		struct afs_vlserver *s = vc->server_list->servers[i].server;
+		int probe_error = READ_ONCE(s->probe.error);
+
+		switch (probe_error) {
+		case 0:
+			continue;
+		default:
+			if (error == -ETIMEDOUT ||
+			    error == -ETIME)
+				continue;
+		case -ETIMEDOUT:
+		case -ETIME:
+			if (error == -ENOMEM ||
+			    error == -ENONET)
+				continue;
+		case -ENOMEM:
+		case -ENONET:
+			if (error == -ENETUNREACH)
+				continue;
+		case -ENETUNREACH:
+			if (error == -EHOSTUNREACH)
+				continue;
+		case -EHOSTUNREACH:
+			if (error == -ECONNREFUSED)
+				continue;
+		case -ECONNREFUSED:
+			if (error == -ECONNRESET)
+				continue;
+		case -ECONNRESET: /* Responded, but call expired. */
+			if (error == -ECONNABORTED)
+				continue;
+		case -ECONNABORTED:
+			abort_code = s->probe.abort_code;
+			error = probe_error;
+			continue;
+		}
+	}
+
+	if (error == -ECONNABORTED)
+		error = afs_abort_to_error(abort_code);
 
+failed_set_error:
+	vc->error = error;
 failed:
 	vc->flags |= AFS_VL_CURSOR_STOP;
 	afs_end_cursor(&vc->ac);
@@ -250,8 +302,8 @@ static void afs_vl_dump_edestaddrreq(const struct afs_vl_cursor *vc)
 
 	rcu_read_lock();
 	pr_notice("EDESTADDR occurred\n");
-	pr_notice("VC: st=%u ix=%u ni=%hu fl=%hx err=%hd\n",
-		  vc->start, vc->index, vc->nr_iterations, vc->flags, vc->error);
+	pr_notice("VC: ut=%lx ix=%u ni=%hu fl=%hx err=%hd\n",
+		  vc->untried, vc->index, vc->nr_iterations, vc->flags, vc->error);
 
 	if (vc->server_list) {
 		const struct afs_vlserver_list *sl = vc->server_list;
@@ -259,26 +311,25 @@ static void afs_vl_dump_edestaddrreq(const struct afs_vl_cursor *vc)
 			  sl->nr_servers, sl->index);
 		for (i = 0; i < sl->nr_servers; i++) {
 			const struct afs_vlserver *s = sl->servers[i].server;
-			pr_notice("VC: server fl=%lx %s+%hu\n",
-				  s->flags, s->name, s->port);
+			pr_notice("VC: server %s+%hu fl=%lx E=%hd\n",
+				  s->name, s->port, s->flags, s->probe.error);
 			if (s->addresses) {
 				const struct afs_addr_list *a =
 					rcu_dereference(s->addresses);
-				pr_notice("VC:  - av=%u nr=%u/%u/%u ax=%u\n",
-					  a->version,
+				pr_notice("VC:  - nr=%u/%u/%u pf=%u\n",
 					  a->nr_ipv4, a->nr_addrs, a->max_addrs,
-					  a->index);
-				pr_notice("VC:  - pr=%lx yf=%lx\n",
-					  a->probed, a->yfs);
+					  a->preferred);
+				pr_notice("VC:  - pr=%lx R=%lx F=%lx\n",
+					  a->probed, a->responded, a->failed);
 				if (a == vc->ac.alist)
 					pr_notice("VC:  - current\n");
 			}
 		}
 	}
 
-	pr_notice("AC: as=%u ax=%u ac=%d er=%d b=%u r=%u ni=%hu\n",
-		  vc->ac.start, vc->ac.index, vc->ac.abort_code, vc->ac.error,
-		  vc->ac.begun, vc->ac.responded, vc->ac.nr_iterations);
+	pr_notice("AC: t=%lx ax=%u ac=%d er=%d r=%u ni=%u\n",
+		  vc->ac.tried, vc->ac.index, vc->ac.abort_code, vc->ac.error,
+		  vc->ac.responded, vc->ac.nr_iterations);
 	rcu_read_unlock();
 }
 
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index 3127ab9b5521..c3d9e5a5f67e 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -348,12 +348,18 @@ static int afs_deliver_vl_get_capabilities(struct afs_call *call)
 		break;
 	}
 
-	call->reply[0] = (void *)(unsigned long)call->service_id;
-
 	_leave(" = 0 [done]");
 	return 0;
 }
 
+static void afs_destroy_vl_get_capabilities(struct afs_call *call)
+{
+	struct afs_vlserver *server = call->reply[0];
+
+	afs_put_vlserver(call->net, server);
+	afs_flat_call_destructor(call);
+}
+
 /*
  * VL.GetCapabilities operation type
  */
@@ -361,7 +367,8 @@ static const struct afs_call_type afs_RXVLGetCapabilities = {
 	.name		= "VL.GetCapabilities",
 	.op		= afs_VL_GetCapabilities,
 	.deliver	= afs_deliver_vl_get_capabilities,
-	.destructor	= afs_flat_call_destructor,
+	.done		= afs_vlserver_probe_result,
+	.destructor	= afs_destroy_vl_get_capabilities,
 };
 
 /*
@@ -371,8 +378,12 @@ static const struct afs_call_type afs_RXVLGetCapabilities = {
  * We use this to probe for service upgrade to determine what the server at the
  * other end supports.
  */
-int afs_vl_get_capabilities(struct afs_net *net, struct afs_addr_cursor *ac,
-			    struct key *key)
+int afs_vl_get_capabilities(struct afs_net *net,
+			    struct afs_addr_cursor *ac,
+			    struct key *key,
+			    struct afs_vlserver *server,
+			    unsigned int server_index,
+			    bool async)
 {
 	struct afs_call *call;
 	__be32 *bp;
@@ -384,9 +395,10 @@ int afs_vl_get_capabilities(struct afs_net *net, struct afs_addr_cursor *ac,
 		return -ENOMEM;
 
 	call->key = key;
-	call->upgrade = true; /* Let's see if this is a YFS server */
-	call->reply[0] = (void *)VLGETCAPABILITIES;
-	call->ret_reply0 = true;
+	call->reply[0] = afs_get_vlserver(server);
+	call->reply[1] = (void *)(long)server_index;
+	call->upgrade = true;
+	call->want_reply_time = true;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -394,7 +406,7 @@ int afs_vl_get_capabilities(struct afs_net *net, struct afs_addr_cursor *ac,
 
 	/* Can't take a ref on server */
 	trace_afs_make_vl_call(call);
-	return afs_make_call(ac, call, GFP_KERNEL, false);
+	return afs_make_call(ac, call, GFP_KERNEL, async);
 }
 
 /*
@@ -591,11 +603,6 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 	}
 
 	alist = call->reply[0];
-
-	/* Start with IPv6 if available. */
-	if (alist->nr_ipv4 < alist->nr_addrs)
-		alist->index = alist->nr_ipv4;
-
 	_leave(" = 0 [done]");
 	return 0;
 }
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index 7527c081726e..00975ed3640f 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -82,22 +82,6 @@ static struct afs_vldb_entry *afs_vl_lookup_vldb(struct afs_cell *cell,
 		return ERR_PTR(-ERESTARTSYS);
 
 	while (afs_select_vlserver(&vc)) {
-		if (!test_bit(vc.ac.index, &vc.ac.alist->probed)) {
-			ret = afs_vl_get_capabilities(cell->net, &vc.ac, key);
-			switch (ret) {
-			case VL_SERVICE:
-				clear_bit(vc.ac.index, &vc.ac.alist->yfs);
-				set_bit(vc.ac.index, &vc.ac.alist->probed);
-				vc.ac.alist->addrs[vc.ac.index].srx_service = ret;
-				break;
-			case YFS_VL_SERVICE:
-				set_bit(vc.ac.index, &vc.ac.alist->yfs);
-				set_bit(vc.ac.index, &vc.ac.alist->probed);
-				vc.ac.alist->addrs[vc.ac.index].srx_service = ret;
-				break;
-			}
-		}
-
 		vldb = afs_vl_get_entry_by_name_u(&vc, volname, volnamesz);
 	}
 
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index ed155042236b..33d291888ba9 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -137,6 +137,7 @@ enum afs_io_error {
 	afs_io_error_extract,
 	afs_io_error_fs_probe_fail,
 	afs_io_error_vl_lookup_fail,
+	afs_io_error_vl_probe_fail,
 };
 
 enum afs_file_error {
@@ -261,7 +262,8 @@ enum afs_file_error {
 	EM(afs_io_error_cm_reply,		"CM_REPLY")		\
 	EM(afs_io_error_extract,		"EXTRACT")		\
 	EM(afs_io_error_fs_probe_fail,		"FS_PROBE_FAIL")	\
-	E_(afs_io_error_vl_lookup_fail,		"VL_LOOKUP_FAIL")
+	EM(afs_io_error_vl_lookup_fail,		"VL_LOOKUP_FAIL")	\
+	E_(afs_io_error_vl_probe_fail,		"VL_PROBE_FAIL")
 
 #define afs_file_errors							\
 	EM(afs_file_error_dir_bad_magic,	"DIR_BAD_MAGIC")	\

