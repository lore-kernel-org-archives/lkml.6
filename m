Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E283C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C564D20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C564D20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeIDUYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:24:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:50744 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726347AbeIDUYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:24:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8AA72B09D;
        Tue,  4 Sep 2018 15:59:01 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/29] staging: bcm2835-audio: Clean up mutex locks
Date:   Tue,  4 Sep 2018 17:58:30 +0200
Message-Id: <20180904155858.8001-2-tiwai@suse.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904155858.8001-1-tiwai@suse.de>
References: <20180904155858.8001-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd-bcm2835 driver takes the lock with mutex_lock_interruptible() in
all places, which don't make sense.  Replace them with the simple
mutex_lock().

Also taking a mutex lock right after creating it for each PCM object
is nonsense, too.  It cannot be racy at that point.  We can get rid of
it.

Last but not least, initializing chip->audio_mutex at each place is
error-prone.  Initialize properly at creating the chip object in
snd_bcm2835_create() instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../vc04_services/bcm2835-audio/bcm2835-ctl.c | 18 +++----
 .../vc04_services/bcm2835-audio/bcm2835-pcm.c | 33 ++-----------
 .../bcm2835-audio/bcm2835-vchiq.c             | 47 ++++---------------
 .../vc04_services/bcm2835-audio/bcm2835.c     |  1 +
 4 files changed, 20 insertions(+), 79 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
