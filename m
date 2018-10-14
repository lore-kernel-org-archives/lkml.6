Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F180EC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD74820835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD74820835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeJNXMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:12:09 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36381 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728257AbeJNXMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:07 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLu-0004cm-CE; Sun, 14 Oct 2018 16:30:46 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLV-0000RZ-9Z; Sun, 14 Oct 2018 16:30:21 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.284870599@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 213/366] ALSA: seq: oss: Hardening for potential
 Spectre v1
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 8d218dd8116695ecda7164f97631c069938aa22e upstream.

As Smatch recently suggested, a few places in OSS sequencer codes may
expand the array directly from the user-space value with speculation,
namely there are a significant amount of references to either
info->ch[] or dp->synths[] array:

  sound/core/seq/oss/seq_oss_event.c:315 note_on_event() warn: potential spectre issue 'info->ch' (local cap)
  sound/core/seq/oss/seq_oss_event.c:362 note_off_event() warn: potential spectre issue 'info->ch' (local cap)
  sound/core/seq/oss/seq_oss_synth.c:470 snd_seq_oss_synth_load_patch() warn: potential spectre issue 'dp->synths' (local cap)
  sound/core/seq/oss/seq_oss_event.c:293 note_on_event() warn: potential spectre issue 'dp->synths'
  sound/core/seq/oss/seq_oss_event.c:353 note_off_event() warn: potential spectre issue 'dp->synths'
  sound/core/seq/oss/seq_oss_synth.c:506 snd_seq_oss_synth_sysex() warn: potential spectre issue 'dp->synths'
  sound/core/seq/oss/seq_oss_synth.c:580 snd_seq_oss_synth_ioctl() warn: potential spectre issue 'dp->synths'

Although all these seem doing only the first load without further
reference, we may want to stay in a safer side, so hardening with
array_index_nospec() would still make sense.

We may put array_index_nospec() at each place, but here we take a
different approach:

- For dp->synths[], change the helpers to retrieve seq_oss_synthinfo
  pointer directly instead of the array expansion at each place

- For info->ch[], harden in a normal way, as there are only a couple
  of places

As a result, the existing helper, snd_seq_oss_synth_is_valid() is
replaced with snd_seq_oss_synth_info().  Also, we cover MIDI device
where a similar array expansion is done, too, although it wasn't
reported by Smatch.

BugLink: https://marc.info/?l=linux-kernel&m=152411496503418&w=2
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/seq/oss/seq_oss_event.c | 15 +++---
 sound/core/seq/oss/seq_oss_midi.c  |  2 +
 sound/core/seq/oss/seq_oss_synth.c | 75 +++++++++++++++++-------------
 sound/core/seq/oss/seq_oss_synth.h |  3 +-
 4 files changed, 55 insertions(+), 40 deletions(-)

--- a/sound/core/seq/oss/seq_oss_event.c
+++ b/sound/core/seq/oss/seq_oss_event.c
@@ -26,6 +26,7 @@
 #include <sound/seq_oss_legacy.h>
 #include "seq_oss_readq.h"
 #include "seq_oss_writeq.h"
+#include <linux/nospec.h>
 
 
 /*
@@ -287,10 +288,10 @@ note_on_event(struct seq_oss_devinfo *dp
 {
 	struct seq_oss_synthinfo *info;
 
-	if (!snd_seq_oss_synth_is_valid(dp, dev))
+	info = snd_seq_oss_synth_info(dp, dev);
+	if (!info)
 		return -ENXIO;
 
-	info = &dp->synths[dev];
 	switch (info->arg.event_passing) {
 	case SNDRV_SEQ_OSS_PROCESS_EVENTS:
 		if (! info->ch || ch < 0 || ch >= info->nr_voices) {
@@ -298,6 +299,7 @@ note_on_event(struct seq_oss_devinfo *dp
 			return set_note_event(dp, dev, SNDRV_SEQ_EVENT_NOTEON, ch, note, vel, ev);
 		}
 
+		ch = array_index_nospec(ch, info->nr_voices);
 		if (note == 255 && info->ch[ch].note >= 0) {
 			/* volume control */
 			int type;
