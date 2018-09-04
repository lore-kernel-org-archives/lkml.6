Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274C5C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCAB320645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCAB320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbeIDUZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:25:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:51058 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727791AbeIDUYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:24:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D8DE4B0B4;
        Tue,  4 Sep 2018 15:59:02 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 25/29] staging: bcm2835-audio: Use coherent device buffers
Date:   Tue,  4 Sep 2018 17:58:54 +0200
Message-Id: <20180904155858.8001-26-tiwai@suse.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904155858.8001-1-tiwai@suse.de>
References: <20180904155858.8001-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory access to the pages allocated with
SNDRV_DMA_TYPE_CONTINUOUS are basically non-coherent, and it becomes a
problem when a process accesses via mmap.

For the more consistent access, use the device coherent memory, just
by replacing the call pattern in the allocator helpers.

The only point we need to be careful for is the device object passed
there; since bcm2835-audio driver creates fake devices and each card
is created on top of that, we need to pass its parent device as the
real device object.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../vc04_services/bcm2835-audio/bcm2835-pcm.c        | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index d2373e4a4d53..8b8e286587cb 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -345,8 +345,8 @@ int snd_bcm2835_new_pcm(struct bcm2835_chip *chip, u32 numchannels)
 
 	/* pre-allocation of buffers */
 	/* NOTE: this may fail */
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
-					      snd_dma_continuous_data(GFP_KERNEL),
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+					      chip->card->dev->parent,
 					      snd_bcm2835_playback_hw.buffer_bytes_max,
 					      snd_bcm2835_playback_hw.buffer_bytes_max);
 
@@ -371,8 +371,8 @@ int snd_bcm2835_new_spdif_pcm(struct bcm2835_chip *chip)
 
 	/* pre-allocation of buffers */
 	/* NOTE: this may fail */
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
-		snd_dma_continuous_data(GFP_KERNEL),
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+		chip->card->dev->parent,
 		snd_bcm2835_playback_spdif_hw.buffer_bytes_max, snd_bcm2835_playback_spdif_hw.buffer_bytes_max);
 
 	return 0;
@@ -404,8 +404,8 @@ int snd_bcm2835_new_simple_pcm(struct bcm2835_chip *chip,
 
 	snd_pcm_lib_preallocate_pages_for_all(
 		pcm,
-		SNDRV_DMA_TYPE_CONTINUOUS,
-		snd_dma_continuous_data(GFP_KERNEL),
+		SNDRV_DMA_TYPE_DEV,
+		chip->card->dev->parent,
 		snd_bcm2835_playback_hw.buffer_bytes_max,
 		snd_bcm2835_playback_hw.buffer_bytes_max);
 
-- 
2.18.0

