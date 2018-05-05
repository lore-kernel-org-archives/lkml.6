Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751917AbeEETE2 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 15:04:28 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33389 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751252AbeEETEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 15:04:16 -0400
X-Google-Smtp-Source: AB8JxZpcol0ZJcweXmx8wGIFU3OSMd99+ssmv0XGJiKwOnjFRm92w8MYDCimpkepvzACO7zQi3K/gQ==
From: Connor McAdams <conmanx360@gmail.com>
Cc: o-takashi@sakamocchi.jp, Connor McAdams <conmanx360@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?q?J=C3=A9r=C3=A9my=20Lefaure?=
        <jeremy.lefaure@lse.epita.fr>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/9] ALSA: hda/ca0132: add/change helper functions for R3Di and SBZ
Date: Sat,  5 May 2018 15:03:16 -0400
Message-Id: <1525547001-17588-6-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525547001-17588-1-git-send-email-conmanx360@gmail.com>
References: <1525547001-17588-1-git-send-email-conmanx360@gmail.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Edit core functions to support the Sound Blaster Z and Recon3Di for
startup and loading of the DSP, as well as setting effects.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 1064 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 1018 insertions(+), 46 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 5cda7a5..bb0feaa 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -45,6 +45,7 @@
 #define FLOAT_ZERO	0x00000000
 #define FLOAT_ONE	0x3f800000
 #define FLOAT_TWO	0x40000000
+#define FLOAT_THREE     0x40400000
 #define FLOAT_MINUS_5	0xc0a00000
 
 #define UNSOL_TAG_DSP	0x16
