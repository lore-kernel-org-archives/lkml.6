Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB702C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB5220645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB5220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeIDUYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:24:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:51014 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727715AbeIDUYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:24:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2D400B0A7;
        Tue,  4 Sep 2018 15:59:02 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/29] staging: bcm2835-audio: Drop unnecessary pcm indirect setup
Date:   Tue,  4 Sep 2018 17:58:41 +0200
Message-Id: <20180904155858.8001-13-tiwai@suse.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904155858.8001-1-tiwai@suse.de>
References: <20180904155858.8001-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hw_queue_size of PCM indirect helper doesn't need to be set up if
you use the whole given buffer size.  Drop the useless
initialization, which just confuses readers.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index a3605505cc20..c935c6e99633 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -280,7 +280,6 @@ static int snd_bcm2835_pcm_ack(struct snd_pcm_substream *substream)
 	struct bcm2835_alsa_stream *alsa_stream = runtime->private_data;
 	struct snd_pcm_indirect *pcm_indirect = &alsa_stream->pcm_indirect;
 
-	pcm_indirect->hw_queue_size = runtime->hw.buffer_bytes_max;
 	return snd_pcm_indirect_playback_transfer(substream, pcm_indirect,
 						  snd_bcm2835_pcm_transfer);
 }
-- 
2.18.0

