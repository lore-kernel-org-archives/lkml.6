Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E45C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FD0208B4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1FD0208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389479AbeG0SzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:55:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388886AbeG0SzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:55:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 14D194219DCA;
        Fri, 27 Jul 2018 17:32:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 86E4C2026D6B;
        Fri, 27 Jul 2018 17:32:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 09/38] selinux: Implement the new mount API LSM hooks [ver
 #10]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org,
        torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 Jul 2018 18:32:23 +0100
Message-ID: <153271274305.9458.13602378603425233117.stgit@warthog.procyon.org.uk>
In-Reply-To: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 27 Jul 2018 17:32:26 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 27 Jul 2018 17:32:26 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the new mount API LSM hooks for SELinux.  At some point the old
hooks will need to be removed.

Question: Should the ->fs_context_parse_source() hook be implemented to
check the labels on any source devices specified?

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paul Moore <paul@paul-moore.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov
cc: linux-security-module@vger.kernel.org
---

 security/selinux/hooks.c |  290 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 290 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ef0428311a5c..9774d1f0e99f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -48,6 +48,8 @@
 #include <linux/fdtable.h>
 #include <linux/namei.h>
 #include <linux/mount.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv6.h>
 #include <linux/tty.h>
@@ -446,6 +448,7 @@ enum {
 	Opt_rootcontext = 4,
 	Opt_labelsupport = 5,
 	Opt_nextmntopt = 6,
+	nr__selinux_params
 };
 
 #define NUM_SEL_MNT_OPTS	(Opt_nextmntopt - 1)
@@ -2974,6 +2977,285 @@ static int selinux_umount(struct vfsmount *mnt, int flags)
 				   FILESYSTEM__UNMOUNT, NULL);
 }
 
