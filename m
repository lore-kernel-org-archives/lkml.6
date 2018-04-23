Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754508AbeDWIOw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:14:52 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:59391 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754131AbeDWIOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:14:46 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
        Geoff Levand <geoff@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] powerpc: remove unused to_tm() helper
Date: Mon, 23 Apr 2018 10:10:29 +0200
Message-Id: <20180423081114.1813726-5-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180423081114.1813726-1-arnd@arndb.de>
References: <20180423081114.1813726-1-arnd@arndb.de>
X-Provags-ID: V03:K1:ZTkperZmeZEQDDES1bMgdyE3YY2YxPIZl+DADVz4C+S3HI+7NOO
 HHVz6xV0yiB+d7AQcvoapf6GFelzkCdLJgaJkjnMhjlJOLpAXQAlas1KtIBxUXu84JE0Nqr
 mNDj+bjg7cROGqHiNT8aGbNlNWU9MwtoWh7vGiIjF9EvrtSDg2lMb9DNMGXhL5yL0qfK7wu
 7EuBYh4vmKfTInlcNmR8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1mrS97M2bk8=:EX7plqzzHNDcAUbQCebLUN
 F7ZHr+WqKhxVtmX2mUv6KdnIwQAejN/AI9/VRr9LZMZYdQ/KBu/3k7+CsiqMYaoHTMEdfc430
 Jfkb89j+4CeK2b+rcxRUYSnzQAMgUvB67kYAvEnb4OLanf2t+coW/EULwobKV/PDvPhFYAxl9
 cPEAtEpnJQ51j+a9ApGa9hCkk102W9JCJCHIcP9eXPqCUTRXjrd/moLGHNnFuuwhakE3zJRhc
 T1kvG2Bim7AqbZDEN6fDpK9RoUb35TInwnJiP5SueVDAvqeFgH972W3VknXfqw96u1xvUNTi1
 tt8rct+5+SH2ZI9SWM6oFh/HcxxB4yx3KjScNkeQrUfosp1Fcfruj4Uu4MshzN+p9Y7QdTTst
 VzZ8N6k7ouQ2c8KaUe4QxnZ+TLVvdBO+nBAjA+TWo8D0t2d9E5OVqaKsggVACC214QKD4Jwn8
 Te4MRmox6HJlllAf8Zt92bGSXWstqHAkCWQu3r3nr1hFm4qpnLwD5izl2Y8GvXshnYrsoTviP
 9OrVI7govrkdLLdrQAiC6EYzT6nh38O9VCRbibLig0GX3oQIQTyKW1UeZVB3MUpDO3dNk1nNI
 /oUyLLICsTdfQ/YmvzL64MSpHgzhT7juTQZb/pplK9GZ3qH8MTRFFNRFABWCTKrJZl1/UvMvT
 Cv75W2m2l+5QZegDBjpfNHlqgmlc0xUd5+z1d4EDX0bI4mtfRo7xnZlyaU48ipor6Km7p/MtF
 8Il5HNw1N2TT4JjWfPgF4YBuvZidH4QNWPNeMA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

to_tm() is now completely unused, the only reference being in the
_dump_time() helper that is also unused. This removes both, leaving
the rest of the powerpc RTC code y2038 safe to as far as the hardware
supports.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/include/asm/time.h   |  2 --
 arch/powerpc/kernel/time.c        | 50 ---------------------------------------
 arch/powerpc/platforms/ps3/time.c | 24 -------------------
 3 files changed, 76 deletions(-)

diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index db546c034905..79bc9c3e4325 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -26,8 +26,6 @@ extern unsigned long tb_ticks_per_usec;
 extern unsigned long tb_ticks_per_sec;
 extern struct clock_event_device decrementer_clockevent;
 
-struct rtc_time;
-extern void to_tm(int tim, struct rtc_time * tm);
 extern void tick_broadcast_ipi_handler(void);
 
 extern void generic_calibrate_decr(void);
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index f9b0baa3fa2b..79bdeea85ab4 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -1138,56 +1138,6 @@ void __init time_init(void)
 #endif
 }
 
-
-#define FEBRUARY	2
-#define	STARTOFTIME	1970
-#define SECDAY		86400L
-#define SECYR		(SECDAY * 365)
-#define	leapyear(year)		((year) % 4 == 0 && \
-				 ((year) % 100 != 0 || (year) % 400 == 0))
-#define	days_in_year(a) 	(leapyear(a) ? 366 : 365)
-#define	days_in_month(a) 	(month_days[(a) - 1])
-
-static int month_days[12] = {
-	31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
-};
-
-void to_tm(int tim, struct rtc_time * tm)
-{
-	register int    i;
-	register long   hms, day;
-
-	day = tim / SECDAY;
-	hms = tim % SECDAY;
-
-	/* Hours, minutes, seconds are easy */
-	tm->tm_hour = hms / 3600;
-	tm->tm_min = (hms % 3600) / 60;
-	tm->tm_sec = (hms % 3600) % 60;
-
-	/* Number of years in days */
-	for (i = STARTOFTIME; day >= days_in_year(i); i++)
-		day -= days_in_year(i);
-	tm->tm_year = i;
-
-	/* Number of months in days left */
-	if (leapyear(tm->tm_year))
-		days_in_month(FEBRUARY) = 29;
-	for (i = 1; day >= days_in_month(i); i++)
-		day -= days_in_month(i);
-	days_in_month(FEBRUARY) = 28;
-	tm->tm_mon = i;
-
-	/* Days are what is left over (+1) from all that. */
-	tm->tm_mday = day + 1;
-
-	/*
-	 * No-one uses the day of the week.
-	 */
-	tm->tm_wday = -1;
-}
-EXPORT_SYMBOL(to_tm);
-
 /*
  * Divide a 128-bit dividend by a 32-bit divisor, leaving a 128 bit
  * result.
diff --git a/arch/powerpc/platforms/ps3/time.c b/arch/powerpc/platforms/ps3/time.c
index 9dac125c997e..08ca76e23d09 100644
--- a/arch/powerpc/platforms/ps3/time.c
+++ b/arch/powerpc/platforms/ps3/time.c
@@ -28,30 +28,6 @@
 
 #include "platform.h"
 
-#define dump_tm(_a) _dump_tm(_a, __func__, __LINE__)
-static void _dump_tm(const struct rtc_time *tm, const char* func, int line)
-{
-	pr_debug("%s:%d tm_sec  %d\n", func, line, tm->tm_sec);
-	pr_debug("%s:%d tm_min  %d\n", func, line, tm->tm_min);
-	pr_debug("%s:%d tm_hour %d\n", func, line, tm->tm_hour);
-	pr_debug("%s:%d tm_mday %d\n", func, line, tm->tm_mday);
-	pr_debug("%s:%d tm_mon  %d\n", func, line, tm->tm_mon);
-	pr_debug("%s:%d tm_year %d\n", func, line, tm->tm_year);
-	pr_debug("%s:%d tm_wday %d\n", func, line, tm->tm_wday);
-}
-
-#define dump_time(_a) _dump_time(_a, __func__, __LINE__)
-static void __maybe_unused _dump_time(int time, const char *func,
-	int line)
-{
-	struct rtc_time tm;
-
-	to_tm(time, &tm);
-
-	pr_debug("%s:%d time    %d\n", func, line, time);
-	_dump_tm(&tm, func, line);
-}
-
 void __init ps3_calibrate_decr(void)
 {
 	int result;
-- 
2.9.0
