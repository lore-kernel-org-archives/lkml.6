Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754794AbeBWTnh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 14:43:37 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40318 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933609AbeBWTnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 14:43:35 -0500
X-Google-Smtp-Source: AG47ELsi11PGp1Yl/4LVpzbv5YAJJbWFKETPc7/lD+3kvO/OoU+hq0euuRer5aQfT2XKw8nQbqKeLw==
Date: Fri, 23 Feb 2018 22:43:31 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] proc: make /proc/*/cmdline go through LSM
Message-ID: <20180223194331.GB5708@avx2>
References: <20180221192339.GA28548@avx2>
 <20180221120627.9e134187df86df7c08ad78ca@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221120627.9e134187df86df7c08ad78ca@linux-foundation.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/proc/*/mem and /proc/*/environ use common code to check if open is
allowed. Essentially they all access target task memory.

/proc/*/cmdline should be subject to the same checks as it does
what /proc/*/environ does.

->security_ptrace_access_check LSM hook will be called allowing LSM
to interfere.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/base.c |   67 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -208,11 +208,34 @@ static int proc_root_link(struct dentry *dentry, struct path *path)
 	return result;
 }
 
+static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
+{
+	struct mm_struct *mm = proc_mem_open(inode, mode);
+
+	if (IS_ERR(mm))
+		return PTR_ERR(mm);
+
+	file->private_data = mm;
+	return 0;
+}
+
+static int proc_pid_cmdline_open(struct inode *inode, struct file *file)
+{
+	return __mem_open(inode, file, PTRACE_MODE_READ);
+}
+
+static int mem_release(struct inode *inode, struct file *file)
+{
+	struct mm_struct *mm = file->private_data;
+	if (mm)
+		mmdrop(mm);
+	return 0;
+}
+
 static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 				     size_t _count, loff_t *pos)
 {
-	struct task_struct *tsk;
-	struct mm_struct *mm;
+	struct mm_struct *mm = file->private_data;
 	char *page;
 	unsigned long count = _count;
 	unsigned long arg_start, arg_end, env_start, env_end;
@@ -223,18 +246,11 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 
 	BUG_ON(*pos < 0);
 
-	tsk = get_proc_task(file_inode(file));
-	if (!tsk)
-		return -ESRCH;
-	mm = get_task_mm(tsk);
-	put_task_struct(tsk);
-	if (!mm)
-		return 0;
 	/* Check if process spawned far enough to have cmdline. */
-	if (!mm->env_end) {
-		rv = 0;
-		goto out_mmput;
-	}
+	if (!mm || !mm->env_end)
+		return 0;
+	if (!mmget_not_zero(mm))
+		return 0;
 
 	page = (char *)__get_free_page(GFP_KERNEL);
 	if (!page) {
@@ -376,8 +392,10 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 }
 
 static const struct file_operations proc_pid_cmdline_ops = {
-	.read	= proc_pid_cmdline_read,
-	.llseek	= generic_file_llseek,
+	.open		= proc_pid_cmdline_open,
+	.read		= proc_pid_cmdline_read,
+	.llseek		= generic_file_llseek,
+	.release	= mem_release,
 };
 
 #ifdef CONFIG_KALLSYMS
@@ -786,17 +804,6 @@ struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode)
 	return mm;
 }
 
-static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
-{
-	struct mm_struct *mm = proc_mem_open(inode, mode);
-
-	if (IS_ERR(mm))
-		return PTR_ERR(mm);
-
-	file->private_data = mm;
-	return 0;
-}
-
 static int mem_open(struct inode *inode, struct file *file)
 {
 	int ret = __mem_open(inode, file, PTRACE_MODE_ATTACH);
@@ -890,14 +897,6 @@ loff_t mem_lseek(struct file *file, loff_t offset, int orig)
 	return file->f_pos;
 }
 
-static int mem_release(struct inode *inode, struct file *file)
-{
-	struct mm_struct *mm = file->private_data;
-	if (mm)
-		mmdrop(mm);
-	return 0;
-}
-
 static const struct file_operations proc_mem_operations = {
 	.llseek		= mem_lseek,
 	.read		= mem_read,
