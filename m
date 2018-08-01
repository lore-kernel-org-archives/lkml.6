Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56350C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044B220841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044B220841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390249AbeHASA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 14:00:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390108AbeHASA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 14:00:57 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A0C974219DB4;
        Wed,  1 Aug 2018 16:14:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C816610EE6D0;
        Wed,  1 Aug 2018 16:14:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 5/5] vfs: Implement parameter value retrieval with fsinfo()
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 01 Aug 2018 17:14:27 +0100
Message-ID: <153314006732.18964.13429664337039974242.stgit@warthog.procyon.org.uk>
In-Reply-To: <153314002975.18964.1773855756473041897.stgit@warthog.procyon.org.uk>
References: <153314002975.18964.1773855756473041897.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 01 Aug 2018 16:14:28 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 01 Aug 2018 16:14:28 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement parameter value retrieval with fsinfo() - akin to parsing
/proc/mounts.

This allows the values of each parameter to be retrieved in an order
corresponding to the Nth index used by FSINFO_ATTR_PARAM_SPECIFICATION.  If
a parameter isn't set, an empty string is returned.  Parameters may have
multiple values, which can be accessed using the Mth index.  For example,
set:

	struct fsinfo_params params = {
		.request	= FSINFO_ATTR_PARAM_SPECIFICATION,
		.Nth		= 3,
	};

this can be passed to fsinfo() to retrieve the type information for the
parameter #3.  Value #2 of parameter #3 can then be retrieved using:

	struct fsinfo_params params = {
		.request	= FSINFO_ATTR_PARAM_SPECIFICATION,
		.Nth		= 3,
		.Mth		= 2,
	};

fsinfo() returned -ENODATA if Nth is beyond the last parameter or Mth is
beyond the last value of that parameter.

Note that it is permissible for the filesystem to add extra values on the
end beyond the number of specs returned by FSINFO_ATTR_PARAM_SPECIFICATION.
This is used by cgroup-v1 to list the supported subsystem names after the
standard parameters.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/internal.h         |    1 +
 fs/afs/super.c            |   39 +++++++++++++++++++++++-
 fs/hugetlbfs/inode.c      |   65 +++++++++++++++++++++++++++++++++++++++++
 fs/kernfs/mount.c         |   16 ++++++++++
 include/linux/kernfs.h    |    2 +
 kernel/cgroup/cgroup-v1.c |   72 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/cgroup/cgroup.c    |   31 +++++++++++++++++++
 samples/Kconfig           |    2 +
 8 files changed, 225 insertions(+), 3 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index e35d59761d47..35aa4bd79145 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -195,6 +195,7 @@ struct afs_super_info {
 	struct afs_cell		*cell;		/* The cell in which the volume resides */
 	struct afs_volume	*volume;	/* volume record */
 	bool			dyn_root;	/* True if dynamic root */
+	bool			autocell;	/* True if autocell */
 };
 
 static inline struct afs_super_info *AFS_FS_S(struct super_block *sb)
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 10b5616a7843..7c97836e7937 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -197,7 +197,7 @@ static int afs_show_options(struct seq_file *m, struct dentry *root)
 
 	if (as->dyn_root)
 		seq_puts(m, ",dyn");
-	if (test_bit(AFS_VNODE_AUTOCELL, &AFS_FS_I(d_inode(root))->flags))
+	if (as->autocell)
 		seq_puts(m, ",autocell");
 	return 0;
 }
@@ -444,7 +444,7 @@ static int afs_fill_super(struct super_block *sb, struct afs_fs_context *ctx)
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
-	if (ctx->autocell || as->dyn_root)
+	if (as->autocell || as->dyn_root)
 		set_bit(AFS_VNODE_AUTOCELL, &AFS_FS_I(inode)->flags);
 
 	ret = -ENOMEM;
@@ -483,6 +483,8 @@ static struct afs_super_info *afs_alloc_sbi(struct fs_context *fc)
 			as->cell = afs_get_cell(ctx->cell);
 			as->volume = __afs_get_volume(ctx->volume);
 		}
+		if (ctx->autocell)
+			as->autocell = true;
 	}
 	return as;
 }
