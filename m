Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CC7C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A1020870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A1020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbeKUBXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:23:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:39318 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727788AbeKUBXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:23:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7C6BDAF9F;
        Tue, 20 Nov 2018 14:54:10 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, eric@anholt.net,
        dave.stevenson@raspberrypi.org
Cc:     linux-rpi-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 09/16] staging: vchiq_core: do not initialize semaphores twice
Date:   Tue, 20 Nov 2018 15:53:44 +0100
Message-Id: <20181120145351.30390-10-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120145351.30390-1-nsaenzjulienne@suse.de>
References: <20181120145351.30390-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vchiq_init_state() initialises a series of semaphores to then call
remote_event_create() on the same semaphores, which initializes them
again. We get rid of the second initialization.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../vc04_services/interface/vchiq_arm/vchiq_core.c    | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index dee5ea7bfe4f..8b23ea5322e8 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -418,12 +418,11 @@ vchiq_set_conn_state(VCHIQ_STATE_T *state, VCHIQ_CONNSTATE_T newstate)
 }
 
 static inline void
-remote_event_create(VCHIQ_STATE_T *state, REMOTE_EVENT_T *event)
+remote_event_create(REMOTE_EVENT_T *event)
 {
 	event->armed = 0;
 	/* Don't clear the 'fired' flag because it may already have been set
 	** by the other side. */
-	sema_init((struct semaphore *)((char *)state + event->event), 0);
 }
 
 static inline int
@@ -2237,18 +2236,18 @@ vchiq_init_state(VCHIQ_STATE_T *state, VCHIQ_SLOT_ZERO_T *slot_zero)
 	state->data_quota = state->slot_queue_available - 1;
 
 	local->trigger.event = offsetof(VCHIQ_STATE_T, trigger_event);
-	remote_event_create(state, &local->trigger);
+	remote_event_create(&local->trigger);
 	local->tx_pos = 0;
 
 	local->recycle.event = offsetof(VCHIQ_STATE_T, recycle_event);
-	remote_event_create(state, &local->recycle);
+	remote_event_create(&local->recycle);
 	local->slot_queue_recycle = state->slot_queue_available;
 
 	local->sync_trigger.event = offsetof(VCHIQ_STATE_T, sync_trigger_event);
-	remote_event_create(state, &local->sync_trigger);
+	remote_event_create(&local->sync_trigger);
 
 	local->sync_release.event = offsetof(VCHIQ_STATE_T, sync_release_event);
-	remote_event_create(state, &local->sync_release);
+	remote_event_create(&local->sync_release);
 
 	/* At start-of-day, the slot is empty and available */
 	((VCHIQ_HEADER_T *)SLOT_DATA_FROM_INDEX(state, local->slot_sync))->msgid
-- 
2.19.1

