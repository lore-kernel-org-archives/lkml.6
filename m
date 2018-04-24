Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932854AbeDXCWQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 22:22:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:36645 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932701AbeDXCVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 22:21:15 -0400
From: jeffm@suse.com
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexey Dobriyan <adobriyan@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        Jeff Mahoney <jeffm@suse.com>
Subject: [PATCH 5/5] procfs: share fd/fdinfo with thread group leader when files are shared
Date: Mon, 23 Apr 2018 22:21:06 -0400
Message-Id: <20180424022106.16952-6-jeffm@suse.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180424022106.16952-1-jeffm@suse.com>
References: <20180424022106.16952-1-jeffm@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Mahoney <jeffm@suse.com>

When we have a single task with e.g. 4096 threads and 16k files open,
we can create over 134 million inode and dentry pairs just to back the fd
and fdinfo directories.  On smaller systems, memory pressure keeps the
number relatively contained.  On huge systems, all of these can fit
in memory.  The wasted memory is a problem, but the real problem is
what happens when that task exits.  Every task attempts to free its
own proc files, and we end up with a system that becomes unresponsive
for several minutes due to contention on the super's inode list lock.

The thing is, except for threads that have called unshare(CLONE_FILES),
the contents of every one of these directories is identical and comes
from the same files_struct.

This patch uses symbolic links to the thread group leader's fd and
fdinfo directories if the thread and the group leader have the same
files_struct.  If the thread calls unshare(CLONE_FILES), the
d_revalidate callback will bounce the symlink and the lookup will
create a directory.  If it's the thread group leader that calls
unshare, no symlinks will be used.

In the 4096 threads * 16k files case, the total procfs load is
about 600k files instead of 134M.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 fs/proc/base.c | 242 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 231 insertions(+), 11 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 005b4f8a19c2..dbdc2f9b2c58 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -122,6 +122,7 @@ struct pid_entry {
 	umode_t mode;
 	const struct inode_operations *iop;
 	const struct file_operations *fop;
+	const struct dentry_operations *dop;
 	union proc_op op;
 };
 
