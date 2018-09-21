Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E52C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F1621566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F1621566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391051AbeIUWWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:22:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390065AbeIUWWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:22:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8408B30B8FB9;
        Fri, 21 Sep 2018 16:32:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E9F07F350;
        Fri, 21 Sep 2018 16:32:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 18/34] proc: Add fs_context support to procfs [ver #12]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
Date:   Fri, 21 Sep 2018 17:32:35 +0100
Message-ID: <153754755539.17872.4886958550085541823.stgit@warthog.procyon.org.uk>
In-Reply-To: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
References: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 21 Sep 2018 16:32:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fs_context support to procfs.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/proc/inode.c    |    1 
 fs/proc/internal.h |    1 
 fs/proc/root.c     |  220 ++++++++++++++++++++++++++++++++++++----------------
 3 files changed, 151 insertions(+), 71 deletions(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 9fdda2946554..4e38156e2531 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -129,7 +129,6 @@ const struct super_operations proc_sops = {
 	.drop_inode	= generic_delete_inode,
 	.evict_inode	= proc_evict_inode,
 	.statfs		= simple_statfs,
-	.remount_fs	= proc_remount,
 	.show_options	= proc_show_options,
 };
 
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 912cb2cd29dd..40f905143d39 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -270,7 +270,6 @@ static inline void proc_tty_init(void) {}
 extern struct proc_dir_entry proc_root;
 
 extern void proc_self_init(void);
-extern int proc_remount(struct super_block *, int *, char *, size_t);
 
 /*
  * task_[no]mmu.c
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 15da85cefd3f..8912a8b57ac3 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -19,74 +19,97 @@
 #include <linux/module.h>
 #include <linux/bitops.h>
 #include <linux/user_namespace.h>
+#include <linux/fs_context.h>
 #include <linux/mount.h>
 #include <linux/pid_namespace.h>
-#include <linux/parser.h>
+#include <linux/fs_parser.h>
 #include <linux/cred.h>
 #include <linux/magic.h>
+#include <linux/slab.h>
 
 #include "internal.h"
 
-enum {
-	Opt_gid, Opt_hidepid, Opt_err,
+struct proc_fs_context {
+	struct pid_namespace	*pid_ns;
+	unsigned long		mask;
+	int			hidepid;
+	int			gid;
 };
 
-static const match_table_t tokens = {
-	{Opt_hidepid, "hidepid=%u"},
-	{Opt_gid, "gid=%u"},
-	{Opt_err, NULL},
+enum proc_param {
+	Opt_gid,
+	Opt_hidepid,
+	nr__proc_params
 };
 
-static int proc_parse_options(char *options, struct pid_namespace *pid)
+static const struct fs_parameter_spec proc_param_specs[nr__proc_params] = {
+	[Opt_gid]	= { fs_param_is_u32 },
+	[Opt_hidepid]	= { fs_param_is_u32 },
+};
+
+static const char *const proc_param_keys[nr__proc_params] = {
+	[Opt_gid]	= "gid",
+	[Opt_hidepid]	= "hidepid",
+};
+
+static const struct fs_parameter_description proc_fs_parameters = {
+	.name		= "proc",
+	.nr_params	= nr__proc_params,
+	.keys		= proc_param_keys,
+	.specs		= proc_param_specs,
+	.no_source	= true,
+};
+
+static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
-	char *p;
-	substring_t args[MAX_OPT_ARGS];
-	int option;
-
-	if (!options)
-		return 1;
-
-	while ((p = strsep(&options, ",")) != NULL) {
-		int token;
-		if (!*p)
-			continue;
-
-		args[0].to = args[0].from = NULL;
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_gid:
-			if (match_int(&args[0], &option))
-				return 0;
-			pid->pid_gid = make_kgid(current_user_ns(), option);
-			break;
-		case Opt_hidepid:
-			if (match_int(&args[0], &option))
-				return 0;
-			if (option < HIDEPID_OFF ||
-			    option > HIDEPID_INVISIBLE) {
-				pr_err("proc: hidepid value must be between 0 and 2.\n");
-				return 0;
-			}
-			pid->hide_pid = option;
-			break;
-		default:
-			pr_err("proc: unrecognized mount option \"%s\" "
-			       "or missing value\n", p);
-			return 0;
-		}
+	struct proc_fs_context *ctx = fc->fs_private;
+	struct fs_parse_result result;
+	int opt;
+
+	opt = fs_parse(fc, &proc_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_gid:
+		ctx->gid = result.uint_32;
+		break;
+
+	case Opt_hidepid:
+		ctx->hidepid = result.uint_32;
+		if (ctx->hidepid < HIDEPID_OFF ||
+		    ctx->hidepid > HIDEPID_INVISIBLE)
+			return invalf(fc, "proc: hidepid value must be between 0 and 2.\n");
+		break;
+
+	default:
+		return -EINVAL;
 	}
 
-	return 1;
+	ctx->mask |= 1 << result.key;
+	return 0;
 }
 
-static int proc_fill_super(struct super_block *s, void *data, size_t data_size, int silent)
+static void proc_apply_options(struct super_block *s,
+			       struct fs_context *fc,
+			       struct pid_namespace *pid_ns,
+			       struct user_namespace *user_ns)
 {
-	struct pid_namespace *ns = get_pid_ns(s->s_fs_info);
+	struct proc_fs_context *ctx = fc->fs_private;
+
+	if (ctx->mask & (1 << Opt_gid))
+		pid_ns->pid_gid = make_kgid(user_ns, ctx->gid);
+	if (ctx->mask & (1 << Opt_hidepid))
+		pid_ns->hide_pid = ctx->hidepid;
+}
+
+static int proc_fill_super(struct super_block *s, struct fs_context *fc)
+{
+	struct pid_namespace *pid_ns = get_pid_ns(s->s_fs_info);
 	struct inode *root_inode;
 	int ret;
 
-	if (!proc_parse_options(data, ns))
-		return -EINVAL;
+	proc_apply_options(s, fc, pid_ns, current_user_ns());
 
 	/* User space would break if executables or devices appear on proc */
 	s->s_iflags |= SB_I_USERNS_VISIBLE | SB_I_NOEXEC | SB_I_NODEV;
@@ -103,7 +126,7 @@ static int proc_fill_super(struct super_block *s, void *data, size_t data_size,
 	 * top of it
 	 */
 	s->s_stack_depth = FILESYSTEM_MAX_STACK_DEPTH;
-	
+
 	pde_get(&proc_root);
 	root_inode = proc_get_inode(s, &proc_root);
 	if (!root_inode) {
@@ -124,30 +147,61 @@ static int proc_fill_super(struct super_block *s, void *data, size_t data_size,
 	return proc_setup_thread_self(s);
 }
 
-int proc_remount(struct super_block *sb, int *flags,
-		 char *data, size_t data_size)
+static int proc_reconfigure(struct fs_context *fc)
 {
+	struct super_block *sb = fc->root->d_sb;
 	struct pid_namespace *pid = sb->s_fs_info;
 
 	sync_filesystem(sb);
-	return !proc_parse_options(data, pid);
+
+	proc_apply_options(sb, fc, pid, current_user_ns());
+	return 0;
 }
 
-static struct dentry *proc_mount(struct file_system_type *fs_type,
-				 int flags, const char *dev_name,
-				 void *data, size_t data_size)
+static int proc_get_tree(struct fs_context *fc)
 {
-	struct pid_namespace *ns;
+	struct proc_fs_context *ctx = fc->fs_private;
 
-	if (flags & SB_KERNMOUNT) {
-		ns = data;
-		data = NULL;
-	} else {
-		ns = task_active_pid_ns(current);
+	fc->s_fs_info = ctx->pid_ns;
+	return vfs_get_super(fc, vfs_get_keyed_super, proc_fill_super);
+}
+
+static void proc_fs_context_free(struct fs_context *fc)
+{
+	struct proc_fs_context *ctx = fc->fs_private;
+
+	if (ctx->pid_ns)
+		put_pid_ns(ctx->pid_ns);
+	kfree(ctx);
+}
+
+static const struct fs_context_operations proc_fs_context_ops = {
+	.free		= proc_fs_context_free,
+	.parse_param	= proc_parse_param,
+	.get_tree	= proc_get_tree,
+	.reconfigure	= proc_reconfigure,
+};
+
+static int proc_init_fs_context(struct fs_context *fc, struct dentry *reference)
+{
+	struct proc_fs_context *ctx;
+
+	switch (fc->purpose) {
+	case FS_CONTEXT_FOR_UMOUNT:
+	case FS_CONTEXT_FOR_EMERGENCY_RO:
+		return -EOPNOTSUPP;
+	default:
+		break;
 	}
 
-	return mount_ns(fs_type, flags, data, data_size, ns, ns->user_ns,
-			proc_fill_super);
+	ctx = kzalloc(sizeof(struct proc_fs_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->pid_ns = get_pid_ns(task_active_pid_ns(current));
+	fc->fs_private = ctx;
+	fc->ops = &proc_fs_context_ops;
+	return 0;
 }
 
 static void proc_kill_sb(struct super_block *sb)
@@ -164,10 +218,11 @@ static void proc_kill_sb(struct super_block *sb)
 }
 
 static struct file_system_type proc_fs_type = {
-	.name		= "proc",
-	.mount		= proc_mount,
-	.kill_sb	= proc_kill_sb,
-	.fs_flags	= FS_USERNS_MOUNT,
+	.name			= "proc",
+	.init_fs_context	= proc_init_fs_context,
+	.parameters		= &proc_fs_parameters,
+	.kill_sb		= proc_kill_sb,
+	.fs_flags		= FS_USERNS_MOUNT,
 };
 
 void __init proc_root_init(void)
@@ -205,7 +260,7 @@ static struct dentry *proc_root_lookup(struct inode * dir, struct dentry * dentr
 {
 	if (!proc_pid_lookup(dir, dentry, flags))
 		return NULL;
-	
+
 	return proc_lookup(dir, dentry, flags);
 }
 
@@ -258,9 +313,36 @@ struct proc_dir_entry proc_root = {
 
 int pid_ns_prepare_proc(struct pid_namespace *ns)
 {
+	struct proc_fs_context *ctx;
+	struct fs_context *fc;
 	struct vfsmount *mnt;
+	int ret;
+
+	fc = vfs_new_fs_context(&proc_fs_type, NULL, 0, 0,
+				FS_CONTEXT_FOR_KERNEL_MOUNT);
+	if (IS_ERR(fc))
+		return PTR_ERR(fc);
+
+	if (fc->user_ns != ns->user_ns) {
+		put_user_ns(fc->user_ns);
+		fc->user_ns = get_user_ns(ns->user_ns);
+	}
+
+	ctx = fc->fs_private;
+	if (ctx->pid_ns != ns) {
+		put_pid_ns(ctx->pid_ns);
+		get_pid_ns(ns);
+		ctx->pid_ns = ns;
+	}
+
+	ret = vfs_get_tree(fc);
+	if (ret < 0) {
+		put_fs_context(fc);
+		return ret;
+	}
 
-	mnt = kern_mount_data(&proc_fs_type, ns, 0);
+	mnt = vfs_create_mount(fc, 0);
+	put_fs_context(fc);
 	if (IS_ERR(mnt))
 		return PTR_ERR(mnt);
 