@@ -789,6 +791,7 @@ static int afs_get_fsinfo(struct dentry *dentry, struct fsinfo_kparams *params)
 	struct afs_volume *volume = as->volume;
 	struct afs_cell *cell = as->cell;
 	struct afs_net *net = afs_d2net(dentry);
+	const char *str = NULL;
 	bool dyn_root = as->dyn_root;
 	int ret;
 
@@ -893,7 +896,39 @@ static int afs_get_fsinfo(struct dentry *dentry, struct fsinfo_kparams *params)
 		afs_put_serverlist(net, slist);
 		return ret;
 
+	case FSINFO_ATTR_PARAMETER:
+		if (params->Mth)
+			return -ENODATA;
+		switch (params->Nth) {
+		case Opt_autocell:
+			if (as->autocell)
+				str = "autocell";
+			goto string;
+		case Opt_dyn:
+			if (dyn_root)
+				str = "dyn";
+			goto string;
+		case Opt_source:
+			if (dyn_root)
+				return 0;
+			return sprintf(params->buffer, "source=%c%s:%s%s",
+				       volume->type == AFSVL_RWVOL ? '%' : '#',
+				       cell->name,
+				       volume->name,
+				       volume->type == AFSVL_RWVOL ? "" :
+				       volume->type == AFSVL_ROVOL ? ".readonly" :
+				       ".backup");
+		default:
+			return -ENODATA;
+		}
+
 	default:
 		return generic_fsinfo(dentry, params);
 	}
+
+string:
+	if (!str)
+		return 0;
+	strcpy(params->buffer, str);
+	return strlen(params->buffer);
 }
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 28f6c28e55dc..e2378c8ce7e0 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -28,6 +28,7 @@
 #include <linux/hugetlb.h>
 #include <linux/pagevec.h>
 #include <linux/fs_parser.h>
+#include <linux/fsinfo.h>
 #include <linux/mman.h>
 #include <linux/slab.h>
 #include <linux/dnotify.h>
@@ -948,6 +949,69 @@ static int hugetlbfs_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
+static int hugetlbfs_get_fsinfo(struct dentry *dentry, struct fsinfo_kparams *params)
+{
+	struct hugetlbfs_sb_info *sbinfo = HUGETLBFS_SB(dentry->d_sb);
+	struct hugepage_subpool *spool = sbinfo->spool;
+	unsigned long hpage_size = huge_page_size(sbinfo->hstate);
+	unsigned hpage_shift = huge_page_shift(sbinfo->hstate);
+	char mod;
+
+	switch (params->request) {
+	case FSINFO_ATTR_PARAMETER:
+		if (params->Mth)
+			return -ENODATA;
+		switch (params->Nth) {
+		case Opt_uid:
+			if (!uid_eq(sbinfo->uid, GLOBAL_ROOT_UID))
+				return sprintf(params->buffer, "uid=%u",
+					       from_kuid_munged(&init_user_ns,
+								sbinfo->uid));
+			return 0;
+		case Opt_gid:
+			if (!gid_eq(sbinfo->gid, GLOBAL_ROOT_GID))
+				return sprintf(params->buffer, "gid=%u",
+					       from_kgid_munged(&init_user_ns,
+								sbinfo->gid));
+			return 0;
+
+		case Opt_size:
+			if (!spool || spool->max_hpages == -1)
+				return 0;
+			return sprintf(params->buffer, "size=%llu",
+				       (unsigned long long)spool->max_hpages << hpage_shift);
+		case Opt_min_size:
+			if (!spool || spool->min_hpages == -1)
+				return 0;
+			return sprintf(params->buffer, "min_size=%llu",
+				       (unsigned long long)spool->min_hpages << hpage_shift);
+		case Opt_pagesize:
+			hpage_size /= 1024;
+			mod = 'K';
+			if (hpage_size >= 1024) {
+				hpage_size /= 1024;
+				mod = 'M';
+			}
+			return sprintf(params->buffer, "pagesize=%lu%c",
+				       hpage_size, mod);
+
+		case Opt_mode:
+			if (sbinfo->mode == 0755)
+				return 0;
+			return sprintf(params->buffer, "mode=%o", sbinfo->mode);
+		case Opt_nr_inodes:
+			if (sbinfo->max_inodes == -1)
+				return 0;
+			return sprintf(params->buffer, "nr_inodes=%lu",
+				       sbinfo->max_inodes);
+		default:
+			return -ENODATA;
+		}
+	default:
+		return generic_fsinfo(dentry, params);
+	}
+}
+
 static int hugetlbfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct hugetlbfs_sb_info *sbinfo = HUGETLBFS_SB(dentry->d_sb);
