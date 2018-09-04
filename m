Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D55C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E2A20645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E2A20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbeIDUYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:24:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:51016 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727802AbeIDUYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:24:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ECF2EB0B6;
        Tue,  4 Sep 2018 15:59:02 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 27/29] staging: bcm2835-audio: Simplify PCM creation helpers
Date:   Tue,  4 Sep 2018 17:58:56 +0200
Message-Id: <20180904155858.8001-28-tiwai@suse.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904155858.8001-1-tiwai@suse.de>
References: <20180904155858.8001-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All three functions to create PCM objects are fairly resemble, and can
be unified to a single common helper.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../vc04_services/bcm2835-audio/bcm2835-pcm.c | 87 ++++---------------
 .../vc04_services/bcm2835-audio/bcm2835.c     | 17 +++-
 .../vc04_services/bcm2835-audio/bcm2835.h     |  9 +-
 3 files changed, 32 insertions(+), 81 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index 5ddb8ee93cb2..98480d97cc2e 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -324,91 +324,36 @@ static const struct snd_pcm_ops snd_bcm2835_playback_spdif_ops = {
 };
 
 /* create a pcm device */
-int snd_bcm2835_new_pcm(struct bcm2835_chip *chip, u32 numchannels)
+int snd_bcm2835_new_pcm(struct bcm2835_chip *chip, const char *name,
+			int idx, enum snd_bcm2835_route route,
+			u32 numchannels, bool spdif)
 {
 	struct snd_pcm *pcm;
 	int err;
 
-	err = snd_pcm_new(chip->card, "bcm2835 ALSA", 0, numchannels, 0, &pcm);
-	if (err < 0)
-		return err;
-	pcm->private_data = chip;
-	pcm->nonatomic = true;
-	strcpy(pcm->name, "bcm2835 ALSA");
-	chip->pcm = pcm;
-	chip->dest = AUDIO_DEST_AUTO;
-	chip->volume = 0;
-	chip->mute = CTRL_VOL_UNMUTE; /*disable mute on startup */
-	/* set operators */
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
-			&snd_bcm2835_playback_ops);
-
-	/* pre-allocation of buffers */
-	/* NOTE: this may fail */
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-					      chip->card->dev->parent,
-					      snd_bcm2835_playback_hw.buffer_bytes_max,
-					      snd_bcm2835_playback_hw.buffer_bytes_max);
-
-	return 0;
-}
-
-int snd_bcm2835_new_spdif_pcm(struct bcm2835_chip *chip)
-{
-	struct snd_pcm *pcm;
-	int err;
-
-	err = snd_pcm_new(chip->card, "bcm2835 ALSA", 1, 1, 0, &pcm);
-	if (err < 0)
-		return err;
-
-	pcm->private_data = chip;
-	pcm->nonatomic = true;
-	strcpy(pcm->name, "bcm2835 IEC958/HDMI");
-	chip->pcm_spdif = pcm;
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
-			&snd_bcm2835_playback_spdif_ops);
-
-	/* pre-allocation of buffers */
-	/* NOTE: this may fail */
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-		chip->card->dev->parent,
-		snd_bcm2835_playback_spdif_hw.buffer_bytes_max, snd_bcm2835_playback_spdif_hw.buffer_bytes_max);
-
-	return 0;
-}
-
-int snd_bcm2835_new_simple_pcm(struct bcm2835_chip *chip,
-			       const char *name,
-			       enum snd_bcm2835_route route,
-			       u32 numchannels)
-{
-	struct snd_pcm *pcm;
-	int err;
-
-	err = snd_pcm_new(chip->card, name, 0, numchannels,
-			  0, &pcm);
+	err = snd_pcm_new(chip->card, name, idx, numchannels, 0, &pcm);
 	if (err)
 		return err;
 
 	pcm->private_data = chip;
 	pcm->nonatomic = true;
 	strcpy(pcm->name, name);
-	chip->pcm = pcm;
-	chip->dest = route;
-	chip->volume = 0;
-	chip->mute = CTRL_VOL_UNMUTE;
+	if (!spdif) {
+		chip->dest = route;
+		chip->volume = 0;
+		chip->mute = CTRL_VOL_UNMUTE;
+	}
 
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
+			spdif ? &snd_bcm2835_playback_spdif_ops :
 			&snd_bcm2835_playback_ops);
 
