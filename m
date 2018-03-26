Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751083AbeCZFZP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 01:25:15 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:51265 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750857AbeCZFZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 01:25:13 -0400
From: Robert Rosengren <robert.rosengren@axis.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Robert Rosengren <robertr@axis.com>
Subject: [PATCH] ALSA: aloop: Mark paused device as inactive
Date: Mon, 26 Mar 2018 07:24:49 +0200
Message-Id: <20180326052449.3618-1-robertr@axis.com>
X-Mailer: git-send-email 2.11.0
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show paused ALSA aloop device as inactive, i.e. the control
"PCM Slave Active" set as false. Notification sent upon state change.

This makes it possible for client capturing from aloop device to know if
data is expected. Without it the client expects data even if playback
is paused.

Signed-off-by: Robert Rosengren <robertr@axis.com>
---
 sound/drivers/aloop.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 0333143a1fa7..5404ab11132d 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -291,6 +291,8 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
 		cable->pause |= stream;
 		loopback_timer_stop(dpcm);
 		spin_unlock(&cable->lock);
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			loopback_active_notify(dpcm);
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
@@ -299,6 +301,8 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
 		cable->pause &= ~stream;
 		loopback_timer_start(dpcm);
 		spin_unlock(&cable->lock);
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			loopback_active_notify(dpcm);
 		break;
 	default:
 		return -EINVAL;
@@ -879,9 +883,11 @@ static int loopback_active_get(struct snd_kcontrol *kcontrol,
 			[kcontrol->id.subdevice][kcontrol->id.device ^ 1];
 	unsigned int val = 0;
 
-	if (cable != NULL)
-		val = (cable->running & (1 << SNDRV_PCM_STREAM_PLAYBACK)) ?
-									1 : 0;
+	if (cable != NULL) {
+		unsigned int running = cable->running ^ cable->pause;
+
+		val = (running & (1 << SNDRV_PCM_STREAM_PLAYBACK)) ? 1 : 0;
+	}
 	ucontrol->value.integer.value[0] = val;
 	return 0;
 }
-- 
2.11.0
