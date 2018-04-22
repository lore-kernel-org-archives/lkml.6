Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49iIevkisQgZ/2z9WK9cKDpmGkhEQuQtH008Cd8TfUgFMdzXl01EdUuZA88bsHQOktIjUEe
ARC-Seal: i=1; a=rsa-sha256; t=1524406487; cv=none;
        d=google.com; s=arc-20160816;
        b=gAbn76hluxWpma7T1Id24kqBFDMftXYX2xIk5m1tmowW0+gLiz94NgRhqFdif/1uHP
         nfvsNz+SzrpYFY53racdS3tKZSBxlR9hwZDbLlbEkzu7KZNuebllsaBHg0f2XKgEeJnA
         pVDcoK5uCZYnRMEje7yk8/ulg220relFO9I0eEGHJQuhGHRY6/19d536YvjKxlcchYFK
         2ImtIxQUEIX9OV3kRXhackuWyWVccfTrI5g1/KbspD4ploBglk0UUspRr2d4qVO5nbir
         rXxVKPw7unxsSHFKiLJfxPk6o18YZqvFZL1HlZoT9PAn3IRlV41Pe1ejJFy/VXiMYFQW
         +Opg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Cbsf9PCf1n7i454sF5uZ2fWeGsjt6YxyeFL1pIJOJ/M=;
        b=vH1VaOJ81QQOV61X63bIuMKLZkiEqGQbRuhqgXgrALHLmM5ByNOC+FmFlEQQ1voSMk
         35b/Fai0BdBBkVjWbTC2YIkrO2LshbqYHqIfgIPoKhURkHPSv/2nALf1ZgrHnuYo82R7
         2lIA4TwDZtPPmf1wMxPOLPUlrUo0kvnXfqRSTIUfS1gh3Clr8FQxhYdPPe3UN1ZCXo8y
         aNgG+D96h6om0iS6HLVBMsPlCMhdhKbLGLYBuLTkN3ttJ5cTLqslC/BMUJok8QiuEmcb
         7iaZCRyuUt3stL849aoMKIa/us9z6hTkx0sTwmvS8neG0fYUvrRdgKRSyseifRdk+hGp
         4ocQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 62/95] ALSA: pcm: Return -EBUSY for OSS ioctls changing busy streams
Date: Sun, 22 Apr 2018 15:53:31 +0200
Message-Id: <20180422135212.962826250@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455078261500157?=
X-GMAIL-MSGID: =?utf-8?q?1598456056464132630?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 40cab6e88cb0b6c56d3f30b7491a20e803f948f6 upstream.

