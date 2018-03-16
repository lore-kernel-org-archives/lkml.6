Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753823AbeCPLNN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 07:13:13 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:64313 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753609AbeCPLNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 07:13:12 -0400
From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kexec@lists.infradead.org
Cc: davem@davemloft.net, ebiederm@xmission.com, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, ganeshgr@chelsio.com,
        nirranjan@chelsio.com, indranil@chelsio.com,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Subject: [RFC v2 1/2] proc/crashdd: add API to collect hardware dump in second kernel
Date: Fri, 16 Mar 2018 16:42:04 +0530
Message-Id: <1521198725-13463-2-git-send-email-rahul.lakkireddy@chelsio.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <1521198725-13463-1-git-send-email-rahul.lakkireddy@chelsio.com>
References: <1521198725-13463-1-git-send-email-rahul.lakkireddy@chelsio.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new module crashdd that exports the /proc/crashdd/ directory
in second kernel, containing collected hardware/firmware dumps.

The sequence of actions done by device drivers to append their device
specific hardware/firmware logs to /proc/crashdd/ directory are as
follows:

1. During probe (before hardware is initialized), device drivers
register to the crashdd module (via crashdd_add_dump()), with
callback function, along with buffer size and log name needed for
firmware/hardware log collection.

2. Crashdd creates a driver's directory under /proc/crashdd/<driver>.
Then, it allocates the buffer with requested size and invokes the
device driver's registered callback function.

3. Device driver collects all hardware/firmware logs into the buffer
and returns control back to crashdd.

4. Crashdd exposes the buffer as a file via
/proc/crashdd/<driver>/<dump_file>.

Signed-off-by: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
---
v2:
- Patch added in this series.

 fs/proc/Kconfig         |  11 ++
 fs/proc/Makefile        |   1 +
 fs/proc/crashdd.c       | 263 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/crashdd.h |  43 ++++++++
 4 files changed, 318 insertions(+)
 create mode 100644 fs/proc/crashdd.c
 create mode 100644 include/linux/crashdd.h

diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
index 1ade1206bb89..c378edffe7b3 100644
--- a/fs/proc/Kconfig
+++ b/fs/proc/Kconfig
@@ -43,6 +43,17 @@ config PROC_VMCORE
         help
         Exports the dump image of crashed kernel in ELF format.
 
+config PROC_CRASH_DRIVER_DUMP
+	bool "/proc/crashdd support"
+	depends on PROC_FS && CRASH_DUMP
+	default y
+        ---help---
+	Device drivers can collect the device specific snapshot of
+	their hardware or firmware before they are initialized in
+	crash recovery kernel. If you say Y here a tree of device
+	specific dumps will be made available under /proc/crashdd/
+	directory.
+
 config PROC_SYSCTL
 	bool "Sysctl support (/proc/sys)" if EXPERT
 	depends on PROC_FS
diff --git a/fs/proc/Makefile b/fs/proc/Makefile
index ead487e80510..73883bc857b5 100644
--- a/fs/proc/Makefile
+++ b/fs/proc/Makefile
@@ -33,3 +33,4 @@ proc-$(CONFIG_PROC_KCORE)	+= kcore.o
 proc-$(CONFIG_PROC_VMCORE)	+= vmcore.o
 proc-$(CONFIG_PRINTK)	+= kmsg.o
 proc-$(CONFIG_PROC_PAGE_MONITOR)	+= page.o
