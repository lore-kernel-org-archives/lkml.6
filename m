Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C94ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22ED120868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22ED120868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeJZWZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 18:25:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:44790 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727431AbeJZWZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 18:25:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 11A1DB04D;
        Fri, 26 Oct 2018 13:48:37 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, eric@anholt.net,
        dave.stevenson@raspberrypi.org
Cc:     nsaenzjulienne@suse.de, linux-rpi-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 12/18] staging: vchiq_util: use completions instead of semaphores
Date:   Fri, 26 Oct 2018 15:48:07 +0200
Message-Id: <20181026134813.7775-13-nsaenzjulienne@suse.de>
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
 .../interface/vchiq_arm/vchiq_util.c             | 16 ++++++++--------
 .../interface/vchiq_arm/vchiq_util.h             |  6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
index 2e52f07bbaa9..44b954daa74a 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
@@ -48,8 +48,8 @@ int vchiu_queue_init(VCHIU_QUEUE_T *queue, int size)
 	queue->write = 0;
 	queue->initialized = 1;
 
-	sema_init(&queue->pop, 0);
-	sema_init(&queue->push, 0);
+	init_completion(&queue->pop);
+	init_completion(&queue->push);
 
 	queue->storage = kcalloc(size, sizeof(VCHIQ_HEADER_T *), GFP_KERNEL);
 	if (!queue->storage) {
@@ -80,7 +80,7 @@ void vchiu_queue_push(VCHIU_QUEUE_T *queue, VCHIQ_HEADER_T *header)
 		return;
 
 	while (queue->write == queue->read + queue->size) {
-		if (down_interruptible(&queue->pop) != 0)
+		if (wait_for_completion_interruptible(&queue->pop))
 			flush_signals(current);
 	}
 
@@ -100,17 +100,17 @@ void vchiu_queue_push(VCHIU_QUEUE_T *queue, VCHIQ_HEADER_T *header)
 
 	queue->write++;
 
-	up(&queue->push);
+	complete(&queue->push);
 }
 
 VCHIQ_HEADER_T *vchiu_queue_peek(VCHIU_QUEUE_T *queue)
 {
 	while (queue->write == queue->read) {
-		if (down_interruptible(&queue->push) != 0)
+		if (wait_for_completion_interruptible(&queue->push))
 			flush_signals(current);
 	}
 
-	up(&queue->push); // We haven't removed anything from the queue.
+	complete(&queue->push); // We haven't removed anything from the queue.
 
 	/*
 	 * Read from queue->storage must be visible after read from
@@ -126,7 +126,7 @@ VCHIQ_HEADER_T *vchiu_queue_pop(VCHIU_QUEUE_T *queue)
 	VCHIQ_HEADER_T *header;
 
 	while (queue->write == queue->read) {
-		if (down_interruptible(&queue->push) != 0)
+		if (wait_for_completion_interruptible(&queue->push))
 			flush_signals(current);
 	}
 
@@ -146,7 +146,7 @@ VCHIQ_HEADER_T *vchiu_queue_pop(VCHIU_QUEUE_T *queue)
 
 	queue->read++;
 
-	up(&queue->pop);
+	complete(&queue->pop);
 
 	return header;
 }
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.h
index 5a1540d349d3..b226227fe5bc 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.h
@@ -35,7 +35,7 @@
 #define VCHIQ_UTIL_H
 
 #include <linux/types.h>
-#include <linux/semaphore.h>
+#include <linux/completion.h>
 #include <linux/mutex.h>
 #include <linux/bitops.h>
 #include <linux/kthread.h>
@@ -60,8 +60,8 @@ typedef struct {
 	int write;
 	int initialized;
 
-	struct semaphore pop;
-	struct semaphore push;
+	struct completion pop;
+	struct completion push;
 
 	VCHIQ_HEADER_T **storage;
 } VCHIU_QUEUE_T;
-- 
2.19.1

