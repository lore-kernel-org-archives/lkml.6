Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033228AbeCAQwG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:52:06 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:51703 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033004AbeCAQwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:52:02 -0500
Message-Id: <20180301165150.410218515@linutronix.de>
User-Agent: quilt/0.63-1
Date: Thu, 01 Mar 2018 17:33:37 +0100
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
Subject: [RFC/RFT patch 6/7] hrtimer: Conflate clock MONOTONIC and BOOTTIME
References: <20180301163331.987775783@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline;
 filename=hrtimer--Conflate-clock-MONOTONIC-and-BOOTTIME.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that clock MONOTONIC and BOOTTIME are indentical remove all the special
casing. The user space visible interfaces still support both clocks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/hrtimer.h   |    2 --
 kernel/time/hrtimer.c     |   16 ++--------------
 kernel/time/timekeeping.c |    4 +---
 kernel/time/timekeeping.h |    1 -
 4 files changed, 3 insertions(+), 20 deletions(-)

--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -161,11 +161,9 @@ struct hrtimer_clock_base {
 enum  hrtimer_base_type {
 	HRTIMER_BASE_MONOTONIC,
 	HRTIMER_BASE_REALTIME,
-	HRTIMER_BASE_BOOTTIME,
 	HRTIMER_BASE_TAI,
 	HRTIMER_BASE_MONOTONIC_SOFT,
 	HRTIMER_BASE_REALTIME_SOFT,
-	HRTIMER_BASE_BOOTTIME_SOFT,
 	HRTIMER_BASE_TAI_SOFT,
 	HRTIMER_MAX_CLOCK_BASES,
 };
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -91,11 +91,6 @@ DEFINE_PER_CPU(struct hrtimer_cpu_base,
 			.get_time = &ktime_get_real,
 		},
 		{
-			.index = HRTIMER_BASE_BOOTTIME,
-			.clockid = CLOCK_BOOTTIME,
-			.get_time = &ktime_get_boottime,
-		},
-		{
 			.index = HRTIMER_BASE_TAI,
 			.clockid = CLOCK_TAI,
 			.get_time = &ktime_get_clocktai,
@@ -111,11 +106,6 @@ DEFINE_PER_CPU(struct hrtimer_cpu_base,
 			.get_time = &ktime_get_real,
 		},
 		{
-			.index = HRTIMER_BASE_BOOTTIME_SOFT,
-			.clockid = CLOCK_BOOTTIME,
-			.get_time = &ktime_get_boottime,
-		},
-		{
 			.index = HRTIMER_BASE_TAI_SOFT,
 			.clockid = CLOCK_TAI,
 			.get_time = &ktime_get_clocktai,
@@ -129,7 +119,7 @@ static const int hrtimer_clock_to_base_t
 
 	[CLOCK_REALTIME]	= HRTIMER_BASE_REALTIME,
 	[CLOCK_MONOTONIC]	= HRTIMER_BASE_MONOTONIC,
-	[CLOCK_BOOTTIME]	= HRTIMER_BASE_BOOTTIME,
+	[CLOCK_BOOTTIME]	= HRTIMER_BASE_MONOTONIC,
 	[CLOCK_TAI]		= HRTIMER_BASE_TAI,
 };
 
@@ -565,14 +555,12 @@ static ktime_t
 static inline ktime_t hrtimer_update_base(struct hrtimer_cpu_base *base)
 {
 	ktime_t *offs_real = &base->clock_base[HRTIMER_BASE_REALTIME].offset;
-	ktime_t *offs_boot = &base->clock_base[HRTIMER_BASE_BOOTTIME].offset;
 	ktime_t *offs_tai = &base->clock_base[HRTIMER_BASE_TAI].offset;
 
 	ktime_t now = ktime_get_update_offsets_now(&base->clock_was_set_seq,
-					    offs_real, offs_boot, offs_tai);
+						   offs_real, offs_tai);
 
 	base->clock_base[HRTIMER_BASE_REALTIME_SOFT].offset = *offs_real;
-	base->clock_base[HRTIMER_BASE_BOOTTIME_SOFT].offset = *offs_boot;
 	base->clock_base[HRTIMER_BASE_TAI_SOFT].offset = *offs_tai;
 
 	return now;
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2242,7 +2242,6 @@ void do_timer(unsigned long ticks)
  * ktime_get_update_offsets_now - hrtimer helper
  * @cwsseq:	pointer to check and store the clock was set sequence number
  * @offs_real:	pointer to storage for monotonic -> realtime offset
- * @offs_boot:	pointer to storage for monotonic -> boottime offset
  * @offs_tai:	pointer to storage for monotonic -> clock tai offset
  *
  * Returns current monotonic time and updates the offsets if the
@@ -2252,7 +2251,7 @@ void do_timer(unsigned long ticks)
  * Called from hrtimer_interrupt() or retrigger_next_event()
  */
 ktime_t ktime_get_update_offsets_now(unsigned int *cwsseq, ktime_t *offs_real,
-				     ktime_t *offs_boot, ktime_t *offs_tai)
+				     ktime_t *offs_tai)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	unsigned int seq;
@@ -2269,7 +2268,6 @@ ktime_t ktime_get_update_offsets_now(uns
 		if (*cwsseq != tk->clock_was_set_seq) {
 			*cwsseq = tk->clock_was_set_seq;
 			*offs_real = tk->offs_real;
-			*offs_boot = tk->offs_boot;
 			*offs_tai = tk->offs_tai;
 		}
 
--- a/kernel/time/timekeeping.h
+++ b/kernel/time/timekeeping.h
@@ -6,7 +6,6 @@
  */
 extern ktime_t ktime_get_update_offsets_now(unsigned int *cwsseq,
 					    ktime_t *offs_real,
-					    ktime_t *offs_boot,
 					    ktime_t *offs_tai);
 
 extern int timekeeping_valid_for_hres(void);
