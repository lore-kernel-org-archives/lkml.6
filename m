Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F837C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5700208B4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5700208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388467AbeG0Sz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:55:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388886AbeG0Sz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:55:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A61EB40241CC;
        Fri, 27 Jul 2018 17:32:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5AA72026D6B;
        Fri, 27 Jul 2018 17:32:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 10/38] smack: Implement filesystem context security hooks
 [ver #10]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 Jul 2018 18:32:31 +0100
Message-ID: <153271275122.9458.5878346975276108582.stgit@warthog.procyon.org.uk>
In-Reply-To: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 27 Jul 2018 17:32:32 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 27 Jul 2018 17:32:32 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement filesystem context security hooks for the smack LSM.

Question: Should the ->fs_context_parse_source() hook be implemented to
check the labels on any source devices specified?

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Casey Schaufler <casey@schaufler-ca.com>
cc: linux-security-module@vger.kernel.org
---

 security/smack/smack.h     |   11 +
 security/smack/smack_lsm.c |  337 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 343 insertions(+), 5 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index f7db791fb566..e6d54e829394 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -195,11 +195,12 @@ struct smack_known_list_elem {
 
 enum {
 	Opt_error = -1,
-	Opt_fsdefault = 1,
-	Opt_fsfloor = 2,
-	Opt_fshat = 3,
-	Opt_fsroot = 4,
-	Opt_fstransmute = 5,
+	Opt_fsdefault = 0,
+	Opt_fsfloor = 1,
+	Opt_fshat = 2,
+	Opt_fsroot = 3,
+	Opt_fstransmute = 4,
+        nr__smack_params
 };
 
 /*
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 9811476c8441..339ac4d42785 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -42,6 +42,8 @@
 #include <linux/shm.h>
 #include <linux/binfmts.h>
 #include <linux/parser.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include "smack.h"
 
 #define TRANS_TRUE	"TRUE"
@@ -521,6 +523,334 @@ static int smack_syslog(int typefrom_file)
 	return rc;
 }
 
+/*
+ * Mount context operations
+ */
+
+struct smack_fs_context {
+	union {
+		struct {
+			char		*fsdefault;
+			char		*fsfloor;
+			char		*fshat;
+			char		*fsroot;
+			char		*fstransmute;
+		};
+		char			*ptrs[5];
+
+	};
+	struct superblock_smack		*sbsp;
+	struct inode_smack		*isp;
+	bool				transmute;
+};
+
+/**
+ * smack_fs_context_free - Free the security data from a filesystem context
+ * @fc: The filesystem context to be cleaned up.
+ */
+static void smack_fs_context_free(struct fs_context *fc)
+{
+	struct smack_fs_context *ctx = fc->security;
+	int i;
+
+	if (ctx) {
+		for (i = 0; i < ARRAY_SIZE(ctx->ptrs); i++)
+			kfree(ctx->ptrs[i]);
+		kfree(ctx->isp);
+		kfree(ctx->sbsp);
+		kfree(ctx);
+		fc->security = NULL;
+	}
+}
+
+/**
+ * smack_fs_context_alloc - Allocate security data for a filesystem context
+ * @fc: The filesystem context.
+ * @reference: Reference dentry (automount/reconfigure) or NULL
+ *
+ * Returns 0 on success or -ENOMEM on error.
+ */
+static int smack_fs_context_alloc(struct fs_context *fc,
+				  struct dentry *reference)
+{
+	struct smack_fs_context *ctx;
+	struct superblock_smack *sbsp;
+	struct inode_smack *isp;
+	struct smack_known *skp;
+
+	ctx = kzalloc(sizeof(struct smack_fs_context), GFP_KERNEL);
+	if (!ctx)
+		goto nomem;
+	fc->security = ctx;
+
+	sbsp = kzalloc(sizeof(struct superblock_smack), GFP_KERNEL);
+	if (!sbsp)
+		goto nomem_free;
+	ctx->sbsp = sbsp;
+
+	isp = new_inode_smack(NULL);
+	if (!isp)
+		goto nomem_free;
+	ctx->isp = isp;
+
+	if (reference) {
+		if (reference->d_sb->s_security)
+			memcpy(sbsp, reference->d_sb->s_security, sizeof(*sbsp));
+	} else if (!smack_privileged(CAP_MAC_ADMIN)) {
+		/* Unprivileged mounts get root and default from the caller. */
+		skp = smk_of_current();
+		sbsp->smk_root = skp;
+		sbsp->smk_default = skp;
+	} else {
+		sbsp->smk_root = &smack_known_floor;
+		sbsp->smk_default = &smack_known_floor;
+		sbsp->smk_floor = &smack_known_floor;
+		sbsp->smk_hat = &smack_known_hat;
+		/* SMK_SB_INITIALIZED will be zero from kzalloc. */
+	}
+
+	return 0;
+
+nomem_free:
+	smack_fs_context_free(fc);
+nomem:
+	return -ENOMEM;
+}
+
+/**
+ * smack_fs_context_dup - Duplicate the security data on fs_context duplication
+ * @fc: The new filesystem context.
+ * @src_fc: The source filesystem context being duplicated.
+ *
+ * Returns 0 on success or -ENOMEM on error.
+ */
+static int smack_fs_context_dup(struct fs_context *fc,
+				struct fs_context *src_fc)
+{
+	struct smack_fs_context *dst, *src = src_fc->security;
+	int i;
+
+	dst = kzalloc(sizeof(struct smack_fs_context), GFP_KERNEL);
+	if (!dst)
+		goto nomem;
+	fc->security = dst;
+
+	dst->sbsp = kmemdup(src->sbsp, sizeof(struct superblock_smack),
+			    GFP_KERNEL);
+	if (!dst->sbsp)
+		goto nomem_free;
+
+	for (i = 0; i < ARRAY_SIZE(dst->ptrs); i++) {
+		if (src->ptrs[i]) {
+			dst->ptrs[i] = kstrdup(src->ptrs[i], GFP_KERNEL);
+			if (!dst->ptrs[i])
+				goto nomem_free;
+		}
+	}
+
+	return 0;
+
+nomem_free:
+	smack_fs_context_free(fc);
+nomem:
+	return -ENOMEM;
+}
+
+static const struct fs_parameter_spec smack_param_specs[nr__smack_params] = {
+	[Opt_fsdefault]		= { fs_param_is_string },
+	[Opt_fsfloor]		= { fs_param_is_string },
+	[Opt_fshat]		= { fs_param_is_string },
+	[Opt_fsroot]		= { fs_param_is_string },
+	[Opt_fstransmute]	= { fs_param_is_string },
+};
+
+static const struct constant_table smack_param_keys[] = {
+	{ SMK_FSDEFAULT,	Opt_fsdefault },
+	{ SMK_FSFLOOR,		Opt_fsfloor },
+	{ SMK_FSHAT,		Opt_fshat },
+	{ SMK_FSROOT,		Opt_fsroot },
+	{ SMK_FSTRANS,		Opt_fstransmute },
+};
+
+static const struct fs_parameter_description smack_fs_parameters = {
+	.name		= "smack",
+	.nr_params	= nr__smack_params,
+	.nr_keys	= ARRAY_SIZE(smack_param_keys),
+	.keys		= smack_param_keys,
+	.specs		= smack_param_specs,
+};
+
+/**
+ * smack_fs_context_parse_param - Parse a single mount parameter
+ * @fc: The new filesystem context being constructed.
+ * @param: The parameter.
+ *
+ * Returns 0 on success or -ENOMEM on error.
+ */
+static int smack_fs_context_parse_param(struct fs_context *fc,
+					struct fs_parameter *param)
+{
+	struct smack_fs_context *ctx = fc->security;
+	struct fs_parse_result result;
+	int ret;
+
+	/* Unprivileged mounts don't get to specify Smack values. */
+	if (!smack_privileged(CAP_MAC_ADMIN))
+		return -EPERM;
+
+	ret = fs_parse(fc, &smack_fs_parameters, param, &result);
+	if (ret <= 0)
+		return ret; /* Note: 0 indicates no match */
+
+	switch (result.key) {
+	case Opt_fsdefault:
+		if (ctx->fsdefault)
+			goto error_dup;
+		ctx->fsdefault = param->string;
+		if (!ctx->fsdefault)
+			goto error;
+		break;
+	case Opt_fsfloor:
+		if (ctx->fsfloor)
+			goto error_dup;
+		ctx->fsfloor = param->string;
+		if (!ctx->fsfloor)
+			goto error;
+		break;
+	case Opt_fshat:
+		if (ctx->fshat)
+			goto error_dup;
+		ctx->fshat = param->string;
+		if (!ctx->fshat)
+			goto error;
+		break;
+	case Opt_fsroot:
+		if (ctx->fsroot)
+			goto error_dup;
+		ctx->fsroot = param->string;
+		if (!ctx->fsroot)
+			goto error;
+		break;
+	case Opt_fstransmute:
+		if (ctx->fstransmute)
+			goto error_dup;
+		ctx->fstransmute = param->string;
+		if (!ctx->fstransmute)
+			goto error;
+		break;
+	default:
+		pr_warn("Smack:  unknown mount option\n");
+		goto error_inval;
+	}
+
+	param->string = NULL;
+	return 0;
+
+error_dup:
+	warnf(fc, "Smack: duplicate mount option\n");
+error_inval:
+	ret = -EINVAL;
+error:
+	return ret;
+}
+
+/**
+ * smack_fs_context_validate - Validate the filesystem context security data
+ * @fc: The filesystem context.
+ *
+ * Returns 0 on success or -ENOMEM on error.
+ */
+static int smack_fs_context_validate(struct fs_context *fc)
+{
+	struct smack_fs_context *ctx = fc->security;
+	struct superblock_smack *sbsp = ctx->sbsp;
+	struct inode_smack *isp = ctx->isp;
+	struct smack_known *skp;
+
+	if (ctx->fsdefault) {
+		skp = smk_import_entry(ctx->fsdefault, 0);
+		if (IS_ERR(skp))
+			return PTR_ERR(skp);
+		sbsp->smk_default = skp;
+	}
+
+	if (ctx->fsfloor) {
+		skp = smk_import_entry(ctx->fsfloor, 0);
+		if (IS_ERR(skp))
+			return PTR_ERR(skp);
+		sbsp->smk_floor = skp;
+	}
+
+	if (ctx->fshat) {
+		skp = smk_import_entry(ctx->fshat, 0);
+		if (IS_ERR(skp))
+			return PTR_ERR(skp);
+		sbsp->smk_hat = skp;
+	}
+
+	if (ctx->fsroot || ctx->fstransmute) {
+		skp = smk_import_entry(ctx->fstransmute ?: ctx->fsroot, 0);
+		if (IS_ERR(skp))
+			return PTR_ERR(skp);
+		sbsp->smk_root = skp;
+		ctx->transmute = !!ctx->fstransmute;
+	}
+
+	isp->smk_inode = sbsp->smk_root;
+	return 0;
+}
+
+/**
+ * smack_sb_get_tree - Assign the context to a newly created superblock
+ * @fc: The new filesystem context.
+ *
+ * Returns 0 on success or -ENOMEM on error.
+ */
+static int smack_sb_get_tree(struct fs_context *fc)
+{
+	struct smack_fs_context *ctx = fc->security;
+	struct superblock_smack *sbsp = ctx->sbsp;
+	struct dentry *root = fc->root;
+	struct inode *inode = d_backing_inode(root);
+	struct super_block *sb = root->d_sb;
+	struct inode_smack *isp;
+	bool transmute = ctx->transmute;
+
+	if (sb->s_security)
+		return 0;
+
+	if (!smack_privileged(CAP_MAC_ADMIN)) {
+		/*
+		 * For a handful of fs types with no user-controlled
+		 * backing store it's okay to trust security labels
+		 * in the filesystem. The rest are untrusted.
+		 */
+		if (fc->user_ns != &init_user_ns &&
+		    sb->s_magic != SYSFS_MAGIC && sb->s_magic != TMPFS_MAGIC &&
+		    sb->s_magic != RAMFS_MAGIC) {
+			transmute = true;
+			sbsp->smk_flags |= SMK_SB_UNTRUSTED;
+		}
+	}
+
+	sbsp->smk_flags |= SMK_SB_INITIALIZED;
+	sb->s_security = sbsp;
+	ctx->sbsp = NULL;
+
+	/* Initialize the root inode. */
+	isp = inode->i_security;
+	if (isp == NULL) {
+		isp = ctx->isp;
+		ctx->isp = NULL;
+		inode->i_security = isp;
+	} else
+		isp->smk_inode = sbsp->smk_root;
+
+	if (transmute)
+		isp->smk_flags |= SMK_INODE_TRANSMUTE;
+
+	return 0;
+}
 
 /*
  * Superblock Hooks.
@@ -4649,6 +4979,13 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
 	LSM_HOOK_INIT(syslog, smack_syslog),
 
+	LSM_HOOK_INIT(fs_context_alloc, smack_fs_context_alloc),
+	LSM_HOOK_INIT(fs_context_dup, smack_fs_context_dup),
+	LSM_HOOK_INIT(fs_context_free, smack_fs_context_free),
+	LSM_HOOK_INIT(fs_context_parse_param, smack_fs_context_parse_param),
+	LSM_HOOK_INIT(fs_context_validate, smack_fs_context_validate),
+	LSM_HOOK_INIT(sb_get_tree, smack_sb_get_tree),
+
 	LSM_HOOK_INIT(sb_alloc_security, smack_sb_alloc_security),
 	LSM_HOOK_INIT(sb_free_security, smack_sb_free_security),
 	LSM_HOOK_INIT(sb_copy_data, smack_sb_copy_data),

