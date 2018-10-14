Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4768C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D9B2077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D9B2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeJNXpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:45:07 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35726 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727040AbeJNXLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:45 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLY-0004cd-NH; Sun, 14 Oct 2018 16:30:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLW-0000Tw-7c; Sun, 14 Oct 2018 16:30:22 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "DaeRyong Jeong" <threeearcat@gmail.com>,
        "Takashi Iwai" <tiwai@suse.de>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.24020427@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 237/366] ALSA: seq: Fix races at MIDI encoding in
 snd_virmidi_output_trigger()
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

commit 8f22e52528cc372b218b5f100457469615c733ce upstream.

The sequencer virmidi code has an open race at its output trigger
callback: namely, virmidi keeps only one event packet for processing
while it doesn't protect for concurrent output trigger calls.

snd_virmidi_output_trigger() tries to process the previously
unfinished event before starting encoding the given MIDI stream, but
this is done without any lock.  Meanwhile, if another rawmidi stream
starts the output trigger, this proceeds further, and overwrites the
event package that is being processed in another thread.  This
eventually corrupts and may lead to the invalid memory access if the
event type is like SYSEX.

The fix is just to move the spinlock to cover both the pending event
and the new stream.

The bug was spotted by a new fuzzer, RaceFuzzer.

BugLink: http://lkml.kernel.org/r/20180426045223.GA15307@dragonet.kaist.ac.kr
Reported-by: DaeRyong Jeong <threeearcat@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/seq/seq_virmidi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/core/seq/seq_virmidi.c
+++ b/sound/core/seq/seq_virmidi.c
@@ -174,12 +174,12 @@ static void snd_virmidi_output_trigger(s
 			}
 			return;
 		}
+		spin_lock_irqsave(&substream->runtime->lock, flags);
 		if (vmidi->event.type != SNDRV_SEQ_EVENT_NONE) {
 			if (snd_seq_kernel_client_dispatch(vmidi->client, &vmidi->event, in_atomic(), 0) < 0)
-				return;
+				goto out;
 			vmidi->event.type = SNDRV_SEQ_EVENT_NONE;
 		}
-		spin_lock_irqsave(&substream->runtime->lock, flags);
 		while (1) {
 			count = __snd_rawmidi_transmit_peek(substream, buf, sizeof(buf));
 			if (count <= 0)