@@ -1107,6 +1171,7 @@ static const struct super_operations hugetlbfs_ops = {
 	.statfs		= hugetlbfs_statfs,
 	.put_super	= hugetlbfs_put_super,
 	.show_options	= hugetlbfs_show_options,
+	.get_fsinfo	= hugetlbfs_get_fsinfo,
 };
 
 /*
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 188c683eab14..b568e6c5e063 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -17,6 +17,7 @@
 #include <linux/namei.h>
 #include <linux/seq_file.h>
 #include <linux/exportfs.h>
+#include <linux/fsinfo.h>
 
 #include "kernfs-internal.h"
 
@@ -55,6 +56,20 @@ static int kernfs_sop_show_path(struct seq_file *sf, struct dentry *dentry)
 	return 0;
 }
 
+static int kernfs_sop_get_fsinfo(struct dentry *dentry, struct fsinfo_kparams *params)
+{
+	struct kernfs_root *root = kernfs_root(kernfs_dentry_node(dentry));
+	struct kernfs_syscall_ops *scops = root->syscall_ops;
+	int ret;
+
+	if (scops && scops->fsinfo) {
+		ret = scops->fsinfo(root, params);
+		if (ret != -EAGAIN)
+			return ret;
+	}
+	return generic_fsinfo(dentry, params);
+}
+
 const struct super_operations kernfs_sops = {
 	.statfs		= simple_statfs,
 	.drop_inode	= generic_delete_inode,
@@ -63,6 +78,7 @@ const struct super_operations kernfs_sops = {
 	.reconfigure	= kernfs_sop_reconfigure,
 	.show_options	= kernfs_sop_show_options,
 	.show_path	= kernfs_sop_show_path,
+	.get_fsinfo	= kernfs_sop_get_fsinfo,
 };
 
 /*
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 627fa3956146..9fdcdbbb67e9 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -25,6 +25,7 @@ struct seq_file;
 struct vm_area_struct;
 struct super_block;
 struct file_system_type;
+struct fsinfo_kparams;
 
 struct kernfs_fs_context;
 struct kernfs_open_node;
@@ -170,6 +171,7 @@ struct kernfs_node {
 struct kernfs_syscall_ops {
 	int (*reconfigure)(struct kernfs_root *root, struct fs_context *fc);
 	int (*show_options)(struct seq_file *sf, struct kernfs_root *root);
+	int (*fsinfo)(struct kernfs_root *root, struct fsinfo_kparams *params);
 
 	int (*mkdir)(struct kernfs_node *parent, const char *name,
 		     umode_t mode);
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index fb721aa20aa0..7a12a7876fb3 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -14,6 +14,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/cgroupstats.h>
 #include <linux/fs_parser.h>
+#include <linux/fsinfo.h>
 
 #include <trace/events/cgroup.h>
 
@@ -950,6 +951,76 @@ const struct fs_parameter_description cgroup1_fs_parameters = {
 	.no_source	= true,
 };
 
+static int cgroup1_fsinfo(struct kernfs_root *kf_root, struct fsinfo_kparams *params)
+{
+	struct cgroup_root *root = cgroup_root_from_kf(kf_root);
+	struct cgroup_subsys *ss;
+	const char *str = NULL;
+	unsigned int Mth;
+	int ret = 0, ssid;
+
+	switch (params->request) {
+	case FSINFO_ATTR_PARAMETER:
+		if (params->Mth && params->Nth != nr__cgroup1_params)
+			return -ENODATA;
+		switch (params->Nth) {
+		case Opt_all:
+			return 0;
+		case Opt_clone_children:
+			if (test_bit(CGRP_CPUSET_CLONE_CHILDREN, &root->cgrp.flags))
+				str = "clone_children";
+			goto string;
+		case Opt_cpuset_v2_mode:
+			if (root->flags & CGRP_ROOT_CPUSET_V2_MODE)
+				str = "noprefix";
+			goto string;
+		case Opt_name:
+			if (strlen(root->name))
+				return sprintf(params->buffer, "name=%s", root->name);
+			return 0;
+		case Opt_none:
+			return 0;
+		case Opt_noprefix:
+			if (root->flags & CGRP_ROOT_NOPREFIX)
+				str = "noprefix";
+			goto string;
+		case Opt_release_agent:
+			spin_lock(&release_agent_path_lock);
+			if (strlen(root->release_agent_path))
+				ret = sprintf(params->buffer, "release_agent=%s",
+					      root->release_agent_path);
+			spin_unlock(&release_agent_path_lock);
+			return ret;
+		case Opt_xattr:
+			if (root->flags & CGRP_ROOT_XATTR)
+				str = "noprefix";
+			goto string;
+		case nr__cgroup1_params:
+			Mth = params->Mth;
+			for_each_subsys(ss, ssid) {
+				if (Mth == 0) {
+					if (root->subsys_mask & (1 << ssid))
+						str = ss->legacy_name;
+					goto string;
+				}
+				Mth--;
+			}
+			return -ENODATA;
+		default:
+			return -ENODATA;
+		}
+
+	default:
+		return -EAGAIN; /* Tell kernfs to call generic_fsinfo() */
+	}
+
+string:
+	if (!str)
+		return 0;
+	strcpy(params->buffer, str);
+	return strlen(params->buffer);
+}
+
 int cgroup1_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
