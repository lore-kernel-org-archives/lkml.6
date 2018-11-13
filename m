Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88071C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416E320835
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416E320835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731801AbeKNJVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 04:21:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbeKNJVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 04:21:00 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D615A30BB53A;
        Tue, 13 Nov 2018 23:20:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCBBF5F734;
        Tue, 13 Nov 2018 23:20:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/3] afs: Fix missing net error handling
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 13 Nov 2018 23:20:28 +0000
Message-ID: <154215122800.3727.1021684456062839383.stgit@warthog.procyon.org.uk>
In-Reply-To: <154215121391.3727.8471308154885635876.stgit@warthog.procyon.org.uk>
References: <154215121391.3727.8471308154885635876.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 13 Nov 2018 23:20:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kAFS can be given certain network errors (EADDRNOTAVAIL, EHOSTDOWN and
ERFKILL) that it doesn't handle in its server/address rotation algorithms.
They cause the probing and rotation to abort immediately rather than
rotating.

Fix this by:

 (1) Abstracting out the error prioritisation from the VL and FS rotation
     algorithms into a common function and expand usage into the server
     probing code.

     When multiple errors are available, this code selects the one we'd
     prefer to return.

 (2) Add handling for EADDRNOTAVAIL, EHOSTDOWN and ERFKILL.

Fixes: 0fafdc9f888b ("afs: Fix file locking")
Fixes: 0338747d8454 ("afs: Probe multiple fileservers simultaneously")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/fs_probe.c  |   39 ++++++++++++++++++++++++--------------
 fs/afs/internal.h  |    9 +++++++++
 fs/afs/misc.c      |   52 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/afs/rotate.c    |   53 +++++++++++++---------------------------------------
 fs/afs/vl_probe.c  |   45 ++++++++++++++++++++++++++------------------
 fs/afs/vl_rotate.c |   50 ++++++++++---------------------------------------
 6 files changed, 135 insertions(+), 113 deletions(-)

diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index d049cb459742..fde6b4d4121e 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -61,8 +61,11 @@ void afs_fileserver_probe_result(struct afs_call *call)
 		afs_io_error(call, afs_io_error_fs_probe_fail);
 		goto out;
 	case -ECONNRESET: /* Responded, but call expired. */
+	case -ERFKILL:
+	case -EADDRNOTAVAIL:
 	case -ENETUNREACH:
 	case -EHOSTUNREACH:
+	case -EHOSTDOWN:
 	case -ECONNREFUSED:
 	case -ETIMEDOUT:
 	case -ETIME:
