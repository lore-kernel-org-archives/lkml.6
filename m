Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751652AbeECVoC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 17:44:02 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37713 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751493AbeECVn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 17:43:27 -0400
X-Google-Smtp-Source: AB8JxZp9nPsz67AN9vDTOaL2RI+cWypqmUACmYd4h4v6UKo9dDxQUX1hqiLZasy2abN7dVcLvs6XuQ==
From: Connor McAdams <conmanx360@gmail.com>
Cc: o-takashi@sakamocchi.jp, Connor McAdams <conmanx360@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?q?J=C3=A9r=C3=A9my=20Lefaure?=
        <jeremy.lefaure@lse.epita.fr>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] add ca0132_alt_set_vipsource
Date: Thu,  3 May 2018 17:42:49 -0400
Message-Id: <1525383771-11105-8-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525383771-11105-1-git-send-email-conmanx360@gmail.com>
References: <1525383771-11105-1-git-send-email-conmanx360@gmail.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add function to set vipsource on cards that use_alt_controls. Different
sequence. Also, add cvoice_switch_set at end of ca0132_select_in so that
when switching between inputs cvoice state is maintained.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 72 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 9d19a275..ba166cb 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -3969,6 +3969,71 @@ static int ca0132_set_vipsource(struct hda_codec *codec, int val)
 	return 1;
 }
 
+static int ca0132_alt_set_vipsource(struct hda_codec *codec, int val)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int tmp;
+
+	if (spec->dsp_state != DSP_DOWNLOADED)
+		return 0;
+
+	codec_dbg(codec, "ca0132_alt_set_vipsource");
+
+	chipio_set_stream_control(codec, 0x03, 0);
+	chipio_set_stream_control(codec, 0x04, 0);
+
+	/* if CrystalVoice is off, vipsource should be 0 */
+	if (!spec->effects_switch[CRYSTAL_VOICE - EFFECT_START_NID] ||
+	    (val == 0) || spec->in_enum_val == REAR_LINE_IN) {
+		codec_dbg(codec, "ca0132_alt_set_vipsource off.");
+		chipio_set_control_param(codec, CONTROL_PARAM_VIP_SOURCE, 0);
+
+		tmp = FLOAT_ZERO;
+		dspio_set_uint_param(codec, 0x80, 0x05, tmp);
+
+		chipio_set_conn_rate(codec, MEM_CONNID_MICIN1, SR_96_000);
+		chipio_set_conn_rate(codec, MEM_CONNID_MICOUT1, SR_96_000);
+		if (spec->quirk == QUIRK_R3DI)
+			chipio_set_conn_rate(codec, 0x0F, SR_96_000);
+
+
+		if (spec->in_enum_val == REAR_LINE_IN)
+			tmp = FLOAT_ZERO;
+		else {
+			if (spec->quirk == QUIRK_SBZ)
+				tmp = FLOAT_THREE;
+			else
+				tmp = FLOAT_ONE;
+		}
+
+		dspio_set_uint_param(codec, 0x80, 0x00, tmp);
+
+	} else {
+		codec_dbg(codec, "ca0132_alt_set_vipsource on.");
+		chipio_set_conn_rate(codec, MEM_CONNID_MICIN1, SR_16_000);
+		chipio_set_conn_rate(codec, MEM_CONNID_MICOUT1, SR_16_000);
+		if (spec->quirk == QUIRK_R3DI)
+			chipio_set_conn_rate(codec, 0x0F, SR_16_000);
+
+		if (spec->effects_switch[VOICE_FOCUS - EFFECT_START_NID])
+			tmp = FLOAT_TWO;
+		else
+			tmp = FLOAT_ONE;
+		dspio_set_uint_param(codec, 0x80, 0x00, tmp);
+
+		tmp = FLOAT_ONE;
+		dspio_set_uint_param(codec, 0x80, 0x05, tmp);
+
+		msleep(20);
+		chipio_set_control_param(codec, CONTROL_PARAM_VIP_SOURCE, val);
+	}
+
+	chipio_set_stream_control(codec, 0x03, 1);
+	chipio_set_stream_control(codec, 0x04, 1);
+
+	return 1;
+}
+
 /*
  * Select the active microphone.
  * If autodetect is enabled, mic will be selected based on jack detection.
@@ -4132,6 +4197,7 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
                 }
                 break;
         }
+	ca0132_cvoice_switch_set(codec);
 
         snd_hda_power_down_pm(codec);
         return 0;
@@ -4344,7 +4410,10 @@ static int ca0132_cvoice_switch_set(struct hda_codec *codec)
 
 	/* set correct vipsource */
 	oldval = stop_mic1(codec);
-	ret |= ca0132_set_vipsource(codec, 1);
+	if (spec->use_alt_functions)
+		ret |= ca0132_alt_set_vipsource(codec, 1);
+	else
+		ret |= ca0132_set_vipsource(codec, 1);
 	resume_mic1(codec, oldval);
 	return ret;
 }
@@ -6381,7 +6450,6 @@ static int ca0132_init(struct hda_codec *codec)
 		if (dsp_loaded) {
 			if (spec->quirk == QUIRK_SBZ)
 				sbz_dsp_startup_check(codec);
-
 			return 0;
 		} else {
 			spec->dsp_reload = true;
-- 
2.7.4