@@ -710,6 +711,7 @@ struct ca0132_spec {
 	const struct hda_verb *base_init_verbs;
 	const struct hda_verb *base_exit_verbs;
 	const struct hda_verb *chip_init_verbs;
+	const struct hda_verb *sbz_init_verbs;
 	struct hda_verb *spec_init_verbs;
 	struct auto_pin_cfg autocfg;
 
@@ -743,6 +745,8 @@ struct ca0132_spec {
 	unsigned int scp_resp_data[4];
 	unsigned int scp_resp_count;
 	bool alt_firmware_present;
+	bool startup_check_entered;
+	bool dsp_reload;
 
 	/* mixer and effects related */
 	unsigned char dmic_ctl;
@@ -768,6 +772,13 @@ struct ca0132_spec {
 	 * switching, and other unknown commands.
 	 */
 	void __iomem *mem_base;
+
+	/*
+	 * Whether or not to use the alt functions like alt_select_out,
+	 * alt_select_in, etc. Only used on desktop codecs for now, because of
+	 * surround sound support.
+	 */
+	bool use_alt_functions;
 };
 
 /*
@@ -1015,6 +1026,29 @@ static int chipio_write(struct hda_codec *codec,
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
@@ -1108,6 +1142,81 @@ static void chipio_set_control_param(struct hda_codec *codec,
 }
 
 /*
+ * Set chip parameters through the chip I/O widget. NO MUTEX.
+ */
+static void chipio_set_control_param_no_mutex(struct hda_codec *codec,
+		enum control_param_id param_id, int param_val)
+{
+	int val;
+
+	if ((param_id < 32) && (param_val < 8)) {
+		val = (param_val << 5) | (param_id);
+		snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+				    VENDOR_CHIPIO_PARAM_SET, val);
+	} else {
+		if (chipio_send(codec, VENDOR_CHIPIO_STATUS, 0) == 0) {
+			snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+					    VENDOR_CHIPIO_PARAM_EX_ID_SET,
+					    param_id);
+			snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+					    VENDOR_CHIPIO_PARAM_EX_VALUE_SET,
+					    param_val);
+		}
+	}
+}
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
+
+/*
+ * Enable/Disable audio stream.
+ */
+static void chipio_set_stream_control(struct hda_codec *codec,
+				int streamid, int enable)
+{
+	chipio_set_control_param_no_mutex(codec,
+			CONTROL_PARAM_STREAM_ID, streamid);
+	chipio_set_control_param_no_mutex(codec,
+			CONTROL_PARAM_STREAM_CONTROL, enable);
+}
+
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
+/*
  * Set sampling rate of the connection point.
  */
 static void chipio_set_conn_rate(struct hda_codec *codec,
@@ -1470,8 +1579,8 @@ static int dspio_send_scp_message(struct hda_codec *codec,
  * Returns zero or a negative error code.
  */
 static int dspio_scp(struct hda_codec *codec,
-		int mod_id, int req, int dir, void *data, unsigned int len,
-		void *reply, unsigned int *reply_len)
+		int mod_id, int src_id, int req, int dir, const void *data,
+		unsigned int len, void *reply, unsigned int *reply_len)
 {
 	int status = 0;
 	struct scp_msg scp_send, scp_reply;
@@ -1495,7 +1604,7 @@ static int dspio_scp(struct hda_codec *codec,
 		return -EINVAL;
 	}
 
-	scp_send.hdr = make_scp_header(mod_id, 0x20, (dir == SCP_GET), req,
+	scp_send.hdr = make_scp_header(mod_id, src_id, (dir == SCP_GET), req,
 				       0, 0, 0, len/sizeof(unsigned int));
 	if (data != NULL && len > 0) {
 		len = min((unsigned int)(sizeof(scp_send.data)), len);
@@ -1552,15 +1661,24 @@ static int dspio_scp(struct hda_codec *codec,
  * Set DSP parameters
  */
 static int dspio_set_param(struct hda_codec *codec, int mod_id,
-			int req, void *data, unsigned int len)
+			int src_id, int req, const void *data, unsigned int len)
 {
-	return dspio_scp(codec, mod_id, req, SCP_SET, data, len, NULL, NULL);
+	return dspio_scp(codec, mod_id, src_id, req, SCP_SET, data, len, NULL,
+			NULL);
 }
 
 static int dspio_set_uint_param(struct hda_codec *codec, int mod_id,
-			int req, unsigned int data)
+			int req, const unsigned int data)
 {
-	return dspio_set_param(codec, mod_id, req, &data, sizeof(unsigned int));
+	return dspio_set_param(codec, mod_id, 0x20, req, &data,
+			sizeof(unsigned int));
+}
+
+static int dspio_set_uint_param_no_source(struct hda_codec *codec, int mod_id,
+			int req, const unsigned int data)
+{
+	return dspio_set_param(codec, mod_id, 0x00, req, &data,
+			sizeof(unsigned int));
 }
 
 /*
@@ -1572,8 +1690,9 @@ static int dspio_alloc_dma_chan(struct hda_codec *codec, unsigned int *dma_chan)
 	unsigned int size = sizeof(dma_chan);
 
 	codec_dbg(codec, "     dspio_alloc_dma_chan() -- begin\n");
-	status = dspio_scp(codec, MASTERCONTROL, MASTERCONTROL_ALLOC_DMA_CHAN,
-			SCP_GET, NULL, 0, dma_chan, &size);
+	status = dspio_scp(codec, MASTERCONTROL, 0x20,
+			MASTERCONTROL_ALLOC_DMA_CHAN, SCP_GET, NULL, 0,
+			dma_chan, &size);
 
 	if (status < 0) {
 		codec_dbg(codec, "dspio_alloc_dma_chan: SCP Failed\n");
@@ -1602,8 +1721,9 @@ static int dspio_free_dma_chan(struct hda_codec *codec, unsigned int dma_chan)
 	codec_dbg(codec, "     dspio_free_dma_chan() -- begin\n");
 	codec_dbg(codec, "dspio_free_dma_chan: chan=%d\n", dma_chan);
 
-	status = dspio_scp(codec, MASTERCONTROL, MASTERCONTROL_ALLOC_DMA_CHAN,
-			   SCP_SET, &dma_chan, sizeof(dma_chan), NULL, &dummy);
+	status = dspio_scp(codec, MASTERCONTROL, 0x20,
+			MASTERCONTROL_ALLOC_DMA_CHAN, SCP_SET, &dma_chan,
+			sizeof(dma_chan), NULL, &dummy);
 
 	if (status < 0) {
 		codec_dbg(codec, "dspio_free_dma_chan: SCP Failed\n");
@@ -2625,14 +2745,16 @@ static int dspxfr_image(struct hda_codec *codec,
  */
 static void dspload_post_setup(struct hda_codec *codec)
 {
+	struct ca0132_spec *spec = codec->spec;
 	codec_dbg(codec, "---- dspload_post_setup ------\n");
+	if (!spec->use_alt_functions) {
+		/*set DSP speaker to 2.0 configuration*/
+		chipio_write(codec, XRAM_XRAM_INST_OFFSET(0x18), 0x08080080);
+		chipio_write(codec, XRAM_XRAM_INST_OFFSET(0x19), 0x3f800000);
 
-	/*set DSP speaker to 2.0 configuration*/
-	chipio_write(codec, XRAM_XRAM_INST_OFFSET(0x18), 0x08080080);
-	chipio_write(codec, XRAM_XRAM_INST_OFFSET(0x19), 0x3f800000);
-
-	/*update write pointer*/
-	chipio_write(codec, XRAM_XRAM_INST_OFFSET(0x29), 0x00000002);
+		/*update write pointer*/
+		chipio_write(codec, XRAM_XRAM_INST_OFFSET(0x29), 0x00000002);
+	}
 }
 
 /**
@@ -2740,6 +2862,170 @@ static bool dspload_wait_loaded(struct hda_codec *codec)
 }
 
 /*
+ * Setup GPIO for the other variants of Core3D.
+ */
+
+/*
+ * Sets up the GPIO pins so that they are discoverable. If this isn't done,
+ * the card shows as having no GPIO pins.
+ */
+static void ca0132_gpio_init(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	switch (spec->quirk) {
+	case QUIRK_SBZ:
+		snd_hda_codec_write(codec, 0x01, 0, 0x793, 0x00);
+		snd_hda_codec_write(codec, 0x01, 0, 0x794, 0x53);
+		snd_hda_codec_write(codec, 0x01, 0, 0x790, 0x23);
+		break;
+	case QUIRK_R3DI:
+		snd_hda_codec_write(codec, 0x01, 0, 0x793, 0x00);
+		snd_hda_codec_write(codec, 0x01, 0, 0x794, 0x5B);
+		break;
+	}
+
+}
+
+/* Sets the GPIO for audio output. */
+static void ca0132_gpio_setup(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	switch (spec->quirk) {
+	case QUIRK_SBZ:
+		snd_hda_codec_write(codec, 0x01, 0,
+				AC_VERB_SET_GPIO_DIRECTION, 0x07);
+		snd_hda_codec_write(codec, 0x01, 0,
+				AC_VERB_SET_GPIO_MASK, 0x07);
+		snd_hda_codec_write(codec, 0x01, 0,
+				AC_VERB_SET_GPIO_DATA, 0x04);
+		snd_hda_codec_write(codec, 0x01, 0,
+				AC_VERB_SET_GPIO_DATA, 0x06);
+		break;
+	case QUIRK_R3DI:
+		snd_hda_codec_write(codec, 0x01, 0,
+				AC_VERB_SET_GPIO_DIRECTION, 0x1E);
+		snd_hda_codec_write(codec, 0x01, 0,
+				AC_VERB_SET_GPIO_MASK, 0x1F);
+		snd_hda_codec_write(codec, 0x01, 0,
+				AC_VERB_SET_GPIO_DATA, 0x0C);
+		break;
+	}
+}
+
+/*
+ * GPIO control functions for the Recon3D integrated.
+ */
+
+enum r3di_gpio_bit {
+	/* Bit 1 - Switch between front/rear mic. 0 = rear, 1 = front */
+	R3DI_MIC_SELECT_BIT = 1,
+	/* Bit 2 - Switch between headphone/line out. 0 = Headphone, 1 = Line */
+	R3DI_OUT_SELECT_BIT = 2,
+	/*
+	 * I dunno what this actually does, but it stays on until the dsp
+	 * is downloaded.
+	 */
+	R3DI_GPIO_DSP_DOWNLOADING = 3,
+	/*
+	 * Same as above, no clue what it does, but it comes on after the dsp
+	 * is downloaded.
+	 */
+	R3DI_GPIO_DSP_DOWNLOADED = 4
+};
+
+enum r3di_mic_select {
+	/* Set GPIO bit 1 to 0 for rear mic */
+	R3DI_REAR_MIC = 0,
+	/* Set GPIO bit 1 to 1 for front microphone*/
+	R3DI_FRONT_MIC = 1
+};
+
+enum r3di_out_select {
+	/* Set GPIO bit 2 to 0 for headphone */
+	R3DI_HEADPHONE_OUT = 0,
+	/* Set GPIO bit 2 to 1 for speaker */
+	R3DI_LINE_OUT = 1
+};
+enum r3di_dsp_status {
+	/* Set GPIO bit 3 to 1 until DSP is downloaded */
+	R3DI_DSP_DOWNLOADING = 0,
+	/* Set GPIO bit 4 to 1 once DSP is downloaded */
+	R3DI_DSP_DOWNLOADED = 1
+};
+/* Not used until next patch in series */
+/*
+static void r3di_gpio_mic_set(struct hda_codec *codec,
+		enum r3di_mic_select cur_mic)
+{
+	unsigned int cur_gpio;
+
+*/	/* Get the current GPIO Data setup */
+/*	cur_gpio = snd_hda_codec_read(codec, 0x01, 0, AC_VERB_GET_GPIO_DATA, 0);
+
+	switch (cur_mic) {
+	case R3DI_REAR_MIC:
+		cur_gpio &= ~(1 << R3DI_MIC_SELECT_BIT);
+		break;
+	case R3DI_FRONT_MIC:
+		cur_gpio |= (1 << R3DI_MIC_SELECT_BIT);
+		break;
+	}
+	snd_hda_codec_write(codec, codec->core.afg, 0,
+			    AC_VERB_SET_GPIO_DATA, cur_gpio);
+}
+
+static void r3di_gpio_out_set(struct hda_codec *codec,
+		enum r3di_out_select cur_out)
+{
+	unsigned int cur_gpio;
+
+*/	/* Get the current GPIO Data setup */
+/*	cur_gpio = snd_hda_codec_read(codec, 0x01, 0, AC_VERB_GET_GPIO_DATA, 0);
+
+	switch (cur_out) {
+	case R3DI_HEADPHONE_OUT:
+		cur_gpio &= ~(1 << R3DI_OUT_SELECT_BIT);
+		break;
+	case R3DI_LINE_OUT:
+		cur_gpio |= (1 << R3DI_OUT_SELECT_BIT);
+		break;
+	}
+	snd_hda_codec_write(codec, codec->core.afg, 0,
+			    AC_VERB_SET_GPIO_DATA, cur_gpio);
+}
+*/
+static void r3di_gpio_dsp_status_set(struct hda_codec *codec,
+		enum r3di_dsp_status dsp_status)
+{
+	unsigned int cur_gpio;
+
+	/* Get the current GPIO Data setup */
+	cur_gpio = snd_hda_codec_read(codec, 0x01, 0, AC_VERB_GET_GPIO_DATA, 0);
+
+	switch (dsp_status) {
+	case R3DI_DSP_DOWNLOADING:
+		cur_gpio |= (1 << R3DI_GPIO_DSP_DOWNLOADING);
+		snd_hda_codec_write(codec, codec->core.afg, 0,
+				AC_VERB_SET_GPIO_DATA, cur_gpio);
+		break;
+	case R3DI_DSP_DOWNLOADED:
+		/* Set DOWNLOADING bit to 0. */
+		cur_gpio &= ~(1 << R3DI_GPIO_DSP_DOWNLOADING);
+
+		snd_hda_codec_write(codec, codec->core.afg, 0,
+				AC_VERB_SET_GPIO_DATA, cur_gpio);
+
+		cur_gpio |= (1 << R3DI_GPIO_DSP_DOWNLOADED);
+		break;
+	}
+
+	snd_hda_codec_write(codec, codec->core.afg, 0,
+			    AC_VERB_SET_GPIO_DATA, cur_gpio);
+}
+
+/*
  * PCM callbacks
  */
 static int ca0132_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
@@ -2992,7 +3278,7 @@ static int tuning_ctl_set(struct hda_codec *codec, hda_nid_t nid,
 			break;
 
 	snd_hda_power_up(codec);
-	dspio_set_param(codec, ca0132_tuning_ctls[i].mid,
+	dspio_set_param(codec, ca0132_tuning_ctls[i].mid, 0x20,
 			ca0132_tuning_ctls[i].req,
 			&(lookup[idx]), sizeof(unsigned int));
 	snd_hda_power_down(codec);
@@ -3318,6 +3604,9 @@ static void ca0132_unsol_hp_delayed(struct work_struct *work)
 static void ca0132_set_dmic(struct hda_codec *codec, int enable);
 static int ca0132_mic_boost_set(struct hda_codec *codec, long val);
 static int ca0132_effects_set(struct hda_codec *codec, hda_nid_t nid, long val);
+static void resume_mic1(struct hda_codec *codec, unsigned int oldval);
+static int stop_mic1(struct hda_codec *codec);
+static int ca0132_cvoice_switch_set(struct hda_codec *codec);
 
 /*
  * Select the active VIP source
@@ -3468,7 +3757,7 @@ static int ca0132_voicefx_set(struct hda_codec *codec, int enable)
 static int ca0132_effects_set(struct hda_codec *codec, hda_nid_t nid, long val)
 {
 	struct ca0132_spec *spec = codec->spec;
-	unsigned int on;
+	unsigned int on, tmp;
 	int num_fx = OUT_EFFECTS_COUNT + IN_EFFECTS_COUNT;
 	int err = 0;
 	int idx = nid - EFFECT_START_NID;
@@ -3492,6 +3781,39 @@ static int ca0132_effects_set(struct hda_codec *codec, hda_nid_t nid, long val)
 		/* Voice Focus applies to 2-ch Mic, Digital Mic */
 		if ((nid == VOICE_FOCUS) && (spec->cur_mic_type != DIGITAL_MIC))
 			val = 0;
+
+		/* If Voice Focus on SBZ, set to two channel. */
+		if ((nid == VOICE_FOCUS) && (spec->quirk == QUIRK_SBZ)) {
+			if (spec->effects_switch[CRYSTAL_VOICE -
+						 EFFECT_START_NID]) {
+
+				if (spec->effects_switch[VOICE_FOCUS -
+							 EFFECT_START_NID]) {
+					tmp = FLOAT_TWO;
+					val = 1;
+				} else
+					tmp = FLOAT_ONE;
+
+				dspio_set_uint_param(codec, 0x80, 0x00, tmp);
+			}
+		}
+		/*
+		 * For SBZ noise reduction, there's an extra command
+		 * to module ID 0x47. No clue why.
+		 */
+		if ((nid == NOISE_REDUCTION) && (spec->quirk == QUIRK_SBZ)) {
+			if (spec->effects_switch[CRYSTAL_VOICE -
+						 EFFECT_START_NID]) {
+				if (spec->effects_switch[NOISE_REDUCTION -
+							 EFFECT_START_NID])
+					tmp = FLOAT_ONE;
+				else
+					tmp = FLOAT_ZERO;
+			} else
+				tmp = FLOAT_ZERO;
+
+			dspio_set_uint_param(codec, 0x47, 0x00, tmp);
+		}
 	}
 
 	codec_dbg(codec, "ca0132_effect_set: nid=0x%x, val=%ld\n",
@@ -4126,12 +4448,16 @@ static int ca0132_build_pcms(struct hda_codec *codec)
 	info->stream[SNDRV_PCM_STREAM_CAPTURE].substreams = 1;
 	info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->adcs[0];
 
-	info = snd_hda_codec_pcm_new(codec, "CA0132 Analog Mic-In2");
-	if (!info)
-		return -ENOMEM;
-	info->stream[SNDRV_PCM_STREAM_CAPTURE] = ca0132_pcm_analog_capture;
-	info->stream[SNDRV_PCM_STREAM_CAPTURE].substreams = 1;
-	info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->adcs[1];
+	/* With the DSP enabled, desktops don't use this ADC. */
+	if (spec->use_alt_functions) {
+		info = snd_hda_codec_pcm_new(codec, "CA0132 Analog Mic-In2");
+		if (!info)
+			return -ENOMEM;
+		info->stream[SNDRV_PCM_STREAM_CAPTURE] =
+			ca0132_pcm_analog_capture;
+		info->stream[SNDRV_PCM_STREAM_CAPTURE].substreams = 1;
+		info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->adcs[1];
+	}
 
 	info = snd_hda_codec_pcm_new(codec, "CA0132 What U Hear");
 	if (!info)
@@ -4338,6 +4664,196 @@ static void ca0132_refresh_widget_caps(struct hda_codec *codec)
 }
 
 /*
+ * Recon3Di r3di_setup_defaults sub functions.
+ */
+
+static void r3di_dsp_scp_startup(struct hda_codec *codec)
+{
+	unsigned int tmp;
+
+	tmp = 0x00000000;
+	dspio_set_uint_param_no_source(codec, 0x80, 0x0A, tmp);
+
+	tmp = 0x00000001;
+	dspio_set_uint_param_no_source(codec, 0x80, 0x0B, tmp);
+
+	tmp = 0x00000004;
+	dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+
+	tmp = 0x00000005;
+	dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+
+	tmp = 0x00000000;
+	dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+
+}
+
+static void r3di_dsp_initial_mic_setup(struct hda_codec *codec)
+{
+	unsigned int tmp;
+
+	/* Mic 1 Setup */
+	chipio_set_conn_rate(codec, MEM_CONNID_MICIN1, SR_96_000);
+	chipio_set_conn_rate(codec, MEM_CONNID_MICOUT1, SR_96_000);
+	/* This ConnPointID is unique to Recon3Di. Haven't seen it elsewhere */
+	chipio_set_conn_rate(codec, 0x0F, SR_96_000);
+	tmp = FLOAT_ONE;
+	dspio_set_uint_param(codec, 0x80, 0x00, tmp);
+
+	/* Mic 2 Setup, even though it isn't connected on SBZ */
+	chipio_set_conn_rate(codec, MEM_CONNID_MICIN2, SR_96_000);
+	chipio_set_conn_rate(codec, MEM_CONNID_MICOUT2, SR_96_000);
+	chipio_set_conn_rate(codec, 0x0F, SR_96_000);
+	tmp = FLOAT_ZERO;
+	dspio_set_uint_param(codec, 0x80, 0x01, tmp);
+}
+
+/*
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
+/*
+ * Sound Blaster Z uses these after DSP is loaded. Weird SCP commands
+ * without a 0x20 source like normal.
+ */
+static void sbz_dsp_scp_startup(struct hda_codec *codec)
+{
+	unsigned int tmp;
+
+	tmp = 0x00000003;
+	dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+
+	tmp = 0x00000000;
+	dspio_set_uint_param_no_source(codec, 0x80, 0x0A, tmp);
+
+	tmp = 0x00000001;
+	dspio_set_uint_param_no_source(codec, 0x80, 0x0B, tmp);
+
+	tmp = 0x00000004;
+	dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+
+	tmp = 0x00000005;
+	dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+
+	tmp = 0x00000000;
+	dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+
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
@@ -4382,16 +4898,162 @@ static void ca0132_setup_defaults(struct hda_codec *codec)
 }
 
 /*
+ * Setup default parameters for Recon3Di DSP.
+ */
+
+static void r3di_setup_defaults(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int tmp;
+	int num_fx;
+	int idx, i;
+
+	if (spec->dsp_state != DSP_DOWNLOADED)
+		return;
+
+	r3di_dsp_scp_startup(codec);
+
+	r3di_dsp_initial_mic_setup(codec);
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
+	r3di_gpio_dsp_status_set(codec, R3DI_DSP_DOWNLOADED);
+
+	/* Setup effect defaults */
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
+}
+
+/*
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
+	if (spec->quirk == QUIRK_SBZ)
+		sbz_dsp_scp_startup(codec);
+
+	if (spec->dsp_state != DSP_DOWNLOADED)
+		return;
+
+	sbz_dsp_scp_startup(codec);
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
 {
-	chipio_set_control_flag(codec, CONTROL_FLAG_IDLE_ENABLE, 0);
-	chipio_set_control_flag(codec, CONTROL_FLAG_PORT_A_COMMON_MODE, 0);
-	chipio_set_control_flag(codec, CONTROL_FLAG_PORT_D_COMMON_MODE, 0);
-	chipio_set_control_flag(codec, CONTROL_FLAG_PORT_A_10KOHM_LOAD, 0);
-	chipio_set_control_flag(codec, CONTROL_FLAG_PORT_D_10KOHM_LOAD, 0);
-	chipio_set_control_flag(codec, CONTROL_FLAG_ADC_C_HIGH_PASS, 1);
+	struct ca0132_spec *spec = codec->spec;
+
+	if (spec->use_alt_functions) {
+		chipio_set_control_flag(codec, CONTROL_FLAG_DSP_96KHZ, 1);
+		chipio_set_control_flag(codec, CONTROL_FLAG_DAC_96KHZ, 1);
+		chipio_set_control_flag(codec, CONTROL_FLAG_ADC_B_96KHZ, 1);
+		chipio_set_control_flag(codec, CONTROL_FLAG_ADC_C_96KHZ, 1);
+		chipio_set_control_flag(codec, CONTROL_FLAG_SRC_RATE_96KHZ, 1);
+		chipio_set_control_flag(codec, CONTROL_FLAG_IDLE_ENABLE, 0);
+		chipio_set_control_flag(codec, CONTROL_FLAG_SPDIF2OUT, 0);
+		chipio_set_control_flag(codec,
+				CONTROL_FLAG_PORT_D_10KOHM_LOAD, 0);
+		chipio_set_control_flag(codec,
+				CONTROL_FLAG_PORT_A_10KOHM_LOAD, 1);
+	} else {
+		chipio_set_control_flag(codec, CONTROL_FLAG_IDLE_ENABLE, 0);
+		chipio_set_control_flag(codec,
+				CONTROL_FLAG_PORT_A_COMMON_MODE, 0);
+		chipio_set_control_flag(codec,
+				CONTROL_FLAG_PORT_D_COMMON_MODE, 0);
+		chipio_set_control_flag(codec,
+				CONTROL_FLAG_PORT_A_10KOHM_LOAD, 0);
+		chipio_set_control_flag(codec,
+				CONTROL_FLAG_PORT_D_10KOHM_LOAD, 0);
+		chipio_set_control_flag(codec, CONTROL_FLAG_ADC_C_HIGH_PASS, 1);
+	}
 }
 
 /*
@@ -4399,6 +5061,16 @@ static void ca0132_init_flags(struct hda_codec *codec)
  */
 static void ca0132_init_params(struct hda_codec *codec)
 {
+	struct ca0132_spec *spec = codec->spec;
+
+	if (spec->use_alt_functions) {
+		chipio_set_conn_rate(codec, MEM_CONNID_WUH, SR_48_000);
+		chipio_set_conn_rate(codec, 0x0B, SR_48_000);
+		chipio_set_control_param(codec, CONTROL_PARAM_SPDIF1_SOURCE, 0);
+		chipio_set_control_param(codec, 0, 0);
+		chipio_set_control_param(codec, CONTROL_PARAM_VIP_SOURCE, 0);
+	}
+
 	chipio_set_control_param(codec, CONTROL_PARAM_PORTA_160OHM_GAIN, 6);
 	chipio_set_control_param(codec, CONTROL_PARAM_PORTD_160OHM_GAIN, 6);
 }
@@ -4490,13 +5162,17 @@ static void ca0132_download_dsp(struct hda_codec *codec)
 		return; /* don't retry failures */
 
 	chipio_enable_clocks(codec);
-	spec->dsp_state = DSP_DOWNLOADING;
-	if (!ca0132_download_dsp_images(codec))
-		spec->dsp_state = DSP_DOWNLOAD_FAILED;
-	else
-		spec->dsp_state = DSP_DOWNLOADED;
+	if (spec->dsp_state != DSP_DOWNLOADED) {
+		spec->dsp_state = DSP_DOWNLOADING;
+
+		if (!ca0132_download_dsp_images(codec))
+			spec->dsp_state = DSP_DOWNLOAD_FAILED;
+		else
+			spec->dsp_state = DSP_DOWNLOADED;
+	}
 
-	if (spec->dsp_state == DSP_DOWNLOADED)
+	/* For codecs using alt functions, this is already done earlier */
+	if (spec->dsp_state == DSP_DOWNLOADED && (!spec->use_alt_functions))
 		ca0132_set_dsp_msr(codec, true);
 }
 
@@ -4543,7 +5219,7 @@ static void ca0132_init_unsol(struct hda_codec *codec)
 	snd_hda_jack_detect_enable_callback(codec, UNSOL_TAG_DSP,
 					    ca0132_process_dsp_response);
 	/* Front headphone jack detection */
-	if (spec->quirk == QUIRK_SBZ || spec->quirk == QUIRK_R3DI)
+	if (spec->use_alt_functions)
 		snd_hda_jack_detect_enable_callback(codec,
 			spec->unsol_tag_front_hp, hp_callback);
 }
@@ -4569,6 +5245,7 @@ static struct hda_verb ca0132_base_exit_verbs[] = {
 };
 
 /* Other verbs tables. Sends after DSP download. */
+
 static struct hda_verb ca0132_init_verbs0[] = {
 	/* chip init verbs */
 	{0x15, 0x70D, 0xF0},
@@ -4598,8 +5275,27 @@ static struct hda_verb ca0132_init_verbs0[] = {
 	{0x15, 0x546, 0xC9},
 	{0x15, 0x53B, 0xCE},
 	{0x15, 0x5E8, 0xC9},
-	{0x15, 0x717, 0x0D},
-	{0x15, 0x718, 0x20},
+	{}
+};
+
+/* Extra init verbs for SBZ */
+static struct hda_verb sbz_init_verbs[] = {
+	{0x15, 0x70D, 0x20},
+	{0x15, 0x70E, 0x19},
+	{0x15, 0x707, 0x00},
+	{0x15, 0x539, 0xCE},
+	{0x15, 0x546, 0xC9},
+	{0x15, 0x70D, 0xB7},
+	{0x15, 0x70E, 0x09},
+	{0x15, 0x707, 0x10},
+	{0x15, 0x70D, 0xAF},
+	{0x15, 0x70E, 0x09},
+	{0x15, 0x707, 0x01},
+	{0x15, 0x707, 0x05},
+	{0x15, 0x70D, 0x73},
+	{0x15, 0x70E, 0x09},
+	{0x15, 0x707, 0x14},
+	{0x15, 0x6FF, 0xC4},
 	{}
 };
 
@@ -4716,12 +5412,16 @@ static void sbz_gpio_shutdown_commands(struct hda_codec *codec, int dir,
 
 static void sbz_exit_chip(struct hda_codec *codec)
 {
+	chipio_set_stream_control(codec, 0x03, 0);
+	chipio_set_stream_control(codec, 0x04, 0);
 
 	/* Mess with GPIO */
 	sbz_gpio_shutdown_commands(codec, 0x07, 0x07, -1);
 	sbz_gpio_shutdown_commands(codec, 0x07, 0x07, 0x05);
 	sbz_gpio_shutdown_commands(codec, 0x07, 0x07, 0x01);
 
+	chipio_set_stream_control(codec, 0x14, 0);
+	chipio_set_stream_control(codec, 0x0C, 0);
 
 	chipio_set_conn_rate(codec, 0x41, SR_192_000);
 	chipio_set_conn_rate(codec, 0x91, SR_192_000);
@@ -4732,6 +5432,7 @@ static void sbz_exit_chip(struct hda_codec *codec)
 	sbz_gpio_shutdown_commands(codec, 0x07, 0x07, 0x07);
 	sbz_gpio_shutdown_commands(codec, 0x07, 0x07, 0x06);
 
+	chipio_set_stream_control(codec, 0x0C, 0);
 
 	chipio_set_control_param(codec, 0x0D, 0x24);
 
@@ -4758,28 +5459,264 @@ static void ca0132_exit_chip(struct hda_codec *codec)
 		dsp_reset(codec);
 }
 
+/*
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
+ * This is for the extra volume verbs 0x797 (left) and 0x798 (right). These add
+ * extra precision for decibel values. If you had the dB value in floating point
+ * you would take the value after the decimal point, multiply by 64, and divide
+ * by 2. So for 8.59, it's (59 * 64) / 100. Useful if someone wanted to
+ * implement fixed point or floating point dB volumes. For now, I'll set them
+ * to 0 just incase a value has lingered from a boot into Windows.
+ */
+static void ca0132_alt_vol_setup(struct hda_codec *codec)
+{
+	snd_hda_codec_write(codec, 0x02, 0, 0x797, 0x00);
+	snd_hda_codec_write(codec, 0x02, 0, 0x798, 0x00);
+	snd_hda_codec_write(codec, 0x03, 0, 0x797, 0x00);
+	snd_hda_codec_write(codec, 0x03, 0, 0x798, 0x00);
+	snd_hda_codec_write(codec, 0x04, 0, 0x797, 0x00);
+	snd_hda_codec_write(codec, 0x04, 0, 0x798, 0x00);
+	snd_hda_codec_write(codec, 0x07, 0, 0x797, 0x00);
+	snd_hda_codec_write(codec, 0x07, 0, 0x798, 0x00);
+}
+
+/*
+ * Extra commands that don't really fit anywhere else.
+ */
+static void sbz_pre_dsp_setup(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	writel(0x00820680, spec->mem_base + 0x01C);
+	writel(0x00820680, spec->mem_base + 0x01C);
+
+	snd_hda_codec_write(codec, 0x15, 0, 0xd00, 0xfc);
+	snd_hda_codec_write(codec, 0x15, 0, 0xd00, 0xfd);
+	snd_hda_codec_write(codec, 0x15, 0, 0xd00, 0xfe);
+	snd_hda_codec_write(codec, 0x15, 0, 0xd00, 0xff);
+
+	chipio_write(codec, 0x18b0a4, 0x000000c2);
+
+	snd_hda_codec_write(codec, 0x11, 0,
+			AC_VERB_SET_PIN_WIDGET_CONTROL, 0x44);
+}
+
+/*
+ * Extra commands that don't really fit anywhere else.
+ */
+static void r3di_pre_dsp_setup(struct hda_codec *codec)
+{
+	chipio_write(codec, 0x18b0a4, 0x000000c2);
+
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x1E);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_HIGH, 0x1C);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_DATA_WRITE, 0x5B);
+
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x20);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_HIGH, 0x19);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_DATA_WRITE, 0x00);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_DATA_WRITE, 0x40);
+
+	snd_hda_codec_write(codec, 0x11, 0,
+			AC_VERB_SET_PIN_WIDGET_CONTROL, 0x04);
+}
+
+
+/*
+ * These are sent before the DSP is downloaded. Not sure
+ * what they do, or if they're necessary. Could possibly
+ * be removed. Figure they're better to leave in.
+ */
+static void sbz_region2_startup(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	writel(0x00000000, spec->mem_base + 0x400);
+	writel(0x00000000, spec->mem_base + 0x408);
+	writel(0x00000000, spec->mem_base + 0x40C);
+	writel(0x00880680, spec->mem_base + 0x01C);
+	writel(0x00000083, spec->mem_base + 0xC0C);
+	writel(0x00000030, spec->mem_base + 0xC00);
+	writel(0x00000000, spec->mem_base + 0xC04);
+	writel(0x00000003, spec->mem_base + 0xC0C);
+	writel(0x00000003, spec->mem_base + 0xC0C);
+	writel(0x00000003, spec->mem_base + 0xC0C);
+	writel(0x00000003, spec->mem_base + 0xC0C);
+	writel(0x000000C1, spec->mem_base + 0xC08);
+	writel(0x000000F1, spec->mem_base + 0xC08);
+	writel(0x00000001, spec->mem_base + 0xC08);
+	writel(0x000000C7, spec->mem_base + 0xC08);
+	writel(0x000000C1, spec->mem_base + 0xC08);
+	writel(0x00000080, spec->mem_base + 0xC04);
+}
+
+/*
+ * Extra init functions for alternative ca0132 codecs. Done
+ * here so they don't clutter up the main ca0132_init function
+ * anymore than they have to.
+ */
+static void ca0132_alt_init(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	ca0132_alt_vol_setup(codec);
+
+	switch (spec->quirk) {
+	case QUIRK_SBZ:
+		codec_dbg(codec, "SBZ alt_init");
+		ca0132_gpio_init(codec);
+		sbz_pre_dsp_setup(codec);
+		snd_hda_sequence_write(codec, spec->chip_init_verbs);
+		snd_hda_sequence_write(codec, spec->sbz_init_verbs);
+		break;
+	case QUIRK_R3DI:
+		codec_dbg(codec, "R3DI alt_init");
+		ca0132_gpio_init(codec);
+		ca0132_gpio_setup(codec);
+		r3di_gpio_dsp_status_set(codec, R3DI_DSP_DOWNLOADING);
+		r3di_pre_dsp_setup(codec);
+		snd_hda_sequence_write(codec, spec->chip_init_verbs);
+		snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0, 0x6FF, 0xC4);
+		break;
+	}
+}
+
 static int ca0132_init(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
 	int i;
+	bool dsp_loaded;
+
+	/*
+	 * If the DSP is already downloaded, and init has been entered again,
+	 * there's only two reasons for it. One, the codec has awaken from a
+	 * suspended state, and in that case dspload_is_loaded will return
+	 * false, and the init will be ran again. The other reason it gets
+	 * re entered is on startup for some reason it triggers a suspend and
+	 * resume state. In this case, it will check if the DSP is downloaded,
+	 * and not run the init function again. For codecs using alt_functions,
+	 * it will check if the DSP is loaded properly.
+	 */
+	if (spec->dsp_state == DSP_DOWNLOADED) {
+		dsp_loaded = dspload_is_loaded(codec);
+		if (!dsp_loaded) {
+			spec->dsp_reload = true;
+			spec->dsp_state = DSP_DOWNLOAD_INIT;
+		} else {
+			if (spec->quirk == QUIRK_SBZ)
+				sbz_dsp_startup_check(codec);
+			return 0;
+		}
+	}
 
 	if (spec->dsp_state != DSP_DOWNLOAD_FAILED)
 		spec->dsp_state = DSP_DOWNLOAD_INIT;
 	spec->curr_chip_addx = INVALID_CHIP_ADDRESS;
 
+	if (spec->quirk == QUIRK_SBZ)
+		sbz_region2_startup(codec);
+
 	snd_hda_power_up_pm(codec);
 
 	ca0132_init_unsol(codec);
-
 	ca0132_init_params(codec);
 	ca0132_init_flags(codec);
+
 	snd_hda_sequence_write(codec, spec->base_init_verbs);
+
+	if (spec->quirk != QUIRK_NONE)
+		ca0132_alt_init(codec);
+
 	ca0132_download_dsp(codec);
+
 	ca0132_refresh_widget_caps(codec);
-	ca0132_setup_defaults(codec);
-	ca0132_init_analog_mic2(codec);
-	ca0132_init_dmic(codec);
+
+	if (spec->quirk == QUIRK_SBZ)
+		writew(0x0107, spec->mem_base + 0x320);
+
+	switch (spec->quirk) {
+	case QUIRK_R3DI:
+		r3di_setup_defaults(codec);
+		break;
+	case QUIRK_NONE:
+	case QUIRK_ALIENWARE:
+		ca0132_setup_defaults(codec);
+		ca0132_init_analog_mic2(codec);
+		ca0132_init_dmic(codec);
+		break;
+	}
 
 	for (i = 0; i < spec->num_outputs; i++)
 		init_output(codec, spec->out_pins[i], spec->dacs[0]);
@@ -4791,7 +5728,19 @@ static int ca0132_init(struct hda_codec *codec)
 
 	init_input(codec, cfg->dig_in_pin, spec->dig_in);
 
-	snd_hda_sequence_write(codec, spec->chip_init_verbs);
+	if (!spec->use_alt_functions) {
+		snd_hda_sequence_write(codec, spec->chip_init_verbs);
+		snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_PARAM_EX_ID_SET, 0x0D);
+		snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_PARAM_EX_VALUE_SET, 0x20);
+	}
+
+	if (spec->quirk == QUIRK_SBZ) {
+		ca0132_gpio_setup(codec);
+		sbz_setup_defaults(codec);
+	}
+
 	snd_hda_sequence_write(codec, spec->spec_init_verbs);
 
 	ca0132_select_out(codec);
