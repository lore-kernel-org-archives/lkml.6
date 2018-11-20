Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5691EC18E01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDD520989
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CDD520989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbeKUBYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:24:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:39284 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729294AbeKUBXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:23:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83F4CAE02;
        Tue, 20 Nov 2018 14:54:09 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, eric@anholt.net,
        dave.stevenson@raspberrypi.org
Cc:     linux-rpi-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 07/16] staging: vchiq-core: get rid of is_master distinction
Date:   Tue, 20 Nov 2018 15:53:42 +0100
Message-Id: <20181120145351.30390-8-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120145351.30390-1-nsaenzjulienne@suse.de>
References: <20181120145351.30390-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VCHIQ bulk transfers are what most people call DMA transfers. The CPU
sends a list of physical addresses to the VideoCore which then access
the memory directly without the need for CPU interaction.  With this
setup we call the CPU the "slave" and the VideoCore the "master".

There seems to be an option to switch roles in vchiq. Which nobody is
using nor is properly implemented. So we get rid of the "is_master == 1"
option, and all the related code.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchiq_arm/vchiq_2835_arm.c      |  12 +-
 .../interface/vchiq_arm/vchiq_core.c          | 300 +++---------------
 .../interface/vchiq_arm/vchiq_core.h          |  11 +-
 3 files changed, 38 insertions(+), 285 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index 014583cdf367..ecee54a31f8d 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -163,7 +163,7 @@ int vchiq_platform_init(struct platform_device *pdev, VCHIQ_STATE_T *state)
 	*(char **)&g_fragments_base[i * g_fragments_size] = NULL;
 	sema_init(&g_free_fragments_sema, MAX_FRAGMENTS);
 
-	if (vchiq_init_state(state, vchiq_slot_zero, 0) != VCHIQ_SUCCESS)
+	if (vchiq_init_state(state, vchiq_slot_zero) != VCHIQ_SUCCESS)
 		return -EINVAL;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -278,16 +278,6 @@ vchiq_complete_bulk(VCHIQ_BULK_T *bulk)
 			      bulk->actual);
 }
 
