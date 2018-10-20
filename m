Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92630ECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D108214C2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D108214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbeJTJVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 05:21:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42612 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbeJTJVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 05:21:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 88FE415561;
        Sat, 20 Oct 2018 01:13:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F9BE6F945;
        Sat, 20 Oct 2018 01:13:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 21/24] afs: Allow dumping of server cursor on operation
 failure
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 20 Oct 2018 02:13:10 +0100
Message-ID: <153999799073.866.15303855282448985947.stgit@warthog.procyon.org.uk>
In-Reply-To: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
References: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sat, 20 Oct 2018 01:13:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide an option to allow the file or volume location server cursor to be
dumped if the rotation routine falls off the end without managing to
contact a server.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/Kconfig     |   12 +++++++++++
 fs/afs/addr_list.c |    2 ++
 fs/afs/internal.h  |    3 +++
 fs/afs/rotate.c    |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/afs/vl_rotate.c |   53 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 127 insertions(+)

diff --git a/fs/afs/Kconfig b/fs/afs/Kconfig
index ebba3b18e5da..701aaa9b1899 100644
--- a/fs/afs/Kconfig
+++ b/fs/afs/Kconfig
@@ -27,3 +27,15 @@ config AFS_FSCACHE
 	help
 	  Say Y here if you want AFS data to be cached locally on disk through
 	  the generic filesystem cache manager
+
+config AFS_DEBUG_CURSOR
+	bool "AFS server cursor debugging"
+	depends on AFS_FS
+	help
+	  Say Y here to cause the contents of a server cursor to be dumped to
+	  the dmesg log if the server rotation algorithm fails to successfully
+	  contact a server.
+
+	  See <file:Documentation/filesystems/afs.txt> for more information.
+
+	  If unsure, say N.
diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index 3f60b4012587..bc5ce31a4ae4 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -358,6 +358,8 @@ bool afs_iterate_addresses(struct afs_addr_cursor *ac)
 	if (!ac->alist)
 		return false;
 
+	ac->nr_iterations++;
+
 	if (ac->begun) {
 		ac->index++;
 		if (ac->index == ac->alist->nr_addrs)
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index ce79bd514331..ac9da1e4050e 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -660,6 +660,7 @@ struct afs_addr_cursor {
 	short			error;
 	bool			begun;		/* T if we've begun iteration */
 	bool			responded;	/* T if the current address responded */
+	unsigned short		nr_iterations;	/* Number of address iterations */
 };
 
 /*
@@ -677,6 +678,7 @@ struct afs_vl_cursor {
 #define AFS_VL_CURSOR_STOP	0x0001		/* Set to cease iteration */
 #define AFS_VL_CURSOR_RETRY	0x0002		/* Set to do a retry */
 #define AFS_VL_CURSOR_RETRIED	0x0004		/* Set if started a retry */
+	unsigned short		nr_iterations;	/* Number of server iterations */
 };
 
 /*
@@ -700,6 +702,7 @@ struct afs_fs_cursor {
 #define AFS_FS_CURSOR_VNOVOL	0x0008		/* Set if seen VNOVOL */
 #define AFS_FS_CURSOR_CUR_ONLY	0x0010		/* Set if current server only (file lock held) */
 #define AFS_FS_CURSOR_NO_VSLEEP	0x0020		/* Set to prevent sleep on VBUSY, VOFFLINE, ... */
+	unsigned short		nr_iterations;	/* Number of server iterations */
 };
 
 /*
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 41405dde0113..7c4487781637 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -156,6 +156,8 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 		return false;
 	}
 
+	fc->nr_iterations++;
+
 	/* Evaluate the result of the previous operation, if there was one. */
 	switch (error) {
 	case SHRT_MAX:
@@ -519,6 +521,56 @@ bool afs_select_current_fileserver(struct afs_fs_cursor *fc)
 	return false;
 }
 
