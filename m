Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3312AC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28042086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28042086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757067AbeFQCzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 22:55:06 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:60990 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756946AbeFQCzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 22:55:04 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fUNqH-00043y-Hp; Sat, 16 Jun 2018 20:55:01 -0600
Received: from 97-119-124-205.omah.qwest.net ([97.119.124.205] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fUNqF-0007UB-2d; Sat, 16 Jun 2018 20:55:01 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alistair Strachan <astrachan@google.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>,
        Djalal Harouni <tixxdz@gmail.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org
References: <20180611195744.154962-1-astrachan@google.com>
        <87bmcgpzno.fsf@xmission.com>
        <CANDihLFmc21Ox_pe9S+oimiZcHB-hQLkv4avF7nReu+QjjL2Zg@mail.gmail.com>
        <87fu1svynb.fsf@xmission.com> <874li3pg2u.fsf_-_@xmission.com>
Date:   Sat, 16 Jun 2018 21:54:47 -0500
In-Reply-To: <874li3pg2u.fsf_-_@xmission.com> (Eric W. Biederman's message of
        "Fri, 15 Jun 2018 22:26:17 -0500")
Message-ID: <87lgbem8aw.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fUNqF-0007UB-2d;;;mid=<87lgbem8aw.fsf_-_@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19F1tXU22VIew8r0K1anSPnbsXPnUH1B10=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v2] proc: Simplify and fix proc by removing the kernel mount
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Today there are three users of proc_mnt.
- The legacy sysctl system call implementation.
- The uml mconsole driver.
- The process cleanup function proc_flush_task.

The first two are slow path and essentially unused.  I expect soon we
will be able to remove the legacy sysctl system call entirely.  To
keep them working for now a new wrapper file_open_proc_is added to
mount and unmount proc around file_open_root.  Which nicely removes
the need for a always mounted proc instance for these cases.

Handling proc_flush_task which is regularly used requires a little more
work.  First I optimize proc_flush_task to do nothing where there is
evidence that there are no entries in proc, by looking at pid->count.
Then I carefully update proc_fill_super and proc_kill_sb to maintain a
ns->proc_super pointer to the super block for proc.  This allows
proc_flush_task to find the appropriate instance of proc via rcu.

Once the appropriate instance of proc is found in proc_flush_task
atomic_inc_not_zero is used to increase the s_active count ensuring
proc_kill_sb will not be called, until the superblock is deactivated.
This makes it safe to inspect the instance of proc and invalidate any
dentries that mention the exiting task.

The two extra atomics operations in exit are not my favorite but given
that exit is already almost completely serialized with the task lock I
do not expect this change will be measurable.

The benefit for all of this change is that one of the most error prone
and tricky parts of the pid namespace implementation, maintaining
kernel mounts of proc is removed.

In addition removing the unnecessary complexity of the kernel mount
fixes a regression that caused the proc mount options to be ignored.
Now that the initial mount of proc comes from userspace, those mount
options are again honored.  This fixes Android's usage of the proc
hidepid option.

Reported-by: Alistair Strachan <astrachan@google.com>
Cc: stable@vger.kernel.org
Fixes: e94591d0d90c ("proc: Convert proc_mount to use mount_ns.")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

Alistair if you can test and confirm this fixes your issue I will add
your tested by and send the fix to Linus.

Since my earlier posting I have spot tested this.  Fixed a few bugs that
showed up and verified my changes work.  So I think this is ready to go
unless someone looks at this and in testing or code review spots a bug.

Eric

 arch/um/drivers/mconsole_kern.c |  4 ++--
 fs/proc/base.c                  | 36 ++++++++++++++++++++++++++-------
 fs/proc/inode.c                 |  5 ++++-
 fs/proc/root.c                  | 28 ++++++++++---------------
 include/linux/pid_namespace.h   |  3 +--
 include/linux/proc_ns.h         |  7 ++-----
 kernel/pid.c                    |  8 --------
 kernel/pid_namespace.c          |  7 -------
 kernel/sysctl_binary.c          |  5 ++---
 9 files changed, 51 insertions(+), 52 deletions(-)

diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index d5f9a2d1da1b..36af0e02d56b 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -27,6 +27,7 @@
 #include <linux/file.h>
 #include <linux/uaccess.h>
 #include <asm/switch_to.h>
+#include <linux/proc_ns.h>
 
 #include <init.h>
 #include <irq_kern.h>
@@ -124,7 +125,6 @@ void mconsole_log(struct mc_request *req)
 
 void mconsole_proc(struct mc_request *req)
 {
-	struct vfsmount *mnt = task_active_pid_ns(current)->proc_mnt;
 	char *buf;
 	int len;
 	struct file *file;
@@ -135,7 +135,7 @@ void mconsole_proc(struct mc_request *req)
 	ptr += strlen("proc");
 	ptr = skip_spaces(ptr);
 
-	file = file_open_root(mnt->mnt_root, mnt, ptr, O_RDONLY, 0);
+	file = file_open_proc(ptr, O_RDONLY, 0);
 	if (IS_ERR(file)) {
 		mconsole_reply(req, "Failed to open file", 1, 0);
 		printk(KERN_ERR "open /proc/%s: %ld\n", ptr, PTR_ERR(file));
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 1b2ede6abcdf..cd7b68a64ed1 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3052,7 +3052,7 @@ static const struct inode_operations proc_tgid_base_inode_operations = {
 	.permission	= proc_pid_permission,
 };
 
-static void proc_flush_task_mnt(struct vfsmount *mnt, pid_t pid, pid_t tgid)
+static void proc_flush_task_root(struct dentry *proc_root, pid_t pid, pid_t tgid)
 {
 	struct dentry *dentry, *leader, *dir;
 	char buf[10 + 1];
@@ -3061,7 +3061,7 @@ static void proc_flush_task_mnt(struct vfsmount *mnt, pid_t pid, pid_t tgid)
 	name.name = buf;
 	name.len = snprintf(buf, sizeof(buf), "%u", pid);
 	/* no ->d_hash() rejects on procfs */
-	dentry = d_hash_and_lookup(mnt->mnt_root, &name);
+	dentry = d_hash_and_lookup(proc_root, &name);
 	if (dentry) {
 		d_invalidate(dentry);
 		dput(dentry);
@@ -3072,7 +3072,7 @@ static void proc_flush_task_mnt(struct vfsmount *mnt, pid_t pid, pid_t tgid)
 
 	name.name = buf;
 	name.len = snprintf(buf, sizeof(buf), "%u", tgid);
-	leader = d_hash_and_lookup(mnt->mnt_root, &name);
+	leader = d_hash_and_lookup(proc_root, &name);
 	if (!leader)
 		goto out;
 
@@ -3102,8 +3102,8 @@ static void proc_flush_task_mnt(struct vfsmount *mnt, pid_t pid, pid_t tgid)
  * @task: task that should be flushed.
  *
  * When flushing dentries from proc, one needs to flush them from global
- * proc (proc_mnt) and from all the namespaces' procs this task was seen
- * in. This call is supposed to do all of this job.
+ * proc and from all the namespaces' procs this task was seen in. This call
+ * is supposed to do all of this job.
  *
  * Looks in the dcache for
  * /proc/@pid
@@ -3127,15 +3127,37 @@ void proc_flush_task(struct task_struct *task)
 	int i;
 	struct pid *pid, *tgid;
 	struct upid *upid;
+	int expected = 1;
 
 	pid = task_pid(task);
 	tgid = task_tgid(task);
+	if (thread_group_leader(task)) {
+		if (task_pgrp(task) == pid)
+			expected++;
+		if (task_session(task) == pid)
+			expected++;
+	}
+
+	/* Nothing to do if proc inodes have not take a reference to pid */
+	if (atomic_read(&pid->count) == expected)
+		return;
 
+	rcu_read_lock();
 	for (i = 0; i <= pid->level; i++) {
+		struct super_block *sb;
 		upid = &pid->numbers[i];
-		proc_flush_task_mnt(upid->ns->proc_mnt, upid->nr,
-					tgid->numbers[i].nr);
+
+		sb = rcu_dereference(upid->ns->proc_super);
+		if (!sb || !atomic_inc_not_zero(&sb->s_active))
+			continue;
+		rcu_read_unlock();
+
+		proc_flush_task_root(sb->s_root, upid->nr, tgid->numbers[i].nr);
+		deactivate_super(sb);
+
+		rcu_read_lock();
 	}
+	rcu_read_unlock();
 }
 
 static int proc_pid_instantiate(struct inode *dir,
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 2cf3b74391ca..1dd9514fa068 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -532,5 +532,8 @@ int proc_fill_super(struct super_block *s, void *data, int silent)
 	if (ret) {
 		return ret;
 	}
-	return proc_setup_thread_self(s);
+	ret = proc_setup_thread_self(s);
+
+	rcu_assign_pointer(ns->proc_super, s);
+	return ret;
 }
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 61b7340b357a..59ca06c386a0 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -89,14 +89,7 @@ int proc_remount(struct super_block *sb, int *flags, char *data)
 static struct dentry *proc_mount(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data)
 {
-	struct pid_namespace *ns;
-
-	if (flags & SB_KERNMOUNT) {
-		ns = data;
-		data = NULL;
-	} else {
-		ns = task_active_pid_ns(current);
-	}
+	struct pid_namespace *ns = task_active_pid_ns(current);
 
 	return mount_ns(fs_type, flags, data, ns, ns->user_ns, proc_fill_super);
 }
@@ -106,6 +99,7 @@ static void proc_kill_sb(struct super_block *sb)
 	struct pid_namespace *ns;
 
 	ns = (struct pid_namespace *)sb->s_fs_info;
+	rcu_assign_pointer(ns->proc_super, NULL);
 	if (ns->proc_self)
 		dput(ns->proc_self);
 	if (ns->proc_thread_self)
@@ -208,19 +202,19 @@ struct proc_dir_entry proc_root = {
 	.inline_name	= "/proc",
 };
 
-int pid_ns_prepare_proc(struct pid_namespace *ns)
+#if defined(CONFIG_SYSCTL_SYSCALL) || defined(CONFIG_MCONSOLE)
+struct file *file_open_proc(const char *pathname, int flags, umode_t mode)
 {
 	struct vfsmount *mnt;
+	struct file *file;
 
-	mnt = kern_mount_data(&proc_fs_type, ns);
+	mnt = kern_mount(&proc_fs_type);
 	if (IS_ERR(mnt))
-		return PTR_ERR(mnt);
+		return ERR_CAST(mnt);
 
-	ns->proc_mnt = mnt;
-	return 0;
-}
+	file = file_open_root(mnt->mnt_root, mnt, pathname, flags, mode);
+	kern_unmount(mnt);
 
-void pid_ns_release_proc(struct pid_namespace *ns)
-{
-	kern_unmount(ns->proc_mnt);
+	return file;
 }
+#endif
diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index 49538b172483..dfa70858b19a 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -31,7 +31,7 @@ struct pid_namespace {
 	unsigned int level;
 	struct pid_namespace *parent;
 #ifdef CONFIG_PROC_FS
-	struct vfsmount *proc_mnt;
+	struct super_block __rcu *proc_super;
 	struct dentry *proc_self;
 	struct dentry *proc_thread_self;
 #endif
@@ -40,7 +40,6 @@ struct pid_namespace {
 #endif
 	struct user_namespace *user_ns;
 	struct ucounts *ucounts;
-	struct work_struct proc_work;
 	kgid_t pid_gid;
 	int hide_pid;
 	int reboot;	/* group exit code if this pidns was rebooted */
diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
index d31cb6215905..8f1b9edf40ba 100644
--- a/include/linux/proc_ns.h
+++ b/include/linux/proc_ns.h
@@ -47,16 +47,11 @@ enum {
 
 #ifdef CONFIG_PROC_FS
 
-extern int pid_ns_prepare_proc(struct pid_namespace *ns);
-extern void pid_ns_release_proc(struct pid_namespace *ns);
 extern int proc_alloc_inum(unsigned int *pino);
 extern void proc_free_inum(unsigned int inum);
 
 #else /* CONFIG_PROC_FS */
 
-static inline int pid_ns_prepare_proc(struct pid_namespace *ns) { return 0; }
-static inline void pid_ns_release_proc(struct pid_namespace *ns) {}
-
 static inline int proc_alloc_inum(unsigned int *inum)
 {
 	*inum = 1;
@@ -86,4 +81,6 @@ extern int ns_get_name(char *buf, size_t size, struct task_struct *task,
 			const struct proc_ns_operations *ns_ops);
 extern void nsfs_init(void);
 
+extern struct file *file_open_proc(const char *pathname, int flags, umode_t mode);
+
 #endif /* _LINUX_PROC_NS_H */
diff --git a/kernel/pid.c b/kernel/pid.c
index 157fe4b19971..7a1a4f39e527 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -143,9 +143,6 @@ void free_pid(struct pid *pid)
 			/* Handle a fork failure of the first process */
 			WARN_ON(ns->child_reaper);
 			ns->pid_allocated = 0;
-			/* fall through */
-		case 0:
-			schedule_work(&ns->proc_work);
 			break;
 		}
 
@@ -204,11 +201,6 @@ struct pid *alloc_pid(struct pid_namespace *ns)
 		tmp = tmp->parent;
 	}
 
-	if (unlikely(is_child_reaper(pid))) {
-		if (pid_ns_prepare_proc(ns))
-			goto out_free;
-	}
-
 	get_pid_ns(ns);
 	atomic_set(&pid->count, 1);
 	for (type = 0; type < PIDTYPE_MAX; ++type)
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 2a2ac53d8b8b..3018cc18ac38 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -58,12 +58,6 @@ static struct kmem_cache *create_pid_cachep(unsigned int level)
 	return READ_ONCE(*pkc);
 }
 
-static void proc_cleanup_work(struct work_struct *work)
-{
-	struct pid_namespace *ns = container_of(work, struct pid_namespace, proc_work);
-	pid_ns_release_proc(ns);
-}
-
 static struct ucounts *inc_pid_namespaces(struct user_namespace *ns)
 {
 	return inc_ucount(ns, current_euid(), UCOUNT_PID_NAMESPACES);
@@ -115,7 +109,6 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
 	ns->user_ns = get_user_ns(user_ns);
 	ns->ucounts = ucounts;
 	ns->pid_allocated = PIDNS_ADDING;
-	INIT_WORK(&ns->proc_work, proc_cleanup_work);
 
 	return ns;
 
diff --git a/kernel/sysctl_binary.c b/kernel/sysctl_binary.c
index 07148b497451..b655410fa05a 100644
--- a/kernel/sysctl_binary.c
+++ b/kernel/sysctl_binary.c
@@ -17,6 +17,7 @@
 #include <linux/uuid.h>
 #include <linux/slab.h>
 #include <linux/compat.h>
+#include <linux/proc_ns.h>
 
 #ifdef CONFIG_SYSCTL_SYSCALL
 
@@ -1278,7 +1279,6 @@ static ssize_t binary_sysctl(const int *name, int nlen,
 	void __user *oldval, size_t oldlen, void __user *newval, size_t newlen)
 {
 	const struct bin_table *table = NULL;
-	struct vfsmount *mnt;
 	struct file *file;
 	ssize_t result;
 	char *pathname;
@@ -1301,8 +1301,7 @@ static ssize_t binary_sysctl(const int *name, int nlen,
 		goto out_putname;
 	}
 
-	mnt = task_active_pid_ns(current)->proc_mnt;
-	file = file_open_root(mnt->mnt_root, mnt, pathname, flags, 0);
+	file = file_open_proc(pathname, flags, 0);
 	result = PTR_ERR(file);
 	if (IS_ERR(file))
 		goto out_putname;
-- 
2.17.1

