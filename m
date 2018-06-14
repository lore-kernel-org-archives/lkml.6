Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 315DEC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E629D208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E629D208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936256AbeFNOGP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:06:15 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:36950 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936206AbeFNOGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:06:05 -0400
Received: from [148.252.241.226] (helo=ct-lt-1121.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fTSt1-0005OK-4O; Thu, 14 Jun 2018 15:06:03 +0100
From:   Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
To:     tiwai@suse.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        ruslan.bilovol@gmail.com
Subject: [PATCH v2 4/4] ALSA: usb-audio: Always create the interrupt pipe for the mixer
Date:   Thu, 14 Jun 2018 15:05:58 +0100
Message-Id: <20180614140558.28277-5-jorge.sanjuan@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180614140558.28277-1-jorge.sanjuan@codethink.co.uk>
References: <20180612143201.29988-1-jorge.sanjuan@codethink.co.uk>
 <20180614140558.28277-1-jorge.sanjuan@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An UAC3 BADD device may also include an interrupt status pipe
to report changes on the HEADSET ADAPTER terminals. The creation
of the status pipe is dependent on the device reporting that it
has it.

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 sound/usb/mixer.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 03b8a2ac93c8..b1dcf6dfc27e 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -3338,10 +3338,12 @@ int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif,
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

