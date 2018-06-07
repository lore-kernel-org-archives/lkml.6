Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ET/GEYg9GVveQAAAmS7hNA
	; Thu, 07 Jun 2018 14:14:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B42CF608B8; Thu,  7 Jun 2018 14:14:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 374566063F;
	Thu,  7 Jun 2018 14:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 374566063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933378AbeFGON6 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:13:58 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39512 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933157AbeFGOJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:38 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbM-0005hJ-6c; Thu, 07 Jun 2018 15:09:20 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbE-0003I8-78; Thu, 07 Jun 2018 15:09:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.352848545@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 388/410] ALSA: aloop: Fix access to not-yet-ready
 substream via cable
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 8e6b1a72a75bb5067ccb6b56d8ca4aa3a300a64e upstream.

In loopback_open() and loopback_close(), we assign and release the
substream object to the corresponding cable in a racy way.  It's
neither locked nor done in the right position.  The open callback
assigns the substream before its preparation finishes, hence the other
side of the cable may pick it up, which may lead to the invalid memory
access.

This patch addresses these: move the assignment to the end of the open
callback, and wrap with cable->lock for avoiding concurrent accesses.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/drivers/aloop.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -667,7 +667,9 @@ static void free_cable(struct snd_pcm_su
 		return;
 	if (cable->streams[!substream->stream]) {
 		/* other stream is still alive */
+		spin_lock_irq(&cable->lock);
 		cable->streams[substream->stream] = NULL;
+		spin_unlock_irq(&cable->lock);
 	} else {
 		/* free the cable */
 		loopback->cables[substream->number][dev] = NULL;
@@ -707,7 +709,6 @@ static int loopback_open(struct snd_pcm_
 		loopback->cables[substream->number][dev] = cable;
 	}
 	dpcm->cable = cable;
-	cable->streams[substream->stream] = dpcm;
 
 	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
 
@@ -739,6 +740,11 @@ static int loopback_open(struct snd_pcm_
 		runtime->hw = loopback_pcm_hardware;
 	else
 		runtime->hw = cable->hw;
+
+	spin_lock_irq(&cable->lock);
+	cable->streams[substream->stream] = dpcm;
+	spin_unlock_irq(&cable->lock);
+
  unlock:
 	if (err < 0) {
 		free_cable(substream);
