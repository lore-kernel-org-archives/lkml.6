Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D39ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB09208FC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB09208FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbeGPJTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:19:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43181 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730116AbeGPJTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:19:23 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fezFY-0002vE-EE; Mon, 16 Jul 2018 08:52:56 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: sb8: remove redundant pointer runtime
Date:   Mon, 16 Jul 2018 09:52:56 +0100
Message-Id: <20180716085256.15878-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer runtime is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'runtime' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/isa/sb/sb8_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/isa/sb/sb8_main.c b/sound/isa/sb/sb8_main.c
index d45df5c54423..80e7dcaa551f 100644
--- a/sound/isa/sb/sb8_main.c
+++ b/sound/isa/sb/sb8_main.c
@@ -381,7 +381,6 @@ static int snd_sb8_capture_trigger(struct snd_pcm_substream *substream,
 irqreturn_t snd_sb8dsp_interrupt(struct snd_sb *chip)
 {
 	struct snd_pcm_substream *substream;
-	struct snd_pcm_runtime *runtime;
 
 	snd_sb_ack_8bit(chip);
 	switch (chip->mode) {
@@ -391,7 +390,6 @@ irqreturn_t snd_sb8dsp_interrupt(struct snd_sb *chip)
 		/* fallthru */
 	case SB_MODE_PLAYBACK_8:
 		substream = chip->playback_substream;
-		runtime = substream->runtime;
 		if (chip->playback_format == SB_DSP_OUTPUT)
 		    	snd_sb8_playback_trigger(substream, SNDRV_PCM_TRIGGER_START);
 		snd_pcm_period_elapsed(substream);
@@ -402,7 +400,6 @@ irqreturn_t snd_sb8dsp_interrupt(struct snd_sb *chip)
 		/* fallthru */
 	case SB_MODE_CAPTURE_8:
 		substream = chip->capture_substream;
-		runtime = substream->runtime;
 		if (chip->capture_format == SB_DSP_INPUT)
 		    	snd_sb8_capture_trigger(substream, SNDRV_PCM_TRIGGER_START);
 		snd_pcm_period_elapsed(substream);
-- 
2.17.1