+proc-$(CONFIG_PROC_CRASH_DRIVER_DUMP) += crashdd.o
diff --git a/fs/proc/crashdd.c b/fs/proc/crashdd.c
new file mode 100644
index 000000000000..c7585031541e
--- /dev/null
+++ b/fs/proc/crashdd.c
@@ -0,0 +1,263 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/uaccess.h>
+#include <linux/vmalloc.h>
+#include <linux/crash_dump.h>
+#include <linux/crashdd.h>
+#include "internal.h"
+
+static LIST_HEAD(crashdd_list);
+static DEFINE_MUTEX(crashdd_mutex);
+
+#define CRASHDD_PROC_PERM 400 /* S_ISRUSR */
+static struct proc_dir_entry *proc_crashdd;
+
+static ssize_t crashdd_read_data(struct file *file, char __user *buffer,
+				 size_t buflen, loff_t *fpos)
+{
+	struct crashdd_dump_node *dump = PDE_DATA(file->f_inode);
+	unsigned long len;
+	char *start;
+
+	if (*fpos < 0)
+		return -EINVAL;
+
+	if (!dump || !buflen)
+		return 0;
+
+	if (*fpos >= dump->size)
+		return 0;
+
+	len = dump->size - *fpos;
+	if (len > buflen)
+		len = buflen;
+
+	start = (char *)dump->buf + *fpos;
+	if (copy_to_user(buffer, start, len))
+		return -EFAULT;
+
+	*fpos += len;
+	return len;
+}
+
+static const struct file_operations proc_crashdd_ops = {
+	.read   = crashdd_read_data,
+	.llseek = default_llseek,
+	.open   = simple_open,
+};
+
+static void *crashdd_proc_mkdir(const char *name)
+{
+	return proc_mkdir_mode(name, CRASHDD_PROC_PERM, proc_crashdd);
+}
+
+static void *crashdd_proc_add(struct proc_dir_entry *parent,
+			      const char *name, void *dump)
+{
+	return proc_create_data(name, CRASHDD_PROC_PERM, parent,
+				&proc_crashdd_ops, dump);
+}
+
+static void crashdd_proc_del(struct proc_dir_entry *entry)
+{
+	proc_remove(entry);
+}
+
+/**
+ * crashdd_init_driver - create a proc driver context.
+ * @name: Name of the directory.
+ *
+ * Creates a directory under /proc/crashdd/ with @name.  Allocates and
+ * saves the proc context.  The proc context is added to the global list
+ * and then returned to the caller. On failure, returns NULL.
+ */
+static struct crashdd_driver_node *crashdd_init_driver(const char *name)
+{
+	struct crashdd_driver_node *node;
+
+	node = vzalloc(sizeof(*node));
+	if (!node)
+		return NULL;
+
+	/* Create a driver's directory under /proc/crashdd/ */
+	node->proc_node = crashdd_proc_mkdir(name);
+	if (!node->proc_node) {
+		vfree(node);
+		return NULL;
+	}
+
+	atomic_set(&node->refcnt, 1);
+
+	/* Initialize the list of dumps that go under this driver's
+	 * directory.
+	 */
+	INIT_LIST_HEAD(&node->dump_list);
+
+	/* Add the driver's context to global list */
+	mutex_lock(&crashdd_mutex);
+	list_add_tail(&node->list, &crashdd_list);
+	mutex_unlock(&crashdd_mutex);
+
+	return node;
+}
+
+/**
+ * crashdd_get_driver - get an exisiting proc driver context.
+ * @name: Name of the directory.
+ *
+ * Searches and fetches a proc context having @name.  If @name is
+ * found, then the reference count is incremented and the context
+ * is returned.  If @name is not found, NULL is returned.
+ */
+static struct crashdd_driver_node *crashdd_get_driver(const char *name)
+{
+	struct crashdd_driver_node *node;
+	int found = 0;
+
+	/* Search for an existing driver context having @name */
+	mutex_lock(&crashdd_mutex);
+	list_for_each_entry(node, &crashdd_list, list) {
+		if (!strcmp(node->proc_node->name, name)) {
+			atomic_inc(&node->refcnt);
+			found = 1;
+			break;
+		}
+	}
+	mutex_unlock(&crashdd_mutex);
+
+	if (found)
+		return node;
+
+	/* No driver with @name found */
+	return NULL;
+}
+
+/**
+ * crashdd_put_driver - put an exisiting proc driver context.
+ * @node: driver proc context
+ *
+ * Decrement @node reference count.  If there are no dumps left under it,
+ * delete the proc directory and remove it from the global list.
+ */
+static void crashdd_put_driver(struct crashdd_driver_node *node)
+{
+	mutex_lock(&crashdd_mutex);
+	if (atomic_dec_and_test(&node->refcnt)) {
+		/* Delete @node driver context if it has no dumps under it */
+		crashdd_proc_del(node->proc_node);
+		node->proc_node = NULL;
+		list_del(&node->list);
+	}
+	mutex_unlock(&crashdd_mutex);
+}
+
+/**
+ * crashdd_add_dump - Allocate a directory under /proc/crashdd/ and add the
+ * dump to it.
+ * @driver_name: directory name under which the dump should be added.
+ * @data: dump info.
+ *
+ * Search for @driver_name directory under /proc/crashdd/.  If not found,
+ * allocate a new directory under /proc/crashdd/ with @driver_name.
+ * Allocate the dump context and invoke the calling driver's dump collect
+ * routine.  Once collection is done, add the dump under
+ * /proc/crashdd/@driver_name/ directory.
+ */
+int crashdd_add_dump(const char *driver_name, struct crashdd_data *data)
+{
+	struct crashdd_driver_node *node;
+	struct crashdd_dump_node *dump;
+	void *buf = NULL;
+	int ret;
+
+	if (!driver_name || !strlen(driver_name) ||
+	    !data || !strlen(data->name) ||
+	    !data->crashdd_callback || !data->size)
+		return -EINVAL;
+
+	/* Get a driver proc context with specified name. */
+	node = crashdd_get_driver(driver_name);
+	if (!node) {
+		/* No driver proc context found with specified name.
+		 * So create a new one
+		 */
+		node = crashdd_init_driver(driver_name);
+		if (!node)
+			return -ENOMEM;
+	}
+
+	dump = vzalloc(sizeof(*dump));
+	if (!dump) {
+		ret = -ENOMEM;
+		goto out_err;
+	}
+
+	/* Allocate buffer for driver's to write their dumps */
+	buf = vzalloc(data->size);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto out_err;
+	}
+
+	/* Allocate a proc file under /proc/crashdd/@driver_name/.
+	 * Also set the dump as proc file's data
+	 */
+	dump->proc_node = crashdd_proc_add(node->proc_node, data->name, dump);
+	if (!dump->proc_node) {
+		ret = -ENOMEM;
+		goto out_err;
+	}
+
+	/* Invoke the driver's dump collection routing */
+	ret = data->crashdd_callback(data, buf);
+	if (ret)
+		goto out_err;
+
+	dump->buf = buf;
+	dump->size = data->size;
+	dump->proc_node->size = dump->size;
+
+	/* Add the dump to driver proc context list */
+	mutex_lock(&crashdd_mutex);
+	list_add_tail(&dump->list, &node->dump_list);
+	atomic_inc(&node->refcnt);
+	mutex_unlock(&crashdd_mutex);
+
+	/* Return back the driver proc context reference */
+	crashdd_put_driver(node);
+	return 0;
+
+out_err:
+	if (buf)
+		vfree(buf);
+
+	if (dump) {
+		if (dump->proc_node) {
+			crashdd_proc_del(dump->proc_node);
+			dump->proc_node = NULL;
+		}
+		vfree(dump);
+	}
+
+	crashdd_put_driver(node);
+	return ret;
+}
+EXPORT_SYMBOL(crashdd_add_dump);
+
+/* Init function for crash driver dump module. */
+static int __init crashdd_proc_init(void)
+{
+	/*
+	 * Only export this directory in 2nd kernel.
+	 */
+	if (!is_kdump_kernel())
+		return 0;
+
+	/* Create /proc/crashdd/ directory */
+	proc_crashdd = proc_mkdir_mode("crashdd", CRASHDD_PROC_PERM, NULL);
+	if (!proc_crashdd)
+		return -ENOMEM;
+
+	return 0;
+}
+fs_initcall(crashdd_proc_init);
diff --git a/include/linux/crashdd.h b/include/linux/crashdd.h
new file mode 100644
index 000000000000..1f1ec280a2bb
--- /dev/null
+++ b/include/linux/crashdd.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef CRASH_DRIVER_DUMP_H
+#define CRASH_DRIVER_DUMP_H
+
+/* Max driver/dump name length */
+#define CRASHDD_NAME_LENGTH 32
+
+/* Dump proc context internal to crashdd */
+struct crashdd_dump_node {
+	/* Pointer to list of dumps under the driver proc context */
+	struct list_head list;
+	void *buf;             /* Buffer containing device's dump */
+	unsigned long size;    /* Size of the buffer */
+	/* Pointer to dump's entry in driver directory */
+	struct proc_dir_entry *proc_node;
+};
+
+/* Driver proc context internal to crashdd */
+struct crashdd_driver_node {
+	/* Pointer to global list of driver proc contexts */
+	struct list_head list;
+	struct list_head dump_list; /* List of dumps under this driver */
+	atomic_t refcnt;            /* Number of dumps under this directory */
+	/* Pointer to driver directory entry */
+	struct proc_dir_entry *proc_node;
+};
+
+/* Driver Dump information to be filled by drivers */
+struct crashdd_data {
+	char name[CRASHDD_NAME_LENGTH]; /* Unique name of the dump */
+	unsigned long size;             /* Size of the dump */
+	/* Driver's registered callback to be invoked to collect dump */
+	int (*crashdd_callback)(struct crashdd_data *data, void *buf);
+};
+
+#ifdef CONFIG_PROC_CRASH_DRIVER_DUMP
+int crashdd_add_dump(const char *driver_name, struct crashdd_data *data);
+#else
+#define crashdd_add_dump(x, y) 0
+#endif /* CONFIG_PROC_CRASH_DRIVER_DUMP */
+
+#endif /* CRASH_DRIVER_DUMP_H */
-- 
2.14.1
