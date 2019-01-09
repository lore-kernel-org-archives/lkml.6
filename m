Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234BEC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5224206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v1dhDkJd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbfAICLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 21:11:30 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:45739 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729327AbfAICL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 21:11:29 -0500
Received: by mail-qt1-f201.google.com with SMTP id w1so5206862qta.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 18:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IFOF9XQe8fUM/Gsdgu44gKiVB74j0iA6xaxTxEOQUtE=;
        b=v1dhDkJdYQKN1dclahjdxwCh3TrySY7JxT/Pmm6FfEKAZxKoJvW7lBPhHy/ko3ZwmS
         aAKWy0Lk2UDAbPy19wTzCOm1IMrNQKorycrHEFFsULMo1PPcpgcV2yt0lnOgSraHIP0n
         hBIQDDRNfhyBSqaLOoZadqUgWzB3scIb4W68yBCoZvHT4R4u15cArZELD6Cy4vzOdYha
         7ov2JIoeD7peUy9SQqo3tklE95Az8Bo5jsKTl9U0DgRzg/Z0/a12lgj5VkuJ3vaSKIyh
         JB+grHRDY0LpQAoRAUIb795e2zmiJk2alWrT6nCLGKhHUB4P8RWe6e/KF10b+baYU9nb
         rLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IFOF9XQe8fUM/Gsdgu44gKiVB74j0iA6xaxTxEOQUtE=;
        b=IN1GsvgrUsdyLIedfNtjU18+42QHpTTjiCY0d86RdQPUULnCuKL76ptrpS7gBclcHw
         cH/mmJdxtG/1fnUQckX8XPzPO4gz51sktxA67jZJyEj/a3omROtyOqNIhcn3k+B3gSqM
         iLA/bZRA0QsdySBY/DGUTICV35/CUONB6c2Ros0CBBnhv9lcNlkeBYttJITurjmX7ABv
         A6V3YjttI0OvxunwSkSKwH2ySn7mOcG3P1fVS8C0d24286azMwFy2gwA1Rl+QruTwWoz
         4tE+7almgnucIujO0ZDbv+9dpFkwQ6IUqiQZQMw5hgWaJTh8a4mtFrCRSIQnVK2UHZB9
         tzEA==
X-Gm-Message-State: AJcUukcKcemVv4F0E6tteC1pwyVIxdJlpnudB+T7N1qeXQO56hVX4gKy
        HhqT4MwbtcJ+lEClPEb5NkPofrpp
X-Google-Smtp-Source: ALg8bN6N6yGkwkEUOYhN9Y2e/1C8lH+L1rOwy+8m5L8Yhj8kbVLdfwLsoSTq3p7AN/KJB3c5gRV9KlKO
X-Received: by 2002:ac8:4307:: with SMTP id z7mr2817600qtm.7.1546999887619;
 Tue, 08 Jan 2019 18:11:27 -0800 (PST)
Date:   Tue,  8 Jan 2019 18:11:12 -0800
In-Reply-To: <20190109021112.5836-1-rkir@google.com>
Message-Id: <20190109021112.5836-3-rkir@google.com>
Mime-Version: 1.0
References: <20190109021112.5836-1-rkir@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v3 3/3] drivers: platform: goldfish: goldfish_sync: add a driver
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

The Goldfish sync driver is designed to provide a interface
between the underlying host's sync device and the kernel's
fence sync framework.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
Changes in v3:
 - Removed WARN_ON.

Changes in v2:
 - Added a missing include (mod_devicetable.h).
 - Put in one batch with goldfish_address_space.c to avoid merge comflicts.

 drivers/platform/goldfish/Kconfig           |   7 +
 drivers/platform/goldfish/Makefile          |   1 +
 drivers/platform/goldfish/goldfish_sync.c   | 827 ++++++++++++++++++++
 include/uapi/linux/goldfish/goldfish_sync.h |  28 +
 4 files changed, 863 insertions(+)
 create mode 100644 drivers/platform/goldfish/goldfish_sync.c
 create mode 100644 include/uapi/linux/goldfish/goldfish_sync.h

diff --git a/drivers/platform/goldfish/Kconfig b/drivers/platform/goldfish/Kconfig
index 60ecec4a3c59..841250235430 100644
--- a/drivers/platform/goldfish/Kconfig
+++ b/drivers/platform/goldfish/Kconfig
@@ -25,4 +25,11 @@ config GOLDFISH_ADDRESS_SPACE
 	  populate them later in the host. This allows sharing host's memory
 	  with the guest.
 
