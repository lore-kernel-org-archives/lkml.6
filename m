Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD0AC282C9
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 11:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B98B21473
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 11:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfA0LKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 06:10:49 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:40088 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfA0LKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 06:10:48 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gniKs-00024G-TE; Sun, 27 Jan 2019 12:10:47 +0100
Subject: [GIT pull] timer updates for 5.0
Message-ID: <154858736708.17771.8837069746437903427.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
References: <154858736708.17771.12039221093557296917.tglx@nanos.tec.linutronix.de>
Date:   Sun, 27 Jan 2019 12:10:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

A single regression fix to address the unintended breakage of posix cpu
timers. This is caused by a new sanity check in the common code, which
fails for posix cpu timers under certain conditions because the posix cpu
timer code never updates the variable which is checked.

Thanks,

	tglx

------------------>
Thomas Gleixner (1):
      posix-cpu-timers: Unbreak timer rearming


 kernel/time/posix-cpu-timers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 8f0644af40be..80f955210861 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -685,6 +685,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	 * set up the signal and overrun bookkeeping.
 	 */
 	timer->it.cpu.incr = timespec64_to_ns(&new->it_interval);
+	timer->it_interval = ns_to_ktime(timer->it.cpu.incr);
 
 	/*
 	 * This acts as a modification timestamp for the timer,

