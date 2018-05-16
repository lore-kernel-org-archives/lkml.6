Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbeEPCk0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 22:40:26 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48402 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751489AbeEPCkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 22:40:22 -0400
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: pasha.tatashin@oracle.com, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, linux-kernel@vger.kernel.org,
        jeffrey.t.kirsher@intel.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, gregkh@linuxfoundation.org,
        alexander.duyck@gmail.com, tobin@apporbit.com,
        andy.shevchenko@gmail.com
Subject: [PATCH v5 2/3] drivers core: prepare device_shutdown for multi-threading
Date: Tue, 15 May 2018 22:40:03 -0400
Message-Id: <20180516024004.28977-3-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516024004.28977-1-pasha.tatashin@oracle.com>
References: <20180516024004.28977-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8894 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805160023
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do all the necessary refactoring to prepare device_shutdown() logic to
be multi-threaded.

Which includes:
1. Change the direction of traversing the list instead of going backward,
we now go forward.
2. Children are shutdown recursively for each root device from bottom-up.
3. Functions that can be multi-threaded have _task() in their name.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 drivers/base/core.c | 178 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 149 insertions(+), 29 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index ed189f6d1a2f..210b619931bc 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2102,6 +2102,59 @@ const char *device_get_devnode(struct device *dev,
 	return *tmp = s;
 }
 
+/*
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
+/*
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
@@ -2794,50 +2847,117 @@ static void device_shutdown_one(struct device *dev)
 	put_device(dev);
 }
 
+/*
+ * Passed as an argument to device_shutdown_child_task().
+ * child_next_index	the next available child index.
+ * parent		Parent device.
+ */
+struct device_shutdown_task_data {
+	atomic_t		child_next_index;
+	struct device		*parent;
+};
+
+static int device_shutdown_child_task(void *data);
+
+/*
+ * Shutdown device tree with root started in dev. If dev has no children
+ * simply shutdown only this device. If dev has children recursively shutdown
+ * children first, and only then the parent.
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
+		atomic_set(&tdata.child_next_index, 0);
+		tdata.parent = dev;
+
+		for (i = 0; i < children_count; i++) {
+			device_shutdown_child_task(&tdata);
+		}
+	}
+	device_shutdown_one(dev);
+	device_unlock(dev);
+}
+
+/*
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
+	return 0;
+}
+
+/*
+ * On shutdown each root device (the one that does not have a parent) goes
+ * through this function.
+ */
+static int device_shutdown_root_task(void *data)
+{
+	struct device *dev = (struct device *)data;
+
+	device_shutdown_tree(dev);
+
+	return 0;
+}
+
 /**
  * device_shutdown - call ->shutdown() on each device to shutdown.
  */
 void device_shutdown(void)
 {
-	struct device *dev, *parent;
+	struct device *dev;
 
-	spin_lock(&devices_kset->list_lock);
-	/*
-	 * Walk the devices list backward, shutting down each in turn.
-	 * Beware that device unplug events may also start pulling
-	 * devices offline, even as the system is shutting down.
+	/* Shutdown the root devices. The children are going to be
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
 		/*
 		 * Make sure the device is off the kset list, in the
 		 * event that dev->*->shutdown() doesn't remove it.
 		 */
 		list_del_init(&dev->kobj.entry);
-		spin_unlock(&devices_kset->list_lock);
 
-		/* hold lock to avoid race with probe/release */
-		if (parent)
-			device_lock(parent);
-		device_lock(dev);
-
-		device_shutdown_one(dev);
-		device_unlock(dev);
-		if (parent)
-			device_unlock(parent);
-
-		put_device(parent);
-
-		spin_lock(&devices_kset->list_lock);
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
+			device_shutdown_root_task(dev);
+			spin_lock(&devices_kset->list_lock);
+		}
 	}
 	spin_unlock(&devices_kset->list_lock);
 }
-- 
2.17.0
