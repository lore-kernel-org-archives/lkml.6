Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52528ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F175A208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F175A208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxera.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbeGLWGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 18:06:15 -0400
Received: from mx2.mpynet.fi ([82.197.21.85]:39201 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbeGLWGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 18:06:15 -0400
From:   Tuomas Tynkkynen <tuomas@tuxera.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        <linux-rpi-kernel@lists.infradead.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        Tuomas Tynkkynen <tuomas@tuxera.com>
Subject: [PATCH 2/2] staging: bcm2835-audio: Don't leak workqueue if open fails
Date:   Fri, 13 Jul 2018 00:54:17 +0300
Message-ID: <20180712215417.22491-2-tuomas@tuxera.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180712215417.22491-1-tuomas@tuxera.com>
References: <20180712215417.22491-1-tuomas@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
Received-SPF: none
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if bcm2835_audio_open() fails partway, the allocated
workqueue is leaked. Avoid that.

While at it, propagate the return value of
bcm2835_audio_open_connection() on failure instead of returning -1.

Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>
---
 .../staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c  | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index 85ed807bb873..779c1e993b55 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -416,16 +416,16 @@ int bcm2835_audio_open(struct bcm2835_alsa_stream *alsa_stream)
 		return -ENOMEM;
 
 	ret = bcm2835_audio_open_connection(alsa_stream);
-	if (ret) {
-		ret = -1;
-		goto exit;
-	}
+	if (ret)
+		goto free_wq;
+
 	instance = alsa_stream->instance;
 	LOG_DBG(" instance (%p)\n", instance);
 
 	if (mutex_lock_interruptible(&instance->vchi_mutex)) {
 		LOG_DBG("Interrupted whilst waiting for lock on (%d)\n", instance->num_connections);
-		return -EINTR;
+		ret = -EINTR;
+		goto free_wq;
 	}
 	vchi_service_use(instance->vchi_handle[0]);
 
@@ -448,7 +448,11 @@ int bcm2835_audio_open(struct bcm2835_alsa_stream *alsa_stream)
 unlock:
 	vchi_service_release(instance->vchi_handle[0]);
 	mutex_unlock(&instance->vchi_mutex);
-exit:
+
+free_wq:
+	if (ret)
+		destroy_workqueue(alsa_stream->my_wq);
+
 	return ret;
 }
 
-- 
2.16.3

