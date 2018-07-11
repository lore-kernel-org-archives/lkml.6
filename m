Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF0CC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E0920B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E0920B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387527AbeGKMmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:42:13 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:56058 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387501AbeGKMmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:42:12 -0400
Received: from [148.252.241.226] (helo=ct-lt-1121.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fdENe-00042U-7W; Wed, 11 Jul 2018 13:38:02 +0100
From:   Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
To:     tiwai@suse.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] ALSA: usb-audio: Processing Unit controls parsing in UAC2
Date:   Wed, 11 Jul 2018 13:37:52 +0100
Message-Id: <20180711123755.27182-3-jorge.sanjuan@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180711123755.27182-1-jorge.sanjuan@codethink.co.uk>
References: <20180711123755.27182-1-jorge.sanjuan@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current support for UAC2 Processing Units does the parsing
as one control per bit in the bitmap. However, the UAC2 spec
defines the controls as bit pairs where b01 means read-only
and b11 means read/write control.

This patch fixes that and uses the helper functions for checking
controls readability/writability when the control is defined as
bit pairs (UAC2 and UAC3).

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 sound/usb/mixer.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index a51f2320a3dd..bfb3484096a6 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2300,8 +2300,16 @@ static int build_audio_procunit(struct mixer_build *state, int unitid,
 	for (valinfo = info->values; valinfo->control; valinfo++) {
 		__u8 *controls = uac_processing_unit_bmControls(desc, state->mixer->protocol);
 
-		if (!(controls[valinfo->control / 8] & (1 << ((valinfo->control % 8) - 1))))
-			continue;
+		if (state->mixer->protocol == UAC_VERSION_1) {
+			if (!(controls[valinfo->control / 8] &
+					(1 << ((valinfo->control % 8) - 1))))
+				continue;
+		} else { /* UAC_VERSION_2/3 */
+			if (!uac_v2v3_control_is_readable(controls[valinfo->control / 8],
+							  valinfo->control))
+				continue;
+		}
+
 		map = find_map(state->map, unitid, valinfo->control);
 		if (check_ignored_ctl(map))
 			continue;
@@ -2313,6 +2321,11 @@ static int build_audio_procunit(struct mixer_build *state, int unitid,
 		cval->val_type = valinfo->val_type;
 		cval->channels = 1;
 
+		if (state->mixer->protocol > UAC_VERSION_1 &&
+		    !uac_v2v3_control_is_writeable(controls[valinfo->control / 8],
+						   valinfo->control))
+			cval->master_readonly = 1;
+
 		/* get min/max values */
 		if (type == UAC_PROCESS_UP_DOWNMIX && cval->control == UAC_UD_MODE_SELECT) {
 			__u8 *control_spec = uac_processing_unit_specific(desc, state->mixer->protocol);
-- 
2.11.0

