Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751639AbeBUTXp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 14:23:45 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46740 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751432AbeBUTXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 14:23:43 -0500
X-Google-Smtp-Source: AH8x2270555YkQRNPgq+EJsG1DqCEEl6EsfcmYAsDhHYhF1Abv1DOkEp2DbAYzW4UTwR7sWUFWgV0w==
Date: Wed, 21 Feb 2018 22:23:39 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] proc: make /proc/*/cmdline go through LSM
Message-ID: <20180221192339.GA28548@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/proc/*/cmdline is not different from /proc/*/environ as it accesses
target task's memory (and can access the very same region of memory)
but it doesn't go through ptrace_may_access() and thus doesn't go through LSM.

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
