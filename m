Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753431AbeDAKSE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 06:18:04 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36459 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753338AbeDAKR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 06:17:58 -0400
X-Google-Smtp-Source: AIpwx48fUouCI4PPmOijIQPojx2Yi8KFEI7lrQVOhzKG7Rr0o8qMwi4yXU/4hLhrYTDR8Z6nlzMfOA==
Date: Sun, 1 Apr 2018 10:17:54 +0000
From: Sargun Dhillon <sargun@sargun.me>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: penguin-kernel@i-love.sakura.ne.jp, keescook@chromium.org,
        igor.stoppa@huawei.com, casey@schaufler-ca.com, jmorris@namei.org
Subject: [PATCH 2/4] security: Refactor security hooks into structured hooks
Message-ID: <6492dcb88731b71ab02d3115558170896b25e89e.1522577650.git.sargun@sargun.me>
References: <cover.1522577650.git.sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1522577650.git.sargun@sargun.me>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This follows-up on the patch of moving the hook definitions into
lsm_hook_types.h. In order to facilitate their usage in other
purposes than just the security hook list union, they must
be turned into a structure that can be used for other purposes.

For this, there exist the new definition format:
VOID_HOOK(name, args...) -- for evaluation not returning anything
INT_HOOK(name, args...) -- for evaluation returning int

This should be a 0-functional, or logical change patch.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 include/linux/lsm_hook_types.h | 524 ++++++++++++++++++++---------------------
 include/linux/lsm_hooks.h      |   4 +
 2 files changed, 266 insertions(+), 262 deletions(-)

diff --git a/include/linux/lsm_hook_types.h b/include/linux/lsm_hook_types.h
index ea8653826cc3..7035ac682bfc 100644
--- a/include/linux/lsm_hook_types.h
+++ b/include/linux/lsm_hook_types.h
@@ -1373,297 +1373,297 @@
  *
  */
 
