Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752101AbeEPCkY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 22:40:24 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48400 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbeEPCkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 22:40:22 -0400
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: pasha.tatashin@oracle.com, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, linux-kernel@vger.kernel.org,
        jeffrey.t.kirsher@intel.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, gregkh@linuxfoundation.org,
        alexander.duyck@gmail.com, tobin@apporbit.com,
        andy.shevchenko@gmail.com
Subject: [PATCH v5 1/3] drivers core: refactor device_shutdown
Date: Tue, 15 May 2018 22:40:02 -0400
Message-Id: <20180516024004.28977-2-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516024004.28977-1-pasha.tatashin@oracle.com>
References: <20180516024004.28977-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8894 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=722
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805160023
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_shutdown() traverses through the list of devices, and calls
dev->{bug/driver}->shutdown() for each entry in the list.

Refactor the function by keeping device_shutdown() to do the logic of
traversing the list of devices, and device_shutdown_one() to perform the
actual shutdown operation on one device.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 drivers/base/core.c | 50 +++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index b610816eb887..ed189f6d1a2f 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2765,6 +2765,35 @@ int device_move(struct device *dev, struct device *new_parent,
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
 /**
  * device_shutdown - call ->shutdown() on each device to shutdown.
  */
@@ -2801,30 +2830,11 @@ void device_shutdown(void)
 			device_lock(parent);
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
+		device_shutdown_one(dev);
 		device_unlock(dev);
 		if (parent)
 			device_unlock(parent);
 
-		put_device(dev);
 		put_device(parent);
 
 		spin_lock(&devices_kset->list_lock);
-- 
2.17.0
