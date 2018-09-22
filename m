Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760B6ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308FF2157C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308FF2157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392062AbeIVGKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:10:49 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44232 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392003AbeIVGKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:48 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdy-0008BN-1k; Sat, 22 Sep 2018 01:19:30 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdo-0000t3-II; Sat, 22 Sep 2018 01:19:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        syzbot+52f83f0ea8df16932f7f@syzkaller.appspotmail.com,
        "Takashi Iwai" <tiwai@suse.de>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.196996512@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 42/63] ALSA: rawmidi: Change resized buffers atomically
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 39675f7a7c7e7702f7d5341f1e0d01db746543a0 upstream.

The SNDRV_RAWMIDI_IOCTL_PARAMS ioctl may resize the buffers and the
current code is racy.  For example, the sequencer client may write to
buffer while it being resized.

As a simple workaround, let's switch to the resized buffer inside the
stream runtime lock.

Reported-by: syzbot+52f83f0ea8df16932f7f@syzkaller.appspotmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/rawmidi.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -645,7 +645,7 @@ static int snd_rawmidi_info_select_user(
 int snd_rawmidi_output_params(struct snd_rawmidi_substream *substream,
 			      struct snd_rawmidi_params * params)
 {
-	char *newbuf;
+	char *newbuf, *oldbuf;
 	struct snd_rawmidi_runtime *runtime = substream->runtime;
 	
 	if (substream->append && substream->use_count > 1)
@@ -658,13 +658,17 @@ int snd_rawmidi_output_params(struct snd
 		return -EINVAL;
 	}
 	if (params->buffer_size != runtime->buffer_size) {
-		newbuf = krealloc(runtime->buffer, params->buffer_size,
-				  GFP_KERNEL);
+		newbuf = kmalloc(params->buffer_size, GFP_KERNEL);
 		if (!newbuf)
 			return -ENOMEM;
+		spin_lock_irq(&runtime->lock);
+		oldbuf = runtime->buffer;
 		runtime->buffer = newbuf;
 		runtime->buffer_size = params->buffer_size;
 		runtime->avail = runtime->buffer_size;
+		runtime->appl_ptr = runtime->hw_ptr = 0;
+		spin_unlock_irq(&runtime->lock);
+		kfree(oldbuf);
 	}
 	runtime->avail_min = params->avail_min;
 	substream->active_sensing = !params->no_active_sensing;
@@ -675,7 +679,7 @@ EXPORT_SYMBOL(snd_rawmidi_output_params)
 int snd_rawmidi_input_params(struct snd_rawmidi_substream *substream,
 			     struct snd_rawmidi_params * params)
 {
-	char *newbuf;
+	char *newbuf, *oldbuf;
 	struct snd_rawmidi_runtime *runtime = substream->runtime;
 
 	snd_rawmidi_drain_input(substream);
@@ -686,12 +690,16 @@ int snd_rawmidi_input_params(struct snd_
 		return -EINVAL;
 	}
 	if (params->buffer_size != runtime->buffer_size) {
-		newbuf = krealloc(runtime->buffer, params->buffer_size,
-				  GFP_KERNEL);
+		newbuf = kmalloc(params->buffer_size, GFP_KERNEL);
 		if (!newbuf)
 			return -ENOMEM;
+		spin_lock_irq(&runtime->lock);
+		oldbuf = runtime->buffer;
 		runtime->buffer = newbuf;
 		runtime->buffer_size = params->buffer_size;
+		runtime->appl_ptr = runtime->hw_ptr = 0;
+		spin_unlock_irq(&runtime->lock);
+		kfree(oldbuf);
 	}
 	runtime->avail_min = params->avail_min;
 	return 0;

