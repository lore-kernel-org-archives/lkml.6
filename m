Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755537AbeD3XUi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 19:20:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752614AbeD3XUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 19:20:35 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/3] proc: Add a way to make network proc files writable
From: David Howells <dhowells@redhat.com>
To: hch@lst.de
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Tue, 01 May 2018 00:20:33 +0100
Message-ID: <152513043358.13808.4250608064312146536.stgit@warthog.procyon.org.uk>
In-Reply-To: <152513042072.13808.9692322366778075206.stgit@warthog.procyon.org.uk>
References: <152513042072.13808.9692322366778075206.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide two extra functions, proc_create_net_data_write() and
proc_create_net_single_write() that act like their non-write versions but
also set a write method in the proc_dir_entry struct.

An internal simple write function is provided that will copy its buffer and
hand it to the pde->write() method if available (or give an error if not).
The buffer may be modified by the write method.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/proc/generic.c       |   24 ++++++++++++
 fs/proc/internal.h      |    2 +
 fs/proc/proc_net.c      |   92 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/proc_fs.h |   12 ++++++
 4 files changed, 130 insertions(+)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 02bb1914f5f7..d0e5a68ae14a 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -741,3 +741,27 @@ void *PDE_DATA(const struct inode *inode)
 	return __PDE_DATA(inode);
 }
 EXPORT_SYMBOL(PDE_DATA);
+
+/*
+ * Pull a user buffer into memory and pass it to the file's write handler if
+ * one is supplied.  The ->write() method is permitted to modify the
+ * kernel-side buffer.
+ */
+ssize_t proc_simple_write(struct file *f, const char __user *ubuf, size_t size,
+			  loff_t *_pos)
+{
+	struct proc_dir_entry *pde = PDE(file_inode(f));
+	char *buf;
+	int ret;
+
+	if (!pde->write)
+		return -EACCES;
+	if (size == 0 || size > PAGE_SIZE - 1)
+		return -EINVAL;
+	buf = memdup_user_nul(ubuf, size);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+	ret = pde->write(f, buf, size);
+	kfree(buf);
+	return ret == 0 ? size : ret;
+}
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 6d171485c45b..0f3eeed2767a 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -48,6 +48,7 @@ struct proc_dir_entry {
 		const struct seq_operations *seq_ops;
 		int (*single_show)(struct seq_file *, void *);
 	};
+	proc_write_t write;
 	unsigned int state_size;
 	void *data;
 	unsigned int low_ino;
@@ -187,6 +188,7 @@ static inline bool is_empty_pde(const struct proc_dir_entry *pde)
 {
 	return S_ISDIR(pde->mode) && !pde->proc_iops;
 }
