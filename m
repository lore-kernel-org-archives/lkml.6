Return-Path: <BATV+8c5add14d4fec8f33fc9+5379+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AB8JxZr6BvHzz1glHR0/YvL4cFFqIW6nwyA7KKQgI8SJ6nspOjSfwVG3JGduE3r8ciQs6ucOGubk
ARC-Seal: i=1; a=rsa-sha256; t=1526463839; cv=none;
        d=google.com; s=arc-20160816;
        b=Xs7q7UKe7CHx9JjrgZ8Q7sRh5Jr+FfwJBA3l8mmWMYgCAtm7SqSJeFxPOqrUCAkWEW
         wMNGwMwU4PM3/B6MqF9jbvfT/WY5fazVqJ6dO67n/NX2bY4jM/dNLJn08ddRAuDg8tpz
         Zs3+b1v9CXapbontMBSRK0s9NJvUvEhU3Utj2efYBbGLV+CWu4b8NsCiBcN9KeIfPH5G
         jcgp/aOci1ddpK98Kbr6tz7cbvfCYDeZkERP15mb+imoYqn55uZa94FoPyeO7FUXz9MG
         zU+erDOxqImgHYE4mnLlh4kz40kSOSX14+ZQEilBXvjibSwrNEp2sVCa9w1LuVHlibO9
         77Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=O0iutuoU/1QAohLn9IBcRPVTaw7+5DkVSCk6pHHuT+o=;
        b=tzvoEHDIINocTW/jVkTHZ2Tx+fbELkaOnBakl2JGo7q2FMfsjVqPdVGYNRbIgjM5YZ
         KzYZbFncB5cBjvkvaf47rB0jiBRNeOtDgXT+zvZnYXwpXHoE32eXBaa7I8jtUV4b4psq
         LZw2T29Z0cmogmVk4FTKxf2K8LAvbPXbnGvdccWZiV6VYpwq2/O81oK6wAP+hA51aBZX
         QKozycGJT5uoLzv5T56u+8a+Kv+xwzYztcHDe1Px0aSQ4cMD1lgzb4sUUqN314GSWBS7
         vvgHTjCHwpTiaUmqDAJRW2H4R+jiaPhiS7u+8uhfwNuIXrtLKkdGdRSAJGZ/FOw5DrOw
         MH3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=UZsFhnBN;
       spf=pass (google.com: best guess record for domain of batv+8c5add14d4fec8f33fc9+5379+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+8c5add14d4fec8f33fc9+5379+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=UZsFhnBN;
       spf=pass (google.com: best guess record for domain of batv+8c5add14d4fec8f33fc9+5379+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+8c5add14d4fec8f33fc9+5379+infradead.org+hch@bombadil.srs.infradead.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-acpi@vger.kernel.org,
	drbd-dev@lists.linbit.com,
	linux-ide@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-afs@lists.infradead.org,
	linux-ext4@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	netfilter-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/42] proc: introduce a proc_pid_ns helper
Date: Wed, 16 May 2018 11:43:06 +0200
Message-Id: <20180516094346.20506-3-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516094346.20506-1-hch@lst.de>
References: <20180516094346.20506-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600613347161334024?=
X-GMAIL-MSGID: =?utf-8?q?1600613347161334024?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Factor out retrieving the per-sb pid namespaces from the sb private data
into an easier to understand helper.

Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/proc/array.c         |  7 +------
 fs/proc/base.c          | 18 ++++++++----------
 fs/proc/self.c          |  4 ++--
 fs/proc/thread_self.c   |  4 ++--
 include/linux/proc_fs.h |  6 ++++++
 5 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index ae2c807fd719..911f66924d81 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -677,12 +677,7 @@ get_children_pid(struct inode *inode, struct pid *pid_prev, loff_t pos)
 
 static int children_seq_show(struct seq_file *seq, void *v)
 {
-	struct inode *inode = seq->private;
-	pid_t pid;
-
-	pid = pid_nr_ns(v, inode->i_sb->s_fs_info);
-	seq_printf(seq, "%d ", pid);
-
+	seq_printf(seq, "%d ", pid_nr_ns(v, proc_pid_ns(seq->private)));
 	return 0;
 }
 
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 1b2ede6abcdf..29237cad19fd 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -698,7 +698,7 @@ static bool has_pid_permissions(struct pid_namespace *pid,
 
 static int proc_pid_permission(struct inode *inode, int mask)
 {
-	struct pid_namespace *pid = inode->i_sb->s_fs_info;
+	struct pid_namespace *pid = proc_pid_ns(inode);
 	struct task_struct *task;
 	bool has_perms;
 
@@ -733,13 +733,11 @@ static const struct inode_operations proc_def_inode_operations = {
 static int proc_single_show(struct seq_file *m, void *v)
 {
 	struct inode *inode = m->private;
-	struct pid_namespace *ns;
-	struct pid *pid;
+	struct pid_namespace *ns = proc_pid_ns(inode);
+	struct pid *pid = proc_pid(inode);
 	struct task_struct *task;
 	int ret;
 
-	ns = inode->i_sb->s_fs_info;
-	pid = proc_pid(inode);
 	task = get_pid_task(pid, PIDTYPE_PID);
 	if (!task)
 		return -ESRCH;
@@ -1410,7 +1408,7 @@ static const struct file_operations proc_fail_nth_operations = {
 static int sched_show(struct seq_file *m, void *v)
 {
 	struct inode *inode = m->private;
-	struct pid_namespace *ns = inode->i_sb->s_fs_info;
+	struct pid_namespace *ns = proc_pid_ns(inode);
 	struct task_struct *p;
 
 	p = get_proc_task(inode);
@@ -1782,8 +1780,8 @@ int pid_getattr(const struct path *path, struct kstat *stat,
 		u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
+	struct pid_namespace *pid = proc_pid_ns(inode);
 	struct task_struct *task;
-	struct pid_namespace *pid = path->dentry->d_sb->s_fs_info;
 
 	generic_fillattr(inode, stat);
 
@@ -2337,7 +2335,7 @@ static int proc_timers_open(struct inode *inode, struct file *file)
 		return -ENOMEM;
 
 	tp->pid = proc_pid(inode);
-	tp->ns = inode->i_sb->s_fs_info;
+	tp->ns = proc_pid_ns(inode);
 	return 0;
 }
 
@@ -3239,7 +3237,7 @@ static struct tgid_iter next_tgid(struct pid_namespace *ns, struct tgid_iter ite
 int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct tgid_iter iter;
-	struct pid_namespace *ns = file_inode(file)->i_sb->s_fs_info;
+	struct pid_namespace *ns = proc_pid_ns(file_inode(file));
 	loff_t pos = ctx->pos;
 
 	if (pos >= PID_MAX_LIMIT + TGID_OFFSET)
@@ -3588,7 +3586,7 @@ static int proc_task_readdir(struct file *file, struct dir_context *ctx)
 	/* f_version caches the tgid value that the last readdir call couldn't
 	 * return. lseek aka telldir automagically resets f_version to 0.
 	 */
-	ns = inode->i_sb->s_fs_info;
+	ns = proc_pid_ns(inode);
 	tid = (int)file->f_version;
 	file->f_version = 0;
 	for (task = first_tid(proc_pid(inode), tid, ctx->pos - 2, ns);
diff --git a/fs/proc/self.c b/fs/proc/self.c
index 4d7d061696b3..127265e5c55f 100644
--- a/fs/proc/self.c
+++ b/fs/proc/self.c
@@ -12,7 +12,7 @@ static const char *proc_self_get_link(struct dentry *dentry,
 				      struct inode *inode,
 				      struct delayed_call *done)
 {
-	struct pid_namespace *ns = inode->i_sb->s_fs_info;
+	struct pid_namespace *ns = proc_pid_ns(inode);
 	pid_t tgid = task_tgid_nr_ns(current, ns);
 	char *name;
 
@@ -36,7 +36,7 @@ static unsigned self_inum __ro_after_init;
 int proc_setup_self(struct super_block *s)
 {
 	struct inode *root_inode = d_inode(s->s_root);
-	struct pid_namespace *ns = s->s_fs_info;
+	struct pid_namespace *ns = proc_pid_ns(root_inode);
 	struct dentry *self;
 	
 	inode_lock(root_inode);
diff --git a/fs/proc/thread_self.c b/fs/proc/thread_self.c
index 9d2efaca499f..b905010ca9eb 100644
--- a/fs/proc/thread_self.c
+++ b/fs/proc/thread_self.c
@@ -12,7 +12,7 @@ static const char *proc_thread_self_get_link(struct dentry *dentry,
 					     struct inode *inode,
 					     struct delayed_call *done)
 {
-	struct pid_namespace *ns = inode->i_sb->s_fs_info;
+	struct pid_namespace *ns = proc_pid_ns(inode);
 	pid_t tgid = task_tgid_nr_ns(current, ns);
 	pid_t pid = task_pid_nr_ns(current, ns);
 	char *name;
@@ -36,7 +36,7 @@ static unsigned thread_self_inum __ro_after_init;
 int proc_setup_thread_self(struct super_block *s)
 {
 	struct inode *root_inode = d_inode(s->s_root);
-	struct pid_namespace *ns = s->s_fs_info;
+	struct pid_namespace *ns = proc_pid_ns(root_inode);
 	struct dentry *thread_self;
 
 	inode_lock(root_inode);
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 928ef9e4d912..4edcde510631 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -83,4 +83,10 @@ struct ns_common;
 int open_related_ns(struct ns_common *ns,
 		   struct ns_common *(*get_ns)(struct ns_common *ns));
 
+/* get the associated pid namespace for a file in procfs */
+static inline struct pid_namespace *proc_pid_ns(struct inode *inode)
+{
+	return inode->i_sb->s_fs_info;
+}
+
 #endif /* _LINUX_PROC_FS_H */
-- 
2.17.0