+/* fsopen mount context operations */
+
+static int selinux_fs_context_alloc(struct fs_context *fc,
+				    struct dentry *reference)
+{
+	struct security_mnt_opts *opts;
+
+	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
+	if (!opts)
+		return -ENOMEM;
+
+	fc->security = opts;
+	return 0;
+}
+
+static int selinux_fs_context_dup(struct fs_context *fc,
+				  struct fs_context *src_fc)
+{
+	const struct security_mnt_opts *src = src_fc->security;
+	struct security_mnt_opts *opts;
+	int i, n;
+
+	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
+	if (!opts)
+		return -ENOMEM;
+	fc->security = opts;
+
+	if (!src || !src->num_mnt_opts)
+		return 0;
+	n = opts->num_mnt_opts = src->num_mnt_opts;
+
+	if (src->mnt_opts) {
+		opts->mnt_opts = kcalloc(n, sizeof(char *), GFP_KERNEL);
+		if (!opts->mnt_opts)
+			return -ENOMEM;
+
+		for (i = 0; i < n; i++) {
+			if (src->mnt_opts[i]) {
+				opts->mnt_opts[i] = kstrdup(src->mnt_opts[i],
+							    GFP_KERNEL);
+				if (!opts->mnt_opts[i])
+					return -ENOMEM;
+			}
+		}
+	}
+
+	if (src->mnt_opts_flags) {
+		opts->mnt_opts_flags = kmemdup(src->mnt_opts_flags,
+					       n * sizeof(int), GFP_KERNEL);
+		if (!opts->mnt_opts_flags)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void selinux_fs_context_free(struct fs_context *fc)
+{
+	struct security_mnt_opts *opts = fc->security;
+
+	if (opts) {
+		security_free_mnt_opts(opts);
+		fc->security = NULL;
+	}
+}
+
+static const struct fs_parameter_spec selinux_param_specs[nr__selinux_params] = {
+	[Opt_context]		= { fs_param_is_string },
+	[Opt_defcontext]	= { fs_param_is_string },
+	[Opt_fscontext]		= { fs_param_is_string },
+	[Opt_labelsupport]	= { fs_param_takes_no_value },
+	[Opt_rootcontext]	= { fs_param_is_string },
+};
+
+static const struct constant_table selinux_param_keys[] = {
+	{ CONTEXT_STR,		Opt_context },
+	{ DEFCONTEXT_STR,	Opt_defcontext },
+	{ FSCONTEXT_STR,	Opt_fscontext },
+	{ ROOTCONTEXT_STR,	Opt_rootcontext },
+	{ LABELSUPP_STR,	Opt_labelsupport },
+};
+
+static const struct fs_parameter_description selinux_fs_parameters = {
+	.name		= "SELinux",
+	.nr_params	= nr__selinux_params,
+	.nr_keys	= ARRAY_SIZE(selinux_param_keys),
+	.keys		= selinux_param_keys,
+	.specs		= selinux_param_specs,
+	.ignore_unknown	= true,
+};
+
+static int selinux_fs_context_parse_param(struct fs_context *fc,
+					  struct fs_parameter *param)
+{
+	struct security_mnt_opts *opts = fc->security;
+	struct fs_parse_result result;
+	unsigned int have;
+	char **oo;
+	int ret, ctx, i, *of;
+
+	ret = fs_parse(fc, &selinux_fs_parameters, param, &result);
+	if (ret <= 0)
+		return ret; /* Note: 0 indicates no match */
+
+	have = 0;
+	for (i = 0; i < opts->num_mnt_opts; i++)
+		have |= 1 << opts->mnt_opts_flags[i];
+	if (have & (1 << result.key))
+		return -EINVAL;
+
+	switch (result.key) {
+	case Opt_context:
+		if (have & (1 << Opt_defcontext))
+			goto incompatible;
+		ctx = CONTEXT_MNT;
+		goto copy_context_string;
+
+	case Opt_fscontext:
+		ctx = FSCONTEXT_MNT;
+		goto copy_context_string;
+
+	case Opt_rootcontext:
+		ctx = ROOTCONTEXT_MNT;
+		goto copy_context_string;
+
+	case Opt_defcontext:
+		if (have & (1 << Opt_context))
+			goto incompatible;
+		ctx = DEFCONTEXT_MNT;
+		goto copy_context_string;
+
+	case Opt_labelsupport:
+		return 1;
+
+	default:
+		return -EINVAL;
+	}
+
+copy_context_string:
+	if (opts->num_mnt_opts > 3)
+		return -EINVAL;
+
+	of = krealloc(opts->mnt_opts_flags,
+		      (opts->num_mnt_opts + 1) * sizeof(int), GFP_KERNEL);
+	if (!of)
+		return -ENOMEM;
+	of[opts->num_mnt_opts] = 0;
+	opts->mnt_opts_flags = of;
+
+	oo = krealloc(opts->mnt_opts,
+		      (opts->num_mnt_opts + 1) * sizeof(char *), GFP_KERNEL);
+	if (!oo)
+		return -ENOMEM;
+	oo[opts->num_mnt_opts] = NULL;
+	opts->mnt_opts = oo;
+
+	opts->mnt_opts[opts->num_mnt_opts] = param->string;
+	opts->mnt_opts_flags[opts->num_mnt_opts] = ctx;
+	opts->num_mnt_opts++;
+	param->string = NULL;
+	return 1;
+
+incompatible:
+	return -EINVAL;
+}
+
+/*
+ * Validate the security parameters supplied for a reconfiguration/remount
+ * event.
+ */
+static int selinux_validate_for_sb_reconfigure(struct fs_context *fc)
+{
+	struct super_block *sb = fc->root->d_sb;
+	struct superblock_security_struct *sbsec = sb->s_security;
+	struct security_mnt_opts *opts = fc->security;
+	int rc, i, *flags;
+	char **mount_options;
+
+	if (!(sbsec->flags & SE_SBINITIALIZED))
+		return 0;
+
+	mount_options = opts->mnt_opts;
+	flags = opts->mnt_opts_flags;
+
+	for (i = 0; i < opts->num_mnt_opts; i++) {
+		u32 sid;
+
+		if (flags[i] == SBLABEL_MNT)
+			continue;
+
+		rc = security_context_str_to_sid(&selinux_state, mount_options[i],
+						 &sid, GFP_KERNEL);
+		if (rc) {
+			pr_warn("SELinux: security_context_str_to_sid"
+				"(%s) failed for (dev %s, type %s) errno=%d\n",
+				mount_options[i], sb->s_id, sb->s_type->name, rc);
+			goto inval;
+		}
+
+		switch (flags[i]) {
+		case FSCONTEXT_MNT:
+			if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid, sid))
+				goto bad_option;
+			break;
+		case CONTEXT_MNT:
+			if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid, sid))
+				goto bad_option;
+			break;
+		case ROOTCONTEXT_MNT: {
+			struct inode_security_struct *root_isec;
+			root_isec = backing_inode_security(sb->s_root);
+
+			if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid, sid))
+				goto bad_option;
+			break;
+		}
+		case DEFCONTEXT_MNT:
+			if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid, sid))
+				goto bad_option;
+			break;
+		default:
+			goto inval;
+		}
+	}
+
+	rc = 0;
+out:
+	return rc;
+
+bad_option:
+	pr_warn("SELinux: unable to change security options "
+		"during remount (dev %s, type=%s)\n",
+		sb->s_id, sb->s_type->name);
+inval:
+	rc = -EINVAL;
+	goto out;
+}
+
+/*
+ * Validate the security context assembled from the option data supplied to
+ * mount.
+ */
+static int selinux_fs_context_validate(struct fs_context *fc)
+{
+	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE)
+		return selinux_validate_for_sb_reconfigure(fc);
+	return 0;
+}
+
+/*
+ * Set the security context on a superblock.
+ */
+static int selinux_sb_get_tree(struct fs_context *fc)
+{
+	const struct cred *cred = current_cred();
+	struct common_audit_data ad;
+	int rc;
+
+	rc = selinux_set_mnt_opts(fc->root->d_sb, fc->security, 0, NULL);
+	if (rc)
+		return rc;
+
+	/* Allow all mounts performed by the kernel */
+	if (fc->purpose == FS_CONTEXT_FOR_KERNEL_MOUNT)
+		return 0;
+
+	ad.type = LSM_AUDIT_DATA_DENTRY;
+	ad.u.dentry = fc->root;
+	return superblock_has_perm(cred, fc->root->d_sb, FILESYSTEM__MOUNT, &ad);
+}
+
+static int selinux_sb_mountpoint(struct fs_context *fc, struct path *mountpoint,
+				 unsigned int mnt_flags)
+{
+	const struct cred *cred = current_cred();
+
+	return path_has_perm(cred, mountpoint, FILE__MOUNTON);
+}
+
 /* inode security operations */
 
 static int selinux_inode_alloc_security(struct inode *inode)
@@ -6906,6 +7188,14 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(bprm_committing_creds, selinux_bprm_committing_creds),
 	LSM_HOOK_INIT(bprm_committed_creds, selinux_bprm_committed_creds),
 
+	LSM_HOOK_INIT(fs_context_alloc, selinux_fs_context_alloc),
+	LSM_HOOK_INIT(fs_context_dup, selinux_fs_context_dup),
+	LSM_HOOK_INIT(fs_context_free, selinux_fs_context_free),
+	LSM_HOOK_INIT(fs_context_parse_param, selinux_fs_context_parse_param),
+	LSM_HOOK_INIT(fs_context_validate, selinux_fs_context_validate),
+	LSM_HOOK_INIT(sb_get_tree, selinux_sb_get_tree),
+	LSM_HOOK_INIT(sb_mountpoint, selinux_sb_mountpoint),
+
 	LSM_HOOK_INIT(sb_alloc_security, selinux_sb_alloc_security),
 	LSM_HOOK_INIT(sb_free_security, selinux_sb_free_security),
 	LSM_HOOK_INIT(sb_copy_data, selinux_sb_copy_data),

