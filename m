Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED2FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF971206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390325AbfBOHoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 02:44:07 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:43713 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfBOHoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 02:44:06 -0500
X-Originating-IP: 141.70.45.131
Received: from localhost (hadi-gate-vlan-851.hadiko.whka.de [141.70.45.131])
        (Authenticated sender: hle@owl.eu.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 71232C000F;
        Fri, 15 Feb 2019 07:44:02 +0000 (UTC)
Date:   Fri, 15 Feb 2019 08:44:01 +0100
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Hartman <ghartman@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging/android: use multiple futex wait queues
Message-ID: <20190215074401.GA20188@behemoth.owl.eu.com.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use multiple per-offset wait queues instead of one big wait queue per
region.

Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
---
Changes in v2:
  - dereference the it pointer instead of wait_queue (which is not set
    yet) in handle_vsoc_cond_wait()
---
 drivers/staging/android/TODO   |  4 ---
 drivers/staging/android/vsoc.c | 56 ++++++++++++++++++++++++++--------
 2 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/android/TODO b/drivers/staging/android/TODO
index fbf015cc6d62..cd2af06341dc 100644
--- a/drivers/staging/android/TODO
+++ b/drivers/staging/android/TODO
@@ -12,10 +12,6 @@ ion/
  - Better test framework (integration with VGEM was suggested)
 
 vsoc.c, uapi/vsoc_shm.h
- - The current driver uses the same wait queue for all of the futexes in a
-   region. This will cause false wakeups in regions with a large number of
-   waiting threads. We should eventually use multiple queues and select the
-   queue based on the region.
  - Add debugfs support for examining the permissions of regions.
  - Remove VSOC_WAIT_FOR_INCOMING_INTERRUPT ioctl. This functionality has been
    superseded by the futex and is there for legacy reasons.
diff --git a/drivers/staging/android/vsoc.c b/drivers/staging/android/vsoc.c
index f2bb18158e5b..97303d9173aa 100644
--- a/drivers/staging/android/vsoc.c
+++ b/drivers/staging/android/vsoc.c
@@ -31,6 +31,7 @@
 #include <linux/interrupt.h>
 #include <linux/cdev.h>
 #include <linux/file.h>
+#include <linux/list.h>
 #include "uapi/vsoc_shm.h"
 
 #define VSOC_DEV_NAME "vsoc"
@@ -62,11 +63,18 @@ static const int MAX_REGISTER_BAR_LEN = 0x100;
  */
 static const int SHARED_MEMORY_BAR = 2;
 
+struct vsoc_futex_wait_queue_t {
+	struct list_head list;
+	u32 offset;
+	wait_queue_head_t queue;
+};
+
 struct vsoc_region_data {
 	char name[VSOC_DEVICE_NAME_SZ + 1];
 	wait_queue_head_t interrupt_wait_queue;
-	/* TODO(b/73664181): Use multiple futex wait queues */
-	wait_queue_head_t futex_wait_queue;
+	/* Per-offset futex wait queue. */
+	struct list_head futex_wait_queue_list;
+	spinlock_t futex_wait_queue_lock;
 	/* Flag indicating that an interrupt has been signalled by the host. */
 	atomic_t *incoming_signalled;
 	/* Flag indicating the guest has signalled the host. */
@@ -402,6 +410,7 @@ static int handle_vsoc_cond_wait(struct file *filp, struct vsoc_cond_wait *arg)
 	struct vsoc_region_data *data = vsoc_dev.regions_data + region_number;
 	int ret = 0;
 	struct vsoc_device_region *region_p = vsoc_region_from_filep(filp);
+	struct vsoc_futex_wait_queue_t *it, *wait_queue = NULL;
 	atomic_t *address = NULL;
 	ktime_t wake_time;
 
@@ -415,10 +424,27 @@ static int handle_vsoc_cond_wait(struct file *filp, struct vsoc_cond_wait *arg)
 	address = shm_off_to_virtual_addr(region_p->region_begin_offset +
 					  arg->offset);
 
+	/* Find wait queue corresponding to offset or create it */
+	spin_lock(&data->futex_wait_queue_lock);
+	list_for_each_entry(it, &data->futex_wait_queue_list, list) {
+		if (it->offset == arg->offset) {
+			wait_queue = it;
+			break;
+		}
+	}
+
+	if (!wait_queue) {
+		wait_queue = kmalloc(sizeof(*wait_queue), GFP_KERNEL);
+		wait_queue->offset = arg->offset;
+		init_waitqueue_head(&wait_queue->queue);
+		list_add(&wait_queue->list, &data->futex_wait_queue_list);
+	}
+	spin_unlock(&data->futex_wait_queue_lock);
+
 	/* Ensure that the type of wait is valid */
 	switch (arg->wait_type) {
 	case VSOC_WAIT_IF_EQUAL:
-		ret = wait_event_freezable(data->futex_wait_queue,
+		ret = wait_event_freezable(wait_queue->queue,
 					   arg->wakes++ &&
 					   atomic_read(address) != arg->value);
 		break;
@@ -426,7 +452,7 @@ static int handle_vsoc_cond_wait(struct file *filp, struct vsoc_cond_wait *arg)
 		if (arg->wake_time_nsec >= NSEC_PER_SEC)
 			return -EINVAL;
 		wake_time = ktime_set(arg->wake_time_sec, arg->wake_time_nsec);
-		ret = wait_event_freezable_hrtimeout(data->futex_wait_queue,
+		ret = wait_event_freezable_hrtimeout(wait_queue->queue,
 						     arg->wakes++ &&
 						     atomic_read(address) != arg->value,
 						     wake_time);
@@ -463,6 +489,7 @@ static int do_vsoc_cond_wake(struct file *filp, uint32_t offset)
 	struct vsoc_device_region *region_p = vsoc_region_from_filep(filp);
 	u32 region_number = iminor(file_inode(filp));
 	struct vsoc_region_data *data = vsoc_dev.regions_data + region_number;
+	struct vsoc_futex_wait_queue_t *wait_queue;
 	/* Ensure that the offset is aligned */
 	if (offset & (sizeof(uint32_t) - 1))
 		return -EADDRNOTAVAIL;
@@ -470,13 +497,17 @@ static int do_vsoc_cond_wake(struct file *filp, uint32_t offset)
 	if (((uint64_t)offset) + region_p->region_begin_offset +
 	    sizeof(uint32_t) > region_p->region_end_offset)
 		return -E2BIG;
-	/*
-	 * TODO(b/73664181): Use multiple futex wait queues.
-	 * We need to wake every sleeper when the condition changes. Typically
-	 * only a single thread will be waiting on the condition, but there
-	 * are exceptions. The worst case is about 10 threads.
-	 */
-	wake_up_interruptible_all(&data->futex_wait_queue);
+	/* Only wake up tasks waiting for given offset */
+	spin_lock(&data->futex_wait_queue_lock);
+	list_for_each_entry(wait_queue, &data->futex_wait_queue_list, list) {
+		if (wait_queue->offset == offset) {
+			wake_up_interruptible_all(&wait_queue->queue);
+			list_del(&wait_queue->list);
+			kfree(wait_queue);
+			break;
+		}
+	}
+	spin_unlock(&data->futex_wait_queue_lock);
 	return 0;
 }
 
@@ -866,7 +897,8 @@ static int vsoc_probe_device(struct pci_dev *pdev,
 			 i, vsoc_dev.regions_data[i].name);
 		init_waitqueue_head
 			(&vsoc_dev.regions_data[i].interrupt_wait_queue);
-		init_waitqueue_head(&vsoc_dev.regions_data[i].futex_wait_queue);
+		spin_lock_init(&vsoc_dev.regions_data[i].futex_wait_queue_lock);
+		INIT_LIST_HEAD(&vsoc_dev.regions_data[i].futex_wait_queue_list);
 		vsoc_dev.regions_data[i].incoming_signalled =
 			shm_off_to_virtual_addr(region->region_begin_offset) +
 			h_to_g_signal_table->interrupt_signalled_offset;
-- 
2.20.1
