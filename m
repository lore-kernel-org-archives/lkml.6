Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA35ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E362A208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E362A208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxera.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732262AbeGLWGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 18:06:16 -0400
Received: from mx2.mpynet.fi ([82.197.21.85]:29691 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbeGLWGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 18:06:15 -0400
From:   Tuomas Tynkkynen <tuomas@tuxera.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        <linux-rpi-kernel@lists.infradead.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        Tuomas Tynkkynen <tuomas@tuxera.com>
Subject: [PATCH 1/2] staging: bcm2835-audio: Check if workqueue allocation failed
Date:   Fri, 13 Jul 2018 00:54:16 +0300
Message-ID: <20180712215417.22491-1-tuomas@tuxera.com>
X-Mailer: git-send-email 2.16.3
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
Received-SPF: none
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if allocating a workqueue fails, the driver will probe
successfully but it will silently do nothing, which is rather silly.
So instead bail out with -ENOMEM in bcm2835_audio_open() if
alloc_workqueue() fails, and remove the now pointless checks for a NULL
workqueue.

While at it, get rid of the rather pointless one-line function
my_workqueue_init().

Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>
---
 .../vc04_services/bcm2835-audio/bcm2835-vchiq.c    | 111 ++++++++++-----------
 1 file changed, 50 insertions(+), 61 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index a4a48f31f1a3..85ed807bb873 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -118,44 +118,40 @@ static void my_wq_function(struct work_struct *work)
 
 int bcm2835_audio_start(struct bcm2835_alsa_stream *alsa_stream)
 {
-	if (alsa_stream->my_wq) {
-		struct bcm2835_audio_work *work;
-
-		work = kmalloc(sizeof(*work), GFP_ATOMIC);
-		/*--- Queue some work (item 1) ---*/
-		if (!work) {
-			LOG_ERR(" .. Error: NULL work kmalloc\n");
-			return -ENOMEM;
-		}
-		INIT_WORK(&work->my_work, my_wq_function);
-		work->alsa_stream = alsa_stream;
-		work->cmd = BCM2835_AUDIO_START;
-		if (!queue_work(alsa_stream->my_wq, &work->my_work)) {
-			kfree(work);
-			return -EBUSY;
-		}
+	struct bcm2835_audio_work *work;
+
+	work = kmalloc(sizeof(*work), GFP_ATOMIC);
+	/*--- Queue some work (item 1) ---*/
+	if (!work) {
+		LOG_ERR(" .. Error: NULL work kmalloc\n");
+		return -ENOMEM;
+	}
+	INIT_WORK(&work->my_work, my_wq_function);
+	work->alsa_stream = alsa_stream;
+	work->cmd = BCM2835_AUDIO_START;
+	if (!queue_work(alsa_stream->my_wq, &work->my_work)) {
+		kfree(work);
+		return -EBUSY;
 	}
 	return 0;
 }
 
 int bcm2835_audio_stop(struct bcm2835_alsa_stream *alsa_stream)
 {
-	if (alsa_stream->my_wq) {
-		struct bcm2835_audio_work *work;
-
-		work = kmalloc(sizeof(*work), GFP_ATOMIC);
-		/*--- Queue some work (item 1) ---*/
-		if (!work) {
-			LOG_ERR(" .. Error: NULL work kmalloc\n");
-			return -ENOMEM;
-		}
-		INIT_WORK(&work->my_work, my_wq_function);
-		work->alsa_stream = alsa_stream;
-		work->cmd = BCM2835_AUDIO_STOP;
-		if (!queue_work(alsa_stream->my_wq, &work->my_work)) {
-			kfree(work);
-			return -EBUSY;
-		}
+	struct bcm2835_audio_work *work;
+
+	work = kmalloc(sizeof(*work), GFP_ATOMIC);
+	/*--- Queue some work (item 1) ---*/
+	if (!work) {
+		LOG_ERR(" .. Error: NULL work kmalloc\n");
+		return -ENOMEM;
+	}
+	INIT_WORK(&work->my_work, my_wq_function);
+	work->alsa_stream = alsa_stream;
+	work->cmd = BCM2835_AUDIO_STOP;
+	if (!queue_work(alsa_stream->my_wq, &work->my_work)) {
+		kfree(work);
+		return -EBUSY;
 	}
 	return 0;
 }
@@ -163,40 +159,31 @@ int bcm2835_audio_stop(struct bcm2835_alsa_stream *alsa_stream)
 int bcm2835_audio_write(struct bcm2835_alsa_stream *alsa_stream,
 			unsigned int count, void *src)
 {
-	if (alsa_stream->my_wq) {
-		struct bcm2835_audio_work *work;
-
-		work = kmalloc(sizeof(*work), GFP_ATOMIC);
-		/*--- Queue some work (item 1) ---*/
-		if (!work) {
-			LOG_ERR(" .. Error: NULL work kmalloc\n");
-			return -ENOMEM;
-		}
-		INIT_WORK(&work->my_work, my_wq_function);
-		work->alsa_stream = alsa_stream;
-		work->cmd = BCM2835_AUDIO_WRITE;
-		work->src = src;
-		work->count = count;
-		if (!queue_work(alsa_stream->my_wq, &work->my_work)) {
-			kfree(work);
-			return -EBUSY;
-		}
+	struct bcm2835_audio_work *work;
+
+	work = kmalloc(sizeof(*work), GFP_ATOMIC);
+	/*--- Queue some work (item 1) ---*/
+	if (!work) {
+		LOG_ERR(" .. Error: NULL work kmalloc\n");
+		return -ENOMEM;
+	}
+	INIT_WORK(&work->my_work, my_wq_function);
+	work->alsa_stream = alsa_stream;
+	work->cmd = BCM2835_AUDIO_WRITE;
+	work->src = src;
+	work->count = count;
+	if (!queue_work(alsa_stream->my_wq, &work->my_work)) {
+		kfree(work);
+		return -EBUSY;
 	}
 	return 0;
 }
 
-static void my_workqueue_init(struct bcm2835_alsa_stream *alsa_stream)
-{
-	alsa_stream->my_wq = alloc_workqueue("my_queue", WQ_HIGHPRI, 1);
-}
-
 static void my_workqueue_quit(struct bcm2835_alsa_stream *alsa_stream)
 {
-	if (alsa_stream->my_wq) {
-		flush_workqueue(alsa_stream->my_wq);
-		destroy_workqueue(alsa_stream->my_wq);
-		alsa_stream->my_wq = NULL;
-	}
+	flush_workqueue(alsa_stream->my_wq);
+	destroy_workqueue(alsa_stream->my_wq);
+	alsa_stream->my_wq = NULL;
 }
 
 static void audio_vchi_callback(void *param,
@@ -424,7 +411,9 @@ int bcm2835_audio_open(struct bcm2835_alsa_stream *alsa_stream)
 	int status;
 	int ret;
 
-	my_workqueue_init(alsa_stream);
+	alsa_stream->my_wq = alloc_workqueue("my_queue", WQ_HIGHPRI, 1);
+	if (!alsa_stream->my_wq)
+		return -ENOMEM;
 
 	ret = bcm2835_audio_open_connection(alsa_stream);
 	if (ret) {
-- 
2.16.3