index ec468d5719b1..04ea3ec7f64f 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
@@ -77,8 +77,7 @@ static int snd_bcm2835_ctl_get(struct snd_kcontrol *kcontrol,
 {
 	struct bcm2835_chip *chip = snd_kcontrol_chip(kcontrol);
 
-	if (mutex_lock_interruptible(&chip->audio_mutex))
-		return -EINTR;
+	mutex_lock(&chip->audio_mutex);
 
 	BUG_ON(!chip && !(chip->avail_substreams & AVAIL_SUBSTREAMS_MASK));
 
@@ -99,8 +98,7 @@ static int snd_bcm2835_ctl_put(struct snd_kcontrol *kcontrol,
 	struct bcm2835_chip *chip = snd_kcontrol_chip(kcontrol);
 	int changed = 0;
 
-	if (mutex_lock_interruptible(&chip->audio_mutex))
-		return -EINTR;
+	mutex_lock(&chip->audio_mutex);
 
 	if (kcontrol->private_value == PCM_PLAYBACK_VOLUME) {
 		audio_info("Volume change attempted.. volume = %d new_volume = %d\n", chip->volume, (int)ucontrol->value.integer.value[0]);
@@ -187,8 +185,7 @@ static int snd_bcm2835_spdif_default_get(struct snd_kcontrol *kcontrol,
 	struct bcm2835_chip *chip = snd_kcontrol_chip(kcontrol);
 	int i;
 
-	if (mutex_lock_interruptible(&chip->audio_mutex))
-		return -EINTR;
+	mutex_lock(&chip->audio_mutex);
 
 	for (i = 0; i < 4; i++)
 		ucontrol->value.iec958.status[i] =
@@ -205,8 +202,7 @@ static int snd_bcm2835_spdif_default_put(struct snd_kcontrol *kcontrol,
 	unsigned int val = 0;
 	int i, change;
 
-	if (mutex_lock_interruptible(&chip->audio_mutex))
-		return -EINTR;
+	mutex_lock(&chip->audio_mutex);
 
 	for (i = 0; i < 4; i++)
 		val |= (unsigned int)ucontrol->value.iec958.status[i] << (i * 8);
@@ -251,8 +247,7 @@ static int snd_bcm2835_spdif_stream_get(struct snd_kcontrol *kcontrol,
 	struct bcm2835_chip *chip = snd_kcontrol_chip(kcontrol);
 	int i;
 
-	if (mutex_lock_interruptible(&chip->audio_mutex))
-		return -EINTR;
+	mutex_lock(&chip->audio_mutex);
 
 	for (i = 0; i < 4; i++)
 		ucontrol->value.iec958.status[i] =
@@ -269,8 +264,7 @@ static int snd_bcm2835_spdif_stream_put(struct snd_kcontrol *kcontrol,
 	unsigned int val = 0;
 	int i, change;
 
-	if (mutex_lock_interruptible(&chip->audio_mutex))
-		return -EINTR;
+	mutex_lock(&chip->audio_mutex);
 
 	for (i = 0; i < 4; i++)
 		val |= (unsigned int)ucontrol->value.iec958.status[i] << (i * 8);
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index 8359cf881bef..f2d8b17d0cfe 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -99,10 +99,7 @@ static int snd_bcm2835_playback_open_generic(
 	int idx;
 	int err;
 
-	if (mutex_lock_interruptible(&chip->audio_mutex)) {
-		audio_error("Interrupted whilst waiting for lock\n");
-		return -EINTR;
-	}
+	mutex_lock(&chip->audio_mutex);
 	audio_info("Alsa open (%d)\n", substream->number);
 	idx = substream->number;
 
@@ -194,10 +191,7 @@ static int snd_bcm2835_playback_close(struct snd_pcm_substream *substream)
 	struct bcm2835_alsa_stream *alsa_stream;
 
 	chip = snd_pcm_substream_chip(substream);
-	if (mutex_lock_interruptible(&chip->audio_mutex)) {
-		audio_error("Interrupted whilst waiting for lock\n");
-		return -EINTR;
-	}
+	mutex_lock(&chip->audio_mutex);
 	runtime = substream->runtime;
 	alsa_stream = runtime->private_data;
 
@@ -274,8 +268,7 @@ static int snd_bcm2835_pcm_prepare(struct snd_pcm_substream *substream)
 	int channels;
 	int err;
 
-	if (mutex_lock_interruptible(&chip->audio_mutex))
-		return -EINTR;
+	mutex_lock(&chip->audio_mutex);
 
 	/* notify the vchiq that it should enter spdif passthrough mode by
 	 * setting channels=0 (see
@@ -449,14 +442,9 @@ int snd_bcm2835_new_pcm(struct bcm2835_chip *chip, u32 numchannels)
 	struct snd_pcm *pcm;
 	int err;
 
-	mutex_init(&chip->audio_mutex);
-	if (mutex_lock_interruptible(&chip->audio_mutex)) {
-		audio_error("Interrupted whilst waiting for lock\n");
-		return -EINTR;
-	}
 	err = snd_pcm_new(chip->card, "bcm2835 ALSA", 0, numchannels, 0, &pcm);
 	if (err < 0)
-		goto out;
+		return err;
 	pcm->private_data = chip;
 	strcpy(pcm->name, "bcm2835 ALSA");
 	chip->pcm = pcm;
@@ -474,9 +462,6 @@ int snd_bcm2835_new_pcm(struct bcm2835_chip *chip, u32 numchannels)
 					      snd_bcm2835_playback_hw.buffer_bytes_max,
 					      snd_bcm2835_playback_hw.buffer_bytes_max);
 
-out:
-	mutex_unlock(&chip->audio_mutex);
-
 	return 0;
 }
 
@@ -485,13 +470,9 @@ int snd_bcm2835_new_spdif_pcm(struct bcm2835_chip *chip)
 	struct snd_pcm *pcm;
 	int err;
 
-	if (mutex_lock_interruptible(&chip->audio_mutex)) {
-		audio_error("Interrupted whilst waiting for lock\n");
-		return -EINTR;
-	}
 	err = snd_pcm_new(chip->card, "bcm2835 ALSA", 1, 1, 0, &pcm);
 	if (err < 0)
-		goto out;
+		return err;
 
 	pcm->private_data = chip;
 	strcpy(pcm->name, "bcm2835 IEC958/HDMI");
@@ -504,8 +485,6 @@ int snd_bcm2835_new_spdif_pcm(struct bcm2835_chip *chip)
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
 		snd_dma_continuous_data(GFP_KERNEL),
 		snd_bcm2835_playback_spdif_hw.buffer_bytes_max, snd_bcm2835_playback_spdif_hw.buffer_bytes_max);
-out:
-	mutex_unlock(&chip->audio_mutex);
 
 	return 0;
 }
@@ -518,8 +497,6 @@ int snd_bcm2835_new_simple_pcm(struct bcm2835_chip *chip,
 	struct snd_pcm *pcm;
 	int err;
 
-	mutex_init(&chip->audio_mutex);
-
 	err = snd_pcm_new(chip->card, name, 0, numchannels,
 			  0, &pcm);
 	if (err)
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index 868e2d6aaf1b..bec361aff4fe 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -319,11 +319,7 @@ static int vc_vchi_audio_deinit(struct bcm2835_audio_instance *instance)
 	}
 
 	LOG_DBG(" .. about to lock (%d)\n", instance->num_connections);
-	if (mutex_lock_interruptible(&instance->vchi_mutex)) {
-		LOG_DBG("Interrupted whilst waiting for lock on (%d)\n",
-			instance->num_connections);
-		return -EINTR;
-	}
+	mutex_lock(&instance->vchi_mutex);
 
 	/* Close all VCHI service connections */
 	for (i = 0; i < instance->num_connections; i++) {
@@ -434,11 +430,7 @@ int bcm2835_audio_open(struct bcm2835_alsa_stream *alsa_stream)
 	instance = alsa_stream->instance;
 	LOG_DBG(" instance (%p)\n", instance);
 
-	if (mutex_lock_interruptible(&instance->vchi_mutex)) {
-		LOG_DBG("Interrupted whilst waiting for lock on (%d)\n", instance->num_connections);
-		ret = -EINTR;
-		goto free_wq;
-	}
+	mutex_lock(&instance->vchi_mutex);
 	vchi_service_use(instance->vchi_handle[0]);
 
 	m.type = VC_AUDIO_MSG_TYPE_OPEN;
@@ -479,11 +471,7 @@ static int bcm2835_audio_set_ctls_chan(struct bcm2835_alsa_stream *alsa_stream,
 	LOG_INFO(" Setting ALSA dest(%d), volume(%d)\n",
 		 chip->dest, chip->volume);
 
-	if (mutex_lock_interruptible(&instance->vchi_mutex)) {
-		LOG_DBG("Interrupted whilst waiting for lock on (%d)\n",
-			instance->num_connections);
-		return -EINTR;
-	}
+	mutex_lock(&instance->vchi_mutex);
 	vchi_service_use(instance->vchi_handle[0]);
 
 	instance->result = -1;
@@ -569,10 +557,7 @@ int bcm2835_audio_set_params(struct bcm2835_alsa_stream *alsa_stream,
 		return -EINVAL;
 	}
 
-	if (mutex_lock_interruptible(&instance->vchi_mutex)) {
-		LOG_DBG("Interrupted whilst waiting for lock on (%d)\n", instance->num_connections);
-		return -EINTR;
-	}
+	mutex_lock(&instance->vchi_mutex);
 	vchi_service_use(instance->vchi_handle[0]);
 
 	instance->result = -1;
@@ -629,11 +614,7 @@ static int bcm2835_audio_start_worker(struct bcm2835_alsa_stream *alsa_stream)
 	int status;
 	int ret;
 
-	if (mutex_lock_interruptible(&instance->vchi_mutex)) {
-		LOG_DBG("Interrupted whilst waiting for lock on (%d)\n",
-			instance->num_connections);
-		return -EINTR;
-	}
+	mutex_lock(&instance->vchi_mutex);
 	vchi_service_use(instance->vchi_handle[0]);
 
 	m.type = VC_AUDIO_MSG_TYPE_START;
@@ -665,11 +646,7 @@ static int bcm2835_audio_stop_worker(struct bcm2835_alsa_stream *alsa_stream)
 	int status;
 	int ret;
 
-	if (mutex_lock_interruptible(&instance->vchi_mutex)) {
-		LOG_DBG("Interrupted whilst waiting for lock on (%d)\n",
-			instance->num_connections);
-		return -EINTR;
-	}
+	mutex_lock(&instance->vchi_mutex);
 	vchi_service_use(instance->vchi_handle[0]);
 
 	m.type = VC_AUDIO_MSG_TYPE_STOP;
@@ -704,11 +681,7 @@ int bcm2835_audio_close(struct bcm2835_alsa_stream *alsa_stream)
 
 	my_workqueue_quit(alsa_stream);
 
-	if (mutex_lock_interruptible(&instance->vchi_mutex)) {
-		LOG_DBG("Interrupted whilst waiting for lock on (%d)\n",
-			instance->num_connections);
-		return -EINTR;
-	}
+	mutex_lock(&instance->vchi_mutex);
 	vchi_service_use(instance->vchi_handle[0]);
 
 	m.type = VC_AUDIO_MSG_TYPE_CLOSE;
@@ -761,11 +734,7 @@ static int bcm2835_audio_write_worker(struct bcm2835_alsa_stream *alsa_stream,
 
 	LOG_INFO(" Writing %d bytes from %p\n", count, src);
 
-	if (mutex_lock_interruptible(&instance->vchi_mutex)) {
-		LOG_DBG("Interrupted whilst waiting for lock on (%d)\n",
-			instance->num_connections);
-		return -EINTR;
-	}
+	mutex_lock(&instance->vchi_mutex);
 	vchi_service_use(instance->vchi_handle[0]);
 
 	if (instance->peer_version == 0 &&
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
index da0fa34501fa..fa04f6bc9858 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
@@ -149,6 +149,7 @@ static int snd_bcm2835_create(struct snd_card *card,
 		return -ENOMEM;
 
 	chip->card = card;
+	mutex_init(&chip->audio_mutex);
 
 	chip->vchi_ctx = devres_find(card->dev->parent,
 				     bcm2835_devm_free_vchi_ctx, NULL, NULL);
-- 
2.18.0

