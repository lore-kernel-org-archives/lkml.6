Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C888ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94AF20869
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94AF20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbeJZW0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 18:26:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:44840 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727591AbeJZWZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 18:25:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 46287B054;
        Fri, 26 Oct 2018 13:48:38 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, eric@anholt.net,
        dave.stevenson@raspberrypi.org
Cc:     nsaenzjulienne@suse.de, linux-rpi-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 14/18] staging: vchiq_util: get rid of unneeded memory barriers
Date:   Fri, 26 Oct 2018 15:48:09 +0200
Message-Id: <20181026134813.7775-15-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181026134813.7775-1-nsaenzjulienne@suse.de>
References: <20181026134813.7775-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the memory operations featured in this file modify/access memory
that is only accessed by the CPU. So we can assume that all the memory
barrier handling done by the completion routines is good enough for us.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchiq_arm/vchiq_util.c          | 32 -------------------
 1 file changed, 32 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
index 44b954daa74a..4b8554bc647e 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
@@ -84,20 +84,7 @@ void vchiu_queue_push(VCHIU_QUEUE_T *queue, VCHIQ_HEADER_T *header)
 			flush_signals(current);
 	}
 
-	/*
-	 * Write to queue->storage must be visible after read from
-	 * queue->read
-	 */
-	smp_mb();
-
 	queue->storage[queue->write & (queue->size - 1)] = header;
-
-	/*
-	 * Write to queue->storage must be visible before write to
-	 * queue->write
-	 */
-	smp_wmb();
-
 	queue->write++;
 
 	complete(&queue->push);
@@ -112,12 +99,6 @@ VCHIQ_HEADER_T *vchiu_queue_peek(VCHIU_QUEUE_T *queue)
 
 	complete(&queue->push); // We haven't removed anything from the queue.
 
-	/*
-	 * Read from queue->storage must be visible after read from
-	 * queue->write
-	 */
-	smp_rmb();
-
 	return queue->storage[queue->read & (queue->size - 1)];
 }
 
@@ -130,20 +111,7 @@ VCHIQ_HEADER_T *vchiu_queue_pop(VCHIU_QUEUE_T *queue)
 			flush_signals(current);
 	}
 
-	/*
-	 * Read from queue->storage must be visible after read from
-	 * queue->write
-	 */
-	smp_rmb();
-
 	header = queue->storage[queue->read & (queue->size - 1)];
-
-	/*
-	 * Read from queue->storage must be visible before write to
-	 * queue->read
-	 */
-	smp_mb();
-
 	queue->read++;
 
 	complete(&queue->pop);
-- 
2.19.1