OSS PCM stream management isn't modal but it allows ioctls issued at
any time for changing the parameters.  In the previous hardening
patch ("ALSA: pcm: Avoid potential races between OSS ioctls and
read/write"), we covered these races and prevent the corruption by
protecting the concurrent accesses via params_lock mutex.  However,
this means that some ioctls that try to change the stream parameter
(e.g. channels or format) would be blocked until the read/write
finishes, and it may take really long.

Basically changing the parameter while reading/writing is an invalid
operation, hence it's even more user-friendly from the API POV if it
returns -EBUSY in such a situation.

This patch adds such checks in the relevant ioctls with the addition
of read/write access refcount.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/sound/pcm_oss.h  |    1 +
 sound/core/oss/pcm_oss.c |   36 +++++++++++++++++++++++++++---------
 2 files changed, 28 insertions(+), 9 deletions(-)

--- a/include/sound/pcm_oss.h
+++ b/include/sound/pcm_oss.h
@@ -57,6 +57,7 @@ struct snd_pcm_oss_runtime {
 	char *buffer;				/* vmallocated period */
 	size_t buffer_used;			/* used length from period buffer */
 	struct mutex params_lock;
+	atomic_t rw_ref;		/* concurrent read/write accesses */
 #ifdef CONFIG_SND_PCM_OSS_PLUGINS
 	struct snd_pcm_plugin *plugin_first;
 	struct snd_pcm_plugin *plugin_last;
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1405,6 +1405,7 @@ static ssize_t snd_pcm_oss_write1(struct
 	if (atomic_read(&substream->mmap_count))
 		return -ENXIO;
 
+	atomic_inc(&runtime->oss.rw_ref);
 	while (bytes > 0) {
 		if (mutex_lock_interruptible(&runtime->oss.params_lock)) {
 			tmp = -ERESTARTSYS;
@@ -1468,6 +1469,7 @@ static ssize_t snd_pcm_oss_write1(struct
 		}
 		tmp = 0;
 	}
+	atomic_dec(&runtime->oss.rw_ref);
 	return xfer > 0 ? (snd_pcm_sframes_t)xfer : tmp;
 }
 
@@ -1513,6 +1515,7 @@ static ssize_t snd_pcm_oss_read1(struct
 	if (atomic_read(&substream->mmap_count))
 		return -ENXIO;
 
+	atomic_inc(&runtime->oss.rw_ref);
 	while (bytes > 0) {
 		if (mutex_lock_interruptible(&runtime->oss.params_lock)) {
 			tmp = -ERESTARTSYS;
@@ -1561,6 +1564,7 @@ static ssize_t snd_pcm_oss_read1(struct
 		}
 		tmp = 0;
 	}
+	atomic_dec(&runtime->oss.rw_ref);
 	return xfer > 0 ? (snd_pcm_sframes_t)xfer : tmp;
 }
 
@@ -1667,8 +1671,11 @@ static int snd_pcm_oss_sync(struct snd_p
 			goto __direct;
 		if ((err = snd_pcm_oss_make_ready(substream)) < 0)
 			return err;
-		if (mutex_lock_interruptible(&runtime->oss.params_lock))
+		atomic_inc(&runtime->oss.rw_ref);
+		if (mutex_lock_interruptible(&runtime->oss.params_lock)) {
+			atomic_dec(&runtime->oss.rw_ref);
 			return -ERESTARTSYS;
+		}
 		format = snd_pcm_oss_format_from(runtime->oss.format);
 		width = snd_pcm_format_physical_width(format);
 		if (runtime->oss.buffer_used > 0) {
@@ -1680,10 +1687,8 @@ static int snd_pcm_oss_sync(struct snd_p
 						   runtime->oss.buffer + runtime->oss.buffer_used,
 						   size);
 			err = snd_pcm_oss_sync1(substream, runtime->oss.period_bytes);
-			if (err < 0) {
-				mutex_unlock(&runtime->oss.params_lock);
-				return err;
-			}
+			if (err < 0)
+				goto unlock;
 		} else if (runtime->oss.period_ptr > 0) {
 #ifdef OSS_DEBUG
 			pcm_dbg(substream->pcm, "sync: period_ptr\n");
@@ -1693,10 +1698,8 @@ static int snd_pcm_oss_sync(struct snd_p
 						   runtime->oss.buffer,
 						   size * 8 / width);
 			err = snd_pcm_oss_sync1(substream, size);
-			if (err < 0) {
-				mutex_unlock(&runtime->oss.params_lock);
-				return err;
-			}
+			if (err < 0)
+				goto unlock;
 		}
 		/*
 		 * The ALSA's period might be a bit large than OSS one.
@@ -1727,7 +1730,11 @@ static int snd_pcm_oss_sync(struct snd_p
 				snd_pcm_lib_writev(substream, buffers, size);
 			}
 		}
+unlock:
 		mutex_unlock(&runtime->oss.params_lock);
+		atomic_dec(&runtime->oss.rw_ref);
+		if (err < 0)
+			return err;
 		/*
 		 * finish sync: drain the buffer
 		 */
@@ -1775,6 +1782,8 @@ static int snd_pcm_oss_set_rate(struct s
 			rate = 192000;
 		if (mutex_lock_interruptible(&runtime->oss.params_lock))
 			return -ERESTARTSYS;
+		if (atomic_read(&runtime->oss.rw_ref))
+			return -EBUSY;
 		if (runtime->oss.rate != rate) {
 			runtime->oss.params = 1;
 			runtime->oss.rate = rate;
@@ -1809,6 +1818,8 @@ static int snd_pcm_oss_set_channels(stru
 		runtime = substream->runtime;
 		if (mutex_lock_interruptible(&runtime->oss.params_lock))
 			return -ERESTARTSYS;
+		if (atomic_read(&runtime->oss.rw_ref))
+			return -EBUSY;
 		if (runtime->oss.channels != channels) {
 			runtime->oss.params = 1;
 			runtime->oss.channels = channels;
@@ -1899,6 +1910,8 @@ static int snd_pcm_oss_set_format(struct
 			if (substream == NULL)
 				continue;
 			runtime = substream->runtime;
+			if (atomic_read(&runtime->oss.rw_ref))
+				return -EBUSY;
 			if (mutex_lock_interruptible(&runtime->oss.params_lock))
 				return -ERESTARTSYS;
 			if (runtime->oss.format != format) {
@@ -1953,6 +1966,8 @@ static int snd_pcm_oss_set_subdivide(str
 		if (substream == NULL)
 			continue;
 		runtime = substream->runtime;
+		if (atomic_read(&runtime->oss.rw_ref))
+			return -EBUSY;
 		if (mutex_lock_interruptible(&runtime->oss.params_lock))
 			return -ERESTARTSYS;
 		err = snd_pcm_oss_set_subdivide1(substream, subdivide);
@@ -1991,6 +2006,8 @@ static int snd_pcm_oss_set_fragment(stru
 		if (substream == NULL)
 			continue;
 		runtime = substream->runtime;
+		if (atomic_read(&runtime->oss.rw_ref))
+			return -EBUSY;
 		if (mutex_lock_interruptible(&runtime->oss.params_lock))
 			return -ERESTARTSYS;
 		err = snd_pcm_oss_set_fragment1(substream, val);
@@ -2385,6 +2402,7 @@ static void snd_pcm_oss_init_substream(s
 	runtime->oss.maxfrags = 0;
 	runtime->oss.subdivision = 0;
 	substream->pcm_release = snd_pcm_oss_release_substream;
+	atomic_set(&runtime->oss.rw_ref, 0);
 }
 
 static int snd_pcm_oss_release_file(struct snd_pcm_oss_file *pcm_oss_file)