+/*
+ * Dump cursor state in the case of the error being EDESTADDRREQ.
+ */
+static void afs_dump_edestaddrreq(const struct afs_fs_cursor *fc)
+{
+	static int count;
+	int i;
+
+	if (!IS_ENABLED(CONFIG_AFS_DEBUG_CURSOR) || count > 3)
+		return;
+	count++;
+
+	rcu_read_lock();
+
+	pr_notice("EDESTADDR occurred\n");
+	pr_notice("FC: cbb=%x cbb2=%x fl=%hx err=%hd\n",
+		  fc->cb_break, fc->cb_break_2, fc->flags, fc->error);
+	pr_notice("FC: st=%u ix=%u ni=%u\n",
+		  fc->start, fc->index, fc->nr_iterations);
+
+	if (fc->server_list) {
+		const struct afs_server_list *sl = fc->server_list;
+		pr_notice("FC: SL nr=%u ix=%u vnov=%hx\n",
+			  sl->nr_servers, sl->index, sl->vnovol_mask);
+		for (i = 0; i < sl->nr_servers; i++) {
+			const struct afs_server *s = sl->servers[i].server;
+			pr_notice("FC: server fl=%lx av=%u %pU\n",
+				  s->flags, s->addr_version, &s->uuid);
+			if (s->addresses) {
+				const struct afs_addr_list *a =
+					rcu_dereference(s->addresses);
+				pr_notice("FC:  - av=%u nr=%u/%u/%u ax=%u\n",
+					  a->version,
+					  a->nr_ipv4, a->nr_addrs, a->max_addrs,
+					  a->index);
+				pr_notice("FC:  - pr=%lx yf=%lx\n",
+					  a->probed, a->yfs);
+				if (a == fc->ac.alist)
+					pr_notice("FC:  - current\n");
+			}
+		}
+	}
+
+	pr_notice("AC: as=%u ax=%u ac=%d er=%d b=%u r=%u ni=%u\n",
+		  fc->ac.start, fc->ac.index, fc->ac.abort_code, fc->ac.error,
+		  fc->ac.begun, fc->ac.responded, fc->ac.nr_iterations);
+
+	rcu_read_unlock();
+}
+
 /*
  * Tidy up a filesystem cursor and unlock the vnode.
  */
@@ -526,6 +578,11 @@ int afs_end_vnode_operation(struct afs_fs_cursor *fc)
 {
 	struct afs_net *net = afs_v2net(fc->vnode);
 
+	if (fc->error == -EDESTADDRREQ ||
+	    fc->error == -ENETUNREACH ||
+	    fc->error == -EHOSTUNREACH)
+		afs_dump_edestaddrreq(fc);
+
 	mutex_unlock(&fc->vnode->io_lock);
 
 	afs_end_cursor(&fc->ac);
diff --git a/fs/afs/vl_rotate.c b/fs/afs/vl_rotate.c
index 44a936ad9c7a..5b99ea7be194 100644
--- a/fs/afs/vl_rotate.c
+++ b/fs/afs/vl_rotate.c
@@ -83,6 +83,8 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
 		return false;
 	}
 
+	vc->nr_iterations++;
+
 	/* Evaluate the result of the previous operation, if there was one. */
 	switch (error) {
 	case SHRT_MAX:
@@ -234,6 +236,52 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
 	return false;
 }
 
+/*
+ * Dump cursor state in the case of the error being EDESTADDRREQ.
+ */
+static void afs_vl_dump_edestaddrreq(const struct afs_vl_cursor *vc)
+{
+	static int count;
+	int i;
+
+	if (!IS_ENABLED(CONFIG_AFS_DEBUG_CURSOR) || count > 3)
+		return;
+	count++;
+
+	rcu_read_lock();
+	pr_notice("EDESTADDR occurred\n");
+	pr_notice("VC: st=%u ix=%u ni=%hu fl=%hx err=%hd\n",
+		  vc->start, vc->index, vc->nr_iterations, vc->flags, vc->error);
+
+	if (vc->server_list) {
+		const struct afs_vlserver_list *sl = vc->server_list;
+		pr_notice("VC: SL nr=%u ix=%u\n",
+			  sl->nr_servers, sl->index);
+		for (i = 0; i < sl->nr_servers; i++) {
+			const struct afs_vlserver *s = sl->servers[i].server;
+			pr_notice("VC: server fl=%lx %s+%hu\n",
+				  s->flags, s->name, s->port);
+			if (s->addresses) {
+				const struct afs_addr_list *a =
+					rcu_dereference(s->addresses);
+				pr_notice("VC:  - av=%u nr=%u/%u/%u ax=%u\n",
+					  a->version,
+					  a->nr_ipv4, a->nr_addrs, a->max_addrs,
+					  a->index);
+				pr_notice("VC:  - pr=%lx yf=%lx\n",
+					  a->probed, a->yfs);
+				if (a == vc->ac.alist)
+					pr_notice("VC:  - current\n");
+			}
+		}
+	}
+
+	pr_notice("AC: as=%u ax=%u ac=%d er=%d b=%u r=%u ni=%hu\n",
+		  vc->ac.start, vc->ac.index, vc->ac.abort_code, vc->ac.error,
+		  vc->ac.begun, vc->ac.responded, vc->ac.nr_iterations);
+	rcu_read_unlock();
+}
+
 /*
  * Tidy up a volume location server cursor and unlock the vnode.
  */
@@ -241,6 +289,11 @@ int afs_end_vlserver_operation(struct afs_vl_cursor *vc)
 {
 	struct afs_net *net = vc->cell->net;
 
+	if (vc->error == -EDESTADDRREQ ||
+	    vc->error == -ENETUNREACH ||
+	    vc->error == -EHOSTUNREACH)
+		afs_vl_dump_edestaddrreq(vc);
+
 	afs_end_cursor(&vc->ac);
 	afs_put_vlserverlist(net, vc->server_list);
 

