Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B01C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0818C222D9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltYmAPJ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394087AbfBOWkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:40:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41356 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391991AbfBOWjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:39:52 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so11887114wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 14:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P62+1HdFOIhxczZ5eG+TOL/5Ti2BeIuCM6AU1LuP7MI=;
        b=ltYmAPJ3RSjfl+7NPLYbnZ4dsDt+kt7kCl6Cu8YFZhLtgJ48OT2NFR62YgHQUgOqEU
         6HrcU4dEiG5/PGsd4J8f+8npaUNKA1Y48Q3Vv5+/3aJFZZUhOtWNxAmKGyr5rRsL/iUj
         4+fSHdh/pZik6I8/LUWBAM+dSDkg3xeFyVzoRyO9LtovmVtiSdsTqQQd9DXs4Ao8U9H0
         nxW+RLNUBg0hBRkUXMiEoeyJ49EF9uaKPOGttpXEHrHq0TaTg5MjPmQmjYBgCW3zAp5g
         POpXD/Pa3b8CASARfbAND0oypNKVxidr+uEEubRRc5XMm/LLGDzxjbOsNgADdGWGuUZQ
         1FsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P62+1HdFOIhxczZ5eG+TOL/5Ti2BeIuCM6AU1LuP7MI=;
        b=RDlLm1VPcld5zjNxRe2p85fXx7B3Oz2O0sZK7dfgsUuEs4WtilKIDuocGDYEB7LIqp
         s1NDwMEWk/D2neMnFQL+Tac4k+hTdg+V+6rulm0NsHO8TWt0KPx3KLmnckHoRE7k4U9S
         VRfGyBXSzQyx2KW6nG1vzpKvA6Neq6KIVI/HjQtjXpgp45Dvah44DMy/Itqgti/lohhE
         1aFnHnRXAhU56Zy1kBCM7naENh/yFDYxagGpXdj0REEjKczWPwJp24XIsx+UJ0yTTEH9
         rZXCdFauqrcb4hzQXlUR4H4hqPEBlTP7+mmv1dSuNlAeFI6P7KGVkruaDr/SvgHV6GHS
         343g==
X-Gm-Message-State: AHQUAuaM+bTkv+meXP1Z44iXV3FFLoV+r41DfF/rNN3UqxwAiNDsze23
        aoNasTCqK1mp5nFfVJne0fw=
X-Google-Smtp-Source: AHgI3IadKgl6P41Q2tXOr9NJj3JOq9Oh4nTtF4dof3lv6Y9ydh+Ts4X/bPiw1689Fec2q8P3incujw==
X-Received: by 2002:a05:6000:128f:: with SMTP id f15mr8060170wrx.74.1550270387866;
        Fri, 15 Feb 2019 14:39:47 -0800 (PST)
Received: from goyamonster.habana-labs.com ([31.154.181.186])
        by smtp.gmail.com with ESMTPSA id b197sm14652609wmd.23.2019.02.15.14.39.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 14:39:46 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rppt@linux.ibm.com, olof@lixom.net
Cc:     ogabbay@habana.ai, arnd@arndb.de, joe@perches.com
Subject: [PATCH v6 10/15] habanalabs: add device reset support
Date:   Sat, 16 Feb 2019 00:39:20 +0200
Message-Id: <20190215223925.16351-11-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190215223925.16351-1-oded.gabbay@gmail.com>
References: <20190215223925.16351-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for doing various on-the-fly reset of Goya.

The driver supports two types of resets:
1. soft-reset
2. hard-reset

Soft-reset is done when the device detects a timeout of a command
submission that was given to the device. The soft-reset process only resets
the engines that are relevant for the submission of compute jobs, i.e. the
DMA channels, the TPCs and the MME. The purpose is to bring the device as
fast as possible to a working state.

Hard-reset is done in several cases:
1. After soft-reset is done but the device is not responding
2. When fatal errors occur inside the device, e.g. ECC error
3. When the driver is removed

Hard-reset performs a reset of the entire chip except for the PCI
controller and the PLLs. It is a much longer process then soft-reset but it
helps to recover the device without the need to reboot the Host.

After hard-reset, the driver will restore the max power attribute and in
case of manual power management, the frequencies that were set.

This patch also adds two entries to the sysfs, which allows the root user
to initiate a soft or hard reset.

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
Changes in v6:
  - Only include headers needed for compilation
 
 drivers/misc/habanalabs/command_buffer.c   |   9 +-
 drivers/misc/habanalabs/device.c           | 325 ++++++++++++++++++++-
 drivers/misc/habanalabs/goya/goya.c        | 226 +++++++++++++-
 drivers/misc/habanalabs/goya/goya_hwmgr.c  |  18 +-
 drivers/misc/habanalabs/habanalabs.h       |  52 ++++
 drivers/misc/habanalabs/habanalabs_drv.c   |   9 +-
 drivers/misc/habanalabs/habanalabs_ioctl.c |   6 +
 drivers/misc/habanalabs/hwmon.c            |   4 +-
 drivers/misc/habanalabs/irq.c              |  31 ++
 drivers/misc/habanalabs/sysfs.c            |  82 +++++-
 10 files changed, 737 insertions(+), 25 deletions(-)

diff --git a/drivers/misc/habanalabs/command_buffer.c b/drivers/misc/habanalabs/command_buffer.c
index e659ca3035e4..1e90025204c0 100644
--- a/drivers/misc/habanalabs/command_buffer.c
+++ b/drivers/misc/habanalabs/command_buffer.c
@@ -91,9 +91,14 @@ int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr,
 	bool alloc_new_cb = true;
 	int rc;
 
-	if (hdev->disabled) {
+	/*
+	 * Can't use generic function to check this because of special case
+	 * where we create a CB as part of the reset process
+	 */
+	if ((hdev->disabled) || ((atomic_read(&hdev->in_reset)) &&
+					(ctx_id != HL_KERNEL_ASID_ID))) {
 		dev_warn_ratelimited(hdev->dev,
-			"Device is disabled. Can't create new CBs\n");
+			"Device is disabled or in reset. Can't create new CBs\n");
 		rc = -EBUSY;
 		goto out_err;
 	}
diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index f879de310915..2aa8a68cdf76 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -8,9 +8,17 @@
 #include "habanalabs.h"
 
 #include <linux/pci.h>
-#include <linux/delay.h>
+#include <linux/sched/signal.h>
 #include <linux/hwmon.h>
 
+bool hl_device_disabled_or_in_reset(struct hl_device *hdev)
+{
+	if ((hdev->disabled) || (atomic_read(&hdev->in_reset)))
+		return true;
+	else
+		return false;
+}
+
 static void hpriv_release(struct kref *ref)
 {
 	struct hl_fpriv *hpriv;
@@ -200,6 +208,7 @@ static int device_early_init(struct hl_device *hdev)
 
 	mutex_init(&hdev->fd_open_cnt_lock);
 	mutex_init(&hdev->send_cpu_message_lock);
+	atomic_set(&hdev->in_reset, 0);
 	atomic_set(&hdev->fd_open_cnt, 0);
 
 	return 0;
@@ -254,6 +263,27 @@ static void set_freq_to_low_job(struct work_struct *work)
 			usecs_to_jiffies(HL_PLL_LOW_JOB_FREQ_USEC));
 }
 
