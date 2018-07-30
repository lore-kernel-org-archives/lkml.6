Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFB7FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBAA20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BBAA20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbeG3K5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:57:49 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:56190 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbeG3K5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:57:49 -0400
Received: from [148.252.241.226] (helo=ct-lt-1121.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fk4Oz-0004qJ-30; Mon, 30 Jul 2018 10:23:41 +0100
From:   Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
To:     tiwai@suse.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] ALSA: usb-audio: Add UAC3 Power Domains to suspend/resume
Date:   Mon, 30 Jul 2018 10:23:35 +0100
Message-Id: <20180730092336.18741-4-jorge.sanjuan@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180730092336.18741-1-jorge.sanjuan@codethink.co.uk>
References: <20180719112215.4219-1-jorge.sanjuan@codethink.co.uk>
 <20180730092336.18741-1-jorge.sanjuan@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the UAC3 Power Domain state for an Audio Streaming interface
to D2 state before suspending the device (usb_driver callback).
This lets the device know there is no intention to use any of the
Units in the Audio Function and that the host is not going to
even listen for wake-up events (interrupts) on the units.

When the usb_driver gets resumed, the state D0 (fully powered) will
be set. This ties up the UAC3 Power Domains to the runtime PM.

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 sound/usb/card.c |  9 +++++++++
 sound/usb/pcm.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 sound/usb/pcm.h  |  2 ++
 3 files changed, 59 insertions(+)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index a1ed798a1c6b..9c2a15b805c3 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -808,6 +808,7 @@ static int usb_audio_suspend(struct usb_interface *intf, pm_message_t message)
 		snd_power_change_state(chip->card, SNDRV_CTL_POWER_D3hot);
 	if (!chip->num_suspended_intf++) {
 		list_for_each_entry(as, &chip->pcm_list, list) {
+			snd_usb_pcm_suspend(as);
 			snd_pcm_suspend_all(as->pcm);
 			as->substream[0].need_setup_ep =
 				as->substream[1].need_setup_ep = true;
@@ -824,6 +825,7 @@ static int usb_audio_suspend(struct usb_interface *intf, pm_message_t message)
 static int __usb_audio_resume(struct usb_interface *intf, bool reset_resume)
 {
 	struct snd_usb_audio *chip = usb_get_intfdata(intf);
+	struct snd_usb_stream *as;
 	struct usb_mixer_interface *mixer;
 	struct list_head *p;
 	int err = 0;
@@ -834,6 +836,13 @@ static int __usb_audio_resume(struct usb_interface *intf, bool reset_resume)
 		return 0;
 
 	atomic_inc(&chip->active); /* avoid autopm */
+
+	list_for_each_entry(as, &chip->pcm_list, list) {
+		err = snd_usb_pcm_resume(as);
+		if (err < 0)
+			goto err_out;
+	}
+
 	/*
 	 * ALSA leaves material resumption to user space
 	 * we just notify and restart the mixers
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 4b930fa47277..99ec9d5caa58 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -711,6 +711,54 @@ static int configure_endpoint(struct snd_usb_substream *subs)
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
+int snd_usb_pcm_suspend(struct snd_usb_stream *as)
+{
+	int ret;
+
+	ret = snd_usb_pcm_change_state(&as->substream[0], UAC3_PD_STATE_D2);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_usb_pcm_change_state(&as->substream[1], UAC3_PD_STATE_D2);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+int snd_usb_pcm_resume(struct snd_usb_stream *as)
+{
+	int ret;
+
+	ret = snd_usb_pcm_change_state(&as->substream[0], UAC3_PD_STATE_D0);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_usb_pcm_change_state(&as->substream[1], UAC3_PD_STATE_D0);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 /*
  * hw_params callback
  *
diff --git a/sound/usb/pcm.h b/sound/usb/pcm.h
index f77ec58bf1a1..9833627c1eca 100644
--- a/sound/usb/pcm.h
+++ b/sound/usb/pcm.h
@@ -6,6 +6,8 @@ snd_pcm_uframes_t snd_usb_pcm_delay(struct snd_usb_substream *subs,
 				    unsigned int rate);
 
 void snd_usb_set_pcm_ops(struct snd_pcm *pcm, int stream);
+int snd_usb_pcm_suspend(struct snd_usb_stream *as);
+int snd_usb_pcm_resume(struct snd_usb_stream *as);
 
 int snd_usb_init_pitch(struct snd_usb_audio *chip, int iface,
 		       struct usb_host_interface *alts,
-- 
2.11.0