-void
-vchiq_transfer_bulk(VCHIQ_BULK_T *bulk)
-{
-	/*
-	 * This should only be called on the master (VideoCore) side, but
-	 * provide an implementation to avoid the need for ifdefery.
-	 */
-	BUG();
-}
-
 void
 vchiq_dump_platform_state(void *dump_context)
 {
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 8c7bda2e7cb6..34a892011296 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -85,8 +85,6 @@ int vchiq_core_log_level = VCHIQ_LOG_DEFAULT;
 int vchiq_core_msg_log_level = VCHIQ_LOG_DEFAULT;
 int vchiq_sync_log_level = VCHIQ_LOG_DEFAULT;
 
-static atomic_t pause_bulks_count = ATOMIC_INIT(0);
-
 static DEFINE_SPINLOCK(service_spinlock);
 DEFINE_SPINLOCK(bulk_waiter_spinlock);
 static DEFINE_SPINLOCK(quota_spinlock);
@@ -1222,32 +1220,7 @@ notify_bulks(VCHIQ_SERVICE_T *service, VCHIQ_BULK_QUEUE_T *queue,
 		(queue == &service->bulk_tx) ? 't' : 'r',
 		queue->process, queue->remote_notify, queue->remove);
 
-	if (service->state->is_master) {
-		while (queue->remote_notify != queue->process) {
-			VCHIQ_BULK_T *bulk =
-				&queue->bulks[BULK_INDEX(queue->remote_notify)];
-			int msgtype = (bulk->dir == VCHIQ_BULK_TRANSMIT) ?
-				VCHIQ_MSG_BULK_RX_DONE : VCHIQ_MSG_BULK_TX_DONE;
-			int msgid = VCHIQ_MAKE_MSG(msgtype, service->localport,
-				service->remoteport);
-			/* Only reply to non-dummy bulk requests */
-			if (bulk->remote_data) {
-				status = queue_message(
-						service->state,
-						NULL,
-						msgid,
-						memcpy_copy_callback,
-						&bulk->actual,
-						4,
-						0);
-				if (status != VCHIQ_SUCCESS)
-					break;
-			}
-			queue->remote_notify++;
-		}
-	} else {
-		queue->remote_notify = queue->process;
-	}
+	queue->remote_notify = queue->process;
 
 	if (status == VCHIQ_SUCCESS) {
 		while (queue->remove != queue->remote_notify) {
@@ -1385,63 +1358,6 @@ poll_services(VCHIQ_STATE_T *state)
 	}
 }
 
-/* Called by the slot handler or application threads, holding the bulk mutex. */
-static int
-resolve_bulks(VCHIQ_SERVICE_T *service, VCHIQ_BULK_QUEUE_T *queue)
-{
-	VCHIQ_STATE_T *state = service->state;
-	int resolved = 0;
-
-	while ((queue->process != queue->local_insert) &&
-		(queue->process != queue->remote_insert)) {
-		VCHIQ_BULK_T *bulk = &queue->bulks[BULK_INDEX(queue->process)];
-
-		vchiq_log_trace(vchiq_core_log_level,
-			"%d: rb:%d %cx - li=%x ri=%x p=%x",
-			state->id, service->localport,
-			(queue == &service->bulk_tx) ? 't' : 'r',
-			queue->local_insert, queue->remote_insert,
-			queue->process);
-
-		WARN_ON(!((int)(queue->local_insert - queue->process) > 0));
-		WARN_ON(!((int)(queue->remote_insert - queue->process) > 0));
-
-		if (mutex_lock_killable(&state->bulk_transfer_mutex))
-			break;
-
-		vchiq_transfer_bulk(bulk);
-		mutex_unlock(&state->bulk_transfer_mutex);
-
-		if (SRVTRACE_ENABLED(service, VCHIQ_LOG_INFO)) {
-			const char *header = (queue == &service->bulk_tx) ?
-				"Send Bulk to" : "Recv Bulk from";
-			if (bulk->actual != VCHIQ_BULK_ACTUAL_ABORTED)
-				vchiq_log_info(SRVTRACE_LEVEL(service),
-					"%s %c%c%c%c d:%d len:%d %pK<->%pK",
-					header,
-					VCHIQ_FOURCC_AS_4CHARS(
-						service->base.fourcc),
-					service->remoteport, bulk->size,
-					bulk->data, bulk->remote_data);
-			else
-				vchiq_log_info(SRVTRACE_LEVEL(service),
-					"%s %c%c%c%c d:%d ABORTED - tx len:%d,"
-					" rx len:%d %pK<->%pK",
-					header,
-					VCHIQ_FOURCC_AS_4CHARS(
-						service->base.fourcc),
-					service->remoteport,
-					bulk->size, bulk->remote_size,
-					bulk->data, bulk->remote_data);
-		}
-
-		vchiq_complete_bulk(bulk);
-		queue->process++;
-		resolved++;
-	}
-	return resolved;
-}
-
 /* Called with the bulk_mutex held */
 static void
 abort_outstanding_bulks(VCHIQ_SERVICE_T *service, VCHIQ_BULK_QUEUE_T *queue)
@@ -1492,65 +1408,6 @@ abort_outstanding_bulks(VCHIQ_SERVICE_T *service, VCHIQ_BULK_QUEUE_T *queue)
 	}
 }
 
