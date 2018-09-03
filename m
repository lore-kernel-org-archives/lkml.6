Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31B7C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91F22077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91F22077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbeICVhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:37:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42570 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbeICVh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:37:29 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 37121D06;
        Mon,  3 Sep 2018 17:16:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eugeniu Rosca <erosca@de.adit-jv.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 019/165] usb: gadget: u_audio: fix pcm/card naming in g_audio_setup()
Date:   Mon,  3 Sep 2018 18:55:05 +0200
Message-Id: <20180903165655.994505525@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eugeniu Rosca <erosca@de.adit-jv.com>

[ Upstream commit dfa042fa310caa475667b8c38d852f14439e0b01 ]

Fix below smatch (v0.5.0-4443-g69e9094e11c1) warnings:
drivers/usb/gadget/function/u_audio.c:607 g_audio_setup() warn: strcpy() 'pcm_name' of unknown size might be too large for 'pcm->name'
drivers/usb/gadget/function/u_audio.c:614 g_audio_setup() warn: strcpy() 'card_name' of unknown size might be too large for 'card->driver'
drivers/usb/gadget/function/u_audio.c:615 g_audio_setup() warn: strcpy() 'card_name' of unknown size might be too large for 'card->shortname'

Below commits performed a similar 's/strcpy/strlcpy/' rework:
* v2.6.31 commit 8372d4980fbc ("ALSA: ctxfi - Fix PCM device naming")
* v4.14 commit 003d3e70dbeb ("ALSA: ad1848: fix format string overflow warning")
* v4.14 commit 6d8b04de87e1 ("ALSA: cs423x: fix format string overflow warning")

Fixes: eb9fecb9e69b ("usb: gadget: f_uac2: split out audio core")
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/u_audio.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -604,15 +604,15 @@ int g_audio_setup(struct g_audio *g_audi
 	if (err < 0)
 		goto snd_fail;
 
-	strcpy(pcm->name, pcm_name);
+	strlcpy(pcm->name, pcm_name, sizeof(pcm->name));
 	pcm->private_data = uac;
 	uac->pcm = pcm;
 
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &uac_pcm_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &uac_pcm_ops);
 
-	strcpy(card->driver, card_name);
-	strcpy(card->shortname, card_name);
+	strlcpy(card->driver, card_name, sizeof(card->driver));
+	strlcpy(card->shortname, card_name, sizeof(card->shortname));
 	sprintf(card->longname, "%s %i", card_name, card->dev->id);
 
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,


