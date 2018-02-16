Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750940AbeBPXfD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 18:35:03 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:35669 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbeBPXe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 18:34:59 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Matt Turner <mattst88@gmail.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] alpha: rtc: remove unused set_mmss ops
Date: Sat, 17 Feb 2018 00:34:46 +0100
Message-Id: <20180216233446.26818-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .set_mmss and .setmmss64 ops are only called when the RTC is not
providing an implementation for the .set_time callback.

On alpha, .set_time is provided so .set_mmss64 is never called. Remove the
unused code.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/alpha/kernel/rtc.c | 99 -------------------------------------------------
 1 file changed, 99 deletions(-)

diff --git a/arch/alpha/kernel/rtc.c b/arch/alpha/kernel/rtc.c
index b3da0dcda47d..0816e6c747e8 100644
--- a/arch/alpha/kernel/rtc.c
+++ b/arch/alpha/kernel/rtc.c
@@ -114,83 +114,6 @@ alpha_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	return mc146818_set_time(tm);
 }
 
-static int
-alpha_rtc_set_mmss(struct device *dev, time64_t nowtime)
-{
-	int retval = 0;
-	int real_seconds, real_minutes, cmos_minutes;
-	unsigned char save_control, save_freq_select;
-
-	/* Note: This code only updates minutes and seconds.  Comments
-	   indicate this was to avoid messing with unknown time zones,
-	   and with the epoch nonsense described above.  In order for
-	   this to work, the existing clock cannot be off by more than
-	   15 minutes.
-
-	   ??? This choice is may be out of date.  The x86 port does
-	   not have problems with timezones, and the epoch processing has
-	   now been fixed in alpha_set_rtc_time.
-
-	   In either case, one can always force a full rtc update with
-	   the userland hwclock program, so surely 15 minute accuracy
-	   is no real burden.  */
-
-	/* In order to set the CMOS clock precisely, we have to be called
-	   500 ms after the second nowtime has started, because when
-	   nowtime is written into the registers of the CMOS clock, it will
-	   jump to the next second precisely 500 ms later. Check the Motorola
-	   MC146818A or Dallas DS12887 data sheet for details.  */
-
-	/* irq are locally disabled here */
-	spin_lock(&rtc_lock);
-	/* Tell the clock it's being set */
-	save_control = CMOS_READ(RTC_CONTROL);
-	CMOS_WRITE((save_control|RTC_SET), RTC_CONTROL);
-
-	/* Stop and reset prescaler */
-	save_freq_select = CMOS_READ(RTC_FREQ_SELECT);
-	CMOS_WRITE((save_freq_select|RTC_DIV_RESET2), RTC_FREQ_SELECT);
-
-	cmos_minutes = CMOS_READ(RTC_MINUTES);
-	if (!(save_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
-		cmos_minutes = bcd2bin(cmos_minutes);
-
-	real_seconds = nowtime % 60;
-	real_minutes = nowtime / 60;
-	if (((abs(real_minutes - cmos_minutes) + 15) / 30) & 1) {
-		/* correct for half hour time zone */
-		real_minutes += 30;
-	}
-	real_minutes %= 60;
-
-	if (abs(real_minutes - cmos_minutes) < 30) {
-		if (!(save_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
-			real_seconds = bin2bcd(real_seconds);
-			real_minutes = bin2bcd(real_minutes);
-		}
-		CMOS_WRITE(real_seconds,RTC_SECONDS);
-		CMOS_WRITE(real_minutes,RTC_MINUTES);
-	} else {
-		printk_once(KERN_NOTICE
-			    "set_rtc_mmss: can't update from %d to %d\n",
-			    cmos_minutes, real_minutes);
-		retval = -1;
-	}
-
-	/* The following flags have to be released exactly in this order,
-	 * otherwise the DS12887 (popular MC146818A clone with integrated
-	 * battery and quartz) will not reset the oscillator and will not
-	 * update precisely 500 ms later. You won't find this mentioned in
-	 * the Dallas Semiconductor data sheets, but who believes data
-	 * sheets anyway ...                           -- Markus Kuhn
-	 */
-	CMOS_WRITE(save_control, RTC_CONTROL);
-	CMOS_WRITE(save_freq_select, RTC_FREQ_SELECT);
-	spin_unlock(&rtc_lock);
-
-	return retval;
-}
-
 static int
 alpha_rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 {
@@ -210,7 +133,6 @@ alpha_rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 static const struct rtc_class_ops alpha_rtc_ops = {
 	.read_time = alpha_rtc_read_time,
 	.set_time = alpha_rtc_set_time,
-	.set_mmss64 = alpha_rtc_set_mmss,
 	.ioctl = alpha_rtc_ioctl,
 };
 
@@ -225,7 +147,6 @@ static const struct rtc_class_ops alpha_rtc_ops = {
 
 union remote_data {
 	struct rtc_time *tm;
-	unsigned long now;
 	long retval;
 };
 
@@ -267,29 +188,9 @@ remote_set_time(struct device *dev, struct rtc_time *tm)
 	return alpha_rtc_set_time(NULL, tm);
 }
 
-static void
-do_remote_mmss(void *data)
-{
-	union remote_data *x = data;
-	x->retval = alpha_rtc_set_mmss(NULL, x->now);
-}
-
-static int
-remote_set_mmss(struct device *dev, time64_t now)
-{
-	union remote_data x;
-	if (smp_processor_id() != boot_cpuid) {
-		x.now = now;
-		smp_call_function_single(boot_cpuid, do_remote_mmss, &x, 1);
-		return x.retval;
-	}
-	return alpha_rtc_set_mmss(NULL, now);
-}
-
 static const struct rtc_class_ops remote_rtc_ops = {
 	.read_time = remote_read_time,
 	.set_time = remote_set_time,
-	.set_mmss64 = remote_set_mmss,
 	.ioctl = alpha_rtc_ioctl,
 };
 #endif
-- 
2.16.1
