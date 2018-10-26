Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7202EC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC992086C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FC992086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeJZWZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 18:25:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:44886 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727520AbeJZWZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 18:25:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A4452B053;
        Fri, 26 Oct 2018 13:48:37 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, eric@anholt.net,
        dave.stevenson@raspberrypi.org
Cc:     nsaenzjulienne@suse.de, linux-rpi-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 13/18] staging: vchiq_core: use completions instead of semaphores
Date:   Fri, 26 Oct 2018 15:48:08 +0200
Message-Id: <20181026134813.7775-14-nsaenzjulienne@suse.de>
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
events as, they are optimised for the opposite situation; where the
common case is that they are available and may block only occasionally.
FYI see this thread: https://lkml.org/lkml/2008/4/11/323.

Also completions are semantically more explicit in this case.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchiq_arm/vchiq_arm.c           |  2 +-
 .../interface/vchiq_arm/vchiq_core.c          | 94 +++++++++----------
 .../interface/vchiq_arm/vchiq_core.h          | 26 ++---
 3 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 463d0eec2e96..383013a92939 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -2063,7 +2063,7 @@ vchiq_release(struct inode *inode, struct file *file)
 			!= NULL) {
 			USER_SERVICE_T *user_service = service->base.userdata;
 
-			down(&service->remove_event);
+			wait_for_completion(&service->remove_event);
 
 			BUG_ON(service->srvstate != VCHIQ_SRVSTATE_FREE);
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index e8b7ccabd9cb..0c37b7032857 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -376,7 +376,7 @@ mark_service_closing_internal(VCHIQ_SERVICE_T *service, int sh_thread)
 
 	/* Unblock any sending thread. */
 	service_quota = &state->service_quotas[service->localport];
-	up(&service_quota->quota_event);
+	complete(&service_quota->quota_event);
 }
 
 static void
@@ -423,7 +423,7 @@ remote_event_create(VCHIQ_STATE_T *state, REMOTE_EVENT_T *event)
 	event->armed = 0;
 	/* Don't clear the 'fired' flag because it may already have been set
 	** by the other side. */
-	sema_init((struct semaphore *)((char *)state + event->event), 0);
+	init_completion((struct completion *)((char *)state + event->event));
 }
 
 static inline int
