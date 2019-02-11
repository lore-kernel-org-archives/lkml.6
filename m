Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7F0C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12FA320844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895778;
	bh=WnQRRZ/qPBl+zLuETMzFCUyj14dN65E3QPOJPfn6BSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D6YAZWIAvHt6S6RoW8mOZjKzKDfLdtcqAu1rpCvHBZW/KxA63yLYts73SxB/9rUL6
	 MF+cfiZ0DiGaOklrHhNJKmltdz40etook7x0TnAReeB1tHpXuReHEBfX2J7TDAwAWl
	 oUAl9r13jGvhAw4iRzG6jY96OmWYl0lwyfNZYveE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731217AbfBKOgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:36:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:45234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730527AbfBKOgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:36:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E302A20818;
        Mon, 11 Feb 2019 14:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895772;
        bh=WnQRRZ/qPBl+zLuETMzFCUyj14dN65E3QPOJPfn6BSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fo4r5Fw9FzuNMQC+Nhv9giaoje1pInsi0llBxvP1HCZBEdRh9yZyPH9oNDv3JfRgE
         UqrzoEDo3s0PHGEt9v9vNKLzOQHb0FJMT91YfUNz2eTf5HHEAoNGoOUXHzb1Bs2rU5
         ofoEhRFdIWwG2ODDiIkENykepLmjkfOsCyIg/dzY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.20 318/352] ALSA: hda/realtek - Use a common helper for hp pin reference
Date:   Mon, 11 Feb 2019 15:19:05 +0100
Message-Id: <20190211141907.055650955@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 35a39f98567d8d3f1cea48f0f30de1a7e736b644 upstream.

Replace the open-codes in many places with a new common helper for
performing the same thing: referring to the primary headphone pin.

This eventually fixes the potentially missing headphone pin on some
weird devices, too.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   96 ++++++++++--------------------------------
 1 file changed, 24 insertions(+), 72 deletions(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -515,6 +515,15 @@ static void alc_auto_init_amp(struct hda
 	}
 }
 
+/* get a primary headphone pin if available */
+static hda_nid_t alc_get_hp_pin(struct alc_spec *spec)
+{
+	if (spec->gen.autocfg.hp_pins[0])
+		return spec->gen.autocfg.hp_pins[0];
+	if (spec->gen.autocfg.line_out_type == AC_JACK_HP_OUT)
+		return spec->gen.autocfg.line_out_pins[0];
+	return 0;
+}
 
 /*
  * Realtek SSID verification
@@ -725,9 +734,7 @@ do_sku:
 	 * 15   : 1 --> enable the function "Mute internal speaker
 	 *	        when the external headphone out jack is plugged"
 	 */
