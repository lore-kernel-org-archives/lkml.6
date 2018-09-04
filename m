Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79795C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A63E20645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A63E20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeIDU0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:26:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:50972 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726367AbeIDUYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:24:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EC943AD6D;
        Tue,  4 Sep 2018 15:59:01 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/29] staging: bcm2835-audio: Drop useless running flag and check
Date:   Tue,  4 Sep 2018 17:58:37 +0200
Message-Id: <20180904155858.8001-9-tiwai@suse.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904155858.8001-1-tiwai@suse.de>
References: <20180904155858.8001-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The running flag of alsa_stream is basically useless.  The running
state is strictly controlled in ALSA PCM core side, hence the check in
PCM trigger and close callbacks are superfluous.

Also, the prefill ack at trigger start became superfluous nowadays
with the ALSA PCM core update.

Let's rip them off.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../vc04_services/bcm2835-audio/bcm2835-pcm.c | 46 ++++---------------
 .../vc04_services/bcm2835-audio/bcm2835.h     |  1 -
 2 files changed, 8 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index 2c2b6b70df63..b4b9e90131bf 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -187,19 +187,6 @@ static int snd_bcm2835_playback_close(struct snd_pcm_substream *substream)
 
 	audio_info("Alsa close\n");
 
-	/*
-	 * Call stop if it's still running. This happens when app
-	 * is force killed and we don't get a stop trigger.
-	 */
-	if (alsa_stream->running) {
-		int err;
-
-		err = bcm2835_audio_stop(alsa_stream);
-		alsa_stream->running = 0;
-		if (err)
-			audio_error(" Failed to STOP alsa device\n");
-	}
-
 	alsa_stream->period_size = 0;
 	alsa_stream->buffer_size = 0;
 
@@ -324,27 +311,13 @@ static int snd_bcm2835_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		audio_debug("bcm2835_AUDIO_TRIGGER_START running=%d\n",
-			alsa_stream->running);
-		if (!alsa_stream->running) {
-			err = bcm2835_audio_start(alsa_stream);
-			if (!err) {
-				alsa_stream->pcm_indirect.hw_io =
-					alsa_stream->pcm_indirect.hw_data =
-					bytes_to_frames(runtime,
-					alsa_stream->pos);
-				substream->ops->ack(substream);
-				alsa_stream->running = 1;
-				alsa_stream->draining = 1;
-			} else {
-				audio_error(" Failed to START alsa device (%d)\n", err);
-			}
-		}
+		err = bcm2835_audio_start(alsa_stream);
+		if (!err)
+			alsa_stream->draining = 1;
+		else
+			audio_error(" Failed to START alsa device (%d)\n", err);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-		audio_debug
-			("bcm2835_AUDIO_TRIGGER_STOP running=%d draining=%d\n",
-			alsa_stream->running, runtime->status->state == SNDRV_PCM_STATE_DRAINING);
 		if (runtime->status->state == SNDRV_PCM_STATE_DRAINING) {
 			audio_info("DRAINING\n");
 			alsa_stream->draining = 1;
@@ -352,12 +325,9 @@ static int snd_bcm2835_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 			audio_info("DROPPING\n");
 			alsa_stream->draining = 0;
 		}
-		if (alsa_stream->running) {
-			err = bcm2835_audio_stop(alsa_stream);
-			if (err != 0)
-				audio_error(" Failed to STOP alsa device (%d)\n", err);
-			alsa_stream->running = 0;
-		}
+		err = bcm2835_audio_stop(alsa_stream);
+		if (err != 0)
+			audio_error(" Failed to STOP alsa device (%d)\n", err);
 		break;
 	default:
 		err = -EINVAL;
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
index 79363260ae34..2a9f3d6c10dc 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
@@ -121,7 +121,6 @@ struct bcm2835_alsa_stream {
 
 	spinlock_t lock;
 
-	int running;
 	int draining;
 
 	int channels;
-- 
2.18.0

