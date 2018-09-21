Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D92BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1E021566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C1E021566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390906AbeIUW2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:28:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390873AbeIUW2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:28:09 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8C99430001D8;
        Fri, 21 Sep 2018 16:38:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A56689247;
        Fri, 21 Sep 2018 16:38:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 5/5] vfs: Implement parameter value retrieval with fsinfo()
 [ver #12]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Date:   Fri, 21 Sep 2018 17:38:26 +0100
Message-ID: <153754790645.19213.6268357372779664850.stgit@warthog.procyon.org.uk>
In-Reply-To: <153754786825.19213.16907802981157370740.stgit@warthog.procyon.org.uk>
References: <153754786825.19213.16907802981157370740.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 21 Sep 2018 16:38:28 +0000 (UTC)
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

 fs/afs/internal.h           |    1 +
 fs/afs/super.c              |   39 ++++++++++++++++++++++-
 fs/hugetlbfs/inode.c        |   66 +++++++++++++++++++++++++++++++++++++++
 fs/kernfs/mount.c           |   16 ++++++++++
 include/linux/kernfs.h      |    2 +
 include/uapi/linux/fsinfo.h |    1 +
 kernel/cgroup/cgroup-v1.c   |   72 +++++++++++++++++++++++++++++++++++++++++++
 kernel/cgroup/cgroup.c      |   31 +++++++++++++++++++
 samples/vfs/test-fs-query.c |    1 +
 9 files changed, 227 insertions(+), 2 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 7a603398b69e..2ecfa32f26ac 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -196,6 +196,7 @@ struct afs_super_info {
 	struct afs_cell		*cell;		/* The cell in which the volume resides */
 	struct afs_volume	*volume;	/* volume record */
 	bool			dyn_root;	/* True if dynamic root */
+	bool			autocell;	/* True if autocell */
 };
 
 static inline struct afs_super_info *AFS_FS_S(struct super_block *sb)
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 1fe5026b1104..14abf604e8d3 100644
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
@@ -790,6 +792,7 @@ static int afs_fsinfo(struct path *path, struct fsinfo_kparams *params)
 	struct afs_volume *volume = as->volume;
 	struct afs_cell *cell = as->cell;
 	struct afs_net *net = afs_d2net(dentry);
+	const char *str = NULL;
 	bool dyn_root = as->dyn_root;
 	int ret;
 
@@ -894,7 +897,39 @@ static int afs_fsinfo(struct path *path, struct fsinfo_kparams *params)
 		afs_put_serverlist(net, slist);
 		return ret;
 
+	case FSINFO_ATTR_PARAMETER:
+		if (params->Mth)
+			return -ENODATA;
+		switch (params->Nth) {
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
+		case Opt_autocell:
+			if (as->autocell)
+				str = "autocell";
+			goto string;
+		case Opt_dyn:
+			if (dyn_root)
+				str = "dyn";
+			goto string;
+		default:
+			return -ENODATA;
+		}
+
 	default:
 		return generic_fsinfo(path, params);
 	}
+
+string:
+	if (!str)
+		return 0;
+	strcpy(params->buffer, str);
+	return strlen(params->buffer);
 }
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 700b009af8e4..762028994f47 100644
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
@@ -947,6 +948,70 @@ static int hugetlbfs_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
+static int hugetlbfs_fsinfo(struct path *path, struct fsinfo_kparams *params)
+{
+	struct dentry *dentry = path->dentry;
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
+		return generic_fsinfo(path, params);
+	}
+}
+
 static int hugetlbfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct hugetlbfs_sb_info *sbinfo = HUGETLBFS_SB(dentry->d_sb);