-int (*binder_set_context_mgr)(struct task_struct *mgr);
-int (*binder_transaction)(struct task_struct *from, struct task_struct *to);
-int (*binder_transfer_binder)(struct task_struct *from, struct task_struct *to);
-int (*binder_transfer_file)(struct task_struct *from, struct task_struct *to,
-				struct file *file);
-int (*ptrace_access_check)(struct task_struct *child, unsigned int mode);
-int (*ptrace_traceme)(struct task_struct *parent);
-int (*capget)(struct task_struct *target, kernel_cap_t *effective,
-		kernel_cap_t *inheritable, kernel_cap_t *permitted);
-int (*capset)(struct cred *new, const struct cred *old,
-		const kernel_cap_t *effective,
-		const kernel_cap_t *inheritable,
-		const kernel_cap_t *permitted);
-int (*capable)(const struct cred *cred, struct user_namespace *ns, int cap,
-		int audit);
-int (*quotactl)(int cmds, int type, int id, struct super_block *sb);
-int (*quota_on)(struct dentry *dentry);
-int (*syslog)(int type);
-int (*settime)(const struct timespec64 *ts, const struct timezone *tz);
-int (*vm_enough_memory)(struct mm_struct *mm, long pages);
-int (*bprm_set_creds)(struct linux_binprm *bprm);
-int (*bprm_check_security)(struct linux_binprm *bprm);
-void (*bprm_committing_creds)(struct linux_binprm *bprm);
-void (*bprm_committed_creds)(struct linux_binprm *bprm);
-int (*sb_alloc_security)(struct super_block *sb);
-void (*sb_free_security)(struct super_block *sb);
-int (*sb_copy_data)(char *orig, char *copy);
-int (*sb_remount)(struct super_block *sb, void *data);
-int (*sb_kern_mount)(struct super_block *sb, int flags, void *data);
-int (*sb_show_options)(struct seq_file *m, struct super_block *sb);
-int (*sb_statfs)(struct dentry *dentry);
-int (*sb_mount)(const char *dev_name, const struct path *path, const char *type,
-		unsigned long flags, void *data);
-int (*sb_umount)(struct vfsmount *mnt, int flags);
-int (*sb_pivotroot)(const struct path *old_path, const struct path *new_path);
-int (*sb_set_mnt_opts)(struct super_block *sb, struct security_mnt_opts *opts,
-			unsigned long kern_flags,
-			unsigned long *set_kern_flags);
-int (*sb_clone_mnt_opts)(const struct super_block *oldsb,
-				struct super_block *newsb,
-				unsigned long kern_flags,
-				unsigned long *set_kern_flags);
-int (*sb_parse_opts_str)(char *options, struct security_mnt_opts *opts);
-int (*dentry_init_security)(struct dentry *dentry, int mode,
-				const struct qstr *name, void **ctx,
-				u32 *ctxlen);
-int (*dentry_create_files_as)(struct dentry *dentry, int mode,
-					struct qstr *name,
-					const struct cred *old,
-					struct cred *new);
+INT_HOOK(binder_set_context_mgr, struct task_struct *mgr);
+INT_HOOK(binder_transaction, struct task_struct *from, struct task_struct *to);
+INT_HOOK(binder_transfer_binder, struct task_struct *from,
+	 struct task_struct *to);
+INT_HOOK(binder_transfer_file, struct task_struct *from, struct task_struct *to,
+	 struct file *file);
+INT_HOOK(ptrace_access_check, struct task_struct *child, unsigned int mode);
+INT_HOOK(ptrace_traceme, struct task_struct *parent);
+INT_HOOK(capget, struct task_struct *target, kernel_cap_t *effective,
+	 kernel_cap_t *inheritable, kernel_cap_t *permitted);
+INT_HOOK(capset, struct cred *new, const struct cred *old,
+	 const kernel_cap_t *effective, const kernel_cap_t *inheritable,
+	 const kernel_cap_t *permitted);
+INT_HOOK(capable, const struct cred *cred, struct user_namespace *ns, int cap,
+	 int audit);
+INT_HOOK(quotactl, int cmds, int type, int id, struct super_block *sb);
+INT_HOOK(quota_on, struct dentry *dentry);
+INT_HOOK(syslog, int type);
+INT_HOOK(settime, const struct timespec64 *ts, const struct timezone *tz);
+INT_HOOK(vm_enough_memory, struct mm_struct *mm, long pages);
+INT_HOOK(bprm_set_creds, struct linux_binprm *bprm);
+INT_HOOK(bprm_check_security, struct linux_binprm *bprm);
+VOID_HOOK(bprm_committing_creds, struct linux_binprm *bprm);
+VOID_HOOK(bprm_committed_creds, struct linux_binprm *bprm);
+INT_HOOK(sb_alloc_security, struct super_block *sb);
+VOID_HOOK(sb_free_security, struct super_block *sb);
+INT_HOOK(sb_copy_data, char *orig, char *copy);
+INT_HOOK(sb_remount, struct super_block *sb, void *data);
+INT_HOOK(sb_kern_mount, struct super_block *sb, int flags, void *data);
+INT_HOOK(sb_show_options, struct seq_file *m, struct super_block *sb);
+INT_HOOK(sb_statfs, struct dentry *dentry);
+INT_HOOK(sb_mount, const char *dev_name, const struct path *path,
+	 const char *type, unsigned long flags, void *data);
+INT_HOOK(sb_umount, struct vfsmount *mnt, int flags);
+INT_HOOK(sb_pivotroot, const struct path *old_path,
+	 const struct path *new_path);
+INT_HOOK(sb_set_mnt_opts, struct super_block *sb,
+	 struct security_mnt_opts *opts, unsigned long kern_flags,
+	 unsigned long *set_kern_flags);
+INT_HOOK(sb_clone_mnt_opts, const struct super_block *oldsb,
+	 struct super_block *newsb, unsigned long kern_flags,
+	 unsigned long *set_kern_flags);
+INT_HOOK(sb_parse_opts_str, char *options, struct security_mnt_opts *opts);
+INT_HOOK(dentry_init_security, struct dentry *dentry, int mode,
+	 const struct qstr *name, void **ctx, u32 *ctxlen);
+INT_HOOK(dentry_create_files_as, struct dentry *dentry, int mode,
+	 struct qstr *name, const struct cred *old, struct cred *new);
 
 
 #ifdef CONFIG_SECURITY_PATH
-int (*path_unlink)(const struct path *dir, struct dentry *dentry);
-int (*path_mkdir)(const struct path *dir, struct dentry *dentry, umode_t mode);
-int (*path_rmdir)(const struct path *dir, struct dentry *dentry);
-int (*path_mknod)(const struct path *dir, struct dentry *dentry, umode_t mode,
-			unsigned int dev);
-int (*path_truncate)(const struct path *path);
-int (*path_symlink)(const struct path *dir, struct dentry *dentry,
-			const char *old_name);
-int (*path_link)(struct dentry *old_dentry, const struct path *new_dir,
-			struct dentry *new_dentry);
-int (*path_rename)(const struct path *old_dir, struct dentry *old_dentry,
-			const struct path *new_dir,
-			struct dentry *new_dentry);
-int (*path_chmod)(const struct path *path, umode_t mode);
-int (*path_chown)(const struct path *path, kuid_t uid, kgid_t gid);
-int (*path_chroot)(const struct path *path);
+INT_HOOK(path_unlink, const struct path *dir, struct dentry *dentry);
+INT_HOOK(path_mkdir, const struct path *dir, struct dentry *dentry,
+	 umode_t mode);
+INT_HOOK(path_rmdir, const struct path *dir, struct dentry *dentry);
+INT_HOOK(path_mknod, const struct path *dir, struct dentry *dentry,
+	 umode_t mode, unsigned int dev);
+INT_HOOK(path_truncate, const struct path *path);
+INT_HOOK(path_symlink, const struct path *dir, struct dentry *dentry,
+	 const char *old_name);
+INT_HOOK(path_link, struct dentry *old_dentry, const struct path *new_dir,
+	 struct dentry *new_dentry);
+INT_HOOK(path_rename, const struct path *old_dir, struct dentry *old_dentry,
+	 const struct path *new_dir, struct dentry *new_dentry);
+INT_HOOK(path_chmod, const struct path *path, umode_t mode);
+INT_HOOK(path_chown, const struct path *path, kuid_t uid, kgid_t gid);
+INT_HOOK(path_chroot, const struct path *path);
 #endif
 
