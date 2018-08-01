Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC47C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F3B208A6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F3B208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390186AbeHASAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 14:00:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390167AbeHASAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 14:00:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7BF7A4021706;
        Wed,  1 Aug 2018 16:14:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7C77202020C;
        Wed,  1 Aug 2018 16:14:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/5] afs: Add fsinfo support
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 01 Aug 2018 17:14:08 +0100
Message-ID: <153314004826.18964.10724955422385190184.stgit@warthog.procyon.org.uk>
In-Reply-To: <153314002975.18964.1773855756473041897.stgit@warthog.procyon.org.uk>
References: <153314002975.18964.1773855756473041897.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 01 Aug 2018 16:14:09 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 01 Aug 2018 16:14:09 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fsinfo support to the AFS filesystem.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/super.c |  128 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/fs/afs/super.c b/fs/afs/super.c
index 56eab3433aba..10b5616a7843 100644
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
@@ -769,3 +772,128 @@ static int afs_statfs(struct dentry *dentry, struct kstatfs *buf)
 
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
+		return generic_fsinfo(dentry, params);
+	}
+}

