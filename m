Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD94AC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E717208B6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E717208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389631AbeG0S4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:56:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388563AbeG0S4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:56:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C0242406E8CB;
        Fri, 27 Jul 2018 17:33:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D1101C5B9;
        Fri, 27 Jul 2018 17:33:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 18/38] proc: Add fs_context support to procfs [ver #10]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 Jul 2018 18:33:23 +0100
Message-ID: <153271280354.9458.5335032487534270748.stgit@warthog.procyon.org.uk>
In-Reply-To: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 27 Jul 2018 17:33:25 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 27 Jul 2018 17:33:25 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fs_context support to procfs.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/proc/inode.c    |    2 
 fs/proc/internal.h |    2 
 fs/proc/root.c     |  209 +++++++++++++++++++++++++++++++++++-----------------
 3 files changed, 141 insertions(+), 72 deletions(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index c5e7bbf81e10..38155bec4a54 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -127,7 +127,7 @@ const struct super_operations proc_sops = {
 	.drop_inode	= generic_delete_inode,
 	.evict_inode	= proc_evict_inode,
 	.statfs		= simple_statfs,
-	.remount_fs	= proc_remount,
+	.reconfigure	= proc_reconfigure,
 	.show_options	= proc_show_options,
 };
 
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index bfe2bea2c71d..ea8c5468eafc 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -273,7 +273,7 @@ static inline void proc_tty_init(void) {}
 extern struct proc_dir_entry proc_root;
 
 extern void proc_self_init(void);
-extern int proc_remount(struct super_block *, int *, char *, size_t);
+extern int proc_reconfigure(struct super_block *, struct fs_context *);
 
 /*
  * task_[no]mmu.c
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 15da85cefd3f..662ce77eaeb7 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -19,74 +19,98 @@
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
+static const struct constant_table proc_param_keys[] = {
+	{ "gid",	Opt_gid },
+	{ "hidepid",	Opt_hidepid },
+};
+
+static const struct fs_parameter_description proc_fs_parameters = {
+	.name		= "proc",
+	.nr_params	= nr__proc_params,
+	.nr_keys	= ARRAY_SIZE(proc_param_keys),
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
+	int ret;
+
+	ret = fs_parse(fc, &proc_fs_parameters, param, &result);
+	if (ret <= 0)
+		return ret;
+
+	switch (result.key) {
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
+}
+
+static void proc_apply_options(struct super_block *s,
+			       struct fs_context *fc,
+			       struct pid_namespace *pid_ns,
+			       struct user_namespace *user_ns)
+{
+	struct proc_fs_context *ctx = fc->fs_private;
+
+	if (ctx->mask & (1 << Opt_gid))
+		pid_ns->pid_gid = make_kgid(user_ns, ctx->gid);
+	if (ctx->mask & (1 << Opt_hidepid))
+		pid_ns->hide_pid = ctx->hidepid;
 }
 
-static int proc_fill_super(struct super_block *s, void *data, size_t data_size, int silent)
+static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 {
-	struct pid_namespace *ns = get_pid_ns(s->s_fs_info);
+	struct pid_namespace *pid_ns = get_pid_ns(s->s_fs_info);
 	struct inode *root_inode;
 	int ret;
 
-	if (!proc_parse_options(data, ns))
-		return -EINVAL;
+	proc_apply_options(s, fc, pid_ns, current_user_ns());
 
 	/* User space would break if executables or devices appear on proc */
 	s->s_iflags |= SB_I_USERNS_VISIBLE | SB_I_NOEXEC | SB_I_NODEV;
@@ -103,7 +127,7 @@ static int proc_fill_super(struct super_block *s, void *data, size_t data_size,
 	 * top of it
 	 */
 	s->s_stack_depth = FILESYSTEM_MAX_STACK_DEPTH;
-	
+
 	pde_get(&proc_root);
 	root_inode = proc_get_inode(s, &proc_root);
 	if (!root_inode) {
@@ -124,30 +148,52 @@ static int proc_fill_super(struct super_block *s, void *data, size_t data_size,
 	return proc_setup_thread_self(s);
 }
 
-int proc_remount(struct super_block *sb, int *flags,
-		 char *data, size_t data_size)
+int proc_reconfigure(struct super_block *sb, struct fs_context *fc)
 {
 	struct pid_namespace *pid = sb->s_fs_info;
 
 	sync_filesystem(sb);
-	return !proc_parse_options(data, pid);
+
+	if (fc)
+		proc_apply_options(sb, fc, pid, current_user_ns());
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
-	}
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
+};
 
-	return mount_ns(fs_type, flags, data, data_size, ns, ns->user_ns,
-			proc_fill_super);
+static int proc_init_fs_context(struct fs_context *fc, struct dentry *reference)
+{
+	struct proc_fs_context *ctx;
+
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
@@ -164,10 +210,11 @@ static void proc_kill_sb(struct super_block *sb)
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
@@ -205,7 +252,7 @@ static struct dentry *proc_root_lookup(struct inode * dir, struct dentry * dentr
 {
 	if (!proc_pid_lookup(dir, dentry, flags))
 		return NULL;
-	
+
 	return proc_lookup(dir, dentry, flags);
 }
 
@@ -258,9 +305,31 @@ struct proc_dir_entry proc_root = {
 
 int pid_ns_prepare_proc(struct pid_namespace *ns)
 {
+	struct proc_fs_context *ctx;
+	struct fs_context *fc;
 	struct vfsmount *mnt;
+	int ret;
+
+	fc = vfs_new_fs_context(&proc_fs_type, NULL, 0,
+				FS_CONTEXT_FOR_KERNEL_MOUNT);
+	if (IS_ERR(fc))
+		return PTR_ERR(fc);
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
 

