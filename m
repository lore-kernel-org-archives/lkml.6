Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200CFC282DB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F972073D
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbfBCOUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:20:11 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55282 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729321AbfBCOUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:04 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIct-00067y-LB; Sun, 03 Feb 2019 14:20:03 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9l-0007Hz-PW; Sun, 03 Feb 2019 14:49:57 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Takashi Sakamoto" <o-takashi@sakamocchi.jp>,
        "Takashi Iwai" <tiwai@suse.de>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.40226833@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 229/305] ALSA: sparc: Fix invalid snd_free_pages() at
 error path
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

commit 9a20332ab373b1f8f947e0a9c923652b32dab031 upstream.

Some spurious calls of snd_free_pages() have been overlooked and
remain in the error paths of sparc cs4231 driver code.  Since
runtime->dma_area is managed by the PCM core helper, we shouldn't
release manually.

Drop the superfluous calls.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/sparc/cs4231.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/sound/sparc/cs4231.c
+++ b/sound/sparc/cs4231.c
@@ -1146,10 +1146,8 @@ static int snd_cs4231_playback_open(stru
 	runtime->hw = snd_cs4231_playback;
 
 	err = snd_cs4231_open(chip, CS4231_MODE_PLAY);
-	if (err < 0) {
-		snd_free_pages(runtime->dma_area, runtime->dma_bytes);
+	if (err < 0)
 		return err;
-	}
 	chip->playback_substream = substream;
 	chip->p_periods_sent = 0;
 	snd_pcm_set_sync(substream);
@@ -1167,10 +1165,8 @@ static int snd_cs4231_capture_open(struc
 	runtime->hw = snd_cs4231_capture;
 
 	err = snd_cs4231_open(chip, CS4231_MODE_RECORD);
-	if (err < 0) {
-		snd_free_pages(runtime->dma_area, runtime->dma_bytes);
+	if (err < 0)
 		return err;
-	}
 	chip->capture_substream = substream;
 	chip->c_periods_sent = 0;
 	snd_pcm_set_sync(substream);

