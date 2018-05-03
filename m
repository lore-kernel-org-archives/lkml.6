Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AB8JxZoFmTG/7mwXWtHj87du/7dDmR9KYJjhLchKFu+OWuJ1yJdedv7Kp6qfPvnIhb1JxUEpv7H7
ARC-Seal: i=1; a=rsa-sha256; t=1525319982; cv=none;
        d=google.com; s=arc-20160816;
        b=DbgWovtETDIbda7L9tlIhgv3sAdoT4fFRPSxD6bIaf8/SdimLDzCPzHQYBPIeWd8lh
         D199PomM/LTiuIIXLt7Qrs02WXQdEAAQ+E6hQnIfHpaEoxLKo3gW1TbmTbpAsPaETU4p
         Im4bg1EoQsTiF0rABSXyC3qKAipbbWfLjAe1LQ3EUviQTURaSbQ07L9Y+283gp9/aMV8
         VyAr7rbMEn6huMAdhZ7bmJHbXqLSxE/1KjHLILak/xC1PJxtpFn9fOlpoKgS3IhkiTog
         CQL6IrcYJyAbkE99caad2l2rFfGA71b0yu2PzyWvleEENBvhafyxroHn5B71xrReWZFz
         DDag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=v1eLTNmRblmbIeK87KBSgfE23uqpqRFXf6g/3DvYgz4=;
        b=BPOE01Oa3VDq/Snhindkagsq36IgGSKooOqZmZFi4K9OV8loxE9MDum9Oo5v8/vgn2
         G6HLr/R0CG2eWEKm+AMUOtVln02nzc8Pnlzt44BHvaqmB2DPrpCLra5Jxz9kAZgKIqwp
         sxvbYscAyr/oj3GlblF0CWaNxUBTstn2JYKOSoSCC9mHbMivWm8vJ5WJZxWCPMyg3M2p
         v/wCOHsHTsFzGW10eaNFGAISlm9cYbhU2vKUKBbU2bQNrUg69KhdNbYOYJgZ/xTr5ssS
         VHH8DE9nN8cMMlbif5aiKFQWZgQxiYYU9eYErYTBk+pFrPa94PgkxmQFi97WIV2IHx3g
         jCTg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=Zq9/FM3v;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=Zq9/FM3v;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: pasha.tatashin@oracle.com, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, linux-kernel@vger.kernel.org,
        jeffrey.t.kirsher@intel.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH 2/2] drivers core: multi-threading device shutdown
Date: Wed,  2 May 2018 23:59:31 -0400
Message-Id: <20180503035931.22439-3-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180503035931.22439-1-pasha.tatashin@oracle.com>
References: <20180503035931.22439-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8881 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805030034
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599413926103775713?=
X-GMAIL-MSGID: =?utf-8?q?1599413926103775713?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When system is rebooted, halted or kexeced device_shutdown() is
called.

This function shuts down every single device by calling either:
	dev->bus->shutdown(dev)
	dev->driver->shutdown(dev)

Even on a machine just with a moderate amount of devices, device_shutdown()
may take multiple seconds to complete. Because many devices require a
specific delays to perform this operation.

Here is sample analysis of time it takes to call device_shutdown() on
two socket Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz machine.

device_shutdown		2.95s
 mlx4_shutdown		1.14s
 megasas_shutdown	0.24s
 ixgbe_shutdown		0.37s x 4 (four ixgbe devices on my machine).
 the rest		0.09s

In mlx4 we spent the most time, but that is because there is a 1 second
sleep:
mlx4_shutdown
 mlx4_unload_one
  mlx4_free_ownership
   msleep(1000)

With megasas we spend quoter of second, but sometimes longer (up-to 0.5s)
in this path:

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
24 * 0.0055s = 0.132s. Adding-up to 0.528s for four devices.

While we should keep optimizing the individual device drivers, in some
cases this is simply a hardware property that forces a specific delay, and
we must wait.

So, the solution for this problem is to shutdown devices in parallel.
However, we must shutdown children before shutting down parents, so parent
device must wait for its children to finish.

