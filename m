Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932818AbeDXCVz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 22:21:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:36671 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932721AbeDXCVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 22:21:16 -0400
From: jeffm@suse.com
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexey Dobriyan <adobriyan@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        Jeff Mahoney <jeffm@suse.com>
Subject: [PATCH 4/5] procfs: share common directories between /proc/tgid and /proc/tgid/task/tgid
Date: Mon, 23 Apr 2018 22:21:05 -0400
Message-Id: <20180424022106.16952-5-jeffm@suse.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180424022106.16952-1-jeffm@suse.com>
References: <20180424022106.16952-1-jeffm@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Mahoney <jeffm@suse.com>

The contents of /proc/tgid and /proc/tgid/task/tgid are nearly identical
but aren't.  There are files (or directory) contained in only one or
the other.  Therefore, we can't replace one with a symbolic link.
Creating links for the common files doesn't gain us anything since we'll
still need the dentries and inodes for them.  What we can do is create
links for the common subdirectories so the files below them are shared.

This patch converts the fd, fdinfo, ns, net, and attr directories at the
/proc/tgid level to symbolic links that point to the directories in
/proc/tgid/task/pid .

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 fs/proc/base.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index de12bd2137ac..005b4f8a19c2 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -140,6 +140,9 @@ struct pid_entry {
 	NOD(NAME, (S_IFLNK|S_IRWXUGO),				\
 		&proc_pid_link_inode_operations, NULL,		\
 		{ .proc_get_link = get_link } )
+#define TASKLNK(NAME)						\
+	NOD(NAME, (S_IFLNK|S_IRWXUGO),				\
+		&proc_tgid_to_pid_link_inode_operations, NULL, {})
 #define REG(NAME, MODE, fops)				\
 	NOD(NAME, (S_IFREG|(MODE)), NULL, &fops, {})
 #define ONE(NAME, MODE, show)				\
@@ -2941,6 +2944,37 @@ static int proc_pid_patch_state(struct seq_file *m, struct pid_namespace *ns,
 }
 #endif /* CONFIG_LIVEPATCH */
 
+static const char *proc_tgid_to_pid_symlink_get_link(struct dentry *dentry,
+						     struct inode *inode,
+						     struct delayed_call *done)
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
+		link = kasprintf(GFP_KERNEL, "task/%u/%.*s",
+				 pid_nr_ns(PROC_I(inode)->pid, ns),
+				 dentry->d_name.len, dentry->d_name.name);
+		if (link)
+			set_delayed_call(done, kfree_link, link);
+		else
+			link = ERR_PTR(-ENOMEM);
+		put_task_struct(task);
+	}
+	return link;
+}
+
+static const struct inode_operations proc_tgid_to_pid_link_inode_operations = {
+	.get_link	= proc_tgid_to_pid_symlink_get_link,
+	.setattr	= proc_setattr,
+};
+
 /*
  * Thread groups
  */
@@ -2948,12 +2982,12 @@ static const struct file_operations proc_task_operations;
 static const struct inode_operations proc_task_inode_operations;
 
 static const struct pid_entry tgid_base_stuff[] = {
-	DIR("fd",         S_IRUSR|S_IXUSR, proc_fd_inode_operations, proc_fd_operations),
+	TASKLNK("fd"),
 	DIR("map_files",  S_IRUSR|S_IXUSR, proc_map_files_inode_operations, proc_map_files_operations),
-	DIR("fdinfo",     S_IRUSR|S_IXUSR, proc_fdinfo_inode_operations, proc_fdinfo_operations),
-	DIR("ns",	  S_IRUSR|S_IXUGO, proc_ns_dir_inode_operations, proc_ns_dir_operations),
+	TASKLNK("fdinfo"),
+	TASKLNK("ns"),
 #ifdef CONFIG_NET
-	DIR("net",        S_IRUGO|S_IXUGO, proc_net_inode_operations, proc_net_operations),
+	TASKLNK("net"),
 #endif
 	REG("environ",    S_IRUSR, proc_environ_operations),
 	REG("auxv",       S_IRUSR, proc_auxv_operations),
@@ -2991,7 +3025,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 	REG("pagemap",    S_IRUSR, proc_pagemap_operations),
 #endif
 #ifdef CONFIG_SECURITY
-	DIR("attr",       S_IRUGO|S_IXUGO, proc_attr_dir_inode_operations, proc_attr_dir_operations),
+	TASKLNK("attr"),
 #endif
 #ifdef CONFIG_KALLSYMS
 	ONE("wchan",      S_IRUGO, proc_pid_wchan),
-- 
2.12.3