+extern ssize_t proc_simple_write(struct file *, const char __user *, size_t, loff_t *);
 
 /*
  * inode.c
diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
index baf1994289ce..690764714fc3 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -46,6 +46,9 @@ static int seq_open_net(struct inode *inode, struct file *file)
 
 	WARN_ON_ONCE(state_size < sizeof(*p));
 
+	if (file->f_mode & FMODE_WRITE && !PDE(inode)->write)
+		return -EACCES;
+
 	net = get_proc_net(inode);
 	if (!net)
 		return -ENXIO;
@@ -73,6 +76,7 @@ static int seq_release_net(struct inode *ino, struct file *f)
 static const struct file_operations proc_net_seq_fops = {
 	.open		= seq_open_net,
 	.read		= seq_read,
+	.write		= proc_simple_write,
 	.llseek		= seq_lseek,
 	.release	= seq_release_net,
 };
@@ -93,6 +97,50 @@ struct proc_dir_entry *proc_create_net_data(const char *name, umode_t mode,
 }
 EXPORT_SYMBOL_GPL(proc_create_net_data);
 
+/**
+ * proc_create_net_data_write - Create a writable net_ns-specific proc file
+ * @name: The name of the file.
+ * @mode: The file's access mode.
+ * @parent: The parent directory in which to create.
+ * @ops: The seq_file ops with which to read the file.
+ * @write: The write method which which to 'modify' the file.
+ * @data: Data for retrieval by PDE_DATA().
+ *
+ * Create a network namespaced proc file in the @parent directory with the
+ * specified @name and @mode that allows reading of a file that displays a
+ * series of elements and also provides for the file accepting writes that have
+ * some arbitrary effect.
+ *
+ * The functions in the @ops table are used to iterate over items to be
+ * presented and extract the readable content using the seq_file interface.
+ *
+ * The @write function is called with the data copied into a kernel space
+ * scratch buffer and has a NUL appended for convenience.  The buffer may be
+ * modified by the @write function.  @write should return 0 on success.
+ *
+ * The @data value is accessible from the @show and @write functions by calling
+ * PDE_DATA() on the file inode.  The network namespace must be accessed by
+ * calling seq_file_net() on the seq_file struct.
+ */
+struct proc_dir_entry *proc_create_net_data_write(const char *name, umode_t mode,
+						  struct proc_dir_entry *parent,
+						  const struct seq_operations *ops,
+						  proc_write_t write,
+						  unsigned int state_size, void *data)
+{
+	struct proc_dir_entry *p;
+
+	p = proc_create_reg(name, mode, &parent, data);
+	if (!p)
+		return NULL;
+	p->proc_fops = &proc_net_seq_fops;
+	p->seq_ops = ops;
+	p->state_size = state_size;
+	p->write = write;
+	return proc_register(parent, p);
+}
+EXPORT_SYMBOL_GPL(proc_create_net_data_write);
+
 static int single_open_net(struct inode *inode, struct file *file)
 {
 	struct proc_dir_entry *de = PDE(inode);
@@ -119,6 +167,7 @@ static int single_release_net(struct inode *ino, struct file *f)
 static const struct file_operations proc_net_single_fops = {
 	.open		= single_open_net,
 	.read		= seq_read,
+	.write		= proc_simple_write,
 	.llseek		= seq_lseek,
 	.release	= single_release_net,
 };
@@ -138,6 +187,49 @@ struct proc_dir_entry *proc_create_net_single(const char *name, umode_t mode,
 }
 EXPORT_SYMBOL_GPL(proc_create_net_single);
 
+/**
+ * proc_create_net_single_write - Create a writable net_ns-specific proc file
+ * @name: The name of the file.
+ * @mode: The file's access mode.
+ * @parent: The parent directory in which to create.
+ * @show: The seqfile show method with which to read the file.
+ * @write: The write method which which to 'modify' the file.
+ * @data: Data for retrieval by PDE_DATA().
+ *
+ * Create a network-namespaced proc file in the @parent directory with the
+ * specified @name and @mode that allows reading of a file that displays a
+ * single element rather than a series and also provides for the file accepting
+ * writes that have some arbitrary effect.
+ *
+ * The @show function is called to extract the readable content via the
+ * seq_file interface.
+ *
+ * The @write function is called with the data copied into a kernel space
+ * scratch buffer and has a NUL appended for convenience.  The buffer may be
+ * modified by the @write function.  @write should return 0 on success.
+ *
+ * The @data value is accessible from the @show and @write functions by calling
+ * PDE_DATA() on the file inode.  The network namespace must be accessed by
+ * calling seq_file_single_net() on the seq_file struct.
+ */
+struct proc_dir_entry *proc_create_net_single_write(const char *name, umode_t mode,
+						    struct proc_dir_entry *parent,
+						    int (*show)(struct seq_file *, void *),
+						    proc_write_t write,
+						    void *data)
+{
+	struct proc_dir_entry *p;
+
+	p = proc_create_reg(name, mode, &parent, data);
+	if (!p)
+		return NULL;
+	p->proc_fops = &proc_net_single_fops;
+	p->single_show = show;
+	p->write = write;
+	return proc_register(parent, p);
+}
+EXPORT_SYMBOL_GPL(proc_create_net_single_write);
+
 static struct net *get_proc_task_net(struct inode *dir)
 {
 	struct task_struct *task;
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 928c7b2cbff4..33187c55eb8a 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -14,6 +14,8 @@ struct seq_operations;
 
 #ifdef CONFIG_PROC_FS
 
+typedef int (*proc_write_t)(struct file *, char *, size_t);
+
 extern void proc_root_init(void);
 extern void proc_flush_task(struct task_struct *);
 
@@ -61,6 +63,16 @@ struct proc_dir_entry *proc_create_net_data(const char *name, umode_t mode,
 struct proc_dir_entry *proc_create_net_single(const char *name, umode_t mode,
 		struct proc_dir_entry *parent,
 		int (*show)(struct seq_file *, void *), void *data);
+struct proc_dir_entry *proc_create_net_data_write(const char *name, umode_t mode,
+						  struct proc_dir_entry *parent,
+						  const struct seq_operations *ops,
+						  proc_write_t write,
+						  unsigned int state_size, void *data);
+struct proc_dir_entry *proc_create_net_single_write(const char *name, umode_t mode,
+						    struct proc_dir_entry *parent,
+						    int (*show)(struct seq_file *, void *),
+						    proc_write_t write,
+						    void *data);
 
 #else /* CONFIG_PROC_FS */
 
