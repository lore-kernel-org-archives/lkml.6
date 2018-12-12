Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D799AC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DBE20811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93DBE20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeLLSyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:54:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:46518 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726235AbeLLSy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:54:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 80BDEAF1A;
        Wed, 12 Dec 2018 18:54:26 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, stefan.wahren@i2se.com, eric@anholt.net,
        gregkh@linuxfoundation.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Subject: [PATCH 1/3] staging: vchiq: switch to wait_for_completion_killable
Date:   Wed, 12 Dec 2018 19:51:33 +0100
Message-Id: <20181212185136.6620-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181212185136.6620-1-nsaenzjulienne@suse.de>
References: <20181212185136.6620-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes f27e47bc6b8b ("staging: vchiq: use completions instead of
semaphores") as it neglected the subtle down_interruptible() macro
override in vchiq_killable.h. Hence all completions should be killable
instead of interruptible.

Fixes: f27e47bc6b8b ("staging: vchiq: use completions instead of semaphores")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 21 +++++++++----------
 .../interface/vchiq_arm/vchiq_core.c          | 21 +++++++++----------
 .../interface/vchiq_arm/vchiq_util.c          |  6 +++---
 3 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index f28f681192dd..227c208dd122 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -559,8 +559,7 @@ add_completion(VCHIQ_INSTANCE_T instance, VCHIQ_REASON_T reason,
 		vchiq_log_trace(vchiq_arm_log_level,
 			"%s - completion queue full", __func__);
 		DEBUG_COUNT(COMPLETION_QUEUE_FULL_COUNT);
-		if (wait_for_completion_interruptible(
-					&instance->remove_event)) {
+		if (wait_for_completion_killable( &instance->remove_event)) {
 			vchiq_log_info(vchiq_arm_log_level,
 				"service_callback interrupted");
 			return VCHIQ_RETRY;
@@ -671,7 +670,7 @@ service_callback(VCHIQ_REASON_T reason, VCHIQ_HEADER_T *header,
 			}
 
 			DEBUG_TRACE(SERVICE_CALLBACK_LINE);
-			if (wait_for_completion_interruptible(
+			if (wait_for_completion_killable(
 						&user_service->remove_event)
 				!= 0) {
 				vchiq_log_info(vchiq_arm_log_level,
@@ -1006,7 +1005,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		   has been closed until the client library calls the
 		   CLOSE_DELIVERED ioctl, signalling close_event. */
 		if (user_service->close_pending &&
-			wait_for_completion_interruptible(
+			wait_for_completion_killable(
 				&user_service->close_event))
 			status = VCHIQ_RETRY;
 		break;
@@ -1182,7 +1181,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 			DEBUG_TRACE(AWAIT_COMPLETION_LINE);
 			mutex_unlock(&instance->completion_mutex);
-			rc = wait_for_completion_interruptible(
+			rc = wait_for_completion_killable(
 						&instance->insert_event);
 			mutex_lock(&instance->completion_mutex);
 			if (rc != 0) {
@@ -1351,7 +1350,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			do {
 				spin_unlock(&msg_queue_spinlock);
 				DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
-				if (wait_for_completion_interruptible(
+				if (wait_for_completion_killable(
 					&user_service->insert_event)) {
 					vchiq_log_info(vchiq_arm_log_level,
 						"DEQUEUE_MESSAGE interrupted");
@@ -2356,7 +2355,7 @@ vchiq_keepalive_thread_func(void *v)
 	while (1) {
 		long rc = 0, uc = 0;
 
-		if (wait_for_completion_interruptible(&arm_state->ka_evt)
+		if (wait_for_completion_killable(&arm_state->ka_evt)
 				!= 0) {
 			vchiq_log_error(vchiq_susp_log_level,
 				"%s interrupted", __func__);
@@ -2606,7 +2605,7 @@ block_resume(VCHIQ_ARM_STATE_T *arm_state)
 		write_unlock_bh(&arm_state->susp_res_lock);
 		vchiq_log_info(vchiq_susp_log_level, "%s wait for previously "
 			"blocked clients", __func__);
-		if (wait_for_completion_interruptible_timeout(
+		if (wait_for_completion_killable_timeout(
 				&arm_state->blocked_blocker, timeout_val)
 					<= 0) {
 			vchiq_log_error(vchiq_susp_log_level, "%s wait for "
@@ -2632,7 +2631,7 @@ block_resume(VCHIQ_ARM_STATE_T *arm_state)
 		write_unlock_bh(&arm_state->susp_res_lock);
 		vchiq_log_info(vchiq_susp_log_level, "%s wait for resume",
 			__func__);
-		if (wait_for_completion_interruptible_timeout(
+		if (wait_for_completion_killable_timeout(
 				&arm_state->vc_resume_complete, timeout_val)
 					<= 0) {
 			vchiq_log_error(vchiq_susp_log_level, "%s wait for "
@@ -2839,7 +2838,7 @@ vchiq_arm_force_suspend(VCHIQ_STATE_T *state)
 	do {
 		write_unlock_bh(&arm_state->susp_res_lock);
 
-		rc = wait_for_completion_interruptible_timeout(
+		rc = wait_for_completion_killable_timeout(
 				&arm_state->vc_suspend_complete,
 				msecs_to_jiffies(FORCE_SUSPEND_TIMEOUT_MS));
 
@@ -2935,7 +2934,7 @@ vchiq_arm_allow_resume(VCHIQ_STATE_T *state)
 	write_unlock_bh(&arm_state->susp_res_lock);
 
 	if (resume) {
-		if (wait_for_completion_interruptible(
+		if (wait_for_completion_killable(
 			&arm_state->vc_resume_complete) < 0) {
 			vchiq_log_error(vchiq_susp_log_level,
 				"%s interrupted", __func__);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 5ee667d46eb5..afe2aa5ac3e9 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -592,7 +592,7 @@ reserve_space(VCHIQ_STATE_T *state, size_t space, int is_blocking)
 			remote_event_signal(&state->remote->trigger);
 
 			if (!is_blocking ||
-				(wait_for_completion_interruptible(
+				(wait_for_completion_killable(
 				&state->slot_available_event)))
 				return NULL; /* No space available */
 		}
@@ -862,7 +862,7 @@ queue_message(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service,
 			spin_unlock(&quota_spinlock);
 			mutex_unlock(&state->slot_mutex);
 
-			if (wait_for_completion_interruptible(
+			if (wait_for_completion_killable(
 						&state->data_quota_event))
 				return VCHIQ_RETRY;
 
@@ -893,7 +893,7 @@ queue_message(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service,
 				service_quota->slot_use_count);
 			VCHIQ_SERVICE_STATS_INC(service, quota_stalls);
 			mutex_unlock(&state->slot_mutex);
-			if (wait_for_completion_interruptible(
+			if (wait_for_completion_killable(
 						&service_quota->quota_event))
 				return VCHIQ_RETRY;
 			if (service->closing)
@@ -1742,8 +1742,7 @@ parse_rx_slots(VCHIQ_STATE_T *state)
 					&service->bulk_rx : &service->bulk_tx;
 
 				DEBUG_TRACE(PARSE_LINE);
-				if (mutex_lock_killable(
-					&service->bulk_mutex) != 0) {
+				if (mutex_lock_killable(&service->bulk_mutex)) {
 					DEBUG_TRACE(PARSE_LINE);
 					goto bail_not_ready;
 				}
@@ -2468,7 +2467,7 @@ vchiq_open_service_internal(VCHIQ_SERVICE_T *service, int client_id)
 			       QMFLAGS_IS_BLOCKING);
 	if (status == VCHIQ_SUCCESS) {
 		/* Wait for the ACK/NAK */
-		if (wait_for_completion_interruptible(&service->remove_event)) {
+		if (wait_for_completion_killable(&service->remove_event)) {
 			status = VCHIQ_RETRY;
 			vchiq_release_service_internal(service);
 		} else if ((service->srvstate != VCHIQ_SRVSTATE_OPEN) &&
@@ -2835,7 +2834,7 @@ vchiq_connect_internal(VCHIQ_STATE_T *state, VCHIQ_INSTANCE_T instance)
 	}
 
 	if (state->conn_state == VCHIQ_CONNSTATE_CONNECTING) {
-		if (wait_for_completion_interruptible(&state->connect))
+		if (wait_for_completion_killable(&state->connect))
 			return VCHIQ_RETRY;
 
 		vchiq_set_conn_state(state, VCHIQ_CONNSTATE_CONNECTED);
@@ -2934,7 +2933,7 @@ vchiq_close_service(VCHIQ_SERVICE_HANDLE_T handle)
 	}
 
 	while (1) {
-		if (wait_for_completion_interruptible(&service->remove_event)) {
+		if (wait_for_completion_killable(&service->remove_event)) {
 			status = VCHIQ_RETRY;
 			break;
 		}
@@ -2995,7 +2994,7 @@ vchiq_remove_service(VCHIQ_SERVICE_HANDLE_T handle)
 		request_poll(service->state, service, VCHIQ_POLL_REMOVE);
 	}
 	while (1) {
-		if (wait_for_completion_interruptible(&service->remove_event)) {
+		if (wait_for_completion_killable(&service->remove_event)) {
 			status = VCHIQ_RETRY;
 			break;
 		}
@@ -3078,7 +3077,7 @@ VCHIQ_STATUS_T vchiq_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle,
 		VCHIQ_SERVICE_STATS_INC(service, bulk_stalls);
 		do {
 			mutex_unlock(&service->bulk_mutex);
-			if (wait_for_completion_interruptible(
+			if (wait_for_completion_killable(
 						&service->bulk_remove_event)) {
 				status = VCHIQ_RETRY;
 				goto error_exit;
@@ -3155,7 +3154,7 @@ VCHIQ_STATUS_T vchiq_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle,
 
 	if (bulk_waiter) {
 		bulk_waiter->bulk = bulk;
-		if (wait_for_completion_interruptible(&bulk_waiter->event))
+		if (wait_for_completion_killable(&bulk_waiter->event))
 			status = VCHIQ_RETRY;
 		else if (bulk_waiter->actual == VCHIQ_BULK_ACTUAL_ABORTED)
 			status = VCHIQ_ERROR;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
index 4b8554bc647e..42e10d7d97a4 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
@@ -80,7 +80,7 @@ void vchiu_queue_push(VCHIU_QUEUE_T *queue, VCHIQ_HEADER_T *header)
 		return;
 
 	while (queue->write == queue->read + queue->size) {
-		if (wait_for_completion_interruptible(&queue->pop))
+		if (wait_for_completion_killable(&queue->pop))
 			flush_signals(current);
 	}
 
@@ -93,7 +93,7 @@ void vchiu_queue_push(VCHIU_QUEUE_T *queue, VCHIQ_HEADER_T *header)
 VCHIQ_HEADER_T *vchiu_queue_peek(VCHIU_QUEUE_T *queue)
 {
 	while (queue->write == queue->read) {
-		if (wait_for_completion_interruptible(&queue->push))
+		if (wait_for_completion_killable(&queue->push))
 			flush_signals(current);
 	}
 
@@ -107,7 +107,7 @@ VCHIQ_HEADER_T *vchiu_queue_pop(VCHIU_QUEUE_T *queue)
 	VCHIQ_HEADER_T *header;
 
 	while (queue->write == queue->read) {
-		if (wait_for_completion_interruptible(&queue->push))
+		if (wait_for_completion_killable(&queue->push))
 			flush_signals(current);
 	}
 
-- 
2.19.2

