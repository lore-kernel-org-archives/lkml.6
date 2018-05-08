Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933121AbeEHSMY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:12:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:54041 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755815AbeEHSGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:06:14 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 59/76] fs/proc: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:19 -0700
Message-Id: <20180508180436.716-60-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/proc/array.c       |  2 +-
 fs/proc/base.c        | 22 ++++++++++++----------
 fs/proc/fd.c          |  4 ++--
 fs/proc/generic.c     |  2 +-
 fs/proc/namespaces.c  |  2 +-
 fs/proc/nommu.c       |  2 +-
 fs/proc/proc_sysctl.c |  4 ++--
 fs/proc/self.c        |  2 +-
 fs/proc/task_mmu.c    |  2 +-
 fs/proc/task_nommu.c  |  2 +-
 fs/proc/thread_self.c |  2 +-
 11 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 598803576e4c..e7a668a89caf 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -687,7 +687,7 @@ static int children_seq_show(struct seq_file *seq, void *v)
 	struct inode *inode = seq->private;
 	pid_t pid;
 
-	pid = pid_nr_ns(v, inode->i_sb->s_fs_info);
+	pid = pid_nr_ns(v, inode_sb(inode)->s_fs_info);
 	seq_printf(seq, "%d ", pid);
 
 	return 0;
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9298324325ed..a39fdd56f5d9 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -698,7 +698,7 @@ static bool has_pid_permissions(struct pid_namespace *pid,
 
 static int proc_pid_permission(struct inode *inode, int mask)
 {
-	struct pid_namespace *pid = inode->i_sb->s_fs_info;
+	struct pid_namespace *pid = inode_sb(inode)->s_fs_info;
 	struct task_struct *task;
 	bool has_perms;
 
@@ -738,7 +738,7 @@ static int proc_single_show(struct seq_file *m, void *v)
 	struct task_struct *task;
 	int ret;
 
-	ns = inode->i_sb->s_fs_info;
+	ns = inode_sb(inode)->s_fs_info;
 	pid = proc_pid(inode);
 	task = get_pid_task(pid, PIDTYPE_PID);
 	if (!task)
@@ -1410,7 +1410,7 @@ static const struct file_operations proc_fail_nth_operations = {
 static int sched_show(struct seq_file *m, void *v)
 {
 	struct inode *inode = m->private;
-	struct pid_namespace *ns = inode->i_sb->s_fs_info;
+	struct pid_namespace *ns = inode_sb(inode)->s_fs_info;
 	struct task_struct *p;
 
 	p = get_proc_task(inode);
@@ -2065,7 +2065,7 @@ proc_map_files_instantiate(struct inode *dir, struct dentry *dentry,
 	struct proc_inode *ei;
 	struct inode *inode;
 
-	inode = proc_pid_make_inode(dir->i_sb, task, S_IFLNK |
+	inode = proc_pid_make_inode(inode_sb(dir), task, S_IFLNK |
 				    ((mode & FMODE_READ ) ? S_IRUSR : 0) |
 				    ((mode & FMODE_WRITE) ? S_IWUSR : 0));
 	if (!inode)
@@ -2327,7 +2327,7 @@ static int proc_timers_open(struct inode *inode, struct file *file)
 		return -ENOMEM;
 
 	tp->pid = proc_pid(inode);
-	tp->ns = inode->i_sb->s_fs_info;
+	tp->ns = inode_sb(inode)->s_fs_info;
 	return 0;
 }
 
@@ -2432,7 +2432,7 @@ static int proc_pident_instantiate(struct inode *dir,
 	struct inode *inode;
 	struct proc_inode *ei;
 
-	inode = proc_pid_make_inode(dir->i_sb, task, p->mode);
+	inode = proc_pid_make_inode(inode_sb(dir), task, p->mode);
 	if (!inode)
 		goto out;
 
@@ -3137,7 +3137,8 @@ static int proc_pid_instantiate(struct inode *dir,
 {
 	struct inode *inode;
 
-	inode = proc_pid_make_inode(dir->i_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
+	inode = proc_pid_make_inode(inode_sb(dir), task,
+				    S_IFDIR | S_IRUGO | S_IXUGO);
 	if (!inode)
 		goto out;
 
@@ -3232,7 +3233,7 @@ static struct tgid_iter next_tgid(struct pid_namespace *ns, struct tgid_iter ite
 int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct tgid_iter iter;
-	struct pid_namespace *ns = file_inode(file)->i_sb->s_fs_info;
+	struct pid_namespace *ns = inode_sb(file_inode(file))->s_fs_info;
 	loff_t pos = ctx->pos;
 
 	if (pos >= PID_MAX_LIMIT + TGID_OFFSET)
@@ -3435,7 +3436,8 @@ static int proc_task_instantiate(struct inode *dir,
 	struct dentry *dentry, struct task_struct *task, const void *ptr)
 {
 	struct inode *inode;
-	inode = proc_pid_make_inode(dir->i_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
+	inode = proc_pid_make_inode(inode_sb(dir), task,
+				    S_IFDIR | S_IRUGO | S_IXUGO);
 
 	if (!inode)
 		goto out;
@@ -3584,7 +3586,7 @@ static int proc_task_readdir(struct file *file, struct dir_context *ctx)
 	/* f_version caches the tgid value that the last readdir call couldn't
 	 * return. lseek aka telldir automagically resets f_version to 0.
 	 */
-	ns = inode->i_sb->s_fs_info;
+	ns = inode_sb(inode)->s_fs_info;
 	tid = (int)file->f_version;
 	file->f_version = 0;
 	for (task = first_tid(proc_pid(inode), tid, ctx->pos - 2, ns);
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 6b80cd1e419a..818fe341c3e7 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -174,7 +174,7 @@ proc_fd_instantiate(struct inode *dir, struct dentry *dentry,
 	struct proc_inode *ei;
 	struct inode *inode;
 
-	inode = proc_pid_make_inode(dir->i_sb, task, S_IFLNK);
+	inode = proc_pid_make_inode(inode_sb(dir), task, S_IFLNK);
 	if (!inode)
 		goto out;
 
@@ -312,7 +312,7 @@ proc_fdinfo_instantiate(struct inode *dir, struct dentry *dentry,
 	struct proc_inode *ei;
 	struct inode *inode;
 
-	inode = proc_pid_make_inode(dir->i_sb, task, S_IFREG | S_IRUSR);
+	inode = proc_pid_make_inode(inode_sb(dir), task, S_IFREG | S_IRUSR);
 	if (!inode)
 		goto out;
 
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 5d709fa8f3a2..9da0c07329ea 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -221,7 +221,7 @@ struct dentry *proc_lookup_de(struct inode *dir, struct dentry *dentry,
 	if (de) {
 		pde_get(de);
 		read_unlock(&proc_subdir_lock);
-		inode = proc_get_inode(dir->i_sb, de);
+		inode = proc_get_inode(inode_sb(dir), de);
 		if (!inode)
 			return ERR_PTR(-ENOMEM);
 		d_set_d_op(dentry, &simple_dentry_operations);
diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
index 59b17e509f46..3d624af32bb2 100644
--- a/fs/proc/namespaces.c
+++ b/fs/proc/namespaces.c
@@ -94,7 +94,7 @@ static int proc_ns_instantiate(struct inode *dir,
 	struct inode *inode;
 	struct proc_inode *ei;
 
-	inode = proc_pid_make_inode(dir->i_sb, task, S_IFLNK | S_IRWXUGO);
+	inode = proc_pid_make_inode(inode_sb(dir), task, S_IFLNK | S_IRWXUGO);
 	if (!inode)
 		goto out;
 
diff --git a/fs/proc/nommu.c b/fs/proc/nommu.c
index 75634379f82e..5c979fc49662 100644
--- a/fs/proc/nommu.c
+++ b/fs/proc/nommu.c
@@ -46,7 +46,7 @@ static int nommu_region_show(struct seq_file *m, struct vm_region *region)
 
 	if (file) {
 		struct inode *inode = file_inode(region->vm_file);
-		dev = inode->i_sb->s_dev;
+		dev = inode_sb(inode)->s_dev;
 		ino = inode->i_ino;
 	}
 
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index c41ab261397d..a989afed4b1e 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -280,7 +280,7 @@ static void proc_sys_prune_dcache(struct ctl_table_header *head)
 		spin_unlock(&sysctl_lock);
 
 		inode = &ei->vfs_inode;
-		sb = inode->i_sb;
+		sb = inode_sb(inode);
 		if (!atomic_inc_not_zero(&sb->s_active))
 			continue;
 		inode = igrab(inode);
@@ -550,7 +550,7 @@ static struct dentry *proc_sys_lookup(struct inode *dir, struct dentry *dentry,
 	}
 
 	err = ERR_PTR(-ENOMEM);
-	inode = proc_sys_make_inode(dir->i_sb, h ? h : head, p);
+	inode = proc_sys_make_inode(inode_sb(dir), h ? h : head, p);
 	if (!inode)
 		goto out;
 
diff --git a/fs/proc/self.c b/fs/proc/self.c
index 4d7d061696b3..43875daa8e16 100644
--- a/fs/proc/self.c
+++ b/fs/proc/self.c
@@ -12,7 +12,7 @@ static const char *proc_self_get_link(struct dentry *dentry,
 				      struct inode *inode,
 				      struct delayed_call *done)
 {
-	struct pid_namespace *ns = inode->i_sb->s_fs_info;
+	struct pid_namespace *ns = inode_sb(inode)->s_fs_info;
 	pid_t tgid = task_tgid_nr_ns(current, ns);
 	char *name;
 
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ec6d2983a5cb..27bf744e8da9 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -312,7 +312,7 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma, int is_pid)
 
 	if (file) {
 		struct inode *inode = file_inode(vma->vm_file);
-		dev = inode->i_sb->s_dev;
+		dev = inode_sb(inode)->s_dev;
 		ino = inode->i_ino;
 		pgoff = ((loff_t)vma->vm_pgoff) << PAGE_SHIFT;
 	}
diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index 5b62f57bd9bc..d3acd4433d9d 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -157,7 +157,7 @@ static int nommu_vma_show(struct seq_file *m, struct vm_area_struct *vma,
 
 	if (file) {
 		struct inode *inode = file_inode(vma->vm_file);
-		dev = inode->i_sb->s_dev;
+		dev = inode_sb(inode)->s_dev;
 		ino = inode->i_ino;
 		pgoff = (loff_t)vma->vm_pgoff << PAGE_SHIFT;
 	}
diff --git a/fs/proc/thread_self.c b/fs/proc/thread_self.c
index 9d2efaca499f..fdcf057eab38 100644
--- a/fs/proc/thread_self.c
+++ b/fs/proc/thread_self.c
@@ -12,7 +12,7 @@ static const char *proc_thread_self_get_link(struct dentry *dentry,
 					     struct inode *inode,
 					     struct delayed_call *done)
 {
-	struct pid_namespace *ns = inode->i_sb->s_fs_info;
+	struct pid_namespace *ns = inode_sb(inode)->s_fs_info;
 	pid_t tgid = task_tgid_nr_ns(current, ns);
 	pid_t pid = task_pid_nr_ns(current, ns);
 	char *name;
-- 
2.15.1
