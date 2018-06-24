Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863C2C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 10:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC7B24E95
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 10:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC7B24E95
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeFXKdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 06:33:22 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44808 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751596AbeFXKdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 06:33:21 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fX2Kd-0003Xo-AY; Sun, 24 Jun 2018 12:33:19 +0200
Date:   Sun, 24 Jun 2018 12:33:18 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] timer updates for 4.18
Message-ID: <alpine.DEB.2.21.1806241222450.8650@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

A small set of fixes for time(r) related issues:

  - Fix a long standing conversion issue in jiffies_to_msecs() for odd HZ
    values like 1024 or 1200 which resulted in returning 0 for small
    jiffies values due to rounding down.

  - Use the proper CONFIG symbol in the new Y2038 safe compat code for
    posix-timers. Not yet a visible breakage, but this will immediately
    trigger when the architecture support for the new interfaces is merged.

  - Return an error code in the STM32 clocksource driver on failure instead
    of success.

  - Remove the redundant and stale irq disabled check in the posix cpu
    timer code. The check is at the wrong place anyway and lockdep already
    covers it via the sighand lock locking coverage.

Thanks,

	tglx

------------------>
Arnd Bergmann (1):
      posix-timers: Fix nanosleep_copyout() for CONFIG_COMPAT_32BIT_TIME

Geert Uytterhoeven (1):
      time: Make sure jiffies_to_msecs() preserves non-zero time periods

Julia Lawall (1):
      clocksource/drivers/stm32: Fix error return code

Sebastian Andrzej Siewior (1):
      posix-cpu-timers: Remove lockdep_assert_irqs_disabled()


 drivers/clocksource/timer-stm32.c | 4 +++-
 kernel/time/hrtimer.c             | 2 +-
 kernel/time/posix-cpu-timers.c    | 2 --
 kernel/time/time.c                | 6 ++++--
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
index e5cdc3af684c..2717f88c7904 100644
--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -304,8 +304,10 @@ static int __init stm32_timer_init(struct device_node *node)
 
 	to->private_data = kzalloc(sizeof(struct stm32_timer_private),
 				   GFP_KERNEL);
-	if (!to->private_data)
+	if (!to->private_data) {
+		ret = -ENOMEM;
 		goto deinit;
+	}
 
 	rstc = of_reset_control_get(node, NULL);
 	if (!IS_ERR(rstc)) {
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 055a4a728c00..3e93c54bd3a1 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1659,7 +1659,7 @@ EXPORT_SYMBOL_GPL(hrtimer_init_sleeper);
 int nanosleep_copyout(struct restart_block *restart, struct timespec64 *ts)
 {
 	switch(restart->nanosleep.type) {
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_32BIT_TIME
 	case TT_COMPAT:
 		if (compat_put_timespec64(ts, restart->nanosleep.compat_rmtp))
 			return -EFAULT;
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 5a6251ac6f7a..9cdf54b04ca8 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -604,7 +604,6 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	/*
 	 * Disarm any old timer after extracting its expiry time.
 	 */
-	lockdep_assert_irqs_disabled();
 
 	ret = 0;
 	old_incr = timer->it.cpu.incr;
@@ -1049,7 +1048,6 @@ static void posix_cpu_timer_rearm(struct k_itimer *timer)
 	/*
 	 * Now re-arm for the new expiry time.
 	 */
-	lockdep_assert_irqs_disabled();
 	arm_timer(timer);
 unlock:
 	unlock_task_sighand(p, &flags);
diff --git a/kernel/time/time.c b/kernel/time/time.c
index 6fa99213fc72..2b41e8e2d31d 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -28,6 +28,7 @@
  */
 
 #include <linux/export.h>
+#include <linux/kernel.h>
 #include <linux/timex.h>
 #include <linux/capability.h>
 #include <linux/timekeeper_internal.h>
@@ -314,9 +315,10 @@ unsigned int jiffies_to_msecs(const unsigned long j)
 	return (j + (HZ / MSEC_PER_SEC) - 1)/(HZ / MSEC_PER_SEC);
 #else
 # if BITS_PER_LONG == 32
-	return (HZ_TO_MSEC_MUL32 * j) >> HZ_TO_MSEC_SHR32;
+	return (HZ_TO_MSEC_MUL32 * j + (1ULL << HZ_TO_MSEC_SHR32) - 1) >>
+	       HZ_TO_MSEC_SHR32;
 # else
-	return (j * HZ_TO_MSEC_NUM) / HZ_TO_MSEC_DEN;
+	return DIV_ROUND_UP(j * HZ_TO_MSEC_NUM, HZ_TO_MSEC_DEN);
 # endif
 #endif
 }