+static void hl_device_heartbeat(struct work_struct *work)
+{
+	struct hl_device *hdev = container_of(work, struct hl_device,
+						work_heartbeat.work);
+
+	if (hl_device_disabled_or_in_reset(hdev))
+		goto reschedule;
+
+	if (!hdev->asic_funcs->send_heartbeat(hdev))
+		goto reschedule;
+
+	dev_err(hdev->dev, "Device heartbeat failed!\n");
+	hl_device_reset(hdev, true, false);
+
+	return;
+
+reschedule:
+	schedule_delayed_work(&hdev->work_heartbeat,
+			usecs_to_jiffies(HL_HEARTBEAT_PER_USEC));
+}
+
 /*
  * device_late_init - do late stuff initialization for the habanalabs device
  *
@@ -289,6 +319,12 @@ static int device_late_init(struct hl_device *hdev)
 	schedule_delayed_work(&hdev->work_freq,
 			usecs_to_jiffies(HL_PLL_LOW_JOB_FREQ_USEC));
 
+	if (hdev->heartbeat) {
+		INIT_DELAYED_WORK(&hdev->work_heartbeat, hl_device_heartbeat);
+		schedule_delayed_work(&hdev->work_heartbeat,
+				usecs_to_jiffies(HL_HEARTBEAT_PER_USEC));
+	}
+
 	hdev->late_init_done = true;
 
 	return 0;
@@ -306,6 +342,8 @@ static void device_late_fini(struct hl_device *hdev)
 		return;
 
 	cancel_delayed_work_sync(&hdev->work_freq);
+	if (hdev->heartbeat)
+		cancel_delayed_work_sync(&hdev->work_heartbeat);
 
 	if (hdev->asic_funcs->late_fini)
 		hdev->asic_funcs->late_fini(hdev);
@@ -413,6 +451,260 @@ int hl_device_resume(struct hl_device *hdev)
 	return 0;
 }
 
+static void hl_device_hard_reset_pending(struct work_struct *work)
+{
+	struct hl_device_reset_work *device_reset_work =
+		container_of(work, struct hl_device_reset_work, reset_work);
+	struct hl_device *hdev = device_reset_work->hdev;
+	u16 pending_cnt = HL_PENDING_RESET_PER_SEC;
+	struct task_struct *task = NULL;
+
+	/* Flush all processes that are inside hl_open */
+	mutex_lock(&hdev->fd_open_cnt_lock);
+
+	while ((atomic_read(&hdev->fd_open_cnt)) && (pending_cnt)) {
+
+		pending_cnt--;
+
+		dev_info(hdev->dev,
+			"Can't HARD reset, waiting for user to close FD\n");
+		ssleep(1);
+	}
+
+	if (atomic_read(&hdev->fd_open_cnt)) {
+		task = get_pid_task(hdev->user_ctx->hpriv->taskpid,
+					PIDTYPE_PID);
+		if (task) {
+			dev_info(hdev->dev, "Killing user processes\n");
+			send_sig(SIGKILL, task, 1);
+			msleep(100);
+
+			put_task_struct(task);
+		}
+	}
+
+	mutex_unlock(&hdev->fd_open_cnt_lock);
+
+	hl_device_reset(hdev, true, true);
+
+	kfree(device_reset_work);
+}
+
+/*
+ * hl_device_reset - reset the device
+ *
+ * @hdev: pointer to habanalabs device structure
+ * @hard_reset: should we do hard reset to all engines or just reset the
+ *              compute/dma engines
+ *
+ * Block future CS and wait for pending CS to be enqueued
+ * Call ASIC H/W fini
+ * Flush all completions
+ * Re-initialize all internal data structures
+ * Call ASIC H/W init, late_init
+ * Test queues
+ * Enable device
+ *
+ * Returns 0 for success or an error on failure.
+ */
+int hl_device_reset(struct hl_device *hdev, bool hard_reset,
+			bool from_hard_reset_thread)
+{
+	int i, rc;
+
+	if (!hdev->init_done) {
+		dev_err(hdev->dev,
+			"Can't reset before initialization is done\n");
+		return 0;
+	}
+
+	/*
+	 * Prevent concurrency in this function - only one reset should be
+	 * done at any given time. Only need to perform this if we didn't
+	 * get from the dedicated hard reset thread
+	 */
+	if (!from_hard_reset_thread) {
+		/* Block future CS/VM/JOB completion operations */
+		rc = atomic_cmpxchg(&hdev->in_reset, 0, 1);
+		if (rc)
+			return 0;
+
+		/* This also blocks future CS/VM/JOB completion operations */
+		hdev->disabled = true;
+
+		/*
+		 * Flush anyone that is inside the critical section of enqueue
+		 * jobs to the H/W
+		 */
+		hdev->asic_funcs->hw_queues_lock(hdev);
+		hdev->asic_funcs->hw_queues_unlock(hdev);
+
+		dev_err(hdev->dev, "Going to RESET device!\n");
+	}
+
+again:
+	if ((hard_reset) && (!from_hard_reset_thread)) {
+		struct hl_device_reset_work *device_reset_work;
+
+		if (!hdev->pdev) {
+			dev_err(hdev->dev,
+				"Reset action is NOT supported in simulator\n");
+			rc = -EINVAL;
+			goto out_err;
+		}
+
+		hdev->hard_reset_pending = true;
+
+		device_reset_work = kzalloc(sizeof(*device_reset_work),
+						GFP_ATOMIC);
+		if (!device_reset_work) {
+			rc = -ENOMEM;
+			goto out_err;
+		}
+
+		/*
+		 * Because the reset function can't run from interrupt or
+		 * from heartbeat work, we need to call the reset function
+		 * from a dedicated work
+		 */
+		INIT_WORK(&device_reset_work->reset_work,
+				hl_device_hard_reset_pending);
+		device_reset_work->hdev = hdev;
+		schedule_work(&device_reset_work->reset_work);
+
+		return 0;
+	}
+
+	if (hard_reset) {
+		device_late_fini(hdev);
+
+		/*
+		 * Now that the heartbeat thread is closed, flush processes
+		 * which are sending messages to CPU
+		 */
+		mutex_lock(&hdev->send_cpu_message_lock);
+		mutex_unlock(&hdev->send_cpu_message_lock);
+	}
+
+	/*
+	 * Halt the engines and disable interrupts so we won't get any more
+	 * completions from H/W and we won't have any accesses from the
+	 * H/W to the host machine
+	 */
+	hdev->asic_funcs->halt_engines(hdev, hard_reset);
+
+	if (hard_reset) {
+		/* Release kernel context */
+		if (hl_ctx_put(hdev->kernel_ctx) != 1) {
+			dev_err(hdev->dev,
+				"kernel ctx is alive during hard reset\n");
+			rc = -EBUSY;
+			goto out_err;
+		}
+
+		hdev->kernel_ctx = NULL;
+	}
+
+	/* Reset the H/W. It will be in idle state after this returns */
+	hdev->asic_funcs->hw_fini(hdev, hard_reset);
+
+	if (hard_reset)
+		hl_eq_reset(hdev, &hdev->event_queue);
+
+	/* Re-initialize PI,CI to 0 in all queues (hw queue, cq) */
+	hl_hw_queue_reset(hdev, hard_reset);
+	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++)
+		hl_cq_reset(hdev, &hdev->completion_queue[i]);
+
+	/* Finished tear-down, starting to re-initialize */
+
+	if (hard_reset) {
+		/* Allocate the kernel context */
+		hdev->kernel_ctx = kzalloc(sizeof(*hdev->kernel_ctx),
+						GFP_KERNEL);
+		if (!hdev->kernel_ctx) {
+			rc = -ENOMEM;
+			goto out_err;
+		}
+
+		hdev->user_ctx = NULL;
+
+		rc = hl_ctx_init(hdev, hdev->kernel_ctx, true);
+		if (rc) {
+			dev_err(hdev->dev,
+				"failed to init kernel ctx in hard reset\n");
+			kfree(hdev->kernel_ctx);
+			hdev->kernel_ctx = NULL;
+			goto out_err;
+		}
+	}
+
+	rc = hdev->asic_funcs->hw_init(hdev);
+	if (rc) {
+		dev_err(hdev->dev,
+			"failed to initialize the H/W after reset\n");
+		goto out_err;
+	}
+
+	hdev->disabled = false;
+
+	/* Check that the communication with the device is working */
+	rc = hdev->asic_funcs->test_queues(hdev);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to detect if device is alive after reset\n");
+		goto out_err;
+	}
+
+	if (hard_reset) {
+		rc = device_late_init(hdev);
+		if (rc) {
+			dev_err(hdev->dev,
+				"Failed late init after hard reset\n");
+			goto out_err;
+		}
+
+		hl_set_max_power(hdev, hdev->max_power);
+
+		hdev->hard_reset_pending = false;
+	} else {
+		rc = hdev->asic_funcs->soft_reset_late_init(hdev);
+		if (rc) {
+			dev_err(hdev->dev,
+				"Failed late init after soft reset\n");
+			goto out_err;
+		}
+	}
+
+	atomic_set(&hdev->in_reset, 0);
+
+	if (hard_reset)
+		hdev->hard_reset_cnt++;
+	else
+		hdev->soft_reset_cnt++;
+
+	return 0;
+
+out_err:
+	hdev->disabled = true;
+
+	if (hard_reset) {
+		dev_err(hdev->dev,
+			"Failed to reset! Device is NOT usable\n");
+		hdev->hard_reset_cnt++;
+	} else {
+		dev_err(hdev->dev,
+			"Failed to do soft-reset, trying hard reset\n");
+		hdev->soft_reset_cnt++;
+		hard_reset = true;
+		goto again;
+	}
+
+	atomic_set(&hdev->in_reset, 0);
+
+	return rc;
+}
+
 /*
  * hl_device_init - main initialization function for habanalabs device
  *
@@ -520,6 +812,12 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 		goto free_cb_pool;
 	}
 
+	if (hdev->asic_funcs->get_hw_state(hdev) == HL_DEVICE_HW_STATE_DIRTY) {
+		dev_info(hdev->dev,
+			"H/W state is dirty, must reset before initializing\n");
+		hdev->asic_funcs->hw_fini(hdev, true);
+	}
+
 	rc = hdev->asic_funcs->hw_init(hdev);
 	if (rc) {
 		dev_err(hdev->dev, "failed to initialize the H/W\n");
@@ -565,6 +863,8 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	dev_notice(hdev->dev,
 		"Successfully added device to habanalabs driver\n");
 
+	hdev->init_done = true;
+
 	return 0;
 
 free_cb_pool:
@@ -612,9 +912,30 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
  */
 void hl_device_fini(struct hl_device *hdev)
 {
-	int i;
+	int i, rc;
+	ktime_t timeout;
+
 	dev_info(hdev->dev, "Removing device\n");
 
+	/*
+	 * This function is competing with the reset function, so try to
+	 * take the reset atomic and if we are already in middle of reset,
+	 * wait until reset function is finished. Reset function is designed
+	 * to always finish (could take up to a few seconds in worst case).
+	 */
+
+	timeout = ktime_add_us(ktime_get(),
+				HL_PENDING_RESET_PER_SEC * 1000 * 1000 * 4);
+	rc = atomic_cmpxchg(&hdev->in_reset, 0, 1);
+	while (rc) {
+		usleep_range(50, 200);
+		rc = atomic_cmpxchg(&hdev->in_reset, 0, 1);
+		if (ktime_compare(ktime_get(), timeout) > 0) {
+			WARN(1, "Failed to remove device because reset function did not finish\n");
+			return;
+		}
+	};
+
 	/* Mark device as disabled */
 	hdev->disabled = true;
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index d46925d921a3..1fe1d6a1ff9e 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -120,6 +120,130 @@ static const char *goya_axi_name[GOYA_MAX_INITIATORS] = {
 
 #define GOYA_ASYC_EVENT_GROUP_NON_FATAL_SIZE 121
 
+static u32 goya_non_fatal_events[GOYA_ASYC_EVENT_GROUP_NON_FATAL_SIZE] = {
+	GOYA_ASYNC_EVENT_ID_PCIE_IF,
+	GOYA_ASYNC_EVENT_ID_TPC0_ECC,
+	GOYA_ASYNC_EVENT_ID_TPC1_ECC,
+	GOYA_ASYNC_EVENT_ID_TPC2_ECC,
+	GOYA_ASYNC_EVENT_ID_TPC3_ECC,
+	GOYA_ASYNC_EVENT_ID_TPC4_ECC,
+	GOYA_ASYNC_EVENT_ID_TPC5_ECC,
+	GOYA_ASYNC_EVENT_ID_TPC6_ECC,
+	GOYA_ASYNC_EVENT_ID_TPC7_ECC,
+	GOYA_ASYNC_EVENT_ID_MME_ECC,
+	GOYA_ASYNC_EVENT_ID_MME_ECC_EXT,
+	GOYA_ASYNC_EVENT_ID_MMU_ECC,
+	GOYA_ASYNC_EVENT_ID_DMA_MACRO,
+	GOYA_ASYNC_EVENT_ID_DMA_ECC,
+	GOYA_ASYNC_EVENT_ID_CPU_IF_ECC,
+	GOYA_ASYNC_EVENT_ID_PSOC_MEM,
+	GOYA_ASYNC_EVENT_ID_PSOC_CORESIGHT,
+	GOYA_ASYNC_EVENT_ID_SRAM0,
+	GOYA_ASYNC_EVENT_ID_SRAM1,
+	GOYA_ASYNC_EVENT_ID_SRAM2,
+	GOYA_ASYNC_EVENT_ID_SRAM3,
+	GOYA_ASYNC_EVENT_ID_SRAM4,
+	GOYA_ASYNC_EVENT_ID_SRAM5,
+	GOYA_ASYNC_EVENT_ID_SRAM6,
+	GOYA_ASYNC_EVENT_ID_SRAM7,
+	GOYA_ASYNC_EVENT_ID_SRAM8,
+	GOYA_ASYNC_EVENT_ID_SRAM9,
+	GOYA_ASYNC_EVENT_ID_SRAM10,
+	GOYA_ASYNC_EVENT_ID_SRAM11,
+	GOYA_ASYNC_EVENT_ID_SRAM12,
+	GOYA_ASYNC_EVENT_ID_SRAM13,
+	GOYA_ASYNC_EVENT_ID_SRAM14,
+	GOYA_ASYNC_EVENT_ID_SRAM15,
+	GOYA_ASYNC_EVENT_ID_SRAM16,
+	GOYA_ASYNC_EVENT_ID_SRAM17,
+	GOYA_ASYNC_EVENT_ID_SRAM18,
+	GOYA_ASYNC_EVENT_ID_SRAM19,
+	GOYA_ASYNC_EVENT_ID_SRAM20,
+	GOYA_ASYNC_EVENT_ID_SRAM21,
+	GOYA_ASYNC_EVENT_ID_SRAM22,
+	GOYA_ASYNC_EVENT_ID_SRAM23,
+	GOYA_ASYNC_EVENT_ID_SRAM24,
+	GOYA_ASYNC_EVENT_ID_SRAM25,
+	GOYA_ASYNC_EVENT_ID_SRAM26,
+	GOYA_ASYNC_EVENT_ID_SRAM27,
+	GOYA_ASYNC_EVENT_ID_SRAM28,
+	GOYA_ASYNC_EVENT_ID_SRAM29,
+	GOYA_ASYNC_EVENT_ID_GIC500,
+	GOYA_ASYNC_EVENT_ID_PLL0,
+	GOYA_ASYNC_EVENT_ID_PLL1,
+	GOYA_ASYNC_EVENT_ID_PLL3,
+	GOYA_ASYNC_EVENT_ID_PLL4,
+	GOYA_ASYNC_EVENT_ID_PLL5,
+	GOYA_ASYNC_EVENT_ID_PLL6,
+	GOYA_ASYNC_EVENT_ID_AXI_ECC,
+	GOYA_ASYNC_EVENT_ID_L2_RAM_ECC,
+	GOYA_ASYNC_EVENT_ID_PSOC_GPIO_05_SW_RESET,
+	GOYA_ASYNC_EVENT_ID_PSOC_GPIO_10_VRHOT_ICRIT,
+	GOYA_ASYNC_EVENT_ID_PCIE_DEC,
+	GOYA_ASYNC_EVENT_ID_TPC0_DEC,
+	GOYA_ASYNC_EVENT_ID_TPC1_DEC,
+	GOYA_ASYNC_EVENT_ID_TPC2_DEC,
+	GOYA_ASYNC_EVENT_ID_TPC3_DEC,
+	GOYA_ASYNC_EVENT_ID_TPC4_DEC,
+	GOYA_ASYNC_EVENT_ID_TPC5_DEC,
+	GOYA_ASYNC_EVENT_ID_TPC6_DEC,
+	GOYA_ASYNC_EVENT_ID_TPC7_DEC,
+	GOYA_ASYNC_EVENT_ID_MME_WACS,
+	GOYA_ASYNC_EVENT_ID_MME_WACSD,
+	GOYA_ASYNC_EVENT_ID_CPU_AXI_SPLITTER,
+	GOYA_ASYNC_EVENT_ID_PSOC_AXI_DEC,
+	GOYA_ASYNC_EVENT_ID_PSOC,
+	GOYA_ASYNC_EVENT_ID_TPC0_KRN_ERR,
+	GOYA_ASYNC_EVENT_ID_TPC1_KRN_ERR,
+	GOYA_ASYNC_EVENT_ID_TPC2_KRN_ERR,
+	GOYA_ASYNC_EVENT_ID_TPC3_KRN_ERR,
+	GOYA_ASYNC_EVENT_ID_TPC4_KRN_ERR,
+	GOYA_ASYNC_EVENT_ID_TPC5_KRN_ERR,
+	GOYA_ASYNC_EVENT_ID_TPC6_KRN_ERR,
+	GOYA_ASYNC_EVENT_ID_TPC7_KRN_ERR,
+	GOYA_ASYNC_EVENT_ID_TPC0_CMDQ,
+	GOYA_ASYNC_EVENT_ID_TPC1_CMDQ,
+	GOYA_ASYNC_EVENT_ID_TPC2_CMDQ,
+	GOYA_ASYNC_EVENT_ID_TPC3_CMDQ,
+	GOYA_ASYNC_EVENT_ID_TPC4_CMDQ,
+	GOYA_ASYNC_EVENT_ID_TPC5_CMDQ,
+	GOYA_ASYNC_EVENT_ID_TPC6_CMDQ,
+	GOYA_ASYNC_EVENT_ID_TPC7_CMDQ,
+	GOYA_ASYNC_EVENT_ID_TPC0_QM,
+	GOYA_ASYNC_EVENT_ID_TPC1_QM,
+	GOYA_ASYNC_EVENT_ID_TPC2_QM,
+	GOYA_ASYNC_EVENT_ID_TPC3_QM,
+	GOYA_ASYNC_EVENT_ID_TPC4_QM,
+	GOYA_ASYNC_EVENT_ID_TPC5_QM,
+	GOYA_ASYNC_EVENT_ID_TPC6_QM,
+	GOYA_ASYNC_EVENT_ID_TPC7_QM,
+	GOYA_ASYNC_EVENT_ID_MME_QM,
+	GOYA_ASYNC_EVENT_ID_MME_CMDQ,
+	GOYA_ASYNC_EVENT_ID_DMA0_QM,
+	GOYA_ASYNC_EVENT_ID_DMA1_QM,
+	GOYA_ASYNC_EVENT_ID_DMA2_QM,
+	GOYA_ASYNC_EVENT_ID_DMA3_QM,
+	GOYA_ASYNC_EVENT_ID_DMA4_QM,
+	GOYA_ASYNC_EVENT_ID_DMA0_CH,
+	GOYA_ASYNC_EVENT_ID_DMA1_CH,
+	GOYA_ASYNC_EVENT_ID_DMA2_CH,
+	GOYA_ASYNC_EVENT_ID_DMA3_CH,
+	GOYA_ASYNC_EVENT_ID_DMA4_CH,
+	GOYA_ASYNC_EVENT_ID_TPC0_BMON_SPMU,
+	GOYA_ASYNC_EVENT_ID_TPC1_BMON_SPMU,
+	GOYA_ASYNC_EVENT_ID_TPC2_BMON_SPMU,
+	GOYA_ASYNC_EVENT_ID_TPC3_BMON_SPMU,
+	GOYA_ASYNC_EVENT_ID_TPC4_BMON_SPMU,
+	GOYA_ASYNC_EVENT_ID_TPC5_BMON_SPMU,
+	GOYA_ASYNC_EVENT_ID_TPC6_BMON_SPMU,
+	GOYA_ASYNC_EVENT_ID_TPC7_BMON_SPMU,
+	GOYA_ASYNC_EVENT_ID_DMA_BM_CH0,
+	GOYA_ASYNC_EVENT_ID_DMA_BM_CH1,
+	GOYA_ASYNC_EVENT_ID_DMA_BM_CH2,
+	GOYA_ASYNC_EVENT_ID_DMA_BM_CH3,
+	GOYA_ASYNC_EVENT_ID_DMA_BM_CH4
+};
+
 static int goya_armcp_info_get(struct hl_device *hdev);
 
 static void goya_get_fixed_properties(struct hl_device *hdev)
@@ -2447,6 +2571,14 @@ static int goya_hw_init(struct hl_device *hdev)
 	/* Perform read from the device to make sure device is up */
 	val = RREG32(mmPCIE_DBI_DEVICE_ID_VENDOR_ID_REG);
 
+	/*
+	 * Let's mark in the H/W that we have reached this point. We check
+	 * this value in the reset_before_init function to understand whether
+	 * we need to reset the chip before doing H/W init. This register is
+	 * cleared by the H/W upon H/W reset
+	 */
+	WREG32(mmPSOC_GLOBAL_CONF_APP_STATUS, HL_DEVICE_HW_STATE_DIRTY);
+
 	rc = goya_init_cpu(hdev, GOYA_CPU_TIMEOUT_USEC);
 	if (rc) {
 		dev_err(hdev->dev, "failed to initialize CPU\n");
@@ -2575,6 +2707,14 @@ static void goya_hw_fini(struct hl_device *hdev, bool hard_reset)
 			"Timeout while waiting for device to reset 0x%x\n",
 			status);
 
+	if (!hard_reset) {
+		goya->hw_cap_initialized &= ~(HW_CAP_DMA | HW_CAP_MME |
+						HW_CAP_GOLDEN | HW_CAP_TPC);
+		WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR,
+				GOYA_ASYNC_EVENT_ID_SOFT_RESET);
+		return;
+	}
+
 	/* Chicken bit to re-initiate boot sequencer flow */
 	WREG32(mmPSOC_GLOBAL_CONF_BOOT_SEQ_RE_START,
 		1 << PSOC_GLOBAL_CONF_BOOT_SEQ_RE_START_IND_SHIFT);
@@ -3184,6 +3324,57 @@ static void goya_print_irq_info(struct hl_device *hdev, u16 event_type)
 	}
 }
 