@@ -433,9 +433,9 @@ remote_event_wait(VCHIQ_STATE_T *state, REMOTE_EVENT_T *event)
 		event->armed = 1;
 		dsb(sy);
 		if (!event->fired) {
-			if (down_interruptible(
-					(struct semaphore *)
-					((char *)state + event->event)) != 0) {
+			if (wait_for_completion_interruptible(
+					(struct completion *)
+					((char *)state + event->event))) {
 				event->armed = 0;
 				return 0;
 			}
@@ -452,7 +452,7 @@ static inline void
 remote_event_signal_local(VCHIQ_STATE_T *state, REMOTE_EVENT_T *event)
 {
 	event->armed = 0;
-	up((struct semaphore *)((char *)state + event->event));
+	complete((struct completion *)((char *)state + event->event));
 }
 
 static inline void
@@ -582,7 +582,7 @@ reserve_space(VCHIQ_STATE_T *state, size_t space, int is_blocking)
 
 		/* If there is no free slot... */
 
-		if (down_trylock(&state->slot_available_event) != 0) {
+		if (!try_wait_for_completion(&state->slot_available_event)) {
 			/* ...wait for one. */
 
 			VCHIQ_STATS_INC(state, slot_stalls);
@@ -593,13 +593,13 @@ reserve_space(VCHIQ_STATE_T *state, size_t space, int is_blocking)
 			remote_event_signal(&state->remote->trigger);
 
 			if (!is_blocking ||
-				(down_interruptible(
-				&state->slot_available_event) != 0))
+				(wait_for_completion_interruptible(
+				&state->slot_available_event)))
 				return NULL; /* No space available */
 		}
 
 		if (tx_pos == (state->slot_queue_available * VCHIQ_SLOT_SIZE)) {
-			up(&state->slot_available_event);
+			complete(&state->slot_available_event);
 			pr_warn("%s: invalid tx_pos: %d\n", __func__, tx_pos);
 			return NULL;
 		}
@@ -679,7 +679,7 @@ process_free_queue(VCHIQ_STATE_T *state, BITSET_T *service_found, size_t length)
 					/* Signal the service that it
 					** has dropped below its quota
 					*/
-					up(&service_quota->quota_event);
+					complete(&service_quota->quota_event);
 				else if (count == 0) {
 					vchiq_log_error(vchiq_core_log_level,
 						"service %d message_use_count=%d (header %pK, msgid %x, header->msgid %x, header->size %x)",
@@ -704,7 +704,7 @@ process_free_queue(VCHIQ_STATE_T *state, BITSET_T *service_found, size_t length)
 						/* Signal the service in case
 						** it has dropped below its
 						** quota */
-						up(&service_quota->quota_event);
+						complete(&service_quota->quota_event);
 						vchiq_log_trace(
 							vchiq_core_log_level,
 							"%d: pfq:%d %x@%pK - slot_use->%d",
@@ -745,7 +745,7 @@ process_free_queue(VCHIQ_STATE_T *state, BITSET_T *service_found, size_t length)
 					count - 1;
 			spin_unlock(&quota_spinlock);
 			if (count == state->data_quota)
-				up(&state->data_quota_event);
+				complete(&state->data_quota_event);
 		}
 
 		/*
@@ -755,7 +755,7 @@ process_free_queue(VCHIQ_STATE_T *state, BITSET_T *service_found, size_t length)
 		mb();
 
 		state->slot_queue_available = slot_queue_available;
-		up(&state->slot_available_event);
+		complete(&state->slot_available_event);
 	}
 }
 
@@ -863,8 +863,8 @@ queue_message(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service,
 			spin_unlock(&quota_spinlock);
 			mutex_unlock(&state->slot_mutex);
 
-			if (down_interruptible(&state->data_quota_event)
-				!= 0)
+			if (wait_for_completion_interruptible(
+						&state->data_quota_event))
 				return VCHIQ_RETRY;
 
 			mutex_lock(&state->slot_mutex);
@@ -874,7 +874,7 @@ queue_message(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service,
 			if ((tx_end_index == state->previous_data_index) ||
 				(state->data_use_count < state->data_quota)) {
 				/* Pass the signal on to other waiters */
-				up(&state->data_quota_event);
+				complete(&state->data_quota_event);
 				break;
 			}
 		}
@@ -894,8 +894,8 @@ queue_message(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service,
 				service_quota->slot_use_count);
 			VCHIQ_SERVICE_STATS_INC(service, quota_stalls);
 			mutex_unlock(&state->slot_mutex);
-			if (down_interruptible(&service_quota->quota_event)
-				!= 0)
+			if (wait_for_completion_interruptible(
+						&service_quota->quota_event))
 				return VCHIQ_RETRY;
 			if (service->closing)
 				return VCHIQ_ERROR;
@@ -1252,7 +1252,7 @@ notify_bulks(VCHIQ_SERVICE_T *service, VCHIQ_BULK_QUEUE_T *queue,
 					waiter = bulk->userdata;
 					if (waiter) {
 						waiter->actual = bulk->actual;
-						up(&waiter->event);
+						complete(&waiter->event);
 					}
 					spin_unlock(&bulk_waiter_spinlock);
 				} else if (bulk->mode ==
@@ -1275,7 +1275,7 @@ notify_bulks(VCHIQ_SERVICE_T *service, VCHIQ_BULK_QUEUE_T *queue,
 			}
 
 			queue->remove++;
-			up(&service->bulk_remove_event);
+			complete(&service->bulk_remove_event);
 		}
 		if (!retry_poll)
 			status = VCHIQ_SUCCESS;
@@ -1668,7 +1668,7 @@ parse_rx_slots(VCHIQ_STATE_T *state)
 				service->remoteport = remoteport;
 				vchiq_set_service_state(service,
 					VCHIQ_SRVSTATE_OPEN);
-				up(&service->remove_event);
+				complete(&service->remove_event);
 			} else
 				vchiq_log_error(vchiq_core_log_level,
 					"OPENACK received in state %s",
@@ -1722,7 +1722,7 @@ parse_rx_slots(VCHIQ_STATE_T *state)
 				"%d: prs CONNECT@%pK", state->id, header);
 			state->version_common = ((VCHIQ_SLOT_ZERO_T *)
 						 state->slot_data)->version;
-			up(&state->connect);
+			complete(&state->connect);
 			break;
 		case VCHIQ_MSG_BULK_RX:
 		case VCHIQ_MSG_BULK_TX:
@@ -2056,7 +2056,7 @@ sync_func(void *v)
 				vchiq_set_service_state(service,
 					VCHIQ_SRVSTATE_OPENSYNC);
 				service->sync = 1;
-				up(&service->remove_event);
+				complete(&service->remove_event);
 			}
 			release_message_sync(state, header);
 			break;
