Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D992C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FF8218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfBCNyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:54:14 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:54126 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728453AbfBCNuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:50:06 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9s-0003tg-VU; Sun, 03 Feb 2019 13:50:05 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9o-0007ML-Qg; Sun, 03 Feb 2019 14:50:00 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Takashi Iwai" <tiwai@suse.de>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.762786632@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 254/305] ALSA: usb-audio: Replace probing flag with
 active refcount
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

From: Takashi Iwai <tiwai@suse.de>

commit a6da499b76b1a75412f047ac388e9ffd69a5c55b upstream.

We can use active refcount for preventing autopm during probe.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/usb/card.c     | 12 ++++--------
 sound/usb/usbaudio.h |  1 -
 2 files changed, 4 insertions(+), 9 deletions(-)

--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -402,7 +402,7 @@ static int snd_usb_audio_create(struct u
 	chip->card = card;
 	chip->setup = device_setup[idx];
 	chip->autoclock = autoclock;
-	chip->probing = 1;
+	atomic_set(&chip->active, 1); /* avoid autopm during probing */
 	atomic_set(&chip->usage_count, 0);
 	atomic_set(&chip->shutdown, 0);
 
@@ -532,7 +532,7 @@ snd_usb_audio_probe(struct usb_device *d
 				goto __error;
 			}
 			chip = usb_chip[i];
-			chip->probing = 1;
+			atomic_inc(&chip->active); /* avoid autopm */
 			break;
 		}
 	}
@@ -588,7 +588,7 @@ snd_usb_audio_probe(struct usb_device *d
 
 	usb_chip[chip->index] = chip;
 	chip->num_interfaces++;
-	chip->probing = 0;
+	atomic_dec(&chip->active);
 	mutex_unlock(&register_mutex);
 	return chip;
 
@@ -596,7 +596,7 @@ snd_usb_audio_probe(struct usb_device *d
 	if (chip) {
 		if (!chip->num_interfaces)
 			snd_card_free(chip->card);
-		chip->probing = 0;
+		atomic_dec(&chip->active);
 	}
 	mutex_unlock(&register_mutex);
  __err_val:
@@ -712,8 +712,6 @@ int snd_usb_autoresume(struct snd_usb_au
 {
 	if (atomic_read(&chip->shutdown))
 		return -EIO;
-	if (chip->probing)
-		return 0;
 	if (atomic_inc_return(&chip->active) == 1)
 		return usb_autopm_get_interface(chip->pm_intf);
 	return 0;
@@ -721,8 +719,6 @@ int snd_usb_autoresume(struct snd_usb_au
 
 void snd_usb_autosuspend(struct snd_usb_audio *chip)
 {
-	if (chip->probing)
-		return;
 	if (atomic_dec_and_test(&chip->active))
 		usb_autopm_put_interface(chip->pm_intf);
 }
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -37,7 +37,6 @@ struct snd_usb_audio {
 	struct usb_interface *pm_intf;
 	u32 usb_id;
 	struct mutex mutex;
-	unsigned int probing:1;
 	unsigned int autosuspended:1;	
 	atomic_t active;
 	atomic_t shutdown;

