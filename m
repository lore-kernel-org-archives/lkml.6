Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+ugK2CRBytFiy6VvTtEL54iEjT5b7n9mXBN+2B66/ai+85FNVKuRWdXTip3Hu9jy4MbGTE
ARC-Seal: i=1; a=rsa-sha256; t=1524406692; cv=none;
        d=google.com; s=arc-20160816;
        b=vdTQfpqnMKYE9bLWEP1PJ4oy41uWCx0OCV1NfvDvVb+aGOpqSwQAFN0GxtZgyIjjwR
         HdroQyxc1yIow/C5uq7wKI8PvlQm1p92HOxsnAC8JcEvyx+MqVeBwlOAAztFnDVPzv1U
         jFi22RTf5thMZtbMLeTZLj9HbaMCE1uzPHa9mPWqEUsL8Cmu7Ss+EMTz4/Hj4533PjGw
         xIhB4KQYKOjONdosJJKaZEnd34KIvo0i89mOE360Hzj/SuvsHPObf49hDrsfbM2AFGRU
         IXuzKD7RA3nlsb6ZW/2FdefC/p438Qla5T7AHcHfuyARMYb/ClQREff7vskQ5FbysB4I
         /+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=avf5NFlh18RhJP85lP6JPN3CKrL1DVtW59d0W7JulbI=;
        b=APHJDr2z6a3lhhMQiW2NLjR2Mm8OJ/oG3djNVW9Rt2UC/FWDHB65zDl1mSZlwDUZym
         8555TtvQxlOeLfI+RIkNWSQJA+UR9bHuBG6j3WD5MFYgqXystEwulfJenFkZjm762Fq8
         X9/treo2dpzQbaXewe8vgjID6zlVcu5g2QylU2rUuWdbrvy6L13dhG1vNqUueUmrGa0i
         VyVZhsHfXTXTRZv2v2KP1mHcD31bZX0cBT8//7aDB7WRIGBdmQvsILeSz/wmWLKnQryJ
         wYzMIzXNItkQZOl/YkMvGePuBUEBUV28zK2KfgBAkJA+WLv5Vk0eBaKc2BY9qfYsgoSj
         g6fQ==
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
Subject: [PATCH 4.4 67/97] ALSA: pcm: Avoid potential races between OSS ioctls and read/write
Date: Sun, 22 Apr 2018 15:53:45 +0200
Message-Id: <20180422135308.945813134@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455075008305944?=
X-GMAIL-MSGID: =?utf-8?q?1598456271441542166?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 	sw_params = kzalloc(sizeof(*sw_params), GFP_KERNEL);
 	params = kmalloc(sizeof(*params), GFP_KERNEL);
 	sparams = kmalloc(sizeof(*sparams), GFP_KERNEL);
@@ -1078,6 +1075,23 @@ failure:
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
@@ -1106,11 +1120,14 @@ static int snd_pcm_oss_get_active_substr
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
@@ -1130,8 +1147,6 @@ static int snd_pcm_oss_make_ready(struct
 	struct snd_pcm_runtime *runtime;
 	int err;
 
-	if (substream == NULL)
-		return 0;
 	runtime = substream->runtime;
 	if (runtime->oss.params) {
 		err = snd_pcm_oss_change_params(substream, false);
@@ -1139,6 +1154,29 @@ static int snd_pcm_oss_make_ready(struct
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
@@ -1366,13 +1404,14 @@ static ssize_t snd_pcm_oss_write1(struct
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
@@ -1473,13 +1512,14 @@ static ssize_t snd_pcm_oss_read1(struct
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
@@ -1535,10 +1575,12 @@ static int snd_pcm_oss_reset(struct snd_
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
@@ -1624,9 +1666,10 @@ static int snd_pcm_oss_sync(struct snd_p
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
@@ -1694,7 +1737,9 @@ static int snd_pcm_oss_sync(struct snd_p
 		substream->f_flags = saved_f_flags;
 		if (err < 0)
 			return err;
+		mutex_lock(&runtime->oss.params_lock);
 		runtime->oss.prepare = 1;
+		mutex_unlock(&runtime->oss.params_lock);
 	}
 
 	substream = pcm_oss_file->streams[SNDRV_PCM_STREAM_CAPTURE];
@@ -1705,8 +1750,10 @@ static int snd_pcm_oss_sync(struct snd_p
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
@@ -1725,10 +1772,13 @@ static int snd_pcm_oss_set_rate(struct s
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
@@ -1756,10 +1806,13 @@ static int snd_pcm_oss_set_channels(stru
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
 
