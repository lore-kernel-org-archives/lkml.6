Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A67D13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BACC208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:23:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BACC208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbeG3K5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:57:49 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:56191 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeG3K5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:57:49 -0400
Received: from [148.252.241.226] (helo=ct-lt-1121.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fk4Oz-0004qJ-Am; Mon, 30 Jul 2018 10:23:41 +0100
From:   Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
To:     tiwai@suse.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] ALSA: usb-audio: Operate UAC3 Power Domains in PCM callbacks
Date:   Mon, 30 Jul 2018 10:23:36 +0100
Message-Id: <20180730092336.18741-5-jorge.sanjuan@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180730092336.18741-1-jorge.sanjuan@codethink.co.uk>
References: <20180719112215.4219-1-jorge.sanjuan@codethink.co.uk>
 <20180730092336.18741-1-jorge.sanjuan@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of UAC3 Power Domains associated to an Audio Streaming
path within the PCM's logic. This means, when there is no audio
being transferred (pcm is closed), the host will set the Power Domain
associated to that substream to state D1. When audio is being transferred
(from hw_params onwards), the Power Domain will be set to D0 state.

This is the way the host lets the device know which Terminal
is going to be actively used and it is for the device to
manage its own internal resources on that UAC3 Power Domain.

Note the resume method now sets the Power Domain to D1 state as
resuming the device doesn't mean audio streaming will occur.

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 sound/usb/pcm.c    | 20 +++++++++++++++-----
 sound/usb/stream.c |  6 +++++-
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 99ec9d5caa58..266f7028d01b 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -748,11 +748,11 @@ int snd_usb_pcm_resume(struct snd_usb_stream *as)
 {
 	int ret;
 
-	ret = snd_usb_pcm_change_state(&as->substream[0], UAC3_PD_STATE_D0);
+	ret = snd_usb_pcm_change_state(&as->substream[0], UAC3_PD_STATE_D1);
 	if (ret < 0)
 		return ret;
 
-	ret = snd_usb_pcm_change_state(&as->substream[1], UAC3_PD_STATE_D0);
+	ret = snd_usb_pcm_change_state(&as->substream[1], UAC3_PD_STATE_D1);
 	if (ret < 0)
 		return ret;
 
@@ -803,16 +803,22 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
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
@@ -1313,6 +1319,7 @@ static int snd_usb_pcm_close(struct snd_pcm_substream *substream)
 	int direction = substream->stream;
 	struct snd_usb_stream *as = snd_pcm_substream_chip(substream);
 	struct snd_usb_substream *subs = &as->substream[direction];
+	int ret;
 
 	stop_endpoints(subs, true);
 
@@ -1321,7 +1328,10 @@ static int snd_usb_pcm_close(struct snd_pcm_substream *substream)
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
index c0567fa1e84b..8fe3b0e00e45 100644
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

