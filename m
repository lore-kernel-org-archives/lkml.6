Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E005AC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2ADD20878
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2ADD20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387553AbeGKMmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:42:14 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:56056 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732808AbeGKMmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:42:12 -0400
Received: from [148.252.241.226] (helo=ct-lt-1121.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fdENe-00042U-Q3; Wed, 11 Jul 2018 13:38:02 +0100
From:   Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
To:     tiwai@suse.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] ALSA: usb-audio: Unify virtual type units type to UAC3 values
Date:   Wed, 11 Jul 2018 13:37:54 +0100
Message-Id: <20180711123755.27182-5-jorge.sanjuan@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180711123755.27182-1-jorge.sanjuan@codethink.co.uk>
References: <20180711123755.27182-1-jorge.sanjuan@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Audio Control interface descriptor subtypes do not match
across all the UAC versions. That makes reusability of the
"virtual type" (Mixer, Processors, Selectors, etc) terminals
difficult. It also makes the mixer get the default names for
the virtual terminals wrong due to the overlap.

This patch proposes an unified approach by always using the most
comprehensive spec version to define them all (in this case UAC3).

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 sound/usb/mixer.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 39fde49e8749..87f18cb74ca3 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -675,16 +675,16 @@ static int get_term_name(struct snd_usb_audio *chip, struct usb_audio_term *iter
 		if (term_only)
 			return 0;
 		switch (iterm->type >> 16) {
-		case UAC_SELECTOR_UNIT:
+		case UAC3_SELECTOR_UNIT:
 			strcpy(name, "Selector");
 			return 8;
-		case UAC1_PROCESSING_UNIT:
+		case UAC3_PROCESSING_UNIT:
 			strcpy(name, "Process Unit");
 			return 12;
-		case UAC1_EXTENSION_UNIT:
+		case UAC3_EXTENSION_UNIT:
 			strcpy(name, "Ext Unit");
 			return 8;
-		case UAC_MIXER_UNIT:
+		case UAC3_MIXER_UNIT:
 			strcpy(name, "Mixer");
 			return 5;
 		default:
@@ -832,7 +832,7 @@ static int check_input_term(struct mixer_build *state, int id,
 			case UAC_MIXER_UNIT: {
 				struct uac_mixer_unit_descriptor *d = p1;
 
-				term->type = d->bDescriptorSubtype << 16; /* virtual type */
+				term->type = UAC3_MIXER_UNIT << 16; /* virtual type */
 				term->channels = uac_mixer_unit_bNrChannels(d);
 				term->chconfig = uac_mixer_unit_wChannelConfig(d, protocol);
 				term->name = uac_mixer_unit_iMixer(d);
@@ -845,15 +845,23 @@ static int check_input_term(struct mixer_build *state, int id,
 				err = check_input_term(state, d->baSourceID[0], term);
 				if (err < 0)
 					return err;
-				term->type = d->bDescriptorSubtype << 16; /* virtual type */
+				term->type = UAC3_SELECTOR_UNIT << 16; /* virtual type */
 				term->id = id;
 				term->name = uac_selector_unit_iSelector(d);
 				return 0;
 			}
 			case UAC1_PROCESSING_UNIT:
+			/* UAC2_EFFECT_UNIT */
+				if (protocol == UAC_VERSION_1)
+					term->type = UAC3_PROCESSING_UNIT << 16; /* virtual type */
+				else /* UAC_VERSION_2 */
+					term->type = UAC3_EFFECT_UNIT << 16; /* virtual type */
 			case UAC1_EXTENSION_UNIT:
 			/* UAC2_PROCESSING_UNIT_V2 */
-			/* UAC2_EFFECT_UNIT */
+				if (protocol == UAC_VERSION_1 && !term->type)
+					term->type = UAC3_EXTENSION_UNIT << 16; /* virtual type */
+				else if (protocol == UAC_VERSION_2 && !term->type)
+					term->type = UAC3_PROCESSING_UNIT << 16; /* virtual type */
 			case UAC2_EXTENSION_UNIT_V2: {
 				struct uac_processing_unit_descriptor *d = p1;
 
@@ -869,7 +877,9 @@ static int check_input_term(struct mixer_build *state, int id,
 					id = d->baSourceID[0];
 					break; /* continue to parse */
 				}
-				term->type = d->bDescriptorSubtype << 16; /* virtual type */
+				if (!term->type)
+					term->type = UAC3_EXTENSION_UNIT << 16; /* virtual type */
+
 				term->channels = uac_processing_unit_bNrChannels(d);
 				term->chconfig = uac_processing_unit_wChannelConfig(d, protocol);
 				term->name = uac_processing_unit_iProcessing(d, protocol);
@@ -878,7 +888,7 @@ static int check_input_term(struct mixer_build *state, int id,
 			case UAC2_CLOCK_SOURCE: {
 				struct uac_clock_source_descriptor *d = p1;
 
-				term->type = d->bDescriptorSubtype << 16; /* virtual type */
+				term->type = UAC3_CLOCK_SOURCE << 16; /* virtual type */
 				term->id = id;
 				term->name = d->iClockSource;
 				return 0;
@@ -923,7 +933,7 @@ static int check_input_term(struct mixer_build *state, int id,
 			case UAC3_CLOCK_SOURCE: {
 				struct uac3_clock_source_descriptor *d = p1;
 
-				term->type = d->bDescriptorSubtype << 16; /* virtual type */
+				term->type = UAC3_CLOCK_SOURCE << 16; /* virtual type */
 				term->id = id;
 				term->name = le16_to_cpu(d->wClockSourceStr);
 				return 0;
@@ -936,7 +946,7 @@ static int check_input_term(struct mixer_build *state, int id,
 					return err;
 
 				term->channels = err;
-				term->type = d->bDescriptorSubtype << 16; /* virtual type */
+				term->type = UAC3_MIXER_UNIT << 16; /* virtual type */
 
 				return 0;
 			}
@@ -947,7 +957,7 @@ static int check_input_term(struct mixer_build *state, int id,
 				err = check_input_term(state, d->baSourceID[0], term);
 				if (err < 0)
 					return err;
-				term->type = d->bDescriptorSubtype << 16; /* virtual type */
+				term->type = UAC3_SELECTOR_UNIT << 16; /* virtual type */
 				term->id = id;
 				term->name = 0; /* TODO: UAC3 Class-specific strings */
 
@@ -964,7 +974,7 @@ static int check_input_term(struct mixer_build *state, int id,
 				if (err < 0)
 					return err;
 
-				term->type = d->bDescriptorSubtype << 16; /* virtual type */
+				term->type = UAC3_PROCESSING_UNIT << 16; /* virtual type */
 				term->id = id;
 				term->name = 0; /* TODO: UAC3 Class-specific strings */
 
-- 
2.11.0

