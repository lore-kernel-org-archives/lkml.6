Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DE9C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684E920645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684E920645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbeIDU0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:26:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:51016 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727716AbeIDUYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:24:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1F099B0A6;
        Tue,  4 Sep 2018 15:59:02 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/29] staging: bcm2835-audio: Use PCM runtime values instead
Date:   Tue,  4 Sep 2018 17:58:40 +0200
Message-Id: <20180904155858.8001-12-tiwai@suse.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904155858.8001-1-tiwai@suse.de>
References: <20180904155858.8001-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some fields in alsa_stream are the values we keep already in PCM
runtime object, hence they are redundant.  Use the standard PCM
runtime values instead of the private copies.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../vc04_services/bcm2835-audio/bcm2835-pcm.c | 23 ++++---------------
 .../vc04_services/bcm2835-audio/bcm2835.h     |  4 ----
 2 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index fc1b345d206c..a3605505cc20 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -206,22 +206,7 @@ static int snd_bcm2835_playback_close(struct snd_pcm_substream *substream)
 static int snd_bcm2835_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct bcm2835_alsa_stream *alsa_stream = runtime->private_data;
-	int err;
-
-	err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
-	if (err < 0) {
-		audio_error
-			(" pcm_lib_malloc failed to allocated pages for buffers\n");
-		return err;
-	}
-
-	alsa_stream->channels = params_channels(params);
-	alsa_stream->params_rate = params_rate(params);
-	alsa_stream->pcm_format_width = snd_pcm_format_width(params_format(params));
-
-	return err;
+	return snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
 }
 
 /* hw_free callback */
@@ -248,11 +233,11 @@ static int snd_bcm2835_pcm_prepare(struct snd_pcm_substream *substream)
 	if (chip->spdif_status & IEC958_AES0_NONAUDIO)
 		channels = 0;
 	else
-		channels = alsa_stream->channels;
+		channels = runtime->channels;
 
 	err = bcm2835_audio_set_params(alsa_stream, channels,
-		alsa_stream->params_rate,
-		alsa_stream->pcm_format_width);
+				       runtime->rate,
+				       snd_pcm_format_width(runtime->format));
 	if (err < 0)
 		audio_error(" error setting hw params\n");
 
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
index 20f5ff1649e6..3bf128422a6f 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
@@ -121,10 +121,6 @@ struct bcm2835_alsa_stream {
 
 	int draining;
 
-	int channels;
-	int params_rate;
-	int pcm_format_width;
-
 	unsigned int pos;
 	unsigned int buffer_size;
 	unsigned int period_size;
-- 
2.18.0

