Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA96C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F8B27B1A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rzauaGGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F8B27B1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966476AbeF2S02 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:26:28 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37540 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752231AbeF2SZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:25:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5TINfXE129267;
        Fri, 29 Jun 2018 18:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=3yWP2VZtGeS1EnJVZim9oC3cvUQxa/TduWADT0HqU1E=;
 b=rzauaGGYzChLzqrpGoi150cKo4FF64r+6Ly7rXbWLP34VBnWUacc8dyEPFFyfeuKWb2S
 UPxhqGyop+YPSENfF+LH7NGkSx/Rlow/lOL+q4JCBUIIeAjVutNuoTsDqDRdTPNjvm4y
 Pl6rSzl7P9li/wAlYiibnGrlb+jTuw18C8LuCFVsdBdrRy4kjpUXFr/tDeiUFxwTwG26
 jOsUTBnR4d9a6htJqamGi9YaRCYIAmDIPHwVrg7ftsACjY9/B2Q41Bv+8K714ZlkYFSB
 L6TLDlxHZn/CwCoZNlmCNaE3MPBENSM6AiQLlGYo+jD6FKzlwdPlKYnKGQD5PufsZob7 mA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2jukhsqnyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jun 2018 18:25:51 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5TIPoLN028128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jun 2018 18:25:50 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5TIPodd031734;
        Fri, 29 Jun 2018 18:25:50 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Jun 2018 11:25:49 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     pasha.tatashin@oracle.com, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, linux-kernel@vger.kernel.org,
        jeffrey.t.kirsher@intel.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, gregkh@linuxfoundation.org,
        alexander.duyck@gmail.com, tobin@apporbit.com,
        andy.shevchenko@gmail.com
Subject: [PATCH v6 3/3] drivers core: multi-threading device shutdown
Date:   Fri, 29 Jun 2018 14:25:41 -0400
Message-Id: <20180629182541.6735-4-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180629182541.6735-1-pasha.tatashin@oracle.com>
References: <20180629182541.6735-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8939 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806290195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
index 5d8623b38d4d..b0f9e70daf52 100644
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
@@ -2887,19 +2888,39 @@ static void device_shutdown_one(struct device *dev)
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
@@ -2913,11 +2934,20 @@ static void device_shutdown_tree(struct device *dev)
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
@@ -2937,6 +2967,10 @@ static int device_shutdown_child_task(void *data)
 	/* ref. counter is going to be decremented in device_shutdown_one() */
 	get_device(dev);
 	device_shutdown_tree(dev);
+
+	/* If we are the last to exit, signal the completion */
+	if (atomic_dec_return(&tdata->tasks_running) == 0)
+		complete(&tdata->complete);
 	return 0;
 }
 
@@ -2947,9 +2981,14 @@ static int device_shutdown_child_task(void *data)
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
 
@@ -2958,10 +2997,17 @@ static int device_shutdown_root_task(void *data)
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
@@ -2992,13 +3038,33 @@ void device_shutdown(void)
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
2.18.0