@@ -2195,28 +2195,28 @@ vchiq_init_state(VCHIQ_STATE_T *state, VCHIQ_SLOT_ZERO_T *slot_zero)
 		initialize events and mutexes
 	 */
 
-	sema_init(&state->connect, 0);
+	init_completion(&state->connect);
 	mutex_init(&state->mutex);
 	mutex_init(&state->slot_mutex);
 	mutex_init(&state->recycle_mutex);
 	mutex_init(&state->sync_mutex);
 	mutex_init(&state->bulk_transfer_mutex);
 
-	sema_init(&state->slot_available_event, 0);
-	sema_init(&state->slot_remove_event, 0);
-	sema_init(&state->data_quota_event, 0);
+	init_completion(&state->slot_available_event);
+	init_completion(&state->slot_remove_event);
+	init_completion(&state->data_quota_event);
 
 	state->slot_queue_available = 0;
 
 	for (i = 0; i < VCHIQ_MAX_SERVICES; i++) {
 		VCHIQ_SERVICE_QUOTA_T *service_quota =
 			&state->service_quotas[i];
-		sema_init(&service_quota->quota_event, 0);
+		init_completion(&service_quota->quota_event);
 	}
 
 	for (i = local->slot_first; i <= local->slot_last; i++) {
 		local->slot_queue[state->slot_queue_available++] = i;
-		up(&state->slot_available_event);
+		complete(&state->slot_available_event);
 	}
 
 	state->default_slot_quota = state->slot_queue_available/2;
@@ -2350,8 +2350,8 @@ vchiq_add_service_internal(VCHIQ_STATE_T *state,
 	service->service_use_count = 0;
 	init_bulk_queue(&service->bulk_tx);
 	init_bulk_queue(&service->bulk_rx);
-	sema_init(&service->remove_event, 0);
-	sema_init(&service->bulk_remove_event, 0);
+	init_completion(&service->remove_event);
+	init_completion(&service->bulk_remove_event);
 	mutex_init(&service->bulk_mutex);
 	memset(&service->stats, 0, sizeof(service->stats));
 
@@ -2466,7 +2466,7 @@ vchiq_open_service_internal(VCHIQ_SERVICE_T *service, int client_id)
 			       QMFLAGS_IS_BLOCKING);
 	if (status == VCHIQ_SUCCESS) {
 		/* Wait for the ACK/NAK */
-		if (down_interruptible(&service->remove_event) != 0) {
+		if (wait_for_completion_interruptible(&service->remove_event)) {
 			status = VCHIQ_RETRY;
 			vchiq_release_service_internal(service);
 		} else if ((service->srvstate != VCHIQ_SRVSTATE_OPEN) &&
@@ -2618,7 +2618,7 @@ close_service_complete(VCHIQ_SERVICE_T *service, int failstate)
 			if (is_server)
 				service->closing = 0;
 
-			up(&service->remove_event);
+			complete(&service->remove_event);
 		}
 	} else
 		vchiq_set_service_state(service, failstate);
@@ -2659,7 +2659,7 @@ vchiq_close_service_internal(VCHIQ_SERVICE_T *service, int close_recvd)
 					vchiq_set_service_state(service,
 						VCHIQ_SRVSTATE_LISTENING);
 			}