+static int goya_unmask_irq_arr(struct hl_device *hdev, u32 *irq_arr,
+		size_t irq_arr_size)
+{
+	struct armcp_unmask_irq_arr_packet *pkt;
+	size_t total_pkt_size;
+	long result;
+	int rc;
+
+	total_pkt_size = sizeof(struct armcp_unmask_irq_arr_packet) +
+			irq_arr_size;
+
+	/* data should be aligned to 8 bytes in order to ArmCP to copy it */
+	total_pkt_size = (total_pkt_size + 0x7) & ~0x7;
+
+	/* total_pkt_size is casted to u16 later on */
+	if (total_pkt_size > USHRT_MAX) {
+		dev_err(hdev->dev, "too many elements in IRQ array\n");
+		return -EINVAL;
+	}
+
+	pkt = kzalloc(total_pkt_size, GFP_KERNEL);
+	if (!pkt)
+		return -ENOMEM;
+
+	pkt->length = irq_arr_size / sizeof(irq_arr[0]);
+	memcpy(&pkt->irqs, irq_arr, irq_arr_size);
+
+	pkt->armcp_pkt.ctl = ARMCP_PACKET_UNMASK_RAZWI_IRQ_ARRAY <<
+						ARMCP_PKT_CTL_OPCODE_SHIFT;
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) pkt,
+			total_pkt_size, HL_DEVICE_TIMEOUT_USEC, &result);
+
+	if (rc)
+		dev_err(hdev->dev, "failed to unmask IRQ array\n");
+
+	kfree(pkt);
+
+	return rc;
+}
+
+static int goya_soft_reset_late_init(struct hl_device *hdev)
+{
+	/*
+	 * Unmask all IRQs since some could have been received
+	 * during the soft reset
+	 */
+	return goya_unmask_irq_arr(hdev, goya_non_fatal_events,
+			sizeof(goya_non_fatal_events));
+}
+
 static int goya_unmask_irq(struct hl_device *hdev, u16 event_type)
 {
 	struct armcp_packet pkt;
@@ -3245,6 +3436,7 @@ void goya_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry)
 		dev_err(hdev->dev,
 			"Received H/W interrupt %d, reset the chip\n",
 			event_type);
