Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F94ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C72520658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C72520658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbeJVRxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:53:16 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:26050 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbeJVRxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:53:16 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9M9ZFMN086279;
        Mon, 22 Oct 2018 18:35:15 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp);
 Mon, 22 Oct 2018 18:35:15 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w9M9Z8cr086106
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 22 Oct 2018 18:35:15 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [RFC v4 0/2] WhiteEgret LSM module
To:     Steve Kemp <steve.backup.kemp@gmail.com>,
        shinya1.takumi@toshiba.co.jp
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1539925672-16744-1-git-send-email-shinya1.takumi@toshiba.co.jp>
 <CABxV-EV0jYWufjEKsBw9X5AsBT5N8OQjOb2kB_QP_LYvgh-gQg@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <845ec2a1-d1a6-dbb6-35fc-04a681f878f7@I-love.SAKURA.ne.jp>
Date:   Mon, 22 Oct 2018 18:35:06 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CABxV-EV0jYWufjEKsBw9X5AsBT5N8OQjOb2kB_QP_LYvgh-gQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Kemp wrote:
> This is an interesting idea, and an evolution since the initial
> approach which was submitted based upon xattr attributes.  I still
> find the idea of using attributes simpler to manage though, since
> they're easy to add, and audit for.
> 
> I suspect the biggest objection to this module is that maintaining a
> whitelist at all is often impractical.

If existing implementations were perfect enough for everyone, we would not
have done a lot of trial and error. ;-)

> 
> My (trivial/toy/silly) module went the attribute-reading way:
> 
> https://github.com/skx/linux-security-modules/tree/master/security/whitelist
> 
> For a completely crazy take upon the idea of userspace decisions
> though you can laugh at my attempt here:
> 
> https://github.com/skx/linux-security-modules/tree/master/security/can-exec
> 
> I callback to userspace for every decision, via
> call_usermodehelper_setup.  The crazy part is that it actually works
> at all!
> 
> Steve

Oh, checking only execve() requests? I have implemented it (using AKARI as a
codebase) which does on-access ClamAV scan, without using call_usermodehelper().
The tutorial is (written in Japanese language) available at
http://I-love.SAKURA.ne.jp/tomoyo/scamp2017-kumaneko.html . Since WhiteEgret
is using a daemon rather than one-time agent, I'm sure that this example
implementation helps how to make WhiteEgret interface robust.



Here begins the feedback.

(1) Please drop module exit functions, for currently it is impossible to unload
    "loadable kernel module based LSM modules".

(2) Please add __init to all init functions, for it helps finding redundant code.

(3) Please test with CONFIG_PROVE_LOCKING=y, for there is a deadlock bug which
    lockdep can find.

(4) Please test with CONFIG_KASAN=y, for there is a use-after-free bug.

(5) Please test with CONFIG_DEBUG_ATOMIC_SLEEP=y, for there is a sleep-in-atomic bug.

(6) Please avoid redundant NULL checks.

(7) Please annotate __user to userspace pointers.

(8) Please do check size when copying kernel <=> user memory.

(9) Setting "struct file_operations"->owner is pointless, for currently it is
    impossible to unload "loadable kernel module based LSM modules".

(10) Please check the compiler output, for there is an incompatible argument warning.

(11) Please don't try to defer pending signals. If a process got a fatal signal,
     the process should be able to terminate as soon as possible.

(12) Please understand when "struct file_operations"->open/release hooks are called,
     for current "from_task" approach is not robust (and hence the tutorial above).



A delta diff is shown below, but you don't want to apply it as-is.