+config GOLDFISH_SYNC
+	tristate "Goldfish AVD Sync Driver"
+	depends on SW_SYNC
+	depends on SYNC_FILE
+	help
+	  Emulated sync fences for the Goldfish Android Virtual Device.
+
 endif # GOLDFISH
diff --git a/drivers/platform/goldfish/Makefile b/drivers/platform/goldfish/Makefile
index 034abe0727b8..bdff4d6a0ad9 100644
--- a/drivers/platform/goldfish/Makefile
+++ b/drivers/platform/goldfish/Makefile
@@ -3,3 +3,4 @@
 #
 obj-$(CONFIG_GOLDFISH_PIPE)	+= goldfish_pipe.o
 obj-$(CONFIG_GOLDFISH_ADDRESS_SPACE) += goldfish_address_space.o
+obj-$(CONFIG_GOLDFISH_SYNC)	+= goldfish_sync.o
diff --git a/drivers/platform/goldfish/goldfish_sync.c b/drivers/platform/goldfish/goldfish_sync.c
new file mode 100644
index 000000000000..3a68e2bb436c
--- /dev/null
+++ b/drivers/platform/goldfish/goldfish_sync.c
@@ -0,0 +1,827 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/* The Goldfish sync driver is designed to provide a interface
+ * between the underlying host's sync device and the kernel's
+ * fence sync framework.
+ *
+ * The purpose of the device/driver is to enable lightweight creation and
+ * signaling of timelines and fences in order to synchronize the guest with
+ * host-side graphics events.
+ *
+ * Each time the interrupt trips, the driver may perform a sync operation.
+ */
+
+#include <linux/acpi.h>
+#include <linux/dma-fence.h>
+#include <linux/fdtable.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/kref.h>
+#include <linux/miscdevice.h>
+#include <linux/mm.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/sync_file.h>
+#include <linux/syscalls.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+
+#include <uapi/linux/goldfish/goldfish_sync.h>
+
+struct sync_pt {
+	struct dma_fence base;	/* must be the first field in this struct */
+	struct list_head active_list;	/* see active_list_head below */
+};
+
+struct goldfish_sync_state;
+
+struct goldfish_sync_timeline {
+	struct goldfish_sync_state *sync_state;
+
+	/* This object is owned by userspace from open() calls and also each
+	 * sync_pt refers to it.
+	 */
+	struct kref		kref;
+	char			name[32];	/* for debugging */
+
+	u64			context;
+	unsigned int		seqno;
+	/* list of active (unsignaled/errored) sync_pts */
+	struct list_head	active_list_head;
+	spinlock_t		lock;	/* protects the fields above */
+};
+
+/* The above definitions (command codes, register layout, ioctl definitions)
+ * need to be in sync with the following files:
+ *
+ * Host-side (emulator):
+ * external/qemu/android/emulation/goldfish_sync.h
+ * external/qemu-android/hw/misc/goldfish_sync.c
+ *
+ * Guest-side (system image):
+ * device/generic/goldfish-opengl/system/egl/goldfish_sync.h
+ * device/generic/goldfish/ueventd.ranchu.rc
+ * platform/build/target/board/generic/sepolicy/file_contexts
+ */
+struct goldfish_sync_hostcmd {
+	/* sorted for alignment */
+	u64 handle;
+	u64 hostcmd_handle;
+	u32 cmd;
+	u32 time_arg;
+};
+
+struct goldfish_sync_guestcmd {
+	u64 host_command; /* u64 for alignment */
+	u64 glsync_handle;
+	u64 thread_handle;
+	u64 guest_timeline_handle;
+};
+
+/* The host operations are: */
+enum cmd_id {
+	/* Ready signal - used to mark when irq should lower */
+	CMD_SYNC_READY			= 0,
+
+	/* Create a new timeline. writes timeline handle */
+	CMD_CREATE_SYNC_TIMELINE	= 1,
+
+	/* Create a fence object. reads timeline handle and time argument.
+	 * Writes fence fd to the SYNC_REG_HANDLE register.
+	 */
+	CMD_CREATE_SYNC_FENCE		= 2,
+
+	/* Increments timeline. reads timeline handle and time argument */
+	CMD_SYNC_TIMELINE_INC		= 3,
+
+	/* Destroys a timeline. reads timeline handle */
+	CMD_DESTROY_SYNC_TIMELINE	= 4,
+
+	/* Starts a wait on the host with the given glsync object and
+	 * sync thread handle.
+	 */
+	CMD_TRIGGER_HOST_WAIT		= 5,
+};
+
+/* The host register layout is: */
+enum sync_reg_id {
+	/* host->guest batch commands */
+	SYNC_REG_BATCH_COMMAND			= 0x00,
+
+	/* guest->host batch commands */
+	SYNC_REG_BATCH_GUESTCOMMAND		= 0x04,
+
+	/* communicate physical address of host->guest batch commands */
+	SYNC_REG_BATCH_COMMAND_ADDR		= 0x08,
+	SYNC_REG_BATCH_COMMAND_ADDR_HIGH	= 0x0C, /* 64-bit part */
+
+	/* communicate physical address of guest->host commands */
+	SYNC_REG_BATCH_GUESTCOMMAND_ADDR	= 0x10,
+	SYNC_REG_BATCH_GUESTCOMMAND_ADDR_HIGH	= 0x14, /* 64-bit part */
+
+	/* signals that the device has been probed */
+	SYNC_REG_INIT				= 0x18,
+};
+
+#define GOLDFISH_SYNC_MAX_CMDS 32
+
+/* The driver state: */
+struct goldfish_sync_state {
+	struct miscdevice miscdev;
+
+	char __iomem *reg_base;
+	int irq;
+
+	/* Used to generate unique names, see goldfish_sync_timeline::name. */
+	u64 id_counter;
+
+	/* |mutex_lock| protects all concurrent access
+	 * to timelines for both kernel and user space.
+	 */
+	struct mutex mutex_lock;
+
+	/* Buffer holding commands issued from host. */
+	struct goldfish_sync_hostcmd to_do[GOLDFISH_SYNC_MAX_CMDS];
+	u32 to_do_end;
+	/* Protects to_do and to_do_end */
+	spinlock_t to_do_lock;
+
+	/* Buffers for the reading or writing
+	 * of individual commands. The host can directly write
+	 * to |batch_hostcmd| (and then this driver immediately
+	 * copies contents to |to_do|). This driver either replies
+	 * through |batch_hostcmd| or simply issues a
+	 * guest->host command through |batch_guestcmd|.
+	 */
+	struct goldfish_sync_hostcmd batch_hostcmd;
+	struct goldfish_sync_guestcmd batch_guestcmd;
+
+	/* Used to give this struct itself to a work queue
+	 * function for executing actual sync commands.
+	 */
+	struct work_struct work_item;
+};
+
+static struct goldfish_sync_timeline
+*goldfish_dma_fence_parent(struct dma_fence *fence)
+{
+	return container_of(fence->lock, struct goldfish_sync_timeline, lock);
+}
+
+static struct sync_pt *goldfish_sync_fence_to_sync_pt(struct dma_fence *fence)
+{
+	return container_of(fence, struct sync_pt, base);
+}
+
+/* sync_state->mutex_lock must be locked. */
+struct goldfish_sync_timeline __must_check
+*goldfish_sync_timeline_create(struct goldfish_sync_state *sync_state)
+{
+	struct goldfish_sync_timeline *tl;
+
+	tl = kzalloc(sizeof(*tl), GFP_KERNEL);
+	if (!tl)
+		return NULL;
+
+	tl->sync_state = sync_state;
+	kref_init(&tl->kref);
+	snprintf(tl->name, sizeof(tl->name),
+		 "%s:%llu", GOLDFISH_SYNC_DEVICE_NAME,
+		 ++sync_state->id_counter);
+	tl->context = dma_fence_context_alloc(1);
+	tl->seqno = 0;
+	INIT_LIST_HEAD(&tl->active_list_head);
+	spin_lock_init(&tl->lock);
+
+	return tl;
+}
+
+static void goldfish_sync_timeline_free(struct kref *kref)
+{
+	struct goldfish_sync_timeline *tl =
+		container_of(kref, struct goldfish_sync_timeline, kref);
+
+	kfree(tl);
+}
+
+static void goldfish_sync_timeline_get(struct goldfish_sync_timeline *tl)
+{
+	kref_get(&tl->kref);
+}
+
+void goldfish_sync_timeline_put(struct goldfish_sync_timeline *tl)
+{
+	kref_put(&tl->kref, goldfish_sync_timeline_free);
+}
+
+void goldfish_sync_timeline_signal(struct goldfish_sync_timeline *tl,
+				   unsigned int inc)
+{
+	unsigned long flags;
+	struct sync_pt *pt, *next;
+
+	spin_lock_irqsave(&tl->lock, flags);
+	tl->seqno += inc;
+
+	list_for_each_entry_safe(pt, next, &tl->active_list_head, active_list) {
+		/* dma_fence_is_signaled_locked has side effects */
+		if (dma_fence_is_signaled_locked(&pt->base))
+			list_del_init(&pt->active_list);
+	}
+	spin_unlock_irqrestore(&tl->lock, flags);
+}
+
+static const struct dma_fence_ops goldfish_sync_timeline_fence_ops;
+
+static struct sync_pt __must_check
+*goldfish_sync_pt_create(struct goldfish_sync_timeline *tl,
+			 unsigned int value)
+{
+	struct sync_pt *pt = kzalloc(sizeof(*pt), GFP_KERNEL);
+
+	if (!pt)
+		return NULL;
+
+	dma_fence_init(&pt->base,
+		       &goldfish_sync_timeline_fence_ops,
+		       &tl->lock,
+		       tl->context,
+		       value);
+	INIT_LIST_HEAD(&pt->active_list);
+	goldfish_sync_timeline_get(tl);	/* pt refers to tl */
+
+	return pt;
+}
+
+static void goldfish_sync_pt_destroy(struct sync_pt *pt)
+{
+	struct goldfish_sync_timeline *tl =
+		goldfish_dma_fence_parent(&pt->base);
+	unsigned long flags;
+
+	spin_lock_irqsave(&tl->lock, flags);
+	if (!list_empty(&pt->active_list))
+		list_del(&pt->active_list);
+	spin_unlock_irqrestore(&tl->lock, flags);
+
+	goldfish_sync_timeline_put(tl);	/* unref pt from tl */
+	dma_fence_free(&pt->base);
+}
+
+static const char
+*goldfish_sync_timeline_fence_get_driver_name(struct dma_fence *fence)
+{
+	return "sw_sync";
+}
+
+static const char
+*goldfish_sync_timeline_fence_get_timeline_name(struct dma_fence *fence)
+{
+	struct goldfish_sync_timeline *tl = goldfish_dma_fence_parent(fence);
+
+	return tl->name;
+}
+
+static void goldfish_sync_timeline_fence_release(struct dma_fence *fence)
+{
+	goldfish_sync_pt_destroy(goldfish_sync_fence_to_sync_pt(fence));
+}
+
+static bool goldfish_sync_timeline_fence_signaled(struct dma_fence *fence)
+{
+	struct goldfish_sync_timeline *tl = goldfish_dma_fence_parent(fence);
+
+	return tl->seqno >= fence->seqno;
+}
+
+static bool
+goldfish_sync_timeline_fence_enable_signaling(struct dma_fence *fence)
+{
+	struct sync_pt *pt;
+	struct goldfish_sync_timeline *tl;
+
+	if (goldfish_sync_timeline_fence_signaled(fence))
+		return false;
+
+	pt = goldfish_sync_fence_to_sync_pt(fence);
+	tl = goldfish_dma_fence_parent(fence);
+	list_add_tail(&pt->active_list, &tl->active_list_head);
+	return true;
+}
+
+static void goldfish_sync_timeline_fence_value_str(struct dma_fence *fence,
+						   char *str, int size)
+{
+	snprintf(str, size, "%d", fence->seqno);
+}
+
+static void goldfish_sync_timeline_fence_timeline_value_str(
+				struct dma_fence *fence,
+				char *str, int size)
+{
+	struct goldfish_sync_timeline *tl = goldfish_dma_fence_parent(fence);
+
+	snprintf(str, size, "%d", tl->seqno);
+}
+
+static const struct dma_fence_ops goldfish_sync_timeline_fence_ops = {
+	.get_driver_name = goldfish_sync_timeline_fence_get_driver_name,
+	.get_timeline_name = goldfish_sync_timeline_fence_get_timeline_name,
+	.enable_signaling = goldfish_sync_timeline_fence_enable_signaling,
+	.signaled = goldfish_sync_timeline_fence_signaled,
+	.wait = dma_fence_default_wait,
+	.release = goldfish_sync_timeline_fence_release,
+	.fence_value_str = goldfish_sync_timeline_fence_value_str,
+	.timeline_value_str = goldfish_sync_timeline_fence_timeline_value_str,
+};
+
+static int __must_check
+goldfish_sync_fence_create(struct goldfish_sync_timeline *tl, u32 val)
+{
+	struct sync_pt *pt;
+	struct sync_file *sync_file_obj = NULL;
+	int fd;
+
+	pt = goldfish_sync_pt_create(tl, val);
+	if (!pt)
+		return -1;
+
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0)
+		goto err_cleanup_pt;
+
+	sync_file_obj = sync_file_create(&pt->base);
+	if (!sync_file_obj)
+		goto err_cleanup_fd_pt;
+
+	fd_install(fd, sync_file_obj->file);
+
+	dma_fence_put(&pt->base);	/* sync_file_obj now owns the fence */
+	return fd;
+
+err_cleanup_fd_pt:
+	put_unused_fd(fd);
+err_cleanup_pt:
+	goldfish_sync_pt_destroy(pt);
+
+	return -1;
+}
+
+static inline void
+goldfish_sync_cmd_queue(struct goldfish_sync_state *sync_state,
+			u32 cmd,
+			u64 handle,
+			u32 time_arg,
+			u64 hostcmd_handle)
+{
+	struct goldfish_sync_hostcmd *to_add =
+		&sync_state->to_do[sync_state->to_do_end];
+
+	to_add->cmd = cmd;
+	to_add->handle = handle;
+	to_add->time_arg = time_arg;
+	to_add->hostcmd_handle = hostcmd_handle;
+
+	++sync_state->to_do_end;
+}
+
+static inline void
+goldfish_sync_hostcmd_reply(struct goldfish_sync_state *sync_state,
+			    u32 cmd,
+			    u64 handle,
+			    u32 time_arg,
+			    u64 hostcmd_handle)
+{
+	unsigned long irq_flags;
+	struct goldfish_sync_hostcmd *batch_hostcmd =
+		&sync_state->batch_hostcmd;
+
+	spin_lock_irqsave(&sync_state->to_do_lock, irq_flags);
+
+	batch_hostcmd->cmd = cmd;
+	batch_hostcmd->handle = handle;
+	batch_hostcmd->time_arg = time_arg;
+	batch_hostcmd->hostcmd_handle = hostcmd_handle;
+	writel(0, sync_state->reg_base + SYNC_REG_BATCH_COMMAND);
+
+	spin_unlock_irqrestore(&sync_state->to_do_lock, irq_flags);
+}
+
+static inline void
+goldfish_sync_send_guestcmd(struct goldfish_sync_state *sync_state,
+			    u32 cmd,
+			    u64 glsync_handle,
+			    u64 thread_handle,
+			    u64 timeline_handle)
+{
+	unsigned long irq_flags;
+	struct goldfish_sync_guestcmd *batch_guestcmd =
+		&sync_state->batch_guestcmd;
+
+	spin_lock_irqsave(&sync_state->to_do_lock, irq_flags);
+
+	batch_guestcmd->host_command = cmd;
+	batch_guestcmd->glsync_handle = glsync_handle;
+	batch_guestcmd->thread_handle = thread_handle;
+	batch_guestcmd->guest_timeline_handle = timeline_handle;
+	writel(0, sync_state->reg_base + SYNC_REG_BATCH_GUESTCOMMAND);
+
+	spin_unlock_irqrestore(&sync_state->to_do_lock, irq_flags);
+}
+
+/* |goldfish_sync_interrupt| handles IRQ raises from the virtual device.
+ * In the context of OpenGL, this interrupt will fire whenever we need
+ * to signal a fence fd in the guest, with the command
+ * |CMD_SYNC_TIMELINE_INC|.
+ * However, because this function will be called in an interrupt context,
+ * it is necessary to do the actual work of signaling off of interrupt context.
+ * The shared work queue is used for this purpose. At the end when
+ * all pending commands are intercepted by the interrupt handler,
+ * we call |schedule_work|, which will later run the actual
+ * desired sync command in |goldfish_sync_work_item_fn|.
+ */
+static irqreturn_t
+goldfish_sync_interrupt_impl(struct goldfish_sync_state *sync_state)
+{
+	struct goldfish_sync_hostcmd *batch_hostcmd =
+			&sync_state->batch_hostcmd;
+
+	spin_lock(&sync_state->to_do_lock);
+	for (;;) {
+		u32 nextcmd;
+		u32 command_r;
+		u64 handle_rw;
+		u32 time_r;
+		u64 hostcmd_handle_rw;
+
+		readl(sync_state->reg_base + SYNC_REG_BATCH_COMMAND);
+		nextcmd = batch_hostcmd->cmd;
+
+		if (nextcmd == 0)
+			break;
+
+		command_r = nextcmd;
+		handle_rw = batch_hostcmd->handle;
+		time_r = batch_hostcmd->time_arg;
+		hostcmd_handle_rw = batch_hostcmd->hostcmd_handle;
+
+		goldfish_sync_cmd_queue(sync_state,
+					command_r,
+					handle_rw,
+					time_r,
+					hostcmd_handle_rw);
+	}
+	spin_unlock(&sync_state->to_do_lock);
+
+	schedule_work(&sync_state->work_item);
+	return IRQ_HANDLED;
+}
+
+static const struct file_operations goldfish_sync_fops;
+
+static irqreturn_t goldfish_sync_interrupt(int irq, void *dev_id)
+{
+	struct goldfish_sync_state *sync_state = dev_id;
+
+	return (sync_state->miscdev.fops == &goldfish_sync_fops) ?
+		goldfish_sync_interrupt_impl(sync_state) : IRQ_NONE;
+}
+
+/* We expect that commands will come in at a slow enough rate
+ * so that incoming items will not be more than
+ * GOLDFISH_SYNC_MAX_CMDS.
+ *
+ * This is because the way the sync device is used,
+ * it's only for managing buffer data transfers per frame,
+ * with a sequential dependency between putting things in
+ * to_do and taking them out. Once a set of commands is
+ * queued up in to_do, the user of the device waits for
+ * them to be processed before queuing additional commands,
+ * which limits the rate at which commands come in
+ * to the rate at which we take them out here.
+ *
+ * We also don't expect more than MAX_CMDS to be issued
+ * at once; there is a correspondence between
+ * which buffers need swapping to the (display / buffer queue)
+ * to particular commands, and we don't expect there to be
+ * enough display or buffer queues in operation at once
+ * to overrun GOLDFISH_SYNC_MAX_CMDS.
+ */
+static u32 __must_check
+goldfish_sync_grab_commands(struct goldfish_sync_state *sync_state,
+			    struct goldfish_sync_hostcmd *dst)
+{
+	u32 to_do_end;
+	u32 i;
+	unsigned long irq_flags;
+
+	spin_lock_irqsave(&sync_state->to_do_lock, irq_flags);
+
+	to_do_end = sync_state->to_do_end;
+	for (i = 0; i < to_do_end; i++)
+		dst[i] = sync_state->to_do[i];
+	sync_state->to_do_end = 0;
+
+	spin_unlock_irqrestore(&sync_state->to_do_lock, irq_flags);
+
+	return to_do_end;
+}
+
+void goldfish_sync_run_hostcmd(struct goldfish_sync_state *sync_state,
+			       struct goldfish_sync_hostcmd *todo)
+{
+	struct goldfish_sync_timeline *tl =
+		(struct goldfish_sync_timeline *)(uintptr_t)todo->handle;
+	int sync_fence_fd;
+
+	switch (todo->cmd) {
+	case CMD_SYNC_READY:
+		break;
+
+	case CMD_CREATE_SYNC_TIMELINE:
+		tl = goldfish_sync_timeline_create(sync_state);
+		goldfish_sync_hostcmd_reply(sync_state,
+					    CMD_CREATE_SYNC_TIMELINE,
+					    (uintptr_t)tl,
+					    0,
+					    todo->hostcmd_handle);
+		break;
+
+	case CMD_CREATE_SYNC_FENCE:
+		sync_fence_fd = goldfish_sync_fence_create(tl, todo->time_arg);
+		goldfish_sync_hostcmd_reply(sync_state,
+					    CMD_CREATE_SYNC_FENCE,
+					    sync_fence_fd,
+					    0,
+					    todo->hostcmd_handle);
+		break;
+
+	case CMD_SYNC_TIMELINE_INC:
+		goldfish_sync_timeline_signal(tl, todo->time_arg);
+		break;
+
+	case CMD_DESTROY_SYNC_TIMELINE:
+		goldfish_sync_timeline_put(tl);
+		break;
+	}
+}
+
+/* |goldfish_sync_work_item_fn| does the actual work of servicing
+ * host->guest sync commands. This function is triggered whenever
+ * the IRQ for the goldfish sync device is raised. Once it starts
+ * running, it grabs the contents of the buffer containing the
+ * commands it needs to execute (there may be multiple, because
+ * our IRQ is active high and not edge triggered), and then
+ * runs all of them one after the other.
+ */
+static void goldfish_sync_work_item_fn(struct work_struct *input)
+{
+	struct goldfish_sync_state *sync_state =
+		container_of(input, struct goldfish_sync_state, work_item);
+
+	struct goldfish_sync_hostcmd to_run[GOLDFISH_SYNC_MAX_CMDS];
+	u32 to_do_end;
+	u32 i;
+
+	mutex_lock(&sync_state->mutex_lock);
+
+	to_do_end = goldfish_sync_grab_commands(sync_state, to_run);
+
+	for (i = 0; i < to_do_end; i++)
+		goldfish_sync_run_hostcmd(sync_state, &to_run[i]);
+
+	mutex_unlock(&sync_state->mutex_lock);
+}
+
+static int goldfish_sync_open(struct inode *inode, struct file *filp)
+{
+	struct goldfish_sync_state *sync_state =
+		container_of(filp->private_data,
+			     struct goldfish_sync_state,
+			     miscdev);
+
+	if (mutex_lock_interruptible(&sync_state->mutex_lock))
+		return -ERESTARTSYS;
+
+	filp->private_data = goldfish_sync_timeline_create(sync_state);
+	mutex_unlock(&sync_state->mutex_lock);
+
+	return filp->private_data ? 0 : -ENOMEM;
+}
+
+static int goldfish_sync_release(struct inode *inode, struct file *filp)
+{
+	struct goldfish_sync_timeline *tl = filp->private_data;
+
+	goldfish_sync_timeline_put(tl);
+	return 0;
+}
+
+/* |goldfish_sync_ioctl| is the guest-facing interface of goldfish sync
+ * and is used in conjunction with eglCreateSyncKHR to queue up the
+ * actual work of waiting for the EGL sync command to complete,
+ * possibly returning a fence fd to the guest.
+ */
+static long
+goldfish_sync_ioctl_locked(struct goldfish_sync_timeline *tl,
+			   unsigned int cmd,
+			   unsigned long arg)
+{
+	struct goldfish_sync_ioctl_info ioctl_data;
+	int fd_out = -1;
+
+	switch (cmd) {
+	case GOLDFISH_SYNC_IOC_QUEUE_WORK:
+		if (copy_from_user(&ioctl_data,
+				   (void __user *)arg,
+				   sizeof(ioctl_data)))
+			return -EFAULT;
+
+		if (!ioctl_data.host_syncthread_handle_in)
+			return -EFAULT;
+
+		fd_out = goldfish_sync_fence_create(tl, tl->seqno + 1);
+		ioctl_data.fence_fd_out = fd_out;
+
+		if (copy_to_user((void __user *)arg,
+				 &ioctl_data,
+				 sizeof(ioctl_data))) {
+			ksys_close(fd_out);
+			return -EFAULT;
+		}
+
+		/* We are now about to trigger a host-side wait;
+		 * accumulate on |pending_waits|.
+		 */
+		goldfish_sync_send_guestcmd(tl->sync_state,
+				CMD_TRIGGER_HOST_WAIT,
+				ioctl_data.host_glsync_handle_in,
+				ioctl_data.host_syncthread_handle_in,
+				(u64)(uintptr_t)tl);
+		return 0;
+
+	default:
+		return -ENOTTY;
+	}
+}
+
+static long goldfish_sync_ioctl(struct file *filp,
+				unsigned int cmd,
+				unsigned long arg)
+{
+	struct goldfish_sync_timeline *tl = filp->private_data;
+	struct goldfish_sync_state *x = tl->sync_state;
+	long res;
+
+	if (mutex_lock_interruptible(&x->mutex_lock))
+		return -ERESTARTSYS;
+
+	res = goldfish_sync_ioctl_locked(tl, cmd, arg);
+	mutex_unlock(&x->mutex_lock);
+
+	return res;
+}
+
+static bool setup_verify_batch_cmd_addr(char *reg_base,
+					void *batch_addr,
+					u32 addr_offset,
+					u32 addr_offset_high)
+{
+	u64 batch_addr_phys;
+	u64 batch_addr_phys_test_lo;
+	u64 batch_addr_phys_test_hi;
+
+	batch_addr_phys = virt_to_phys(batch_addr);
+	writel(lower_32_bits(batch_addr_phys), reg_base + addr_offset);
+	writel(upper_32_bits(batch_addr_phys), reg_base + addr_offset_high);
+
+	batch_addr_phys_test_lo = readl(reg_base + addr_offset);
+	batch_addr_phys_test_hi = readl(reg_base + addr_offset_high);
+
+	batch_addr_phys = batch_addr_phys_test_lo |
+		(batch_addr_phys_test_hi << 32);
+
+	return virt_to_phys(batch_addr) == batch_addr_phys;
+}
+
+static const struct file_operations goldfish_sync_fops = {
+	.owner = THIS_MODULE,
+	.open = goldfish_sync_open,
+	.release = goldfish_sync_release,
+	.unlocked_ioctl = goldfish_sync_ioctl,
+	.compat_ioctl = goldfish_sync_ioctl,
+};
+
+static void fill_miscdevice(struct miscdevice *misc)
+{
+	misc->name = GOLDFISH_SYNC_DEVICE_NAME;
+	misc->minor = MISC_DYNAMIC_MINOR;
+	misc->fops = &goldfish_sync_fops;
+}
+
+static int goldfish_sync_probe(struct platform_device *pdev)
+{
+	struct goldfish_sync_state *sync_state;
+	struct resource *ioresource;
+	int result;
+
+	sync_state = devm_kzalloc(&pdev->dev, sizeof(*sync_state), GFP_KERNEL);
+	if (!sync_state)
+		return -ENOMEM;
+
+	spin_lock_init(&sync_state->to_do_lock);
+	mutex_init(&sync_state->mutex_lock);
+	INIT_WORK(&sync_state->work_item, goldfish_sync_work_item_fn);
+
+	ioresource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!ioresource)
+		return -ENODEV;
+
+	sync_state->reg_base =
+		devm_ioremap(&pdev->dev, ioresource->start, PAGE_SIZE);
+	if (!sync_state->reg_base)
+		return -ENOMEM;
+
+	result = platform_get_irq(pdev, 0);
+	if (result < 0)
+		return -ENODEV;
+
+	sync_state->irq = result;
+
+	result = devm_request_irq(&pdev->dev,
+				  sync_state->irq,
+				  goldfish_sync_interrupt,
+				  IRQF_SHARED,
+				  pdev->name,
+				  sync_state);
+	if (result)
+		return -ENODEV;
+
+	if (!setup_verify_batch_cmd_addr(sync_state->reg_base,
+				&sync_state->batch_hostcmd,
+				SYNC_REG_BATCH_COMMAND_ADDR,
+				SYNC_REG_BATCH_COMMAND_ADDR_HIGH))
+		return -ENODEV;
+
+	if (!setup_verify_batch_cmd_addr(sync_state->reg_base,
+				&sync_state->batch_guestcmd,
+				SYNC_REG_BATCH_GUESTCOMMAND_ADDR,
+				SYNC_REG_BATCH_GUESTCOMMAND_ADDR_HIGH))
+		return -ENODEV;
+
+	fill_miscdevice(&sync_state->miscdev);
+	result = misc_register(&sync_state->miscdev);
+	if (result)
+		return -ENODEV;
+
+	writel(0, sync_state->reg_base + SYNC_REG_INIT);
+
+	platform_set_drvdata(pdev, sync_state);
+
+	return 0;
+}
+
+static int goldfish_sync_remove(struct platform_device *pdev)
+{
+	struct goldfish_sync_state *sync_state = platform_get_drvdata(pdev);
+
+	misc_deregister(&sync_state->miscdev);
+	return 0;
+}
+
+static const struct of_device_id goldfish_sync_of_match[] = {
+	{ .compatible = "google,goldfish-sync", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, goldfish_sync_of_match);
+
+static const struct acpi_device_id goldfish_sync_acpi_match[] = {
+	{ "GFSH0006", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, goldfish_sync_acpi_match);
+
+static struct platform_driver goldfish_sync = {
+	.probe = goldfish_sync_probe,
+	.remove = goldfish_sync_remove,
+	.driver = {
+		.name = GOLDFISH_SYNC_DEVICE_NAME,
+		.of_match_table = goldfish_sync_of_match,
+		.acpi_match_table = ACPI_PTR(goldfish_sync_acpi_match),
+	}
+};
+module_platform_driver(goldfish_sync);
+
+MODULE_AUTHOR("Google, Inc.");
+MODULE_DESCRIPTION("Android QEMU Sync Driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("2.0");
diff --git a/include/uapi/linux/goldfish/goldfish_sync.h b/include/uapi/linux/goldfish/goldfish_sync.h
new file mode 100644
index 000000000000..01d762f77308
--- /dev/null
+++ b/include/uapi/linux/goldfish/goldfish_sync.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef UAPI_GOLDFISH_SYNC_H
+#define UAPI_GOLDFISH_SYNC_H
+
+#include <linux/types.h>
+
+#define GOLDFISH_SYNC_DEVICE_NAME "goldfish_sync"
+
+struct goldfish_sync_ioctl_info {
+	__u64 host_glsync_handle_in;
+	__u64 host_syncthread_handle_in;
+	__s32 fence_fd_out;
+};
+
+/* There is an ioctl associated with goldfish sync driver.
+ * Make it conflict with ioctls that are not likely to be used
+ * in the emulator.
+ *
+ * '@'	00-0F	linux/radeonfb.h		conflict!
+ * '@'	00-0F	drivers/video/aty/aty128fb.c	conflict!
+ */
+#define GOLDFISH_SYNC_IOC_MAGIC	'@'
+
+#define GOLDFISH_SYNC_IOC_QUEUE_WORK	\
+	_IOWR(GOLDFISH_SYNC_IOC_MAGIC, 0, struct goldfish_sync_ioctl_info)
+
+#endif /* UAPI_GOLDFISH_SYNC_H */
-- 
2.20.1.97.g81188d93c3-goog