@@ -2438,6 +2439,7 @@ static const struct file_operations proc_pid_set_timerslack_ns_operations = {
 static int proc_pident_instantiate(struct inode *dir,
 	struct dentry *dentry, struct task_struct *task, const void *ptr)
 {
+	const struct dentry_operations *dops = &pid_dentry_operations;
 	const struct pid_entry *p = ptr;
 	struct inode *inode;
 	struct proc_inode *ei;
@@ -2454,7 +2456,9 @@ static int proc_pident_instantiate(struct inode *dir,
 	if (p->fop)
 		inode->i_fop = p->fop;
 	ei->op = p->op;
-	d_set_d_op(dentry, &pid_dentry_operations);
+	if (p->dop)
+		dops = p->dop;
+	d_set_d_op(dentry, dops);
 	d_add(dentry, inode);
 	/* Close the race of the process dying before we return the dentry */
 	if (pid_revalidate(dentry, 0))
@@ -3482,12 +3486,136 @@ static const struct inode_operations proc_tid_comm_inode_operations = {
 		.permission = proc_tid_comm_permission,
 };
 
+static const char *proc_pid_sibling_get_link(struct dentry *dentry,
+					     struct inode *inode,
+					     struct delayed_call *done)
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
+		link = kasprintf(GFP_KERNEL, "../%u/%.*s",
+				 pid_nr_ns(task_tgid(task), ns),
+				 dentry->d_name.len,
+				 dentry->d_name.name);
+		if (link)
+			set_delayed_call(done, kfree_link, link);
+		else
+			link = ERR_PTR(-ENOMEM);
+
+		put_task_struct(task);
+	}
+
+	return link;
+}
+
+static const struct inode_operations proc_pid_sibling_symlink_inode_operations = {
+	.get_link	= proc_pid_sibling_get_link,
+	.setattr	= proc_setattr,
+};
+
+static bool tasks_share_files(const struct task_struct *task)
+{
+	return task->files == task->group_leader->files;
+}
+
+static int proc_pid_files_revalidate(struct dentry *dentry, unsigned int flags)
+{
+	struct task_struct *task;
+	struct inode *inode;
+	int ret = 1;
+
+	if (flags & LOOKUP_RCU)
+		return -ECHILD;
+
+	inode = d_inode(dentry);
+	task = get_proc_task(inode);
+	if (!task)
+		return -ENOENT;
+
+	pid_revalidate_inode(inode, task);
+
+	/*
+	 * This thread called unshare(CLONE_FILES).
+	 * We need to turn it into a directory.
+	 */
+	if (!thread_group_leader(task) && (inode->i_mode & S_IFLNK) &&
+	    !tasks_share_files(task))
+		ret = 0;
+
+	put_task_struct(task);
+	return ret;
+}
+
+/*
+ * This only gets used with the symbolic links.  Once converted to a
+ * directory, there's no more work to do beyond pid_revalidate_inode, so
+ * we just use the regular pid_dentry_operations.
+ */
+const struct dentry_operations proc_pid_files_link_dentry_operations = {
+	.d_revalidate	= proc_pid_files_revalidate,
+	.d_delete	= pid_delete_dentry,
+};
+
+static const struct pid_entry proc_pid_fd_dir_entry = {
+	.name	= "fd",
+	.len	= sizeof("fd") - 1,
+	.mode	= S_IFDIR|S_IRUSR|S_IXUSR,
+	.iop	= &proc_fd_inode_operations,
+	.fop	= &proc_fd_operations,
+};
+
+static const struct pid_entry proc_pid_fd_link_entry = {
+	.name	= "fd",
+	.len	= sizeof("fd") - 1,
+	.mode	= S_IFLNK|S_IRWXUGO,
+	.iop	= &proc_pid_sibling_symlink_inode_operations,
+	.dop	= &proc_pid_files_link_dentry_operations
+};
+
+static const struct pid_entry *proc_pid_fd_pid_entry(struct task_struct *task)
+{
+	if (thread_group_leader(task) || !tasks_share_files(task))
+		return &proc_pid_fd_dir_entry;
+	else
+		return &proc_pid_fd_link_entry;
+}
+
+static const struct pid_entry proc_pid_fdinfo_dir_entry = {
+	.name	= "fdinfo",
+	.len	= sizeof("fdinfo") - 1,
+	.mode	= S_IFDIR|S_IRUSR|S_IXUSR,
+	.iop	= &proc_fdinfo_inode_operations,
+	.fop	= &proc_fdinfo_operations,
+};
+
+static const struct pid_entry proc_pid_fdinfo_link_entry = {
+	.name	= "fdinfo",
+	.len	= sizeof("fdinfo") - 1,
+	.mode	= S_IFLNK|S_IRWXUGO,
+	.iop	= &proc_pid_sibling_symlink_inode_operations,
+	.dop	= &proc_pid_files_link_dentry_operations
+};
+
+static const struct pid_entry *proc_pid_fdinfo_pid_entry(
+						struct task_struct *task)
+{
+	if (thread_group_leader(task) || !tasks_share_files(task))
+		return &proc_pid_fdinfo_dir_entry;
+	else
+		return &proc_pid_fdinfo_link_entry;
+}
+
 /*
  * Tasks
  */
 static const struct pid_entry tid_base_stuff[] = {
-	DIR("fd",        S_IRUSR|S_IXUSR, proc_fd_inode_operations, proc_fd_operations),
-	DIR("fdinfo",    S_IRUSR|S_IXUSR, proc_fdinfo_inode_operations, proc_fdinfo_operations),
 	DIR("ns",	 S_IRUSR|S_IXUGO, proc_ns_dir_inode_operations, proc_ns_dir_operations),
 #ifdef CONFIG_NET
 	DIR("net",        S_IRUGO|S_IXUGO, proc_net_inode_operations, proc_net_operations),
@@ -3579,14 +3707,71 @@ static const struct pid_entry tid_base_stuff[] = {
 
 static int proc_tid_base_readdir(struct file *file, struct dir_context *ctx)
 {
-	return proc_pident_readdir(file, ctx,
-				   tid_base_stuff, ARRAY_SIZE(tid_base_stuff));
+	const struct pid_entry *entry;
+	struct task_struct *task = get_proc_task(file_inode(file));
+	int i;
+
+	if (!task)
+		return -ENOENT;
+
+	if (!dir_emit_dots(file, ctx))
+		goto out;
+
+	if (ctx->pos == 2) {
+		entry = proc_pid_fd_pid_entry(task);
+
+		if (!proc_fill_cache_entry(file, ctx, entry, task))
+			goto out;
+		ctx->pos++;
+	}
+
+	if (ctx->pos == 3) {
+		entry = proc_pid_fdinfo_pid_entry(task);
+
+		if (!proc_fill_cache_entry(file, ctx, entry, task))
+			goto out;
+		ctx->pos++;
+	}
+
+	for (i = ctx->pos - 4; i < ARRAY_SIZE(tid_base_stuff); i++) {
+		entry = &tid_base_stuff[i];
+
+		if (!proc_fill_cache_entry(file, ctx, entry, task))
+			goto out;
+		ctx->pos++;
+	}
+
+out:
+	put_task_struct(task);
+	return 0;
 }
 
-static struct dentry *proc_tid_base_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
+static struct dentry *proc_tid_base_lookup(struct inode *dir,
+					   struct dentry *dentry,
+					   unsigned int flags)
 {
-	return proc_pident_lookup(dir, dentry,
-				  tid_base_stuff, ARRAY_SIZE(tid_base_stuff));
+	struct task_struct *task;
+	int error;
+
+	task = get_proc_task(dir);
+	if (!task)
+		return ERR_PTR(-ENOENT);
+
+	/* /proc/pid/task/pid/fd */
+	if (pid_entry_match_dentry(&proc_pid_fd_dir_entry, dentry))
+		error = proc_pident_instantiate(dir, dentry, task,
+						proc_pid_fd_pid_entry(task));
+	/* /proc/pid/task/pid/fdinfo */
+	else if (pid_entry_match_dentry(&proc_pid_fdinfo_dir_entry, dentry))
+		error = proc_pident_instantiate(dir, dentry, task,
+					proc_pid_fdinfo_pid_entry(task));
+	else
+		error = proc_pident_lookup_task(dir, dentry, tid_base_stuff,
+						ARRAY_SIZE(tid_base_stuff),
+						task);
+
+	put_task_struct(task);
+	return ERR_PTR(error);
 }
 
 static const struct file_operations proc_tid_base_operations = {
@@ -3601,6 +3786,42 @@ static const struct inode_operations proc_tid_base_inode_operations = {
 	.setattr	= proc_setattr,
 };
 
+static int proc_task_count_links(struct task_struct *task)
+{
+	int nlinks = nlink_tid;
+
+	/* Shared files: symlinks for fd and fdinfo */
+	if (!thread_group_leader(task) && tasks_share_files(task))
+		nlinks++;
+
+	return nlinks;
+}
+
+static int tid_revalidate(struct dentry *dentry, unsigned int flags)
+{
+	struct inode *inode;
+	struct task_struct *task;
+
+	if (flags & LOOKUP_RCU)
+		return -ECHILD;
+
+	inode = d_inode(dentry);
+	task = get_proc_task(inode);
+
+	if (task) {
+		pid_revalidate_inode(inode, task);
+		set_nlink(inode, proc_task_count_links(task));
+		put_task_struct(task);
+		return 1;
+	}
+	return 0;
+}
+
+static const struct dentry_operations proc_tid_dentry_operations = {
+	.d_revalidate	= tid_revalidate,
+	.d_delete	= pid_delete_dentry,
+};
+
 static int proc_task_instantiate(struct inode *dir,
 	struct dentry *dentry, struct task_struct *task, const void *ptr)
 {
@@ -3613,9 +3834,8 @@ static int proc_task_instantiate(struct inode *dir,
 	inode->i_fop = &proc_tid_base_operations;
 	inode->i_flags|=S_IMMUTABLE;
 
-	set_nlink(inode, nlink_tid);
-
-	d_set_d_op(dentry, &pid_dentry_operations);
+	set_nlink(inode, proc_task_count_links(task));
+	d_set_d_op(dentry, &proc_tid_dentry_operations);
 
 	d_add(dentry, inode);
 	/* Close the race of the process dying before we return the dentry */
-- 
2.12.3