diff --git a/security/whiteegret/init.c b/security/whiteegret/init.c
index b78f581..c447655 100644
--- a/security/whiteegret/init.c
+++ b/security/whiteegret/init.c
@@ -23,9 +23,6 @@
 
 static int we_security_bprm_check(struct linux_binprm *bprm)
 {
-	if (!bprm)
-		return 0;
-
 	if (we_security_bprm_check_main(bprm) == -EACCES)
 		return -EACCES;
 
@@ -48,8 +45,6 @@ static int we_security_mmap_check(struct file *file, unsigned long reqprot,
 	defined(CONFIG_SECURITY_WHITEEGRET_HOOK_FILE_WRITE)
 static int we_security_access_check(struct file *file, int mask)
 {
-	if (!file)
-		return 0;
 	return we_security_access_check_main(file, mask);
 }
 #endif
@@ -58,23 +53,18 @@ static int we_security_access_check(struct file *file, int mask)
 	defined(CONFIG_SECURITY_WHITEEGRET_HOOK_WRITE_OPEN)
 static int we_security_open_check(struct file *file)
 {
-	if (!file)
-		return 0;
 	return we_security_open_check_main(file);
 }
 #endif
 
 #ifdef CONFIG_SECURITY_WHITEEGRET_HOOK_WRITE
-static int we_security_rename_check(struct path *old_dir,
+static int we_security_rename_check(const struct path *old_dir,
 				    struct dentry *old_dentry,
-				    struct path *new_dir,
+				    const struct path *new_dir,
 				    struct dentry *new_dentry)
 {
 	struct path new_path;
 
-	if (!new_dir)
-		return 0;
-
 	new_path.mnt = new_dir->mnt;
 	new_path.dentry = new_dentry;
 	return we_security_rename_check_main(&new_path);
@@ -85,17 +75,11 @@ static int we_security_rename_check(struct path *old_dir,
 static int we_task_alloc_check(struct task_struct *task,
 			       unsigned long clone_flag)
 {
-	if (!task)
-		return 0;
-
 	return we_security_task_alloc_check_main(task, clone_flag);
 }
 
 static void we_task_free_check(struct task_struct *task)
 {
-	if (!task)
-		return;
-
 	we_security_task_free_check_main(task);
 }
 #endif
@@ -137,12 +121,4 @@ static int __init we_init(void)
 	return 0;
 }
 
-static void __exit we_exit(void)
-{
-	we_specific_exit();
-
-	pr_warn("WhiteEgret (LSM) exited.\n");
-}
-
 module_init(we_init);
-module_exit(we_exit);
diff --git a/security/whiteegret/main.c b/security/whiteegret/main.c
index cc531d0..8e895b9 100644
--- a/security/whiteegret/main.c
+++ b/security/whiteegret/main.c
@@ -42,7 +42,7 @@ static int send_receive_we_obj_info(
  *
  * Returns 0.
  */
-int we_specific_init(void)
+int __init we_specific_init(void)
 {
 	int rc = 0;
 
@@ -53,20 +53,6 @@ int we_specific_init(void)
 	}
 	we_req_q_head_init();
 
-#ifdef CONFIG_SECURITY_WHITEEGRET_CHECK_LIVING_TASK
-	root_we_obj_info = NULL;
-#endif
-
-	return 0;
-}
-
-/**
- * we_specific_exit - Nothing to do in the implementation.
- *
- * Returns 0.
- */
-int we_specific_exit(void)
-{
 	return 0;
 }
 
@@ -93,12 +79,9 @@ static int we_get_path(struct path *path,
 		       char **ret_pathname, char **ret_pathnamebuf)
 {
 	char *pathname = NULL, *pathnamebuf = NULL;
-	int pathsize = PAGE_SIZE;
+	const int pathsize = PAGE_SIZE;
 	int rc = 0;
 
-	if (!path || !path->dentry)
-		goto failure;
-
 	pathnamebuf = kmalloc(pathsize, GFP_KERNEL);
 	if (unlikely(!pathnamebuf)) {
 		rc = -ENOMEM;
@@ -395,17 +378,17 @@ int we_security_task_alloc_check_main(struct task_struct *task,
 	 * the WhiteEgret User Application.
 	 */
 	while (1) {
-		write_lock(&root_we_obj_info_lock);
+		write_lock_irq(&root_we_obj_info_lock);
 		if (root_we_obj_info) {
 			node = root_we_obj_info;
 			root_we_obj_info = root_we_obj_info->next;
-			write_unlock(&root_we_obj_info_lock);
+			write_unlock_irq(&root_we_obj_info_lock);
 			if (likely(from_task))
 				rc = send_receive_we_obj_info
 					(&node->we_obj_info, &checkresult);
 			kfree(node);
 		} else {
-			write_unlock(&root_we_obj_info_lock);
+			write_unlock_irq(&root_we_obj_info_lock);
 			break;
 		}
 	}
@@ -435,11 +418,12 @@ int we_security_task_alloc_check_main(struct task_struct *task,
 void we_security_task_free_check_main(struct task_struct *task)
 {
 	struct we_obj_info_stack *node;
+	unsigned long flags;
 
 	if (unlikely(!from_task) || from_task == task)
 		return;
 
-	if (get_nr_threads(task) > 1)
+	if (get_nr_threads(task) > 1) // Bad access; use-after-free.
 		return;
 
 	node = kzalloc(sizeof(*node), GFP_ATOMIC);
@@ -458,9 +442,9 @@ void we_security_task_free_check_main(struct task_struct *task)
 	 * Notifying infomation is exit process infomation, not include
 	 * file information.
 	 */
-	write_lock(&root_we_obj_info_lock);
+	write_lock_irqsave(&root_we_obj_info_lock, flags);
 	node->next = root_we_obj_info;
 	root_we_obj_info = node;
-	write_unlock(&root_we_obj_info_lock);
+	write_unlock_irqrestore(&root_we_obj_info_lock, flags);
 }
 #endif
diff --git a/security/whiteegret/request.c b/security/whiteegret/request.c
index 8d230cb..0b6f48b 100644
--- a/security/whiteegret/request.c
+++ b/security/whiteegret/request.c
@@ -19,7 +19,7 @@
  *
  * Returns 0.
  */
-int we_req_q_head_init(void)
+int __init we_req_q_head_init(void)
 {
 	rwlock_init(&(we_q_head.lock));
 	INIT_LIST_HEAD(&(we_q_head.head));
diff --git a/security/whiteegret/request.h b/security/whiteegret/request.h
index c205c4c..273a19f 100644
--- a/security/whiteegret/request.h
+++ b/security/whiteegret/request.h
@@ -40,7 +40,7 @@ struct we_req_q {
 int we_req_q_pop(struct we_req_q *queue);
 int we_req_q_cleanup(void);
 
-int we_req_q_head_init(void);
+int __init we_req_q_head_init(void);
 int we_req_q_init(struct we_req_q *req, struct we_obj_info *info);
 int we_req_q_push(struct we_req_q *queue);
 
diff --git a/security/whiteegret/we.h b/security/whiteegret/we.h
index e8f067c..7812242 100644
--- a/security/whiteegret/we.h
+++ b/security/whiteegret/we.h
@@ -66,7 +66,6 @@ int we_security_task_alloc_check_main(struct task_struct *task,
 				      unsigned long clone_flags);
 void we_security_task_free_check_main(struct task_struct *task);
 
-int we_specific_init(void);
-int we_specific_exit(void);
+int __init we_specific_init(void);
 
 #endif  /* _WE_H */
diff --git a/security/whiteegret/we_fs.c b/security/whiteegret/we_fs.c
index 57f77aa..af7c3f6 100644
--- a/security/whiteegret/we_fs.c
+++ b/security/whiteegret/we_fs.c
@@ -16,6 +16,7 @@
 #include <linux/wait.h>
 #include <linux/sched.h>
 #include <linux/uaccess.h>
+#include <linux/sched/task.h>
 #include "we_fs.h"
 #include "we.h"
 
@@ -31,7 +32,7 @@ static int check_we_pathsize(struct we_req_q *we_req, int size)
 		return -1;
 }
 
-static int set_we_req_info(struct we_req_user *user,
+static int set_we_req_info(struct we_req_user __user *user,
 		struct we_obj_info *info)
 {
 	unsigned long ret;
@@ -49,7 +50,7 @@ static int set_we_req_info(struct we_req_user *user,
 	return 0;
 }
 
-static int set_we_ack(struct we_ack *to, struct we_ack *from)
+static int set_we_ack(struct we_ack *to, const void __user *from)
 {
 	unsigned long ret;
 
@@ -60,12 +61,12 @@ static int set_we_ack(struct we_ack *to, struct we_ack *from)
 	return 0;
 }
 
-static struct we_req_user *get_alive_we_req(void *buf, int size)
+static struct we_req_user __user *get_alive_we_req(void __user *buf, int size)
 {
 	int pathsize;
 	struct list_head *p;
 	struct we_req_q *req;
-	struct we_req_user *user = NULL;
+	struct we_req_user __user *user = NULL;
 
 	write_lock(&we_q_head.lock);
 	list_for_each(p, &we_q_head.head) {
@@ -73,8 +74,8 @@ static struct we_req_user *get_alive_we_req(void *buf, int size)
 		if (req->finish_flag == STOP_EXEC) {
 			if (unlikely(check_we_pathsize(req, size)))
 				goto SIZE_ERROR;
-			user = (struct we_req_user *)buf;
-			set_we_req_info(user, req->we_obj_info);
+			user = (struct we_req_user __user *)buf;
+			set_we_req_info(user, req->we_obj_info); // Bad access; sleep-in-atomic.
 			break;
 		}
 	}
@@ -117,7 +118,7 @@ static ssize_t send_ack(struct we_ack *ack)
 	return sizeof(*ack);
 }
 
-static ssize_t we_driver_read(struct file *file, char *buf,
+static ssize_t we_driver_read(struct file *file, char __user *buf,
 		size_t size, loff_t *off)
 {
 	int ret;
@@ -137,14 +138,16 @@ static ssize_t we_driver_read(struct file *file, char *buf,
 	return 1;
 }
 
-static ssize_t we_driver_write(struct file *file, const char *buf,
+static ssize_t we_driver_write(struct file *file, const char __user *buf,
 		size_t size, loff_t *off)
 {
 	int rc;
 	ssize_t ret;
 	struct we_ack ack;
 
-	rc = set_we_ack(&ack, (struct we_ack *)((void *)buf));
+	if (size != sizeof(ack))
+		return -EINVAL;
+	rc = set_we_ack(&ack, buf);
 	if (rc < 0)
 		return (ssize_t)rc;
 	ret = send_ack(&ack);
@@ -186,6 +189,7 @@ static long we_driver_ioctl(struct file *file,
 static int we_driver_release(struct inode *inode, struct file *filp)
 {
 	int ret = 0;
+	struct task_struct *task = NULL;
 
 	write_lock(&from_task_lock);
 	if (!from_task) {
@@ -193,21 +197,26 @@ static int we_driver_release(struct inode *inode, struct file *filp)
 		ret =  -EACCES;
 		goto END;
 	}
+	// Bad assumption; fork() etc. can make this condition false.
 	if (from_task != current) {
 		pr_warn("This task is not registered to WhiteEgret.\n");
 		ret = -EACCES;
 		goto END;
 	}
+	task = from_task;
 	from_task = NULL;
 	we_req_q_cleanup();
 END:
 	write_unlock(&from_task_lock);
+	if (task)
+		put_task_struct(task);
 	return ret;
 }
 
 static int we_driver_open(struct inode *inode, struct file *filp)
 {
 	write_lock(&from_task_lock);
+	// Bad assumption; fork() etc. does not hit this condition.
 	if (from_task) {
 		write_unlock(&(from_task_lock));
 		pr_warn("WhiteEgret has already started.\n");
@@ -215,13 +224,13 @@ static int we_driver_open(struct inode *inode, struct file *filp)
 	}
 
 	from_task = current;
+	get_task_struct(from_task);
 	write_unlock(&from_task_lock);
 
 	return 0;
 }
 
 static const struct file_operations we_driver_fops = {
-	.owner = THIS_MODULE,
 	.read = we_driver_read,
 	.write = we_driver_write,
 	.unlocked_ioctl = we_driver_ioctl,
@@ -229,7 +238,7 @@ static int we_driver_open(struct inode *inode, struct file *filp)
 	.release = we_driver_release,
 };
 
-int we_fs_init(void)
+int __init we_fs_init(void)
 {
 	struct dentry *we_dir;
 	struct dentry *wecom;
diff --git a/security/whiteegret/we_fs.h b/security/whiteegret/we_fs.h
index ffb7775..f3d69bc 100644
--- a/security/whiteegret/we_fs.h
+++ b/security/whiteegret/we_fs.h
@@ -17,7 +17,7 @@
 
 extern struct task_struct *from_task;
 
-int we_fs_init(void);
+int __init we_fs_init(void);
 int send_we_obj_info(struct we_req_q *req);
 
 #endif  /* _WE_FS_H */







Regarding (4), you can comfirm that get_nr_threads(task) returns 0x6b6b6b6b, using
below demo patch and reproducer. When copy_process() failed after copy_signal()
succeeded, security_task_free() is called after free_signal_struct() is called.

diff --git a/kernel/fork.c b/kernel/fork.c
index f0b5847..11714dd 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1939,6 +1939,12 @@ static __latent_entropy struct task_struct *copy_process(
 	p->task_works = NULL;
 
 	cgroup_threadgroup_change_begin(current);
+
+	if (!strcmp(current->comm, "a.out")) {
+		retval = -ENOMEM;
+		goto bad_fork_free_pid;
+	}
+
 	/*
 	 * Ensure that the cgroup subsystem policies allow the new process to be
 	 * forked. It should be noted the the new process's css_set can be changed

---------- source code of a.out ----------
#include <unistd.h>

int main(int argc, char *argv[])
{
	if (fork() == 0)
		_exit(0);
	return 0;
}
---------- source code of a.out ----------



Regarding (12), you can comfirm that "from_task" logic is broken, using below
reproducer. Since "struct file_operations"->release hook is called when refcount
becomes 0, it is not always the thread who called "struct file_operations"->open
hook. The thread which "from_task" remembers can terminate before "from_task" is
reset to NULL. The kernel side has to be prepared for such situation. You can
hold a refcount using get_task_struct()/put_task_struct(), but "from_task" logic
is still fragile. You need to reconsider how to distinguish requests from
WhiteEgret User Application.

---------- source code of b.out ----------
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
	if (open("/sys/kernel/security/whiteegret/wecom", O_RDWR) < 0)
		return 1;
	if (fork() == 0) {
		sleep(1);
		_exit(0);
	}
	return 0;
}
---------- source code of b.out ----------

