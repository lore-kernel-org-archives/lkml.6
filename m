Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2BFECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFCA21566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AFCA21566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390816AbeIUW1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:27:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32876 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389683AbeIUW1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:27:46 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 31DA5804E2;
        Fri, 21 Sep 2018 16:38:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C108030912F4;
        Fri, 21 Sep 2018 16:38:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/5] afs: Add fsinfo support [ver #12]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Date:   Fri, 21 Sep 2018 17:38:04 +0100
Message-ID: <153754788403.19213.2591548882315053681.stgit@warthog.procyon.org.uk>
In-Reply-To: <153754786825.19213.16907802981157370740.stgit@warthog.procyon.org.uk>
References: <153754786825.19213.16907802981157370740.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 21 Sep 2018 16:38:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fsinfo support to the AFS filesystem.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/super.c |  129 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/fs/afs/super.c b/fs/afs/super.c
index 944985e0a3c8..1fe5026b1104 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -26,6 +26,7 @@
 #include <linux/sched.h>
 #include <linux/nsproxy.h>
 #include <linux/magic.h>
+#include <linux/fsinfo.h>
 #include <net/net_namespace.h>
 #include "internal.h"
 
@@ -34,6 +35,7 @@ static void afs_kill_super(struct super_block *sb);
 static struct inode *afs_alloc_inode(struct super_block *sb);
 static void afs_destroy_inode(struct inode *inode);
 static int afs_statfs(struct dentry *dentry, struct kstatfs *buf);
+static int afs_fsinfo(struct path *path, struct fsinfo_kparams *params);
 static int afs_show_devname(struct seq_file *m, struct dentry *root);
 static int afs_show_options(struct seq_file *m, struct dentry *root);
 static int afs_init_fs_context(struct fs_context *fc, struct dentry *reference);
@@ -53,6 +55,7 @@ int afs_net_id;
 
 static const struct super_operations afs_super_ops = {
 	.statfs		= afs_statfs,
+	.fsinfo		= afs_fsinfo,
 	.alloc_inode	= afs_alloc_inode,
 	.drop_inode	= afs_drop_inode,
 	.destroy_inode	= afs_destroy_inode,
@@ -769,3 +772,129 @@ static int afs_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 	return ret;
 }
+
+/*
+ * Get filesystem information.
+ */
+static int afs_fsinfo(struct path *path, struct fsinfo_kparams *params)
+{
+	struct fsinfo_timestamp_info *tsinfo;
+	struct fsinfo_server_address *addr;
+	struct fsinfo_capabilities *caps;
+	struct fsinfo_supports *sup;
+	struct dentry *dentry = path->dentry;
+	struct afs_server_list *slist;
+	struct afs_super_info *as = AFS_FS_S(dentry->d_sb);
+	struct afs_addr_list *alist;
+	struct afs_server *server;
+	struct afs_volume *volume = as->volume;
+	struct afs_cell *cell = as->cell;
+	struct afs_net *net = afs_d2net(dentry);
+	bool dyn_root = as->dyn_root;
+	int ret;
+
+	switch (params->request) {
+	case FSINFO_ATTR_TIMESTAMP_INFO:
+		tsinfo = params->buffer;
+		tsinfo->minimum_timestamp = 0;
+		tsinfo->maximum_timestamp = UINT_MAX;
+		tsinfo->mtime_gran_mantissa = 1;
+		tsinfo->mtime_gran_exponent = 0;
+		return sizeof(*tsinfo);
+
+	case FSINFO_ATTR_SUPPORTS:
+		sup = params->buffer;
+		sup->stx_mask = (STATX_TYPE | STATX_MODE |
+				 STATX_NLINK |
+				 STATX_UID | STATX_GID |
+				 STATX_MTIME | STATX_INO |
+				 STATX_SIZE);
+		sup->stx_attributes = STATX_ATTR_AUTOMOUNT;
+		return sizeof(*sup);
+
+	case FSINFO_ATTR_CAPABILITIES:
+		caps = params->buffer;
+		if (dyn_root) {
+			fsinfo_set_cap(caps, FSINFO_CAP_IS_AUTOMOUNTER_FS);
+			fsinfo_set_cap(caps, FSINFO_CAP_AUTOMOUNTS);
+		} else {
+			fsinfo_set_cap(caps, FSINFO_CAP_IS_NETWORK_FS);
+			fsinfo_set_cap(caps, FSINFO_CAP_AUTOMOUNTS);
+			fsinfo_set_cap(caps, FSINFO_CAP_ADV_LOCKS);
+			fsinfo_set_cap(caps, FSINFO_CAP_UIDS);
+			fsinfo_set_cap(caps, FSINFO_CAP_GIDS);
+			fsinfo_set_cap(caps, FSINFO_CAP_VOLUME_ID);
+			fsinfo_set_cap(caps, FSINFO_CAP_VOLUME_NAME);
+			fsinfo_set_cap(caps, FSINFO_CAP_CELL_NAME);
+			fsinfo_set_cap(caps, FSINFO_CAP_IVER_MONO_INCR);
+			fsinfo_set_cap(caps, FSINFO_CAP_SYMLINKS);
+			fsinfo_set_cap(caps, FSINFO_CAP_HARD_LINKS_1DIR);
+			fsinfo_set_cap(caps, FSINFO_CAP_HAS_MTIME);
+		}
+		return sizeof(*caps);
+
+	case FSINFO_ATTR_VOLUME_NAME:
+		if (dyn_root)
+			return -EOPNOTSUPP;
+		memcpy(params->buffer, volume->name, volume->name_len);
+		return volume->name_len;
+
+	case FSINFO_ATTR_CELL_NAME:
+		if (dyn_root)
+			return -EOPNOTSUPP;
+		memcpy(params->buffer, cell->name, cell->name_len);
+		return cell->name_len;
+
+	case FSINFO_ATTR_SERVER_NAME:
+		if (dyn_root)
+			return -EOPNOTSUPP;
+		read_lock(&volume->servers_lock);
+		slist = afs_get_serverlist(volume->servers);
+		read_unlock(&volume->servers_lock);
+
+		if (params->Nth < slist->nr_servers) {
+			server = slist->servers[params->Nth].server;
+			ret = sprintf(params->buffer, "%pU", &server->uuid);
+		} else {
+			ret = -ENODATA;
+		}
+
+		afs_put_serverlist(net, slist);
+		return ret;
+
+	case FSINFO_ATTR_SERVER_ADDRESS:
+		addr = params->buffer;
+		if (dyn_root)
+			return -EOPNOTSUPP;
+		read_lock(&volume->servers_lock);
+		slist = afs_get_serverlist(volume->servers);
+		read_unlock(&volume->servers_lock);
+
+		ret = -ENODATA;
+		if (params->Nth >= slist->nr_servers)
+			goto put_slist;
+		server = slist->servers[params->Nth].server;
+
+		read_lock(&server->fs_lock);
+		alist = afs_get_addrlist(rcu_access_pointer(server->addresses));
+		read_unlock(&server->fs_lock);
+		if (!alist)
+			goto put_slist;
+
+		if (params->Mth >= alist->nr_addrs)
+			goto put_alist;
+
+		memcpy(addr, &alist->addrs[params->Mth],
+		       sizeof(struct sockaddr_rxrpc));
+		ret = sizeof(*addr);
+
+	put_alist:
+		afs_put_addrlist(alist);
+	put_slist:
+		afs_put_serverlist(net, slist);
+		return ret;
+
+	default:
+		return generic_fsinfo(path, params);
+	}
+}