@@ -4799,6 +5748,15 @@ static int ca0132_init(struct hda_codec *codec)
 
 	snd_hda_jack_report_sync(codec);
 
+	/*
+	 * Re set the PlayEnhancement switch on a resume event, because the
+	 * controls will not be reloaded.
+	 */
+	if (spec->dsp_reload) {
+		spec->dsp_reload = false;
+		ca0132_pe_switch_set(codec);
+	}
+
 	snd_hda_power_down_pm(codec);
 
 	return 0;
@@ -4857,7 +5815,7 @@ static void ca0132_config(struct hda_codec *codec)
 	spec->multiout.dac_nids = spec->dacs;
 	spec->multiout.num_dacs = 3;
 
-	if (spec->quirk == QUIRK_NONE || spec->quirk == QUIRK_ALIENWARE)
+	if (!spec->use_alt_functions)
 		spec->multiout.max_channels = 2;
 	else
 		spec->multiout.max_channels = 6;
@@ -4985,6 +5943,8 @@ static int ca0132_prepare_verbs(struct hda_codec *codec)
 	struct ca0132_spec *spec = codec->spec;
 
 	spec->chip_init_verbs = ca0132_init_verbs0;
+	if (spec->quirk == QUIRK_SBZ)
+		spec->sbz_init_verbs = sbz_init_verbs;
 	spec->spec_init_verbs = kzalloc(sizeof(struct hda_verb) * NUM_SPEC_VERBS, GFP_KERNEL);
 	if (!spec->spec_init_verbs)
 		return -ENOMEM;
@@ -5057,10 +6017,22 @@ static int patch_ca0132(struct hda_codec *codec)
 			spec->quirk = QUIRK_NONE;
 		}
 	}
+
 	spec->dsp_state = DSP_DOWNLOAD_INIT;
 	spec->num_mixers = 1;
 	spec->mixers[0] = ca0132_mixer;
 
+	/* Setup whether or not to use alt functions */
+	switch (spec->quirk) {
+	case QUIRK_SBZ:
+	case QUIRK_R3DI:
+		spec->use_alt_functions = true;
+		break;
+	default:
+		spec->use_alt_functions = false;
+		break;
+	}
+
 	spec->base_init_verbs = ca0132_base_init_verbs;
 	spec->base_exit_verbs = ca0132_base_exit_verbs;
 
-- 
2.7.4