-			up(&service->remove_event);
+			complete(&service->remove_event);
 		} else
 			vchiq_free_service_internal(service);
 		break;
@@ -2668,7 +2668,7 @@ vchiq_close_service_internal(VCHIQ_SERVICE_T *service, int close_recvd)
 			/* The open was rejected - tell the user */
 			vchiq_set_service_state(service,
 				VCHIQ_SRVSTATE_CLOSEWAIT);
-			up(&service->remove_event);
+			complete(&service->remove_event);
 		} else {
 			/* Shutdown mid-open - let the other side know */
 			status = queue_message(state, service,
@@ -2801,7 +2801,7 @@ vchiq_free_service_internal(VCHIQ_SERVICE_T *service)
 
 	vchiq_set_service_state(service, VCHIQ_SRVSTATE_FREE);
 
-	up(&service->remove_event);
+	complete(&service->remove_event);
 
 	/* Release the initial lock */
 	unlock_service(service);
@@ -2833,11 +2833,11 @@ vchiq_connect_internal(VCHIQ_STATE_T *state, VCHIQ_INSTANCE_T instance)
 	}
 
 	if (state->conn_state == VCHIQ_CONNSTATE_CONNECTING) {
-		if (down_interruptible(&state->connect) != 0)
+		if (wait_for_completion_interruptible(&state->connect))
 			return VCHIQ_RETRY;
 
 		vchiq_set_conn_state(state, VCHIQ_CONNSTATE_CONNECTED);
-		up(&state->connect);
+		complete(&state->connect);
 	}
 
 	return VCHIQ_SUCCESS;
@@ -2932,7 +2932,7 @@ vchiq_close_service(VCHIQ_SERVICE_HANDLE_T handle)
 	}
 
 	while (1) {
-		if (down_interruptible(&service->remove_event) != 0) {
+		if (wait_for_completion_interruptible(&service->remove_event)) {
 			status = VCHIQ_RETRY;
 			break;
 		}
@@ -2993,7 +2993,7 @@ vchiq_remove_service(VCHIQ_SERVICE_HANDLE_T handle)
 		request_poll(service->state, service, VCHIQ_POLL_REMOVE);
 	}
 	while (1) {
-		if (down_interruptible(&service->remove_event) != 0) {
+		if (wait_for_completion_interruptible(&service->remove_event)) {
 			status = VCHIQ_RETRY;
 			break;
 		}
@@ -3050,7 +3050,7 @@ VCHIQ_STATUS_T vchiq_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle,
 		break;
 	case VCHIQ_BULK_MODE_BLOCKING:
 		bulk_waiter = (struct bulk_waiter *)userdata;
-		sema_init(&bulk_waiter->event, 0);
+		init_completion(&bulk_waiter->event);
 		bulk_waiter->actual = 0;
 		bulk_waiter->bulk = NULL;
 		break;
@@ -3076,8 +3076,8 @@ VCHIQ_STATUS_T vchiq_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle,
 		VCHIQ_SERVICE_STATS_INC(service, bulk_stalls);
 		do {
 			mutex_unlock(&service->bulk_mutex);
-			if (down_interruptible(&service->bulk_remove_event)
-				!= 0) {
+			if (wait_for_completion_interruptible(
+						&service->bulk_remove_event)) {
 				status = VCHIQ_RETRY;
 				goto error_exit;
 			}
@@ -3153,7 +3153,7 @@ VCHIQ_STATUS_T vchiq_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle,
 
 	if (bulk_waiter) {
 		bulk_waiter->bulk = bulk;
-		if (down_interruptible(&bulk_waiter->event) != 0)
+		if (wait_for_completion_interruptible(&bulk_waiter->event))
 			status = VCHIQ_RETRY;
 		else if (bulk_waiter->actual == VCHIQ_BULK_ACTUAL_ABORTED)
 			status = VCHIQ_ERROR;
@@ -3322,7 +3322,7 @@ vchiq_set_service_option(VCHIQ_SERVICE_HANDLE_T handle,
 					 service_quota->message_use_count)) {
 					/* Signal the service that it may have
 					** dropped below its quota */
-					up(&service_quota->quota_event);
+					complete(&service_quota->quota_event);
 				}
 				status = VCHIQ_SUCCESS;
 			}
@@ -3343,7 +3343,7 @@ vchiq_set_service_option(VCHIQ_SERVICE_HANDLE_T handle,
 					service_quota->slot_use_count))
 					/* Signal the service that it may have
 					** dropped below its quota */
-					up(&service_quota->quota_event);
+					complete(&service_quota->quota_event);
 				status = VCHIQ_SUCCESS;
 			}
 		} break;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 5b1696422e21..b76281f7510e 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -35,7 +35,7 @@
 #define VCHIQ_CORE_H
 
 #include <linux/mutex.h>
-#include <linux/semaphore.h>
+#include <linux/completion.h>
 #include <linux/kthread.h>
 
 #include "vchiq_cfg.h"
@@ -307,8 +307,8 @@ typedef struct vchiq_service_struct {
 	VCHIQ_BULK_QUEUE_T bulk_tx;
 	VCHIQ_BULK_QUEUE_T bulk_rx;
 
-	struct semaphore remove_event;
-	struct semaphore bulk_remove_event;
+	struct completion remove_event;
+	struct completion bulk_remove_event;
 	struct mutex bulk_mutex;
 
 	struct service_stats_struct {
@@ -337,7 +337,7 @@ typedef struct vchiq_service_quota_struct {
 	unsigned short slot_use_count;
 	unsigned short message_quota;
 	unsigned short message_use_count;
-	struct semaphore quota_event;
+	struct completion quota_event;
 	int previous_tx_index;
 } VCHIQ_SERVICE_QUOTA_T;
 
@@ -410,7 +410,7 @@ struct vchiq_state_struct {
 	unsigned short default_message_quota;
 
 	/* Event indicating connect message received */
-	struct semaphore connect;
+	struct completion connect;
 
 	/* Mutex protecting services */
 	struct mutex mutex;
@@ -426,16 +426,16 @@ struct vchiq_state_struct {
 	struct task_struct *sync_thread;
 
 	/* Local implementation of the trigger remote event */
-	struct semaphore trigger_event;
+	struct completion trigger_event;
 
 	/* Local implementation of the recycle remote event */
-	struct semaphore recycle_event;
+	struct completion recycle_event;
 
 	/* Local implementation of the sync trigger remote event */
-	struct semaphore sync_trigger_event;
+	struct completion sync_trigger_event;
 
 	/* Local implementation of the sync release remote event */
-	struct semaphore sync_release_event;
+	struct completion sync_release_event;
 
 	char *tx_data;
 	char *rx_data;
@@ -481,12 +481,12 @@ struct vchiq_state_struct {
 	int unused_service;
 
 	/* Signalled when a free slot becomes available. */
-	struct semaphore slot_available_event;
+	struct completion slot_available_event;
 
-	struct semaphore slot_remove_event;
+	struct completion slot_remove_event;
 
 	/* Signalled when a free data slot becomes available. */
-	struct semaphore data_quota_event;
+	struct completion data_quota_event;
 
 	struct state_stats_struct {
 		int slot_stalls;
@@ -505,7 +505,7 @@ struct vchiq_state_struct {
 
 struct bulk_waiter {
 	VCHIQ_BULK_T *bulk;
-	struct semaphore event;
+	struct completion event;
 	int actual;
 };
 
-- 
2.19.1

