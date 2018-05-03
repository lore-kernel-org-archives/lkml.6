Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbeECEg7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 00:36:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44758 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751881AbeECEgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 00:36:09 -0400
Smtp-Origin-Hostprefix: devbig
From: Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig500.prn1.facebook.com
To: <davem@davemloft.net>
CC: <daniel@iogearbox.net>, <torvalds@linux-foundation.org>,
        <gregkh@linuxfoundation.org>, <luto@amacapital.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: prn1c29
Subject: [PATCH v2 net-next 1/4] umh: introduce fork_usermode_blob() helper
Date: Wed, 2 May 2018 21:36:01 -0700
Message-ID: <20180503043604.1604587-2-ast@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180503043604.1604587-1-ast@kernel.org>
References: <20180503043604.1604587-1-ast@kernel.org>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce helper:
int fork_usermode_blob(void *data, size_t len, struct umh_info *info);
struct umh_info {
       struct file *pipe_to_umh;
       struct file *pipe_from_umh;
       pid_t pid;
};

that GPLed kernel modules (signed or unsigned) can use it to execute part
of its own data as swappable user mode process.

The kernel will do:
- mount "tmpfs"
- allocate a unique file in tmpfs
- populate that file with [data, data + len] bytes
- user-mode-helper code will do_execve that file and, before the process
  starts, the kernel will create two unix pipes for bidirectional
  communication between kernel module and umh
- close tmpfs file, effectively deleting it
- the fork_usermode_blob will return zero on success and populate
  'struct umh_info' with two unix pipes and the pid of the user process

As the first step in the development of the bpfilter project
the fork_usermode_blob() helper is introduced to allow user mode code
to be invoked from a kernel module. The idea is that user mode code plus
normal kernel module code are built as part of the kernel build
and installed as traditional kernel module into distro specified location,
such that from a distribution point of view, there is
no difference between regular kernel modules and kernel modules + umh code.
Such modules can be signed, modprobed, rmmod, etc. The use of this new helper
by a kernel module doesn't make it any special from kernel and user space
tooling point of view.

Such approach enables kernel to delegate functionality traditionally done
by the kernel modules into the user space processes (either root or !root) and
reduces security attack surface of the new code. The buggy umh code would crash
the user process, but not the kernel. Another advantage is that umh code
of the kernel module can be debugged and tested out of user space
(e.g. opening the possibility to run clang sanitizers, fuzzers or
user space test suites on the umh code).
In case of the bpfilter project such architecture allows complex control plane
to be done in the user space while bpf based data plane stays in the kernel.

Since umh can crash, can be oom-ed by the kernel, killed by the admin,
the kernel module that uses them (like bpfilter) needs to manage life
time of umh on its own via two unix pipes and the pid of umh.

The exit code of such kernel module should kill the umh it started,
so that rmmod of the kernel module will cleanup the corresponding umh.
Just like if the kernel module does kmalloc() it should kfree() it in the exit code.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 fs/exec.c               |  38 ++++++++---
 include/linux/binfmts.h |   1 +
 include/linux/umh.h     |  12 ++++
 kernel/umh.c            | 176 +++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 215 insertions(+), 12 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 183059c427b9..30a36c2a39bf 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1706,14 +1706,13 @@ static int exec_binprm(struct linux_binprm *bprm)
 /*
  * sys_execve() executes a new program.
  */
