Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DA021C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2FE2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2FE2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933766AbeFLOc0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:32:26 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:49580 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754196AbeFLOcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:32:22 -0400
Received: from [148.252.241.226] (helo=ct-lt-1121.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fSkLL-0000OB-3T; Tue, 12 Jun 2018 15:32:19 +0100
From:   Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
To:     tiwai@suse.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        ruslan.bilovol@gmail.com
Subject: [PATCH 2/2] ALSA: usb-audio: UAC3. Add insertion control for BADD.
Date:   Tue, 12 Jun 2018 15:32:01 +0100
Message-Id: <20180612143201.29988-3-jorge.sanjuan@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180612143201.29988-1-jorge.sanjuan@codethink.co.uk>
References: <20180612143201.29988-1-jorge.sanjuan@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HEADSET ADAPTER profile for BADD devices is meant to support
Insertion Control for the Input and Output Terminals of the headset.
Furthermore, this profile may also include the interrupt status pipe
to report changes on these terminals.

This patch creates the jack-detect controls for the Headset Adapter
profile and enables the interrupt status pipe creation for BADD devices.

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 sound/usb/mixer.c | 45 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 898afd3001ea..b1dcf6dfc27e 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1653,11 +1653,11 @@ static void build_feature_ctl_badd(struct usb_mixer_interface *mixer,
 			NULL, NULL, unitid, 0, 0);
 }
 
-static void get_connector_control_name(struct mixer_build *state,
+static void get_connector_control_name(struct usb_mixer_interface *mixer,
 				       struct usb_audio_term *term,
 				       bool is_input, char *name, int name_size)
 {
-	int name_len = get_term_name(state->chip, term, name, name_size, 0);
+	int name_len = get_term_name(mixer->chip, term, name, name_size, 0);
 
 	if (name_len == 0)
 		strlcpy(name, "Unknown", name_size);
@@ -1674,7 +1674,7 @@ static void get_connector_control_name(struct mixer_build *state,
 }
 
 /* Build a mixer control for a UAC connector control (jack-detect) */
-static void build_connector_control(struct mixer_build *state,
+static void build_connector_control(struct usb_mixer_interface *mixer,
 				    struct usb_audio_term *term, bool is_input)
 {
 	struct snd_kcontrol *kctl;
@@ -1683,7 +1683,7 @@ static void build_connector_control(struct mixer_build *state,
 	cval = kzalloc(sizeof(*cval), GFP_KERNEL);
 	if (!cval)
 		return;
-	snd_usb_mixer_elem_init_std(&cval->head, state->mixer, term->id);
+	snd_usb_mixer_elem_init_std(&cval->head, mixer, term->id);
 	/*
 	 * UAC2: The first byte from reading the UAC2_TE_CONNECTOR control returns the
 	 * number of channels connected.
@@ -1694,7 +1694,7 @@ static void build_connector_control(struct mixer_build *state,
 	 * This boolean ctl will simply report if any channels are connected
 	 * or not.
 	 */
-	if (state->mixer->protocol == UAC_VERSION_2)
+	if (mixer->protocol == UAC_VERSION_2)
 		cval->control = UAC2_TE_CONNECTOR;
 	else /* UAC_VERSION_3 */
 		cval->control = UAC3_TE_INSERTION;
@@ -1705,11 +1705,11 @@ static void build_connector_control(struct mixer_build *state,
 	cval->max = 1;
 	kctl = snd_ctl_new1(&usb_connector_ctl_ro, cval);
 	if (!kctl) {
-		usb_audio_err(state->chip, "cannot malloc kcontrol\n");
+		usb_audio_err(mixer->chip, "cannot malloc kcontrol\n");
 		kfree(cval);
 		return;
 	}
-	get_connector_control_name(state, term, is_input, kctl->id.name,
+	get_connector_control_name(mixer, term, is_input, kctl->id.name,
 				   sizeof(kctl->id.name));
 	kctl->private_free = snd_usb_mixer_elem_free;
 	snd_usb_mixer_add_control(&cval->head, kctl);
@@ -2042,7 +2042,7 @@ static int parse_audio_input_terminal(struct mixer_build *state, int unitid,
 
 	/* Check for jack detection. */
 	if (uac_v2v3_control_is_readable(bmctls, control))
-		build_connector_control(state, &iterm, true);
+		build_connector_control(state->mixer, &iterm, true);
 
 	return 0;
 }
@@ -2918,6 +2918,23 @@ static int snd_usb_mixer_controls_badd(struct usb_mixer_interface *mixer,
 				       UAC3_BADD_FU_ID7, map->map);
 	}
 
+	/* Insertion Control */
+	if (f->subclass == UAC3_FUNCTION_SUBCLASS_HEADSET_ADAPTER) {
+		struct usb_audio_term iterm, oterm;
+
+		/* Input Term - Insertion control */
+		memset(&iterm, 0, sizeof(iterm));
+		iterm.id = UAC3_BADD_IT_ID4;
+		iterm.type = UAC_BIDIR_TERMINAL_HEADSET;
+		build_connector_control(mixer, &iterm, true);
+
+		/* Output Term - Insertion control */
+		memset(&oterm, 0, sizeof(oterm));
+		oterm.id = UAC3_BADD_OT_ID3;
+		oterm.type = UAC_BIDIR_TERMINAL_HEADSET;
+		build_connector_control(mixer, &oterm, false);
+	}
+
 	return 0;
 }
 
@@ -2990,7 +3007,7 @@ static int snd_usb_mixer_controls(struct usb_mixer_interface *mixer)
 
 			if (uac_v2v3_control_is_readable(le16_to_cpu(desc->bmControls),
 							 UAC2_TE_CONNECTOR)) {
-				build_connector_control(&state, &state.oterm,
+				build_connector_control(state.mixer, &state.oterm,
 							false);
 			}
 		} else {  /* UAC_VERSION_3 */
@@ -3017,7 +3034,7 @@ static int snd_usb_mixer_controls(struct usb_mixer_interface *mixer)
 
 			if (uac_v2v3_control_is_readable(le32_to_cpu(desc->bmControls),
 							 UAC3_TE_INSERTION)) {
-				build_connector_control(&state, &state.oterm,
+				build_connector_control(state.mixer, &state.oterm,
 							false);
 			}
 		}
@@ -3321,10 +3338,12 @@ int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif,
 		err = snd_usb_mixer_controls(mixer);
 		if (err < 0)
 			goto _error;
-		err = snd_usb_mixer_status_create(mixer);
-		if (err < 0)
-			goto _error;
 	}
+
+	err = snd_usb_mixer_status_create(mixer);
+	if (err < 0)
+		goto _error;
+
 	err = create_keep_iface_ctl(mixer);
 	if (err < 0)
 		goto _error;
-- 
2.11.0

