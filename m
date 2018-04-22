Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48X4BkCeed3YFhDd3JlOo/+o7d98esnjFkkjactfUEPfE5AahCXqi0m+AKLSeMDckKs83zr
ARC-Seal: i=1; a=rsa-sha256; t=1524405553; cv=none;
        d=google.com; s=arc-20160816;
        b=Kqp7TvFzsGXX0nd0seLl98lkmbUbrNlAaqPTRM3YMZC3mroUTKD/v9FONddm5Uqc4K
         vDumv9NE355UTDC4Po7afFSMi7aoS45LD83R8azwfykNQfV72bD+q31a9X6UYvYlnThr
         Khx1uIFudL5YfMCPeJHDqIRV1NJwi60fdPiVWyR6AGJXpKCfY2BJIAwEsortoJGiepU+
         UR0f3+voZC5e9gXISR7ANCtTiBjFR7AzkVanza3L5S5cblfgoNij0gNUudHcby489BZC
         aLXZyRN5i6azyty41ykMIpB5FOMYin4UT4NzwfoWFMj8Trkxhit89TI8VH81Br6+1LjR
         FDvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=f9q83qqtA9LNV7n3fNsAbRHtHfrKLOCDfdHHxaIkyvc=;
        b=XjWh3CTD/PmJD+Kib4jGHyYcym7fGFz/NpMfXb7By4jE8/6uRRAhcy0XPjjROMdq6E
         +vSI8z9AxoZVQFFKLoAzybEa+uTTSN+wSenE6/1nTvdf+UzJidnLi08UyvFbgWEU1Lg/
         5I1GRmUFl/zxRwj8sWWZTTbJT5ejfCUJ1Q+/mNGwJtwiRlQ5m/tKdJPtv2MWOKlXVx+7
         I621xwwybcigJHIPhDlcJs7oMHJ7jJIDfEFZ5nUZjl+/gLhJaRJSBn5HL5loI3+jHXNr
         ZGXOuP/62hsMy/CAyes5NtdsYzRl1eSclKomhpGEzLBEnU6EiB6z7cgrriY4jLxzSAs4
         lDEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.16 109/196] ALSA: pcm: Return -EBUSY for OSS ioctls changing busy streams
Date: Sun, 22 Apr 2018 15:52:09 +0200
Message-Id: <20180422135109.919366829@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455078261500157?=
X-GMAIL-MSGID: =?utf-8?q?1598455078261500157?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1370,6 +1370,7 @@ static ssize_t snd_pcm_oss_write1(struct
 	if (atomic_read(&substream->mmap_count))
 		return -ENXIO;
 
+	atomic_inc(&runtime->oss.rw_ref);
 	while (bytes > 0) {
 		if (mutex_lock_interruptible(&runtime->oss.params_lock)) {
 			tmp = -ERESTARTSYS;
@@ -1433,6 +1434,7 @@ static ssize_t snd_pcm_oss_write1(struct
 		}
 		tmp = 0;
 	}
+	atomic_dec(&runtime->oss.rw_ref);
 	return xfer > 0 ? (snd_pcm_sframes_t)xfer : tmp;
 }
 
@@ -1478,6 +1480,7 @@ static ssize_t snd_pcm_oss_read1(struct
 	if (atomic_read(&substream->mmap_count))
 		return -ENXIO;
 
+	atomic_inc(&runtime->oss.rw_ref);
 	while (bytes > 0) {
 		if (mutex_lock_interruptible(&runtime->oss.params_lock)) {
 			tmp = -ERESTARTSYS;
@@ -1526,6 +1529,7 @@ static ssize_t snd_pcm_oss_read1(struct
 		}
 		tmp = 0;
 	}
+	atomic_dec(&runtime->oss.rw_ref);
 	return xfer > 0 ? (snd_pcm_sframes_t)xfer : tmp;
 }
 
@@ -1632,8 +1636,11 @@ static int snd_pcm_oss_sync(struct snd_p
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
@@ -1645,10 +1652,8 @@ static int snd_pcm_oss_sync(struct snd_p
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
@@ -1658,10 +1663,8 @@ static int snd_pcm_oss_sync(struct snd_p
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
@@ -1675,7 +1678,11 @@ static int snd_pcm_oss_sync(struct snd_p
 			else if (runtime->access == SNDRV_PCM_ACCESS_RW_NONINTERLEAVED)
 				snd_pcm_lib_writev(substream, NULL, size);
 		}
+unlock:
 		mutex_unlock(&runtime->oss.params_lock);
+		atomic_dec(&runtime->oss.rw_ref);
+		if (err < 0)
+			return err;
 		/*
 		 * finish sync: drain the buffer
 		 */
@@ -1723,6 +1730,8 @@ static int snd_pcm_oss_set_rate(struct s
 			rate = 192000;
 		if (mutex_lock_interruptible(&runtime->oss.params_lock))
 			return -ERESTARTSYS;
+		if (atomic_read(&runtime->oss.rw_ref))
+			return -EBUSY;
 		if (runtime->oss.rate != rate) {
 			runtime->oss.params = 1;
 			runtime->oss.rate = rate;
@@ -1757,6 +1766,8 @@ static int snd_pcm_oss_set_channels(stru
 		runtime = substream->runtime;
 		if (mutex_lock_interruptible(&runtime->oss.params_lock))
 			return -ERESTARTSYS;
+		if (atomic_read(&runtime->oss.rw_ref))
+			return -EBUSY;
 		if (runtime->oss.channels != channels) {
 			runtime->oss.params = 1;
 			runtime->oss.channels = channels;
@@ -1847,6 +1858,8 @@ static int snd_pcm_oss_set_format(struct
 			if (substream == NULL)
 				continue;
 			runtime = substream->runtime;
+			if (atomic_read(&runtime->oss.rw_ref))
+				return -EBUSY;
 			if (mutex_lock_interruptible(&runtime->oss.params_lock))
 				return -ERESTARTSYS;
 			if (runtime->oss.format != format) {
@@ -1901,6 +1914,8 @@ static int snd_pcm_oss_set_subdivide(str
 		if (substream == NULL)
 			continue;
 		runtime = substream->runtime;
+		if (atomic_read(&runtime->oss.rw_ref))
+			return -EBUSY;
 		if (mutex_lock_interruptible(&runtime->oss.params_lock))
 			return -ERESTARTSYS;
 		err = snd_pcm_oss_set_subdivide1(substream, subdivide);
@@ -1939,6 +1954,8 @@ static int snd_pcm_oss_set_fragment(stru
 		if (substream == NULL)
 			continue;
 		runtime = substream->runtime;
+		if (atomic_read(&runtime->oss.rw_ref))
+			return -EBUSY;
 		if (mutex_lock_interruptible(&runtime->oss.params_lock))
 			return -ERESTARTSYS;
 		err = snd_pcm_oss_set_fragment1(substream, val);
@@ -2333,6 +2350,7 @@ static void snd_pcm_oss_init_substream(s
 	runtime->oss.maxfrags = 0;
 	runtime->oss.subdivision = 0;
 	substream->pcm_release = snd_pcm_oss_release_substream;
+	atomic_set(&runtime->oss.rw_ref, 0);
 }
 
 static int snd_pcm_oss_release_file(struct snd_pcm_oss_file *pcm_oss_file)