-/* Called from the slot handler thread */
-static void
-pause_bulks(VCHIQ_STATE_T *state)
-{
-	if (unlikely(atomic_inc_return(&pause_bulks_count) != 1)) {
-		WARN_ON_ONCE(1);
-		atomic_set(&pause_bulks_count, 1);
-		return;
-	}
-
-	/* Block bulk transfers from all services */
-	mutex_lock(&state->bulk_transfer_mutex);
-}
-
-/* Called from the slot handler thread */
-static void
-resume_bulks(VCHIQ_STATE_T *state)
-{
-	int i;
-
-	if (unlikely(atomic_dec_return(&pause_bulks_count) != 0)) {
-		WARN_ON_ONCE(1);
-		atomic_set(&pause_bulks_count, 0);
-		return;
-	}
-
-	/* Allow bulk transfers from all services */
-	mutex_unlock(&state->bulk_transfer_mutex);
-
-	if (state->deferred_bulks == 0)
-		return;
-
-	/* Deal with any bulks which had to be deferred due to being in
-	 * paused state.  Don't try to match up to number of deferred bulks
-	 * in case we've had something come and close the service in the
-	 * interim - just process all bulk queues for all services */
-	vchiq_log_info(vchiq_core_log_level, "%s: processing %d deferred bulks",
-		__func__, state->deferred_bulks);
-
-	for (i = 0; i < state->unused_service; i++) {
-		VCHIQ_SERVICE_T *service = state->services[i];
-		int resolved_rx = 0;
-		int resolved_tx = 0;
-
-		if (!service || (service->srvstate != VCHIQ_SRVSTATE_OPEN))
-			continue;
-
-		mutex_lock(&service->bulk_mutex);
-		resolved_rx = resolve_bulks(service, &service->bulk_rx);
-		resolved_tx = resolve_bulks(service, &service->bulk_tx);
-		mutex_unlock(&service->bulk_mutex);
-		if (resolved_rx)
-			notify_bulks(service, &service->bulk_rx, 1);
-		if (resolved_tx)
-			notify_bulks(service, &service->bulk_tx, 1);
-	}
-	state->deferred_bulks = 0;
-}
-
 static int
 parse_open(VCHIQ_STATE_T *state, VCHIQ_HEADER_T *header)
 {
@@ -1871,73 +1728,16 @@ parse_rx_slots(VCHIQ_STATE_T *state)
 			up(&state->connect);
 			break;
 		case VCHIQ_MSG_BULK_RX:
-		case VCHIQ_MSG_BULK_TX: {
-			VCHIQ_BULK_QUEUE_T *queue;
-
-			WARN_ON(!state->is_master);
-			queue = (type == VCHIQ_MSG_BULK_RX) ?
-				&service->bulk_tx : &service->bulk_rx;
-			if ((service->remoteport == remoteport)
-				&& (service->srvstate ==
-				VCHIQ_SRVSTATE_OPEN)) {
-				VCHIQ_BULK_T *bulk;
-				int resolved = 0;
-
-				DEBUG_TRACE(PARSE_LINE);
-				if (mutex_lock_killable(
-					&service->bulk_mutex) != 0) {
-					DEBUG_TRACE(PARSE_LINE);
-					goto bail_not_ready;
-				}
-
-				WARN_ON(!(queue->remote_insert < queue->remove +
-					VCHIQ_NUM_SERVICE_BULKS));
-				bulk = &queue->bulks[
-					BULK_INDEX(queue->remote_insert)];
-				bulk->remote_data =
-					(void *)(long)((int *)header->data)[0];
-				bulk->remote_size = ((int *)header->data)[1];
-				wmb();
-
-				vchiq_log_info(vchiq_core_log_level,
-					"%d: prs %s@%pK (%d->%d) %x@%pK",
-					state->id, msg_type_str(type),
-					header, remoteport, localport,
-					bulk->remote_size, bulk->remote_data);
-
-				queue->remote_insert++;
-
-				if (atomic_read(&pause_bulks_count)) {
-					state->deferred_bulks++;
-					vchiq_log_info(vchiq_core_log_level,
-						"%s: deferring bulk (%d)",
-						__func__,
-						state->deferred_bulks);
-					if (state->conn_state !=
-						VCHIQ_CONNSTATE_PAUSE_SENT)
-						vchiq_log_error(
-							vchiq_core_log_level,
-							"%s: bulks paused in "
-							"unexpected state %s",
-							__func__,
-							conn_state_names[
-							state->conn_state]);
-				} else if (state->conn_state ==
-					VCHIQ_CONNSTATE_CONNECTED) {
-					DEBUG_TRACE(PARSE_LINE);
-					resolved = resolve_bulks(service,
-						queue);
-				}
-
-				mutex_unlock(&service->bulk_mutex);
-				if (resolved)
-					notify_bulks(service, queue,
-						1/*retry_poll*/);
-			}
-		} break;
+		case VCHIQ_MSG_BULK_TX:
+			/*
+			 * We should never receive a bulk request from the
+			 * other side since we're not setup to perform as the
+			 * master.
+			 */
+			WARN_ON(1);
+			break;
 		case VCHIQ_MSG_BULK_RX_DONE:
 		case VCHIQ_MSG_BULK_TX_DONE:
-			WARN_ON(state->is_master);
 			if ((service->remoteport == remoteport)
 				&& (service->srvstate !=
 				VCHIQ_SRVSTATE_FREE)) {
@@ -2026,8 +1826,6 @@ parse_rx_slots(VCHIQ_STATE_T *state)
 					NULL, NULL, 0, QMFLAGS_NO_MUTEX_UNLOCK)
 				    == VCHIQ_RETRY)
 					goto bail_not_ready;
-				if (state->is_master)
-					pause_bulks(state);
 			}
 			/* At this point slot_mutex is held */
 			vchiq_set_conn_state(state, VCHIQ_CONNSTATE_PAUSED);
@@ -2039,8 +1837,6 @@ parse_rx_slots(VCHIQ_STATE_T *state)
 				state->id, header, size);
 			/* Release the slot mutex */
 			mutex_unlock(&state->slot_mutex);
-			if (state->is_master)
-				resume_bulks(state);
 			vchiq_set_conn_state(state, VCHIQ_CONNSTATE_CONNECTED);
 			vchiq_platform_resumed(state);
 			break;
