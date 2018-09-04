Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CF1C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E2520645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E2520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeIDUYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:24:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:50802 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726961AbeIDUYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:24:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C0D3FB0A0;
        Tue,  4 Sep 2018 15:59:01 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/29] staging: bcm2835-audio: Remove redundant substream mask checks
Date:   Tue,  4 Sep 2018 17:58:33 +0200
Message-Id: <20180904155858.8001-5-tiwai@suse.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904155858.8001-1-tiwai@suse.de>
References: <20180904155858.8001-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The avail_substreams bit mask is checked for the possible racy
accesses, but this cannot happen in practice; i.e. the assignment and
the check are superfluous.

Let's rip them off.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../vc04_services/bcm2835-audio/bcm2835-ctl.c   |  2 --
 .../vc04_services/bcm2835-audio/bcm2835-pcm.c   |  8 --------
 .../vc04_services/bcm2835-audio/bcm2835-vchiq.c | 17 +++++++----------
 .../vc04_services/bcm2835-audio/bcm2835.c       |  5 +----
 .../vc04_services/bcm2835-audio/bcm2835.h       |  2 --
 5 files changed, 8 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
index 1c5a87580978..d2f0f609f737 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
@@ -64,8 +64,6 @@ static int snd_bcm2835_ctl_get(struct snd_kcontrol *kcontrol,
 
 	mutex_lock(&chip->audio_mutex);
 
-	BUG_ON(!chip && !(chip->avail_substreams & AVAIL_SUBSTREAMS_MASK));
-
 	if (kcontrol->private_value == PCM_PLAYBACK_VOLUME)
 		ucontrol->value.integer.value[0] = chip2alsa(chip->volume);
 	else if (kcontrol->private_value == PCM_PLAYBACK_MUTE)
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index f2d8b17d0cfe..0be185350f33 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -118,14 +118,6 @@ static int snd_bcm2835_playback_open_generic(
 		goto out;
 	}
 
-	/* Check if we are ready */
-	if (!(chip->avail_substreams & (1 << idx))) {
-		/* We are not ready yet */
-		audio_error("substream(%d) device is not ready yet\n", idx);
-		err = -EAGAIN;
-		goto out;
-	}
-
 	alsa_stream = kzalloc(sizeof(*alsa_stream), GFP_KERNEL);
 	if (!alsa_stream) {
 		err = -ENOMEM;
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index bec361aff4fe..942a38942c29 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -523,16 +523,13 @@ int bcm2835_audio_set_ctls(struct bcm2835_chip *chip)
 
 	/* change ctls for all substreams */
 	for (i = 0; i < MAX_SUBSTREAMS; i++) {
-		if (chip->avail_substreams & (1 << i)) {
-			if (!chip->alsa_stream[i]) {
-				LOG_DBG(" No ALSA stream available?! %i:%p (%x)\n", i, chip->alsa_stream[i], chip->avail_substreams);
-				ret = 0;
-			} else if (bcm2835_audio_set_ctls_chan(chip->alsa_stream[i], chip) != 0) {
-				LOG_ERR("Couldn't set the controls for stream %d\n", i);
-				ret = -1;
-			} else {
-				LOG_DBG(" Controls set for stream %d\n", i);
-			}
+		if (!chip->alsa_stream[i])
+			continue;
+		if (bcm2835_audio_set_ctls_chan(chip->alsa_stream[i], chip) != 0) {
+			LOG_ERR("Couldn't set the controls for stream %d\n", i);
+			ret = -1;
+		} else {
+			LOG_DBG(" Controls set for stream %d\n", i);
 		}
 	}
 	return ret;
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
index fa04f6bc9858..6876a5eadc07 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
@@ -280,7 +280,7 @@ static int snd_add_child_device(struct device *device,
 	struct snd_card *card;
 	struct device *child;
 	struct bcm2835_chip *chip;
-	int err, i;
+	int err;
 
 	child = snd_create_device(device, &audio_driver->driver,
 				  audio_driver->driver.name);
@@ -325,9 +325,6 @@ static int snd_add_child_device(struct device *device,
 		return err;
 	}
 
-	for (i = 0; i < numchans; i++)
-		chip->avail_substreams |= (1 << i);
-
 	err = snd_card_register(card);
 	if (err) {
 		dev_err(child, "Failed to register card, error %d\n", err);
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
index 5dc427240a1d..c0e7df4914ed 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
@@ -98,8 +98,6 @@ struct bcm2835_chip {
 	struct snd_card *card;
 	struct snd_pcm *pcm;
 	struct snd_pcm *pcm_spdif;
-	/* Bitmat for valid reg_base and irq numbers */
-	unsigned int avail_substreams;
 	struct device *dev;
 	struct bcm2835_alsa_stream *alsa_stream[MAX_SUBSTREAMS];
 
-- 
2.18.0

