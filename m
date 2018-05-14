Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AB8JxZrSM2YhALj3Amd27LWpIe25/9an5P0EJO3T35dqwjXT/sigJhkUm9q2kWbO6bnB03PvxOhQ
ARC-Seal: i=1; a=rsa-sha256; t=1526326987; cv=none;
        d=google.com; s=arc-20160816;
        b=zLzKqMYnraNajRqIrAQUAp4/yCNO77jjefPOYma3cJEIQdYBITmXFaK+pD8Qky2t/Z
         VuNnNLmnJmV1jWIginXBnDi85o+GocZgrOmd5b/z78XyxkqD/X6wkju5MnrhCMTTEMoG
         90CtrkNRaGuJC+f1LuKCEfC3sQAnU+qd16j/6QvCoMn/K+fzCCQWsVPs/NkwGLPJlpwR
         SUW/Fd8ZE328TP0PWFgGy0a3yW5UDK1HvNUEn5LY1+GWYIM9nFI61Dwe6eUKO2lcig0M
         GR5a2HXT+oxcGcCX5UScLfifuBLBzpE/T4at3Ox45WdVrJps4kfSNim/tg3kdBzT/I2O
         Tyww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=D6u0dYaau7OxB5Ohrf5W3jYorf/EqWakVvtdpjzLa4w=;
        b=w3Drv+PTWUPMoUpckuvhe5MmxQ3gc9Gn6yH5WGxqp4YQNw8NDfigXX/DGt89PBtew9
         OAHQwIZioGQIXpxIFFXQojMKKm9zXzX1vLiUGK/G7RSjR5OOpdP1QEgeRhk2ZNowSTK/
         3DNMpXT9ytQ33bCpCGAFWRvet0hOyoHVeQ+ZyncUgkKsjl6lAE44QEgE8X2fEGCYVDQ5
         S9MY4qTbOQdI77mgEmYek4R5+ku537XbkhbcbFzubMzme1Hyqb7MBnvYJqTgE8+JzfuP
         T2mig+kEVJW77IEUhbDS9dHou0eTDr2W4YZiWs/cfOlpxVpMZ9cpw640yU8wNkRICt0J
         uWwg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=QYfwMI3Z;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=QYfwMI3Z;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: pasha.tatashin@oracle.com, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, linux-kernel@vger.kernel.org,
        jeffrey.t.kirsher@intel.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, gregkh@linuxfoundation.org,
        alexander.duyck@gmail.com, tobin@apporbit.com
Subject: [PATCH v4 1/1] drivers core: multi-threading device shutdown
Date: Mon, 14 May 2018 15:42:54 -0400
Message-Id: <20180514194254.14748-2-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514194254.14748-1-pasha.tatashin@oracle.com>
References: <20180514194254.14748-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8893 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805140198
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600469847842803826?=
X-GMAIL-MSGID: =?utf-8?q?1600469847842803826?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When system is rebooted, halted or kexeced device_shutdown() is
called.

This function shuts down every single device by calling either:

	dev->bus->shutdown(dev)
	dev->driver->shutdown(dev)

Even on a machine with just a moderate amount of devices, device_shutdown()
may take multiple seconds to complete. This is because many devices require
a specific delays to perform this operation.

Here is a sample analysis of time it takes to call device_shutdown() on a
two socket Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz machine.

device_shutdown		2.95s
-----------------------------
 mlx4_shutdown		1.14s
 megasas_shutdown	0.24s
 ixgbe_shutdown		0.37s x 4 (four ixgbe devices on this machine).
 the rest		0.09s

In mlx4 we spent the most time, but that is because there is a 1 second
sleep, which is defined by hardware specifications:
mlx4_shutdown
 mlx4_unload_one
  mlx4_free_ownership
   msleep(1000)

With megasas we spend a quarter of a second, but sometimes longer (up-to
0.5s) in this path:

    megasas_shutdown
      megasas_flush_cache
        megasas_issue_blocked_cmd
          wait_event_timeout