@@ -2119,8 +1915,6 @@ slot_handler_func(void *v)
 				break;
 
 			case VCHIQ_CONNSTATE_PAUSING:
-				if (state->is_master)
-					pause_bulks(state);
 				if (queue_message(state, NULL,
 					VCHIQ_MAKE_MSG(VCHIQ_MSG_PAUSE, 0, 0),
 					NULL, NULL, 0,
@@ -2129,8 +1923,6 @@ slot_handler_func(void *v)
 					vchiq_set_conn_state(state,
 						VCHIQ_CONNSTATE_PAUSE_SENT);
 				} else {
-					if (state->is_master)
-						resume_bulks(state);
 					/* Retry later */
 					state->poll_needed = 1;
 				}
@@ -2145,8 +1937,6 @@ slot_handler_func(void *v)
 					VCHIQ_MAKE_MSG(VCHIQ_MSG_RESUME, 0, 0),
 					NULL, NULL, 0, QMFLAGS_NO_MUTEX_LOCK)
 					!= VCHIQ_RETRY) {
-					if (state->is_master)
-						resume_bulks(state);
 					vchiq_set_conn_state(state,
 						VCHIQ_CONNSTATE_CONNECTED);
 					vchiq_platform_resumed(state);
@@ -2364,8 +2154,7 @@ vchiq_init_slots(void *mem_base, int mem_size)
 }
 
 VCHIQ_STATUS_T
