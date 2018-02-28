Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-659992-1519838671-2-4783702721624096821
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roenca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519838670; b=VE73iP0zltkIYzUlurCgFHyGG9LtCW6KEoRSt5c2RSgIX8P
    Qkw1i/mB1iQFFfDanbmkmNJeutzuv1w/Y1PZ3J4oKsTcvMYD6822X0yURIpUn6Hu
    AgHlIAHINayxLqURM/mPaEitoZj+ul1OnKeyC8rmKS0qigCHAflj6nlkGjPdS8V7
    DqO56zyxon4qqQ1LP5L2TxlG/oX48gvMBnMv5sDU7CRQVnzBpBU2YHjiF0gA9FoK
    kb47+nMFUhEgBhyFH7i9Zfotg4MsUNXJyC9AIcxmBVuXkzbnNCabCe6zm9wkWZfW
    T6T3TY6ZFbIc3+brdjovZF7FVN95HrIWQL0Cn0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519838670; bh=Kaj2WI2adUdTe9pxnXc
    RiAEPTNSvBHygU9R4pfftpaw=; b=j+q6mAvGzYysHtlQi1K8RRMJRQBX6vb0f5H
    5NbKHwlIy4N2mEN6rhRb4sPVGXr/Golu9hVNfXl93edhYKcd1IOyty2CApFJjY4s
    Q7JeXN+izApmHrEmEfefaomtCc1qzw4Hqu2J4BZBh3qe4/IpBPwbh29JhgW7qtqw
    Y+ta0ipjlj/h6VeXEttWhDCC7ZsrDdgEHpuswMzUFilfuJpUaQ3H5r9FQslMXVty
    n5/dva25qEuMBR6T8NV5qB/scEH7xK0R2ejV3iKMyp+GQzR/HE2M8mKSYr5dWy3z
    iyan7qc70q4X6mFmpaexDa0SPwg+QPCjEoWbRBtu1QP0eG8+JCQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933028AbeB1RXz (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:23:55 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33257 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932613AbeB1PWP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:15 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.94027924@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 087/140] ALSA: aloop: Fix racy hw constraints adjustment
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 898dfe4687f460ba337a01c11549f87269a13fa2 upstream.

The aloop driver tries to update the hw constraints of the connected
target on the cable of the opened PCM substream.  This is done by
adding the extra hw constraints rules referring to the substream
runtime->hw fields, while the other substream may update the runtime
hw of another side on the fly.

This is, however, racy and may result in the inconsistent values when
both PCM streams perform the prepare concurrently.  One of the reason
is that it overwrites the other's runtime->hw field; which is not only
racy but also broken when it's called before the open of another side
finishes.  And, since the reference to runtime->hw isn't protected,
the concurrent write may give the partial value update and become
inconsistent.

This patch is an attempt to fix and clean up:
- The prepare doesn't change the runtime->hw of other side any longer,
  but only update the cable->hw that is referred commonly.
- The extra rules refer to the loopback_pcm object instead of the
  runtime->hw.  The actual hw is deduced from cable->hw.
- The extra rules take the cable_lock to protect against the race.

Fixes: b1c73fc8e697 ("ALSA: snd-aloop: Fix hw_params restrictions and checking")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/drivers/aloop.c | 51 +++++++++++++++++++++------------------------------
 1 file changed, 21 insertions(+), 30 deletions(-)

--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -308,19 +308,6 @@ static int loopback_trigger(struct snd_p
 	return 0;
 }
 
