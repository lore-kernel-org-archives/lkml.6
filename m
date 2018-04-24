Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932838AbeDXCWN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 22:22:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:36658 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932706AbeDXCVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 22:21:15 -0400
From: jeffm@suse.com
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexey Dobriyan <adobriyan@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        Jeff Mahoney <jeffm@suse.com>
Subject: [PATCH 3/5] procfs: use symlinks for /proc/<pid>/task when not thread group leader
Date: Mon, 23 Apr 2018 22:21:04 -0400
Message-Id: <20180424022106.16952-4-jeffm@suse.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180424022106.16952-1-jeffm@suse.com>
References: <20180424022106.16952-1-jeffm@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Mahoney <jeffm@suse.com>

Although readdir only lists thread group leaders at the tgid-level of
/proc, it's possible to do a lookup to get individual threads back.  The
directory contains all of the usual tgid-level files and directories,
including task.  The task directory contains directories for every sibling
thread populated with the usual complement of files, all of which are
identical to the files contained under the tgid's own task directory.
If every thread is looked up, we'll create n^2 directories and there
is no sharing among them.  For a 3000-thread task, that becomes a pretty
big number.

This patch avoids the duplication by retaining the tgid's copy of
the task directory and converting the other threads' task directory
to a symbolic link to the tgid's copy.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 fs/proc/base.c | 123 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 116 insertions(+), 7 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index e7ca45504a5f..de12bd2137ac 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2948,7 +2948,6 @@ static const struct file_operations proc_task_operations;
 static const struct inode_operations proc_task_inode_operations;
 
 static const struct pid_entry tgid_base_stuff[] = {
-	DIR("task",       S_IRUGO|S_IXUGO, proc_task_inode_operations, proc_task_operations),
 	DIR("fd",         S_IRUSR|S_IXUSR, proc_fd_inode_operations, proc_fd_operations),
 	DIR("map_files",  S_IRUSR|S_IXUSR, proc_map_files_inode_operations, proc_map_files_operations),
 	DIR("fdinfo",     S_IRUSR|S_IXUSR, proc_fdinfo_inode_operations, proc_fdinfo_operations),
@@ -3047,10 +3046,96 @@ static const struct pid_entry tgid_base_stuff[] = {
 #endif
 };
 
+/*
+ * Don't instantiate a full duplicate of the thread leader's task
+ * directory for every member of the task group.  Just symlink to the
+ * thread leader's copy.
+ */
+static const char *proc_tgid_task_symlink_get_link(struct dentry *dentry,
+						   struct inode *inode,
+						   struct delayed_call *done)
+{
+	struct task_struct *task;
+	char *link = ERR_PTR(-ENOENT);
+
+	if (!dentry)
+		return ERR_PTR(-ECHILD);
+
+	task = get_proc_task(inode);
+	if (task) {
+		struct pid_namespace *ns = inode->i_sb->s_fs_info;
+
+		link = kasprintf(GFP_KERNEL, "../%u/task",
+				 pid_nr_ns(task_tgid(task), ns));
+		if (link)
+			set_delayed_call(done, kfree_link, link);
+		else
+			link = ERR_PTR(-ENOMEM);
+		put_task_struct(task);
+	}
+	return link;
+}
+
+static const struct inode_operations proc_task_symlink_inode_operations = {
+	.get_link	= proc_tgid_task_symlink_get_link,
+	.setattr	= proc_setattr,
+};
+
+static const struct pid_entry proc_tgid_task_symlink_entry = {
+	.name		= "task",
+	.len		= sizeof("task") - 1,
+	.mode		= S_IFLNK|S_IRWXUGO,
+	.iop		= &proc_task_symlink_inode_operations,
+};
+
+static const struct pid_entry proc_tgid_task_dir_entry = {
+	.name		= "task",
+	.len		= sizeof("task") - 1,
+	.mode		= S_IFDIR|S_IRUGO|S_IXUGO,
+	.iop		= &proc_task_inode_operations,
+	.fop		= &proc_task_operations,
+};
+
+static const struct pid_entry *proc_tgid_task_entry(struct task_struct *task)
+{
+	if (thread_group_leader(task))
+		return &proc_tgid_task_dir_entry;
+	else
+		return &proc_tgid_task_symlink_entry;
+}
+
 static int proc_tgid_base_readdir(struct file *file, struct dir_context *ctx)
 {
-	return proc_pident_readdir(file, ctx,
-				   tgid_base_stuff, ARRAY_SIZE(tgid_base_stuff));
+	const struct pid_entry *entry;
+	struct task_struct *task;
+	int i;
+
+	task = get_proc_task(file_inode(file));
+	if (!task)
+		return -ENOENT;
+
+	if (!dir_emit_dots(file, ctx))
+		goto out;
+
+	/* Add /proc/pid/task entry */
+	if (ctx->pos == 2) {
+		entry = proc_tgid_task_entry(task);
+
+		if (!proc_fill_cache_entry(file, ctx, entry, task))
+			goto out;
+		ctx->pos++;
+	}
+
+	for (i = ctx->pos - 3; i < ARRAY_SIZE(tgid_base_stuff); i++) {
+		entry = &tgid_base_stuff[i];
+
+		if (!proc_fill_cache_entry(file, ctx, entry, task))
+			goto out;
+		ctx->pos++;
+	}
+out:
+	put_task_struct(task);
+	return 0;
 }
 
 static const struct file_operations proc_tgid_base_operations = {
@@ -3059,10 +3144,29 @@ static const struct file_operations proc_tgid_base_operations = {
 	.llseek		= generic_file_llseek,
 };
 
-static struct dentry *proc_tgid_base_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
+
+static struct dentry *proc_tgid_base_lookup(struct inode *dir,
+					    struct dentry *dentry,
+					    unsigned int flags)
 {
-	return proc_pident_lookup(dir, dentry,
-				  tgid_base_stuff, ARRAY_SIZE(tgid_base_stuff));
+	struct task_struct *task;
+	int error = -ENOENT;
+
+	task = get_proc_task(dir);
+	if (!task)
+		goto out;
+
+	/* Handle /proc/pid/task separately */
+	if (pid_entry_match_dentry(&proc_tgid_task_dir_entry, dentry))
+		error = proc_pident_instantiate(dir, dentry, task,
+						proc_tgid_task_entry(task));
+	else
+		error = proc_pident_lookup_task(dir, dentry, tgid_base_stuff,
+						ARRAY_SIZE(tgid_base_stuff),
+						task);
+	put_task_struct(task);
+out:
+	return ERR_PTR(error);
 }
 
 static const struct inode_operations proc_tgid_base_inode_operations = {
@@ -3163,6 +3267,7 @@ static int proc_pid_instantiate(struct inode *dir,
 				   struct task_struct *task, const void *ptr)
 {
 	struct inode *inode;
+	int nlinks = nlink_tgid;
 
 	inode = proc_pid_make_inode(dir->i_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
 	if (!inode)
@@ -3172,7 +3277,11 @@ static int proc_pid_instantiate(struct inode *dir,
 	inode->i_fop = &proc_tgid_base_operations;
 	inode->i_flags|=S_IMMUTABLE;
 
-	set_nlink(inode, nlink_tgid);
+	/* The group leader has a directory */
+	if (thread_group_leader(task))
+		nlinks++;
+
+	set_nlink(inode, nlinks);
 
 	d_set_d_op(dentry, &pid_dentry_operations);
 
-- 
2.12.3