@@ -347,10 +349,10 @@ note_off_event(struct seq_oss_devinfo *d
 {
 	struct seq_oss_synthinfo *info;
 
-	if (!snd_seq_oss_synth_is_valid(dp, dev))
+	info = snd_seq_oss_synth_info(dp, dev);
+	if (!info)
 		return -ENXIO;
 
-	info = &dp->synths[dev];
 	switch (info->arg.event_passing) {
 	case SNDRV_SEQ_OSS_PROCESS_EVENTS:
 		if (! info->ch || ch < 0 || ch >= info->nr_voices) {
@@ -358,6 +360,7 @@ note_off_event(struct seq_oss_devinfo *d
 			return set_note_event(dp, dev, SNDRV_SEQ_EVENT_NOTEON, ch, note, vel, ev);
 		}
 
+		ch = array_index_nospec(ch, info->nr_voices);
 		if (info->ch[ch].note >= 0) {
 			note = info->ch[ch].note;
 			info->ch[ch].vel = 0;
@@ -381,7 +384,7 @@ note_off_event(struct seq_oss_devinfo *d
 static int
 set_note_event(struct seq_oss_devinfo *dp, int dev, int type, int ch, int note, int vel, struct snd_seq_event *ev)
 {
-	if (! snd_seq_oss_synth_is_valid(dp, dev))
+	if (!snd_seq_oss_synth_info(dp, dev))
 		return -ENXIO;
 	
 	ev->type = type;
@@ -399,7 +402,7 @@ set_note_event(struct seq_oss_devinfo *d
 static int
 set_control_event(struct seq_oss_devinfo *dp, int dev, int type, int ch, int param, int val, struct snd_seq_event *ev)
 {
-	if (! snd_seq_oss_synth_is_valid(dp, dev))
+	if (!snd_seq_oss_synth_info(dp, dev))
 		return -ENXIO;
 	
 	ev->type = type;
--- a/sound/core/seq/oss/seq_oss_midi.c
+++ b/sound/core/seq/oss/seq_oss_midi.c
@@ -29,6 +29,7 @@
 #include "../seq_lock.h"
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/nospec.h>
 
 
 /*
@@ -318,6 +319,7 @@ get_mididev(struct seq_oss_devinfo *dp,
 {
 	if (dev < 0 || dev >= dp->max_mididev)
 		return NULL;
+	dev = array_index_nospec(dev, dp->max_mididev);
 	return get_mdev(dev);
 }
 
--- a/sound/core/seq/oss/seq_oss_synth.c
+++ b/sound/core/seq/oss/seq_oss_synth.c
@@ -26,6 +26,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/nospec.h>
 
 /*
  * constants
@@ -339,17 +340,13 @@ snd_seq_oss_synth_cleanup(struct seq_oss
 	dp->max_synthdev = 0;
 }
 
-/*
- * check if the specified device is MIDI mapped device
- */
-static int
-is_midi_dev(struct seq_oss_devinfo *dp, int dev)
+static struct seq_oss_synthinfo *
+get_synthinfo_nospec(struct seq_oss_devinfo *dp, int dev)
 {
 	if (dev < 0 || dev >= dp->max_synthdev)
-		return 0;
-	if (dp->synths[dev].is_midi)
-		return 1;
-	return 0;
+		return NULL;
+	dev = array_index_nospec(dev, SNDRV_SEQ_OSS_MAX_SYNTH_DEVS);
+	return &dp->synths[dev];
 }
 
 /*
@@ -359,11 +356,13 @@ static struct seq_oss_synth *
 get_synthdev(struct seq_oss_devinfo *dp, int dev)
 {
 	struct seq_oss_synth *rec;
-	if (dev < 0 || dev >= dp->max_synthdev)
+	struct seq_oss_synthinfo *info = get_synthinfo_nospec(dp, dev);
+
+	if (!info)
 		return NULL;
-	if (! dp->synths[dev].opened)
+	if (!info->opened)
 		return NULL;
-	if (dp->synths[dev].is_midi) {
+	if (info->is_midi) {
 		rec = &midi_synth_dev;
 		snd_use_lock_use(&rec->use_lock);
 	} else {
@@ -406,10 +405,8 @@ snd_seq_oss_synth_reset(struct seq_oss_d
 	struct seq_oss_synth *rec;
 	struct seq_oss_synthinfo *info;
 
-	if (snd_BUG_ON(dev < 0 || dev >= dp->max_synthdev))
-		return;
-	info = &dp->synths[dev];
-	if (! info->opened)
+	info = get_synthinfo_nospec(dp, dev);
+	if (!info || !info->opened)
 		return;
 	if (info->sysex)
 		info->sysex->len = 0; /* reset sysex */
@@ -458,12 +455,14 @@ snd_seq_oss_synth_load_patch(struct seq_
 			    const char __user *buf, int p, int c)
 {
 	struct seq_oss_synth *rec;
+	struct seq_oss_synthinfo *info;
 	int rc;
 
-	if (dev < 0 || dev >= dp->max_synthdev)
+	info = get_synthinfo_nospec(dp, dev);
+	if (!info)
 		return -ENXIO;
 
-	if (is_midi_dev(dp, dev))
+	if (info->is_midi)
 		return 0;
 	if ((rec = get_synthdev(dp, dev)) == NULL)
 		return -ENXIO;
@@ -471,24 +470,25 @@ snd_seq_oss_synth_load_patch(struct seq_
 	if (rec->oper.load_patch == NULL)
 		rc = -ENXIO;
 	else
-		rc = rec->oper.load_patch(&dp->synths[dev].arg, fmt, buf, p, c);
+		rc = rec->oper.load_patch(&info->arg, fmt, buf, p, c);
 	snd_use_lock_free(&rec->use_lock);
 	return rc;
 }
 
 /*
- * check if the device is valid synth device
+ * check if the device is valid synth device and return the synth info
  */
-int
-snd_seq_oss_synth_is_valid(struct seq_oss_devinfo *dp, int dev)
+struct seq_oss_synthinfo *
+snd_seq_oss_synth_info(struct seq_oss_devinfo *dp, int dev)
 {
 	struct seq_oss_synth *rec;
+
 	rec = get_synthdev(dp, dev);
 	if (rec) {
 		snd_use_lock_free(&rec->use_lock);
-		return 1;
+		return get_synthinfo_nospec(dp, dev);
 	}
-	return 0;
+	return NULL;
 }
 
 
@@ -503,16 +503,18 @@ snd_seq_oss_synth_sysex(struct seq_oss_d
 	int i, send;
 	unsigned char *dest;
 	struct seq_oss_synth_sysex *sysex;
+	struct seq_oss_synthinfo *info;
 
-	if (! snd_seq_oss_synth_is_valid(dp, dev))
+	info = snd_seq_oss_synth_info(dp, dev);
+	if (!info)
 		return -ENXIO;
 
-	sysex = dp->synths[dev].sysex;
+	sysex = info->sysex;
 	if (sysex == NULL) {
 		sysex = kzalloc(sizeof(*sysex), GFP_KERNEL);
 		if (sysex == NULL)
 			return -ENOMEM;
-		dp->synths[dev].sysex = sysex;
+		info->sysex = sysex;
 	}
 
 	send = 0;
@@ -557,10 +559,12 @@ snd_seq_oss_synth_sysex(struct seq_oss_d
 int
 snd_seq_oss_synth_addr(struct seq_oss_devinfo *dp, int dev, struct snd_seq_event *ev)
 {
-	if (! snd_seq_oss_synth_is_valid(dp, dev))
+	struct seq_oss_synthinfo *info = snd_seq_oss_synth_info(dp, dev);
+
+	if (!info)
 		return -EINVAL;
-	snd_seq_oss_fill_addr(dp, ev, dp->synths[dev].arg.addr.client,
-			      dp->synths[dev].arg.addr.port);
+	snd_seq_oss_fill_addr(dp, ev, info->arg.addr.client,
+			      info->arg.addr.port);
 	return 0;
 }
 
@@ -572,16 +576,18 @@ int
 snd_seq_oss_synth_ioctl(struct seq_oss_devinfo *dp, int dev, unsigned int cmd, unsigned long addr)
 {
 	struct seq_oss_synth *rec;
+	struct seq_oss_synthinfo *info;
 	int rc;
 
-	if (is_midi_dev(dp, dev))
+	info = get_synthinfo_nospec(dp, dev);
+	if (!info || info->is_midi)
 		return -ENXIO;
 	if ((rec = get_synthdev(dp, dev)) == NULL)
 		return -ENXIO;
 	if (rec->oper.ioctl == NULL)
 		rc = -ENXIO;
 	else
-		rc = rec->oper.ioctl(&dp->synths[dev].arg, cmd, addr);
+		rc = rec->oper.ioctl(&info->arg, cmd, addr);
 	snd_use_lock_free(&rec->use_lock);
 	return rc;
 }
@@ -593,7 +599,10 @@ snd_seq_oss_synth_ioctl(struct seq_oss_d
 int
 snd_seq_oss_synth_raw_event(struct seq_oss_devinfo *dp, int dev, unsigned char *data, struct snd_seq_event *ev)
 {
-	if (! snd_seq_oss_synth_is_valid(dp, dev) || is_midi_dev(dp, dev))
+	struct seq_oss_synthinfo *info;
+
+	info = snd_seq_oss_synth_info(dp, dev);
+	if (!info || info->is_midi)
 		return -ENXIO;
 	ev->type = SNDRV_SEQ_EVENT_OSS;
 	memcpy(ev->data.raw8.d, data, 8);
--- a/sound/core/seq/oss/seq_oss_synth.h
+++ b/sound/core/seq/oss/seq_oss_synth.h
@@ -37,7 +37,8 @@ void snd_seq_oss_synth_cleanup(struct se
 void snd_seq_oss_synth_reset(struct seq_oss_devinfo *dp, int dev);
 int snd_seq_oss_synth_load_patch(struct seq_oss_devinfo *dp, int dev, int fmt,
 				 const char __user *buf, int p, int c);
-int snd_seq_oss_synth_is_valid(struct seq_oss_devinfo *dp, int dev);
+struct seq_oss_synthinfo *snd_seq_oss_synth_info(struct seq_oss_devinfo *dp,
+						 int dev);
 int snd_seq_oss_synth_sysex(struct seq_oss_devinfo *dp, int dev, unsigned char *buf,
 			    struct snd_seq_event *ev);
 int snd_seq_oss_synth_addr(struct seq_oss_devinfo *dp, int dev, struct snd_seq_event *ev);