+		hl_device_reset(hdev, true, false);
 		break;
 
 	case GOYA_ASYNC_EVENT_ID_PCIE_DEC:
@@ -3310,6 +3502,30 @@ void *goya_get_events_stat(struct hl_device *hdev, u32 *size)
 	return goya->events_stat;
 }
 
+int goya_send_heartbeat(struct hl_device *hdev)
+{
+	struct goya_device *goya = hdev->asic_specific;
+	struct armcp_packet hb_pkt;
+	long result;
+	int rc;
+
+	if (!(goya->hw_cap_initialized & HW_CAP_CPU_Q))
+		return 0;
+
+	memset(&hb_pkt, 0, sizeof(hb_pkt));
+
+	hb_pkt.ctl = ARMCP_PACKET_TEST << ARMCP_PKT_CTL_OPCODE_SHIFT;
+	hb_pkt.value = ARMCP_PACKET_FENCE_VAL;
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &hb_pkt,
+			sizeof(hb_pkt), HL_DEVICE_TIMEOUT_USEC, &result);
+
+	if ((rc) || (result != ARMCP_PACKET_FENCE_VAL))
+		rc = -EIO;
+
+	return rc;
+}
+
 static int goya_armcp_info_get(struct hl_device *hdev)
 {
 	struct goya_device *goya = hdev->asic_specific;
@@ -3455,6 +3671,11 @@ int goya_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size)
 	return rc;
 }
 