-static void params_change_substream(struct loopback_pcm *dpcm,
-				    struct snd_pcm_runtime *runtime)
-{
-	struct snd_pcm_runtime *dst_runtime;
-
-	if (dpcm == NULL || dpcm->substream == NULL)
-		return;
-	dst_runtime = dpcm->substream->runtime;
-	if (dst_runtime == NULL)
-		return;
-	dst_runtime->hw = dpcm->cable->hw;
-}
-
 static void params_change(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -332,10 +319,6 @@ static void params_change(struct snd_pcm
 	cable->hw.rate_max = runtime->rate;
 	cable->hw.channels_min = runtime->channels;
 	cable->hw.channels_max = runtime->channels;
-	params_change_substream(cable->streams[SNDRV_PCM_STREAM_PLAYBACK],
-				runtime);
-	params_change_substream(cable->streams[SNDRV_PCM_STREAM_CAPTURE],
-				runtime);
 }
 
 static int loopback_prepare(struct snd_pcm_substream *substream)
@@ -611,24 +594,29 @@ static unsigned int get_cable_index(stru
 static int rule_format(struct snd_pcm_hw_params *params,
 		       struct snd_pcm_hw_rule *rule)
 {
-
-	struct snd_pcm_hardware *hw = rule->private;
+	struct loopback_pcm *dpcm = rule->private;
+	struct loopback_cable *cable = dpcm->cable;
 	struct snd_mask m;
 
 	snd_mask_none(&m);
-	m.bits[0] = (u_int32_t)hw->formats;
-	m.bits[1] = (u_int32_t)(hw->formats >> 32);
+	mutex_lock(&dpcm->loopback->cable_lock);
+	m.bits[0] = (u_int32_t)cable->hw.formats;
+	m.bits[1] = (u_int32_t)(cable->hw.formats >> 32);
+	mutex_unlock(&dpcm->loopback->cable_lock);
 	return snd_mask_refine(hw_param_mask(params, rule->var), &m);
 }
 
 static int rule_rate(struct snd_pcm_hw_params *params,
 		     struct snd_pcm_hw_rule *rule)
 {
-	struct snd_pcm_hardware *hw = rule->private;
+	struct loopback_pcm *dpcm = rule->private;
+	struct loopback_cable *cable = dpcm->cable;
 	struct snd_interval t;
 
-        t.min = hw->rate_min;
-        t.max = hw->rate_max;
+	mutex_lock(&dpcm->loopback->cable_lock);
+	t.min = cable->hw.rate_min;
+	t.max = cable->hw.rate_max;
+	mutex_unlock(&dpcm->loopback->cable_lock);
         t.openmin = t.openmax = 0;
         t.integer = 0;
 	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
@@ -637,11 +625,14 @@ static int rule_rate(struct snd_pcm_hw_p
 static int rule_channels(struct snd_pcm_hw_params *params,
 			 struct snd_pcm_hw_rule *rule)
 {
-	struct snd_pcm_hardware *hw = rule->private;
+	struct loopback_pcm *dpcm = rule->private;
+	struct loopback_cable *cable = dpcm->cable;
 	struct snd_interval t;
 
-        t.min = hw->channels_min;
-        t.max = hw->channels_max;
+	mutex_lock(&dpcm->loopback->cable_lock);
+	t.min = cable->hw.channels_min;
+	t.max = cable->hw.channels_max;
+	mutex_unlock(&dpcm->loopback->cable_lock);
         t.openmin = t.openmax = 0;
         t.integer = 0;
 	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
@@ -708,19 +699,19 @@ static int loopback_open(struct snd_pcm_
 	/* are cached -> they do not reflect the actual state */
 	err = snd_pcm_hw_rule_add(runtime, 0,
 				  SNDRV_PCM_HW_PARAM_FORMAT,
-				  rule_format, &runtime->hw,
+				  rule_format, dpcm,
 				  SNDRV_PCM_HW_PARAM_FORMAT, -1);
 	if (err < 0)
 		goto unlock;
 	err = snd_pcm_hw_rule_add(runtime, 0,
 				  SNDRV_PCM_HW_PARAM_RATE,
-				  rule_rate, &runtime->hw,
+				  rule_rate, dpcm,
 				  SNDRV_PCM_HW_PARAM_RATE, -1);
 	if (err < 0)
 		goto unlock;
 	err = snd_pcm_hw_rule_add(runtime, 0,
 				  SNDRV_PCM_HW_PARAM_CHANNELS,
-				  rule_channels, &runtime->hw,
+				  rule_channels, dpcm,
 				  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
 	if (err < 0)
 		goto unlock;
