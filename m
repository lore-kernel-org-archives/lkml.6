Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DECECDE47
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90BA620868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90BA620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbeJZWZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 18:25:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:44840 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727520AbeJZWZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 18:25:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 73EE8B052;
        Fri, 26 Oct 2018 13:48:36 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, eric@anholt.net,
        dave.stevenson@raspberrypi.org
Cc:     nsaenzjulienne@suse.de, linux-rpi-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 11/18] staging: vchiq_arm: use completions instead of semaphores
Date:   Fri, 26 Oct 2018 15:48:06 +0200
Message-Id: <20181026134813.7775-12-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181026134813.7775-1-nsaenzjulienne@suse.de>
References: <20181026134813.7775-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred in the kernel to avoid using semaphores to wait for
events, as they are optimised for the opposite situation; where the
common case is that they are available and may block only occasionally.
FYI see this thread: https://lkml.org/lkml/2008/4/11/323.

Also completions are semantically more explicit in this case.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 58 ++++++++++---------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 1cdfdb714abc..463d0eec2e96 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -44,7 +44,7 @@
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
 #include <linux/bug.h>
-#include <linux/semaphore.h>
+#include <linux/completion.h>
 #include <linux/list.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -121,9 +121,9 @@ typedef struct user_service_struct {
 	int message_available_pos;
 	int msg_insert;
 	int msg_remove;
-	struct semaphore insert_event;
-	struct semaphore remove_event;
-	struct semaphore close_event;
+	struct completion insert_event;
+	struct completion remove_event;
+	struct completion close_event;
 	VCHIQ_HEADER_T * msg_queue[MSG_QUEUE_SIZE];
 } USER_SERVICE_T;
 
