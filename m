Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5019C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FD3208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6FD3208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbeKUBXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:23:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:39262 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729945AbeKUBXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:23:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5CFB9AFF8;
        Tue, 20 Nov 2018 14:54:12 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, eric@anholt.net,
        dave.stevenson@raspberrypi.org
Cc:     linux-rpi-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 12/16] staging: vchiq_util: get rid of unneeded memory barriers
Date:   Tue, 20 Nov 2018 15:53:47 +0100
Message-Id: <20181120145351.30390-13-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120145351.30390-1-nsaenzjulienne@suse.de>
References: <20181120145351.30390-1-nsaenzjulienne@suse.de>
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

