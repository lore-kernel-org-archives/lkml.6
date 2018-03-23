Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751938AbeCWIc5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 04:32:57 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:6784 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751823AbeCWIc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 04:32:28 -0400
From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
To: netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: davem@davemloft.net, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        stephen@networkplumber.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, ganeshgr@chelsio.com,
        nirranjan@chelsio.com, indranil@chelsio.com,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Subject: [PATCH net-next 1/2] fs/crashdd: add API to collect hardware dump in second kernel
Date: Fri, 23 Mar 2018 14:01:00 +0530
Message-Id: <f0c38b01859cc6abf32201764311dd48123399c9.1521793455.git.rahul.lakkireddy@chelsio.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <cover.1521793455.git.rahul.lakkireddy@chelsio.com>
References: <cover.1521793455.git.rahul.lakkireddy@chelsio.com>
In-Reply-To: <cover.1521793455.git.rahul.lakkireddy@chelsio.com>
References: <cover.1521793455.git.rahul.lakkireddy@chelsio.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new module crashdd that exports the /sys/kernel/crashdd/
directory in second kernel, containing collected hardware/firmware
dumps.

The sequence of actions done by device drivers to append their device
specific hardware/firmware logs to /sys/kernel/crashdd/ directory are
as follows:

1. During probe (before hardware is initialized), device drivers
register to the crashdd module (via crashdd_add_dump()), with
callback function, along with buffer size and log name needed for
firmware/hardware log collection.

2. Crashdd creates a driver's directory under
/sys/kernel/crashdd/<driver>. Then, it allocates the buffer with
requested size and invokes the device driver's registered callback
function.

3. Device driver collects all hardware/firmware logs into the buffer
and returns control back to crashdd.

4. Crashdd exposes the buffer as a binary file via
/sys/kernel/crashdd/<driver>/<dump_file>.

Suggested-by: Eric Biederman <ebiederm@xmission.com>.
Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
---
Changes since rfc v2:
- Moved exporting crashdd from procfs to sysfs.  Suggested by
  Stephen Hemminger <stephen@networkplumber.org>
- Moved code from fs/proc/crashdd.c to fs/crashdd/ directory.
- Replaced all proc API with sysfs API and updated comments.
- Calling driver callback before creating the binary file under
  crashdd sysfs.
- Changed binary dump file permission from S_IRUSR to S_IRUGO.
- Changed module name from CRASH_DRIVER_DUMP to CRASH_DEVICE_DUMP.

rfc v2:
- Collecting logs in 2nd kernel instead of during kernel panic.
  Suggested by Eric Biederman <ebiederm@xmission.com>.
- Patch added in this series.

 fs/Kconfig                    |   1 +
 fs/Makefile                   |   1 +
 fs/crashdd/Kconfig            |  10 ++
 fs/crashdd/Makefile           |   3 +
 fs/crashdd/crashdd.c          | 234 ++++++++++++++++++++++++++++++++++++++++++
 fs/crashdd/crashdd_internal.h |  24 +++++
 include/linux/crashdd.h       |  24 +++++
 7 files changed, 297 insertions(+)
 create mode 100644 fs/crashdd/Kconfig
 create mode 100644 fs/crashdd/Makefile
 create mode 100644 fs/crashdd/crashdd.c
 create mode 100644 fs/crashdd/crashdd_internal.h
 create mode 100644 include/linux/crashdd.h

diff --git a/fs/Kconfig b/fs/Kconfig
index bc821a86d965..aae1c55a7dad 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -208,6 +208,7 @@ config ARCH_HAS_GIGANTIC_PAGE
 
 source "fs/configfs/Kconfig"
 source "fs/efivarfs/Kconfig"
+source "fs/crashdd/Kconfig"
 
 endmenu
 
diff --git a/fs/Makefile b/fs/Makefile
index add789ea270a..ff398a44f611 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -128,3 +128,4 @@ obj-y				+= exofs/ # Multiple modules
 obj-$(CONFIG_CEPH_FS)		+= ceph/
 obj-$(CONFIG_PSTORE)		+= pstore/
 obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
