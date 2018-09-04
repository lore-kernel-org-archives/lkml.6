Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F021EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF7B20645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF7B20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbeIDU1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:27:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:50976 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727672AbeIDUYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:24:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 032FBB0A4;
        Tue,  4 Sep 2018 15:59:02 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/29] staging: bcm2835-audio: Fix incorrect draining handling
Date:   Tue,  4 Sep 2018 17:58:38 +0200
Message-Id: <20180904155858.8001-10-tiwai@suse.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904155858.8001-1-tiwai@suse.de>
References: <20180904155858.8001-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The handling of SNDRV_PCM_TRIGGER_STOP at the trigger callback is
incorrect: when the STOP is issued, the driver is supposed to drop the
stream immediately.  Meanwhile bcm2835 driver checks the DRAINING
state and tries to issue some different command.

This patch straightens things a bit, dropping the incorrect state
checks.  The draining behavior would be still not perfect at this
point, but will be improved in a later patch.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../vc04_services/bcm2835-audio/bcm2835-pcm.c  | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index b4b9e90131bf..00c2abab4bba 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -153,7 +153,6 @@ static int snd_bcm2835_playback_open_generic(
 	chip->alsa_stream[idx] = alsa_stream;
 
 	chip->opened |= (1 << idx);
-	alsa_stream->draining = 1;
 
 out:
 	mutex_unlock(&chip->audio_mutex);
@@ -268,6 +267,7 @@ static int snd_bcm2835_pcm_prepare(struct snd_pcm_substream *substream)
 	alsa_stream->buffer_size = snd_pcm_lib_buffer_bytes(substream);
 	alsa_stream->period_size = snd_pcm_lib_period_bytes(substream);
 	alsa_stream->pos = 0;
+	alsa_stream->draining = false;
 
 	audio_debug("buffer_size=%d, period_size=%d pos=%d frame_bits=%d\n",
 		alsa_stream->buffer_size, alsa_stream->period_size,
@@ -312,21 +312,15 @@ static int snd_bcm2835_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		err = bcm2835_audio_start(alsa_stream);
-		if (!err)
-			alsa_stream->draining = 1;
-		else
+		if (err)
 			audio_error(" Failed to START alsa device (%d)\n", err);
 		break;
+	case SNDRV_PCM_TRIGGER_DRAIN:
+		alsa_stream->draining = true;
+		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-		if (runtime->status->state == SNDRV_PCM_STATE_DRAINING) {
-			audio_info("DRAINING\n");
-			alsa_stream->draining = 1;
-		} else {
-			audio_info("DROPPING\n");
-			alsa_stream->draining = 0;
-		}
 		err = bcm2835_audio_stop(alsa_stream);
-		if (err != 0)
+		if (err)
 			audio_error(" Failed to STOP alsa device (%d)\n", err);
 		break;
 	default:
-- 
2.18.0

