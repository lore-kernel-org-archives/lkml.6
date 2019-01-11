Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D437EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A93206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217637;
	bh=+YelnWGAPbmPZloWvCN2VABepBB6/XLTzyo/JoCdxzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ERZ9/ptS833U6vhLiX/M5rXG2qAKTahCHBCQQ5tOf2Mv/gEnfaCpd/Sd6rQieF+Qt
	 h9AHasqShizId9AIVStxVqShcGUgyvuqMyPY+jSbrlaABHEA3N8OVFWUdQpiQZkB3Z
	 t4GyaCAQCBMPvRbxPpiWnpnFQHzwKOz9RQewOEIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388119AbfAKOkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:40:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:33174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391246AbfAKOke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:40:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 282092133F;
        Fri, 11 Jan 2019 14:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217633;
        bh=+YelnWGAPbmPZloWvCN2VABepBB6/XLTzyo/JoCdxzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vlbSh5LPr4r03Ueje0oPOEalKQO0zdPTaUxyKJzYV1pEFsgJ5JLxDIEuUxANZvYc5
         2lbyxB8iIIMMoY+5IivdgECOl06Kry7HS0HKhakvOlQ6zYXAwnLnM/zFjJE2oeDx+F
         NFWrdXJH3KimEYPHnUaPRgkHi/Pguk+d+8WhdUO4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 106/148] ALSA: usb-audio: Check mixer unit descriptors more strictly
Date:   Fri, 11 Jan 2019 15:14:44 +0100
Message-Id: <20190111131118.454970179@linuxfoundation.org>
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

commit 0bfe5e434e6665b3590575ec3c5e4f86a1ce51c9 upstream.

We've had some sanity checks of the mixer unit descriptors but they
are too loose and some corner cases are overlooked.  Add more strict
checks in uac_mixer_unit_get_channels() for avoiding possible OOB
accesses by malformed descriptors.

This also changes the semantics of uac_mixer_unit_get_channels()
slightly.  Now it returns zero for the cases where the descriptor
lacks of bmControls instead of -EINVAL.  Then the caller side skips
the mixer creation for such unit while it keeps parsing it.
This corresponds to the case like Maya44.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/mixer.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -753,8 +753,9 @@ static int uac_mixer_unit_get_channels(s
 				       struct uac_mixer_unit_descriptor *desc)
 {
 	int mu_channels;
+	void *c;
 
-	if (desc->bLength < 11)
+	if (desc->bLength < sizeof(*desc))
 		return -EINVAL;
 	if (!desc->bNrInPins)
 		return -EINVAL;
@@ -763,6 +764,8 @@ static int uac_mixer_unit_get_channels(s
 	case UAC_VERSION_1:
 	case UAC_VERSION_2:
 	default:
+		if (desc->bLength < sizeof(*desc) + desc->bNrInPins + 1)
+			return 0; /* no bmControls -> skip */
 		mu_channels = uac_mixer_unit_bNrChannels(desc);
 		break;
 	case UAC_VERSION_3:
@@ -772,7 +775,11 @@ static int uac_mixer_unit_get_channels(s
 	}
 
 	if (!mu_channels)
-		return -EINVAL;
+		return 0;
+
+	c = uac_mixer_unit_bmControls(desc, state->mixer->protocol);
+	if (c - (void *)desc + (mu_channels - 1) / 8 >= desc->bLength)
+		return 0; /* no bmControls -> skip */
 
 	return mu_channels;
 }
@@ -944,7 +951,7 @@ static int check_input_term(struct mixer
 				struct uac_mixer_unit_descriptor *d = p1;
 
 				err = uac_mixer_unit_get_channels(state, d);
-				if (err < 0)
+				if (err <= 0)
 					return err;
 
 				term->channels = err;
@@ -2118,7 +2125,7 @@ static int parse_audio_mixer_unit(struct
 		if (err < 0)
 			continue;
 		/* no bmControls field (e.g. Maya44) -> ignore */
-		if (desc->bLength <= 10 + input_pins)
+		if (!num_outs)
 			continue;
 		err = check_input_term(state, desc->baSourceID[pin], &iterm);
 		if (err < 0)