+obj-$(CONFIG_CRASH_DEVICE_DUMP)	+= crashdd/
diff --git a/fs/crashdd/Kconfig b/fs/crashdd/Kconfig
new file mode 100644
index 000000000000..5db9c7c98c17
--- /dev/null
+++ b/fs/crashdd/Kconfig
@@ -0,0 +1,10 @@
+config CRASH_DEVICE_DUMP
+	bool "Crash Kernel Device Hardware/Firmware Logs"
+	depends on SYSFS && CRASH_DUMP
+	default y
+	---help---
+	  Device drivers can collect the device specific snapshot of
+	  their hardware or firmware before they are initialized in
+	  crash recovery kernel. If you say Y here a tree of device
+	  specific dumps will be made available under /sys/kernel/crashdd/
+	  directory.
diff --git a/fs/crashdd/Makefile b/fs/crashdd/Makefile
new file mode 100644
index 000000000000..8dbf946c0ea4
--- /dev/null
+++ b/fs/crashdd/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y := crashdd.o
diff --git a/fs/crashdd/crashdd.c b/fs/crashdd/crashdd.c
new file mode 100644
index 000000000000..73882ff7722e
--- /dev/null
+++ b/fs/crashdd/crashdd.c
@@ -0,0 +1,234 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018 Chelsio Communications, Inc. All rights reserved. */
+
+#include <linux/vmalloc.h>
+#include <linux/crash_dump.h>
+#include <linux/crashdd.h>
+
+#include "crashdd_internal.h"
+
+static LIST_HEAD(crashdd_list);
+static DEFINE_MUTEX(crashdd_mutex);
+
+#define CRASHDD_SYSFS_MODE 444 /* S_IRUGO */
+static struct kobject *crashdd_kobj;
+
+static ssize_t crashdd_read(struct file *filp, struct kobject *kobj,
+			    struct bin_attribute *bin_attr,
+			    char *buf, loff_t fpos, size_t count)
+{
+	struct crashdd_dump_node *dump = bin_attr->private;
+
+	memcpy(buf, dump->buf + fpos, count);
+	return count;
+}
+
+static struct kobject *crashdd_mkdir(const char *name)
+{
+	return kobject_create_and_add(name, crashdd_kobj);
+}
+
+static int crashdd_add_file(struct kobject *kobj, const char *name,
+			    struct crashdd_dump_node *dump)
+{
+	dump->bin_attr.attr.name = name;
+	dump->bin_attr.attr.mode = CRASHDD_SYSFS_MODE;
+	dump->bin_attr.size = dump->size;
+	dump->bin_attr.read = crashdd_read;
+	dump->bin_attr.private = dump;
+
+	return sysfs_create_bin_file(kobj, &dump->bin_attr);
+}
+
+static void crashdd_rmdir(struct kobject *kobj)
+{
+	kobject_put(kobj);
+}
+
+/**
+ * crashdd_init_driver - create a sysfs driver entry.
+ * @name: Name of the directory.
+ *
+ * Creates a directory under /sys/kernel/crashdd/ with @name.  Allocates
+ * and saves the sysfs entry.  The sysfs entry is added to the global
+ * list and then returned to the caller. On failure, returns NULL.
+ */
+static struct crashdd_driver_node *crashdd_init_driver(const char *name)
+{
+	struct crashdd_driver_node *node;
+
+	node = vzalloc(sizeof(*node));
+	if (!node)
+		return NULL;
+
+	/* Create a driver's directory under /sys/kernel/crashdd/ */
+	node->kobj = crashdd_mkdir(name);
+	if (!node->kobj) {
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
+	/* Add the driver's entry to global list */
+	mutex_lock(&crashdd_mutex);
+	list_add_tail(&node->list, &crashdd_list);
+	mutex_unlock(&crashdd_mutex);
+
+	return node;
+}
+
+/**
+ * crashdd_get_driver - get an exisiting sysfs driver entry.
+ * @name: Name of the directory.
+ *
+ * Searches and fetches a sysfs entry having @name.  If @name is
+ * found, then the reference count is incremented and the entry
+ * is returned.  If @name is not found, NULL is returned.
+ */
+static struct crashdd_driver_node *crashdd_get_driver(const char *name)
+{
+	struct crashdd_driver_node *node;
+	int found = 0;
+
+	/* Search for an existing driver sysfs entry having @name */
+	mutex_lock(&crashdd_mutex);
+	list_for_each_entry(node, &crashdd_list, list) {
+		if (!strcmp(node->kobj->name, name)) {
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
+ * crashdd_put_driver - put an exisiting sysfs driver entry.
+ * @node: driver sysfs entry.
+ *
+ * Decrement @node reference count.  If there are no dumps left under it,
+ * delete the sysfs directory and remove it from the global list.
+ */
+static void crashdd_put_driver(struct crashdd_driver_node *node)
+{
+	mutex_lock(&crashdd_mutex);
+	if (atomic_dec_and_test(&node->refcnt)) {
+		/* Delete @node driver entry if it has no dumps under it */
+		crashdd_rmdir(node->kobj);
+		list_del(&node->list);
+	}
+	mutex_unlock(&crashdd_mutex);
+}
+
+/**
+ * crashdd_add_dump - Allocate a directory under /sys/kernel/crashdd/ and
+ * add the dump to it.
+ * @driver_name: directory name under which the dump should be added.
+ * @data: dump info.
+ *
+ * Search for /sys/kernel/crashdd/<@driver_name>/ directory.  If not found,
+ * allocate a new directory under /sys/kernel/crashdd/ with @driver_name.
+ * Allocate the dump file's context and invoke the calling driver's dump
+ * collect routine.  Once collection is done, add the dump under
+ * /sys/kernel/crashdd/<@driver_name>/ directory.
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
+	/* Get a driver sysfs entry with specified name. */
+	node = crashdd_get_driver(driver_name);
+	if (!node) {
+		/* No driver sysfs entry found with specified name.
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
+	/* Invoke the driver's dump collection routing */
+	ret = data->crashdd_callback(data, buf);
+	if (ret)
+		goto out_err;
+
+	dump->buf = buf;
+	dump->size = data->size;
+
+	/* Add a binary file under /sys/kernel/crashdd/@driver_name/ */
+	ret = crashdd_add_file(node->kobj, data->name, dump);
+	if (ret)
+		goto out_err;
+
+	/* Add the dump to driver sysfs list */
+	mutex_lock(&crashdd_mutex);
+	list_add_tail(&dump->list, &node->dump_list);
+	atomic_inc(&node->refcnt);
+	mutex_unlock(&crashdd_mutex);
+
+	/* Return back the driver sysfs reference */
+	crashdd_put_driver(node);
+	return 0;
+
+out_err:
+	if (buf)
+		vfree(buf);
+
+	if (dump)
+		vfree(dump);
+
+	crashdd_put_driver(node);
+	return ret;
+}
+EXPORT_SYMBOL(crashdd_add_dump);
+
+/* Init function for crash device dump module. */
+static int __init crashdd_init(void)
+{
+	/*
+	 * Only export this directory in 2nd kernel.
+	 */
+	if (!is_kdump_kernel())
+		return 0;
+
+	/* Create /sys/kernel/crashdd/ directory */
+	crashdd_kobj = kobject_create_and_add("crashdd", kernel_kobj);
+	if (!crashdd_kobj)
+		return -ENOMEM;
+
+	return 0;
+}
+fs_initcall(crashdd_init);
diff --git a/fs/crashdd/crashdd_internal.h b/fs/crashdd/crashdd_internal.h
new file mode 100644
index 000000000000..9162d1a4264b
--- /dev/null
+++ b/fs/crashdd/crashdd_internal.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018 Chelsio Communications, Inc. All rights reserved. */
+
+#ifndef CRASH_DEVICE_DUMP_INTERNAL_H
+#define CRASH_DEVICE_DUMP_INTERNAL_H
+
+/* Binary dump file's context internal to crashdd */
+struct crashdd_dump_node {
+	/* Pointer to list of dumps under the driver sysfs entry */
+	struct list_head list;
+	void *buf;                     /* Buffer containing device's dump */
+	unsigned long size;            /* Size of the buffer */
+	struct bin_attribute bin_attr; /* Binary dump file's attributes */
+};
+
+/* Driver sysfs entry internal to crashdd */
+struct crashdd_driver_node {
+	/* Pointer to global list of driver sysfs entries */
+	struct list_head list;
+	struct list_head dump_list; /* List of dumps under this driver */
+	atomic_t refcnt;            /* Number of dumps under this directory */
+	struct kobject *kobj;       /* Pointer to driver sysfs kobject */
+};
+#endif /* CRASH_DEVICE_DUMP_INTERNAL_H */
diff --git a/include/linux/crashdd.h b/include/linux/crashdd.h
new file mode 100644
index 000000000000..edaba8424019
--- /dev/null
+++ b/include/linux/crashdd.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018 Chelsio Communications, Inc. All rights reserved. */
+
+#ifndef CRASH_DEVICE_DUMP_H
+#define CRASH_DEVICE_DUMP_H
+
+/* Max dump name length */
+#define CRASHDD_NAME_LENGTH 32
+
+/* Device Dump information to be filled by drivers */
+struct crashdd_data {
+	char name[CRASHDD_NAME_LENGTH]; /* Unique name of the dump */
+	unsigned long size;             /* Size of the dump */
+	/* Driver's registered callback to be invoked to collect dump */
+	int (*crashdd_callback)(struct crashdd_data *data, void *buf);
+};
+
+#ifdef CONFIG_CRASH_DEVICE_DUMP
+int crashdd_add_dump(const char *driver_name, struct crashdd_data *data);
+#else
+#define crashdd_add_dump(x, y) 0
+#endif /* CONFIG_CRASH_DEVICE_DUMP */
+
+#endif /* CRASH_DEVICE_DUMP_H */
-- 
2.14.1