-static int do_execveat_common(int fd, struct filename *filename,
-			      struct user_arg_ptr argv,
-			      struct user_arg_ptr envp,
-			      int flags)
+static int __do_execve_file(int fd, struct filename *filename,
+			    struct user_arg_ptr argv,
+			    struct user_arg_ptr envp,
+			    int flags, struct file *file)
 {
 	char *pathbuf = NULL;
 	struct linux_binprm *bprm;
-	struct file *file;
 	struct files_struct *displaced;
 	int retval;
 
@@ -1752,7 +1751,8 @@ static int do_execveat_common(int fd, struct filename *filename,
 	check_unsafe_exec(bprm);
 	current->in_execve = 1;
 
-	file = do_open_execat(fd, filename, flags);
+	if (!file)
+		file = do_open_execat(fd, filename, flags);
 	retval = PTR_ERR(file);
 	if (IS_ERR(file))
 		goto out_unmark;
@@ -1760,7 +1760,9 @@ static int do_execveat_common(int fd, struct filename *filename,
 	sched_exec();
 
 	bprm->file = file;
-	if (fd == AT_FDCWD || filename->name[0] == '/') {
+	if (!filename) {
+		bprm->filename = "none";
+	} else if (fd == AT_FDCWD || filename->name[0] == '/') {
 		bprm->filename = filename->name;
 	} else {
 		if (filename->name[0] == '\0')
@@ -1826,7 +1828,8 @@ static int do_execveat_common(int fd, struct filename *filename,
 	task_numa_free(current);
 	free_bprm(bprm);
 	kfree(pathbuf);
-	putname(filename);
+	if (filename)
+		putname(filename);
 	if (displaced)
 		put_files_struct(displaced);
 	return retval;
@@ -1849,10 +1852,27 @@ static int do_execveat_common(int fd, struct filename *filename,
 	if (displaced)
 		reset_files_struct(displaced);
 out_ret:
-	putname(filename);
+	if (filename)
+		putname(filename);
 	return retval;
 }
 
+static int do_execveat_common(int fd, struct filename *filename,
+			      struct user_arg_ptr argv,
+			      struct user_arg_ptr envp,
+			      int flags)
+{
+	return __do_execve_file(fd, filename, argv, envp, flags, NULL);
+}
+
+int do_execve_file(struct file *file, void *__argv, void *__envp)
+{
+	struct user_arg_ptr argv = { .ptr.native = __argv };
+	struct user_arg_ptr envp = { .ptr.native = __envp };
+
+	return __do_execve_file(AT_FDCWD, NULL, argv, envp, 0, file);
+}
+
 int do_execve(struct filename *filename,
 	const char __user *const __user *__argv,
 	const char __user *const __user *__envp)
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 4955e0863b83..c05f24fac4f6 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -150,5 +150,6 @@ extern int do_execveat(int, struct filename *,
 		       const char __user * const __user *,
 		       const char __user * const __user *,
 		       int);
+int do_execve_file(struct file *file, void *__argv, void *__envp);
 
 #endif /* _LINUX_BINFMTS_H */
diff --git a/include/linux/umh.h b/include/linux/umh.h
index 244aff638220..5c812acbb80a 100644
--- a/include/linux/umh.h
+++ b/include/linux/umh.h
@@ -22,8 +22,10 @@ struct subprocess_info {
 	const char *path;
 	char **argv;
 	char **envp;
+	struct file *file;
 	int wait;
 	int retval;
+	pid_t pid;
 	int (*init)(struct subprocess_info *info, struct cred *new);
 	void (*cleanup)(struct subprocess_info *info);
 	void *data;
@@ -38,6 +40,16 @@ call_usermodehelper_setup(const char *path, char **argv, char **envp,
 			  int (*init)(struct subprocess_info *info, struct cred *new),
 			  void (*cleanup)(struct subprocess_info *), void *data);
 
+struct subprocess_info *call_usermodehelper_setup_file(struct file *file,
+			  int (*init)(struct subprocess_info *info, struct cred *new),
+			  void (*cleanup)(struct subprocess_info *), void *data);
+struct umh_info {
+	struct file *pipe_to_umh;
+	struct file *pipe_from_umh;
+	pid_t pid;
+};
+int fork_usermode_blob(void *data, size_t len, struct umh_info *info);
+
 extern int
 call_usermodehelper_exec(struct subprocess_info *info, int wait);
 
diff --git a/kernel/umh.c b/kernel/umh.c
index f76b3ff876cf..c3f418d7d51a 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -25,6 +25,8 @@
 #include <linux/ptrace.h>
 #include <linux/async.h>
 #include <linux/uaccess.h>
+#include <linux/shmem_fs.h>
+#include <linux/pipe_fs_i.h>
 
 #include <trace/events/module.h>
 
@@ -97,9 +99,13 @@ static int call_usermodehelper_exec_async(void *data)
 
 	commit_creds(new);
 
-	retval = do_execve(getname_kernel(sub_info->path),
-			   (const char __user *const __user *)sub_info->argv,
-			   (const char __user *const __user *)sub_info->envp);
+	if (sub_info->file)
+		retval = do_execve_file(sub_info->file,
+					sub_info->argv, sub_info->envp);
+	else
+		retval = do_execve(getname_kernel(sub_info->path),
+				   (const char __user *const __user *)sub_info->argv,
+				   (const char __user *const __user *)sub_info->envp);
 out:
 	sub_info->retval = retval;
 	/*
@@ -185,6 +191,8 @@ static void call_usermodehelper_exec_work(struct work_struct *work)
 		if (pid < 0) {
 			sub_info->retval = pid;
 			umh_complete(sub_info);
+		} else {
+			sub_info->pid = pid;
 		}
 	}
 }
@@ -393,6 +401,168 @@ struct subprocess_info *call_usermodehelper_setup(const char *path, char **argv,
 }
 EXPORT_SYMBOL(call_usermodehelper_setup);
 
+struct subprocess_info *call_usermodehelper_setup_file(struct file *file,
+		int (*init)(struct subprocess_info *info, struct cred *new),
+		void (*cleanup)(struct subprocess_info *info), void *data)
+{
+	struct subprocess_info *sub_info;
+
+	sub_info = kzalloc(sizeof(struct subprocess_info), GFP_KERNEL);
+	if (!sub_info)
+		return NULL;
+
+	INIT_WORK(&sub_info->work, call_usermodehelper_exec_work);
+	sub_info->path = "none";
+	sub_info->file = file;
+	sub_info->init = init;
+	sub_info->cleanup = cleanup;
+	sub_info->data = data;
+	return sub_info;
+}
+
+static struct vfsmount *umh_fs;
+
+static int init_tmpfs(void)
+{
+	struct file_system_type *type;
+
+	if (umh_fs)
+		return 0;
+	type = get_fs_type("tmpfs");
+	if (!type)
+		return -ENODEV;
+	umh_fs = kern_mount(type);
+	if (IS_ERR(umh_fs)) {
+		int err = PTR_ERR(umh_fs);
+
+		put_filesystem(type);
+		umh_fs = NULL;
+		return err;
+	}
+	return 0;
+}
+
+static int alloc_tmpfs_file(size_t size, struct file **filp)
+{
+	struct file *file;
+	int err;
+
+	err = init_tmpfs();
+	if (err)
+		return err;
+	file = shmem_file_setup_with_mnt(umh_fs, "umh", size, VM_NORESERVE);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+	*filp = file;
+	return 0;
+}
+
+static int populate_file(struct file *file, const void *data, size_t size)
+{
+	size_t offset = 0;
+	int err;
+
+	do {
+		unsigned int len = min_t(typeof(size), size, PAGE_SIZE);
+		struct page *page;
+		void *pgdata, *vaddr;
+
+		err = pagecache_write_begin(file, file->f_mapping, offset, len,
+					    0, &page, &pgdata);
+		if (err < 0)
+			goto fail;
+
+		vaddr = kmap(page);
+		memcpy(vaddr, data, len);
+		kunmap(page);
+
+		err = pagecache_write_end(file, file->f_mapping, offset, len,
+					  len, page, pgdata);
+		if (err < 0)
+			goto fail;
+
+		size -= len;
+		data += len;
+		offset += len;
+	} while (size);
+	return 0;
+fail:
+	return err;
+}
+
+static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
+{
+	struct umh_info *umh_info = info->data;
+	struct file *from_umh[2];
+	struct file *to_umh[2];
+	int err;
+
+	/* create pipe to send data to umh */
+	err = create_pipe_files(to_umh, 0);
+	if (err)
+		return err;
+	err = replace_fd(0, to_umh[0], 0);
+	fput(to_umh[0]);
+	if (err < 0) {
+		fput(to_umh[1]);
+		return err;
+	}
+
+	/* create pipe to receive data from umh */
+	err = create_pipe_files(from_umh, 0);
+	if (err) {
+		fput(to_umh[1]);
+		replace_fd(0, NULL, 0);
+		return err;
+	}
+	err = replace_fd(1, from_umh[1], 0);
+	fput(from_umh[1]);
+	if (err < 0) {
+		fput(to_umh[1]);
+		replace_fd(0, NULL, 0);
+		fput(from_umh[0]);
+		return err;
+	}
+
+	umh_info->pipe_to_umh = to_umh[1];
+	umh_info->pipe_from_umh = from_umh[0];
+	return 0;
+}
+
+static void umh_save_pid(struct subprocess_info *info)
+{
+	struct umh_info *umh_info = info->data;
+
+	umh_info->pid = info->pid;
+}
+
+int fork_usermode_blob(void *data, size_t len, struct umh_info *info)
+{
+	struct subprocess_info *sub_info;
+	struct file *file = NULL;
+	int err;
+
+	err = alloc_tmpfs_file(len, &file);
+	if (err)
+		return err;
+
+	err = populate_file(file, data, len);
+	if (err)
+		goto out;
+
+	err = -ENOMEM;
+	sub_info = call_usermodehelper_setup_file(file, umh_pipe_setup,
+						  umh_save_pid, info);
+	if (!sub_info)
+		goto out;
+
+	err = call_usermodehelper_exec(sub_info, UMH_WAIT_EXEC);
+out:
+	fput(file);
+	return err;
+}
+EXPORT_SYMBOL_GPL(fork_usermode_blob);
+
 /**
  * call_usermodehelper_exec - start a usermode application
  * @sub_info: information about the subprocessa
-- 
2.9.5
