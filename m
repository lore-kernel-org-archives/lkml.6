Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48mql4D5E9JcFzHdUHYjqoHTGE1m7i+FGr59iGjF7sgXbROGWZukUFNwUTdlkZRa/k8IhLr
ARC-Seal: i=1; a=rsa-sha256; t=1524406871; cv=none;
        d=google.com; s=arc-20160816;
        b=L+F8FadG9t9K7526Pq5dL1wMAyUzAKlnnB23s8QfucfgKA7CH4deWgP/c/e71m2fuj
         DqXItGiGwYW9rrVGzy1mpynZeHTHo+LlW9C8qP2x88wtsm0otnKc4mtQoGddCYiLBvSk
         ik4f+r564hH9yFYcH0YC92RaE0crU+cYrLpMRlxbpEChKP8ffzlnT89EhWOgj+kDplp9
         u5zDAhcLO81+4Z4rP99nNBmoM1nnEG+kb2tHgnkLNgQyd1r8RoWTlrY2irhYz8jo6AbB
         PBS0mRBGaAqpxAj1+6fgmTRgXlus1V0UC3jF+UeHqla6HcMvT6LAMJeG10oMJ8r5Mdoj
         3SwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=h+sW0A36Aqwk5zab9UGY8Y7nBa/eRUCLa2uKHXu42Fc=;
        b=P0TWQaNvgDeRrHruuCTtEP2aNRcG99u1Gs5Ow4UF7PTYS5X6NlESamgeN4EHXfo8EC
         mazOeOb1F3VtA45omTqlKQHzePAzRwlNpZICM+WIL6qEX8xXRK/3Pek8u36nvZMJap6G
         U1bIsuEX+njhqyWEwg8eg/vgZyS6HJlIIO9qeIH/mdZCfqejD3Eem0X1QSmgoe/WmazM
         +2G/grx3U9t4CmoTnIgwDk2F3IQQOdH5VXkIVTeyunn8pCanO+KBdwEAH5yUuIBscrv6
         VvzN8jot3rRO+o5Nj5XwZ/Rj5qLqYxp1jfvOJXhvoBUhVd0xnHYNCb6tVshv0NLB5KhP
         pZ+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3.18 35/52] ALSA: pcm: Fix mutex unbalance in OSS emulation ioctls
Date: Sun, 22 Apr 2018 15:54:08 +0200
Message-Id: <20180422135317.044121415@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455080797885449?=
X-GMAIL-MSGID: =?utf-8?q?1598456459633112188?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit f6d297df4dd47ef949540e4a201230d0c5308325 upstream.

