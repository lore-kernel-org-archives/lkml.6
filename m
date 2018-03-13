Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbeCMHJo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 03:09:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41455 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbeCMHJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 03:09:42 -0400
Date: Tue, 13 Mar 2018 00:09:08 -0700
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-127bfa5f4342e63d83a0b07ece376c2e8878e4a5@git.kernel.org>
Cc: salyzyn@android.com, john.stultz@linaro.org, kevin@guarana.org,
        corbet@lwn.net, peterz@infradead.org, mingo@kernel.org,
        dmitry.torokhov@gmail.com, sergey.senozhatsky@gmail.com,
        pmladek@suse.com, torvalds@linux-foundation.org, tglx@linutronix.de,
        prarit@redhat.com, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, mtk.manpages@gmail.com
Reply-To: corbet@lwn.net, kevin@guarana.org, john.stultz@linaro.org,
        salyzyn@android.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        tglx@linutronix.de, prarit@redhat.com, torvalds@linux-foundation.org,
        mtk.manpages@gmail.com, hpa@zytor.com, dmitry.torokhov@gmail.com,
        mingo@kernel.org, peterz@infradead.org, sergey.senozhatsky@gmail.com,
        pmladek@suse.com
In-Reply-To: <20180301165150.410218515@linutronix.de>
References: <20180301165150.410218515@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] hrtimer: Unify MONOTONIC and BOOTTIME clock
 behavior
Git-Commit-ID: 127bfa5f4342e63d83a0b07ece376c2e8878e4a5
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

Commit-ID:  127bfa5f4342e63d83a0b07ece376c2e8878e4a5
Gitweb:     https://git.kernel.org/tip/127bfa5f4342e63d83a0b07ece376c2e8878e4a5
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 1 Mar 2018 17:33:37 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Mar 2018 07:34:23 +0100

hrtimer: Unify MONOTONIC and BOOTTIME clock behavior

Now that th MONOTONIC and BOOTTIME clocks are indentical remove all the special
casing.

The user space visible interfaces still support both clocks, but their behavior
is identical.

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
Link: http://lkml.kernel.org/r/20180301165150.410218515@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/hrtimer.h   |  2 --
 kernel/time/hrtimer.c     | 16 ++--------------
 kernel/time/timekeeping.c |  4 +---
 kernel/time/timekeeping.h |  1 -
 4 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index c7902ca7c9f4..78f456fcd242 100644
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
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 23788100e214..9b082ce86325 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -90,11 +90,6 @@ DEFINE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases) =
 			.clockid = CLOCK_REALTIME,
 			.get_time = &ktime_get_real,
 		},
-		{
-			.index = HRTIMER_BASE_BOOTTIME,
-			.clockid = CLOCK_BOOTTIME,
-			.get_time = &ktime_get_boottime,
-		},
 		{
 			.index = HRTIMER_BASE_TAI,
 			.clockid = CLOCK_TAI,
@@ -110,11 +105,6 @@ DEFINE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases) =
 			.clockid = CLOCK_REALTIME,
 			.get_time = &ktime_get_real,
 		},
-		{
-			.index = HRTIMER_BASE_BOOTTIME_SOFT,
-			.clockid = CLOCK_BOOTTIME,
-			.get_time = &ktime_get_boottime,
-		},
 		{
 			.index = HRTIMER_BASE_TAI_SOFT,
 			.clockid = CLOCK_TAI,
@@ -129,7 +119,7 @@ static const int hrtimer_clock_to_base_table[MAX_CLOCKS] = {
 
 	[CLOCK_REALTIME]	= HRTIMER_BASE_REALTIME,
 	[CLOCK_MONOTONIC]	= HRTIMER_BASE_MONOTONIC,
-	[CLOCK_BOOTTIME]	= HRTIMER_BASE_BOOTTIME,
+	[CLOCK_BOOTTIME]	= HRTIMER_BASE_MONOTONIC,
 	[CLOCK_TAI]		= HRTIMER_BASE_TAI,
 };
 
@@ -565,14 +555,12 @@ __hrtimer_get_next_event(struct hrtimer_cpu_base *cpu_base, unsigned int active_
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
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 8355c8803282..ca90219a1e73 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2195,7 +2195,6 @@ void do_timer(unsigned long ticks)
  * ktime_get_update_offsets_now - hrtimer helper
  * @cwsseq:	pointer to check and store the clock was set sequence number
  * @offs_real:	pointer to storage for monotonic -> realtime offset
- * @offs_boot:	pointer to storage for monotonic -> boottime offset
  * @offs_tai:	pointer to storage for monotonic -> clock tai offset
  *
  * Returns current monotonic time and updates the offsets if the
@@ -2205,7 +2204,7 @@ void do_timer(unsigned long ticks)
  * Called from hrtimer_interrupt() or retrigger_next_event()
  */
 ktime_t ktime_get_update_offsets_now(unsigned int *cwsseq, ktime_t *offs_real,
-				     ktime_t *offs_boot, ktime_t *offs_tai)
+				     ktime_t *offs_tai)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	unsigned int seq;
@@ -2222,7 +2221,6 @@ ktime_t ktime_get_update_offsets_now(unsigned int *cwsseq, ktime_t *offs_real,
 		if (*cwsseq != tk->clock_was_set_seq) {
 			*cwsseq = tk->clock_was_set_seq;
 			*offs_real = tk->offs_real;
-			*offs_boot = tk->offs_boot;
 			*offs_tai = tk->offs_tai;
 		}
 
diff --git a/kernel/time/timekeeping.h b/kernel/time/timekeeping.h
index 7a9b4eb7a1d5..79b67f5e0343 100644
--- a/kernel/time/timekeeping.h
+++ b/kernel/time/timekeeping.h
@@ -6,7 +6,6 @@
  */
 extern ktime_t ktime_get_update_offsets_now(unsigned int *cwsseq,
 					    ktime_t *offs_real,
-					    ktime_t *offs_boot,
 					    ktime_t *offs_tai);
 
 extern int timekeeping_valid_for_hres(void);
