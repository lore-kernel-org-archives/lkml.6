Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9C8C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B0220645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B0220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbeJNXTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:19:50 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36794 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728015AbeJNXTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:19:50 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiME-0004co-QV; Sun, 14 Oct 2018 16:31:06 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLP-0000DH-6F; Sun, 14 Oct 2018 16:30:15 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.491067041@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 059/366] ALSA: pcm: Fix mutex unbalance in OSS
 emulation ioctls
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

commit f6d297df4dd47ef949540e4a201230d0c5308325 upstream.

The previous fix 40cab6e88cb0 ("ALSA: pcm: Return -EBUSY for OSS
ioctls changing busy streams") introduced some mutex unbalance; the
check of runtime->oss.rw_ref was inserted in a wrong place after the
mutex lock.

This patch fixes the inconsistency by rewriting with the helper
functions to lock/unlock parameters with the stream check.

Fixes: 40cab6e88cb0 ("ALSA: pcm: Return -EBUSY for OSS ioctls changing busy streams")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/oss/pcm_oss.c | 67 +++++++++++++++++++++++++---------------
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
@@ -1774,6 +1791,8 @@ static int snd_pcm_oss_set_rate(struct s
 	for (idx = 1; idx >= 0; --idx) {
 		struct snd_pcm_substream *substream = pcm_oss_file->streams[idx];
 		struct snd_pcm_runtime *runtime;
+		int err;
+
 		if (substream == NULL)
 			continue;
 		runtime = substream->runtime;
@@ -1781,15 +1800,14 @@ static int snd_pcm_oss_set_rate(struct s
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
@@ -1814,18 +1832,19 @@ static int snd_pcm_oss_set_channels(stru
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
@@ -1896,6 +1915,7 @@ static int snd_pcm_oss_get_formats(struc
 static int snd_pcm_oss_set_format(struct snd_pcm_oss_file *pcm_oss_file, int format)
 {
 	int formats, idx;
+	int err;
 	
 	if (format != AFMT_QUERY) {
 		formats = snd_pcm_oss_get_formats(pcm_oss_file);
@@ -1909,15 +1929,14 @@ static int snd_pcm_oss_set_format(struct
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
@@ -1965,12 +1984,11 @@ static int snd_pcm_oss_set_subdivide(str
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
@@ -2005,12 +2023,11 @@ static int snd_pcm_oss_set_fragment(stru
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

