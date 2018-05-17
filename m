Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbeEQWKJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 18:10:09 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36785 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeEQWKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 18:10:08 -0400
X-Google-Smtp-Source: AB8JxZrPlFWmBKtQF6IWWHINrNeriIP3xhuyoZ3F/uRyjdZ7MEthiPt4WdhQ8/yYrce0tzTBp0eGkw==
From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb: stream: fix potential memory leak during uac3 interface parsing
Date: Fri, 18 May 2018 01:08:59 +0300
Message-Id: <1526594939-21084-1-git-send-email-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UAC3 channel map is created during interface parsing,
and in some cases was not freed in failure paths.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
---
 sound/usb/stream.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index bce3152..d16e1c2 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -982,13 +982,16 @@ static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
 
 	dev_err(&dev->dev, "%u:%d : bogus bTerminalLink %d\n",
 			iface_no, altno, as->bTerminalLink);
+	kfree(chmap);
 	return NULL;
 
 found_clock:
 	fp = audio_format_alloc_init(chip, alts, UAC_VERSION_3, iface_no,
 				     altset_idx, altno, num_channels, clock);
-	if (!fp)
+	if (!fp) {
+		kfree(chmap);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	fp->chmap = chmap;
 
@@ -1009,6 +1012,7 @@ static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
 							       iface_no);
 		/* ok, let's parse further... */
 		if (snd_usb_parse_audio_format_v3(chip, fp, as, stream) < 0) {
+			kfree(fp->chmap);
 			kfree(fp->rate_table);
 			kfree(fp);
 			return NULL;
-- 
1.9.1
