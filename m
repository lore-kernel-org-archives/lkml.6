Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750842AbeEaWgX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 18:36:23 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40593 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbeEaWgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 18:36:22 -0400
X-Google-Smtp-Source: ADUXVKL7pDCyV/PW0N40ymG5/mMw14nB0lcSp7SRCD3MpwLwgFRfY1xT3jq19XAs4JXHApYGadYdlA==
From: Bo Chen <chenbo@pdx.edu>
To: tiwai@suse.com
Cc: perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Bo Chen <chenbo@pdx.edu>
Subject: [PATCH] ALSA: hda - Handle kzalloc() failure in snd_hda_attach_pcm_stream()
Date: Thu, 31 May 2018 15:35:18 -0700
Message-Id: <20180531223518.18675-1-chenbo@pdx.edu>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When 'kzalloc()' fails in 'snd_hda_attach_pcm_stream()', a new pcm instance is
created without setting its operators via 'snd_pcm_set_ops()'. Following
operations on the new pcm instance can trigger kernel null pointer dereferences
and cause kernel oops.

This bug was found with my work on building a gray-box fault-injection tool for
linux-kernel-module binaries. A kernel null pointer dereference was confirmed
from line 'substream->ops->open()' in function 'snd_pcm_open_substream()' in
file 'sound/core/pcm_native.c'.

This patch fixes the bug by calling 'snd_device_free()' in the error handling
path of 'kzalloc()', which removes the new pcm instance from the snd card before
returns with an error code.

Signed-off-by: Bo Chen <chenbo@pdx.edu>
---
 sound/pci/hda/hda_controller.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index d1eb14842340..a12e594d4e3b 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -748,8 +748,10 @@ int snd_hda_attach_pcm_stream(struct hda_bus *_bus, struct hda_codec *codec,
 		return err;
 	strlcpy(pcm->name, cpcm->name, sizeof(pcm->name));
 	apcm = kzalloc(sizeof(*apcm), GFP_KERNEL);
-	if (apcm == NULL)
+	if (apcm == NULL) {
+		snd_device_free(chip->card, pcm);
 		return -ENOMEM;
+	}
 	apcm->chip = chip;
 	apcm->pcm = pcm;
 	apcm->codec = codec;
-- 
2.17.0
