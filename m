Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/QVdLCC7Zx8L869vIPCe3NyuUSjUfiZV700e8k7Ig34g10CVuDFo/okUkStTOTlYB7AjhL
ARC-Seal: i=1; a=rsa-sha256; t=1524405551; cv=none;
        d=google.com; s=arc-20160816;
        b=IUSHxJfBWIu/7hs1DUTJYMTHNjbvJ4ZDtmzsp8fZqNfg6J+M0WrKFRYJkYacpZD9Pb
         sJnzpIuABakaytv/74WRhhT8jQ7/gvwTzYHiyHqU5kCpByYwQHxWEeb+zKdaBWVzHjJf
         3oxcewdBPQDV1NuL4aTenX5AFebA41/1PsAbkhG3Zt7s2laF+JvwKOpfe0WrOJV9hCST
         Hg5bYSbhJ5BUER8bJSSmENkH7OKbfMgfwjrxeESpzJPR6/jY+SlXMPq2w9q0MRFiEN5Y
         Z+ar3R6PovpTAlrmdJiJu3e4BLpQhYHk++aZAHEVGFiiWRZaIppuHFKcqemBFakh8d3V
         uBBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Fzzku6pxN9/+SKxkKX58vbrc3uDbP8jIrGMgDO3X8VQ=;
        b=S1yV0mNzM/+Vwr/tXJcEllBmqVLgGQXQl2Z0cOGZMEO0SyCJhnX5K8jGdT0b1bhT2Z
         Fk7EnqRqv2rSHBUkqzmSSJVbkdsQs+NxWrDmekdwLgfGhM0aZmH2on92WGAIuBpVzmB9
         aZAIxdiW9Hclt6QVMW1HkX0wcGYgyn3kY/yjDY7RQZDjV1UQgUcDPG++cr9KjlVMv4H7
         t3T5jpPR1UAaPFot+Aux/4UuvaA2s3gj7TrgEC5xfom8h28z+XV70Z/OR3QZZGYLFg6d
         3QjVDF7dAnIyd+x71npvcjZi1oLAuBprqS2inFpaf4+NVGzOSHwA3xKmMJHuc0vI+TgF
         kPUg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+c4227aec125487ec3efa@syzkaller.appspotmail.com,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.16 108/196] ALSA: pcm: Avoid potential races between OSS ioctls and read/write
Date: Sun, 22 Apr 2018 15:52:08 +0200
Message-Id: <20180422135109.861033786@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455075008305944?=
X-GMAIL-MSGID: =?utf-8?q?1598455075008305944?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/oss/pcm_oss.c |  134 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 106 insertions(+), 28 deletions(-)

--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -823,8 +823,8 @@ static int choose_rate(struct snd_pcm_su
 	return snd_pcm_hw_param_near(substream, params, SNDRV_PCM_HW_PARAM_RATE, best_rate, NULL);
 }
 
-static int snd_pcm_oss_change_params(struct snd_pcm_substream *substream,
-				     bool trylock)
+/* call with params_lock held */
+static int snd_pcm_oss_change_params_locked(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_pcm_hw_params *params, *sparams;
@@ -838,11 +838,8 @@ static int snd_pcm_oss_change_params(str
 	const struct snd_mask *sformat_mask;
 	struct snd_mask mask;
 
-	if (trylock) {
-		if (!(mutex_trylock(&runtime->oss.params_lock)))
-			return -EAGAIN;
-	} else if (mutex_lock_interruptible(&runtime->oss.params_lock))
-		return -ERESTARTSYS;
+	if (!runtime->oss.params)
+		return 0;
 	sw_params = kzalloc(sizeof(*sw_params), GFP_KERNEL);
 	params = kmalloc(sizeof(*params), GFP_KERNEL);
 	sparams = kmalloc(sizeof(*sparams), GFP_KERNEL);
@@ -1068,6 +1065,23 @@ failure:
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
@@ -1096,11 +1110,14 @@ static int snd_pcm_oss_get_active_substr
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
@@ -1120,8 +1137,6 @@ static int snd_pcm_oss_make_ready(struct
 	struct snd_pcm_runtime *runtime;
 	int err;
 
-	if (substream == NULL)
-		return 0;
 	runtime = substream->runtime;
 	if (runtime->oss.params) {
 		err = snd_pcm_oss_change_params(substream, false);
@@ -1129,6 +1144,29 @@ static int snd_pcm_oss_make_ready(struct
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
@@ -1332,13 +1370,14 @@ static ssize_t snd_pcm_oss_write1(struct
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
@@ -1439,13 +1478,14 @@ static ssize_t snd_pcm_oss_read1(struct
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
@@ -1501,10 +1541,12 @@ static int snd_pcm_oss_reset(struct snd_
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
@@ -1590,9 +1632,10 @@ static int snd_pcm_oss_sync(struct snd_p
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
@@ -1643,7 +1686,9 @@ static int snd_pcm_oss_sync(struct snd_p
 		substream->f_flags = saved_f_flags;
 		if (err < 0)
 			return err;
+		mutex_lock(&runtime->oss.params_lock);
 		runtime->oss.prepare = 1;
+		mutex_unlock(&runtime->oss.params_lock);
 	}
 
 	substream = pcm_oss_file->streams[SNDRV_PCM_STREAM_CAPTURE];
@@ -1654,8 +1699,10 @@ static int snd_pcm_oss_sync(struct snd_p
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
@@ -1674,10 +1721,13 @@ static int snd_pcm_oss_set_rate(struct s
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
@@ -1705,10 +1755,13 @@ static int snd_pcm_oss_set_channels(stru
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
@@ -1794,10 +1847,13 @@ static int snd_pcm_oss_set_format(struct
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
@@ -1817,8 +1873,6 @@ static int snd_pcm_oss_set_subdivide1(st
 {
 	struct snd_pcm_runtime *runtime;
 
-	if (substream == NULL)
-		return 0;
 	runtime = substream->runtime;
 	if (subdivide == 0) {
 		subdivide = runtime->oss.subdivision;
@@ -1842,9 +1896,16 @@ static int snd_pcm_oss_set_subdivide(str
 
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
@@ -1854,8 +1915,6 @@ static int snd_pcm_oss_set_fragment1(str
 {
 	struct snd_pcm_runtime *runtime;
 
-	if (substream == NULL)
-		return 0;
 	runtime = substream->runtime;
 	if (runtime->oss.subdivision || runtime->oss.fragshift)
 		return -EINVAL;
@@ -1875,9 +1934,16 @@ static int snd_pcm_oss_set_fragment(stru
 
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
@@ -1961,6 +2027,9 @@ static int snd_pcm_oss_set_trigger(struc
 	}
       	if (psubstream) {
       		runtime = psubstream->runtime;
+		cmd = 0;
+		if (mutex_lock_interruptible(&runtime->oss.params_lock))
+			return -ERESTARTSYS;
 		if (trigger & PCM_ENABLE_OUTPUT) {
 			if (runtime->oss.trigger)
 				goto _skip1;
@@ -1978,13 +2047,19 @@ static int snd_pcm_oss_set_trigger(struc
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
@@ -1999,11 +2074,14 @@ static int snd_pcm_oss_set_trigger(struc
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
 
