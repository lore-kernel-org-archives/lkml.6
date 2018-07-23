Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633F9ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28AEF20880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28AEF20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388907AbeGWNo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:44:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48196 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387937AbeGWNo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:44:28 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0AE75C83;
        Mon, 23 Jul 2018 12:43:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+52f83f0ea8df16932f7f@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 004/107] ALSA: rawmidi: Change resized buffers atomically
Date:   Mon, 23 Jul 2018 14:40:58 +0200
Message-Id: <20180723122413.163448388@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122413.003644357@linuxfoundation.org>
References: <20180723122413.003644357@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 39675f7a7c7e7702f7d5341f1e0d01db746543a0 upstream.

The SNDRV_RAWMIDI_IOCTL_PARAMS ioctl may resize the buffers and the
current code is racy.  For example, the sequencer client may write to
buffer while it being resized.

As a simple workaround, let's switch to the resized buffer inside the
stream runtime lock.

Reported-by: syzbot+52f83f0ea8df16932f7f@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/rawmidi.c |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -635,7 +635,7 @@ static int snd_rawmidi_info_select_user(
 int snd_rawmidi_output_params(struct snd_rawmidi_substream *substream,
 			      struct snd_rawmidi_params * params)
 {
-	char *newbuf;
+	char *newbuf, *oldbuf;
 	struct snd_rawmidi_runtime *runtime = substream->runtime;
 	
 	if (substream->append && substream->use_count > 1)
@@ -648,13 +648,17 @@ int snd_rawmidi_output_params(struct snd
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
@@ -665,7 +669,7 @@ EXPORT_SYMBOL(snd_rawmidi_output_params)
 int snd_rawmidi_input_params(struct snd_rawmidi_substream *substream,
 			     struct snd_rawmidi_params * params)
 {
-	char *newbuf;
+	char *newbuf, *oldbuf;
 	struct snd_rawmidi_runtime *runtime = substream->runtime;
 
 	snd_rawmidi_drain_input(substream);
@@ -676,12 +680,16 @@ int snd_rawmidi_input_params(struct snd_
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