+static enum hl_device_hw_state goya_get_hw_state(struct hl_device *hdev)
+{
+	return RREG32(mmPSOC_GLOBAL_CONF_APP_STATUS);
+}
+
 static const struct hl_asic_funcs goya_funcs = {
 	.early_init = goya_early_init,
 	.early_fini = goya_early_fini,
@@ -3484,12 +3705,15 @@ static const struct hl_asic_funcs goya_funcs = {
 	.handle_eqe = goya_handle_eqe,
 	.set_pll_profile = goya_set_pll_profile,
 	.get_events_stat = goya_get_events_stat,
+	.send_heartbeat = goya_send_heartbeat,
 	.enable_clock_gating = goya_init_clock_gating,
 	.disable_clock_gating = goya_disable_clock_gating,
+	.soft_reset_late_init = goya_soft_reset_late_init,
 	.hw_queues_lock = goya_hw_queues_lock,
 	.hw_queues_unlock = goya_hw_queues_unlock,
 	.get_eeprom_data = goya_get_eeprom_data,
-	.send_cpu_message = goya_send_cpu_message
+	.send_cpu_message = goya_send_cpu_message,
+	.get_hw_state = goya_get_hw_state
 };
 
 /*
diff --git a/drivers/misc/habanalabs/goya/goya_hwmgr.c b/drivers/misc/habanalabs/goya/goya_hwmgr.c
index 157a204ae7c5..088692c852b6 100644
--- a/drivers/misc/habanalabs/goya/goya_hwmgr.c
+++ b/drivers/misc/habanalabs/goya/goya_hwmgr.c
@@ -38,7 +38,7 @@ static ssize_t mme_clk_show(struct device *dev, struct device_attribute *attr,
 	struct hl_device *hdev = dev_get_drvdata(dev);
 	long value;
 
-	if (hdev->disabled)
+	if (hl_device_disabled_or_in_reset(hdev))
 		return -ENODEV;
 
 	value = hl_get_frequency(hdev, MME_PLL, false);
@@ -57,7 +57,7 @@ static ssize_t mme_clk_store(struct device *dev, struct device_attribute *attr,
 	int rc;
 	long value;
 
-	if (hdev->disabled) {
+	if (hl_device_disabled_or_in_reset(hdev)) {
 		count = -ENODEV;
 		goto fail;
 	}
@@ -87,7 +87,7 @@ static ssize_t tpc_clk_show(struct device *dev, struct device_attribute *attr,
 	struct hl_device *hdev = dev_get_drvdata(dev);
 	long value;
 
-	if (hdev->disabled)
+	if (hl_device_disabled_or_in_reset(hdev))
 		return -ENODEV;
 
 	value = hl_get_frequency(hdev, TPC_PLL, false);
@@ -106,7 +106,7 @@ static ssize_t tpc_clk_store(struct device *dev, struct device_attribute *attr,
 	int rc;
 	long value;
 
-	if (hdev->disabled) {
+	if (hl_device_disabled_or_in_reset(hdev)) {
 		count = -ENODEV;
 		goto fail;
 	}
@@ -136,7 +136,7 @@ static ssize_t ic_clk_show(struct device *dev, struct device_attribute *attr,
 	struct hl_device *hdev = dev_get_drvdata(dev);
 	long value;
 
-	if (hdev->disabled)
+	if (hl_device_disabled_or_in_reset(hdev))
 		return -ENODEV;
 
 	value = hl_get_frequency(hdev, IC_PLL, false);
@@ -155,7 +155,7 @@ static ssize_t ic_clk_store(struct device *dev, struct device_attribute *attr,
 	int rc;
 	long value;
 
-	if (hdev->disabled) {
+	if (hl_device_disabled_or_in_reset(hdev)) {
 		count = -ENODEV;
 		goto fail;
 	}
@@ -185,7 +185,7 @@ static ssize_t mme_clk_curr_show(struct device *dev,
 	struct hl_device *hdev = dev_get_drvdata(dev);
 	long value;
 
-	if (hdev->disabled)
+	if (hl_device_disabled_or_in_reset(hdev))
 		return -ENODEV;
 
 	value = hl_get_frequency(hdev, MME_PLL, true);
@@ -202,7 +202,7 @@ static ssize_t tpc_clk_curr_show(struct device *dev,
 	struct hl_device *hdev = dev_get_drvdata(dev);
 	long value;
 
-	if (hdev->disabled)
+	if (hl_device_disabled_or_in_reset(hdev))
 		return -ENODEV;
 
 	value = hl_get_frequency(hdev, TPC_PLL, true);
@@ -219,7 +219,7 @@ static ssize_t ic_clk_curr_show(struct device *dev,
 	struct hl_device *hdev = dev_get_drvdata(dev);
 	long value;
 
-	if (hdev->disabled)
+	if (hl_device_disabled_or_in_reset(hdev))
 		return -ENODEV;
 
 	value = hl_get_frequency(hdev, IC_PLL, true);
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 7ec1d0908053..744e37bbc2a6 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -21,8 +21,12 @@
 
 #define HL_MMAP_CB_MASK			(0x8000000000000000ull >> PAGE_SHIFT)
 
+#define HL_PENDING_RESET_PER_SEC	5
+
 #define HL_DEVICE_TIMEOUT_USEC		1000000 /* 1 s */
 
+#define HL_HEARTBEAT_PER_USEC		5000000 /* 5 s */
+
 #define HL_PLL_LOW_JOB_FREQ_USEC	5000000 /* 5 s */
 
 #define HL_MAX_QUEUES			128
@@ -57,6 +61,18 @@ struct hw_queue_properties {
 	u8			kmd_only;
 };
 
+/**
+ * enum hl_device_hw_state - H/W device state. use this to understand whether
+ *                           to do reset before hw_init or not
+ * @HL_DEVICE_HW_STATE_CLEAN: H/W state is clean. i.e. after hard reset
+ * @HL_DEVICE_HW_STATE_DIRTY: H/W state is dirty. i.e. we started to execute
+ *                            hw_init
+ */
+enum hl_device_hw_state {
+	HL_DEVICE_HW_STATE_CLEAN = 0,
+	HL_DEVICE_HW_STATE_DIRTY
+};
+
 /**
  * struct asic_fixed_properties - ASIC specific immutable properties.
  * @hw_queues_props: H/W queues properties.
@@ -361,12 +377,15 @@ enum hl_pll_frequency {
  * @handle_eqe: handle event queue entry (IRQ) from ArmCP.
  * @set_pll_profile: change PLL profile (manual/automatic).
  * @get_events_stat: retrieve event queue entries histogram.
+ * @send_heartbeat: send is-alive packet to ArmCP and verify response.
  * @enable_clock_gating: enable clock gating for reducing power consumption.
  * @disable_clock_gating: disable clock for accessing registers on HBW.
+ * @soft_reset_late_init: perform certain actions needed after soft reset.
  * @hw_queues_lock: acquire H/W queues lock.
  * @hw_queues_unlock: release H/W queues lock.
  * @get_eeprom_data: retrieve EEPROM data from F/W.
  * @send_cpu_message: send buffer to ArmCP.
+ * @get_hw_state: retrieve the H/W state
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
@@ -408,14 +427,17 @@ struct hl_asic_funcs {
 	void (*set_pll_profile)(struct hl_device *hdev,
 			enum hl_pll_frequency freq);
 	void* (*get_events_stat)(struct hl_device *hdev, u32 *size);
+	int (*send_heartbeat)(struct hl_device *hdev);
 	void (*enable_clock_gating)(struct hl_device *hdev);
 	void (*disable_clock_gating)(struct hl_device *hdev);
+	int (*soft_reset_late_init)(struct hl_device *hdev);
 	void (*hw_queues_lock)(struct hl_device *hdev);
 	void (*hw_queues_unlock)(struct hl_device *hdev);
 	int (*get_eeprom_data)(struct hl_device *hdev, void *data,
 				size_t max_size);
 	int (*send_cpu_message)(struct hl_device *hdev, u32 *msg,
 				u16 len, u32 timeout, long *result);
+	enum hl_device_hw_state (*get_hw_state)(struct hl_device *hdev);
 };
 
 
@@ -529,6 +551,16 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
 
 struct hwmon_chip_info;
 
+/**
+ * struct hl_device_reset_work - reset workqueue task wrapper.
+ * @reset_work: reset work to be done.
+ * @hdev: habanalabs device structure.
+ */
+struct hl_device_reset_work {
+	struct work_struct		reset_work;
+	struct hl_device		*hdev;
+};
+
 /**
  * struct hl_device - habanalabs device structure.
  * @pdev: pointer to PCI device, can be NULL in case of simulator device.
@@ -537,6 +569,7 @@ struct hwmon_chip_info;
  * @cdev: related char device.
  * @dev: realted kernel basic device structure.
  * @work_freq: delayed work to lower device frequency if possible.
+ * @work_heartbeat: delayed work for ArmCP is-alive check.
  * @asic_name: ASIC specific nmae.
  * @asic_type: ASIC specific type.
  * @completion_queue: array of hl_cq.
@@ -568,6 +601,7 @@ struct hwmon_chip_info;
  * @cb_pool: list of preallocated CBs.
  * @cb_pool_lock: protects the CB pool.
  * @user_ctx: current user context executing.
+ * @in_reset: is device in reset flow.
  * @curr_pll_profile: current PLL profile.
  * @fd_open_cnt: number of open user processes.
  * @max_power: the max power of the device, as configured by the sysadmin. This
@@ -575,10 +609,15 @@ struct hwmon_chip_info;
  *             value and update the F/W after the re-initialization
  * @major: habanalabs KMD major.
  * @high_pll: high PLL profile frequency.
+ * @soft_reset_cnt: number of soft reset since KMD loading.
+ * @hard_reset_cnt: number of hard reset since KMD loading.
  * @id: device minor.
  * @disabled: is device disabled.
  * @late_init_done: is late init stage was done during initialization.
  * @hwmon_initialized: is H/W monitor sensors was initialized.
+ * @hard_reset_pending: is there a hard reset work pending.
+ * @heartbeat: is heartbeat sanity check towards ArmCP enabled.
+ * @init_done: is the initialization of the device done.
  */
 struct hl_device {
 	struct pci_dev			*pdev;
@@ -587,6 +626,7 @@ struct hl_device {
 	struct cdev			cdev;
 	struct device			*dev;
 	struct delayed_work		work_freq;
+	struct delayed_work		work_heartbeat;
 	char				asic_name[16];
 	enum hl_asic_type		asic_type;
 	struct hl_cq			*completion_queue;
@@ -618,15 +658,21 @@ struct hl_device {
 	/* TODO: remove user_ctx for multiple process support */
 	struct hl_ctx			*user_ctx;
 
+	atomic_t			in_reset;
 	atomic_t			curr_pll_profile;
 	atomic_t			fd_open_cnt;
 	u64				max_power;
 	u32				major;
 	u32				high_pll;
+	u32				soft_reset_cnt;
+	u32				hard_reset_cnt;
 	u16				id;
 	u8				disabled;
 	u8				late_init_done;
 	u8				hwmon_initialized;
+	u8				hard_reset_pending;
+	u8				heartbeat;
+	u8				init_done;
 
 	/* Parameters for bring-up */
 	u8				cpu_enable;
@@ -667,6 +713,7 @@ struct hl_ioctl_desc {
  */
 
 int hl_device_open(struct inode *inode, struct file *filp);
+bool hl_device_disabled_or_in_reset(struct hl_device *hdev);
 int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 		enum hl_asic_type asic_type, int minor);
 void destroy_hdev(struct hl_device *hdev);
@@ -680,6 +727,7 @@ int hl_hw_queue_send_cb_no_cmpl(struct hl_device *hdev, u32 hw_queue_id,
 				u32 cb_size, u64 cb_ptr);
 u32 hl_hw_queue_add_ptr(u32 ptr, u16 val);
 void hl_hw_queue_inc_ci_kernel(struct hl_device *hdev, u32 hw_queue_id);
+void hl_hw_queue_reset(struct hl_device *hdev, bool hard_reset);
 
 #define hl_queue_inc_ptr(p)		hl_hw_queue_add_ptr(p, 1)
 #define hl_pi_2_offset(pi)		((pi) & (HL_QUEUE_LENGTH - 1))
@@ -688,6 +736,8 @@ int hl_cq_init(struct hl_device *hdev, struct hl_cq *q, u32 hw_queue_id);
 void hl_cq_fini(struct hl_device *hdev, struct hl_cq *q);
 int hl_eq_init(struct hl_device *hdev, struct hl_eq *q);
 void hl_eq_fini(struct hl_device *hdev, struct hl_eq *q);
+void hl_cq_reset(struct hl_device *hdev, struct hl_cq *q);
+void hl_eq_reset(struct hl_device *hdev, struct hl_eq *q);
 irqreturn_t hl_irq_handler_cq(int irq, void *arg);
 irqreturn_t hl_irq_handler_eq(int irq, void *arg);
 int hl_asid_init(struct hl_device *hdev);
@@ -705,6 +755,8 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass);
 void hl_device_fini(struct hl_device *hdev);
 int hl_device_suspend(struct hl_device *hdev);
 int hl_device_resume(struct hl_device *hdev);
+int hl_device_reset(struct hl_device *hdev, bool hard_reset,
+			bool from_hard_reset_thread);
 void hl_hpriv_get(struct hl_fpriv *hpriv);
 void hl_hpriv_put(struct hl_fpriv *hpriv);
 int hl_device_set_frequency(struct hl_device *hdev, enum hl_pll_frequency freq);
diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
index 4f3d68395b98..b0bf77af1e40 100644
--- a/drivers/misc/habanalabs/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -84,9 +84,9 @@ int hl_device_open(struct inode *inode, struct file *filp)
 
 	mutex_lock(&hdev->fd_open_cnt_lock);
 
-	if (hdev->disabled) {
+	if (hl_device_disabled_or_in_reset(hdev)) {
 		dev_err_ratelimited(hdev->dev,
-			"Can't open %s because it is disabled\n",
+			"Can't open %s because it is disabled or in reset\n",
 			dev_name(hdev->dev));
 		mutex_unlock(&hdev->fd_open_cnt_lock);
 		return -EPERM;
@@ -179,6 +179,7 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 	hdev->cpu_queues_enable = 1;
 	hdev->fw_loading = 1;
 	hdev->pldm = 0;
+	hdev->heartbeat = 1;
 
 	/* If CPU is disabled, no point in loading FW */
 	if (!hdev->cpu_enable)
@@ -188,6 +189,10 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 	if (!hdev->fw_loading)
 		hdev->cpu_queues_enable = 0;
 
+	/* If CPU queues not enabled, no way to do heartbeat */
+	if (!hdev->cpu_queues_enable)
+		hdev->heartbeat = 0;
+
 	hdev->disabled = true;
 	hdev->pdev = pdev; /* can be NULL in case of simulator device */
 
diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
index e53265fe9543..e56a51f6bab6 100644
--- a/drivers/misc/habanalabs/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
@@ -33,6 +33,12 @@ long hl_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	unsigned int usize, asize;
 	int retcode;
 
+	if (hdev->hard_reset_pending) {
+		dev_crit_ratelimited(hdev->dev,
+			"Device HARD reset pending! Please close FD\n");
+		return -ENODEV;
+	}
+
 	if ((nr >= HL_COMMAND_START) && (nr < HL_COMMAND_END)) {
 		u32 hl_size;
 
diff --git a/drivers/misc/habanalabs/hwmon.c b/drivers/misc/habanalabs/hwmon.c
index 13843112e146..9c359a1dd868 100644
--- a/drivers/misc/habanalabs/hwmon.c
+++ b/drivers/misc/habanalabs/hwmon.c
@@ -114,7 +114,7 @@ static int hl_read(struct device *dev, enum hwmon_sensor_types type,
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
 
-	if (hdev->disabled)
+	if (hl_device_disabled_or_in_reset(hdev))
 		return -ENODEV;
 
 	switch (type) {
@@ -188,7 +188,7 @@ static int hl_write(struct device *dev, enum hwmon_sensor_types type,
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
 
-	if (hdev->disabled)
+	if (hl_device_disabled_or_in_reset(hdev))
 		return -ENODEV;
 
 	switch (type) {
diff --git a/drivers/misc/habanalabs/irq.c b/drivers/misc/habanalabs/irq.c
index c12116042d8b..d4c2077a3718 100644
--- a/drivers/misc/habanalabs/irq.c
+++ b/drivers/misc/habanalabs/irq.c
@@ -250,6 +250,23 @@ void hl_cq_fini(struct hl_device *hdev, struct hl_cq *q)
 			(void *) (uintptr_t) q->kernel_address, q->bus_address);
 }
 
+void hl_cq_reset(struct hl_device *hdev, struct hl_cq *q)
+{
+	q->ci = 0;
+	q->pi = 0;
+
+	atomic_set(&q->free_slots_cnt, HL_CQ_LENGTH);
+
+	/*
+	 * It's not enough to just reset the PI/CI because the H/W may have
+	 * written valid completion entries before it was halted and therefore
+	 * we need to clean the actual queues so we won't process old entries
+	 * when the device is operational again
+	 */
+
+	memset((void *) (uintptr_t) q->kernel_address, 0, HL_CQ_SIZE_IN_BYTES);
+}
+
 /*
  * hl_eq_init - main initialization function for an event queue object
  *
@@ -292,3 +309,17 @@ void hl_eq_fini(struct hl_device *hdev, struct hl_eq *q)
 	hdev->asic_funcs->dma_free_coherent(hdev, HL_EQ_SIZE_IN_BYTES,
 			(void *) (uintptr_t) q->kernel_address, q->bus_address);
 }
+
+void hl_eq_reset(struct hl_device *hdev, struct hl_eq *q)
+{
+	q->ci = 0;
+
+	/*
+	 * It's not enough to just reset the PI/CI because the H/W may have
+	 * written valid completion entries before it was halted and therefore
+	 * we need to clean the actual queues so we won't process old entries
+	 * when the device is operational again
+	 */
+
+	memset((void *) (uintptr_t) q->kernel_address, 0, HL_EQ_SIZE_IN_BYTES);
+}
diff --git a/drivers/misc/habanalabs/sysfs.c b/drivers/misc/habanalabs/sysfs.c
index 20481fd9ed20..6d80e7e0885c 100644
--- a/drivers/misc/habanalabs/sysfs.c
+++ b/drivers/misc/habanalabs/sysfs.c
@@ -104,7 +104,7 @@ static ssize_t pm_mng_profile_show(struct device *dev,
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
 
-	if (hdev->disabled)
+	if (hl_device_disabled_or_in_reset(hdev))
 		return -ENODEV;
 
 	return sprintf(buf, "%s\n",
@@ -118,7 +118,7 @@ static ssize_t pm_mng_profile_store(struct device *dev,
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
 
-	if (hdev->disabled) {
+	if (hl_device_disabled_or_in_reset(hdev)) {
 		count = -ENODEV;
 		goto out;
 	}
@@ -162,7 +162,7 @@ static ssize_t high_pll_show(struct device *dev, struct device_attribute *attr,
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
 
-	if (hdev->disabled)
+	if (hl_device_disabled_or_in_reset(hdev))
 		return -ENODEV;
 
 	return sprintf(buf, "%u\n", hdev->high_pll);
@@ -175,7 +175,7 @@ static ssize_t high_pll_store(struct device *dev, struct device_attribute *attr,
 	long value;
 	int rc;
 
-	if (hdev->disabled) {
+	if (hl_device_disabled_or_in_reset(hdev)) {
 		count = -ENODEV;
 		goto out;
 	}
@@ -259,6 +259,48 @@ static ssize_t preboot_btl_ver_show(struct device *dev,
 	return sprintf(buf, "%s\n", hdev->asic_prop.preboot_ver);
 }
 
+static ssize_t soft_reset_store(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+	long value;
+	int rc;
+
+	rc = kstrtoul(buf, 0, &value);
+
+	if (rc) {
+		count = -EINVAL;
+		goto out;
+	}
+
+	hl_device_reset(hdev, false, false);
+
+out:
+	return count;
+}
+
+static ssize_t hard_reset_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+	long value;
+	int rc;
+
+	rc = kstrtoul(buf, 0, &value);
+
+	if (rc) {
+		count = -EINVAL;
+		goto out;
+	}
+
+	hl_device_reset(hdev, true, false);
+
+out:
+	return count;
+}
+
 static ssize_t device_type_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -300,7 +342,9 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
 	struct hl_device *hdev = dev_get_drvdata(dev);
 	char *str;
 
-	if (hdev->disabled)
+	if (atomic_read(&hdev->in_reset))
+		str = "In reset";
+	else if (hdev->disabled)
 		str = "Malfunction";
 	else
 		str = "Operational";
@@ -316,13 +360,29 @@ static ssize_t write_open_cnt_show(struct device *dev,
 	return sprintf(buf, "%d\n", hdev->user_ctx ? 1 : 0);
 }
 
+static ssize_t soft_reset_cnt_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", hdev->soft_reset_cnt);
+}
+
+static ssize_t hard_reset_cnt_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", hdev->hard_reset_cnt);
+}
+
 static ssize_t max_power_show(struct device *dev, struct device_attribute *attr,
 				char *buf)
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
 	long val;
 
-	if (hdev->disabled)
+	if (hl_device_disabled_or_in_reset(hdev))
 		return -ENODEV;
 
 	val = hl_get_max_power(hdev);
@@ -337,7 +397,7 @@ static ssize_t max_power_store(struct device *dev,
 	unsigned long value;
 	int rc;
 
-	if (hdev->disabled) {
+	if (hl_device_disabled_or_in_reset(hdev)) {
 		count = -ENODEV;
 		goto out;
 	}
@@ -389,12 +449,16 @@ static DEVICE_ATTR_RO(armcp_ver);
 static DEVICE_ATTR_RO(cpld_ver);
 static DEVICE_ATTR_RO(device_type);
 static DEVICE_ATTR_RO(fuse_ver);
+static DEVICE_ATTR_WO(hard_reset);
+static DEVICE_ATTR_RO(hard_reset_cnt);
 static DEVICE_ATTR_RW(high_pll);
 static DEVICE_ATTR_RO(infineon_ver);
 static DEVICE_ATTR_RW(max_power);
 static DEVICE_ATTR_RO(pci_addr);
 static DEVICE_ATTR_RW(pm_mng_profile);
 static DEVICE_ATTR_RO(preboot_btl_ver);
+static DEVICE_ATTR_WO(soft_reset);
+static DEVICE_ATTR_RO(soft_reset_cnt);
 static DEVICE_ATTR_RO(status);
 static DEVICE_ATTR_RO(thermal_ver);
 static DEVICE_ATTR_RO(uboot_ver);
@@ -412,12 +476,16 @@ static struct attribute *hl_dev_attrs[] = {
 	&dev_attr_cpld_ver.attr,
 	&dev_attr_device_type.attr,
 	&dev_attr_fuse_ver.attr,
+	&dev_attr_hard_reset.attr,
+	&dev_attr_hard_reset_cnt.attr,
 	&dev_attr_high_pll.attr,
 	&dev_attr_infineon_ver.attr,
 	&dev_attr_max_power.attr,
 	&dev_attr_pci_addr.attr,
 	&dev_attr_pm_mng_profile.attr,
 	&dev_attr_preboot_btl_ver.attr,
+	&dev_attr_soft_reset.attr,
+	&dev_attr_soft_reset_cnt.attr,
 	&dev_attr_status.attr,
 	&dev_attr_thermal_ver.attr,
 	&dev_attr_uboot_ver.attr,
-- 
2.18.0

