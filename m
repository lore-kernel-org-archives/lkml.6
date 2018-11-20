Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADD1C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FAE206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2FAE206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbeKUBXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:23:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:39284 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730000AbeKUBXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:23:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 16798B0CD;
        Tue, 20 Nov 2018 14:54:14 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, eric@anholt.net,
        dave.stevenson@raspberrypi.org
Cc:     linux-rpi-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 15/16] staging: vchiq_arm: fix open/release cdev functions
Date:   Tue, 20 Nov 2018 15:53:50 +0100
Message-Id: <20181120145351.30390-16-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120145351.30390-1-nsaenzjulienne@suse.de>
References: <20181120145351.30390-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both functions checked the minor number of the cdev prior running the
code. This was useless since the number of devices is already limited by
alloc_chrdev_region.

This removes the check and reindents the code where relevant.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 247 +++++++-----------
 1 file changed, 100 insertions(+), 147 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 03cc6947c03c..0caee2d6946f 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -63,8 +63,6 @@
 #undef MODULE_PARAM_PREFIX
 #define MODULE_PARAM_PREFIX DEVICE_NAME "."
 
-#define VCHIQ_MINOR 0
-
 /* Some per-instance constants */
 #define MAX_COMPLETIONS 128
 #define MAX_SERVICES 64
@@ -1955,195 +1953,150 @@ vchiq_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 #endif
 
