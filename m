Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C43C67839
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E000420672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E000420672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbeLJVNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:13:04 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:36305 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbeLJVNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:13:04 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M58OQ-1gVMOL3P2y-001AvP; Mon, 10 Dec 2018 22:12:33 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Tara Null <tn@fastmail.net>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vchiq: rework remove_event handling
Date:   Mon, 10 Dec 2018 22:11:58 +0100
Message-Id: <20181210211231.4084251-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Qy/+4ZfSLzA8az2nBv7MNP8W5PmCaWXwLTxQ5PX9KmzGRsVcWqN
 oN7V3HDjK3fUaJxUwYOgN3Ux6MydnpyxhadJ6rP6NN9YDT2EOqDk8DHEWxVdy4mWcev5qjq
 hI/Ij/38EVuYy9kpAOCjYGOApvZkxHg3hLGXWFShKIXJgz+pGGKdYmrr8G2Ilaze3nVygvZ
 QIKysNREwM8ccCrb/9KfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:796iQkfXSdo=:Z1NVAwbOeU7FM4ov35ifzY
 8cQc0CqrBbCfoBzhuSNmIfCXmTkkd9T0J+kvFRIojiGHddCv1ssF2rKbJkVCEbNubADdHGy6P
 VlKf4vFqUYNsbwSfY9Ya9edwkLDp4qZ6OzNsaCbULaU2UO/G29AE1LuGhdUuMMncXQy34QN/j
 iG/ZUVVo1Vq5j04bXRpjJq4TX8WUwMEthJt1wt2YLqhthy06Tgjh9PdzfIBo0gx8NazEmCwdf
 Rv/OUv5KhOthvhlFPRHSg+p4dOP/31ad4IcQfUJ+meBoP3CMYssT7rh1rXQwYDVeKB19l/MyL
 qLzV1uvnsiUor1nvJ3HnbY7Wm2Ysjv21/Qz07zNlWniQ5mJNZyomQexVfSQNMTpi8uwXtUEyu
 OZeSyK7dVQfSJjjsqgg0bIdCKLn9Fv9BSyaUTliJzX/wOT0nbfywFMWQYhPzfd4WFldtAZu9i
 3/33xgikZAYODGsjFai7dvDhH09cH6dqf+TKbCLsoB272LE+5lW4JgzaEgxcR9rdP/a0J6XnL
 S4ty2FH5QjT6nAF1utwRey7A81b0/reC+i/+IRBPlweAGmyPk1cCNC1lGdMKbh6ybFdTHIF5v
 uXS3rXERJWLtL3uB3OTBVPuP6QK7OTWj7nWqVnvuFh/SL9gX/MmP7S9H3zpMN1AIuqcRlbDLx
 E71KYaXpOIwcbx0+2JqrpXZtEkROgbBlOEOGqRskzl9cg6PClFRFvrIcNZJ/wfBNDj0hihksU
 VPzjL/P/i6ZmaoEhO1yr3qBLGdlKwA0OMbr3PQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I had started the removal of semaphores in this driver without knowing
that Nicolas Saenz Julienne also worked on this. In case of the "remote
event" infrastructure, my solution seemed significantly better, so I'm
proposing this as a change on top.

The problem with using either semaphores or completions here is that
it's an overly complex way of waking up a thread, and it looks like the
'count' of the semaphore can easily get out of sync, even though I found
it hard to come up with a specific example.

Changing it to a 'wait_queue_head_t' instead of a completion simplifies
this by letting us wait directly on the 'event->fired' variable that is
set by the videocore.

Another simplification is passing the wait queue directly into the helper
functions instead of going through the fragile logic of recording the
offset inside of a structure as part of a shared memory variable. This
also avoids one uncached memory read and should be faster.

Note that I'm changing it back to 'killable' after the previous patch
changed 'killable' to 'interruptible', apparently based on a misunderstanding
of the subtle down_interruptible() macro override in vchiq_killable.h.