@@ -1106,6 +1171,7 @@ static const struct super_operations hugetlbfs_ops = {
 	.statfs		= hugetlbfs_statfs,
 	.put_super	= hugetlbfs_put_super,
 	.show_options	= hugetlbfs_show_options,
+	.fsinfo		= hugetlbfs_fsinfo,
 };
 
 /*
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 56742632956c..1bd43f6947f3 100644
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
 
+static int kernfs_sop_fsinfo(struct path *path, struct fsinfo_kparams *params)
+{
+	struct kernfs_root *root = kernfs_root(kernfs_dentry_node(path->dentry));
+	struct kernfs_syscall_ops *scops = root->syscall_ops;
+	int ret;
+
+	if (scops && scops->fsinfo) {
+		ret = scops->fsinfo(root, params);
+		if (ret != -EAGAIN)
+			return ret;
+	}
+	return generic_fsinfo(path, params);
+}
+
 const struct super_operations kernfs_sops = {
 	.statfs		= simple_statfs,
 	.drop_inode	= generic_delete_inode,
@@ -62,6 +77,7 @@ const struct super_operations kernfs_sops = {
 
 	.show_options	= kernfs_sop_show_options,
 	.show_path	= kernfs_sop_show_path,
+	.fsinfo		= kernfs_sop_fsinfo,
 };
 
 /*
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 051709212f55..631b52861763 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -27,6 +27,7 @@ struct vm_area_struct;
 struct super_block;
 struct file_system_type;
 struct fs_context;
+struct fsinfo_kparams;
 
 struct kernfs_fs_context;
 struct kernfs_open_node;
@@ -172,6 +173,7 @@ struct kernfs_node {
 struct kernfs_syscall_ops {
 	int (*reconfigure)(struct kernfs_root *root, struct fs_context *fc);
 	int (*show_options)(struct seq_file *sf, struct kernfs_root *root);
+	int (*fsinfo)(struct kernfs_root *root, struct fsinfo_kparams *params);
 
 	int (*mkdir)(struct kernfs_node *parent, const char *name,
 		     umode_t mode);
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index ec2ff86f49ce..50e6cd50fe63 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -265,6 +265,7 @@ enum fsinfo_param_specification_type {
 	FSINFO_PARAM_SPEC_IS_U32_OCTAL,
 	FSINFO_PARAM_SPEC_IS_U32_HEX,
 	FSINFO_PARAM_SPEC_IS_S32,
+	FSINFO_PARAM_SPEC_IS_U64,
 	FSINFO_PARAM_SPEC_IS_ENUM,
 	FSINFO_PARAM_SPEC_IS_STRING,
 	FSINFO_PARAM_SPEC_IS_BLOB,
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index d5ae888b8c57..d20128d00fbe 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -14,6 +14,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/cgroupstats.h>
 #include <linux/fs_parser.h>
+#include <linux/fsinfo.h>
 
 #include <trace/events/cgroup.h>
 
@@ -948,6 +949,76 @@ const struct fs_parameter_description cgroup1_fs_parameters = {
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
@@ -1138,6 +1209,7 @@ static int cgroup1_reconfigure(struct kernfs_root *kf_root, struct fs_context *f
 struct kernfs_syscall_ops cgroup1_kf_syscall_ops = {
 	.rename			= cgroup1_rename,
 	.show_options		= cgroup1_show_options,
+	.fsinfo			= cgroup1_fsinfo,
 	.reconfigure		= cgroup1_reconfigure,
 	.mkdir			= cgroup_mkdir,
 	.rmdir			= cgroup_rmdir,
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 3c3c40cad257..6d147377d318 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -55,6 +55,7 @@
 #include <linux/nsproxy.h>
 #include <linux/file.h>
 #include <linux/fs_parser.h>
+#include <linux/fsinfo.h>
 #include <linux/sched/cputime.h>
 #include <net/sock.h>
 
@@ -1786,6 +1787,35 @@ static int cgroup_show_options(struct seq_file *seq, struct kernfs_root *kf_root
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
@@ -5260,6 +5290,7 @@ int cgroup_rmdir(struct kernfs_node *kn)
 
 static struct kernfs_syscall_ops cgroup_kf_syscall_ops = {
 	.show_options		= cgroup_show_options,
+	.fsinfo			= cgroup_fsinfo,
 	.reconfigure		= cgroup_reconfigure,
 	.mkdir			= cgroup_mkdir,
 	.rmdir			= cgroup_rmdir,
diff --git a/samples/vfs/test-fs-query.c b/samples/vfs/test-fs-query.c
index 25c69d0df084..511541d12b9e 100644
--- a/samples/vfs/test-fs-query.c
+++ b/samples/vfs/test-fs-query.c
@@ -46,6 +46,7 @@ static const char *param_types[NR__FSINFO_PARAM_SPEC] = {
 	[FSINFO_PARAM_SPEC_IS_U32_OCTAL]	= "octal",
 	[FSINFO_PARAM_SPEC_IS_U32_HEX]		= "hex",
 	[FSINFO_PARAM_SPEC_IS_S32]		= "s32",
+	[FSINFO_PARAM_SPEC_IS_U64]		= "u64",
 	[FSINFO_PARAM_SPEC_IS_ENUM]		= "enum",
 	[FSINFO_PARAM_SPEC_IS_STRING]		= "string",
 	[FSINFO_PARAM_SPEC_IS_BLOB]		= "binary",

