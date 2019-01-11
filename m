Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E1EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C309821841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217607;
	bh=subV7PZCj4edp3nY1BblvIJ9lnaiZUCssgfrsL0eyck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nJZen0niV0vhuPMNmuU5dXLwRY4Kz/9VxMPJ9rjig8J69duoF8CtOMvMh6tMJZTep
	 PXQ196ALvNFueO3YvgJvQXT/uvu2+Du12bML3J/KjDLkWuxtfTAzHUhEoT+DSd5e+L
	 RvKVNKVEL8ISxl8p8j3+xDRxV8ROLjOOOwdkesSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391172AbfAKOkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:40:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:60900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391147AbfAKOkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:40:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8A7521841;
        Fri, 11 Jan 2019 14:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217602;
        bh=subV7PZCj4edp3nY1BblvIJ9lnaiZUCssgfrsL0eyck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q3Ssjb1H1oEGC4UhFse/MhG0tWcu9DOEkner5ZRoPwazMNeecucE+XKRc38YBWj25
         EA5i7Oys8HnMIp/GVmYEuv2tquekaNYQ2qVZYKdqIdav53RKqAFVk/JC0S4iGzO2mN
         XCBlGKa4PpMB62J78Lc2V3KySJkc66vF/xDtl5Ko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 105/148] ALSA: usb-audio: Avoid access before bLength check in build_audio_procunit()
Date:   Fri, 11 Jan 2019 15:14:43 +0100
Message-Id: <20190111131118.419944767@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit f4351a199cc120ff9d59e06d02e8657d08e6cc46 upstream.

The parser for the processing unit reads bNrInPins field before the
bLength sanity check, which may lead to an out-of-bound access when a
malformed descriptor is given.  Fix it by assignment after the bLength
check.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/mixer.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2314,7 +2314,7 @@ static int build_audio_procunit(struct m
 				char *name)
 {
 	struct uac_processing_unit_descriptor *desc = raw_desc;
-	int num_ins = desc->bNrInPins;
+	int num_ins;
 	struct usb_mixer_elem_info *cval;
 	struct snd_kcontrol *kctl;
 	int i, err, nameid, type, len;
@@ -2329,7 +2329,13 @@ static int build_audio_procunit(struct m
 		0, NULL, default_value_info
 	};
 
-	if (desc->bLength < 13 || desc->bLength < 13 + num_ins ||
+	if (desc->bLength < 13) {
+		usb_audio_err(state->chip, "invalid %s descriptor (id %d)\n", name, unitid);
+		return -EINVAL;
+	}
+
+	num_ins = desc->bNrInPins;
+	if (desc->bLength < 13 + num_ins ||
 	    desc->bLength < num_ins + uac_processing_unit_bControlSize(desc, state->mixer->protocol)) {
 		usb_audio_err(state->chip, "invalid %s descriptor (id %d)\n", name, unitid);
 		return -EINVAL;