-int (*inode_alloc_security)(struct inode *inode);
-void (*inode_free_security)(struct inode *inode);
-int (*inode_init_security)(struct inode *inode, struct inode *dir,
-				const struct qstr *qstr, const char **name,
-				void **value, size_t *len);
-int (*inode_create)(struct inode *dir, struct dentry *dentry, umode_t mode);
-int (*inode_link)(struct dentry *old_dentry, struct inode *dir,
-			struct dentry *new_dentry);
-int (*inode_unlink)(struct inode *dir, struct dentry *dentry);
-int (*inode_symlink)(struct inode *dir, struct dentry *dentry,
-			const char *old_name);
-int (*inode_mkdir)(struct inode *dir, struct dentry *dentry, umode_t mode);
-int (*inode_rmdir)(struct inode *dir, struct dentry *dentry);
-int (*inode_mknod)(struct inode *dir, struct dentry *dentry, umode_t mode,
-			dev_t dev);
-int (*inode_rename)(struct inode *old_dir, struct dentry *old_dentry,
-			struct inode *new_dir, struct dentry *new_dentry);
-int (*inode_readlink)(struct dentry *dentry);
-int (*inode_follow_link)(struct dentry *dentry, struct inode *inode, bool rcu);
-int (*inode_permission)(struct inode *inode, int mask);
-int (*inode_setattr)(struct dentry *dentry, struct iattr *attr);
-int (*inode_getattr)(const struct path *path);
-int (*inode_setxattr)(struct dentry *dentry, const char *name,
+INT_HOOK(inode_alloc_security, struct inode *inode);
+VOID_HOOK(inode_free_security, struct inode *inode);
+INT_HOOK(inode_init_security, struct inode *inode, struct inode *dir,
+	 const struct qstr *qstr, const char **name, void **value, size_t *len);
+INT_HOOK(inode_create, struct inode *dir, struct dentry *dentry, umode_t mode);
+INT_HOOK(inode_link, struct dentry *old_dentry, struct inode *dir,
+	 struct dentry *new_dentry);
+INT_HOOK(inode_unlink, struct inode *dir, struct dentry *dentry);
+INT_HOOK(inode_symlink, struct inode *dir, struct dentry *dentry,
+	 const char *old_name);
+INT_HOOK(inode_mkdir, struct inode *dir, struct dentry *dentry, umode_t mode);
+INT_HOOK(inode_rmdir, struct inode *dir, struct dentry *dentry);
+INT_HOOK(inode_mknod, struct inode *dir, struct dentry *dentry, umode_t mode,
+	 dev_t dev);
+INT_HOOK(inode_rename, struct inode *old_dir, struct dentry *old_dentry,
+	 struct inode *new_dir, struct dentry *new_dentry);
+INT_HOOK(inode_readlink, struct dentry *dentry);
+INT_HOOK(inode_follow_link, struct dentry *dentry, struct inode *inode,
+	 bool rcu);
+INT_HOOK(inode_permission, struct inode *inode, int mask);
+INT_HOOK(inode_setattr, struct dentry *dentry, struct iattr *attr);
+INT_HOOK(inode_getattr, const struct path *path);
+INT_HOOK(inode_setxattr, struct dentry *dentry, const char *name,
 			const void *value, size_t size, int flags);
-void (*inode_post_setxattr)(struct dentry *dentry, const char *name,
+VOID_HOOK(inode_post_setxattr, struct dentry *dentry, const char *name,
 				const void *value, size_t size, int flags);
-int (*inode_getxattr)(struct dentry *dentry, const char *name);
-int (*inode_listxattr)(struct dentry *dentry);
-int (*inode_removexattr)(struct dentry *dentry, const char *name);
-int (*inode_need_killpriv)(struct dentry *dentry);
-int (*inode_killpriv)(struct dentry *dentry);
-int (*inode_getsecurity)(struct inode *inode, const char *name, void **buffer,
-				bool alloc);
-int (*inode_setsecurity)(struct inode *inode, const char *name,
-				const void *value, size_t size, int flags);
-int (*inode_listsecurity)(struct inode *inode, char *buffer,
-				size_t buffer_size);
-void (*inode_getsecid)(struct inode *inode, u32 *secid);
-int (*inode_copy_up)(struct dentry *src, struct cred **new);
-int (*inode_copy_up_xattr)(const char *name);
-int (*file_permission)(struct file *file, int mask);
-int (*file_alloc_security)(struct file *file);
-void (*file_free_security)(struct file *file);
-int (*file_ioctl)(struct file *file, unsigned int cmd, unsigned long arg);
-int (*mmap_addr)(unsigned long addr);
-int (*mmap_file)(struct file *file, unsigned long reqprot, unsigned long prot,
-			unsigned long flags);
-int (*file_mprotect)(struct vm_area_struct *vma, unsigned long reqprot,
-			unsigned long prot);
-int (*file_lock)(struct file *file, unsigned int cmd);
-int (*file_fcntl)(struct file *file, unsigned int cmd,
-			unsigned long arg);
-void (*file_set_fowner)(struct file *file);
-int (*file_send_sigiotask)(struct task_struct *tsk, struct fown_struct *fown,
-				int sig);
-int (*file_receive)(struct file *file);
-int (*file_open)(struct file *file, const struct cred *cred);
-int (*task_alloc)(struct task_struct *task, unsigned long clone_flags);
-void (*task_free)(struct task_struct *task);
-int (*cred_alloc_blank)(struct cred *cred, gfp_t gfp);
-void (*cred_free)(struct cred *cred);
-int (*cred_prepare)(struct cred *new, const struct cred *old, gfp_t gfp);
-void (*cred_transfer)(struct cred *new, const struct cred *old);
-int (*kernel_act_as)(struct cred *new, u32 secid);
-int (*kernel_create_files_as)(struct cred *new, struct inode *inode);
-int (*kernel_module_request)(char *kmod_name);
-int (*kernel_read_file)(struct file *file, enum kernel_read_file_id id);
-int (*kernel_post_read_file)(struct file *file, char *buf, loff_t size,
-			     enum kernel_read_file_id id);
-int (*task_fix_setuid)(struct cred *new, const struct cred *old, int flags);
-int (*task_setpgid)(struct task_struct *p, pid_t pgid);
-int (*task_getpgid)(struct task_struct *p);
-int (*task_getsid)(struct task_struct *p);
-void (*task_getsecid)(struct task_struct *p, u32 *secid);
-int (*task_setnice)(struct task_struct *p, int nice);
-int (*task_setioprio)(struct task_struct *p, int ioprio);
-int (*task_getioprio)(struct task_struct *p);
-int (*task_prlimit)(const struct cred *cred, const struct cred *tcred,
-		    unsigned int flags);
-int (*task_setrlimit)(struct task_struct *p, unsigned int resource,
-			struct rlimit *new_rlim);
-int (*task_setscheduler)(struct task_struct *p);
-int (*task_getscheduler)(struct task_struct *p);
-int (*task_movememory)(struct task_struct *p);
-int (*task_kill)(struct task_struct *p, struct siginfo *info, int sig,
-			const struct cred *cred);
-int (*task_prctl)(int option, unsigned long arg2, unsigned long arg3,
-			unsigned long arg4, unsigned long arg5);
-void (*task_to_inode)(struct task_struct *p, struct inode *inode);
-int (*ipc_permission)(struct kern_ipc_perm *ipcp, short flag);
-void (*ipc_getsecid)(struct kern_ipc_perm *ipcp, u32 *secid);
-int (*msg_msg_alloc_security)(struct msg_msg *msg);
-void (*msg_msg_free_security)(struct msg_msg *msg);
-int (*msg_queue_alloc_security)(struct msg_queue *msq);
-void (*msg_queue_free_security)(struct msg_queue *msq);
-int (*msg_queue_associate)(struct msg_queue *msq, int msqflg);
-int (*msg_queue_msgctl)(struct msg_queue *msq, int cmd);
-int (*msg_queue_msgsnd)(struct msg_queue *msq, struct msg_msg *msg, int msqflg);
-int (*msg_queue_msgrcv)(struct msg_queue *msq, struct msg_msg *msg,
-			struct task_struct *target, long type, int mode);
-int (*shm_alloc_security)(struct shmid_kernel *shp);
-void (*shm_free_security)(struct shmid_kernel *shp);
-int (*shm_associate)(struct shmid_kernel *shp, int shmflg);
-int (*shm_shmctl)(struct shmid_kernel *shp, int cmd);
-int (*shm_shmat)(struct shmid_kernel *shp, char __user *shmaddr, int shmflg);
-int (*sem_alloc_security)(struct sem_array *sma);
-void (*sem_free_security)(struct sem_array *sma);
-int (*sem_associate)(struct sem_array *sma, int semflg);
-int (*sem_semctl)(struct sem_array *sma, int cmd);
-int (*sem_semop)(struct sem_array *sma, struct sembuf *sops,
+INT_HOOK(inode_getxattr, struct dentry *dentry, const char *name);
+INT_HOOK(inode_listxattr, struct dentry *dentry);
+INT_HOOK(inode_removexattr, struct dentry *dentry, const char *name);
+INT_HOOK(inode_need_killpriv, struct dentry *dentry);
+INT_HOOK(inode_killpriv, struct dentry *dentry);
+INT_HOOK(inode_getsecurity, struct inode *inode, const char *name,
+	 void **buffer, bool alloc);
+INT_HOOK(inode_setsecurity, struct inode *inode, const char *name,
+	 const void *value, size_t size, int flags);
+INT_HOOK(inode_listsecurity, struct inode *inode, char *buffer,
+	 size_t buffer_size);
+VOID_HOOK(inode_getsecid, struct inode *inode, u32 *secid);
+INT_HOOK(inode_copy_up, struct dentry *src, struct cred **new);
+INT_HOOK(inode_copy_up_xattr, const char *name);
+INT_HOOK(file_permission, struct file *file, int mask);
+INT_HOOK(file_alloc_security, struct file *file);
+VOID_HOOK(file_free_security, struct file *file);
+INT_HOOK(file_ioctl, struct file *file, unsigned int cmd, unsigned long arg);
+INT_HOOK(mmap_addr, unsigned long addr);
+INT_HOOK(mmap_file, struct file *file, unsigned long reqprot,
+	 unsigned long prot, unsigned long flags);
+INT_HOOK(file_mprotect, struct vm_area_struct *vma, unsigned long reqprot,
+	 unsigned long prot);
+INT_HOOK(file_lock, struct file *file, unsigned int cmd);
+INT_HOOK(file_fcntl, struct file *file, unsigned int cmd, unsigned long arg);
+VOID_HOOK(file_set_fowner, struct file *file);
+INT_HOOK(file_send_sigiotask, struct task_struct *tsk, struct fown_struct *fown,
+	 int sig);
+INT_HOOK(file_receive, struct file *file);
+INT_HOOK(file_open, struct file *file, const struct cred *cred);
+INT_HOOK(task_alloc, struct task_struct *task, unsigned long clone_flags);
+VOID_HOOK(task_free, struct task_struct *task);
+INT_HOOK(cred_alloc_blank, struct cred *cred, gfp_t gfp);
+VOID_HOOK(cred_free, struct cred *cred);
+INT_HOOK(cred_prepare, struct cred *new, const struct cred *old, gfp_t gfp);
+VOID_HOOK(cred_transfer, struct cred *new, const struct cred *old);
+INT_HOOK(kernel_act_as, struct cred *new, u32 secid);
+INT_HOOK(kernel_create_files_as, struct cred *new, struct inode *inode);
+INT_HOOK(kernel_module_request, char *kmod_name);
+INT_HOOK(kernel_read_file, struct file *file, enum kernel_read_file_id id);
+INT_HOOK(kernel_post_read_file, struct file *file, char *buf, loff_t size,
+	 enum kernel_read_file_id id);
+INT_HOOK(task_fix_setuid, struct cred *new, const struct cred *old, int flags);
+INT_HOOK(task_setpgid, struct task_struct *p, pid_t pgid);
+INT_HOOK(task_getpgid, struct task_struct *p);
+INT_HOOK(task_getsid, struct task_struct *p);
+VOID_HOOK(task_getsecid, struct task_struct *p, u32 *secid);
+INT_HOOK(task_setnice, struct task_struct *p, int nice);
+INT_HOOK(task_setioprio, struct task_struct *p, int ioprio);
+INT_HOOK(task_getioprio, struct task_struct *p);
+INT_HOOK(task_prlimit, const struct cred *cred, const struct cred *tcred,
+	 unsigned int flags);
+INT_HOOK(task_setrlimit, struct task_struct *p, unsigned int resource,
+	 struct rlimit *new_rlim);
+INT_HOOK(task_setscheduler, struct task_struct *p);
+INT_HOOK(task_getscheduler, struct task_struct *p);
+INT_HOOK(task_movememory, struct task_struct *p);
+INT_HOOK(task_kill, struct task_struct *p, struct siginfo *info, int sig,
+	 const struct cred *cred);
+INT_HOOK(task_prctl, int option, unsigned long arg2, unsigned long arg3,
+	 unsigned long arg4, unsigned long arg5);
+VOID_HOOK(task_to_inode, struct task_struct *p, struct inode *inode);
+INT_HOOK(ipc_permission, struct kern_ipc_perm *ipcp, short flag);
+VOID_HOOK(ipc_getsecid, struct kern_ipc_perm *ipcp, u32 *secid);
+INT_HOOK(msg_msg_alloc_security, struct msg_msg *msg);
+VOID_HOOK(msg_msg_free_security, struct msg_msg *msg);
+INT_HOOK(msg_queue_alloc_security, struct msg_queue *msq);
+VOID_HOOK(msg_queue_free_security, struct msg_queue *msq);
+INT_HOOK(msg_queue_associate, struct msg_queue *msq, int msqflg);
+INT_HOOK(msg_queue_msgctl, struct msg_queue *msq, int cmd);
+INT_HOOK(msg_queue_msgsnd, struct msg_queue *msq, struct msg_msg *msg,
+	 int msqflg);
+INT_HOOK(msg_queue_msgrcv, struct msg_queue *msq, struct msg_msg *msg,
+	 struct task_struct *target, long type, int mode);
+INT_HOOK(shm_alloc_security, struct shmid_kernel *shp);
+VOID_HOOK(shm_free_security, struct shmid_kernel *shp);
+INT_HOOK(shm_associate, struct shmid_kernel *shp, int shmflg);
+INT_HOOK(shm_shmctl, struct shmid_kernel *shp, int cmd);
+INT_HOOK(shm_shmat, struct shmid_kernel *shp, char __user *shmaddr,
+	 int shmflg);
+INT_HOOK(sem_alloc_security, struct sem_array *sma);
+VOID_HOOK(sem_free_security, struct sem_array *sma);
+INT_HOOK(sem_associate, struct sem_array *sma, int semflg);
+INT_HOOK(sem_semctl, struct sem_array *sma, int cmd);
+INT_HOOK(sem_semop, struct sem_array *sma, struct sembuf *sops,
 			unsigned nsops, int alter);
-int (*netlink_send)(struct sock *sk, struct sk_buff *skb);
-void (*d_instantiate)(struct dentry *dentry, struct inode *inode);
-int (*getprocattr)(struct task_struct *p, char *name, char **value);
-int (*setprocattr)(const char *name, void *value, size_t size);
-int (*ismaclabel)(const char *name);
-int (*secid_to_secctx)(u32 secid, char **secdata, u32 *seclen);
-int (*secctx_to_secid)(const char *secdata, u32 seclen, u32 *secid);
-void (*release_secctx)(char *secdata, u32 seclen);
-void (*inode_invalidate_secctx)(struct inode *inode);
-int (*inode_notifysecctx)(struct inode *inode, void *ctx, u32 ctxlen);
-int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
-int (*inode_getsecctx)(struct inode *inode, void **ctx, u32 *ctxlen);
+INT_HOOK(netlink_send, struct sock *sk, struct sk_buff *skb);
+VOID_HOOK(d_instantiate, struct dentry *dentry, struct inode *inode);
+INT_HOOK(getprocattr, struct task_struct *p, char *name, char **value);
+INT_HOOK(setprocattr, const char *name, void *value, size_t size);
+INT_HOOK(ismaclabel, const char *name);
+INT_HOOK(secid_to_secctx, u32 secid, char **secdata, u32 *seclen);
+INT_HOOK(secctx_to_secid, const char *secdata, u32 seclen, u32 *secid);
+VOID_HOOK(release_secctx, char *secdata, u32 seclen);
+VOID_HOOK(inode_invalidate_secctx, struct inode *inode);
+INT_HOOK(inode_notifysecctx, struct inode *inode, void *ctx, u32 ctxlen);
+INT_HOOK(inode_setsecctx, struct dentry *dentry, void *ctx, u32 ctxlen);
+INT_HOOK(inode_getsecctx, struct inode *inode, void **ctx, u32 *ctxlen);
 
 #ifdef CONFIG_SECURITY_NETWORK
-int (*unix_stream_connect)(struct sock *sock, struct sock *other,
+INT_HOOK(unix_stream_connect, struct sock *sock, struct sock *other,
 				struct sock *newsk);
-int (*unix_may_send)(struct socket *sock, struct socket *other);
-int (*socket_create)(int family, int type, int protocol, int kern);
-int (*socket_post_create)(struct socket *sock, int family, int type,
+INT_HOOK(unix_may_send, struct socket *sock, struct socket *other);
+INT_HOOK(socket_create, int family, int type, int protocol, int kern);
+INT_HOOK(socket_post_create, struct socket *sock, int family, int type,
 				int protocol, int kern);
-int (*socket_bind)(struct socket *sock, struct sockaddr *address, int addrlen);
-int (*socket_connect)(struct socket *sock, struct sockaddr *address,
-			int addrlen);
-int (*socket_listen)(struct socket *sock, int backlog);
-int (*socket_accept)(struct socket *sock, struct socket *newsock);
-int (*socket_sendmsg)(struct socket *sock, struct msghdr *msg, int size);
-int (*socket_recvmsg)(struct socket *sock, struct msghdr *msg, int size,
-			int flags);
-int (*socket_getsockname)(struct socket *sock);
-int (*socket_getpeername)(struct socket *sock);
-int (*socket_getsockopt)(struct socket *sock, int level, int optname);
-int (*socket_setsockopt)(struct socket *sock, int level, int optname);
-int (*socket_shutdown)(struct socket *sock, int how);
-int (*socket_sock_rcv_skb)(struct sock *sk, struct sk_buff *skb);
-int (*socket_getpeersec_stream)(struct socket *sock, char __user *optval,
-				int __user *optlen, unsigned len);
-int (*socket_getpeersec_dgram)(struct socket *sock, struct sk_buff *skb,
-				u32 *secid);
-int (*sk_alloc_security)(struct sock *sk, int family, gfp_t priority);
-void (*sk_free_security)(struct sock *sk);
-void (*sk_clone_security)(const struct sock *sk, struct sock *newsk);
-void (*sk_getsecid)(struct sock *sk, u32 *secid);
-void (*sock_graft)(struct sock *sk, struct socket *parent);
-int (*inet_conn_request)(struct sock *sk, struct sk_buff *skb,
-				struct request_sock *req);
-void (*inet_csk_clone)(struct sock *newsk, const struct request_sock *req);
-void (*inet_conn_established)(struct sock *sk, struct sk_buff *skb);
-int (*secmark_relabel_packet)(u32 secid);
-void (*secmark_refcount_inc)(void);
-void (*secmark_refcount_dec)(void);
-void (*req_classify_flow)(const struct request_sock *req, struct flowi *fl);
-int (*tun_dev_alloc_security)(void **security);
-void (*tun_dev_free_security)(void *security);
-int (*tun_dev_create)(void);
-int (*tun_dev_attach_queue)(void *security);
-int (*tun_dev_attach)(struct sock *sk, void *security);
-int (*tun_dev_open)(void *security);
+INT_HOOK(socket_bind, struct socket *sock, struct sockaddr *address,
+	 int addrlen);
+INT_HOOK(socket_connect, struct socket *sock, struct sockaddr *address,
+	 int addrlen);
+INT_HOOK(socket_listen, struct socket *sock, int backlog);
+INT_HOOK(socket_accept, struct socket *sock, struct socket *newsock);
+INT_HOOK(socket_sendmsg, struct socket *sock, struct msghdr *msg, int size);
+INT_HOOK(socket_recvmsg, struct socket *sock, struct msghdr *msg, int size,
+	 int flags);
+INT_HOOK(socket_getsockname, struct socket *sock);
+INT_HOOK(socket_getpeername, struct socket *sock);
+INT_HOOK(socket_getsockopt, struct socket *sock, int level, int optname);
+INT_HOOK(socket_setsockopt, struct socket *sock, int level, int optname);
+INT_HOOK(socket_shutdown, struct socket *sock, int how);
+INT_HOOK(socket_sock_rcv_skb, struct sock *sk, struct sk_buff *skb);
+INT_HOOK(socket_getpeersec_stream, struct socket *sock, char __user *optval,
+	 int __user *optlen, unsigned len);
+INT_HOOK(socket_getpeersec_dgram, struct socket *sock, struct sk_buff *skb,
+	 u32 *secid);
+INT_HOOK(sk_alloc_security, struct sock *sk, int family, gfp_t priority);
+VOID_HOOK(sk_free_security, struct sock *sk);
+VOID_HOOK(sk_clone_security, const struct sock *sk, struct sock *newsk);
+VOID_HOOK(sk_getsecid, struct sock *sk, u32 *secid);
+VOID_HOOK(sock_graft, struct sock *sk, struct socket *parent);
+INT_HOOK(inet_conn_request, struct sock *sk, struct sk_buff *skb,
+	 struct request_sock *req);
+VOID_HOOK(inet_csk_clone, struct sock *newsk, const struct request_sock *req);
+VOID_HOOK(inet_conn_established, struct sock *sk, struct sk_buff *skb);
+INT_HOOK(secmark_relabel_packet, u32 secid);
+VOID_HOOK(secmark_refcount_inc, void);
+VOID_HOOK(secmark_refcount_dec, void);
+VOID_HOOK(req_classify_flow, const struct request_sock *req, struct flowi *fl);
+INT_HOOK(tun_dev_alloc_security, void **security);
+VOID_HOOK(tun_dev_free_security, void *security);
+INT_HOOK(tun_dev_create, void);
+INT_HOOK(tun_dev_attach_queue, void *security);
+INT_HOOK(tun_dev_attach, struct sock *sk, void *security);
+INT_HOOK(tun_dev_open, void *security);
 #endif	/* CONFIG_SECURITY_NETWORK */
 
 #ifdef CONFIG_SECURITY_INFINIBAND
-int (*ib_pkey_access)(void *sec, u64 subnet_prefix, u16 pkey);
-int (*ib_endport_manage_subnet)(void *sec, const char *dev_name, u8 port_num);
-int (*ib_alloc_security)(void **sec);
-void (*ib_free_security)(void *sec);
+INT_HOOK(ib_pkey_access, void *sec, u64 subnet_prefix, u16 pkey);
+INT_HOOK(ib_endport_manage_subnet, void *sec, const char *dev_name,
+	 u8 port_num);
+INT_HOOK(ib_alloc_security, void **sec);
+VOID_HOOK(ib_free_security, void *sec);
 #endif	/* CONFIG_SECURITY_INFINIBAND */
 
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
-int (*xfrm_policy_alloc_security)(struct xfrm_sec_ctx **ctxp,
+INT_HOOK(xfrm_policy_alloc_security, struct xfrm_sec_ctx **ctxp,
 				  struct xfrm_user_sec_ctx *sec_ctx, gfp_t gfp);
-int (*xfrm_policy_clone_security)(struct xfrm_sec_ctx *old_ctx,
+INT_HOOK(xfrm_policy_clone_security, struct xfrm_sec_ctx *old_ctx,
 					struct xfrm_sec_ctx **new_ctx);
-void (*xfrm_policy_free_security)(struct xfrm_sec_ctx *ctx);
-int (*xfrm_policy_delete_security)(struct xfrm_sec_ctx *ctx);
-int (*xfrm_state_alloc)(struct xfrm_state *x,
-			struct xfrm_user_sec_ctx *sec_ctx);
-int (*xfrm_state_alloc_acquire)(struct xfrm_state *x,
+VOID_HOOK(xfrm_policy_free_security, struct xfrm_sec_ctx *ctx);
+INT_HOOK(xfrm_policy_delete_security, struct xfrm_sec_ctx *ctx);
+INT_HOOK(xfrm_state_alloc, struct xfrm_state *x,
+	 struct xfrm_user_sec_ctx *sec_ctx);
+INT_HOOK(xfrm_state_alloc_acquire, struct xfrm_state *x,
 				struct xfrm_sec_ctx *polsec, u32 secid);
-void (*xfrm_state_free_security)(struct xfrm_state *x);
-int (*xfrm_state_delete_security)(struct xfrm_state *x);
-int (*xfrm_policy_lookup)(struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir);
-int (*xfrm_state_pol_flow_match)(struct xfrm_state *x,
-					struct xfrm_policy *xp,
-					const struct flowi *fl);
-int (*xfrm_decode_session)(struct sk_buff *skb, u32 *secid, int ckall);
+VOID_HOOK(xfrm_state_free_security, struct xfrm_state *x);
+INT_HOOK(xfrm_state_delete_security, struct xfrm_state *x);
+INT_HOOK(xfrm_policy_lookup, struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir);
+INT_HOOK(xfrm_state_pol_flow_match, struct xfrm_state *x,
+	 struct xfrm_policy *xp, const struct flowi *fl);
+INT_HOOK(xfrm_decode_session, struct sk_buff *skb, u32 *secid, int ckall);
 #endif	/* CONFIG_SECURITY_NETWORK_XFRM */
 
 	/* key management security hooks */
 #ifdef CONFIG_KEYS
-int (*key_alloc)(struct key *key, const struct cred *cred, unsigned long flags);
-void (*key_free)(struct key *key);
-int (*key_permission)(key_ref_t key_ref, const struct cred *cred,
-			unsigned perm);
-int (*key_getsecurity)(struct key *key, char **_buffer);
+INT_HOOK(key_alloc, struct key *key, const struct cred *cred,
+	 unsigned long flags);
+VOID_HOOK(key_free, struct key *key);
+INT_HOOK(key_permission, key_ref_t key_ref, const struct cred *cred,
+	 unsigned perm);
+INT_HOOK(key_getsecurity, struct key *key, char **_buffer);
 #endif	/* CONFIG_KEYS */
 
 #ifdef CONFIG_AUDIT
-int (*audit_rule_init)(u32 field, u32 op, char *rulestr, void **lsmrule);
-int (*audit_rule_known)(struct audit_krule *krule);
-int (*audit_rule_match)(u32 secid, u32 field, u32 op, void *lsmrule,
-			struct audit_context *actx);
-void (*audit_rule_free)(void *lsmrule);
+INT_HOOK(audit_rule_init, u32 field, u32 op, char *rulestr, void **lsmrule);
+INT_HOOK(audit_rule_known, struct audit_krule *krule);
+INT_HOOK(audit_rule_match, u32 secid, u32 field, u32 op, void *lsmrule,
+	 struct audit_context *actx);
+VOID_HOOK(audit_rule_free, void *lsmrule);
 #endif /* CONFIG_AUDIT */
 
 #ifdef CONFIG_BPF_SYSCALL
-int (*bpf)(int cmd, union bpf_attr *attr, unsigned int size);
-int (*bpf_map)(struct bpf_map *map, fmode_t fmode);
-int (*bpf_prog)(struct bpf_prog *prog);
-int (*bpf_map_alloc_security)(struct bpf_map *map);
-void (*bpf_map_free_security)(struct bpf_map *map);
-int (*bpf_prog_alloc_security)(struct bpf_prog_aux *aux);
-void (*bpf_prog_free_security)(struct bpf_prog_aux *aux);
+INT_HOOK(bpf, int cmd, union bpf_attr *attr, unsigned int size);
+INT_HOOK(bpf_map, struct bpf_map *map, fmode_t fmode);
+INT_HOOK(bpf_prog, struct bpf_prog *prog);
+INT_HOOK(bpf_map_alloc_security, struct bpf_map *map);
+VOID_HOOK(bpf_map_free_security, struct bpf_map *map);
+INT_HOOK(bpf_prog_alloc_security, struct bpf_prog_aux *aux);
+VOID_HOOK(bpf_prog_free_security, struct bpf_prog_aux *aux);
 #endif /* CONFIG_BPF_SYSCALL */
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 84e5aa3132d1..5489f0594f6c 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -29,7 +29,11 @@
 #include <linux/rculist.h>
 
 union security_list_options {
+#define INT_HOOK(_hook_name, ...)      int(*_hook_name)(__VA_ARGS__)
+#define VOID_HOOK(_hook_name, ...)     void(*_hook_name)(__VA_ARGS__)
 #include <linux/lsm_hook_types.h>
+#undef INT_HOOK
+#undef VOID_HOOK
 };
 
 struct security_hook_heads {
-- 
2.14.1
