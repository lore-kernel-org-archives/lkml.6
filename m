Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EC8C7112B
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D11A20895
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D11A20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbeJNXZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:25:12 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37039 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729273AbeJNXZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:25:12 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiME-0004cA-RK; Sun, 14 Oct 2018 16:31:06 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLO-0000Cn-Ue; Sun, 14 Oct 2018 16:30:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>,
        syzbot+c4227aec125487ec3efa@syzkaller.appspotmail.com
Date:   Sun, 14 Oct 2018 16:25:40 +0100
Message-ID: <lsq.1539530740.193014280@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 053/366] ALSA: pcm: Avoid potential races between OSS
 ioctls and read/write
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

commit 02a5d6925cd34c3b774bdb8eefb057c40a30e870 upstream.

Although we apply the params_lock mutex to the whole read and write
operations as well as snd_pcm_oss_change_params(), we may still face
some races.

First off, the params_lock is taken inside the read and write loop.
This is intentional for avoiding the too long locking, but it allows
the in-between parameter change, which might lead to invalid
pointers.  We check the readiness of the stream and set up via
snd_pcm_oss_make_ready() at the beginning of read and write, but it's
called only once, by assuming that it remains ready in the rest.

Second, many ioctls that may change the actual parameters
(i.e. setting runtime->oss.params=1) aren't protected, hence they can
be processed in a half-baked state.

This patch is an attempt to plug these holes.  The stream readiness
check is moved inside the read/write inner loop, so that the stream is
always set up in a proper state before further processing.  Also, each
ioctl that may change the parameter is wrapped with the params_lock
for avoiding the races.

The issues were triggered by syzkaller in a few different scenarios,
particularly the one below appearing as GPF in loopback_pos_update.

Reported-by: syzbot+c4227aec125487ec3efa@syzkaller.appspotmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/oss/pcm_oss.c | 134 +++++++++++++++++++++++++++++++--------
 1 file changed, 106 insertions(+), 28 deletions(-)

--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -833,8 +833,8 @@ static int choose_rate(struct snd_pcm_su
 	return snd_pcm_hw_param_near(substream, params, SNDRV_PCM_HW_PARAM_RATE, best_rate, NULL);
 }
 
-static int snd_pcm_oss_change_params(struct snd_pcm_substream *substream,
-				     bool trylock)
+/* call with params_lock held */
+static int snd_pcm_oss_change_params_locked(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_pcm_hw_params *params, *sparams;
@@ -848,11 +848,8 @@ static int snd_pcm_oss_change_params(str
 	struct snd_mask sformat_mask;
 	struct snd_mask mask;
 
-	if (trylock) {
-		if (!(mutex_trylock(&runtime->oss.params_lock)))
-			return -EAGAIN;
-	} else if (mutex_lock_interruptible(&runtime->oss.params_lock))
-		return -ERESTARTSYS;
+	if (!runtime->oss.params)
+		return 0;
 	sw_params = kmalloc(sizeof(*sw_params), GFP_KERNEL);
 	params = kmalloc(sizeof(*params), GFP_KERNEL);
 	sparams = kmalloc(sizeof(*sparams), GFP_KERNEL);
@@ -1080,6 +1077,23 @@ failure:
 	kfree(sw_params);
 	kfree(params);
 	kfree(sparams);
+	return err;
+}
+
+/* this one takes the lock by itself */
+static int snd_pcm_oss_change_params(struct snd_pcm_substream *substream,
+				     bool trylock)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int err;
+
+	if (trylock) {
+		if (!(mutex_trylock(&runtime->oss.params_lock)))
+			return -EAGAIN;
+	} else if (mutex_lock_interruptible(&runtime->oss.params_lock))
+		return -ERESTARTSYS;
+
+	err = snd_pcm_oss_change_params_locked(substream);
 	mutex_unlock(&runtime->oss.params_lock);
 	return err;
 }
@@ -1108,11 +1122,14 @@ static int snd_pcm_oss_get_active_substr
 	return 0;
 }
 
