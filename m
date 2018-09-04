Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544AFC4321E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A1020645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A1020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbeIDUYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:24:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:50960 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727615AbeIDUYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:24:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D88D1B0A2;
        Tue,  4 Sep 2018 15:59:01 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/29] staging: bcm2835-audio: Remove redundant function calls
Date:   Tue,  4 Sep 2018 17:58:35 +0200
Message-Id: <20180904155858.8001-7-tiwai@suse.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904155858.8001-1-tiwai@suse.de>
References: <20180904155858.8001-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bcm2835_audio_setup(), bcm2835_audio_flush_buffers() and
bcm2835_audio_flush_playback_buffers() functions do implement
nothing.

Also, bcm2835_audio_set_ctls() is already called inside
bcm2835_audio_set_params(), so the later call is superfluous.

This patch removes these superfluous implementations.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../vc04_services/bcm2835-audio/bcm2835-pcm.c |  5 -----
 .../bcm2835-audio/bcm2835-vchiq.c             | 21 -------------------
 .../vc04_services/bcm2835-audio/bcm2835.h     |  3 ---
 3 files changed, 29 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index 9a79d2267df4..a3ab5bfea08a 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -277,11 +277,6 @@ static int snd_bcm2835_pcm_prepare(struct snd_pcm_substream *substream)
 	if (err < 0)
 		audio_error(" error setting hw params\n");
 
-	bcm2835_audio_setup(alsa_stream);
-
-	/* in preparation of the stream, set the controls (volume level) of the stream */
-	bcm2835_audio_set_ctls(alsa_stream);
-
 	memset(&alsa_stream->pcm_indirect, 0, sizeof(alsa_stream->pcm_indirect));
 
 	alsa_stream->pcm_indirect.hw_buffer_size =
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index 8684dc1d0b41..488e676e25e1 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -580,12 +580,6 @@ int bcm2835_audio_set_params(struct bcm2835_alsa_stream *alsa_stream,
 	return ret;
 }
 
-int bcm2835_audio_setup(struct bcm2835_alsa_stream *alsa_stream)
-{
-
-	return 0;
-}
-
 static int bcm2835_audio_start_worker(struct bcm2835_alsa_stream *alsa_stream)
 {
 	struct vc_audio_msg m;
@@ -774,21 +768,6 @@ static int bcm2835_audio_write_worker(struct bcm2835_alsa_stream *alsa_stream,
 	return ret;
 }
 
-/**
- * Returns all buffers from arm->vc
- */
-void bcm2835_audio_flush_buffers(struct bcm2835_alsa_stream *alsa_stream)
-{
-}
-
-/**
- * Forces VC to flush(drop) its filled playback buffers and
- * return them the us. (VC->ARM)
- */
-void bcm2835_audio_flush_playback_buffers(struct bcm2835_alsa_stream *alsa_stream)
-{
-}
-
 unsigned int bcm2835_audio_retrieve_buffers(struct bcm2835_alsa_stream *alsa_stream)
 {
 	unsigned int count = atomic_read(&alsa_stream->retrieved);
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
index 8ee25a837b08..d2441916960d 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
@@ -158,7 +158,6 @@ int bcm2835_audio_close(struct bcm2835_alsa_stream *alsa_stream);
 int bcm2835_audio_set_params(struct bcm2835_alsa_stream *alsa_stream,
 			     unsigned int channels, unsigned int samplerate,
 			     unsigned int bps);
-int bcm2835_audio_setup(struct bcm2835_alsa_stream *alsa_stream);
 int bcm2835_audio_start(struct bcm2835_alsa_stream *alsa_stream);
 int bcm2835_audio_stop(struct bcm2835_alsa_stream *alsa_stream);
 int bcm2835_audio_set_ctls(struct bcm2835_alsa_stream *alsa_stream);
@@ -167,7 +166,5 @@ int bcm2835_audio_write(struct bcm2835_alsa_stream *alsa_stream,
 			void *src);
 void bcm2835_playback_fifo(struct bcm2835_alsa_stream *alsa_stream);
 unsigned int bcm2835_audio_retrieve_buffers(struct bcm2835_alsa_stream *alsa_stream);
-void bcm2835_audio_flush_buffers(struct bcm2835_alsa_stream *alsa_stream);
-void bcm2835_audio_flush_playback_buffers(struct bcm2835_alsa_stream *alsa_stream);
 
 #endif /* __SOUND_ARM_BCM2835_H */
-- 
2.18.0

