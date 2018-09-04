Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6B6C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1668220645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1668220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeIDU04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:26:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:50974 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727665AbeIDUYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:24:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E487EB0A3;
        Tue,  4 Sep 2018 15:59:01 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/29] staging: bcm2835-audio: Remove superfluous open flag
Date:   Tue,  4 Sep 2018 17:58:36 +0200
Message-Id: <20180904155858.8001-8-tiwai@suse.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904155858.8001-1-tiwai@suse.de>
References: <20180904155858.8001-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the alsa_stream->open flag checks in the current code are
redundant, and they cannot be racy.  For the code simplification,
let's remove the flag and its check.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../staging/vc04_services/bcm2835-audio/bcm2835-pcm.c    | 9 ++-------
 drivers/staging/vc04_services/bcm2835-audio/bcm2835.h    | 1 -
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index a3ab5bfea08a..2c2b6b70df63 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -57,8 +57,7 @@ void bcm2835_playback_fifo(struct bcm2835_alsa_stream *alsa_stream)
 	audio_info("alsa_stream=%p substream=%p\n", alsa_stream,
 		alsa_stream ? alsa_stream->substream : 0);
 
-	if (alsa_stream->open)
-		consumed = bcm2835_audio_retrieve_buffers(alsa_stream);
+	consumed = bcm2835_audio_retrieve_buffers(alsa_stream);
 
 	/* We get called only if playback was triggered, So, the number of buffers we retrieve in
 	 * each iteration are the buffers that have been played out already
@@ -154,7 +153,6 @@ static int snd_bcm2835_playback_open_generic(
 	chip->alsa_stream[idx] = alsa_stream;
 
 	chip->opened |= (1 << idx);
-	alsa_stream->open = 1;
 	alsa_stream->draining = 1;
 
 out:
@@ -205,10 +203,7 @@ static int snd_bcm2835_playback_close(struct snd_pcm_substream *substream)
 	alsa_stream->period_size = 0;
 	alsa_stream->buffer_size = 0;
 
-	if (alsa_stream->open) {
-		alsa_stream->open = 0;
-		bcm2835_audio_close(alsa_stream);
-	}
+	bcm2835_audio_close(alsa_stream);
 	if (alsa_stream->chip)
 		alsa_stream->chip->alsa_stream[alsa_stream->idx] = NULL;
 	/*
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
index d2441916960d..79363260ae34 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
@@ -121,7 +121,6 @@ struct bcm2835_alsa_stream {
 
 	spinlock_t lock;
 
-	int open;
 	int running;
 	int draining;
 
-- 
2.18.0

