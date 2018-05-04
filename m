Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbeEDEVz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 00:21:55 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52737 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751324AbeEDEUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 00:20:34 -0400
X-Google-Smtp-Source: AB8JxZpSqQHdIFvXTFPUumvK9XtzQJdQDyrGMli2l15Njzbt6ffy2/IkkZ3MRIXPhuIM7FD9MtCEOQ==
From: Connor McAdams <conmanx360@gmail.com>
Cc: o-takashi@sakamocchi.jp, Connor McAdams <conmanx360@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?q?J=C3=A9r=C3=A9my=20Lefaure?=
        <jeremy.lefaure@lse.epita.fr>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] Add extra exit functions for R3Di and SBZ
Date: Fri,  4 May 2018 00:19:47 -0400
Message-Id: <1525407594-25644-4-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525407594-25644-1-git-send-email-conmanx360@gmail.com>
References: <1525407594-25644-1-git-send-email-conmanx360@gmail.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds extra functions for shutdown on the Sound Blaster Z and
Recon3Di. The Recon3Di only has one specific functions, which sets the
GPIO data pins to 0 to prevent a popping noise.

The Sound Blaster Z exit sequence was taken from Windows. Without this
exit function, the card will not reload properly unless the PC has been
shutdown to clear the onboard memory. There are commented out functions
currently in the sbz_exit_chip function that are added in a later patch.

Also, a reboot notify function has been added, to make sure these
functions are ran before a reboot. This helps when using the card
through VFIO in a virtual machine, to make sure the card reloads the DSP
properly.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 126 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 68e5122..3fbbb85 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4641,6 +4641,121 @@ static void ca0132_init_chip(struct hda_codec *codec)
 #endif
 }
 
+/*
+ * Recon3Di exit specific commands.
+ */
+/* prevents popping noise on shutdown */
+static void r3di_gpio_shutdown(struct hda_codec *codec)
+{
+	snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DATA, 0x00);
+}
+
+/*
+ * Sound Blaster Z exit specific commands.
+ */
+static void sbz_region2_exit(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int i;
+
+	for (i = 0; i < 4; i++)
+		writeb(0x0, spec->mem_base + 0x100);
+	for (i = 0; i < 8; i++)
+		writeb(0xb3, spec->mem_base + 0x304);
+	/*
+	 * I believe these are GPIO, with the right most hex digit being the
+	 * gpio pin, and the second digit being on or off. We see this more in
+	 * the input/output select functions.
+	 */
+	writew(0x0000, spec->mem_base + 0x320);
+	writew(0x0001, spec->mem_base + 0x320);
+	writew(0x0104, spec->mem_base + 0x320);
+	writew(0x0005, spec->mem_base + 0x320);
+	writew(0x0007, spec->mem_base + 0x320);
+}
+
+static void sbz_set_pin_ctl_default(struct hda_codec *codec)
+{
+	hda_nid_t pins[5] = {0x0B, 0x0C, 0x0E, 0x12, 0x13};
+	unsigned int i;
+
+	snd_hda_codec_write(codec, 0x11, 0,
+			AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40);
+
+	for (i = 0; i < 5; i++)
+		snd_hda_codec_write(codec, pins[i], 0,
+				AC_VERB_SET_PIN_WIDGET_CONTROL, 0x00);
+}
+
+static void sbz_clear_unsolicited(struct hda_codec *codec)
+{
+	hda_nid_t pins[7] = {0x0B, 0x0E, 0x0F, 0x10, 0x11, 0x12, 0x13};
+	unsigned int i;
+
+	for (i = 0; i < 7; i++) {
+		snd_hda_codec_write(codec, pins[i], 0,
+				AC_VERB_SET_UNSOLICITED_ENABLE, 0x00);
+	}
+}
+
+/* On shutdown, sends commands in sets of three */
+static void sbz_gpio_shutdown_commands(struct hda_codec *codec, int dir,
+							int mask, int data)
+{
+	if (dir >= 0)
+		snd_hda_codec_write(codec, 0x01, 0,
+				AC_VERB_SET_GPIO_DIRECTION, dir);
+	if (mask >= 0)
+		snd_hda_codec_write(codec, 0x01, 0,
+				AC_VERB_SET_GPIO_MASK, mask);
+
+	if (data >= 0)
+		snd_hda_codec_write(codec, 0x01, 0,
+				AC_VERB_SET_GPIO_DATA, data);
+}
+
+static void sbz_exit_chip(struct hda_codec *codec)
+{
+	/* added in later patch. */
+//	chipio_set_stream_control(codec, 0x03, 0);
+//	chipio_set_stream_control(codec, 0x04, 0);
+
+	/* Mess with GPIO */
+	sbz_gpio_shutdown_commands(codec, 0x07, 0x07, -1);
+	sbz_gpio_shutdown_commands(codec, 0x07, 0x07, 0x05);
+	sbz_gpio_shutdown_commands(codec, 0x07, 0x07, 0x01);
+
+//	chipio_set_stream_control(codec, 0x14, 0);
+//	chipio_set_stream_control(codec, 0x0C, 0);
+
+	chipio_set_conn_rate(codec, 0x41, SR_192_000);
+	chipio_set_conn_rate(codec, 0x91, SR_192_000);
+
+	chipio_write(codec, 0x18a020, 0x00000083);
+
+	sbz_gpio_shutdown_commands(codec, 0x07, 0x07, 0x03);
+	sbz_gpio_shutdown_commands(codec, 0x07, 0x07, 0x07);
+	sbz_gpio_shutdown_commands(codec, 0x07, 0x07, 0x06);
+
+//	chipio_set_stream_control(codec, 0x0C, 0);
+
+	chipio_set_control_param(codec, 0x0D, 0x24);
+
+	sbz_clear_unsolicited(codec);
+	sbz_set_pin_ctl_default(codec);
+
+	snd_hda_codec_write(codec, 0x0B, 0,
+		AC_VERB_SET_EAPD_BTLENABLE, 0x00);
+
+	if (dspload_is_loaded(codec))
+		dsp_reset(codec);
+
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+		VENDOR_CHIPIO_CT_EXTENSIONS_ENABLE, 0x00);
+
+	sbz_region2_exit(codec);
+}
+
 static void ca0132_exit_chip(struct hda_codec *codec)
 {
 	/* put any chip cleanup stuffs here. */
@@ -4703,7 +4818,12 @@ static void ca0132_free(struct hda_codec *codec)
 	snd_hda_power_up(codec);
 	switch (spec->quirk) {
 	case QUIRK_SBZ:
+		sbz_exit_chip(codec);
+		/* unmap BAR region 2. */
 		iounmap(spec->mem_base);
+		break;
+	case QUIRK_R3DI:
+		r3di_gpio_shutdown(codec);
 		snd_hda_sequence_write(codec, spec->base_exit_verbs);
 		ca0132_exit_chip(codec);
 		break;
@@ -4717,12 +4837,18 @@ static void ca0132_free(struct hda_codec *codec)
 	kfree(codec->spec);
 }
 
+static void ca0132_reboot_notify(struct hda_codec *codec)
+{
+	codec->patch_ops.free(codec);
+}
+
 static const struct hda_codec_ops ca0132_patch_ops = {
 	.build_controls = ca0132_build_controls,
 	.build_pcms = ca0132_build_pcms,
 	.init = ca0132_init,
 	.free = ca0132_free,
 	.unsol_event = snd_hda_jack_unsol_event,
+	.reboot_notify = ca0132_reboot_notify,
 };
 
 static void ca0132_config(struct hda_codec *codec)
-- 
2.7.4
