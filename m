Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754068AbeEHCgM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 22:36:12 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:51541 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753904AbeEHCcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 22:32:04 -0400
X-Google-Smtp-Source: AB8JxZp8tfrD9xfdzxsn9R8s8cy8W8Qok7rUd2gofXv1rTdiiNHHaGZHEkYO/bFtV0LcM+rw/1U5IA==
From: Connor McAdams <conmanx360@gmail.com>
Cc: o-takashi@sakamocchi.jp, Connor McAdams <conmanx360@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?q?J=C3=A9r=C3=A9my=20Lefaure?=
        <jeremy.lefaure@lse.epita.fr>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/13] ALSA: hda/ca0132: R3Di and SBZ quirk entires + alt firmware loading
Date: Mon,  7 May 2018 22:31:09 -0400
Message-Id: <1525746683-18535-2-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525746683-18535-1-git-send-email-conmanx360@gmail.com>
References: <1525746683-18535-1-git-send-email-conmanx360@gmail.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds PCI quirk ID's for the Sound Blaster Z and Recon3Di.
Only the currently tested ID's have been added.

This patch also adds the ability to load alternative firmwares for each
card, the firmwares can be obtained from within the Windows driver.
The Recon3Di uses "ctefx-r3di.bin" and the Sound Blaster Z uses
"ctefx-sbz.bin". If the alternative firmware for the given quirk is not
found, the original ctefx.bin will be used. This has been confirmed to
work for both the R3Di and the SBZ.

This patch also makes the character array *dirstr a const.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 61 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 768ea86..8346100 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -72,12 +72,16 @@
 #define SCP_GET    1
 
 #define EFX_FILE   "ctefx.bin"
+#define SBZ_EFX_FILE   "ctefx-sbz.bin"
+#define R3DI_EFX_FILE  "ctefx-r3di.bin"
 
 #ifdef CONFIG_SND_HDA_CODEC_CA0132_DSP
 MODULE_FIRMWARE(EFX_FILE);
+MODULE_FIRMWARE(SBZ_EFX_FILE);
+MODULE_FIRMWARE(R3DI_EFX_FILE);
 #endif
 
-static char *dirstr[2] = { "Playback", "Capture" };
+static const char *dirstr[2] = { "Playback", "Capture" };
 
 enum {
 	SPEAKER_OUT,
@@ -734,6 +738,7 @@ struct ca0132_spec {
 	unsigned int scp_resp_header;
 	unsigned int scp_resp_data[4];
 	unsigned int scp_resp_count;
+	bool alt_firmware_present;
 
 	/* mixer and effects related */
 	unsigned char dmic_ctl;
@@ -762,6 +767,8 @@ struct ca0132_spec {
 enum {
 	QUIRK_NONE,
 	QUIRK_ALIENWARE,
+	QUIRK_SBZ,
+	QUIRK_R3DI,
 };
 
 static const struct hda_pintbl alienware_pincfgs[] = {
@@ -782,6 +789,10 @@ static const struct snd_pci_quirk ca0132_quirks[] = {
 	SND_PCI_QUIRK(0x1028, 0x0685, "Alienware 15 2015", QUIRK_ALIENWARE),
 	SND_PCI_QUIRK(0x1028, 0x0688, "Alienware 17 2015", QUIRK_ALIENWARE),
 	SND_PCI_QUIRK(0x1028, 0x0708, "Alienware 15 R2 2016", QUIRK_ALIENWARE),
+	SND_PCI_QUIRK(0x1102, 0x0010, "Sound Blaster Z", QUIRK_SBZ),
+	SND_PCI_QUIRK(0x1102, 0x0023, "Sound Blaster Z", QUIRK_SBZ),
+	SND_PCI_QUIRK(0x1458, 0xA016, "Recon3Di", QUIRK_R3DI),
+	SND_PCI_QUIRK(0x1458, 0xA036, "Recon3Di", QUIRK_R3DI),
 	{}
 };
 
@@ -3207,7 +3218,7 @@ static int ca0132_select_out(struct hda_codec *codec)
 				    pin_ctl & ~PIN_HP);
 		/* enable speaker node */
 		pin_ctl = snd_hda_codec_read(codec, spec->out_pins[0], 0,
-					     AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+				AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
 		snd_hda_set_pin_ctl(codec, spec->out_pins[0],
 				    pin_ctl | PIN_OUT);
 	} else {
@@ -4370,11 +4381,49 @@ static void ca0132_set_dsp_msr(struct hda_codec *codec, bool is96k)
 static bool ca0132_download_dsp_images(struct hda_codec *codec)
 {
 	bool dsp_loaded = false;
+	struct ca0132_spec *spec = codec->spec;
 	const struct dsp_image_seg *dsp_os_image;
 	const struct firmware *fw_entry;
-
-	if (request_firmware(&fw_entry, EFX_FILE, codec->card->dev) != 0)
-		return false;
+	/*
+	 * Alternate firmwares for different variants. The Recon3Di apparently
+	 * can use the default firmware, but I'll leave the option in case
+	 * it needs it again.
+	 */
+	switch (spec->quirk) {
+	case QUIRK_SBZ:
+		if (request_firmware(&fw_entry, SBZ_EFX_FILE,
+					codec->card->dev) != 0) {
+			codec_dbg(codec, "SBZ alt firmware not detected. ");
+			spec->alt_firmware_present = false;
+		} else {
+			codec_dbg(codec, "Sound Blaster Z firmware selected.");
+			spec->alt_firmware_present = true;
+		}
+		break;
+	case QUIRK_R3DI:
+		if (request_firmware(&fw_entry, R3DI_EFX_FILE,
+					codec->card->dev) != 0) {
+			codec_dbg(codec, "Recon3Di alt firmware not detected.");
+			spec->alt_firmware_present = false;
+		} else {
+			codec_dbg(codec, "Recon3Di firmware selected.");
+			spec->alt_firmware_present = true;
+		}
+		break;
+	default:
+		spec->alt_firmware_present = false;
+		break;
+	}
+	/*
+	 * Use default ctefx.bin if no alt firmware is detected, or if none
+	 * exists for your particular codec.
+	 */
+	if (!spec->alt_firmware_present) {
+		codec_dbg(codec, "Default firmware selected.");
+		if (request_firmware(&fw_entry, EFX_FILE,
+					codec->card->dev) != 0)
+			return false;
+	}
 
 	dsp_os_image = (struct dsp_image_seg *)(fw_entry->data);
 	if (dspload_image(codec, dsp_os_image, 0, 0, true, 0)) {
@@ -4476,7 +4525,7 @@ static struct hda_verb ca0132_base_exit_verbs[] = {
 	{}
 };
 
-/* Other verbs tables.  Sends after DSP download. */
+/* Other verbs tables. Sends after DSP download. */
 static struct hda_verb ca0132_init_verbs0[] = {
 	/* chip init verbs */
 	{0x15, 0x70D, 0xF0},
-- 
2.7.4