+/* call with params_lock held */
 static int snd_pcm_oss_prepare(struct snd_pcm_substream *substream)
 {
 	int err;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
+	if (!runtime->oss.prepare)
+		return 0;
 	err = snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_PREPARE, NULL);
 	if (err < 0) {
 		pcm_dbg(substream->pcm,
@@ -1132,8 +1149,6 @@ static int snd_pcm_oss_make_ready(struct
 	struct snd_pcm_runtime *runtime;
 	int err;
 
-	if (substream == NULL)
-		return 0;
 	runtime = substream->runtime;
 	if (runtime->oss.params) {
 		err = snd_pcm_oss_change_params(substream, false);
@@ -1141,6 +1156,29 @@ static int snd_pcm_oss_make_ready(struct
 			return err;
 	}
 	if (runtime->oss.prepare) {
+		if (mutex_lock_interruptible(&runtime->oss.params_lock))
+			return -ERESTARTSYS;
+		err = snd_pcm_oss_prepare(substream);
+		mutex_unlock(&runtime->oss.params_lock);
+		if (err < 0)
+			return err;
+	}
+	return 0;
+}
+
+/* call with params_lock held */
+static int snd_pcm_oss_make_ready_locked(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime;
+	int err;
+
+	runtime = substream->runtime;
+	if (runtime->oss.params) {
+		err = snd_pcm_oss_change_params_locked(substream);
+		if (err < 0)
+			return err;
+	}
+	if (runtime->oss.prepare) {
 		err = snd_pcm_oss_prepare(substream);
 		if (err < 0)
 			return err;
@@ -1368,13 +1406,14 @@ static ssize_t snd_pcm_oss_write1(struct
 	if (atomic_read(&substream->mmap_count))
 		return -ENXIO;
 
-	if ((tmp = snd_pcm_oss_make_ready(substream)) < 0)
-		return tmp;
 	while (bytes > 0) {
 		if (mutex_lock_interruptible(&runtime->oss.params_lock)) {
 			tmp = -ERESTARTSYS;
 			break;
 		}
+		tmp = snd_pcm_oss_make_ready_locked(substream);
+		if (tmp < 0)
+			goto err;
 		if (bytes < runtime->oss.period_bytes || runtime->oss.buffer_used > 0) {
 			tmp = bytes;
 			if (tmp + runtime->oss.buffer_used > runtime->oss.period_bytes)
@@ -1475,13 +1514,14 @@ static ssize_t snd_pcm_oss_read1(struct
 	if (atomic_read(&substream->mmap_count))
 		return -ENXIO;
 
-	if ((tmp = snd_pcm_oss_make_ready(substream)) < 0)
-		return tmp;
 	while (bytes > 0) {
 		if (mutex_lock_interruptible(&runtime->oss.params_lock)) {
 			tmp = -ERESTARTSYS;
 			break;
 		}
+		tmp = snd_pcm_oss_make_ready_locked(substream);
+		if (tmp < 0)
+			goto err;
 		if (bytes < runtime->oss.period_bytes || runtime->oss.buffer_used > 0) {
 			if (runtime->oss.buffer_used == 0) {
 				tmp = snd_pcm_oss_read2(substream, runtime->oss.buffer, runtime->oss.period_bytes, 1);
@@ -1537,10 +1577,12 @@ static int snd_pcm_oss_reset(struct snd_
 			continue;
 		runtime = substream->runtime;
 		snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_DROP, NULL);
+		mutex_lock(&runtime->oss.params_lock);
 		runtime->oss.prepare = 1;
 		runtime->oss.buffer_used = 0;
 		runtime->oss.prev_hw_ptr_period = 0;
 		runtime->oss.period_ptr = 0;
+		mutex_unlock(&runtime->oss.params_lock);
 	}
 	return 0;
 }
@@ -1626,9 +1668,10 @@ static int snd_pcm_oss_sync(struct snd_p
 			goto __direct;
 		if ((err = snd_pcm_oss_make_ready(substream)) < 0)
 			return err;
+		if (mutex_lock_interruptible(&runtime->oss.params_lock))
+			return -ERESTARTSYS;
 		format = snd_pcm_oss_format_from(runtime->oss.format);
 		width = snd_pcm_format_physical_width(format);
-		mutex_lock(&runtime->oss.params_lock);
 		if (runtime->oss.buffer_used > 0) {
 #ifdef OSS_DEBUG
 			pcm_dbg(substream->pcm, "sync: buffer_used\n");
@@ -1696,7 +1739,9 @@ static int snd_pcm_oss_sync(struct snd_p
 		substream->f_flags = saved_f_flags;
 		if (err < 0)
 			return err;
+		mutex_lock(&runtime->oss.params_lock);
 		runtime->oss.prepare = 1;
+		mutex_unlock(&runtime->oss.params_lock);
 	}
 
 	substream = pcm_oss_file->streams[SNDRV_PCM_STREAM_CAPTURE];
@@ -1707,8 +1752,10 @@ static int snd_pcm_oss_sync(struct snd_p
 		err = snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_DROP, NULL);
 		if (err < 0)
 			return err;
+		mutex_lock(&runtime->oss.params_lock);
 		runtime->oss.buffer_used = 0;
 		runtime->oss.prepare = 1;
+		mutex_unlock(&runtime->oss.params_lock);
 	}
 	return 0;
 }
@@ -1727,10 +1774,13 @@ static int snd_pcm_oss_set_rate(struct s
 			rate = 1000;
 		else if (rate > 192000)
 			rate = 192000;
+		if (mutex_lock_interruptible(&runtime->oss.params_lock))
+			return -ERESTARTSYS;
 		if (runtime->oss.rate != rate) {
 			runtime->oss.params = 1;
 			runtime->oss.rate = rate;
 		}
+		mutex_unlock(&runtime->oss.params_lock);
 	}
 	return snd_pcm_oss_get_rate(pcm_oss_file);
 }
@@ -1758,10 +1808,13 @@ static int snd_pcm_oss_set_channels(stru
 		if (substream == NULL)
 			continue;
 		runtime = substream->runtime;
+		if (mutex_lock_interruptible(&runtime->oss.params_lock))
+			return -ERESTARTSYS;
 		if (runtime->oss.channels != channels) {
 			runtime->oss.params = 1;
 			runtime->oss.channels = channels;
 		}
+		mutex_unlock(&runtime->oss.params_lock);
 	}
 	return snd_pcm_oss_get_channels(pcm_oss_file);
 }
@@ -1845,10 +1898,13 @@ static int snd_pcm_oss_set_format(struct
 			if (substream == NULL)
 				continue;
 			runtime = substream->runtime;
+			if (mutex_lock_interruptible(&runtime->oss.params_lock))
+				return -ERESTARTSYS;
 			if (runtime->oss.format != format) {
 				runtime->oss.params = 1;
 				runtime->oss.format = format;
 			}
+			mutex_unlock(&runtime->oss.params_lock);
 		}
 	}
 	return snd_pcm_oss_get_format(pcm_oss_file);
@@ -1868,8 +1924,6 @@ static int snd_pcm_oss_set_subdivide1(st
 {
 	struct snd_pcm_runtime *runtime;
 
-	if (substream == NULL)
-		return 0;
 	runtime = substream->runtime;
 	if (subdivide == 0) {
 		subdivide = runtime->oss.subdivision;
@@ -1893,9 +1947,16 @@ static int snd_pcm_oss_set_subdivide(str
 
 	for (idx = 1; idx >= 0; --idx) {
 		struct snd_pcm_substream *substream = pcm_oss_file->streams[idx];
+		struct snd_pcm_runtime *runtime;
+
 		if (substream == NULL)
 			continue;
-		if ((err = snd_pcm_oss_set_subdivide1(substream, subdivide)) < 0)
+		runtime = substream->runtime;
+		if (mutex_lock_interruptible(&runtime->oss.params_lock))
+			return -ERESTARTSYS;
+		err = snd_pcm_oss_set_subdivide1(substream, subdivide);
+		mutex_unlock(&runtime->oss.params_lock);
+		if (err < 0)
 			return err;
 	}
 	return err;
@@ -1905,8 +1966,6 @@ static int snd_pcm_oss_set_fragment1(str
 {
 	struct snd_pcm_runtime *runtime;
 
-	if (substream == NULL)
-		return 0;
 	runtime = substream->runtime;
 	if (runtime->oss.subdivision || runtime->oss.fragshift)
 		return -EINVAL;
@@ -1926,9 +1985,16 @@ static int snd_pcm_oss_set_fragment(stru
 
 	for (idx = 1; idx >= 0; --idx) {
 		struct snd_pcm_substream *substream = pcm_oss_file->streams[idx];
+		struct snd_pcm_runtime *runtime;
+
 		if (substream == NULL)
 			continue;
-		if ((err = snd_pcm_oss_set_fragment1(substream, val)) < 0)
+		runtime = substream->runtime;
+		if (mutex_lock_interruptible(&runtime->oss.params_lock))
+			return -ERESTARTSYS;
+		err = snd_pcm_oss_set_fragment1(substream, val);
+		mutex_unlock(&runtime->oss.params_lock);
+		if (err < 0)
 			return err;
 	}
 	return err;
@@ -2012,6 +2078,9 @@ static int snd_pcm_oss_set_trigger(struc
 	}
       	if (psubstream) {
       		runtime = psubstream->runtime;
+		cmd = 0;
+		if (mutex_lock_interruptible(&runtime->oss.params_lock))
+			return -ERESTARTSYS;
 		if (trigger & PCM_ENABLE_OUTPUT) {
 			if (runtime->oss.trigger)
 				goto _skip1;
@@ -2029,13 +2098,19 @@ static int snd_pcm_oss_set_trigger(struc
 			cmd = SNDRV_PCM_IOCTL_DROP;
 			runtime->oss.prepare = 1;
 		}
-		err = snd_pcm_kernel_ioctl(psubstream, cmd, NULL);
-		if (err < 0)
-			return err;
-	}
  _skip1:
+		mutex_unlock(&runtime->oss.params_lock);
+		if (cmd) {
+			err = snd_pcm_kernel_ioctl(psubstream, cmd, NULL);
+			if (err < 0)
+				return err;
+		}
+	}
 	if (csubstream) {
       		runtime = csubstream->runtime;
+		cmd = 0;
+		if (mutex_lock_interruptible(&runtime->oss.params_lock))
+			return -ERESTARTSYS;
 		if (trigger & PCM_ENABLE_INPUT) {
 			if (runtime->oss.trigger)
 				goto _skip2;
@@ -2050,11 +2125,14 @@ static int snd_pcm_oss_set_trigger(struc
 			cmd = SNDRV_PCM_IOCTL_DROP;
 			runtime->oss.prepare = 1;
 		}
-		err = snd_pcm_kernel_ioctl(csubstream, cmd, NULL);
-		if (err < 0)
-			return err;
-	}
  _skip2:
+		mutex_unlock(&runtime->oss.params_lock);
+		if (cmd) {
+			err = snd_pcm_kernel_ioctl(csubstream, cmd, NULL);
+			if (err < 0)
+				return err;
+		}
+	}
 	return 0;
 }
 