Finally, with ixgbe_shutdown() it takes 0.37 for each device, but that time
is spread all over the place, with bigger offenders:

    ixgbe_shutdown
      __ixgbe_shutdown
        ixgbe_close_suspend
          ixgbe_down
            ixgbe_init_hw_generic
              ixgbe_reset_hw_X540
                msleep(100);                        0.104483472
                ixgbe_get_san_mac_addr_generic      0.048414851
                ixgbe_get_wwn_prefix_generic        0.048409893
              ixgbe_start_hw_X540
                ixgbe_start_hw_generic
                  ixgbe_clear_hw_cntrs_generic      0.048581502
                  ixgbe_setup_fc_generic            0.024225800

    All the ixgbe_*generic functions end-up calling:
    ixgbe_read_eerd_X540()
      ixgbe_acquire_swfw_sync_X540
        usleep_range(5000, 6000);
      ixgbe_release_swfw_sync_X540
        usleep_range(5000, 6000);

While these are short sleeps, they end-up calling them over 24 times!
24 * 0.0055s = 0.132s. Adding-up to 0.528s for four devices. Also we have
four msleep(100). Totaling to:  0.928s

While we should keep optimizing the individual device drivers, in some
cases this is simply a hardware property that forces a specific delay, and
we must wait.

So, the solution for this problem is to shutdown devices in parallel.
However, we must shutdown children before shutting down parents, so parent
device must wait for its children to finish.

With this patch, on the same machine devices_shutdown() takes 1.142s, and
without mlx4 one second delay only 0.38s

This feature can be optionally disabled via kernel parameter:
device_shutdown_serial. When booted with this parameter, device_shutdown()
will shutdown devices one by one.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 drivers/base/core.c | 292 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 242 insertions(+), 50 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index b610816eb887..08f14a2c0598 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -25,6 +25,7 @@
 #include <linux/netdevice.h>
 #include <linux/sched/signal.h>
 #include <linux/sysfs.h>
+#include <linux/kthread.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -2102,6 +2103,59 @@ const char *device_get_devnode(struct device *dev,
 	return *tmp = s;
 }
 
