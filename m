Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753770AbeE3LmO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:42:14 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60719 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751811AbeE3LG7 (ORCPT
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
Message-ID: <lsq.1527677562.333114795@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 138/153] ALSA: aloop: Sync stale timer before release
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

commit 67a01afaf3d34893cf7d2ea19b34555d6abb7cb0 upstream.

The aloop driver tries to stop the pending timer via timer_del() in
the trigger callback and in the close callback.  The former is
correct, as it's an atomic operation, while the latter expects that
the timer gets really removed and proceeds the resource releases after
that.  But timer_del() doesn't synchronize, hence the running timer
may still access the released resources.

A similar situation can be also seen in the prepare callback after
trigger(STOP) where the prepare tries to re-initialize the things
while a timer is still running.

The problems like the above are seen indirectly in some syzkaller
reports (although it's not 100% clear whether this is the only cause,
as the race condition is quite narrow and not always easy to
trigger).

For addressing these issues, this patch adds the explicit alls of
timer_del_sync() in some places, so that the pending timer is properly
killed / synced.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/drivers/aloop.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -195,6 +195,11 @@ static inline void loopback_timer_stop(s
 	spin_unlock(&dpcm->timer_lock);
 }
 
+static inline void loopback_timer_stop_sync(struct loopback_pcm *dpcm)
+{
+	del_timer_sync(&dpcm->timer);
+}
+
 #define CABLE_VALID_PLAYBACK	(1 << SNDRV_PCM_STREAM_PLAYBACK)
 #define CABLE_VALID_CAPTURE	(1 << SNDRV_PCM_STREAM_CAPTURE)
 #define CABLE_VALID_BOTH	(CABLE_VALID_PLAYBACK|CABLE_VALID_CAPTURE)
@@ -328,6 +333,8 @@ static int loopback_prepare(struct snd_p
 	struct loopback_cable *cable = dpcm->cable;
 	int bps, salign;
 
+	loopback_timer_stop_sync(dpcm);
+
 	salign = (snd_pcm_format_width(runtime->format) *
 						runtime->channels) / 8;
 	bps = salign * runtime->rate;
@@ -736,7 +743,7 @@ static int loopback_close(struct snd_pcm
 	struct loopback *loopback = substream->private_data;
 	struct loopback_pcm *dpcm = substream->runtime->private_data;
 
-	loopback_timer_stop(dpcm);
+	loopback_timer_stop_sync(dpcm);
 	mutex_lock(&loopback->cable_lock);
 	free_cable(substream);
 	mutex_unlock(&loopback->cable_lock);
