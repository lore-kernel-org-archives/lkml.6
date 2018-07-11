Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEC7C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0915F20B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0915F20B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387514AbeGKMmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:42:13 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:56061 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387498AbeGKMmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:42:12 -0400
Received: from [148.252.241.226] (helo=ct-lt-1121.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fdENf-00042U-3V; Wed, 11 Jul 2018 13:38:03 +0100
From:   Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
To:     tiwai@suse.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] ALSA: usb-audio: Tidy up logic for Processing Unit min/max values
Date:   Wed, 11 Jul 2018 13:37:55 +0100
Message-Id: <20180711123755.27182-6-jorge.sanjuan@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180711123755.27182-1-jorge.sanjuan@codethink.co.uk>
References: <20180711123755.27182-1-jorge.sanjuan@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch refactors the processing units min/max calculation logic
for the mixer controls and fixes an issue where the Mode Select
checking of the Up/Down mixers doesn't differentiate between the
UAC1 and UAC2 Control Selector (0x02) and the UAC3 one which is
different (0x01).

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 sound/usb/mixer.c | 58 +++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 87f18cb74ca3..73e811f86a95 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2376,25 +2376,49 @@ static int build_audio_procunit(struct mixer_build *state, int unitid,
 			cval->master_readonly = 1;
 
 		/* get min/max values */
-		if (type == UAC_PROCESS_UP_DOWNMIX && cval->control == UAC_UD_MODE_SELECT) {
-			__u8 *control_spec = uac_processing_unit_specific(desc, state->mixer->protocol);
-			/* FIXME: hard-coded */
-			cval->min = 1;
-			cval->max = control_spec[0];
-			cval->res = 1;
-			cval->initialized = 1;
-		} else {
-			if (type == USB_XU_CLOCK_RATE) {
-				/*
-				 * E-Mu USB 0404/0202/TrackerPre/0204
-				 * samplerate control quirk
-				 */
-				cval->min = 0;
-				cval->max = 5;
+		switch (type) {
+		case UAC_PROCESS_UP_DOWNMIX: {
+			bool mode_sel = false;
+
+			switch (state->mixer->protocol) {
+			case UAC_VERSION_1:
+			case UAC_VERSION_2:
+			default:
+				if (cval->control == UAC_UD_MODE_SELECT)
+					mode_sel = true;
+				break;
+			case UAC_VERSION_3:
+				if (cval->control == UAC3_UD_MODE_SELECT)
+					mode_sel = true;
+				break;
+			}
+
+			if (mode_sel) {
+				__u8 *control_spec = uac_processing_unit_specific(desc,
+								state->mixer->protocol);
+				cval->min = 1;
+				cval->max = control_spec[0];
 				cval->res = 1;
 				cval->initialized = 1;
-			} else
-				get_min_max(cval, valinfo->min_value);
+				break;
+			}
+
+			get_min_max(cval, valinfo->min_value);
+			break;
+		}
+		case USB_XU_CLOCK_RATE:
+			/*
+			 * E-Mu USB 0404/0202/TrackerPre/0204
+			 * samplerate control quirk
+			 */
+			cval->min = 0;
+			cval->max = 5;
+			cval->res = 1;
+			cval->initialized = 1;
+			break;
+		default:
+			get_min_max(cval, valinfo->min_value);
+			break;
 		}
 
 		kctl = snd_ctl_new1(&mixer_procunit_ctl, cval);
-- 
2.11.0