The previous fix 40cab6e88cb0 ("ALSA: pcm: Return -EBUSY for OSS
ioctls changing busy streams") introduced some mutex unbalance; the
check of runtime->oss.rw_ref was inserted in a wrong place after the
mutex lock.

This patch fixes the inconsistency by rewriting with the helper
functions to lock/unlock parameters with the stream check.

Fixes: 40cab6e88cb0 ("ALSA: pcm: Return -EBUSY for OSS ioctls changing busy streams")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/oss/pcm_oss.c |   67 +++++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 25 deletions(-)

--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -833,6 +833,23 @@ static int choose_rate(struct snd_pcm_su
 	return snd_pcm_hw_param_near(substream, params, SNDRV_PCM_HW_PARAM_RATE, best_rate, NULL);
 }
 
+/* parameter locking: returns immediately if tried during streaming */
+static int lock_params(struct snd_pcm_runtime *runtime)
+{
+	if (mutex_lock_interruptible(&runtime->oss.params_lock))
+		return -ERESTARTSYS;
+	if (atomic_read(&runtime->oss.rw_ref)) {
+		mutex_unlock(&runtime->oss.params_lock);
+		return -EBUSY;
+	}
+	return 0;
+}
+
+static void unlock_params(struct snd_pcm_runtime *runtime)
+{
+	mutex_unlock(&runtime->oss.params_lock);
+}
+
 /* call with params_lock held */
 static int snd_pcm_oss_change_params_locked(struct snd_pcm_substream *substream)
 {
@@ -1773,6 +1790,8 @@ static int snd_pcm_oss_set_rate(struct s
 	for (idx = 1; idx >= 0; --idx) {
 		struct snd_pcm_substream *substream = pcm_oss_file->streams[idx];
 		struct snd_pcm_runtime *runtime;
+		int err;
+
 		if (substream == NULL)
 			continue;
 		runtime = substream->runtime;
@@ -1780,15 +1799,14 @@ static int snd_pcm_oss_set_rate(struct s
 			rate = 1000;
 		else if (rate > 192000)
 			rate = 192000;
-		if (mutex_lock_interruptible(&runtime->oss.params_lock))
-			return -ERESTARTSYS;
-		if (atomic_read(&runtime->oss.rw_ref))
-			return -EBUSY;
+		err = lock_params(runtime);
+		if (err < 0)
+			return err;
 		if (runtime->oss.rate != rate) {
 			runtime->oss.params = 1;
 			runtime->oss.rate = rate;
 		}
-		mutex_unlock(&runtime->oss.params_lock);
+		unlock_params(runtime);
 	}
 	return snd_pcm_oss_get_rate(pcm_oss_file);
 }
@@ -1813,18 +1831,19 @@ static int snd_pcm_oss_set_channels(stru
 	for (idx = 1; idx >= 0; --idx) {
 		struct snd_pcm_substream *substream = pcm_oss_file->streams[idx];
 		struct snd_pcm_runtime *runtime;
+		int err;
+
 		if (substream == NULL)
 			continue;
 		runtime = substream->runtime;
-		if (mutex_lock_interruptible(&runtime->oss.params_lock))
-			return -ERESTARTSYS;
-		if (atomic_read(&runtime->oss.rw_ref))
-			return -EBUSY;
+		err = lock_params(runtime);
+		if (err < 0)
+			return err;
 		if (runtime->oss.channels != channels) {
 			runtime->oss.params = 1;
 			runtime->oss.channels = channels;
 		}
-		mutex_unlock(&runtime->oss.params_lock);
+		unlock_params(runtime);
 	}
 	return snd_pcm_oss_get_channels(pcm_oss_file);
 }
@@ -1897,6 +1916,7 @@ static int snd_pcm_oss_get_formats(struc
 static int snd_pcm_oss_set_format(struct snd_pcm_oss_file *pcm_oss_file, int format)
 {
 	int formats, idx;
+	int err;
 	
 	if (format != AFMT_QUERY) {
 		formats = snd_pcm_oss_get_formats(pcm_oss_file);
@@ -1910,15 +1930,14 @@ static int snd_pcm_oss_set_format(struct
 			if (substream == NULL)
 				continue;
 			runtime = substream->runtime;
-			if (atomic_read(&runtime->oss.rw_ref))
-				return -EBUSY;
-			if (mutex_lock_interruptible(&runtime->oss.params_lock))
-				return -ERESTARTSYS;
+			err = lock_params(runtime);
+			if (err < 0)
+				return err;
 			if (runtime->oss.format != format) {
 				runtime->oss.params = 1;
 				runtime->oss.format = format;
 			}
-			mutex_unlock(&runtime->oss.params_lock);
+			unlock_params(runtime);
 		}
 	}
 	return snd_pcm_oss_get_format(pcm_oss_file);
@@ -1966,12 +1985,11 @@ static int snd_pcm_oss_set_subdivide(str
 		if (substream == NULL)
 			continue;
 		runtime = substream->runtime;
-		if (atomic_read(&runtime->oss.rw_ref))
-			return -EBUSY;
-		if (mutex_lock_interruptible(&runtime->oss.params_lock))
-			return -ERESTARTSYS;
+		err = lock_params(runtime);
+		if (err < 0)
+			return err;
 		err = snd_pcm_oss_set_subdivide1(substream, subdivide);
-		mutex_unlock(&runtime->oss.params_lock);
+		unlock_params(runtime);
 		if (err < 0)
 			return err;
 	}
@@ -2006,12 +2024,11 @@ static int snd_pcm_oss_set_fragment(stru
 		if (substream == NULL)
 			continue;
 		runtime = substream->runtime;
-		if (atomic_read(&runtime->oss.rw_ref))
-			return -EBUSY;
-		if (mutex_lock_interruptible(&runtime->oss.params_lock))
-			return -ERESTARTSYS;
+		err = lock_params(runtime);
+		if (err < 0)
+			return err;
 		err = snd_pcm_oss_set_fragment1(substream, val);
-		mutex_unlock(&runtime->oss.params_lock);
+		unlock_params(runtime);
 		if (err < 0)
 			return err;
 	}