Fixes: f27e47bc6b8b ("staging: vchiq: use completions instead of semaphores")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../interface/vchiq_arm/vchiq_core.c          | 63 +++++++------------
 .../interface/vchiq_arm/vchiq_core.h          | 12 ++--
 2 files changed, 30 insertions(+), 45 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 482b5daf6c0c..eda3004a0c6a 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -417,26 +417,23 @@ vchiq_set_conn_state(VCHIQ_STATE_T *state, VCHIQ_CONNSTATE_T newstate)
 }
 
 static inline void
-remote_event_create(REMOTE_EVENT_T *event)
+remote_event_create(wait_queue_head_t *wq, REMOTE_EVENT_T *event)
 {
 	event->armed = 0;
 	/* Don't clear the 'fired' flag because it may already have been set
 	** by the other side. */
+	init_waitqueue_head(wq);
 }
 
 static inline int
-remote_event_wait(VCHIQ_STATE_T *state, REMOTE_EVENT_T *event)
+remote_event_wait(wait_queue_head_t *wq, REMOTE_EVENT_T *event)
 {
 	if (!event->fired) {
 		event->armed = 1;
 		dsb(sy);
-		if (!event->fired) {
-			if (wait_for_completion_interruptible(
-					(struct completion *)
-					((char *)state + event->event))) {
-				event->armed = 0;
-				return 0;
-			}
+		if (wait_event_killable(*wq, event->fired)) {
+			event->armed = 0;
+			return 0;
 		}
 		event->armed = 0;
 		wmb();
@@ -447,26 +444,26 @@ remote_event_wait(VCHIQ_STATE_T *state, REMOTE_EVENT_T *event)
 }
 
 static inline void
-remote_event_signal_local(VCHIQ_STATE_T *state, REMOTE_EVENT_T *event)
+remote_event_signal_local(wait_queue_head_t *wq, REMOTE_EVENT_T *event)
 {
 	event->armed = 0;
-	complete((struct completion *)((char *)state + event->event));
+	wake_up_all(wq);
 }
 
 static inline void
-remote_event_poll(VCHIQ_STATE_T *state, REMOTE_EVENT_T *event)
+remote_event_poll(wait_queue_head_t *wq, REMOTE_EVENT_T *event)
 {
 	if (event->fired && event->armed)
-		remote_event_signal_local(state, event);
+		remote_event_signal_local(wq, event);
 }
 
 void
 remote_event_pollall(VCHIQ_STATE_T *state)
 {
-	remote_event_poll(state, &state->local->sync_trigger);
-	remote_event_poll(state, &state->local->sync_release);
-	remote_event_poll(state, &state->local->trigger);
-	remote_event_poll(state, &state->local->recycle);
+	remote_event_poll(&state->sync_trigger_event, &state->local->sync_trigger);
+	remote_event_poll(&state->sync_release_event, &state->local->sync_release);
+	remote_event_poll(&state->trigger_event, &state->local->trigger);
+	remote_event_poll(&state->recycle_event, &state->local->recycle);
 }
 
 /* Round up message sizes so that any space at the end of a slot is always big
@@ -550,7 +547,7 @@ request_poll(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service, int poll_type)
 	wmb();
 
 	/* ... and ensure the slot handler runs. */
-	remote_event_signal_local(state, &state->local->trigger);
+	remote_event_signal_local(&state->trigger_event, &state->local->trigger);
 }
 
 /* Called from queue_message, by the slot handler and application threads,
@@ -1069,7 +1066,7 @@ queue_message_sync(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service,
 		(mutex_lock_killable(&state->sync_mutex) != 0))
 		return VCHIQ_RETRY;
 
-	remote_event_wait(state, &local->sync_release);
+	remote_event_wait(&state->sync_release_event, &local->sync_release);
 
 	rmb();
 
@@ -1887,7 +1884,7 @@ slot_handler_func(void *v)
 	while (1) {
 		DEBUG_COUNT(SLOT_HANDLER_COUNT);
 		DEBUG_TRACE(SLOT_HANDLER_LINE);
-		remote_event_wait(state, &local->trigger);
+		remote_event_wait(&state->trigger_event, &local->trigger);
 
 		rmb();
 
@@ -1976,7 +1973,7 @@ recycle_func(void *v)
 		return -ENOMEM;
 
 	while (1) {
-		remote_event_wait(state, &local->recycle);
+		remote_event_wait(&state->recycle_event, &local->recycle);
 
 		process_free_queue(state, found, length);
 	}
@@ -1998,7 +1995,7 @@ sync_func(void *v)
 		int type;
 		unsigned int localport, remoteport;
 
-		remote_event_wait(state, &local->sync_trigger);
+		remote_event_wait(&state->sync_trigger_event, &local->sync_trigger);
 
 		rmb();
 
@@ -2193,11 +2190,6 @@ vchiq_init_state(VCHIQ_STATE_T *state, VCHIQ_SLOT_ZERO_T *slot_zero)
 
 	init_completion(&state->connect);
 	mutex_init(&state->mutex);
-	init_completion(&state->trigger_event);
-	init_completion(&state->recycle_event);
-	init_completion(&state->sync_trigger_event);
-	init_completion(&state->sync_release_event);
-
 	mutex_init(&state->slot_mutex);
 	mutex_init(&state->recycle_mutex);
 	mutex_init(&state->sync_mutex);
@@ -2229,24 +2221,17 @@ vchiq_init_state(VCHIQ_STATE_T *state, VCHIQ_SLOT_ZERO_T *slot_zero)
 	state->data_use_count = 0;
 	state->data_quota = state->slot_queue_available - 1;
 
-	local->trigger.event = offsetof(VCHIQ_STATE_T, trigger_event);
-	remote_event_create(&local->trigger);
+	remote_event_create(&state->trigger_event, &local->trigger);
 	local->tx_pos = 0;
-
-	local->recycle.event = offsetof(VCHIQ_STATE_T, recycle_event);
-	remote_event_create(&local->recycle);
+	remote_event_create(&state->recycle_event, &local->recycle);
 	local->slot_queue_recycle = state->slot_queue_available;
-
-	local->sync_trigger.event = offsetof(VCHIQ_STATE_T, sync_trigger_event);
-	remote_event_create(&local->sync_trigger);
-
-	local->sync_release.event = offsetof(VCHIQ_STATE_T, sync_release_event);
-	remote_event_create(&local->sync_release);
+	remote_event_create(&state->sync_trigger_event, &local->sync_trigger);
+	remote_event_create(&state->sync_release_event, &local->sync_release);
 
 	/* At start-of-day, the slot is empty and available */
 	((VCHIQ_HEADER_T *)SLOT_DATA_FROM_INDEX(state, local->slot_sync))->msgid
 		= VCHIQ_MSGID_PADDING;
-	remote_event_signal_local(state, &local->sync_release);
+	remote_event_signal_local(&state->sync_release_event, &local->sync_release);
 
 	local->debug[DEBUG_ENTRIES] = DEBUG_MAX;
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index b76281f7510e..aae2c59700bd 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -37,6 +37,7 @@
 #include <linux/mutex.h>
 #include <linux/completion.h>
 #include <linux/kthread.h>
+#include <linux/wait.h>
 
 #include "vchiq_cfg.h"
 
@@ -262,8 +263,7 @@ typedef struct vchiq_bulk_queue_struct {
 typedef struct remote_event_struct {
 	int armed;
 	int fired;
-	/* Contains offset from the beginning of the VCHIQ_STATE_T structure */
-	u32 event;
+	u32 __unused;
 } REMOTE_EVENT_T;
 
 typedef struct opaque_platform_state_t *VCHIQ_PLATFORM_STATE_T;
@@ -426,16 +426,16 @@ struct vchiq_state_struct {
 	struct task_struct *sync_thread;
 
 	/* Local implementation of the trigger remote event */
-	struct completion trigger_event;
+	wait_queue_head_t trigger_event;
 
 	/* Local implementation of the recycle remote event */
-	struct completion recycle_event;
+	wait_queue_head_t recycle_event;
 
 	/* Local implementation of the sync trigger remote event */
-	struct completion sync_trigger_event;
+	wait_queue_head_t sync_trigger_event;
 
 	/* Local implementation of the sync release remote event */
-	struct completion sync_release_event;
+	wait_queue_head_t sync_release_event;
 
 	char *tx_data;
 	char *rx_data;
-- 
2.20.0

