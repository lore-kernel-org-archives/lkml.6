Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr8moytDz+m4ndFmpyysMU78FKGXcdjzO7Q22ops2QG6DuVRk2joT3h0WCIEOi5EiQDQ7b3
ARC-Seal: i=1; a=rsa-sha256; t=1525116392; cv=none;
        d=google.com; s=arc-20160816;
        b=XY9cBdVYBiyGABkRCB9DOP8G5lrt+lI9dd1W0MEk2Dwmoowu335z/XaTjNNYPDT0t9
         RutsB8B1tspiV9lwpGlCvCnjn6Y4QsFaTV1BQwhMcDogf4OfcJ0qlIY4TwIPmn+7b57M
         stAisBAEH/UbbrwAZKwN7yRG7GZRfquOMuNx2Gh9WaS3GcPwgUKCIjSAS4aVj5mFlPUp
         DdBGShKy2r75jqYUNpallnF2tB6eAycY/ItYf6zpbEq0tKkPqhd+GYTfEBG6lmBire1R
         o5hNTPw48TRrf2YMPMDy10QYSAC1eHgRQNFNDP9z2f3jyTmPt226q5pV5oGC0zpefW/D
         gCJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=jbtbIJ7ZpaRF0z1WbKrspF3sETyreSRqyHG5gyB87D8=;
        b=CmN78s5Pmumgk5d2V/TlGWfzYXsOCBNEMmdtGE+4/3vRUqf/2FXYhhIp5/Mndzg1Lj
         qYlIU6uqNmUgyg4/NXiTzbd4dLwGf7dg/wwZHlzIYbWWZIIe9qe2Ao6A7W7XiwCB1Dsu
         D3j/SqwYkpJNk5m9TCXpiul+RhiMB6n5NvOBKOPcXbCJhHkQCTHxAo2NISVgqYIgGjlT
         Yv5FSh1pDAc3bEUjw/qfpIjdSekKmoPLxWbiDuO9yVz+iDG4HZ7TcVrD668cytNuaGNi
         +c6ZyiaVcU3+AJSrCqXqxzJv3okN/h0MMWF14enOh+SzoDQSy8WXL365g9KZwJTcXWft
         x9CA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EAD322DAE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 33/61] ALSA: seq: oss: Hardening for potential Spectre v1
Date: Mon, 30 Apr 2018 12:24:36 -0700
Message-Id: <20180430183954.198452778@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200408982455335?=
X-GMAIL-MSGID: =?utf-8?q?1599200445885796389?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/seq/oss/seq_oss_event.c |   15 ++++---
 sound/core/seq/oss/seq_oss_midi.c  |    2 
 sound/core/seq/oss/seq_oss_synth.c |   75 ++++++++++++++++++++-----------------
 sound/core/seq/oss/seq_oss_synth.h |    3 -
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
@@ -315,6 +316,7 @@ get_mididev(struct seq_oss_devinfo *dp,
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
