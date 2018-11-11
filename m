Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782ECC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F0D2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F0D2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbeKLGCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:02:35 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52674 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726709AbeKLGCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:02:34 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt6-0000l4-1J; Sun, 11 Nov 2018 19:59:16 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsQ-0001V8-Rk; Sun, 11 Nov 2018 19:58:34 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Bo Chen" <chenbo@pdx.edu>,
        "Takashi Iwai" <tiwai@suse.de>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.328368160@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 104/366] ALSA: hda - Handle kzalloc() failure in
 snd_hda_attach_pcm_stream()
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Bo Chen <chenbo@pdx.edu>

commit a3aa60d511746bd6c0d0366d4eb90a7998bcde8b upstream.

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
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/pci/hda/hda_controller.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -998,8 +998,10 @@ static int azx_attach_pcm_stream(struct
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

