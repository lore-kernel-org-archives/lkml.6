Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62581C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24AC920843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24AC920843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeIDUYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:24:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:50766 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726367AbeIDUYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:24:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9C2BBB09E;
        Tue,  4 Sep 2018 15:59:01 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/29] staging: bcm2835-audio: Remove redundant spdif stream ctls
Date:   Tue,  4 Sep 2018 17:58:31 +0200
Message-Id: <20180904155858.8001-3-tiwai@suse.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904155858.8001-1-tiwai@suse.de>
References: <20180904155858.8001-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "IEC958 Playback Stream" control does basically the very same
thing as "IEC958 Playback Default" redundantly.  The former should
have been stream-specific and restored after closing the stream, but
we don't do in that way.

Since it's nothing but confusion, remove this fake.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../vc04_services/bcm2835-audio/bcm2835-ctl.c | 51 -------------------
 1 file changed, 51 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
index 04ea3ec7f64f..9020887e1ada 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
@@ -233,48 +233,6 @@ static int snd_bcm2835_spdif_mask_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static int snd_bcm2835_spdif_stream_info(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_info *uinfo)
-{
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
-	uinfo->count = 1;
-	return 0;
-}
-
-static int snd_bcm2835_spdif_stream_get(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	struct bcm2835_chip *chip = snd_kcontrol_chip(kcontrol);
-	int i;
-
-	mutex_lock(&chip->audio_mutex);
-
-	for (i = 0; i < 4; i++)
-		ucontrol->value.iec958.status[i] =
-		(chip->spdif_status >> (i * 8)) & 0xff;
-
-	mutex_unlock(&chip->audio_mutex);
-	return 0;
-}
-
-static int snd_bcm2835_spdif_stream_put(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	struct bcm2835_chip *chip = snd_kcontrol_chip(kcontrol);
-	unsigned int val = 0;
-	int i, change;
-
-	mutex_lock(&chip->audio_mutex);
-
-	for (i = 0; i < 4; i++)
-		val |= (unsigned int)ucontrol->value.iec958.status[i] << (i * 8);
-	change = val != chip->spdif_status;
-	chip->spdif_status = val;
-
-	mutex_unlock(&chip->audio_mutex);
-	return change;
-}
-
 static struct snd_kcontrol_new snd_bcm2835_spdif[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
@@ -290,15 +248,6 @@ static struct snd_kcontrol_new snd_bcm2835_spdif[] = {
 		.info = snd_bcm2835_spdif_mask_info,
 		.get = snd_bcm2835_spdif_mask_get,
 	},
-	{
-		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
-		SNDRV_CTL_ELEM_ACCESS_INACTIVE,
-		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
-		.name = SNDRV_CTL_NAME_IEC958("", PLAYBACK, PCM_STREAM),
-		.info = snd_bcm2835_spdif_stream_info,
-		.get = snd_bcm2835_spdif_stream_get,
-		.put = snd_bcm2835_spdif_stream_put,
-	},
 };
 
 int snd_bcm2835_new_ctl(struct bcm2835_chip *chip)
-- 
2.18.0

