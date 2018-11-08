Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12246ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC43D20818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXL0BNOx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC43D20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbeKIHha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:37:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:55702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730267AbeKIHh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:37:28 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F0742146D;
        Thu,  8 Nov 2018 21:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714399;
        bh=llQSn8jdR4TmSPBOwb/SuQOCuVXKhTnJuvC5o1s5hhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AXL0BNOxOqyGVixPBo1zjnSEro+yh04V73rYsHksdfjLa6JAnxfXq9kU+j/NSEm4N
         L8atd1+PF/IBhOojB1eVxq5wOEB6Q1UmWsTi6mZOzAJ9rUGnPtAMq2a5XrTD+yIKRX
         BCJafRsB2lL9zwr3UVpGC5CCiXwZHnmRunR55Nto=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 059/114] ALSA: timer: Fix zero-division by continue of uninitialized instance
Date:   Thu,  8 Nov 2018 13:51:14 -0800
Message-Id: <20181108215106.440129375@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 9f8a7658bcafb2a7853f7a2eae8a94e87e6e695b ]

When a user timer instance is continued without the explicit start
beforehand, the system gets eventually zero-division error like:

  divide error: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN
  CPU: 1 PID: 27320 Comm: syz-executor Not tainted 4.8.0-rc3-next-20160825+ #8
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
   task: ffff88003c9b2280 task.stack: ffff880027280000
   RIP: 0010:[<ffffffff858e1a6c>]  [<     inline     >] ktime_divns include/linux/ktime.h:195
   RIP: 0010:[<ffffffff858e1a6c>]  [<ffffffff858e1a6c>] snd_hrtimer_callback+0x1bc/0x3c0 sound/core/hrtimer.c:62
  Call Trace:
   <IRQ>
   [<     inline     >] __run_hrtimer kernel/time/hrtimer.c:1238
   [<ffffffff81504335>] __hrtimer_run_queues+0x325/0xe70 kernel/time/hrtimer.c:1302
   [<ffffffff81506ceb>] hrtimer_interrupt+0x18b/0x420 kernel/time/hrtimer.c:1336
   [<ffffffff8126d8df>] local_apic_timer_interrupt+0x6f/0xe0 arch/x86/kernel/apic/apic.c:933
   [<ffffffff86e13056>] smp_apic_timer_interrupt+0x76/0xa0 arch/x86/kernel/apic/apic.c:957
   [<ffffffff86e1210c>] apic_timer_interrupt+0x8c/0xa0 arch/x86/entry/entry_64.S:487
   <EOI>
   .....

Although a similar issue was spotted and a fix patch was merged in
commit [6b760bb2c63a: ALSA: timer: fix division by zero after
SNDRV_TIMER_IOCTL_CONTINUE], it seems covering only a part of
iceberg.

In this patch, we fix the issue a bit more drastically.  Basically the
continue of an uninitialized timer is supposed to be a fresh start, so
we do it for user timers.  For the direct snd_timer_continue() call,
there is no way to pass the initial tick value, so we kick out for the
uninitialized case.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/timer.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index ef850a99d64a..f989adb98a22 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -35,6 +35,9 @@
 #include <sound/initval.h>
 #include <linux/kmod.h>
 
+/* internal flags */
+#define SNDRV_TIMER_IFLG_PAUSED		0x00010000
+
 #if IS_ENABLED(CONFIG_SND_HRTIMER)
 #define DEFAULT_TIMER_LIMIT 4
 #elif IS_ENABLED(CONFIG_SND_RTCTIMER)
@@ -547,6 +550,10 @@ static int snd_timer_stop1(struct snd_timer_instance *timeri, bool stop)
 		}
 	}
 	timeri->flags &= ~(SNDRV_TIMER_IFLG_RUNNING | SNDRV_TIMER_IFLG_START);
+	if (stop)
+		timeri->flags &= ~SNDRV_TIMER_IFLG_PAUSED;
+	else
+		timeri->flags |= SNDRV_TIMER_IFLG_PAUSED;
 	snd_timer_notify1(timeri, stop ? SNDRV_TIMER_EVENT_STOP :
 			  SNDRV_TIMER_EVENT_PAUSE);
  unlock:
@@ -608,6 +615,10 @@ int snd_timer_stop(struct snd_timer_instance *timeri)
  */
 int snd_timer_continue(struct snd_timer_instance *timeri)
 {
+	/* timer can continue only after pause */
+	if (!(timeri->flags & SNDRV_TIMER_IFLG_PAUSED))
+		return -EINVAL;
+
 	if (timeri->flags & SNDRV_TIMER_IFLG_SLAVE)
 		return snd_timer_start_slave(timeri, false);
 	else
@@ -1837,6 +1848,9 @@ static int snd_timer_user_continue(struct file *file)
 	tu = file->private_data;
 	if (!tu->timeri)
 		return -EBADFD;
+	/* start timer instead of continue if it's not used before */
+	if (!(tu->timeri->flags & SNDRV_TIMER_IFLG_PAUSED))
+		return snd_timer_user_start(file);
 	tu->timeri->lost = 0;
 	return (err = snd_timer_continue(tu->timeri)) < 0 ? err : 0;
 }
-- 
2.17.1



