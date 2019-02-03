Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1AEC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D5302073D
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbfBCO26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:28:58 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55448 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729993AbfBCOUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:33 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIdM-0006K2-5h; Sun, 03 Feb 2019 14:20:32 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9V-0006sE-Tx; Sun, 03 Feb 2019 14:49:41 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Takashi Iwai" <tiwai@suse.de>,
        "Nicolas Huaman" <nicolas@herochao.de>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.374133913@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 063/305] ALSA: usb-audio: update quirk for B&W PX to
 remove microphone
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Huaman <nicolas@herochao.de>

commit c369c8db15d51fa175d2ba85928f79d16af6b562 upstream.

A quirk in snd-usb-audio was added to automate setting sample rate to
4800k and remove the previously exposed nonfunctional microphone for
the Bowers & Wilkins PX:
commit 240a8af929c7c57dcde28682725b29cf8474e8e5
https://lore.kernel.org/patchwork/patch/919689/

However the headphones where updated shortly after that to remove the
unintentional microphone functionality. I guess because of this the
headphones now crash when connecting them via USB while the quirk is
active. Dmesg:

snd-usb-audio: probe of 2-3:1.0 failed with error -22
usb 2-3: 2:1: cannot get min/max values for control 2 (id 2)

This patch removes the microfone and allows the headphones to connect
and work out of the box. It is based on the current mainline kernel
 and successfully applied an tested on my machine (4.18.10.arch1-1).

Fixes: 240a8af929c7 ("ALSA: usb-audio: Add a quirck for B&W PX headphones")
Signed-off-by: Nicolas Huaman <nicolas@herochao.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/usb/quirks-table.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3281,19 +3281,14 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_STANDARD_MIXER,
 			},
-			/* Capture */
-			{
-				.ifnum = 1,
-				.type = QUIRK_IGNORE_INTERFACE,
-			},
 			/* Playback */
 			{
-				.ifnum = 2,
+				.ifnum = 1,
 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
 				.data = &(const struct audioformat) {
 					.formats = SNDRV_PCM_FMTBIT_S16_LE,
 					.channels = 2,
-					.iface = 2,
+					.iface = 1,
 					.altsetting = 1,
 					.altset_idx = 1,
 					.attributes = UAC_EP_CS_ATTR_FILL_MAX |

