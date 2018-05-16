Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752352AbeEPCke (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 22:40:34 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60508 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeEPCkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 22:40:25 -0400
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: pasha.tatashin@oracle.com, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, linux-kernel@vger.kernel.org,
        jeffrey.t.kirsher@intel.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, gregkh@linuxfoundation.org,
        alexander.duyck@gmail.com, tobin@apporbit.com,
        andy.shevchenko@gmail.com
Subject: [PATCH v5 3/3] drivers core: multi-threading device shutdown
Date: Tue, 15 May 2018 22:40:04 -0400
Message-Id: <20180516024004.28977-4-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516024004.28977-1-pasha.tatashin@oracle.com>
References: <20180516024004.28977-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8894 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805160023
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 drivers/base/core.c | 70 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 210b619931bc..032a1922bcb7 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -22,6 +22,7 @@
 #include <linux/genhd.h>
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
+#include <linux/kthread.h>
 #include <linux/netdevice.h>
 #include <linux/sched/signal.h>
 #include <linux/sysfs.h>
@@ -2850,19 +2851,39 @@ static void device_shutdown_one(struct device *dev)
 /*
  * Passed as an argument to device_shutdown_child_task().
  * child_next_index	the next available child index.
+ * tasks_running	number of tasks still running. Each tasks decrements it
+ *			when job is finished and the last task signals that the
+ *			job is complete.
+ * complete		Used to signal job competition.
  * parent		Parent device.
  */
 struct device_shutdown_task_data {
 	atomic_t		child_next_index;
+	atomic_t		tasks_running;
+	struct completion	complete;
 	struct device		*parent;
 };
 
 static int device_shutdown_child_task(void *data);
+static bool device_shutdown_serial;
+
+/*
+ * These globals are used by tasks that are started for root devices.
+ * device_root_tasks_finished	Number of root devices finished shutting down.
+ * device_root_tasks_started	Total number of root devices tasks started.
+ * device_root_tasks_done	The completion signal to the main thread.
+ */
+static atomic_t			device_root_tasks_finished;
+static atomic_t			device_root_tasks_started;
+static struct completion	device_root_tasks_done;
 
 /*
  * Shutdown device tree with root started in dev. If dev has no children
  * simply shutdown only this device. If dev has children recursively shutdown
  * children first, and only then the parent.
+ * For performance reasons children are shutdown in parallel using kernel
+ * threads. because we lock dev its children cannot be removed while this
+ * functions is running.
  */
 static void device_shutdown_tree(struct device *dev)
 {
@@ -2876,11 +2897,20 @@ static void device_shutdown_tree(struct device *dev)
 		int i;
 
 		atomic_set(&tdata.child_next_index, 0);
+		atomic_set(&tdata.tasks_running, children_count);
+		init_completion(&tdata.complete);
 		tdata.parent = dev;
 
 		for (i = 0; i < children_count; i++) {
-			device_shutdown_child_task(&tdata);
+			if (device_shutdown_serial) {
+				device_shutdown_child_task(&tdata);
+			} else {
+				kthread_run(device_shutdown_child_task,
+					    &tdata, "device_shutdown.%s",
+					    dev_name(dev));
+			}
 		}
+		wait_for_completion(&tdata.complete);
 	}
 	device_shutdown_one(dev);
 	device_unlock(dev);
@@ -2900,6 +2930,10 @@ static int device_shutdown_child_task(void *data)
 	/* ref. counter is going to be decremented in device_shutdown_one() */
 	get_device(dev);
 	device_shutdown_tree(dev);
+
+	/* If we are the last to exit, signal the completion */
+	if (atomic_dec_return(&tdata->tasks_running) == 0)
+		complete(&tdata->complete);
 	return 0;
 }
 
@@ -2910,9 +2944,14 @@ static int device_shutdown_child_task(void *data)
 static int device_shutdown_root_task(void *data)
 {
 	struct device *dev = (struct device *)data;
+	int root_devices;
 
 	device_shutdown_tree(dev);
 
+	/* If we are the last to exit, signal the completion */
+	root_devices = atomic_inc_return(&device_root_tasks_finished);
+	if (root_devices == atomic_read(&device_root_tasks_started))
+		complete(&device_root_tasks_done);
 	return 0;
 }
 
@@ -2921,10 +2960,17 @@ static int device_shutdown_root_task(void *data)
  */
 void device_shutdown(void)
 {
+	int root_devices = 0;
 	struct device *dev;
 
+	atomic_set(&device_root_tasks_finished, 0);
+	atomic_set(&device_root_tasks_started, 0);
+	init_completion(&device_root_tasks_done);
+
 	/* Shutdown the root devices. The children are going to be
 	 * shutdown first in device_shutdown_tree().
+	 * We shutdown root devices in parallel by starting thread
+	 * for each root device.
 	 */
 	spin_lock(&devices_kset->list_lock);
 	while (!list_empty(&devices_kset->list)) {
@@ -2955,13 +3001,33 @@ void device_shutdown(void)
 			 */
 			spin_unlock(&devices_kset->list_lock);
 
-			device_shutdown_root_task(dev);
+			root_devices++;
+			if (device_shutdown_serial) {
+				device_shutdown_root_task(dev);
+			} else {
+				kthread_run(device_shutdown_root_task,
+					    dev, "device_root_shutdown.%s",
+					    dev_name(dev));
+			}
 			spin_lock(&devices_kset->list_lock);
 		}
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
