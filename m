Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C26C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1650B256DB
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1650B256DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934251AbeGARic (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:38:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35898 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031186AbeGAQf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:35:57 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E86AAACC;
        Sun,  1 Jul 2018 16:35:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 147/157] ALSA: timer: Fix UBSAN warning at SNDRV_TIMER_IOCTL_NEXT_DEVICE ioctl
Date:   Sun,  1 Jul 2018 18:23:39 +0200
Message-Id: <20180701160900.522711854@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
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
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/timer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1514,7 +1514,7 @@ static int snd_timer_user_next_device(st
 				} else {
 					if (id.subdevice < 0)
 						id.subdevice = 0;
-					else
+					else if (id.subdevice < INT_MAX)
 						id.subdevice++;
 				}
 			}


