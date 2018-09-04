Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A87C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6BD120645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BD120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbeIDUZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:25:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:51022 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727773AbeIDUYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:24:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 51325B0AA;
        Tue,  4 Sep 2018 15:59:02 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/29] staging: bcm2835-audio: Drop debug messages in bcm2835-pcm.c
Date:   Tue,  4 Sep 2018 17:58:44 +0200
Message-Id: <20180904155858.8001-16-tiwai@suse.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904155858.8001-1-tiwai@suse.de>
References: <20180904155858.8001-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These debug messages worsen the code readability a lot while they give
little debuggability (which we already have via tracing, in anyway).

Let's clean them up.  This allows us to reduce the
snd_bcm2835_pcm_lib_ioctl() function to be a direct call of the
snd_pcm_lib_ioctl callback (like most other drivers do), too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../vc04_services/bcm2835-audio/bcm2835-pcm.c | 51 +++----------------
 1 file changed, 7 insertions(+), 44 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index 41bcaff6358b..1f9c940f1cc3 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -44,9 +44,7 @@ static const struct snd_pcm_hardware snd_bcm2835_playback_spdif_hw = {
 
 static void snd_bcm2835_playback_free(struct snd_pcm_runtime *runtime)
 {
-	audio_info("Freeing up alsa stream here ..\n");
 	kfree(runtime->private_data);
-	runtime->private_data = NULL;
 }
 
 void bcm2835_playback_fifo(struct bcm2835_alsa_stream *alsa_stream)
@@ -99,7 +97,6 @@ static int snd_bcm2835_playback_open_generic(
 	int err;
 
 	mutex_lock(&chip->audio_mutex);
-	audio_info("Alsa open (%d)\n", substream->number);
 	idx = substream->number;
 
 	if (spdif && chip->opened) {
@@ -182,8 +179,6 @@ static int snd_bcm2835_playback_close(struct snd_pcm_substream *substream)
 	runtime = substream->runtime;
 	alsa_stream = runtime->private_data;
 
-	audio_info("Alsa close\n");
-
 	alsa_stream->period_size = 0;
 	alsa_stream->buffer_size = 0;
 
@@ -251,10 +246,6 @@ static int snd_bcm2835_pcm_prepare(struct snd_pcm_substream *substream)
 	alsa_stream->pos = 0;
 	alsa_stream->draining = false;
 
-	audio_debug("buffer_size=%d, period_size=%d pos=%d frame_bits=%d\n",
-		alsa_stream->buffer_size, alsa_stream->period_size,
-		alsa_stream->pos, runtime->frame_bits);
-
  out:
 	mutex_unlock(&chip->audio_mutex);
 	return err;
@@ -266,12 +257,8 @@ static void snd_bcm2835_pcm_transfer(struct snd_pcm_substream *substream,
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct bcm2835_alsa_stream *alsa_stream = runtime->private_data;
 	void *src = (void *) (substream->runtime->dma_area + rec->sw_data);
-	int err;
-
-	err = bcm2835_audio_write(alsa_stream, bytes, src);
-	if (err)
-		audio_error(" Failed to transfer to alsa device (%d)\n", err);
 
+	bcm2835_audio_write(alsa_stream, bytes, src);
 }
 
 static int snd_bcm2835_pcm_ack(struct snd_pcm_substream *substream)
@@ -289,27 +276,18 @@ static int snd_bcm2835_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct bcm2835_alsa_stream *alsa_stream = runtime->private_data;
-	int err = 0;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		err = bcm2835_audio_start(alsa_stream);
-		if (err)
-			audio_error(" Failed to START alsa device (%d)\n", err);
-		break;
+		return bcm2835_audio_start(alsa_stream);
 	case SNDRV_PCM_TRIGGER_DRAIN:
 		alsa_stream->draining = true;
-		break;
+		return 0;
 	case SNDRV_PCM_TRIGGER_STOP:
-		err = bcm2835_audio_stop(alsa_stream);
-		if (err)
-			audio_error(" Failed to STOP alsa device (%d)\n", err);
-		break;
+		return bcm2835_audio_stop(alsa_stream);
 	default:
-		err = -EINVAL;
+		return -EINVAL;
 	}
-
-	return err;
 }
 
 /* pointer callback */
@@ -319,31 +297,16 @@ snd_bcm2835_pcm_pointer(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct bcm2835_alsa_stream *alsa_stream = runtime->private_data;
 
-	audio_debug("pcm_pointer... (%d) hwptr=%d appl=%d pos=%d\n", 0,
-		frames_to_bytes(runtime, runtime->status->hw_ptr),
-		frames_to_bytes(runtime, runtime->control->appl_ptr),
-		alsa_stream->pos);
-
 	return snd_pcm_indirect_playback_pointer(substream,
 		&alsa_stream->pcm_indirect,
 		alsa_stream->pos);
 }
 
-static int snd_bcm2835_pcm_lib_ioctl(struct snd_pcm_substream *substream,
-	unsigned int cmd, void *arg)
-{
-	int ret = snd_pcm_lib_ioctl(substream, cmd, arg);
-
-	audio_info(" .. substream=%p, cmd=%d, arg=%p (%x) ret=%d\n", substream,
-		cmd, arg, arg ? *(unsigned int *)arg : 0, ret);
-	return ret;
-}
-
 /* operators */
 static const struct snd_pcm_ops snd_bcm2835_playback_ops = {
 	.open = snd_bcm2835_playback_open,
 	.close = snd_bcm2835_playback_close,
-	.ioctl = snd_bcm2835_pcm_lib_ioctl,
+	.ioctl = snd_pcm_lib_ioctl,
 	.hw_params = snd_bcm2835_pcm_hw_params,
 	.hw_free = snd_bcm2835_pcm_hw_free,
 	.prepare = snd_bcm2835_pcm_prepare,
@@ -355,7 +318,7 @@ static const struct snd_pcm_ops snd_bcm2835_playback_ops = {
 static const struct snd_pcm_ops snd_bcm2835_playback_spdif_ops = {
 	.open = snd_bcm2835_playback_spdif_open,
 	.close = snd_bcm2835_playback_close,
-	.ioctl = snd_bcm2835_pcm_lib_ioctl,
+	.ioctl = snd_pcm_lib_ioctl,
 	.hw_params = snd_bcm2835_pcm_hw_params,
 	.hw_free = snd_bcm2835_pcm_hw_free,
 	.prepare = snd_bcm2835_pcm_prepare,
-- 
2.18.0