With this patch, on the same machine devices_shutdown() takes 1.142s, and
without mlx4 one second delay only 0.38s

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 drivers/base/core.c | 238 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 189 insertions(+), 49 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index b610816eb887..f370369a303b 100644
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
+ * Returns number of children for this device or 0 if nonde.
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
+ * device_get_child_by_index - Return child using the provide index.
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
+	while ((d = next_device(&i)) != NULL) {
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
@@ -2765,71 +2819,157 @@ int device_move(struct device *dev, struct device *new_parent,
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
+	/* Release device lock, and decrement the reference counter */
+	device_unlock(dev);
+	put_device(dev);
+}
+
+static DECLARE_COMPLETION(device_root_tasks_complete);
+static void device_shutdown_tree(struct device *dev);
+static atomic_t device_root_tasks;
+
+/*
+ * Passed as an argument to to device_shutdown_task().
+ * child_next_index	the next available child index.
+ * tasks_running	number of tasks still running. Each tasks decrements it
+ *			when job is finished and the last tasks signals that the
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
+static int device_shutdown_task(void *data)
+{
+	struct device_shutdown_task_data *tdata =
+		(struct device_shutdown_task_data *)data;
+	int child_idx = atomic_inc_return(&tdata->child_next_index) - 1;
+	struct device *dev = device_get_child_by_index(tdata->parent,
+						       child_idx);
+
+	if (dev)
+		device_shutdown_tree(dev);
+	if (atomic_dec_return(&tdata->tasks_running) == 0)
+		complete(&tdata->complete);
+	return 0;
+}
+
+/*
+ * Shutdown device tree with root started in dev. If dev has no children
+ * simply shutdown only this device. If dev has children recursively shutdown
+ * children first, and only then the parent. For performance reasons children
+ * are shutdown in parallel using kernel threads.
+ */
+static void device_shutdown_tree(struct device *dev)
+{
+	int children_count = device_children_count(dev);
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
+			kthread_run(device_shutdown_task,
+				    &tdata, "device_shutdown.%s",
+				    dev_name(dev));
+		}
+		wait_for_completion(&tdata.complete);
+	}
+	device_shutdown_one(dev);
+}
+
+/*
+ * On shutdown each root device (the one that does not have a parent) goes
+ * through this function.
+ */
+static int
+device_shutdown_root_task(void *data)
+{
+	struct device *dev = (struct device *)data;
+
+	device_shutdown_tree(dev);
+	if (atomic_dec_return(&device_root_tasks) == 0)
+		complete(&device_root_tasks_complete);
+	return 0;
+}
+
 /**
  * device_shutdown - call ->shutdown() on each device to shutdown.
  */
 void device_shutdown(void)
 {
-	struct device *dev, *parent;
+	struct list_head *pos, *next;
+	int root_devices = 0;
+	struct device *dev;
 
 	spin_lock(&devices_kset->list_lock);
 	/*
-	 * Walk the devices list backward, shutting down each in turn.
-	 * Beware that device unplug events may also start pulling
-	 * devices offline, even as the system is shutting down.
+	 * Prepare devices for shutdown: lock, and increment references in every
+	 * devices. Remove child devices from the list, and count number of root
+	 * devices.
 	 */
-	while (!list_empty(&devices_kset->list)) {
-		dev = list_entry(devices_kset->list.prev, struct device,
-				kobj.entry);
+	list_for_each_safe(pos, next, &devices_kset->list) {
+		dev = list_entry(pos, struct device, kobj.entry);
 
-		/*
-		 * hold reference count of device's parent to
-		 * prevent it from being freed because parent's
-		 * lock is to be held
-		 */
-		parent = get_device(dev->parent);
 		get_device(dev);
-		/*
-		 * Make sure the device is off the kset list, in the
-		 * event that dev->*->shutdown() doesn't remove it.
-		 */
-		list_del_init(&dev->kobj.entry);
-		spin_unlock(&devices_kset->list_lock);
-
-		/* hold lock to avoid race with probe/release */
-		if (parent)
-			device_lock(parent);
 		device_lock(dev);
 
-		/* Don't allow any more runtime suspends */
-		pm_runtime_get_noresume(dev);
-		pm_runtime_barrier(dev);
-
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
-		}
-
-		device_unlock(dev);
-		if (parent)
-			device_unlock(parent);
-
-		put_device(dev);
-		put_device(parent);
-
+		if (!dev->parent)
+			root_devices++;
+		else
+			list_del_init(&dev->kobj.entry);
+	}
+	atomic_set(&device_root_tasks, root_devices);
+	/*
+	 * Shutdown the root devices in parallel. The children are going to be
+	 * shutdown first.
+	 */
+	list_for_each_safe(pos, next, &devices_kset->list) {
+		dev = list_entry(pos, struct device, kobj.entry);
+		list_del_init(&dev->kobj.entry);
+		spin_unlock(&devices_kset->list_lock);
+		kthread_run(device_shutdown_root_task,
+			    dev, "device_root_shutdown.%s",
+			    dev_name(dev));
 		spin_lock(&devices_kset->list_lock);
 	}
 	spin_unlock(&devices_kset->list_lock);
+	wait_for_completion(&device_root_tasks_complete);
 }
 
 /*
-- 
2.17.0
