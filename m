Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF27AECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B685D2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B685D2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbeJRC7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:59:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:42514 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727053AbeJRC7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:59:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0FC80B063;
        Wed, 17 Oct 2018 19:02:20 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     eric@anholt.net, stefan.wahren@i2se.com,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, nsaenzjulienne@suse.de, devel@driverdev.osuosl.org
Subject: [PATCH v2 4/7] staging: bcm2835-audio: use anonymous union in struct vc_audio_msg
Date:   Wed, 17 Oct 2018 21:01:53 +0200
Message-Id: <20181017190156.30010-5-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181017190156.30010-1-nsaenzjulienne@suse.de>
References: <20181017190156.30010-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this case explicitly naming the union doesn't help overall code
comprehension and clutters it.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../bcm2835-audio/bcm2835-vchiq.c             | 30 +++++++++----------
 .../bcm2835-audio/vc_vchi_audioserv_defs.h    |  2 +-
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index 932ef12ac5d2..0db412fd7c55 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -104,15 +104,15 @@ static void audio_vchi_callback(void *param,
 	status = vchi_msg_dequeue(instance->vchi_handle,
 				  &m, sizeof(m), &msg_len, VCHI_FLAGS_NONE);
 	if (m.type == VC_AUDIO_MSG_TYPE_RESULT) {
-		instance->result = m.u.result.success;
+		instance->result = m.result.success;
 		complete(&instance->msg_avail_comp);
 	} else if (m.type == VC_AUDIO_MSG_TYPE_COMPLETE) {
-		if (m.u.complete.cookie1 != VC_AUDIO_WRITE_COOKIE1 ||
-		    m.u.complete.cookie2 != VC_AUDIO_WRITE_COOKIE2)
+		if (m.complete.cookie1 != VC_AUDIO_WRITE_COOKIE1 ||
+		    m.complete.cookie2 != VC_AUDIO_WRITE_COOKIE2)
 			dev_err(instance->dev, "invalid cookie\n");
 		else
 			bcm2835_playback_fifo(instance->alsa_stream,
-					      m.u.complete.count);
+					      m.complete.count);
 	} else {
 		dev_err(instance->dev, "unexpected callback type=%d\n", m.type);
 	}
@@ -249,11 +249,11 @@ int bcm2835_audio_set_ctls(struct bcm2835_alsa_stream *alsa_stream)
 	struct vc_audio_msg m = {};
 
 	m.type = VC_AUDIO_MSG_TYPE_CONTROL;
-	m.u.control.dest = chip->dest;
+	m.control.dest = chip->dest;
 	if (!chip->mute)
-		m.u.control.volume = CHIP_MIN_VOLUME;
+		m.control.volume = CHIP_MIN_VOLUME;
 	else
-		m.u.control.volume = alsa2chip(chip->volume);
+		m.control.volume = alsa2chip(chip->volume);
 
 	return bcm2835_audio_send_msg(alsa_stream->instance, &m, true);
 }
@@ -264,9 +264,9 @@ int bcm2835_audio_set_params(struct bcm2835_alsa_stream *alsa_stream,
 {
 	struct vc_audio_msg m = {
 		 .type = VC_AUDIO_MSG_TYPE_CONFIG,
-		 .u.config.channels = channels,
-		 .u.config.samplerate = samplerate,
-		 .u.config.bps = bps,
+		 .config.channels = channels,
+		 .config.samplerate = samplerate,
+		 .config.bps = bps,
 	};
 	int err;
 
@@ -294,7 +294,7 @@ int bcm2835_audio_drain(struct bcm2835_alsa_stream *alsa_stream)
 {
 	struct vc_audio_msg m = {
 		.type = VC_AUDIO_MSG_TYPE_STOP,
-		.u.stop.draining = 1,
+		.stop.draining = 1,
 	};
 
 	return bcm2835_audio_send_msg(alsa_stream->instance, &m, false);
@@ -322,10 +322,10 @@ int bcm2835_audio_write(struct bcm2835_alsa_stream *alsa_stream,
 	struct bcm2835_audio_instance *instance = alsa_stream->instance;
 	struct vc_audio_msg m = {
 		.type = VC_AUDIO_MSG_TYPE_WRITE,
-		.u.write.count = size,
-		.u.write.max_packet = instance->max_packet,
-		.u.write.cookie1 = VC_AUDIO_WRITE_COOKIE1,
-		.u.write.cookie2 = VC_AUDIO_WRITE_COOKIE2,
+		.write.count = size,
+		.write.max_packet = instance->max_packet,
+		.write.cookie1 = VC_AUDIO_WRITE_COOKIE1,
+		.write.cookie2 = VC_AUDIO_WRITE_COOKIE2,
 	};
 	unsigned int count;
 	int err, status;
diff --git a/drivers/staging/vc04_services/bcm2835-audio/vc_vchi_audioserv_defs.h b/drivers/staging/vc04_services/bcm2835-audio/vc_vchi_audioserv_defs.h
index dc62875cfdca..d6401e914ac9 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/vc_vchi_audioserv_defs.h
+++ b/drivers/staging/vc04_services/bcm2835-audio/vc_vchi_audioserv_defs.h
@@ -93,7 +93,7 @@ struct vc_audio_msg {
 		struct vc_audio_write write;
 		struct vc_audio_result result;
 		struct vc_audio_complete complete;
-	} u;
+	};
 };
 
 #endif /* _VC_AUDIO_DEFS_H_ */
-- 
2.19.1

