Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D2AC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE102174D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE102174D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbeHUJpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:45:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56360 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbeHUJp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:45:29 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2EC54516;
        Tue, 21 Aug 2018 06:26:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+619d9f40141d826b097e@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 13/29] ALSA: virmidi: Fix too long output trigger loop
Date:   Tue, 21 Aug 2018 08:21:06 +0200
Message-Id: <20180821055108.937138396@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055108.333930282@linuxfoundation.org>
References: <20180821055108.333930282@linuxfoundation.org>
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

From: Takashi Iwai <tiwai@suse.de>

commit 50e9ffb1996a5d11ff5040a266585bad4ceeca0a upstream.

The virmidi output trigger tries to parse the all available bytes and
process sequencer events as much as possible.  In a normal situation,
this is supposed to be relatively short, but a program may give a huge
buffer and it'll take a long time in a single spin lock, which may
eventually lead to a soft lockup.

This patch simply adds a workaround, a cond_resched() call in the loop
if applicable.  A better solution would be to move the event processor
into a work, but let's put a duct-tape quickly at first.

Reported-and-tested-by: Dae R. Jeong <threeearcat@gmail.com>
Reported-by: syzbot+619d9f40141d826b097e@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/seq/seq_virmidi.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/sound/core/seq/seq_virmidi.c
+++ b/sound/core/seq/seq_virmidi.c
@@ -163,6 +163,7 @@ static void snd_virmidi_output_trigger(s
 	int count, res;
 	unsigned char buf[32], *pbuf;
 	unsigned long flags;
+	bool check_resched = !in_atomic();
 
 	if (up) {
 		vmidi->trigger = 1;
@@ -200,6 +201,15 @@ static void snd_virmidi_output_trigger(s
 					vmidi->event.type = SNDRV_SEQ_EVENT_NONE;
 				}
 			}
+			if (!check_resched)
+				continue;
+			/* do temporary unlock & cond_resched() for avoiding
+			 * CPU soft lockup, which may happen via a write from
+			 * a huge rawmidi buffer
+			 */
+			spin_unlock_irqrestore(&substream->runtime->lock, flags);
+			cond_resched();
+			spin_lock_irqsave(&substream->runtime->lock, flags);
 		}
 	out:
 		spin_unlock_irqrestore(&substream->runtime->lock, flags);


