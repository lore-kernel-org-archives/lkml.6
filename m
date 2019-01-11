Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5F9C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D716520874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732701AbfAKNgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:36:25 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:33878 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfAKNgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 08:36:24 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ghwz0-0000nP-Py; Fri, 11 Jan 2019 14:36:22 +0100
Message-Id: <20190111133500.840117406@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 11 Jan 2019 14:33:16 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H.J. Lu" <hjl.tools@gmail.com>
Subject: [patch 1/2] posix-cpu-timers: Unbreak timer rearming
References: <20190111133315.657348322@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent commit which prevented a division by 0 issue in the alarm timer
code broke posix CPU timers as an unwanted side effect.

The reason is that the common rearm code checks for timer->it_interval
being 0 now. What went unnoticed is that the posix cpu timer setup does not
initialize timer->it_interval as it stores the interval in CPU timer
specific storage. The reason for the separate storage is historical as the
posix CPU timers always had a 64bit nanoseconds representation internally
while timer->it_interval is type ktime_t which used to be a modified
timespec representation on 32bit machines.

Instead of reverting the offending commit and fixing the alarmtimer issue
in the alarmtimer code, store the interval in timer->it_interval at CPU
timer setup time so the common code check works. This also repairs the
existing inconistency of the posix CPU timer code which kept a single shot
timer armed despite of the interval being 0.

The separate storage can be removed in mainline, but that needs to be a
separate commit as the current one has to be backported to stable kernels.

Fixes: 0e334db6bb4b ("posix-timers: Fix division by zero bug")
Reported-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: John Stultz <john.stultz@linaro.org>
---
 kernel/time/posix-cpu-timers.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -685,6 +685,7 @@ static int posix_cpu_timer_set(struct k_
 	 * set up the signal and overrun bookkeeping.
 	 */
 	timer->it.cpu.incr = timespec64_to_ns(&new->it_interval);
+	timer->it_interval = ns_to_ktime(timer->it.cpu.incr);
 
 	/*
 	 * This acts as a modification timestamp for the timer,