+/**
+ * device_children_count - device children count
+ * @parent: parent struct device.
+ *
+ * Returns number of children for this device or 0 if none.
+ */
+static int device_children_count(struct device *parent)
+{
+	struct klist_iter i;
+	int children = 0;
+
+	if (!parent->p)
+		return 0;
+
+	klist_iter_init(&parent->p->klist_children, &i);
+	while (next_device(&i))
+		children++;
+	klist_iter_exit(&i);
+
+	return children;
+}
+
+/**
+ * device_get_child_by_index - Return child using the provided index.
+ * @parent: parent struct device.
+ * @index:  Index of the child, where 0 is the first child in the children list,
+ * and so on.
+ *
+ * Returns child or NULL if child with this index is not present.
+ */
+static struct device *
+device_get_child_by_index(struct device *parent, int index)
+{
+	struct klist_iter i;
+	struct device *dev = NULL, *d;
+	int child_index = 0;
+
+	if (!parent->p || index < 0)
+		return NULL;
+
+	klist_iter_init(&parent->p->klist_children, &i);
+	while ((d = next_device(&i))) {
+		if (child_index == index) {
+			dev = d;
+			break;
+		}
+		child_index++;
+	}
+	klist_iter_exit(&i);
+
+	return dev;
+}
+
 /**
  * device_for_each_child - device child iterator.
  * @parent: parent struct device.
@@ -2765,73 +2819,211 @@ int device_move(struct device *dev, struct device *new_parent,
 }
 EXPORT_SYMBOL_GPL(device_move);
 
+/*
+ * device_shutdown_one - call ->shutdown() for the device passed as
+ * argument.
+ */
+static void device_shutdown_one(struct device *dev)
+{
+	/* Don't allow any more runtime suspends */
+	pm_runtime_get_noresume(dev);
+	pm_runtime_barrier(dev);
+
+	if (dev->class && dev->class->shutdown_pre) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown_pre\n");
+		dev->class->shutdown_pre(dev);
+	}
+	if (dev->bus && dev->bus->shutdown) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown\n");
+		dev->bus->shutdown(dev);
+	} else if (dev->driver && dev->driver->shutdown) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown\n");
+		dev->driver->shutdown(dev);
+	}
+
+	/* decrement the reference counter */
+	put_device(dev);
+}
+
+/**
+ * Passed as an argument to device_shutdown_child_task().
+ * child_next_index	the next available child index.
+ * tasks_running	number of tasks still running. Each tasks decrements it
+ *			when job is finished and the last task signals that the
+ *			job is complete.
+ * complete		Used to signal job competition.
+ * parent		Parent device.
+ */
+struct device_shutdown_task_data {
+	atomic_t		child_next_index;
+	atomic_t		tasks_running;
+	struct completion	complete;
+	struct device		*parent;
+};
+
+static int device_shutdown_child_task(void *data);
+static bool device_shutdown_serial;
+
+/**
+ * These globals are used by tasks that are started for root devices.
+ * device_root_tasks_finished	Number of root devices finished shutting down.
+ * device_root_tasks_started	Total number of root devices tasks started.
+ * device_root_tasks_done	The completion signal to the main thread.
+ */
+static atomic_t			device_root_tasks_finished;
+static atomic_t			device_root_tasks_started;
+static struct completion	device_root_tasks_done;
+
+/**
+ * Shutdown device tree with root started in dev. If dev has no children
+ * simply shutdown only this device. If dev has children recursively shutdown
+ * children first, and only then the parent. For performance reasons children
+ * are shutdown in parallel using kernel threads. because we lock dev its
+ * children cannot be removed while this functions is running.
+ */
+static void device_shutdown_tree(struct device *dev)
+{
+	int children_count;
+
+	device_lock(dev);
+	children_count = device_children_count(dev);
+
+	if (children_count) {
+		struct device_shutdown_task_data tdata;
+		int i;
+
+		init_completion(&tdata.complete);
+		atomic_set(&tdata.child_next_index, 0);
+		atomic_set(&tdata.tasks_running, children_count);
+		tdata.parent = dev;
+
+		for (i = 0; i < children_count; i++) {
+			if (device_shutdown_serial) {
+				device_shutdown_child_task(&tdata);
+			} else {
+				kthread_run(device_shutdown_child_task,
+					    &tdata, "device_shutdown.%s",
+					    dev_name(dev));
+			}
+		}
+		wait_for_completion(&tdata.complete);
+	}
+	device_shutdown_one(dev);
+	device_unlock(dev);
+}
+
+/**
+ * Only devices with parent are going through this function. The parent is
+ * locked and waits for all of its children to finish shutting down before
+ * calling shutdown function for itself.
+ */
+static int device_shutdown_child_task(void *data)
+{
+	struct device_shutdown_task_data *tdata = data;
+	int cidx = atomic_inc_return(&tdata->child_next_index) - 1;
+	struct device *dev = device_get_child_by_index(tdata->parent, cidx);
+
+	/* ref. counter is going to be decremented in device_shutdown_one() */
+	get_device(dev);
+	device_shutdown_tree(dev);
+
+	/* If we are the last to exit, signal the completion */
+	if (atomic_dec_return(&tdata->tasks_running) == 0)
+		complete(&tdata->complete);
+	return 0;
+}
+
+/**
+ * On shutdown each root device (the one that does not have a parent) goes
+ * through this function.
+ */
+static int device_shutdown_root_task(void *data)
+{
+	struct device *dev = (struct device *)data;
+	int root_devices;
+
+	device_shutdown_tree(dev);
+
+	/* If we are the last to exit, signal the completion */
+	root_devices = atomic_inc_return(&device_root_tasks_finished);
+	if (root_devices == atomic_read(&device_root_tasks_started))
+		complete(&device_root_tasks_done);
+	return 0;
+}
+
 /**
  * device_shutdown - call ->shutdown() on each device to shutdown.
  */
 void device_shutdown(void)
 {
-	struct device *dev, *parent;
+	int root_devices = 0;
+	struct device *dev;
 
-	spin_lock(&devices_kset->list_lock);
-	/*
-	 * Walk the devices list backward, shutting down each in turn.
-	 * Beware that device unplug events may also start pulling
-	 * devices offline, even as the system is shutting down.
+	atomic_set(&device_root_tasks_finished, 0);
+	atomic_set(&device_root_tasks_started, 0);
+	init_completion(&device_root_tasks_done);
+
+	/* Shutdown the root devices in parallel. The children are going to be
+	 * shutdown first in device_shutdown_tree().
 	 */
+	spin_lock(&devices_kset->list_lock);
 	while (!list_empty(&devices_kset->list)) {
-		dev = list_entry(devices_kset->list.prev, struct device,
-				kobj.entry);
+		dev = list_entry(devices_kset->list.next, struct device,
+				 kobj.entry);
 
-		/*
-		 * hold reference count of device's parent to
-		 * prevent it from being freed because parent's
-		 * lock is to be held
-		 */
-		parent = get_device(dev->parent);
-		get_device(dev);
-		/*
-		 * Make sure the device is off the kset list, in the
-		 * event that dev->*->shutdown() doesn't remove it.
+		/* Make sure the device is off the kset list, in the event that
+		 * dev->*->shutdown() doesn't remove it.
 		 */
 		list_del_init(&dev->kobj.entry);
-		spin_unlock(&devices_kset->list_lock);
-
-		/* hold lock to avoid race with probe/release */
-		if (parent)
-			device_lock(parent);
-		device_lock(dev);
-
-		/* Don't allow any more runtime suspends */
-		pm_runtime_get_noresume(dev);
-		pm_runtime_barrier(dev);
 
-		if (dev->class && dev->class->shutdown_pre) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown_pre\n");
-			dev->class->shutdown_pre(dev);
-		}
-		if (dev->bus && dev->bus->shutdown) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown\n");
-			dev->bus->shutdown(dev);
-		} else if (dev->driver && dev->driver->shutdown) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown\n");
-			dev->driver->shutdown(dev);
+		/* Here we start tasks for root devices only */
+		if (!dev->parent) {
+			/* Prevents devices from being freed. The counter is
+			 * going to be decremented in device_shutdown_one() once
+			 * this root device is shutdown.
+			 */
+			get_device(dev);
+
+			/* We unlock list for performance reasons,
+			 * dev->*->shutdown(), may try to take this lock to
+			 * remove us from kset list. To avoid unlocking this
+			 * list we could replace spin lock in:
+			 * dev->kobj.kset->list_lock with a dummy one once
+			 * device is locked in device_shutdown_root_task() and
+			 * in device_shutdown_child_task().
+			 */
+			spin_unlock(&devices_kset->list_lock);
+
+			root_devices++;
+			if (device_shutdown_serial) {
+				device_shutdown_root_task(dev);
+			} else {
+				kthread_run(device_shutdown_root_task,
+					    dev, "device_root_shutdown.%s",
+					    dev_name(dev));
+			}
+			spin_lock(&devices_kset->list_lock);
 		}
-
-		device_unlock(dev);
-		if (parent)
-			device_unlock(parent);
-
-		put_device(dev);
-		put_device(parent);
-
-		spin_lock(&devices_kset->list_lock);
 	}
 	spin_unlock(&devices_kset->list_lock);
+
+	/* Set number of root tasks started, and waits for completion */
+	atomic_set(&device_root_tasks_started, root_devices);
+	if (root_devices != atomic_read(&device_root_tasks_finished))
+		wait_for_completion(&device_root_tasks_done);
+}
+
+static int __init _device_shutdown_serial(char *arg)
+{
+	device_shutdown_serial = true;
+	return 0;
 }
 
+early_param("device_shutdown_serial", _device_shutdown_serial);
+
 /*
  * Device logging functions
  */
-- 
2.17.0
