Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48HYXZDL5jecO6bsKYskGAXqWwH3pOLta6rRL4TgoW4GwuUp0AGQU6PGQRIw3C7b+rzcfpx
ARC-Seal: i=1; a=rsa-sha256; t=1524405556; cv=none;
        d=google.com; s=arc-20160816;
        b=QeANcrBOpwLgnfHFzg/fVIPtnssEN0AKVD6eohiSa2yGuBR9TbEI0D/wRbkKA98Tru
         d/1uXzQAJygxa3U8IH8mRtQoEKG6TS6BZAu6r+deOAPPPUFGKneUhCZzt86SnQbUYvG1
         LJKjQOt67/QMQpx90EcXPIgXery4TefKBOZ/re2Po0CTTpnFEgHn1undHH+7YfOODJE4
         T66OZY/F2Don6ufFa0IX3sNdjnVgmfwyVuXETfcqkY1IBN19HXB3TPEq7LAwmJm9fmu3
         Arv2fGHEALyVUKoA1gpXAgpTTpNHHHLF8jOOmnKlmXObZosAPhBVxRwdo8NGU0ULs9bA
         mh7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CUhj1xW2/rn8GEQFhMtkpvsJwRwsuhBeMi7S9dhZ8HM=;
        b=Aj3Jsdj4WkmbgHKBJ825B1sca3MEi3JFUUd4Wz6D9GFTKC0aJFwEuG9ZL6npQuOK82
         NrTGgAAV52AInA0Y8gkCt9KAxc5bKDZKJRPW1MSuDxjnBDdDUfHCZeiDEON60FXdsKyk
         VbfCBYLBXpjPeO3UZKDKSKGgd+vvoeOUAwm+Za8XzARckUUQsLC9cCGqAkXV2Zs20JCU
         LeevwFcSZ2lbdA74bNO7zYqYDSfIan3Q+KWdzPVUvOULTJwONUEvxkr3kJd1erCvBNQk
         MKqIBo4kpwITb1EDlo4mv6ZU0n6JF2WKym1IFQ2xxsrawW9BTrgeHxlynMQLhq1Bjxte
         W+eA==
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
Subject: [PATCH 4.16 110/196] ALSA: pcm: Fix mutex unbalance in OSS emulation ioctls
Date: Sun, 22 Apr 2018 15:52:10 +0200
Message-Id: <20180422135109.961924781@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455080797885449?=
X-GMAIL-MSGID: =?utf-8?q?1598455080797885449?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -823,6 +823,23 @@ static int choose_rate(struct snd_pcm_su
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
@@ -1721,6 +1738,8 @@ static int snd_pcm_oss_set_rate(struct s
 	for (idx = 1; idx >= 0; --idx) {
 		struct snd_pcm_substream *substream = pcm_oss_file->streams[idx];
 		struct snd_pcm_runtime *runtime;
+		int err;
+
 		if (substream == NULL)
 			continue;
 		runtime = substream->runtime;
@@ -1728,15 +1747,14 @@ static int snd_pcm_oss_set_rate(struct s
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
@@ -1761,18 +1779,19 @@ static int snd_pcm_oss_set_channels(stru
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
@@ -1845,6 +1864,7 @@ static int snd_pcm_oss_get_formats(struc
 static int snd_pcm_oss_set_format(struct snd_pcm_oss_file *pcm_oss_file, int format)
 {
 	int formats, idx;
+	int err;
 	
 	if (format != AFMT_QUERY) {
 		formats = snd_pcm_oss_get_formats(pcm_oss_file);
@@ -1858,15 +1878,14 @@ static int snd_pcm_oss_set_format(struct
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
@@ -1914,12 +1933,11 @@ static int snd_pcm_oss_set_subdivide(str
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
@@ -1954,12 +1972,11 @@ static int snd_pcm_oss_set_fragment(stru
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
