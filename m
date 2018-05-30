Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753738AbeE3LmK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:42:10 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60716 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752075AbeE3LG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:06:59 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>
Date: Wed, 30 May 2018 11:52:42 +0100
Message-ID: <lsq.1527677562.546783901@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 139/153] ALSA: aloop: Fix access to not-yet-ready
 substream via cable
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

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
@@ -656,7 +656,9 @@ static void free_cable(struct snd_pcm_su
 		return;
 	if (cable->streams[!substream->stream]) {
 		/* other stream is still alive */
+		spin_lock_irq(&cable->lock);
 		cable->streams[substream->stream] = NULL;
+		spin_unlock_irq(&cable->lock);
 	} else {
 		/* free the cable */
 		loopback->cables[substream->number][dev] = NULL;
@@ -697,7 +699,6 @@ static int loopback_open(struct snd_pcm_
 		loopback->cables[substream->number][dev] = cable;
 	}
 	dpcm->cable = cable;
-	cable->streams[substream->stream] = dpcm;
 
 	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
 
@@ -729,6 +730,11 @@ static int loopback_open(struct snd_pcm_
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