-/****************************************************************************
-*
-*   vchiq_open
-*
-***************************************************************************/
-
-static int
-vchiq_open(struct inode *inode, struct file *file)
+static int vchiq_open(struct inode *inode, struct file *file)
 {
-	int dev = iminor(inode) & 0x0f;
+	VCHIQ_STATE_T *state = vchiq_get_state();
+	VCHIQ_INSTANCE_T instance;
 
 	vchiq_log_info(vchiq_arm_log_level, "vchiq_open");
-	switch (dev) {
-	case VCHIQ_MINOR: {
-		VCHIQ_STATE_T *state = vchiq_get_state();
-		VCHIQ_INSTANCE_T instance;
 
-		if (!state) {
-			vchiq_log_error(vchiq_arm_log_level,
+	if (!state) {
+		vchiq_log_error(vchiq_arm_log_level,
 				"vchiq has no connection to VideoCore");
-			return -ENOTCONN;
-		}
-
-		instance = kzalloc(sizeof(*instance), GFP_KERNEL);
-		if (!instance)
-			return -ENOMEM;
+		return -ENOTCONN;
+	}
 
-		instance->state = state;
-		instance->pid = current->tgid;
+	instance = kzalloc(sizeof(*instance), GFP_KERNEL);
+	if (!instance)
+		return -ENOMEM;
 
-		vchiq_debugfs_add_instance(instance);
+	instance->state = state;
+	instance->pid = current->tgid;
 
-		init_completion(&instance->insert_event);
-		init_completion(&instance->remove_event);
-		mutex_init(&instance->completion_mutex);
-		mutex_init(&instance->bulk_waiter_list_mutex);
-		INIT_LIST_HEAD(&instance->bulk_waiter_list);
+	vchiq_debugfs_add_instance(instance);
 
-		file->private_data = instance;
-	} break;
+	init_completion(&instance->insert_event);
+	init_completion(&instance->remove_event);
+	mutex_init(&instance->completion_mutex);
+	mutex_init(&instance->bulk_waiter_list_mutex);
+	INIT_LIST_HEAD(&instance->bulk_waiter_list);
 
-	default:
-		vchiq_log_error(vchiq_arm_log_level,
-			"Unknown minor device: %d", dev);
-		return -ENXIO;
-	}
+	file->private_data = instance;
 
 	return 0;
 }
 
-/****************************************************************************
-*
-*   vchiq_release
-*
-***************************************************************************/
-
-static int
-vchiq_release(struct inode *inode, struct file *file)
+static int vchiq_release(struct inode *inode, struct file *file)
 {
-	int dev = iminor(inode) & 0x0f;
+	VCHIQ_INSTANCE_T instance = file->private_data;
+	VCHIQ_STATE_T *state = vchiq_get_state();
+	VCHIQ_SERVICE_T *service;
 	int ret = 0;
+	int i;
 
-	switch (dev) {
-	case VCHIQ_MINOR: {
-		VCHIQ_INSTANCE_T instance = file->private_data;
-		VCHIQ_STATE_T *state = vchiq_get_state();
-		VCHIQ_SERVICE_T *service;
-		int i;
+	vchiq_log_info(vchiq_arm_log_level, "%s: instance=%lx", __func__,
+		       (unsigned long)instance);
 
-		vchiq_log_info(vchiq_arm_log_level,
-			"%s: instance=%lx",
-			__func__, (unsigned long)instance);
+	if (!state) {
+		ret = -EPERM;
+		goto out;
+	}
 
-		if (!state) {
-			ret = -EPERM;
-			goto out;
-		}
+	/* Ensure videocore is awake to allow termination. */
+	vchiq_use_internal(instance->state, NULL, USE_TYPE_VCHIQ);
 
-		/* Ensure videocore is awake to allow termination. */
-		vchiq_use_internal(instance->state, NULL,
-				USE_TYPE_VCHIQ);
+	mutex_lock(&instance->completion_mutex);
 
-		mutex_lock(&instance->completion_mutex);
+	/* Wake the completion thread and ask it to exit */
+	instance->closing = 1;
+	complete(&instance->insert_event);
 
-		/* Wake the completion thread and ask it to exit */
-		instance->closing = 1;
-		complete(&instance->insert_event);
+	mutex_unlock(&instance->completion_mutex);
 
-		mutex_unlock(&instance->completion_mutex);
+	/* Wake the slot handler if the completion queue is full. */
+	complete(&instance->remove_event);
 
-		/* Wake the slot handler if the completion queue is full. */
-		complete(&instance->remove_event);
+	/* Mark all services for termination... */
+	i = 0;
+	while ((service = next_service_by_instance(state, instance, &i))) {
+		USER_SERVICE_T *user_service = service->base.userdata;
 
-		/* Mark all services for termination... */
-		i = 0;
-		while ((service = next_service_by_instance(state, instance,
-			&i)) !=	NULL) {
-			USER_SERVICE_T *user_service = service->base.userdata;
+		/* Wake the slot handler if the msg queue is full. */
+		complete(&user_service->remove_event);
 
-			/* Wake the slot handler if the msg queue is full. */
-			complete(&user_service->remove_event);
+		vchiq_terminate_service_internal(service);
+		unlock_service(service);
+	}
 
-			vchiq_terminate_service_internal(service);
-			unlock_service(service);
-		}
+	/* ...and wait for them to die */
+	i = 0;
+	while ((service = next_service_by_instance(state, instance, &i))) {
+		USER_SERVICE_T *user_service = service->base.userdata;
 
-		/* ...and wait for them to die */
-		i = 0;
-		while ((service = next_service_by_instance(state, instance, &i))
-			!= NULL) {
-			USER_SERVICE_T *user_service = service->base.userdata;
+		wait_for_completion(&service->remove_event);
+
+		BUG_ON(service->srvstate != VCHIQ_SRVSTATE_FREE);
 
-			wait_for_completion(&service->remove_event);
+		spin_lock(&msg_queue_spinlock);
+
+		while (user_service->msg_remove != user_service->msg_insert) {
+			VCHIQ_HEADER_T *header;
+			int m = user_service->msg_remove & (MSG_QUEUE_SIZE - 1);
 
-			BUG_ON(service->srvstate != VCHIQ_SRVSTATE_FREE);
+			header = user_service->msg_queue[m];
+			user_service->msg_remove++;
+			spin_unlock(&msg_queue_spinlock);
 
+			if (header)
+				vchiq_release_message(service->handle, header);
 			spin_lock(&msg_queue_spinlock);
+		}
 
-			while (user_service->msg_remove !=
-				user_service->msg_insert) {
-				VCHIQ_HEADER_T *header;
-				int m = user_service->msg_remove &
-					(MSG_QUEUE_SIZE - 1);
+		spin_unlock(&msg_queue_spinlock);
 
-				header = user_service->msg_queue[m];
-				user_service->msg_remove++;
-				spin_unlock(&msg_queue_spinlock);
+		unlock_service(service);
+	}
 
-				if (header)
-					vchiq_release_message(
-						service->handle,
-						header);
-				spin_lock(&msg_queue_spinlock);
-			}
+	/* Release any closed services */
+	while (instance->completion_remove !=
+		instance->completion_insert) {
+		VCHIQ_COMPLETION_DATA_T *completion;
+		VCHIQ_SERVICE_T *service;
 
-			spin_unlock(&msg_queue_spinlock);
+		completion = &instance->completions[
+			instance->completion_remove & (MAX_COMPLETIONS - 1)];
+		service = completion->service_userdata;
+		if (completion->reason == VCHIQ_SERVICE_CLOSED) {
+			USER_SERVICE_T *user_service = service->base.userdata;
 
+			/* Wake any blocked user-thread */
+			if (instance->use_close_delivered)
+				complete(&user_service->close_event);
 			unlock_service(service);
 		}
+		instance->completion_remove++;
+	}
 
-		/* Release any closed services */
-		while (instance->completion_remove !=
-			instance->completion_insert) {
-			VCHIQ_COMPLETION_DATA_T *completion;
-			VCHIQ_SERVICE_T *service;
-
-			completion = &instance->completions[
-				instance->completion_remove &
-				(MAX_COMPLETIONS - 1)];
-			service = completion->service_userdata;
-			if (completion->reason == VCHIQ_SERVICE_CLOSED) {
-				USER_SERVICE_T *user_service =
-					service->base.userdata;
-
-				/* Wake any blocked user-thread */
-				if (instance->use_close_delivered)
-					complete(&user_service->close_event);
-				unlock_service(service);
-			}
-			instance->completion_remove++;
-		}
-
-		/* Release the PEER service count. */
-		vchiq_release_internal(instance->state, NULL);
+	/* Release the PEER service count. */
+	vchiq_release_internal(instance->state, NULL);
 
-		{
-			struct bulk_waiter_node *waiter, *next;
+	{
+		struct bulk_waiter_node *waiter, *next;
 
-			list_for_each_entry_safe(waiter, next,
-					&instance->bulk_waiter_list, list) {
-				list_del(&waiter->list);
-				vchiq_log_info(vchiq_arm_log_level,
-					"bulk_waiter - cleaned up %pK for pid %d",
-					waiter, waiter->pid);
-				kfree(waiter);
-			}
+		list_for_each_entry_safe(waiter, next,
+					 &instance->bulk_waiter_list, list) {
+			list_del(&waiter->list);
+			vchiq_log_info(vchiq_arm_log_level,
+				"bulk_waiter - cleaned up %pK for pid %d",
+				waiter, waiter->pid);
+			kfree(waiter);
 		}
+	}
 
-		vchiq_debugfs_remove_instance(instance);
+	vchiq_debugfs_remove_instance(instance);
 
-		kfree(instance);
-		file->private_data = NULL;
-	} break;
-
-	default:
-		vchiq_log_error(vchiq_arm_log_level,
-			"Unknown minor device: %d", dev);
-		ret = -ENXIO;
-	}
+	kfree(instance);
+	file->private_data = NULL;
 
 out:
 	return ret;
@@ -3618,7 +3571,7 @@ static int __init vchiq_driver_init(void)
 		return PTR_ERR(vchiq_class);
 	}
 
-	ret = alloc_chrdev_region(&vchiq_devid, VCHIQ_MINOR, 1, DEVICE_NAME);
+	ret = alloc_chrdev_region(&vchiq_devid, 0, 1, DEVICE_NAME);
 	if (ret) {
 		pr_err("Failed to allocate vchiq's chrdev region\n");
 		goto class_destroy;
-- 
2.19.1

