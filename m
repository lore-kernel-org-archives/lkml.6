Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79B4ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 11:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2942084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 11:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2942084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbeGSMFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 08:05:04 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:59732 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbeGSMFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 08:05:04 -0400
Received: from [148.252.241.226] (helo=ct-lt-1121.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fg70l-0004fU-Az; Thu, 19 Jul 2018 12:22:19 +0100
From:   Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
To:     tiwai@suse.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] ALSA: usb-audio: Operate UAC3 Power Domains in PCM callbacks
Date:   Thu, 19 Jul 2018 12:22:14 +0100
Message-Id: <20180719112215.4219-4-jorge.sanjuan@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180719112215.4219-1-jorge.sanjuan@codethink.co.uk>
References: <20180719112215.4219-1-jorge.sanjuan@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of UAC3 Power Domains associated to an Audio Streaming
path within the PCM's logic. This means, when there is no audio
being transferred (pcm is closed), the host will set the Power Domain
associated to that substream to state D1. When audio is being transferred
(from hw_params onwards), the Power Domain will be set to D0 state.

This is the way the host lets the device now which Terminal
is going to be actively used and it is for the device to
manage its own internal resources on that UAC3 Power Domain.

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 sound/usb/pcm.c    | 34 +++++++++++++++++++++++++++++++---
 sound/usb/stream.c |  6 +++++-
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 4b930fa47277..0ae5f539706d 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -711,6 +711,24 @@ static int configure_endpoint(struct snd_usb_substream *subs)
 	return ret;
 }
 
+static int snd_usb_pcm_change_state(struct snd_usb_substream *subs, int state)
+{
+	int ret;
+
+	if (!subs->str_pd)
+		return 0;
+
+	ret = snd_usb_power_domain_set(subs->stream->chip, subs->str_pd, state);
+	if (ret < 0) {
+		dev_err(&subs->dev->dev,
+			"Cannot change Power Domain ID: %d to state: %d. Err: %d\n",
+			subs->str_pd->pd_id, state, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 /*
  * hw_params callback
  *
@@ -755,16 +773,22 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 	ret = snd_usb_lock_shutdown(subs->stream->chip);
 	if (ret < 0)
 		return ret;
+
 	ret = set_format(subs, fmt);
-	snd_usb_unlock_shutdown(subs->stream->chip);
 	if (ret < 0)
-		return ret;
+		goto unlock;
+
+	ret = snd_usb_pcm_change_state(subs, UAC3_PD_STATE_D0);
+	if (ret < 0)
+		goto unlock;
 
 	subs->interface = fmt->iface;
 	subs->altset_idx = fmt->altset_idx;
 	subs->need_setup_ep = true;
 
-	return 0;
+ unlock:
+	snd_usb_unlock_shutdown(subs->stream->chip);
+	return ret;
 }
 
 /*
@@ -1265,6 +1289,7 @@ static int snd_usb_pcm_close(struct snd_pcm_substream *substream)
 	int direction = substream->stream;
 	struct snd_usb_stream *as = snd_pcm_substream_chip(substream);
 	struct snd_usb_substream *subs = &as->substream[direction];
+	int ret;
 
 	stop_endpoints(subs, true);
 
@@ -1273,7 +1298,10 @@ static int snd_usb_pcm_close(struct snd_pcm_substream *substream)
 	    !snd_usb_lock_shutdown(subs->stream->chip)) {
 		usb_set_interface(subs->dev, subs->interface, 0);
 		subs->interface = -1;
+		ret = snd_usb_pcm_change_state(subs, UAC3_PD_STATE_D1);
 		snd_usb_unlock_shutdown(subs->stream->chip);
+		if (ret < 0)
+			return ret;
 	}
 
 	subs->pcm_substream = NULL;
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 031878a2a481..96402ca87aa5 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -110,8 +110,12 @@ static void snd_usb_init_substream(struct snd_usb_stream *as,
 	if (fp->channels > subs->channels_max)
 		subs->channels_max = fp->channels;
 
-	if (pd)
+	if (pd) {
 		subs->str_pd = pd;
+		/* Initialize Power Domain to idle status D1 */
+		snd_usb_power_domain_set(subs->stream->chip, pd,
+					 UAC3_PD_STATE_D1);
+	}
 
 	snd_usb_preallocate_buffer(subs);
 }
-- 
2.11.0

