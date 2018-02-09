Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeBIOvm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 09:51:42 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38907 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbeBIOvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 09:51:40 -0500
X-Google-Smtp-Source: AH8x227vEQn0qRrR6nmDIG8/J9SU046NiX+AYro8cGpRRQXskT4DptX4qjDL9IQTkQhZuuzbVr+X9A==
Subject: Re: [PATCH] ALSA: usb-audio: add implicit fb quirk for Behringer
 UFX1204
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, arvind.yadav.cs@gmail.com,
        bhumirks@gmail.com, perex@perex.cz, linux-kernel@vger.kernel.org
References: <0132cbb2-34f8-b85c-383d-d639d938c836@gmail.com>
 <s5htvut5p1q.wl-tiwai@suse.de>
From: Lassi Ylikojola <lassi.ylikojola@gmail.com>
Message-ID: <95a0b1fe-24e3-e902-8452-0b28c2c95315@gmail.com>
Date: Fri, 9 Feb 2018 16:51:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <s5htvut5p1q.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add quirk to ensure a sync endpoint is properly configured.
This patch is a fix for same symptoms on Behringer UFX1204 as patch
from Albertto Aquirre on Dec 8 2016 for Axe-Fx II.
Resending. Seems that there is a difference between git diff/commit versions 2.7.4 and 2.14.3.
I had to insert a line break with 2.4.13 to align properly(hopefully). 

Signed-off-by: Lassi Ylikojola <lassi.ylikojola@gmail.com>
---
 sound/usb/pcm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index b9c9a19f9588..116a6ccc5b31 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -357,6 +357,16 @@ static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
 
                alts = &iface->altsetting[1];
                goto add_sync_ep;
+       case USB_ID(0x1397, 0x0002):
+               ep = 0x81;
+               iface = usb_ifnum_to_if(dev, 1);
+
+               if (!iface || iface->num_altsetting == 0)
+                       return -EINVAL;
+
+               alts = &iface->altsetting[1];
+               goto add_sync_ep;
+
 
        }
        if (attr == USB_ENDPOINT_SYNC_ASYNC &&
-- 
2.14.3
