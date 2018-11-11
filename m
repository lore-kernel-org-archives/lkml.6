Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7485C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01A82148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A01A82148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbeKLGEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:04:16 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52898 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726816AbeKLGEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:04:16 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsy-0000oO-72; Sun, 11 Nov 2018 19:59:08 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsU-0001d9-5K; Sun, 11 Nov 2018 19:58:38 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.695293795@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 193/366] ALSA: timer: Fix UBSAN warning at
 SNDRV_TIMER_IOCTL_NEXT_DEVICE ioctl
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit b41f794f284966fd6ec634111e3b40d241389f96 upstream.

The kernel may spew a WARNING about UBSAN undefined behavior at
handling ALSA timer ioctl SNDRV_TIMER_IOCTL_NEXT_DEVICE:

UBSAN: Undefined behaviour in sound/core/timer.c:1524:19
signed integer overflow:
2147483647 + 1 cannot be represented in type 'int'
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x122/0x1c8 lib/dump_stack.c:113
 ubsan_epilogue+0x12/0x86 lib/ubsan.c:159
 handle_overflow+0x1c2/0x21f lib/ubsan.c:190
 __ubsan_handle_add_overflow+0x2a/0x31 lib/ubsan.c:198
 snd_timer_user_next_device sound/core/timer.c:1524 [inline]
 __snd_timer_user_ioctl+0x204d/0x2520 sound/core/timer.c:1939
 snd_timer_user_ioctl+0x67/0x95 sound/core/timer.c:1994
 ....

It happens only when a value with INT_MAX is passed, as we're
incrementing it unconditionally.  So the fix is trivial, check the
value with INT_MAX.  Although the bug itself is fairly harmless, it's
better to fix it so that fuzzers won't hit this again later.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=200213
Reported-and-tested-by: Team OWL337 <icytxw@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[bwh: Backported to 3.16: adjust context, indentation]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1476,7 +1476,7 @@ static int snd_timer_user_next_device(st
 					} else {
 						if (id.subdevice < 0) {
 							id.subdevice = 0;
-						} else {
+						} else if (id.subdevice < INT_MAX) {
 							id.subdevice++;
 						}
 					}

