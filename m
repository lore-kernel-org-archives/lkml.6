Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCDCC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E77F20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E77F20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbeJNXbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:31:17 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37392 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728546AbeJNXbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:31:16 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiM0-0004cm-JY; Sun, 14 Oct 2018 16:30:52 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLT-0000Nd-Qp; Sun, 14 Oct 2018 16:30:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        syzbot+f7a0348affc3b67bc617@syzkaller.appspotmail.com,
        "Takashi Iwai" <tiwai@suse.de>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.955954421@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 177/366] ALSA: rawmidi: Fix missing input substream
 checks in compat ioctls
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

commit 8a56ef4f3ffba9ebf4967b61ef600b0a7ba10f11 upstream.

Some rawmidi compat ioctls lack of the input substream checks
(although they do check only for rfile->output).  This many eventually
lead to an Oops as NULL substream is passed to the rawmidi core
functions.

Fix it by adding the proper checks before each function call.

The bug was spotted by syzkaller.

Reported-by: syzbot+f7a0348affc3b67bc617@syzkaller.appspotmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/rawmidi_compat.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

--- a/sound/core/rawmidi_compat.c
+++ b/sound/core/rawmidi_compat.c
@@ -36,8 +36,6 @@ static int snd_rawmidi_ioctl_params_comp
 	struct snd_rawmidi_params params;
 	unsigned int val;
 
-	if (rfile->output == NULL)
-		return -EINVAL;
 	if (get_user(params.stream, &src->stream) ||
 	    get_user(params.buffer_size, &src->buffer_size) ||
 	    get_user(params.avail_min, &src->avail_min) ||
@@ -46,8 +44,12 @@ static int snd_rawmidi_ioctl_params_comp
 	params.no_active_sensing = val;
 	switch (params.stream) {
 	case SNDRV_RAWMIDI_STREAM_OUTPUT:
+		if (!rfile->output)
+			return -EINVAL;
 		return snd_rawmidi_output_params(rfile->output, &params);
 	case SNDRV_RAWMIDI_STREAM_INPUT:
+		if (!rfile->input)
+			return -EINVAL;
 		return snd_rawmidi_input_params(rfile->input, &params);
 	}
 	return -EINVAL;
@@ -67,16 +69,18 @@ static int snd_rawmidi_ioctl_status_comp
 	int err;
 	struct snd_rawmidi_status status;
 
-	if (rfile->output == NULL)
-		return -EINVAL;
 	if (get_user(status.stream, &src->stream))
 		return -EFAULT;
 
 	switch (status.stream) {
 	case SNDRV_RAWMIDI_STREAM_OUTPUT:
+		if (!rfile->output)
+			return -EINVAL;
 		err = snd_rawmidi_output_status(rfile->output, &status);
 		break;
 	case SNDRV_RAWMIDI_STREAM_INPUT:
+		if (!rfile->input)
+			return -EINVAL;
 		err = snd_rawmidi_input_status(rfile->input, &status);
 		break;
 	default:
@@ -113,16 +117,18 @@ static int snd_rawmidi_ioctl_status_x32(
 	int err;
 	struct snd_rawmidi_status status;
 
-	if (rfile->output == NULL)
-		return -EINVAL;
 	if (get_user(status.stream, &src->stream))
 		return -EFAULT;
 
 	switch (status.stream) {
 	case SNDRV_RAWMIDI_STREAM_OUTPUT:
+		if (!rfile->output)
+			return -EINVAL;
 		err = snd_rawmidi_output_status(rfile->output, &status);
 		break;
 	case SNDRV_RAWMIDI_STREAM_INPUT:
+		if (!rfile->input)
+			return -EINVAL;
 		err = snd_rawmidi_input_status(rfile->input, &status);
 		break;
 	default:

