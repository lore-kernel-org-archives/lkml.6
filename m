Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753909AbeEHCc1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 22:32:27 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:39861 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754018AbeEHCcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 22:32:22 -0400
X-Google-Smtp-Source: AB8JxZpNLrvXD0j1hAnpeEwHafgBR40+8S3dAflN0bqNz2ZhOZzsvmqC9vDmEPiyRL+kGH/1Tu+2YA==
From: Connor McAdams <conmanx360@gmail.com>
Cc: o-takashi@sakamocchi.jp, Connor McAdams <conmanx360@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?q?J=C3=A9r=C3=A9my=20Lefaure?=
        <jeremy.lefaure@lse.epita.fr>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/13] ALSA: hda/ca0132: add the ability to set src_id on scp commands
Date: Mon,  7 May 2018 22:31:17 -0400
Message-Id: <1525746683-18535-10-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525746683-18535-1-git-send-email-conmanx360@gmail.com>
References: <1525746683-18535-1-git-send-email-conmanx360@gmail.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the ability to change the src_id on scp commands, which
is used in the dsp setup of the Recon3Di and the Sound Blaster Z. It
also makes sure to maintain backwards compatibility with the older
dspio_set_uint_param function, and sets it's src to the default 0x20.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 86 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 74 insertions(+), 12 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 7a9d505..878bbf7 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1579,8 +1579,8 @@ static int dspio_send_scp_message(struct hda_codec *codec,
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
@@ -1604,7 +1604,7 @@ static int dspio_scp(struct hda_codec *codec,
 		return -EINVAL;
 	}
 
-	scp_send.hdr = make_scp_header(mod_id, 0x20, (dir == SCP_GET), req,
+	scp_send.hdr = make_scp_header(mod_id, src_id, (dir == SCP_GET), req,
 				       0, 0, 0, len/sizeof(unsigned int));
 	if (data != NULL && len > 0) {
 		len = min((unsigned int)(sizeof(scp_send.data)), len);
@@ -1661,15 +1661,24 @@ static int dspio_scp(struct hda_codec *codec,
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
@@ -1681,8 +1690,9 @@ static int dspio_alloc_dma_chan(struct hda_codec *codec, unsigned int *dma_chan)
 	unsigned int size = sizeof(dma_chan);
 
 	codec_dbg(codec, "     dspio_alloc_dma_chan() -- begin\n");
-	status = dspio_scp(codec, MASTERCONTROL, MASTERCONTROL_ALLOC_DMA_CHAN,
-			SCP_GET, NULL, 0, dma_chan, &size);
+	status = dspio_scp(codec, MASTERCONTROL, 0x20,
+			MASTERCONTROL_ALLOC_DMA_CHAN, SCP_GET, NULL, 0,
+			dma_chan, &size);
 
 	if (status < 0) {
 		codec_dbg(codec, "dspio_alloc_dma_chan: SCP Failed\n");
@@ -1711,8 +1721,9 @@ static int dspio_free_dma_chan(struct hda_codec *codec, unsigned int dma_chan)
 	codec_dbg(codec, "     dspio_free_dma_chan() -- begin\n");
 	codec_dbg(codec, "dspio_free_dma_chan: chan=%d\n", dma_chan);
 
-	status = dspio_scp(codec, MASTERCONTROL, MASTERCONTROL_ALLOC_DMA_CHAN,
-			   SCP_SET, &dma_chan, sizeof(dma_chan), NULL, &dummy);
+	status = dspio_scp(codec, MASTERCONTROL, 0x20,
+			MASTERCONTROL_ALLOC_DMA_CHAN, SCP_SET, &dma_chan,
+			sizeof(dma_chan), NULL, &dummy);
 
 	if (status < 0) {
 		codec_dbg(codec, "dspio_free_dma_chan: SCP Failed\n");
@@ -3226,7 +3237,7 @@ static int tuning_ctl_set(struct hda_codec *codec, hda_nid_t nid,
 			break;
 
 	snd_hda_power_up(codec);
-	dspio_set_param(codec, ca0132_tuning_ctls[i].mid,
+	dspio_set_param(codec, ca0132_tuning_ctls[i].mid, 0x20,
 			ca0132_tuning_ctls[i].req,
 			&(lookup[idx]), sizeof(unsigned int));
 	snd_hda_power_down(codec);
@@ -4612,6 +4623,27 @@ static void ca0132_refresh_widget_caps(struct hda_codec *codec)
  * Recon3Di r3di_setup_defaults sub functions.
  */
 
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
 static void r3di_dsp_initial_mic_setup(struct hda_codec *codec)
 {
 	unsigned int tmp;
@@ -4729,6 +4761,34 @@ static void sbz_chipio_startup_data(struct hda_codec *codec)
 	mutex_unlock(&spec->chipio_mutex);
 }
 
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
 static void sbz_dsp_initial_mic_setup(struct hda_codec *codec)
 {
 	unsigned int tmp;
@@ -4807,6 +4867,7 @@ static void r3di_setup_defaults(struct hda_codec *codec)
 	if (spec->dsp_state != DSP_DOWNLOADED)
 		return;
 
+	r3di_dsp_scp_startup(codec);
 
 	r3di_dsp_initial_mic_setup(codec);
 
@@ -4851,6 +4912,7 @@ static void sbz_setup_defaults(struct hda_codec *codec)
 	if (spec->dsp_state != DSP_DOWNLOADED)
 		return;
 
+	sbz_dsp_scp_startup(codec);
 
 	sbz_init_analog_mics(codec);
 
-- 
2.7.4