@@ -132,12 +135,14 @@ void afs_fileserver_probe_result(struct afs_call *call)
 static int afs_do_probe_fileserver(struct afs_net *net,
 				   struct afs_server *server,
 				   struct key *key,
-				   unsigned int server_index)
+				   unsigned int server_index,
+				   struct afs_error *_e)
 {
 	struct afs_addr_cursor ac = {
 		.index = 0,
 	};
-	int ret;
+	bool in_progress = false;
+	int err;
 
 	_enter("%pU", &server->uuid);
 
@@ -151,15 +156,17 @@ static int afs_do_probe_fileserver(struct afs_net *net,
 	server->probe.rtt = UINT_MAX;
 
 	for (ac.index = 0; ac.index < ac.alist->nr_addrs; ac.index++) {
-		ret = afs_fs_get_capabilities(net, server, &ac, key, server_index,
+		err = afs_fs_get_capabilities(net, server, &ac, key, server_index,
 					      true);
-		if (ret != -EINPROGRESS) {
-			afs_fs_probe_done(server);
-			return ret;
-		}
+		if (err == -EINPROGRESS)
+			in_progress = true;
+		else
+			afs_prioritise_error(_e, err, ac.abort_code);
 	}
 
-	return 0;
+	if (!in_progress)
+		afs_fs_probe_done(server);
+	return in_progress;
 }
 
 /*
@@ -169,21 +176,23 @@ int afs_probe_fileservers(struct afs_net *net, struct key *key,
 			  struct afs_server_list *list)
 {
 	struct afs_server *server;
-	int i, ret;
+	struct afs_error e;
+	bool in_progress = false;
+	int i;
 
+	e.error = 0;
+	e.responded = false;
 	for (i = 0; i < list->nr_servers; i++) {
 		server = list->servers[i].server;
 		if (test_bit(AFS_SERVER_FL_PROBED, &server->flags))
 			continue;
 
-		if (!test_and_set_bit_lock(AFS_SERVER_FL_PROBING, &server->flags)) {
-			ret = afs_do_probe_fileserver(net, server, key, i);
-			if (ret)
-				return ret;
-		}
+		if (!test_and_set_bit_lock(AFS_SERVER_FL_PROBING, &server->flags) &&
+		    afs_do_probe_fileserver(net, server, key, i, &e))
+			in_progress = true;
 	}
 
-	return 0;
+	return in_progress ? 0 : e.error;
 }
 
 /*
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 5da3b09b7518..8871b9e8645f 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -695,6 +695,14 @@ struct afs_interface {
 	unsigned	mtu;		/* MTU of interface */
 };
 
+/*
+ * Error prioritisation and accumulation.
+ */
+struct afs_error {
+	short	error;			/* Accumulated error */
+	bool	responded;		/* T if server responded */
+};
+
 /*
  * Cursor for iterating over a server's address list.
  */
@@ -1015,6 +1023,7 @@ static inline void __afs_stat(atomic_t *s)
  * misc.c
  */
 extern int afs_abort_to_error(u32);
+extern void afs_prioritise_error(struct afs_error *, int, u32);
 
 /*
  * mntpt.c
diff --git a/fs/afs/misc.c b/fs/afs/misc.c
index 700a5fa7f4ec..bbb1fd51b019 100644
--- a/fs/afs/misc.c
+++ b/fs/afs/misc.c
@@ -118,3 +118,55 @@ int afs_abort_to_error(u32 abort_code)
 	default:		return -EREMOTEIO;
 	}
 }
+
+/*
+ * Select the error to report from a set of errors.
+ */
+void afs_prioritise_error(struct afs_error *e, int error, u32 abort_code)
+{
+	switch (error) {
+	case 0:
+		return;
+	default:
+		if (e->error == -ETIMEDOUT ||
+		    e->error == -ETIME)
+			return;
+	case -ETIMEDOUT:
+	case -ETIME:
+		if (e->error == -ENOMEM ||
+		    e->error == -ENONET)
+			return;
+	case -ENOMEM:
+	case -ENONET:
+		if (e->error == -ERFKILL)
+			return;
+	case -ERFKILL:
+		if (e->error == -EADDRNOTAVAIL)
+			return;
+	case -EADDRNOTAVAIL:
+		if (e->error == -ENETUNREACH)
+			return;
+	case -ENETUNREACH:
+		if (e->error == -EHOSTUNREACH)
+			return;
+	case -EHOSTUNREACH:
+		if (e->error == -EHOSTDOWN)
+			return;
+	case -EHOSTDOWN:
+		if (e->error == -ECONNREFUSED)
+			return;
+	case -ECONNREFUSED:
+		if (e->error == -ECONNRESET)
+			return;
+	case -ECONNRESET: /* Responded, but call expired. */
+		if (e->responded)
+			return;
+		e->error = error;
+		return;
+
+	case -ECONNABORTED:
+		e->responded = true;
+		e->error = afs_abort_to_error(abort_code);
+		return;
+	}
+}
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 00504254c1c2..c3ae324781f8 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -136,7 +136,8 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 	struct afs_addr_list *alist;
 	struct afs_server *server;
 	struct afs_vnode *vnode = fc->vnode;
-	u32 rtt, abort_code;
+	struct afs_error e;
+	u32 rtt;
 	int error = fc->ac.error, i;
 
 	_enter("%lx[%d],%lx[%d],%d,%d",
@@ -306,8 +307,11 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 		if (fc->error != -EDESTADDRREQ)
 			goto iterate_address;
 		/* Fall through */
+	case -ERFKILL:
+	case -EADDRNOTAVAIL:
 	case -ENETUNREACH:
 	case -EHOSTUNREACH:
+	case -EHOSTDOWN:
 	case -ECONNREFUSED:
 		_debug("no conn");
 		fc->error = error;
@@ -446,50 +450,15 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 	if (fc->flags & AFS_FS_CURSOR_VBUSY)
 		goto restart_from_beginning;
 
-	abort_code = 0;
-	error = -EDESTADDRREQ;
+	e.error = -EDESTADDRREQ;
+	e.responded = false;
 	for (i = 0; i < fc->server_list->nr_servers; i++) {
 		struct afs_server *s = fc->server_list->servers[i].server;
-		int probe_error = READ_ONCE(s->probe.error);
 
-		switch (probe_error) {
-		case 0:
-			continue;
-		default:
-			if (error == -ETIMEDOUT ||
-			    error == -ETIME)
-				continue;
-		case -ETIMEDOUT:
-		case -ETIME:
-			if (error == -ENOMEM ||
-			    error == -ENONET)
-				continue;
-		case -ENOMEM:
-		case -ENONET:
-			if (error == -ENETUNREACH)
-				continue;
-		case -ENETUNREACH:
-			if (error == -EHOSTUNREACH)
-				continue;
-		case -EHOSTUNREACH:
-			if (error == -ECONNREFUSED)
-				continue;
-		case -ECONNREFUSED:
-			if (error == -ECONNRESET)
-				continue;
-		case -ECONNRESET: /* Responded, but call expired. */
-			if (error == -ECONNABORTED)
-				continue;
-		case -ECONNABORTED:
-			abort_code = s->probe.abort_code;
-			error = probe_error;
-			continue;
-		}
+		afs_prioritise_error(&e, READ_ONCE(s->probe.error),
+				     s->probe.abort_code);
 	}
 
-	if (error == -ECONNABORTED)
-		error = afs_abort_to_error(abort_code);
-
 failed_set_error:
 	fc->error = error;
 failed:
@@ -553,8 +522,11 @@ bool afs_select_current_fileserver(struct afs_fs_cursor *fc)
 		_leave(" = f [abort]");
 		return false;
 
+	case -ERFKILL:
+	case -EADDRNOTAVAIL:
 	case -ENETUNREACH:
 	case -EHOSTUNREACH:
+	case -EHOSTDOWN:
 	case -ECONNREFUSED:
 	case -ETIMEDOUT:
 	case -ETIME:
@@ -633,6 +605,7 @@ int afs_end_vnode_operation(struct afs_fs_cursor *fc)
 	struct afs_net *net = afs_v2net(fc->vnode);
 
 	if (fc->error == -EDESTADDRREQ ||
+	    fc->error == -EADDRNOTAVAIL ||
 	    fc->error == -ENETUNREACH ||
 	    fc->error == -EHOSTUNREACH)
 		afs_dump_edestaddrreq(fc);
diff --git a/fs/afs/vl_probe.c b/fs/afs/vl_probe.c
index c0f616bd70cb..f0b032976487 100644
--- a/fs/afs/vl_probe.c
+++ b/fs/afs/vl_probe.c
@@ -61,8 +61,11 @@ void afs_vlserver_probe_result(struct afs_call *call)
 		afs_io_error(call, afs_io_error_vl_probe_fail);
 		goto out;
 	case -ECONNRESET: /* Responded, but call expired. */
+	case -ERFKILL:
+	case -EADDRNOTAVAIL:
 	case -ENETUNREACH:
 	case -EHOSTUNREACH:
+	case -EHOSTDOWN:
 	case -ECONNREFUSED:
 	case -ETIMEDOUT:
 	case -ETIME:
@@ -129,15 +132,17 @@ void afs_vlserver_probe_result(struct afs_call *call)
  * Probe all of a vlserver's addresses to find out the best route and to
  * query its capabilities.
  */
-static int afs_do_probe_vlserver(struct afs_net *net,
-				 struct afs_vlserver *server,
-				 struct key *key,
-				 unsigned int server_index)
+static bool afs_do_probe_vlserver(struct afs_net *net,
+				  struct afs_vlserver *server,
+				  struct key *key,
+				  unsigned int server_index,
+				  struct afs_error *_e)
 {
 	struct afs_addr_cursor ac = {
 		.index = 0,
 	};
-	int ret;
+	bool in_progress = false;
+	int err;
 
 	_enter("%s", server->name);
 
@@ -151,15 +156,17 @@ static int afs_do_probe_vlserver(struct afs_net *net,
 	server->probe.rtt = UINT_MAX;
 
 	for (ac.index = 0; ac.index < ac.alist->nr_addrs; ac.index++) {
-		ret = afs_vl_get_capabilities(net, &ac, key, server,
+		err = afs_vl_get_capabilities(net, &ac, key, server,
 					      server_index, true);
-		if (ret != -EINPROGRESS) {
-			afs_vl_probe_done(server);
-			return ret;
-		}
+		if (err == -EINPROGRESS)
+			in_progress = true;
+		else
+			afs_prioritise_error(_e, err, ac.abort_code);
 	}
 
-	return 0;
+	if (!in_progress)
+		afs_vl_probe_done(server);
+	return in_progress;
 }
 
 /*
@@ -169,21 +176,23 @@ int afs_send_vl_probes(struct afs_net *net, struct key *key,
 		       struct afs_vlserver_list *vllist)
 {
 	struct afs_vlserver *server;
-	int i, ret;
+	struct afs_error e;
+	bool in_progress = false;
+	int i;
 
+	e.error = 0;
+	e.responded = false;
 	for (i = 0; i < vllist->nr_servers; i++) {
 		server = vllist->servers[i].server;
 		if (test_bit(AFS_VLSERVER_FL_PROBED, &server->flags))
 			continue;
 
-		if (!test_and_set_bit_lock(AFS_VLSERVER_FL_PROBING, &server->flags)) {
-			ret = afs_do_probe_vlserver(net, server, key, i);
-			if (ret)
-				return ret;
-		}
+		if (!test_and_set_bit_lock(AFS_VLSERVER_FL_PROBING, &server->flags) &&
+		    afs_do_probe_vlserver(net, server, key, i, &e))
+			in_progress = true;
 	}
 
-	return 0;
+	return in_progress ? 0 : e.error;
 }
 
 /*
diff --git a/fs/afs/vl_rotate.c b/fs/afs/vl_rotate.c
index b64a284b99d2..7adde83a0648 100644
--- a/fs/afs/vl_rotate.c
+++ b/fs/afs/vl_rotate.c
@@ -71,8 +71,9 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
 {
 	struct afs_addr_list *alist;
 	struct afs_vlserver *vlserver;
+	struct afs_error e;
 	u32 rtt;
-	int error = vc->ac.error, abort_code, i;
+	int error = vc->ac.error, i;
 
 	_enter("%lx[%d],%lx[%d],%d,%d",
 	       vc->untried, vc->index,
@@ -119,8 +120,11 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
 			goto failed;
 		}
 
+	case -ERFKILL:
+	case -EADDRNOTAVAIL:
 	case -ENETUNREACH:
 	case -EHOSTUNREACH:
+	case -EHOSTDOWN:
 	case -ECONNREFUSED:
 	case -ETIMEDOUT:
 	case -ETIME:
@@ -235,50 +239,15 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
 	if (vc->flags & AFS_VL_CURSOR_RETRY)
 		goto restart_from_beginning;
 
-	abort_code = 0;
-	error = -EDESTADDRREQ;
+	e.error = -EDESTADDRREQ;
+	e.responded = false;
 	for (i = 0; i < vc->server_list->nr_servers; i++) {
 		struct afs_vlserver *s = vc->server_list->servers[i].server;
-		int probe_error = READ_ONCE(s->probe.error);
 
-		switch (probe_error) {
-		case 0:
-			continue;
-		default:
-			if (error == -ETIMEDOUT ||
-			    error == -ETIME)
-				continue;
-		case -ETIMEDOUT:
-		case -ETIME:
-			if (error == -ENOMEM ||
-			    error == -ENONET)
-				continue;
-		case -ENOMEM:
-		case -ENONET:
-			if (error == -ENETUNREACH)
-				continue;
-		case -ENETUNREACH:
-			if (error == -EHOSTUNREACH)
-				continue;
-		case -EHOSTUNREACH:
-			if (error == -ECONNREFUSED)
-				continue;
-		case -ECONNREFUSED:
-			if (error == -ECONNRESET)
-				continue;
-		case -ECONNRESET: /* Responded, but call expired. */
-			if (error == -ECONNABORTED)
-				continue;
-		case -ECONNABORTED:
-			abort_code = s->probe.abort_code;
-			error = probe_error;
-			continue;
-		}
+		afs_prioritise_error(&e, READ_ONCE(s->probe.error),
+				     s->probe.abort_code);
 	}
 
-	if (error == -ECONNABORTED)
-		error = afs_abort_to_error(abort_code);
-
 failed_set_error:
 	vc->error = error;
 failed:
@@ -341,6 +310,7 @@ int afs_end_vlserver_operation(struct afs_vl_cursor *vc)
 	struct afs_net *net = vc->cell->net;
 
 	if (vc->error == -EDESTADDRREQ ||
+	    vc->error == -EADDRNOTAVAIL ||
 	    vc->error == -ENETUNREACH ||
 	    vc->error == -EHOSTUNREACH)
 		afs_vl_dump_edestaddrreq(vc);