@@ -1140,6 +1211,7 @@ static int cgroup1_reconfigure(struct kernfs_root *kf_root, struct fs_context *f
 struct kernfs_syscall_ops cgroup1_kf_syscall_ops = {
 	.rename			= cgroup1_rename,
 	.show_options		= cgroup1_show_options,
+	.fsinfo			= cgroup1_fsinfo,
 	.reconfigure		= cgroup1_reconfigure,
 	.mkdir			= cgroup_mkdir,
 	.rmdir			= cgroup_rmdir,
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index f3238f38d152..15b976003032 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -55,6 +55,7 @@
 #include <linux/nsproxy.h>
 #include <linux/file.h>
 #include <linux/fs_parser.h>
+#include <linux/fsinfo.h>
 #include <linux/sched/cputime.h>
 #include <net/sock.h>
 
@@ -1784,6 +1785,35 @@ static int cgroup_show_options(struct seq_file *seq, struct kernfs_root *kf_root
 	return 0;
 }
 
+static int cgroup_fsinfo(struct kernfs_root *kf_root, struct fsinfo_kparams *params)
+{
+	const char *str = NULL;
+
+	switch (params->request) {
+	case FSINFO_ATTR_PARAMETER:
+		if (params->Mth)
+			return -ENODATA;
+		switch (params->Nth) {
+		case Opt_nsdelegate:
+			if (current->nsproxy->cgroup_ns == &init_cgroup_ns &&
+			    cgrp_dfl_root.flags & CGRP_ROOT_NS_DELEGATE)
+				str = "nsdelegate";
+			goto string;
+		default:
+			return -ENODATA;
+		}
+
+	default:
+		return -EAGAIN; /* Tell kernfs to call generic_fsinfo() */
+	}
+
+string:
+	if (!str)
+		return 0;
+	strcpy(params->buffer, str);
+	return strlen(params->buffer);
+}
+
 static void apply_cgroup_root_flags(unsigned int root_flags)
 {
 	if (current->nsproxy->cgroup_ns == &init_cgroup_ns) {
@@ -5248,6 +5278,7 @@ int cgroup_rmdir(struct kernfs_node *kn)
 
 static struct kernfs_syscall_ops cgroup_kf_syscall_ops = {
 	.show_options		= cgroup_show_options,
+	.fsinfo			= cgroup_fsinfo,
 	.reconfigure		= cgroup_reconfigure,
 	.mkdir			= cgroup_mkdir,
 	.rmdir			= cgroup_rmdir,
diff --git a/samples/Kconfig b/samples/Kconfig
index daa17e9f3197..82625570211a 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -148,7 +148,7 @@ config SAMPLE_VFIO_MDEV_MBOCHS
 
 config SAMPLE_STATX
 	bool "Build example extended-stat using code"
-	depends on BROKEN
+	#depends on BROKEN
 	help
 	  Build example userspace program to use the new extended-stat syscall.
 

