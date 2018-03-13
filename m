Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752263AbeCMHKO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 03:10:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44737 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbeCMHKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 03:10:11 -0400
Date: Tue, 13 Mar 2018 00:09:34 -0700
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-92af4dcb4e1c5f58dc337bc97bdffd4e853dbc93@git.kernel.org>
Cc: pmladek@suse.com, tglx@linutronix.de, kevin@guarana.org,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        sergey.senozhatsky@gmail.com, mingo@kernel.org, mtk.manpages@gmail.com,
        dmitry.torokhov@gmail.com, prarit@redhat.com, hpa@zytor.com,
        torvalds@linux-foundation.org, salyzyn@android.com, corbet@lwn.net,
        peterz@infradead.org, john.stultz@linaro.org
Reply-To: kevin@guarana.org, tglx@linutronix.de, pmladek@suse.com,
        mtk.manpages@gmail.com, dmitry.torokhov@gmail.com,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, rostedt@goodmis.org, torvalds@linux-foundation.org,
        hpa@zytor.com, salyzyn@android.com, prarit@redhat.com,
        john.stultz@linaro.org, peterz@infradead.org, corbet@lwn.net
In-Reply-To: <20180301165150.489635255@linutronix.de>
References: <20180301165150.489635255@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] tracing: Unify the "boot" and "mono" tracing
 clocks
Git-Commit-ID: 92af4dcb4e1c5f58dc337bc97bdffd4e853dbc93
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  92af4dcb4e1c5f58dc337bc97bdffd4e853dbc93
Gitweb:     https://git.kernel.org/tip/92af4dcb4e1c5f58dc337bc97bdffd4e853dbc93
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 1 Mar 2018 17:33:38 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Mar 2018 07:34:23 +0100

tracing: Unify the "boot" and "mono" tracing clocks

Unify the "boot" and "mono" tracing clocks and document the new behaviour.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Kevin Easton <kevin@guarana.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Salyzyn <salyzyn@android.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20180301165150.489635255@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/trace/ftrace.txt | 14 +++-----------
 include/linux/timekeeping.h    |  6 ------
 kernel/trace/trace.c           |  2 +-
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/Documentation/trace/ftrace.txt b/Documentation/trace/ftrace.txt
index d4601df6e72e..bf89f98bfdb9 100644
--- a/Documentation/trace/ftrace.txt
+++ b/Documentation/trace/ftrace.txt
@@ -449,17 +449,9 @@ of ftrace. Here is a list of some of the key files:
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
 
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index abb396731332..82c219dfd3bb 100644
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
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 20a2300ae4e8..300f4ea39646 100644
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
 
