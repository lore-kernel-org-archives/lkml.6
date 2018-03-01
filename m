Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033156AbeCAQ5q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:57:46 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:51851 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033313AbeCAQ5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:57:32 -0500
Message-Id: <20180301165150.489635255@linutronix.de>
User-Agent: quilt/0.63-1
Date: Thu, 01 Mar 2018 17:33:38 +0100
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Stultz <john.stultz@linaro.org>, Petr Mladek <pmladek@suse.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kevin Easton <kevin@guarana.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [RFC/RFT patch 7/7] tracing: Conflate boot and monotonic clock
References: <20180301163331.987775783@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline;
 filename=tracing--Conflate-boot-and-monotonic-clock.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conflate boot and mono trace clocks and document the new behaviour.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 Documentation/trace/ftrace.txt |   14 +++-----------
 include/linux/timekeeping.h    |    6 ------
 kernel/trace/trace.c           |    2 +-
 3 files changed, 4 insertions(+), 18 deletions(-)

--- a/Documentation/trace/ftrace.txt
+++ b/Documentation/trace/ftrace.txt
@@ -449,17 +449,9 @@ After mounting tracefs you will have acc
 		which is montonic but is not subject to any rate adjustments
 		and ticks at the same rate as the hardware clocksource.
 
-	  boot: This is the boot clock (CLOCK_BOOTTIME) and is based on the
-		fast monotonic clock, but also accounts for time spent in
-		suspend. Since the clock access is designed for use in
-		tracing in the suspend path, some side effects are possible
-		if clock is accessed after the suspend time is accounted before
-		the fast mono clock is updated. In this case, the clock update
-		appears to happen slightly sooner than it normally would have.
-		Also on 32-bit systems, it's possible that the 64-bit boot offset
-		sees a partial update. These effects are rare and post
-		processing should be able to handle them. See comments in the
-		ktime_get_boot_fast_ns() function for more information.
+	  boot: Same as mono. Used to be a separate clock which accounted
+	  	for the time spent in suspend while CLOCK_MONOTONIC did
+		not.
 
 	To set a clock, simply echo the clock name into this file.
 
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -113,12 +113,6 @@ extern u64 ktime_get_mono_fast_ns(void);
 extern u64 ktime_get_raw_fast_ns(void);
 extern u64 ktime_get_real_fast_ns(void);
 
-/* Clock BOOTTIME compatibility wrappers */
-static inline u64 ktime_get_boot_fast_ns(void)
-{
-	return ktime_get_mono_fast_ns();
-}
-
 /*
  * timespec64 interfaces utilizing the ktime based ones
  */
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1164,7 +1164,7 @@ static struct {
 	{ trace_clock,			"perf",		1 },
 	{ ktime_get_mono_fast_ns,	"mono",		1 },
 	{ ktime_get_raw_fast_ns,	"mono_raw",	1 },
-	{ ktime_get_boot_fast_ns,	"boot",		1 },
+	{ ktime_get_mono_fast_ns,	"boot",		1 },
 	ARCH_TRACE_CLOCKS
 };
 
