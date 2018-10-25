Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD5FECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B1F214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmUcruxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B1F214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbeJYWxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:53:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730386AbeJYWxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:53:53 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 872DF2147A;
        Thu, 25 Oct 2018 14:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477254;
        bh=Byhz7nX39/f+AmWT+fqogC1cAKyNTyJW2rwSHlSsjO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SmUcruxdwzuZM1prNcTMH1XWF8MO17Oeue1TuPtnsrXJkenPY7dPv2lP9xof2gAaG
         JdXxs/7ZVtfbgi9+WIywkCrmxJBmEdh8zMRWfw7kUzBCQBl7OJKmH7RUFQeNjWQdbZ
         fh0oQherOxBgqD5TKLxQLRiz0Z2FLAoIgRGFO/wY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Anssi Hannula <anssi.hannula@iki.fi>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 79/98] ALSA: usb-audio: Add a more accurate volume quirk for AudioQuest DragonFly
Date:   Thu, 25 Oct 2018 10:18:34 -0400
Message-Id: <20181025141853.214051-79-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anssi Hannula <anssi.hannula@iki.fi>

[ Upstream commit 42e3121d90f42e57f6dbd6083dff2f57b3ec7daa ]

AudioQuest DragonFly DAC reports a volume control range of 0..50
(0x0000..0x0032) which in USB Audio means a range of 0 .. 0.2dB, which
is obviously incorrect and would cause software using the dB information
in e.g. volume sliders to have a massive volume difference in 100..102%
range.

Commit 2d1cb7f658fb ("ALSA: usb-audio: add dB range mapping for some
devices") added a dB range mapping for it with range 0..50 dB.

However, the actual volume mapping seems to be neither linear volume nor
linear dB scale, but instead quite close to the cubic mapping e.g.
alsamixer uses, with a range of approx. -53...0 dB.

Replace the previous quirk with a custom dB mapping based on some basic
output measurements, using a 10-item range TLV (which will still fit in
alsa-lib MAX_TLV_RANGE_SIZE).

Tested on AudioQuest DragonFly HW v1.2. The quirk is only applied if the
range is 0..50, so if this gets fixed/changed in later HW revisions it
will no longer be applied.

v2: incorporated Takashi Iwai's suggestion for the quirk application
method

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer.c        |  2 ++
 sound/usb/mixer_maps.c   | 12 ------------
 sound/usb/mixer_quirks.c | 37 +++++++++++++++++++++++++++++++++++++
 sound/usb/mixer_quirks.h |  4 ++++
 4 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 8d90cc5faf88..44812e4a4890 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1347,6 +1347,8 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
 		}
 	}
 
+	snd_usb_mixer_fu_apply_quirk(state->mixer, cval, unitid, kctl);
+
 	range = (cval->max - cval->min) / cval->res;
 	/*
 	 * Are there devices with volume range more than 255? I use a bit more
diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index 2f075cd27344..f0f526ca86e5 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -343,13 +343,6 @@ static struct usbmix_name_map bose_companion5_map[] = {
 	{ 0 }	/* terminator */
 };
 
-/* Dragonfly DAC 1.2, the dB conversion factor is 1 instead of 256 */
-static struct usbmix_dB_map dragonfly_1_2_dB = {0, 5000};
-static struct usbmix_name_map dragonfly_1_2_map[] = {
-	{ 7, NULL, .dB = &dragonfly_1_2_dB },
-	{ 0 }	/* terminator */
-};
-
 /*
  * Dell usb dock with ALC4020 codec had a firmware problem where it got
  * screwed up when zero volume is passed; just skip it as a workaround
@@ -478,11 +471,6 @@ static struct usbmix_ctl_map usbmix_ctl_maps[] = {
 		.id = USB_ID(0x05a7, 0x1020),
 		.map = bose_companion5_map,
 	},
-	{
-		/* Dragonfly DAC 1.2 */
-		.id = USB_ID(0x21b4, 0x0081),
-		.map = dragonfly_1_2_map,
-	},
 	{ 0 } /* terminator */
 };
 
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 524366f9d32d..05df7a75a2ea 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -37,6 +37,7 @@
 #include <sound/control.h>
 #include <sound/hwdep.h>
 #include <sound/info.h>
+#include <sound/tlv.h>
 
 #include "usbaudio.h"
 #include "mixer.h"
@@ -1711,3 +1712,39 @@ void snd_usb_mixer_rc_memory_change(struct usb_mixer_interface *mixer,
 	}
 }
 
+static void snd_dragonfly_quirk_db_scale(struct usb_mixer_interface *mixer,
+					 struct snd_kcontrol *kctl)
+{
+	/* Approximation using 10 ranges based on output measurement on hw v1.2.
+	 * This seems close to the cubic mapping e.g. alsamixer uses. */
+	static const DECLARE_TLV_DB_RANGE(scale,
+		 0,  1, TLV_DB_MINMAX_ITEM(-5300, -4970),
+		 2,  5, TLV_DB_MINMAX_ITEM(-4710, -4160),
+		 6,  7, TLV_DB_MINMAX_ITEM(-3884, -3710),
+		 8, 14, TLV_DB_MINMAX_ITEM(-3443, -2560),
+		15, 16, TLV_DB_MINMAX_ITEM(-2475, -2324),
+		17, 19, TLV_DB_MINMAX_ITEM(-2228, -2031),
+		20, 26, TLV_DB_MINMAX_ITEM(-1910, -1393),
+		27, 31, TLV_DB_MINMAX_ITEM(-1322, -1032),
+		32, 40, TLV_DB_MINMAX_ITEM(-968, -490),
+		41, 50, TLV_DB_MINMAX_ITEM(-441, 0),
+	);
+
+	usb_audio_info(mixer->chip, "applying DragonFly dB scale quirk\n");
+	kctl->tlv.p = scale;
+	kctl->vd[0].access |= SNDRV_CTL_ELEM_ACCESS_TLV_READ;
+	kctl->vd[0].access &= ~SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK;
+}
+
+void snd_usb_mixer_fu_apply_quirk(struct usb_mixer_interface *mixer,
+				  struct usb_mixer_elem_info *cval, int unitid,
+				  struct snd_kcontrol *kctl)
+{
+	switch (mixer->chip->usb_id) {
+	case USB_ID(0x21b4, 0x0081): /* AudioQuest DragonFly */
+		if (unitid == 7 && cval->min == 0 && cval->max == 50)
+			snd_dragonfly_quirk_db_scale(mixer, kctl);
+		break;
+	}
+}
+
diff --git a/sound/usb/mixer_quirks.h b/sound/usb/mixer_quirks.h
index bdbfab093816..177c329cd4dd 100644
--- a/sound/usb/mixer_quirks.h
+++ b/sound/usb/mixer_quirks.h
@@ -9,5 +9,9 @@ void snd_emuusb_set_samplerate(struct snd_usb_audio *chip,
 void snd_usb_mixer_rc_memory_change(struct usb_mixer_interface *mixer,
 				    int unitid);
 
+void snd_usb_mixer_fu_apply_quirk(struct usb_mixer_interface *mixer,
+				  struct usb_mixer_elem_info *cval, int unitid,
+				  struct snd_kcontrol *kctl);
+
 #endif /* SND_USB_MIXER_QUIRKS_H */
 
-- 
2.17.1

