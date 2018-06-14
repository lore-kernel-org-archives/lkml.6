Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6C62BC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B58F208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B58F208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936240AbeFNOGN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:06:13 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:36948 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936205AbeFNOGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:06:05 -0400
Received: from [148.252.241.226] (helo=ct-lt-1121.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fTSt0-0005OK-RP; Thu, 14 Jun 2018 15:06:02 +0100
From:   Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
To:     tiwai@suse.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        ruslan.bilovol@gmail.com
Subject: [PATCH v2 3/4] ALSA: usb-audio: UAC3. Add insertion control for BADD.
Date:   Thu, 14 Jun 2018 15:05:57 +0100
Message-Id: <20180614140558.28277-4-jorge.sanjuan@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180614140558.28277-1-jorge.sanjuan@codethink.co.uk>
References: <20180612143201.29988-1-jorge.sanjuan@codethink.co.uk>
 <20180614140558.28277-1-jorge.sanjuan@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HEADSET ADAPTER profile for BADD devices is meant to support
Insertion Control for the Input and Output Terminals of the headset.

This patch defines the BADD inferred input and output terminals and
builds the connector controls.

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 sound/usb/mixer.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 34fef71e0330..03b8a2ac93c8 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
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
 
-- 
2.11.0

