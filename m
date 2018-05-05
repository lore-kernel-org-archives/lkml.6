Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752049AbeEETGr (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 15:06:47 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:44521 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751825AbeEETEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 15:04:09 -0400
X-Google-Smtp-Source: AB8JxZokXi3vPqv9KRD7zQdsqE7Ili3SfZ7WvT8v5Zk78o+77SU3aFRu358nItTVjkHAbbetaVZqpg==
From: Connor McAdams <conmanx360@gmail.com>
Cc: o-takashi@sakamocchi.jp, Connor McAdams <conmanx360@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?q?J=C3=A9r=C3=A9my=20Lefaure?=
        <jeremy.lefaure@lse.epita.fr>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/9] ALSA: hda/ca0132: Add pincfg for SBZ + R3Di, add fp hp auto-detect
Date: Sat,  5 May 2018 15:03:13 -0400
Message-Id: <1525547001-17588-3-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525547001-17588-1-git-send-email-conmanx360@gmail.com>
References: <1525547001-17588-1-git-send-email-conmanx360@gmail.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an unsolicited response tag for the front headphone
panel which uses the same hp_callback as the rear headphone detection.

This patch also adds pincfgs for the R3Di and SBZ which were taken from
the Windows driver. The pins are also defined in the function
ca0132_config. Both the R3Di and SBZ are also given a max out channel
value of 6 to handle 5.1 surround sound in later patches.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 111 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 108 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 8346100..02238fe 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -723,6 +723,7 @@ struct ca0132_spec {
 	hda_nid_t shared_mic_nid;
 	hda_nid_t shared_out_nid;
 	hda_nid_t unsol_tag_hp;
+	hda_nid_t unsol_tag_front_hp; /* for desktop ca0132 codecs */
 	hda_nid_t unsol_tag_amic1;
 
 	/* chip access */
@@ -785,6 +786,36 @@ static const struct hda_pintbl alienware_pincfgs[] = {
 	{}
 };
 
+/* Sound Blaster Z pin configs taken from Windows Driver */
+static const struct hda_pintbl sbz_pincfgs[] = {
+	{ 0x0b, 0x01017010 }, /* Port G -- Lineout FRONT L/R */
+	{ 0x0c, 0x014510f0 }, /* SPDIF Out 1 */
+	{ 0x0d, 0x014510f0 }, /* Digital Out */
+	{ 0x0e, 0x01c510f0 }, /* SPDIF In */
+	{ 0x0f, 0x0221701f }, /* Port A -- BackPanel HP */
+	{ 0x10, 0x01017012 }, /* Port D -- Center/LFE or FP Hp */
+	{ 0x11, 0x01017014 }, /* Port B -- LineMicIn2 / Rear L/R */
+	{ 0x12, 0x01a170f0 }, /* Port C -- LineIn1 */
+	{ 0x13, 0x908700f0 }, /* What U Hear In*/
+	{ 0x18, 0x50d000f0 }, /* N/A */
+	{}
+};
+
+/* Recon3D integrated pin configs taken from Windows Driver */
+static const struct hda_pintbl r3di_pincfgs[] = {
+	{ 0x0b, 0x01014110 }, /* Port G -- Lineout FRONT L/R */
+	{ 0x0c, 0x014510f0 }, /* SPDIF Out 1 */
+	{ 0x0d, 0x014510f0 }, /* Digital Out */
+	{ 0x0e, 0x41c520f0 }, /* SPDIF In */
+	{ 0x0f, 0x0221401f }, /* Port A -- BackPanel HP */
+	{ 0x10, 0x01016011 }, /* Port D -- Center/LFE or FP Hp */
+	{ 0x11, 0x01011014 }, /* Port B -- LineMicIn2 / Rear L/R */
+	{ 0x12, 0x02a090f0 }, /* Port C -- LineIn1 */
+	{ 0x13, 0x908700f0 }, /* What U Hear In*/
+	{ 0x18, 0x500000f0 }, /* N/A */
+	{}
+};
+
 static const struct snd_pci_quirk ca0132_quirks[] = {
 	SND_PCI_QUIRK(0x1028, 0x0685, "Alienware 15 2015", QUIRK_ALIENWARE),
 	SND_PCI_QUIRK(0x1028, 0x0688, "Alienware 17 2015", QUIRK_ALIENWARE),
@@ -4503,6 +4534,10 @@ static void ca0132_init_unsol(struct hda_codec *codec)
 					    amic_callback);
 	snd_hda_jack_detect_enable_callback(codec, UNSOL_TAG_DSP,
 					    ca0132_process_dsp_response);
+	/* Front headphone jack detection */
+	if (spec->quirk == QUIRK_SBZ || spec->quirk == QUIRK_R3DI)
+		snd_hda_jack_detect_enable_callback(codec,
+			spec->unsol_tag_front_hp, hp_callback);
 }
 
 /*
@@ -4684,9 +4719,14 @@ static void ca0132_config(struct hda_codec *codec)
 
 	spec->multiout.dac_nids = spec->dacs;
 	spec->multiout.num_dacs = 3;
-	spec->multiout.max_channels = 2;
 
-	if (spec->quirk == QUIRK_ALIENWARE) {
+	if (spec->quirk == QUIRK_NONE || spec->quirk == QUIRK_ALIENWARE)
+		spec->multiout.max_channels = 2;
+	else
+		spec->multiout.max_channels = 6;
+
+	switch (spec->quirk) {
+	case QUIRK_ALIENWARE:
 		codec_dbg(codec, "ca0132_config: QUIRK_ALIENWARE applied.\n");
 		snd_hda_apply_pincfgs(codec, alienware_pincfgs);
 
@@ -4706,7 +4746,71 @@ static void ca0132_config(struct hda_codec *codec)
 		spec->input_pins[2] = 0x13;
 		spec->shared_mic_nid = 0x7;
 		spec->unsol_tag_amic1 = 0x11;
-	} else {
+		break;
+	case QUIRK_SBZ:
+		codec_dbg(codec, "%s: QUIRK_SBZ applied.\n", __func__);
+		snd_hda_apply_pincfgs(codec, sbz_pincfgs);
+
+		spec->num_outputs = 2;
+		spec->out_pins[0] = 0x0B; /* Line out */
+		spec->out_pins[1] = 0x0F; /* Rear headphone out */
+		spec->out_pins[2] = 0x10; /* Front Headphone / Center/LFE*/
+		spec->out_pins[3] = 0x11; /* Rear surround */
+		spec->shared_out_nid = 0x2;
+		spec->unsol_tag_hp = spec->out_pins[1];
+		spec->unsol_tag_front_hp = spec->out_pins[2];
+
+		spec->adcs[0] = 0x7; /* Rear Mic / Line-in */
+		spec->adcs[1] = 0x8; /* Front Mic, but only if no DSP */
+		spec->adcs[2] = 0xa; /* what u hear */
+
+		spec->num_inputs = 2;
+		spec->input_pins[0] = 0x12; /* Rear Mic / Line-in */
+		spec->input_pins[1] = 0x13; /* What U Hear */
+		spec->shared_mic_nid = 0x7;
+		spec->unsol_tag_amic1 = spec->input_pins[0];
+
+		/* SPDIF I/O */
+		spec->dig_out = 0x05;
+		spec->multiout.dig_out_nid = spec->dig_out;
+		cfg->dig_out_pins[0] = 0x0c;
+		cfg->dig_outs = 1;
+		cfg->dig_out_type[0] = HDA_PCM_TYPE_SPDIF;
+		spec->dig_in = 0x09;
+		cfg->dig_in_pin = 0x0e;
+		cfg->dig_in_type = HDA_PCM_TYPE_SPDIF;
+		break;
+	case QUIRK_R3DI:
+		codec_dbg(codec, "%s: QUIRK_R3DI applied.\n", __func__);
+		snd_hda_apply_pincfgs(codec, r3di_pincfgs);
+
+		spec->num_outputs = 2;
+		spec->out_pins[0] = 0x0B; /* Line out */
+		spec->out_pins[1] = 0x0F; /* Rear headphone out */
+		spec->out_pins[2] = 0x10; /* Front Headphone / Center/LFE*/
+		spec->out_pins[3] = 0x11; /* Rear surround */
+		spec->shared_out_nid = 0x2;
+		spec->unsol_tag_hp = spec->out_pins[1];
+		spec->unsol_tag_front_hp = spec->out_pins[2];
+
+		spec->adcs[0] = 0x07; /* Rear Mic / Line-in */
+		spec->adcs[1] = 0x08; /* Front Mic, but only if no DSP */
+		spec->adcs[2] = 0x0a; /* what u hear */
+
+		spec->num_inputs = 2;
+		spec->input_pins[0] = 0x12; /* Rear Mic / Line-in */
+		spec->input_pins[1] = 0x13; /* What U Hear */
+		spec->shared_mic_nid = 0x7;
+		spec->unsol_tag_amic1 = spec->input_pins[0];
+
+		/* SPDIF I/O */
+		spec->dig_out = 0x05;
+		spec->multiout.dig_out_nid = spec->dig_out;
+		cfg->dig_out_pins[0] = 0x0c;
+		cfg->dig_outs = 1;
+		cfg->dig_out_type[0] = HDA_PCM_TYPE_SPDIF;
+		break;
+	default:
 		spec->num_outputs = 2;
 		spec->out_pins[0] = 0x0b; /* speaker out */
 		spec->out_pins[1] = 0x10; /* headphone out */
@@ -4733,6 +4837,7 @@ static void ca0132_config(struct hda_codec *codec)
 		spec->dig_in = 0x09;
 		cfg->dig_in_pin = 0x0e;
 		cfg->dig_in_type = HDA_PCM_TYPE_SPDIF;
+		break;
 	}
 }
 
-- 
2.7.4
