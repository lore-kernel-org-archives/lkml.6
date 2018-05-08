Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754108AbeEHCeW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 22:34:22 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38106 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753794AbeEHCcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 22:32:18 -0400
X-Google-Smtp-Source: AB8JxZq+obcefMRLYacX9xEGMbnbT+qZbcvhzDeALaFCNGQK4aeRDWXx8NAGnhl1Ladnk8TnUxm/ew==
From: Connor McAdams <conmanx360@gmail.com>
Cc: o-takashi@sakamocchi.jp, Connor McAdams <conmanx360@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?q?J=C3=A9r=C3=A9my=20Lefaure?=
        <jeremy.lefaure@lse.epita.fr>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/13] ALSA: hda/ca0132: add dsp setup related commands for the sbz
Date: Mon,  7 May 2018 22:31:15 -0400
Message-Id: <1525746683-18535-8-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525746683-18535-1-git-send-email-conmanx360@gmail.com>
References: <1525746683-18535-1-git-send-email-conmanx360@gmail.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dsp setup related functions for the Sound Blaster Z, along with
other helper functions.

Also, add sbz_dsp_startup_check, which fixes a bug where the card
sometimes starts up and has no sound.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 341 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 335 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 31c9d42..37609bd 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -45,6 +45,7 @@
 #define FLOAT_ZERO	0x00000000
 #define FLOAT_ONE	0x3f800000
 #define FLOAT_TWO	0x40000000
+#define FLOAT_THREE     0x40400000
 #define FLOAT_MINUS_5	0xc0a00000
 
 #define UNSOL_TAG_DSP	0x16
@@ -744,6 +745,7 @@ struct ca0132_spec {
 	unsigned int scp_resp_data[4];
 	unsigned int scp_resp_count;
 	bool alt_firmware_present;
+	bool startup_check_entered;
 	bool dsp_reload;
 
 	/* mixer and effects related */
@@ -1024,6 +1026,29 @@ static int chipio_write(struct hda_codec *codec,
 }
 
 /*
+ * Write given value to the given address through the chip I/O widget.
+ * not protected by the Mutex
+ */
+static int chipio_write_no_mutex(struct hda_codec *codec,
+		unsigned int chip_addx, const unsigned int data)
+{
+	int err;
+
+
+	/* write the address, and if successful proceed to write data */
+	err = chipio_write_address(codec, chip_addx);
+	if (err < 0)
+		goto exit;
+
+	err = chipio_write_data(codec, data);
+	if (err < 0)
+		goto exit;
+
+exit:
+	return err;
+}
+
+/*
  * Write multiple values to the given address through the chip I/O widget.
  * protected by the Mutex
  */
@@ -1139,6 +1164,32 @@ static void chipio_set_control_param_no_mutex(struct hda_codec *codec,
 		}
 	}
 }
+/*
+ * Connect stream to a source point, and then connect
+ * that source point to a destination point.
+ */
+static void chipio_set_stream_source_dest(struct hda_codec *codec,
+				int streamid, int source_point, int dest_point)
+{
+	chipio_set_control_param_no_mutex(codec,
+			CONTROL_PARAM_STREAM_ID, streamid);
+	chipio_set_control_param_no_mutex(codec,
+			CONTROL_PARAM_STREAM_SOURCE_CONN_POINT, source_point);
+	chipio_set_control_param_no_mutex(codec,
+			CONTROL_PARAM_STREAM_DEST_CONN_POINT, dest_point);
+}
+
+/*
+ * Set number of channels in the selected stream.
+ */
+static void chipio_set_stream_channels(struct hda_codec *codec,
+				int streamid, unsigned int channels)
+{
+	chipio_set_control_param_no_mutex(codec,
+			CONTROL_PARAM_STREAM_ID, streamid);
+	chipio_set_control_param_no_mutex(codec,
+			CONTROL_PARAM_STREAMS_CHANNELS, channels);
+}
 
 /*
  * Enable/Disable audio stream.
@@ -1152,6 +1203,19 @@ static void chipio_set_stream_control(struct hda_codec *codec,
 			CONTROL_PARAM_STREAM_CONTROL, enable);
 }
 
+
+/*
+ * Set sampling rate of the connection point. NO MUTEX.
+ */
+static void chipio_set_conn_rate_no_mutex(struct hda_codec *codec,
+				int connid, enum ca0132_sample_rate rate)
+{
+	chipio_set_control_param_no_mutex(codec,
+			CONTROL_PARAM_CONN_POINT_ID, connid);
+	chipio_set_control_param_no_mutex(codec,
+			CONTROL_PARAM_CONN_POINT_SAMPLE_RATE, rate);
+}
+
 /*
  * Set sampling rate of the connection point.
  */
