Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B56C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE47208A2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE47208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388641AbeG0LtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:49:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42340 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730340AbeG0LtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:49:01 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 68D13CD1;
        Fri, 27 Jul 2018 10:27:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+52f83f0ea8df16932f7f@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3.18 03/27] ALSA: rawmidi: Change resized buffers atomically
Date:   Fri, 27 Jul 2018 12:26:40 +0200
Message-Id: <20180727102649.168841256@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727102649.049641021@linuxfoundation.org>
References: <20180727102649.049641021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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