-vchiq_init_state(VCHIQ_STATE_T *state, VCHIQ_SLOT_ZERO_T *slot_zero,
-		 int is_master)
+vchiq_init_state(VCHIQ_STATE_T *state, VCHIQ_SLOT_ZERO_T *slot_zero)
 {
 	VCHIQ_SHARED_STATE_T *local;
 	VCHIQ_SHARED_STATE_T *remote;
@@ -2374,8 +2163,7 @@ vchiq_init_state(VCHIQ_STATE_T *state, VCHIQ_SLOT_ZERO_T *slot_zero,
 	int i;
 
 	vchiq_log_warning(vchiq_core_log_level,
-		"%s: slot_zero = %pK, is_master = %d",
-		__func__, slot_zero, is_master);
+		"%s: slot_zero = %pK", __func__, slot_zero);
 
 	if (vchiq_states[0]) {
 		pr_err("%s: VCHIQ state already initialized\n", __func__);
@@ -2441,13 +2229,8 @@ vchiq_init_state(VCHIQ_STATE_T *state, VCHIQ_SLOT_ZERO_T *slot_zero,
 	if (VCHIQ_VERSION < slot_zero->version)
 		slot_zero->version = VCHIQ_VERSION;
 
-	if (is_master) {
-		local = &slot_zero->master;
-		remote = &slot_zero->slave;
-	} else {
-		local = &slot_zero->slave;
-		remote = &slot_zero->master;
-	}
+	local = &slot_zero->slave;
+	remote = &slot_zero->master;
 
 	if (local->initialised) {
 		vchiq_loud_error_header();
@@ -2455,16 +2238,13 @@ vchiq_init_state(VCHIQ_STATE_T *state, VCHIQ_SLOT_ZERO_T *slot_zero,
 			vchiq_loud_error("local state has already been "
 				"initialised");
 		else
-			vchiq_loud_error("master/slave mismatch - two %ss",
-				is_master ? "master" : "slave");
+			vchiq_loud_error("master/slave mismatch two slaves");
 		vchiq_loud_error_footer();
 		return VCHIQ_ERROR;
 	}
 
 	memset(state, 0, sizeof(VCHIQ_STATE_T));
 
-	state->is_master = is_master;
-
 	/*
 		initialize shared state pointers
 	 */
@@ -2971,7 +2751,7 @@ vchiq_close_service_internal(VCHIQ_SERVICE_T *service, int close_recvd)
 		mutex_lock(&state->sync_mutex);
 		/* fall through */
 	case VCHIQ_SRVSTATE_OPEN:
-		if (state->is_master || close_recvd) {
+		if (close_recvd) {
 			if (!do_abort_bulks(service))
 				status = VCHIQ_RETRY;
 		}
@@ -3018,11 +2798,9 @@ vchiq_close_service_internal(VCHIQ_SERVICE_T *service, int close_recvd)
 			/* This happens when a process is killed mid-close */
 			break;
 
-		if (!state->is_master) {
-			if (!do_abort_bulks(service)) {
-				status = VCHIQ_RETRY;
-				break;
-			}
+		if (!do_abort_bulks(service)) {
+			status = VCHIQ_RETRY;
+			break;
 		}
 
 		if (status == VCHIQ_SUCCESS)
@@ -3327,6 +3105,7 @@ VCHIQ_STATUS_T vchiq_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle,
 	const int dir_msgtype = (dir == VCHIQ_BULK_TRANSMIT) ?
 		VCHIQ_MSG_BULK_TX : VCHIQ_MSG_BULK_RX;
 	VCHIQ_STATUS_T status = VCHIQ_ERROR;
+	int payload[2];
 
 	if (!service || service->srvstate != VCHIQ_SRVSTATE_OPEN ||
 	    !offset || vchiq_check_service(service) != VCHIQ_SUCCESS)
@@ -3406,32 +3185,25 @@ VCHIQ_STATUS_T vchiq_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle,
 	if (service->srvstate != VCHIQ_SRVSTATE_OPEN)
 		goto unlock_both_error_exit;
 
-	if (state->is_master) {
-		queue->local_insert++;
-		if (resolve_bulks(service, queue))
-			request_poll(state, service,
-				(dir == VCHIQ_BULK_TRANSMIT) ?
-				VCHIQ_POLL_TXNOTIFY : VCHIQ_POLL_RXNOTIFY);
-	} else {
-		int payload[2] = { (int)(long)bulk->data, bulk->size };
-
-		status = queue_message(state,
-				       NULL,
-				       VCHIQ_MAKE_MSG(dir_msgtype,
-						      service->localport,
-						      service->remoteport),
-				       memcpy_copy_callback,
-				       &payload,
-				       sizeof(payload),
-				       QMFLAGS_IS_BLOCKING |
-				       QMFLAGS_NO_MUTEX_LOCK |
-				       QMFLAGS_NO_MUTEX_UNLOCK);
-		if (status != VCHIQ_SUCCESS) {
-			goto unlock_both_error_exit;
-		}
-		queue->local_insert++;
+	payload[0] = (int)(long)bulk->data;
+	payload[1] = bulk->size;
+	status = queue_message(state,
+			       NULL,
+			       VCHIQ_MAKE_MSG(dir_msgtype,
+					      service->localport,
+					      service->remoteport),
+			       memcpy_copy_callback,
+			       &payload,
+			       sizeof(payload),
+			       QMFLAGS_IS_BLOCKING |
+			       QMFLAGS_NO_MUTEX_LOCK |
+			       QMFLAGS_NO_MUTEX_UNLOCK);
+	if (status != VCHIQ_SUCCESS) {
+		goto unlock_both_error_exit;
 	}
 
+	queue->local_insert++;
+
 	mutex_unlock(&state->slot_mutex);
 	mutex_unlock(&service->bulk_mutex);
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index daada568f400..5b1696422e21 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -400,7 +400,6 @@ struct vchiq_state_struct {
 	int id;
 	int initialised;
 	VCHIQ_CONNSTATE_T conn_state;
-	int is_master;
 	short version_common;
 
 	VCHIQ_SHARED_STATE_T *local;
@@ -489,10 +488,6 @@ struct vchiq_state_struct {
 	/* Signalled when a free data slot becomes available. */
 	struct semaphore data_quota_event;
 
-	/* Incremented when there are bulk transfers which cannot be processed
-	 * whilst paused and must be processed on resume */
-	int deferred_bulks;
-
 	struct state_stats_struct {
 		int slot_stalls;
 		int data_stalls;
@@ -529,8 +524,7 @@ extern VCHIQ_SLOT_ZERO_T *
 vchiq_init_slots(void *mem_base, int mem_size);
 
 extern VCHIQ_STATUS_T
-vchiq_init_state(VCHIQ_STATE_T *state, VCHIQ_SLOT_ZERO_T *slot_zero,
-	int is_master);
+vchiq_init_state(VCHIQ_STATE_T *state, VCHIQ_SLOT_ZERO_T *slot_zero);
 
 extern VCHIQ_STATUS_T
 vchiq_connect_internal(VCHIQ_STATE_T *state, VCHIQ_INSTANCE_T instance);
@@ -625,9 +619,6 @@ unlock_service(VCHIQ_SERVICE_T *service);
 extern VCHIQ_STATUS_T
 vchiq_prepare_bulk_data(VCHIQ_BULK_T *bulk, void *offset, int size, int dir);
 
-extern void
-vchiq_transfer_bulk(VCHIQ_BULK_T *bulk);
-
 extern void
 vchiq_complete_bulk(VCHIQ_BULK_T *bulk);
 
-- 
2.19.1

