Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61011C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2597F20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2597F20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbeJNXUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:20:48 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36860 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728015AbeJNXUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:20:48 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiME-0004cg-Pf; Sun, 14 Oct 2018 16:31:06 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLO-0000Cu-WA; Sun, 14 Oct 2018 16:30:15 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>
Date:   Sun, 14 Oct 2018 16:25:40 +0100
Message-ID: <lsq.1539530740.917146154@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 054/366] ALSA: pcm: Return -EBUSY for OSS ioctls
 changing busy streams
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/sound/pcm_oss.h  |  1 +
 sound/core/oss/pcm_oss.c | 36 +++++++++++++++++++++++++++---------
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
@@ -1406,6 +1406,7 @@ static ssize_t snd_pcm_oss_write1(struct
 	if (atomic_read(&substream->mmap_count))
 		return -ENXIO;
 
+	atomic_inc(&runtime->oss.rw_ref);
 	while (bytes > 0) {
 		if (mutex_lock_interruptible(&runtime->oss.params_lock)) {
 			tmp = -ERESTARTSYS;
@@ -1469,6 +1470,7 @@ static ssize_t snd_pcm_oss_write1(struct
 		}
 		tmp = 0;
 	}
+	atomic_dec(&runtime->oss.rw_ref);
 	return xfer > 0 ? (snd_pcm_sframes_t)xfer : tmp;
 }
 
@@ -1514,6 +1516,7 @@ static ssize_t snd_pcm_oss_read1(struct
 	if (atomic_read(&substream->mmap_count))
 		return -ENXIO;
 
+	atomic_inc(&runtime->oss.rw_ref);
 	while (bytes > 0) {
 		if (mutex_lock_interruptible(&runtime->oss.params_lock)) {
 			tmp = -ERESTARTSYS;
@@ -1562,6 +1565,7 @@ static ssize_t snd_pcm_oss_read1(struct
 		}
 		tmp = 0;
 	}
+	atomic_dec(&runtime->oss.rw_ref);
 	return xfer > 0 ? (snd_pcm_sframes_t)xfer : tmp;
 }
 
@@ -1668,8 +1672,11 @@ static int snd_pcm_oss_sync(struct snd_p
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
@@ -1681,10 +1688,8 @@ static int snd_pcm_oss_sync(struct snd_p
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
@@ -1694,10 +1699,8 @@ static int snd_pcm_oss_sync(struct snd_p
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
@@ -1728,7 +1731,11 @@ static int snd_pcm_oss_sync(struct snd_p
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
@@ -1776,6 +1783,8 @@ static int snd_pcm_oss_set_rate(struct s
 			rate = 192000;
 		if (mutex_lock_interruptible(&runtime->oss.params_lock))
 			return -ERESTARTSYS;
+		if (atomic_read(&runtime->oss.rw_ref))
+			return -EBUSY;
 		if (runtime->oss.rate != rate) {
 			runtime->oss.params = 1;
 			runtime->oss.rate = rate;
@@ -1810,6 +1819,8 @@ static int snd_pcm_oss_set_channels(stru
 		runtime = substream->runtime;
 		if (mutex_lock_interruptible(&runtime->oss.params_lock))
 			return -ERESTARTSYS;
+		if (atomic_read(&runtime->oss.rw_ref))
+			return -EBUSY;
 		if (runtime->oss.channels != channels) {
 			runtime->oss.params = 1;
 			runtime->oss.channels = channels;
@@ -1898,6 +1909,8 @@ static int snd_pcm_oss_set_format(struct
 			if (substream == NULL)
 				continue;
 			runtime = substream->runtime;
+			if (atomic_read(&runtime->oss.rw_ref))
+				return -EBUSY;
 			if (mutex_lock_interruptible(&runtime->oss.params_lock))
 				return -ERESTARTSYS;
 			if (runtime->oss.format != format) {
@@ -1952,6 +1965,8 @@ static int snd_pcm_oss_set_subdivide(str
 		if (substream == NULL)
 			continue;
 		runtime = substream->runtime;
+		if (atomic_read(&runtime->oss.rw_ref))
+			return -EBUSY;
 		if (mutex_lock_interruptible(&runtime->oss.params_lock))
 			return -ERESTARTSYS;
 		err = snd_pcm_oss_set_subdivide1(substream, subdivide);
@@ -1990,6 +2005,8 @@ static int snd_pcm_oss_set_fragment(stru
 		if (substream == NULL)
 			continue;
 		runtime = substream->runtime;
+		if (atomic_read(&runtime->oss.rw_ref))
+			return -EBUSY;
 		if (mutex_lock_interruptible(&runtime->oss.params_lock))
 			return -ERESTARTSYS;
 		err = snd_pcm_oss_set_fragment1(substream, val);
@@ -2384,6 +2401,7 @@ static void snd_pcm_oss_init_substream(s
 	runtime->oss.maxfrags = 0;
 	runtime->oss.subdivision = 0;
 	substream->pcm_release = snd_pcm_oss_release_substream;
+	atomic_set(&runtime->oss.rw_ref, 0);
 }
 
 static int snd_pcm_oss_release_file(struct snd_pcm_oss_file *pcm_oss_file)