-	if (!spec->gen.autocfg.hp_pins[0] &&
-	    !(spec->gen.autocfg.line_out_pins[0] &&
-	      spec->gen.autocfg.line_out_type == AUTO_PIN_HP_OUT)) {
+	if (!alc_get_hp_pin(spec)) {
 		hda_nid_t nid;
 		tmp = (ass >> 11) & 0x3;	/* HP to chassis */
 		nid = ports[tmp];
@@ -2959,15 +2966,10 @@ static void alc282_restore_default_value
 static void alc282_init(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	hda_nid_t hp_pin = spec->gen.autocfg.hp_pins[0];
+	hda_nid_t hp_pin = alc_get_hp_pin(spec);
 	bool hp_pin_sense;
 	int coef78;
 
-	if (!spec->gen.autocfg.hp_outs && spec->gen.suppress_auto_mute) {
-		if (spec->gen.autocfg.line_out_type == AC_JACK_HP_OUT)
-			hp_pin = spec->gen.autocfg.line_out_pins[0];
-	}
-
 	alc282_restore_default_value(codec);
 
 	if (!hp_pin)
@@ -3001,15 +3003,10 @@ static void alc282_init(struct hda_codec
 static void alc282_shutup(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	hda_nid_t hp_pin = spec->gen.autocfg.hp_pins[0];
+	hda_nid_t hp_pin = alc_get_hp_pin(spec);
 	bool hp_pin_sense;
 	int coef78;
 
-	if (!spec->gen.autocfg.hp_outs && spec->gen.suppress_auto_mute) {
-		if (spec->gen.autocfg.line_out_type == AC_JACK_HP_OUT)
-			hp_pin = spec->gen.autocfg.line_out_pins[0];
-	}
-
 	if (!hp_pin) {
 		alc269_shutup(codec);
 		return;
@@ -3084,14 +3081,9 @@ static void alc283_restore_default_value
 static void alc283_init(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	hda_nid_t hp_pin = spec->gen.autocfg.hp_pins[0];
+	hda_nid_t hp_pin = alc_get_hp_pin(spec);
 	bool hp_pin_sense;
 
-	if (!spec->gen.autocfg.hp_outs) {
-		if (spec->gen.autocfg.line_out_type == AC_JACK_HP_OUT)
-			hp_pin = spec->gen.autocfg.line_out_pins[0];
-	}
-
 	alc283_restore_default_value(codec);
 
 	if (!hp_pin)
@@ -3125,14 +3117,9 @@ static void alc283_init(struct hda_codec
 static void alc283_shutup(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	hda_nid_t hp_pin = spec->gen.autocfg.hp_pins[0];
+	hda_nid_t hp_pin = alc_get_hp_pin(spec);
 	bool hp_pin_sense;
 
-	if (!spec->gen.autocfg.hp_outs) {
-		if (spec->gen.autocfg.line_out_type == AC_JACK_HP_OUT)
-			hp_pin = spec->gen.autocfg.line_out_pins[0];
-	}
-
 	if (!hp_pin) {
 		alc269_shutup(codec);
 		return;
@@ -3166,14 +3153,9 @@ static void alc283_shutup(struct hda_cod
 static void alc256_init(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	hda_nid_t hp_pin = spec->gen.autocfg.hp_pins[0];
+	hda_nid_t hp_pin = alc_get_hp_pin(spec);
 	bool hp_pin_sense;
 
-	if (!spec->gen.autocfg.hp_outs && spec->gen.suppress_auto_mute) {
-		if (spec->gen.autocfg.line_out_type == AC_JACK_HP_OUT)
-			hp_pin = spec->gen.autocfg.line_out_pins[0];
-	}
-
 	if (!hp_pin)
 		return;
 
@@ -3207,14 +3189,9 @@ static void alc256_init(struct hda_codec
 static void alc256_shutup(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	hda_nid_t hp_pin = spec->gen.autocfg.hp_pins[0];
+	hda_nid_t hp_pin = alc_get_hp_pin(spec);
 	bool hp_pin_sense;
 
-	if (!spec->gen.autocfg.hp_outs && spec->gen.suppress_auto_mute) {
-		if (spec->gen.autocfg.line_out_type == AC_JACK_HP_OUT)
-			hp_pin = spec->gen.autocfg.line_out_pins[0];
-	}
-
 	if (!hp_pin) {
 		alc269_shutup(codec);
 		return;
@@ -3248,14 +3225,9 @@ static void alc256_shutup(struct hda_cod
 static void alc225_init(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	hda_nid_t hp_pin = spec->gen.autocfg.hp_pins[0];
+	hda_nid_t hp_pin = alc_get_hp_pin(spec);
 	bool hp1_pin_sense, hp2_pin_sense;
 
-	if (!spec->gen.autocfg.hp_outs && spec->gen.suppress_auto_mute) {
-		if (spec->gen.autocfg.line_out_type == AC_JACK_HP_OUT)
-			hp_pin = spec->gen.autocfg.line_out_pins[0];
-	}
-
 	if (!hp_pin)
 		return;
 
@@ -3296,14 +3268,9 @@ static void alc225_init(struct hda_codec
 static void alc225_shutup(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	hda_nid_t hp_pin = spec->gen.autocfg.hp_pins[0];
+	hda_nid_t hp_pin = alc_get_hp_pin(spec);
 	bool hp1_pin_sense, hp2_pin_sense;
 
-	if (!spec->gen.autocfg.hp_outs && spec->gen.suppress_auto_mute) {
-		if (spec->gen.autocfg.line_out_type == AC_JACK_HP_OUT)
-			hp_pin = spec->gen.autocfg.line_out_pins[0];
-	}
-
 	if (!hp_pin) {
 		alc269_shutup(codec);
 		return;
@@ -3345,14 +3312,9 @@ static void alc225_shutup(struct hda_cod
 static void alc_default_init(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	hda_nid_t hp_pin = spec->gen.autocfg.hp_pins[0];
+	hda_nid_t hp_pin = alc_get_hp_pin(spec);
 	bool hp_pin_sense;
 
-	if (!spec->gen.autocfg.hp_outs && spec->gen.suppress_auto_mute) {
-		if (spec->gen.autocfg.line_out_type == AC_JACK_HP_OUT)
-			hp_pin = spec->gen.autocfg.line_out_pins[0];
-	}
-
 	if (!hp_pin)
 		return;
 
@@ -3379,14 +3341,9 @@ static void alc_default_init(struct hda_
 static void alc_default_shutup(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	hda_nid_t hp_pin = spec->gen.autocfg.hp_pins[0];
+	hda_nid_t hp_pin = alc_get_hp_pin(spec);
 	bool hp_pin_sense;
 
-	if (!spec->gen.autocfg.hp_outs && spec->gen.suppress_auto_mute) {
-		if (spec->gen.autocfg.line_out_type == AC_JACK_HP_OUT)
-			hp_pin = spec->gen.autocfg.line_out_pins[0];
-	}
-
 	if (!hp_pin) {
 		alc269_shutup(codec);
 		return;
@@ -3416,14 +3373,9 @@ static void alc_default_shutup(struct hd
 static void alc294_hp_init(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	hda_nid_t hp_pin = spec->gen.autocfg.hp_pins[0];
+	hda_nid_t hp_pin = alc_get_hp_pin(spec);
 	int i, val;
 
-	if (!spec->gen.autocfg.hp_outs && spec->gen.suppress_auto_mute) {
-		if (spec->gen.autocfg.line_out_type == AC_JACK_HP_OUT)
-			hp_pin = spec->gen.autocfg.line_out_pins[0];
-	}
-
 	if (!hp_pin)
 		return;
 
@@ -4825,7 +4777,7 @@ static void alc_update_headset_mode(stru
 	struct alc_spec *spec = codec->spec;
 
 	hda_nid_t mux_pin = spec->gen.imux_pins[spec->gen.cur_mux[0]];
-	hda_nid_t hp_pin = spec->gen.autocfg.hp_pins[0];
+	hda_nid_t hp_pin = alc_get_hp_pin(spec);
 
 	int new_headset_mode;
 
@@ -5104,7 +5056,7 @@ static void alc_fixup_tpt470_dock(struct
 static void alc_shutup_dell_xps13(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	int hp_pin = spec->gen.autocfg.hp_pins[0];
+	int hp_pin = alc_get_hp_pin(spec);
 
 	/* Prevent pop noises when headphones are plugged in */
 	snd_hda_codec_write(codec, hp_pin, 0,
@@ -5197,7 +5149,7 @@ static void alc271_hp_gate_mic_jack(stru
 
 	if (action == HDA_FIXUP_ACT_PROBE) {
 		int mic_pin = find_ext_mic_pin(codec);
-		int hp_pin = spec->gen.autocfg.hp_pins[0];
+		int hp_pin = alc_get_hp_pin(spec);
 
 		if (snd_BUG_ON(!mic_pin || !hp_pin))
 			return;


