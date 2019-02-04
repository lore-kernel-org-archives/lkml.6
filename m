Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1569BC282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB237217FA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277136;
	bh=1ZZH699qjda+HDwUrecUvbcGcbl+74prKJVqdlSygo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VgcL2jk3Yh3M/4XX4bD5RSgMw30wKfL7b6oTyp7ohYLnHQo8gyxOsEuzfrMh5N8xO
	 bzr7yU4mySyHy6Q2v2GgRD0GXb/FuYOrWnCy0LQkR3kBXWgcbVfgN3XIgzDGJOXBUm
	 8HLogM+UTitI8xN1l7kE8x58Lw7KVD0BnSfkUWc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbfBDKpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:45:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:43644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731190AbfBDKpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:45:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A68C22176F;
        Mon,  4 Feb 2019 10:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277133;
        bh=1ZZH699qjda+HDwUrecUvbcGcbl+74prKJVqdlSygo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C8xddGchPYBnF/tt3UDmLj76uiRwgu/ffFkf6OW7mG5bW7ggKoik/UpXm67L8ZXVe
         s2x3JdKBaBbafNtoATtf/xjpPgOCWNvTm1S5M7Eh7uxyWMOk50pEV+BCjYfUHO6Y5j
         pFUM2cPYe/Ufx5BYnH5J2zlXtr7/K5/c3avyIWBw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 33/46] ALSA: hda/realtek - Fixed hp_pin no value
Date:   Mon,  4 Feb 2019 11:37:04 +0100
Message-Id: <20190204103614.493431937@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103608.651205056@linuxfoundation.org>
References: <20190204103608.651205056@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kailang Yang <kailang@realtek.com>

commit 693abe11aa6b27aed6eb8222162f8fb986325cef upstream.

Fix hp_pin always no value.

[More notes on the changes:

 The hp_pin value that is referred in alc294_hp_init() is always zero
 at the moment the function gets called, hence this is actually
 useless as in the current code.

 And, this kind of init sequence should be called from the codec init
 callback, instead of the parser function.  So, the first fix in this
 patch to move the call call into its own init_hook.

 OTOH, this function is needed to be called only once after the boot,
 and it'd take too long for invoking at each resume (where the init
 callback gets called).  So we add a new flag and invoke this only
 once as an additional fix.

 The one case is still not covered, though: S4 resume.  But this
 change itself won't lead to any regression in that regard, so we
 leave S4 issue as is for now and fix it later.  -- tiwai ]

Fixes: bde1a7459623 ("ALSA: hda/realtek - Fixed headphone issue for ALC700")
Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   78 ++++++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 33 deletions(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -118,6 +118,7 @@ struct alc_spec {
 	int codec_variant;	/* flag for other variants */
 	unsigned int has_alc5505_dsp:1;
 	unsigned int no_depop_delay:1;
+	unsigned int done_hp_init:1;
 
 	/* for PLL fix */
 	hda_nid_t pll_nid;
@@ -3213,6 +3214,48 @@ static void alc_default_shutup(struct hd
 	snd_hda_shutup_pins(codec);
 }
 
+static void alc294_hp_init(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+	hda_nid_t hp_pin = spec->gen.autocfg.hp_pins[0];
+	int i, val;
+
+	if (!hp_pin)
+		return;
+
+	snd_hda_codec_write(codec, hp_pin, 0,
+			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+
+	msleep(100);
+
+	snd_hda_codec_write(codec, hp_pin, 0,
+			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+
+	alc_update_coef_idx(codec, 0x6f, 0x000f, 0);/* Set HP depop to manual mode */
+	alc_update_coefex_idx(codec, 0x58, 0x00, 0x8000, 0x8000); /* HP depop procedure start */
+
+	/* Wait for depop procedure finish  */
+	val = alc_read_coefex_idx(codec, 0x58, 0x01);
+	for (i = 0; i < 20 && val & 0x0080; i++) {
+		msleep(50);
+		val = alc_read_coefex_idx(codec, 0x58, 0x01);
+	}
+	/* Set HP depop to auto mode */
+	alc_update_coef_idx(codec, 0x6f, 0x000f, 0x000b);
+	msleep(50);
+}
+
+static void alc294_init(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (!spec->done_hp_init) {
+		alc294_hp_init(codec);
+		spec->done_hp_init = true;
+	}
+	alc_default_init(codec);
+}
+
 static void alc5505_coef_set(struct hda_codec *codec, unsigned int index_reg,
 			     unsigned int val)
 {
@@ -6981,37 +7024,6 @@ static void alc269_fill_coef(struct hda_
 	alc_update_coef_idx(codec, 0x4, 0, 1<<11);
 }
 
-static void alc294_hp_init(struct hda_codec *codec)
-{
-	struct alc_spec *spec = codec->spec;
-	hda_nid_t hp_pin = spec->gen.autocfg.hp_pins[0];
-	int i, val;
-
-	if (!hp_pin)
-		return;
-
-	snd_hda_codec_write(codec, hp_pin, 0,
-			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
-
-	msleep(100);
-
-	snd_hda_codec_write(codec, hp_pin, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
-
-	alc_update_coef_idx(codec, 0x6f, 0x000f, 0);/* Set HP depop to manual mode */
-	alc_update_coefex_idx(codec, 0x58, 0x00, 0x8000, 0x8000); /* HP depop procedure start */
-
-	/* Wait for depop procedure finish  */
-	val = alc_read_coefex_idx(codec, 0x58, 0x01);
-	for (i = 0; i < 20 && val & 0x0080; i++) {
-		msleep(50);
-		val = alc_read_coefex_idx(codec, 0x58, 0x01);
-	}
-	/* Set HP depop to auto mode */
-	alc_update_coef_idx(codec, 0x6f, 0x000f, 0x000b);
-	msleep(50);
-}
-
 /*
  */
 static int patch_alc269(struct hda_codec *codec)
@@ -7148,7 +7160,7 @@ static int patch_alc269(struct hda_codec
 		spec->codec_variant = ALC269_TYPE_ALC294;
 		spec->gen.mixer_nid = 0; /* ALC2x4 does not have any loopback mixer path */
 		alc_update_coef_idx(codec, 0x6b, 0x0018, (1<<4) | (1<<3)); /* UAJ MIC Vref control by verb */
-		alc294_hp_init(codec);
+		spec->init_hook = alc294_init;
 		break;
 	case 0x10ec0300:
 		spec->codec_variant = ALC269_TYPE_ALC300;
@@ -7160,7 +7172,7 @@ static int patch_alc269(struct hda_codec
 		spec->codec_variant = ALC269_TYPE_ALC700;
 		spec->gen.mixer_nid = 0; /* ALC700 does not have any loopback mixer path */
 		alc_update_coef_idx(codec, 0x4a, 1 << 15, 0); /* Combo jack auto trigger control */
-		alc294_hp_init(codec);
+		spec->init_hook = alc294_init;
 		break;
 
 	}