@@ -138,8 +138,8 @@ struct vchiq_instance_struct {
 	VCHIQ_COMPLETION_DATA_T completions[MAX_COMPLETIONS];
 	int completion_insert;
 	int completion_remove;
-	struct semaphore insert_event;
-	struct semaphore remove_event;
+	struct completion insert_event;
+	struct completion remove_event;
 	struct mutex completion_mutex;
 
 	int connected;
@@ -562,7 +562,8 @@ add_completion(VCHIQ_INSTANCE_T instance, VCHIQ_REASON_T reason,
 		vchiq_log_trace(vchiq_arm_log_level,
 			"%s - completion queue full", __func__);
 		DEBUG_COUNT(COMPLETION_QUEUE_FULL_COUNT);
-		if (down_interruptible(&instance->remove_event) != 0) {
+		if (wait_for_completion_interruptible(
+					&instance->remove_event)) {
 			vchiq_log_info(vchiq_arm_log_level,
 				"service_callback interrupted");
 			return VCHIQ_RETRY;
@@ -600,7 +601,7 @@ add_completion(VCHIQ_INSTANCE_T instance, VCHIQ_REASON_T reason,
 	insert++;
 	instance->completion_insert = insert;
 
-	up(&instance->insert_event);
+	complete(&instance->insert_event);
 
 	return VCHIQ_SUCCESS;
 }
@@ -673,7 +674,8 @@ service_callback(VCHIQ_REASON_T reason, VCHIQ_HEADER_T *header,
 			}
 
 			DEBUG_TRACE(SERVICE_CALLBACK_LINE);
-			if (down_interruptible(&user_service->remove_event)
+			if (wait_for_completion_interruptible(
+						&user_service->remove_event)
 				!= 0) {
 				vchiq_log_info(vchiq_arm_log_level,
 					"%s interrupted", __func__);
@@ -705,7 +707,7 @@ service_callback(VCHIQ_REASON_T reason, VCHIQ_HEADER_T *header,
 		}
 
 		spin_unlock(&msg_queue_spinlock);
-		up(&user_service->insert_event);
+		complete(&user_service->insert_event);
 
 		header = NULL;
 	}
@@ -745,7 +747,7 @@ static void close_delivered(USER_SERVICE_T *user_service)
 		unlock_service(user_service->service);
 
 		/* Wake the user-thread blocked in close_ or remove_service */
-		up(&user_service->close_event);
+		complete(&user_service->close_event);
 
 		user_service->close_pending = 0;
 	}
@@ -867,7 +869,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if (status == VCHIQ_SUCCESS) {
 			/* Wake the completion thread and ask it to exit */
 			instance->closing = 1;
-			up(&instance->insert_event);
+			complete(&instance->insert_event);
 		}
 
 		break;
@@ -948,9 +950,9 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 				instance->completion_remove - 1;
 			user_service->msg_insert = 0;
 			user_service->msg_remove = 0;
-			sema_init(&user_service->insert_event, 0);
-			sema_init(&user_service->remove_event, 0);
-			sema_init(&user_service->close_event, 0);
+			init_completion(&user_service->insert_event);
+			init_completion(&user_service->remove_event);
+			init_completion(&user_service->close_event);
 
 			if (args.is_open) {
 				status = vchiq_open_service_internal
@@ -1007,7 +1009,8 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		   has been closed until the client library calls the
 		   CLOSE_DELIVERED ioctl, signalling close_event. */
 		if (user_service->close_pending &&
-			down_interruptible(&user_service->close_event))
+			wait_for_completion_interruptible(
+				&user_service->close_event))
 			status = VCHIQ_RETRY;
 		break;
 	}
@@ -1182,7 +1185,8 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 			DEBUG_TRACE(AWAIT_COMPLETION_LINE);
 			mutex_unlock(&instance->completion_mutex);
-			rc = down_interruptible(&instance->insert_event);
+			rc = wait_for_completion_interruptible(
+						&instance->insert_event);
 			mutex_lock(&instance->completion_mutex);
 			if (rc != 0) {
 				DEBUG_TRACE(AWAIT_COMPLETION_LINE);
@@ -1310,7 +1314,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		}
 
 		if (ret != 0)
-			up(&instance->remove_event);
+			complete(&instance->remove_event);
 		mutex_unlock(&instance->completion_mutex);
 		DEBUG_TRACE(AWAIT_COMPLETION_LINE);
 	} break;
@@ -1350,8 +1354,8 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			do {
 				spin_unlock(&msg_queue_spinlock);
 				DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
-				if (down_interruptible(
-					&user_service->insert_event) != 0) {
+				if (wait_for_completion_interruptible(
+					&user_service->insert_event)) {
 					vchiq_log_info(vchiq_arm_log_level,
 						"DEQUEUE_MESSAGE interrupted");
 					ret = -EINTR;
@@ -1373,7 +1377,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		user_service->msg_remove++;
 		spin_unlock(&msg_queue_spinlock);
 
-		up(&user_service->remove_event);
+		complete(&user_service->remove_event);
 		if (header == NULL)
 			ret = -ENOTCONN;
 		else if (header->size <= args.bufsize) {
@@ -1979,8 +1983,8 @@ vchiq_open(struct inode *inode, struct file *file)
 
 		vchiq_debugfs_add_instance(instance);
 
-		sema_init(&instance->insert_event, 0);
-		sema_init(&instance->remove_event, 0);
+		init_completion(&instance->insert_event);
+		init_completion(&instance->remove_event);
 		mutex_init(&instance->completion_mutex);
 		mutex_init(&instance->bulk_waiter_list_mutex);
 		INIT_LIST_HEAD(&instance->bulk_waiter_list);
@@ -2033,12 +2037,12 @@ vchiq_release(struct inode *inode, struct file *file)
 
 		/* Wake the completion thread and ask it to exit */
 		instance->closing = 1;
-		up(&instance->insert_event);
+		complete(&instance->insert_event);
 
 		mutex_unlock(&instance->completion_mutex);
 
 		/* Wake the slot handler if the completion queue is full. */
-		up(&instance->remove_event);
+		complete(&instance->remove_event);
 
 		/* Mark all services for termination... */
 		i = 0;
@@ -2047,7 +2051,7 @@ vchiq_release(struct inode *inode, struct file *file)
 			USER_SERVICE_T *user_service = service->base.userdata;
 
 			/* Wake the slot handler if the msg queue is full. */
-			up(&user_service->remove_event);
+			complete(&user_service->remove_event);
 
 			vchiq_terminate_service_internal(service);
 			unlock_service(service);
@@ -2103,7 +2107,7 @@ vchiq_release(struct inode *inode, struct file *file)
 
 				/* Wake any blocked user-thread */
 				if (instance->use_close_delivered)
-					up(&user_service->close_event);
+					complete(&user_service->close_event);
 				unlock_service(service);
 			}
 			instance->completion_remove++;
-- 
2.19.1