-	snd_pcm_lib_preallocate_pages_for_all(
-		pcm,
-		SNDRV_DMA_TYPE_DEV,
-		chip->card->dev->parent,
-		snd_bcm2835_playback_hw.buffer_bytes_max,
-		snd_bcm2835_playback_hw.buffer_bytes_max);
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+		chip->card->dev->parent, 128 * 1024, 128 * 1024);
 
+	if (spdif)
+		chip->pcm_spdif = pcm;
+	else
+		chip->pcm = pcm;
 	return 0;
 }
-
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
index 8a87c33b1ea9..2869f310086f 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
@@ -138,17 +138,26 @@ static int bcm2835_audio_alsa_newpcm(struct bcm2835_chip *chip,
 {
 	int err;
 
-	err = snd_bcm2835_new_pcm(chip, numchannels - 1);
+	err = snd_bcm2835_new_pcm(chip, "bcm2835 ALSA", 0, AUDIO_DEST_AUTO,
+				  numchannels - 1, false);
 	if (err)
 		return err;
 
-	err = snd_bcm2835_new_spdif_pcm(chip);
+	err = snd_bcm2835_new_pcm(chip, "bcm2835 IEC958/HDMI", 1, 0, 1, true);
 	if (err)
 		return err;
 
 	return 0;
 }
 
+static int bcm2835_audio_simple_newpcm(struct bcm2835_chip *chip,
+				       const char *name,
+				       enum snd_bcm2835_route route,
+				       u32 numchannels)
+{
+	return snd_bcm2835_new_pcm(chip, name, 0, route, numchannels, false);
+}
+
 static struct bcm2835_audio_driver bcm2835_audio_alsa = {
 	.driver = {
 		.name = "bcm2835_alsa",
@@ -169,7 +178,7 @@ static struct bcm2835_audio_driver bcm2835_audio_hdmi = {
 	.shortname = "bcm2835 HDMI",
 	.longname  = "bcm2835 HDMI",
 	.minchannels = 1,
-	.newpcm = snd_bcm2835_new_simple_pcm,
+	.newpcm = bcm2835_audio_simple_newpcm,
 	.newctl = snd_bcm2835_new_hdmi_ctl,
 	.route = AUDIO_DEST_HDMI
 };
@@ -182,7 +191,7 @@ static struct bcm2835_audio_driver bcm2835_audio_headphones = {
 	.shortname = "bcm2835 Headphones",
 	.longname  = "bcm2835 Headphones",
 	.minchannels = 1,
-	.newpcm = snd_bcm2835_new_simple_pcm,
+	.newpcm = bcm2835_audio_simple_newpcm,
 	.newctl = snd_bcm2835_new_headphones_ctl,
 	.route = AUDIO_DEST_HEADPHONES
 };
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
index 4e41069dc22a..e13435d1c205 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
@@ -84,12 +84,9 @@ struct bcm2835_alsa_stream {
 };
 
 int snd_bcm2835_new_ctl(struct bcm2835_chip *chip);
-int snd_bcm2835_new_pcm(struct bcm2835_chip *chip, u32 numchannels);
-int snd_bcm2835_new_spdif_pcm(struct bcm2835_chip *chip);
-int snd_bcm2835_new_simple_pcm(struct bcm2835_chip *chip,
-			       const char *name,
-			       enum snd_bcm2835_route route,
-			       u32 numchannels);
+int snd_bcm2835_new_pcm(struct bcm2835_chip *chip, const char *name,
+			int idx, enum snd_bcm2835_route route,
+			u32 numchannels, bool spdif);
 
 int snd_bcm2835_new_hdmi_ctl(struct bcm2835_chip *chip);
 int snd_bcm2835_new_headphones_ctl(struct bcm2835_chip *chip);
-- 
2.18.0