@@ -4475,6 +4539,123 @@ static void ca0132_refresh_widget_caps(struct hda_codec *codec)
 }
 
 /*
+ * Initialize Sound Blaster Z analog microphones.
+ */
+static void sbz_init_analog_mics(struct hda_codec *codec)
+{
+	unsigned int tmp;
+
+	/* Mic 1 Setup */
+	chipio_set_conn_rate(codec, MEM_CONNID_MICIN1, SR_96_000);
+	chipio_set_conn_rate(codec, MEM_CONNID_MICOUT1, SR_96_000);
+	tmp = FLOAT_THREE;
+	dspio_set_uint_param(codec, 0x80, 0x00, tmp);
+
+	/* Mic 2 Setup, even though it isn't connected on SBZ */
+	chipio_set_conn_rate(codec, MEM_CONNID_MICIN2, SR_96_000);
+	chipio_set_conn_rate(codec, MEM_CONNID_MICOUT2, SR_96_000);
+	tmp = FLOAT_ZERO;
+	dspio_set_uint_param(codec, 0x80, 0x01, tmp);
+
+}
+
+/*
+ * Sets the source of stream 0x14 to connpointID 0x48, and the destination
+ * connpointID to 0x91. If this isn't done, the destination is 0x71, and
+ * you get no sound. I'm guessing this has to do with the Sound Blaster Z
+ * having an updated DAC, which changes the destination to that DAC.
+ */
+static void sbz_connect_streams(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	mutex_lock(&spec->chipio_mutex);
+
+	codec_dbg(codec, "Connect Streams entered, mutex locked and loaded.\n");
+
+	chipio_set_stream_channels(codec, 0x0C, 6);
+	chipio_set_stream_control(codec, 0x0C, 1);
+
+	/* This value is 0x43 for 96khz, and 0x83 for 192khz. */
+	chipio_write_no_mutex(codec, 0x18a020, 0x00000043);
+
+	/* Setup stream 0x14 with it's source and destination points */
+	chipio_set_stream_source_dest(codec, 0x14, 0x48, 0x91);
+	chipio_set_conn_rate_no_mutex(codec, 0x48, SR_96_000);
+	chipio_set_conn_rate_no_mutex(codec, 0x91, SR_96_000);
+	chipio_set_stream_channels(codec, 0x14, 2);
+	chipio_set_stream_control(codec, 0x14, 1);
+
+	codec_dbg(codec, "Connect Streams exited, mutex released.\n");
+
+	mutex_unlock(&spec->chipio_mutex);
+
+}
+
+/*
+ * Write data through ChipIO to setup proper stream destinations.
+ * Not sure how it exactly works, but it seems to direct data
+ * to different destinations. Example is f8 to c0, e0 to c0.
+ * All I know is, if you don't set these, you get no sound.
+ */
+static void sbz_chipio_startup_data(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	mutex_lock(&spec->chipio_mutex);
+	codec_dbg(codec, "Startup Data entered, mutex locked and loaded.\n");
+
+	/* These control audio output */
+	chipio_write_no_mutex(codec, 0x190060, 0x0001f8c0);
+	chipio_write_no_mutex(codec, 0x190064, 0x0001f9c1);
+	chipio_write_no_mutex(codec, 0x190068, 0x0001fac6);
+	chipio_write_no_mutex(codec, 0x19006c, 0x0001fbc7);
+	/* Signal to update I think */
+	chipio_write_no_mutex(codec, 0x19042c, 0x00000001);
+
+	chipio_set_stream_channels(codec, 0x0C, 6);
+	chipio_set_stream_control(codec, 0x0C, 1);
+	/* No clue what these control */
+	chipio_write_no_mutex(codec, 0x190030, 0x0001e0c0);
+	chipio_write_no_mutex(codec, 0x190034, 0x0001e1c1);
+	chipio_write_no_mutex(codec, 0x190038, 0x0001e4c2);
+	chipio_write_no_mutex(codec, 0x19003c, 0x0001e5c3);
+	chipio_write_no_mutex(codec, 0x190040, 0x0001e2c4);
+	chipio_write_no_mutex(codec, 0x190044, 0x0001e3c5);
+	chipio_write_no_mutex(codec, 0x190048, 0x0001e8c6);
+	chipio_write_no_mutex(codec, 0x19004c, 0x0001e9c7);
+	chipio_write_no_mutex(codec, 0x190050, 0x0001ecc8);
+	chipio_write_no_mutex(codec, 0x190054, 0x0001edc9);
+	chipio_write_no_mutex(codec, 0x190058, 0x0001eaca);
+	chipio_write_no_mutex(codec, 0x19005c, 0x0001ebcb);
+
+	chipio_write_no_mutex(codec, 0x19042c, 0x00000001);
+
+	codec_dbg(codec, "Startup Data exited, mutex released.\n");
+	mutex_unlock(&spec->chipio_mutex);
+}
+
+static void sbz_dsp_initial_mic_setup(struct hda_codec *codec)
+{
+	unsigned int tmp;
+
+	chipio_set_stream_control(codec, 0x03, 0);
+	chipio_set_stream_control(codec, 0x04, 0);
+
+	chipio_set_conn_rate(codec, MEM_CONNID_MICIN1, SR_96_000);
+	chipio_set_conn_rate(codec, MEM_CONNID_MICOUT1, SR_96_000);
+
+	tmp = FLOAT_THREE;
+	dspio_set_uint_param(codec, 0x80, 0x00, tmp);
+
+	chipio_set_stream_control(codec, 0x03, 1);
+	chipio_set_stream_control(codec, 0x04, 1);
+
+	chipio_write(codec, 0x18b098, 0x0000000c);
+	chipio_write(codec, 0x18b09C, 0x0000000c);
+}
+
+/*
  * Setup default parameters for DSP
  */
 static void ca0132_setup_defaults(struct hda_codec *codec)
