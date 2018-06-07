Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id MtbaCoQ/GVv0WgAAmS7hNA
	; Thu, 07 Jun 2018 14:22:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 73E346089E; Thu,  7 Jun 2018 14:22:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BEEA66063F;
	Thu,  7 Jun 2018 14:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BEEA66063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933574AbeFGOWC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:22:02 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39436 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933073AbeFGOJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:10 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbA-0005Zw-Jw; Thu, 07 Jun 2018 15:09:08 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb7-00033D-Br; Thu, 07 Jun 2018 15:09:05 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Jan-Marek Glogowski" <glogow@fbihome.de>,
        "Takashi Iwai" <tiwai@suse.de>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.496576521@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 232/410] ALSA: hda/realtek: PCI quirk for Fujitsu U7x7
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jan-Marek Glogowski <glogow@fbihome.de>

commit fdcc968a3b290407bcba9d4c90e2fba6d8d928f1 upstream.

These laptops have a combined jack to attach headsets, the U727 on
the left, the U757 on the right, but a headsets microphone doesn't
work. Using hdajacksensetest I found that pin 0x19 changed the
present state when plugging the headset, in addition to 0x21, but
didn't have the correct configuration (shown as "Not connected").

So this sets the configuration to the same values as the headphone
pin 0x21 except for the device type microphone, which makes it
work correctly. With the patch the configured pins for U727 are

Pin 0x12 (Internal Mic, Mobile-In): present = No
Pin 0x14 (Internal Speaker): present = No
Pin 0x19 (Black Mic, Left side): present = No
Pin 0x1d (Internal Aux): present = No
Pin 0x21 (Black Headphone, Left side): present = No

Signed-off-by: Jan-Marek Glogowski <glogow@fbihome.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/pci/hda/patch_realtek.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3289,6 +3289,19 @@ static void alc269_fixup_pincfg_no_hp_to
 		spec->parse_flags = HDA_PINCFG_NO_HP_FIXUP;
 }
 
+static void alc269_fixup_pincfg_U7x7_headset_mic(struct hda_codec *codec,
+						 const struct hda_fixup *fix,
+						 int action)
+{
+	unsigned int cfg_headphone = snd_hda_codec_get_pincfg(codec, 0x21);
+	unsigned int cfg_headset_mic = snd_hda_codec_get_pincfg(codec, 0x19);
+
+	if (cfg_headphone && cfg_headset_mic == 0x411111f0)
+		snd_hda_codec_set_pincfg(codec, 0x19,
+			(cfg_headphone & ~AC_DEFCFG_DEVICE) |
+			(AC_JACK_MIC_IN << AC_DEFCFG_DEVICE_SHIFT));
+}
+
 static void alc269_fixup_hweq(struct hda_codec *codec,
 			       const struct hda_fixup *fix, int action)
 {
@@ -4292,6 +4305,7 @@ enum {
 	ALC269_FIXUP_LIFEBOOK_EXTMIC,
 	ALC269_FIXUP_LIFEBOOK_HP_PIN,
 	ALC269_FIXUP_LIFEBOOK_NO_HP_TO_LINEOUT,
+	ALC255_FIXUP_LIFEBOOK_U7x7_HEADSET_MIC,
 	ALC269_FIXUP_AMIC,
 	ALC269_FIXUP_DMIC,
 	ALC269VB_FIXUP_AMIC,
@@ -4456,6 +4470,10 @@ static const struct hda_fixup alc269_fix
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_pincfg_no_hp_to_lineout,
 	},
+	[ALC255_FIXUP_LIFEBOOK_U7x7_HEADSET_MIC] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc269_fixup_pincfg_U7x7_headset_mic,
+	},
 	[ALC269_FIXUP_AMIC] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -4996,6 +5014,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x10cf, 0x159f, "Lifebook E780", ALC269_FIXUP_LIFEBOOK_NO_HP_TO_LINEOUT),
 	SND_PCI_QUIRK(0x10cf, 0x15dc, "Lifebook T731", ALC269_FIXUP_LIFEBOOK_HP_PIN),
 	SND_PCI_QUIRK(0x10cf, 0x1757, "Lifebook E752", ALC269_FIXUP_LIFEBOOK_HP_PIN),
+	SND_PCI_QUIRK(0x10cf, 0x1629, "Lifebook U7x7", ALC255_FIXUP_LIFEBOOK_U7x7_HEADSET_MIC),
 	SND_PCI_QUIRK(0x10cf, 0x1845, "Lifebook U904", ALC269_FIXUP_LIFEBOOK_EXTMIC),
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Thinkpad SL410/510", ALC269_FIXUP_SKU_IGNORE),
 	SND_PCI_QUIRK(0x17aa, 0x215e, "Thinkpad L512", ALC269_FIXUP_SKU_IGNORE),
