Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76059C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4676820661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4676820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbeLIWNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:13:55 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37984 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728183AbeLIWNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:13:54 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73L-0002ir-76; Sun, 09 Dec 2018 21:55:55 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72a-0003IO-Ud; Sun, 09 Dec 2018 21:55:08 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>,
        syzbot+619d9f40141d826b097e@syzkaller.appspotmail.com
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.693739044@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 078/328] ALSA: virmidi: Fix too long output trigger loop
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/seq/seq_virmidi.c | 10 ++++++++++
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