@@ -4519,6 +4700,83 @@ static void ca0132_setup_defaults(struct hda_codec *codec)
 }
 
 /*
+ * Setup default parameters for the Sound Blaster Z DSP. A lot more going on
+ * than the Chromebook setup.
+ */
+static void sbz_setup_defaults(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int tmp, stream_format;
+	int num_fx;
+	int idx, i;
+
+	if (spec->dsp_state != DSP_DOWNLOADED)
+		return;
+
+
+	sbz_init_analog_mics(codec);
+
+	sbz_connect_streams(codec);
+
+	sbz_chipio_startup_data(codec);
+
+	chipio_set_stream_control(codec, 0x03, 1);
+	chipio_set_stream_control(codec, 0x04, 1);
+
+	/*
+	 * Sets internal input loopback to off, used to have a switch to
+	 * enable input loopback, but turned out to be way too buggy.
+	 */
+	tmp = FLOAT_ONE;
+	dspio_set_uint_param(codec, 0x37, 0x08, tmp);
+	dspio_set_uint_param(codec, 0x37, 0x10, tmp);
+
+	/*remove DSP headroom*/
+	tmp = FLOAT_ZERO;
+	dspio_set_uint_param(codec, 0x96, 0x3C, tmp);
+
+	/* set WUH source */
+	tmp = FLOAT_TWO;
+	dspio_set_uint_param(codec, 0x31, 0x00, tmp);
+	chipio_set_conn_rate(codec, MEM_CONNID_WUH, SR_48_000);
+
+	/* Set speaker source? */
+	dspio_set_uint_param(codec, 0x32, 0x00, tmp);
+
+	sbz_dsp_initial_mic_setup(codec);
+
+
+	/* out, in effects + voicefx */
+	num_fx = OUT_EFFECTS_COUNT + IN_EFFECTS_COUNT + 1;
+	for (idx = 0; idx < num_fx; idx++) {
+		for (i = 0; i <= ca0132_effects[idx].params; i++) {
+			dspio_set_uint_param(codec,
+					ca0132_effects[idx].mid,
+					ca0132_effects[idx].reqs[i],
+					ca0132_effects[idx].def_vals[i]);
+		}
+	}
+
+	/*
+	 * Have to make a stream to bind the sound output to, otherwise
+	 * you'll get dead audio. Before I did this, it would bind to an
+	 * audio input, and would never work
+	 */
+	stream_format = snd_hdac_calc_stream_format(48000, 2,
+			SNDRV_PCM_FORMAT_S32_LE, 32, 0);
+
+	snd_hda_codec_setup_stream(codec, spec->dacs[0], spec->dsp_stream_id,
+					0, stream_format);
+
+	snd_hda_codec_cleanup_stream(codec, spec->dacs[0]);
+
+	snd_hda_codec_setup_stream(codec, spec->dacs[0], spec->dsp_stream_id,
+					0, stream_format);
+
+	snd_hda_codec_cleanup_stream(codec, spec->dacs[0]);
+}
+
+/*
  * Initialization of flags in chip
  */
 static void ca0132_init_flags(struct hda_codec *codec)
