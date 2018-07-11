Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28852C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD8E20B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD8E20B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387589AbeGKMmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:42:38 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:56057 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387497AbeGKMmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:42:13 -0400
Received: from [148.252.241.226] (helo=ct-lt-1121.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fdENd-00042U-Uo; Wed, 11 Jul 2018 13:38:02 +0100
From:   Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
To:     tiwai@suse.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] ALSA: usb-audio: Add support for Selector Units in UAC3
Date:   Wed, 11 Jul 2018 13:37:51 +0100
Message-Id: <20180711123755.27182-2-jorge.sanjuan@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180711123755.27182-1-jorge.sanjuan@codethink.co.uk>
References: <20180711123755.27182-1-jorge.sanjuan@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for Selector Units and Clock Selector Units
defined in the new UAC3 spec.

Selector Units play a really important role in the new UAC3 spec as
Processing Units do not define an on/off switch control anymore.
This forces topology designers to add bypass paths in the topology
to enable/dissable the Processing Units.

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 sound/usb/mixer.c | 54 ++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 10 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index ca963e94ec03..a51f2320a3dd 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -940,6 +940,19 @@ static int check_input_term(struct mixer_build *state, int id,
 
 				return 0;
 			}
+			case UAC3_SELECTOR_UNIT:
+			case UAC3_CLOCK_SELECTOR: {
+				struct uac_selector_unit_descriptor *d = p1;
+				/* call recursively to retrieve the channel info */
+				err = check_input_term(state, d->baSourceID[0], term);
+				if (err < 0)
+					return err;
+				term->type = d->bDescriptorSubtype << 16; /* virtual type */
+				term->id = id;
+				term->name = 0; /* TODO: UAC3 Class-specific strings */
+
+				return 0;
+			}
 			default:
 				return -ENODEV;
 			}
@@ -2509,11 +2522,20 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
 	cval->res = 1;
 	cval->initialized = 1;
 
-	if (state->mixer->protocol == UAC_VERSION_1)
+	switch (state->mixer->protocol) {
+	case UAC_VERSION_1:
+	default:
 		cval->control = 0;
-	else /* UAC_VERSION_2 */
-		cval->control = (desc->bDescriptorSubtype == UAC2_CLOCK_SELECTOR) ?
-			UAC2_CX_CLOCK_SELECTOR : UAC2_SU_SELECTOR;
+		break;
+	case UAC_VERSION_2:
+	case UAC_VERSION_3:
+		if (desc->bDescriptorSubtype == UAC2_CLOCK_SELECTOR ||
+		    desc->bDescriptorSubtype == UAC3_CLOCK_SELECTOR)
+			cval->control = UAC2_CX_CLOCK_SELECTOR;
+		else /* UAC2/3_SELECTOR_UNIT */
+			cval->control = UAC2_SU_SELECTOR;
+		break;
+	}
 
 	namelist = kmalloc_array(desc->bNrInPins, sizeof(char *), GFP_KERNEL);
 	if (!namelist) {
@@ -2555,12 +2577,22 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
 	len = check_mapped_name(map, kctl->id.name, sizeof(kctl->id.name));
 	if (!len) {
 		/* no mapping ? */
+		switch (state->mixer->protocol) {
+		case UAC_VERSION_1:
+		case UAC_VERSION_2:
+		default:
 		/* if iSelector is given, use it */
-		nameid = uac_selector_unit_iSelector(desc);
-		if (nameid)
-			len = snd_usb_copy_string_desc(state->chip, nameid,
-						       kctl->id.name,
-						       sizeof(kctl->id.name));
+			nameid = uac_selector_unit_iSelector(desc);
+			if (nameid)
+				len = snd_usb_copy_string_desc(state->chip,
+							nameid, kctl->id.name,
+							sizeof(kctl->id.name));
+			break;
+		case UAC_VERSION_3:
+			/* TODO: Class-Specific strings not yet supported */
+			break;
+		}
+
 		/* ... or pick up the terminal name at next */
 		if (!len)
 			len = get_term_name(state->chip, &state->oterm,
@@ -2570,7 +2602,8 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
 			strlcpy(kctl->id.name, "USB", sizeof(kctl->id.name));
 
 		/* and add the proper suffix */
-		if (desc->bDescriptorSubtype == UAC2_CLOCK_SELECTOR)
+		if (desc->bDescriptorSubtype == UAC2_CLOCK_SELECTOR ||
+		    desc->bDescriptorSubtype == UAC3_CLOCK_SELECTOR)
 			append_ctl_name(kctl, " Clock Source");
 		else if ((state->oterm.type & 0xff00) == 0x0100)
 			append_ctl_name(kctl, " Capture Source");
@@ -2641,6 +2674,7 @@ static int parse_audio_unit(struct mixer_build *state, int unitid)
 			return parse_audio_mixer_unit(state, unitid, p1);
 		case UAC3_CLOCK_SOURCE:
 			return parse_clock_source_unit(state, unitid, p1);
+		case UAC3_SELECTOR_UNIT:
 		case UAC3_CLOCK_SELECTOR:
 			return parse_audio_selector_unit(state, unitid, p1);
 		case UAC3_FEATURE_UNIT:
-- 
2.11.0

