Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD59C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE76320862
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE76320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389815AbeG0S6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:58:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388701AbeG0S6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:58:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 287F8F2B37;
        Fri, 27 Jul 2018 17:35:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B2912026D6B;
        Fri, 27 Jul 2018 17:35:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 35/38] afs: Add fsinfo support [ver #10]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 Jul 2018 18:35:16 +0100
Message-ID: <153271291695.9458.8521989831386567633.stgit@warthog.procyon.org.uk>
In-Reply-To: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 27 Jul 2018 17:35:18 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 27 Jul 2018 17:35:18 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fsinfo support to the AFS filesystem.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/super.c |  133 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/fs/afs/super.c b/fs/afs/super.c
index 55f11477ade6..852526f17e4a 100644
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
+static int afs_get_fsinfo(struct dentry *dentry, struct fsinfo_kparams *params);
 static int afs_show_devname(struct seq_file *m, struct dentry *root);
 static int afs_show_options(struct seq_file *m, struct dentry *root);
 static int afs_init_fs_context(struct fs_context *fc, struct dentry *reference);
@@ -53,6 +55,7 @@ int afs_net_id;
 
 static const struct super_operations afs_super_ops = {
 	.statfs		= afs_statfs,
+	.get_fsinfo	= afs_get_fsinfo,
 	.alloc_inode	= afs_alloc_inode,
 	.drop_inode	= afs_drop_inode,
 	.destroy_inode	= afs_destroy_inode,
@@ -771,3 +774,133 @@ static int afs_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 	return ret;
 }
+
+/*
+ * Get filesystem information.
+ */
+static int afs_get_fsinfo(struct dentry *dentry, struct fsinfo_kparams *params)
+{
+	struct fsinfo_timestamp_info *tsinfo;
+	struct fsinfo_server_address *addr;
+	struct fsinfo_capabilities *caps;
+	struct fsinfo_supports *sup;
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
+	case fsinfo_attr_timestamp_info:
+		tsinfo = params->buffer;
+		tsinfo->minimum_timestamp = 0;
+		tsinfo->maximum_timestamp = UINT_MAX;
+		tsinfo->mtime_gran_mantissa = 1;
+		tsinfo->mtime_gran_exponent = 0;
+		return sizeof(*tsinfo);
+
+	case fsinfo_attr_supports:
+		sup = params->buffer;
+		sup->stx_mask = (STATX_TYPE | STATX_MODE |
+				 STATX_NLINK |
+				 STATX_UID | STATX_GID |
+				 STATX_MTIME | STATX_INO |
+				 STATX_SIZE);
+		sup->stx_attributes = STATX_ATTR_AUTOMOUNT;
+		return sizeof(*sup);
+
+	case fsinfo_attr_capabilities:
+		caps = params->buffer;
+		if (dyn_root) {
+			fsinfo_set_cap(caps, fsinfo_cap_is_automounter_fs);
+			fsinfo_set_cap(caps, fsinfo_cap_automounts);
+		} else {
+			fsinfo_set_cap(caps, fsinfo_cap_is_network_fs);
+			fsinfo_set_cap(caps, fsinfo_cap_automounts);
+			fsinfo_set_cap(caps, fsinfo_cap_adv_locks);
+			fsinfo_set_cap(caps, fsinfo_cap_uids);
+			fsinfo_set_cap(caps, fsinfo_cap_gids);
+			fsinfo_set_cap(caps, fsinfo_cap_volume_id);
+			fsinfo_set_cap(caps, fsinfo_cap_volume_name);
+			fsinfo_set_cap(caps, fsinfo_cap_cell_name);
+			fsinfo_set_cap(caps, fsinfo_cap_iver_mono_incr);
+			fsinfo_set_cap(caps, fsinfo_cap_symlinks);
+			fsinfo_set_cap(caps, fsinfo_cap_hard_links_1dir);
+			fsinfo_set_cap(caps, fsinfo_cap_has_mtime);
+		}
+		return sizeof(*caps);
+
+	case fsinfo_attr_volume_name:
+		if (dyn_root)
+			return -EOPNOTSUPP;
+		if (params->buffer)
+			memcpy(params->buffer, volume->name, volume->name_len);
+		return volume->name_len;
+
+	case fsinfo_attr_cell_name:
+		if (dyn_root)
+			return -EOPNOTSUPP;
+		if (params->buffer)
+			memcpy(params->buffer, cell->name, cell->name_len);
+		return cell->name_len;
+
+	case fsinfo_attr_server_name:
+		if (dyn_root)
+			return -EOPNOTSUPP;
+		read_lock(&volume->servers_lock);
+		slist = afs_get_serverlist(volume->servers);
+		read_unlock(&volume->servers_lock);
+
+		if (params->Nth < slist->nr_servers) {
+			server = slist->servers[params->Nth].server;
+			if (params->buffer)
+				ret = sprintf(params->buffer, "%pU", &server->uuid);
+			else
+				ret = 16 * 2 + 4;
+		} else {
+			ret = -ENODATA;
+		}
+
+		afs_put_serverlist(net, slist);
+		return ret;
+
+	case fsinfo_attr_server_address:
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
+		return generic_fsinfo(dentry, params);
+	}
+}