@@ -4955,6 +5213,71 @@ static void ca0132_exit_chip(struct hda_codec *codec)
 }
 
 /*
+ * This fixes a problem that was hard to reproduce. Very rarely, I would
+ * boot up, and there would be no sound, but the DSP indicated it had loaded
+ * properly. I did a few memory dumps to see if anything was different, and
+ * there were a few areas of memory uninitialized with a1a2a3a4. This function
+ * checks if those areas are uninitialized, and if they are, it'll attempt to
+ * reload the card 3 times. Usually it fixes by the second.
+ */
+static void sbz_dsp_startup_check(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int dsp_data_check[4];
+	unsigned int cur_address = 0x390;
+	unsigned int i;
+	unsigned int failure = 0;
+	unsigned int reload = 3;
+
+	if (spec->startup_check_entered)
+		return;
+
+	spec->startup_check_entered = true;
+
+	for (i = 0; i < 4; i++) {
+		chipio_read(codec, cur_address, &dsp_data_check[i]);
+		cur_address += 0x4;
+	}
+	for (i = 0; i < 4; i++) {
+		if (dsp_data_check[i] == 0xa1a2a3a4)
+			failure = 1;
+	}
+
+	codec_dbg(codec, "Startup Check: %d ", failure);
+	if (failure)
+		codec_info(codec, "DSP not initialized properly. Attempting to fix.");
+	/*
+	 * While the failure condition is true, and we haven't reached our
+	 * three reload limit, continue trying to reload the driver and
+	 * fix the issue.
+	 */
+	while (failure && (reload != 0)) {
+		codec_info(codec, "Reloading... Tries left: %d", reload);
+		sbz_exit_chip(codec);
+		spec->dsp_state = DSP_DOWNLOAD_INIT;
+		codec->patch_ops.init(codec);
+		failure = 0;
+		for (i = 0; i < 4; i++) {
+			chipio_read(codec, cur_address, &dsp_data_check[i]);
+			cur_address += 0x4;
+		}
+		for (i = 0; i < 4; i++) {
+			if (dsp_data_check[i] == 0xa1a2a3a4)
+				failure = 1;
+		}
+		reload--;
+	}
+
+	if (!failure && reload < 3)
+		codec_info(codec, "DSP fixed.");
+
+	if (!failure)
+		return;
+
+	codec_info(codec, "DSP failed to initialize properly. Either try a full shutdown or a suspend to clear the internal memory.");
+}
+
+/*
  * This is for the extra volume verbs 0x797 (left) and 0x798 (right). These add
  * extra precision for decibel values. If you had the dB value in floating point
  * you would take the value after the decimal point, multiply by 64, and divide
@@ -5103,8 +5426,11 @@ static int ca0132_init(struct hda_codec *codec)
 		if (!dsp_loaded) {
 			spec->dsp_reload = true;
 			spec->dsp_state = DSP_DOWNLOAD_INIT;
-		} else
+		} else {
+			if (spec->quirk == QUIRK_SBZ)
+				sbz_dsp_startup_check(codec);
 			return 0;
+		}
 	}
 
 	if (spec->dsp_state != DSP_DOWNLOAD_FAILED)
@@ -5117,7 +5443,6 @@ static int ca0132_init(struct hda_codec *codec)
 	snd_hda_power_up_pm(codec);
 
 	ca0132_init_unsol(codec);
-
 	ca0132_init_params(codec);
 	ca0132_init_flags(codec);
 	snd_hda_sequence_write(codec, spec->base_init_verbs);
@@ -5131,9 +5456,11 @@ static int ca0132_init(struct hda_codec *codec)
 	if (spec->quirk == QUIRK_SBZ)
 		writew(0x0107, spec->mem_base + 0x320);
 
-	ca0132_setup_defaults(codec);
-	ca0132_init_analog_mic2(codec);
-	ca0132_init_dmic(codec);
+	if (spec->quirk != QUIRK_SBZ) {
+		ca0132_setup_defaults(codec);
+		ca0132_init_analog_mic2(codec);
+		ca0132_init_dmic(codec);
+	}
 
 	for (i = 0; i < spec->num_outputs; i++)
 		init_output(codec, spec->out_pins[i], spec->dacs[0]);
@@ -5153,8 +5480,10 @@ static int ca0132_init(struct hda_codec *codec)
 			    VENDOR_CHIPIO_PARAM_EX_VALUE_SET, 0x20);
 	}
 
-	if (spec->quirk == QUIRK_SBZ)
+	if (spec->quirk == QUIRK_SBZ) {
 		ca0132_gpio_setup(codec);
+		sbz_setup_defaults(codec);
+	}
 
 	snd_hda_sequence_write(codec, spec->spec_init_verbs);
 
-- 
2.7.4
