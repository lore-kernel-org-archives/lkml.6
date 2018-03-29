Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752568AbeC2NkS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 09:40:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59089 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751908AbeC2NkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 09:40:16 -0400
Date: Thu, 29 Mar 2018 06:40:10 -0700
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-00c720743fc951d46a7ee15f26a531b27f6082cb@git.kernel.org>
Cc: hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, john.stultz@linaro.org
Reply-To: john.stultz@linaro.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com
In-Reply-To: <alpine.DEB.2.21.1803261528270.1585@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1803261528270.1585@nanos.tec.linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] alarmtimer: Init nanosleep alarm timer on stack
Git-Commit-ID: 00c720743fc951d46a7ee15f26a531b27f6082cb
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

Commit-ID:  00c720743fc951d46a7ee15f26a531b27f6082cb
Gitweb:     https://git.kernel.org/tip/00c720743fc951d46a7ee15f26a531b27f6082cb
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 26 Mar 2018 15:29:57 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 29 Mar 2018 15:35:59 +0200

alarmtimer: Init nanosleep alarm timer on stack

syszbot reported the following debugobjects splat:

 ODEBUG: object is on stack, but not annotated
 WARNING: CPU: 0 PID: 4185 at lib/debugobjects.c:328

 RIP: 0010:debug_object_is_on_stack lib/debugobjects.c:327 [inline]
 debug_object_init+0x17/0x20 lib/debugobjects.c:391
 debug_hrtimer_init kernel/time/hrtimer.c:410 [inline]
 debug_init kernel/time/hrtimer.c:458 [inline]
 hrtimer_init+0x8c/0x410 kernel/time/hrtimer.c:1259
 alarm_init kernel/time/alarmtimer.c:339 [inline]
 alarm_timer_nsleep+0x164/0x4d0 kernel/time/alarmtimer.c:787
 SYSC_clock_nanosleep kernel/time/posix-timers.c:1226 [inline]
 SyS_clock_nanosleep+0x235/0x330 kernel/time/posix-timers.c:1204
 do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x42/0xb7

This happens because the hrtimer for the alarm nanosleep is on stack, but
the code does not use the proper debug objects initialization.

Split out the code for the allocated use cases and invoke
hrtimer_init_on_stack() for the nanosleep related functions.

Reported-by: syzbot+a3e0726462b2e346a31d@syzkaller.appspotmail.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: syzkaller-bugs@googlegroups.com
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1803261528270.1585@nanos.tec.linutronix.de
---
 kernel/time/alarmtimer.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index ec09ce9a6012..6960fb02828b 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -326,6 +326,17 @@ static int alarmtimer_resume(struct device *dev)
 }
 #endif
 
+static void
+__alarm_init(struct alarm *alarm, enum alarmtimer_type type,
+	     enum alarmtimer_restart (*function)(struct alarm *, ktime_t))
+{
+	timerqueue_init(&alarm->node);
+	alarm->timer.function = alarmtimer_fired;
+	alarm->function = function;
+	alarm->type = type;
+	alarm->state = ALARMTIMER_STATE_INACTIVE;
+}
+
 /**
  * alarm_init - Initialize an alarm structure
  * @alarm: ptr to alarm to be initialized
@@ -335,16 +346,21 @@ static int alarmtimer_resume(struct device *dev)
 void alarm_init(struct alarm *alarm, enum alarmtimer_type type,
 		enum alarmtimer_restart (*function)(struct alarm *, ktime_t))
 {
-	timerqueue_init(&alarm->node);
 	hrtimer_init(&alarm->timer, alarm_bases[type].base_clockid,
-			HRTIMER_MODE_ABS);
-	alarm->timer.function = alarmtimer_fired;
-	alarm->function = function;
-	alarm->type = type;
-	alarm->state = ALARMTIMER_STATE_INACTIVE;
+		     HRTIMER_MODE_ABS);
+	__alarm_init(alarm, type, function);
 }
 EXPORT_SYMBOL_GPL(alarm_init);
 
+static void
+alarm_init_on_stack(struct alarm *alarm, enum alarmtimer_type type,
+		    enum alarmtimer_restart (*function)(struct alarm *, ktime_t))
+{
+	hrtimer_init_on_stack(&alarm->timer, alarm_bases[type].base_clockid,
+			      HRTIMER_MODE_ABS);
+	__alarm_init(alarm, type, function);
+}
+
 /**
  * alarm_start - Sets an absolute alarm to fire
  * @alarm: ptr to alarm to set
@@ -719,6 +735,8 @@ static int alarmtimer_do_nsleep(struct alarm *alarm, ktime_t absexp,
 
 	__set_current_state(TASK_RUNNING);
 
+	destroy_hrtimer_on_stack(&alarm->timer);
+
 	if (!alarm->data)
 		return 0;
 
@@ -752,7 +770,7 @@ static long __sched alarm_timer_nsleep_restart(struct restart_block *restart)
 	ktime_t exp = restart->nanosleep.expires;
 	struct alarm alarm;
 
-	alarm_init(&alarm, type, alarmtimer_nsleep_wakeup);
+	alarm_init_on_stack(&alarm, type, alarmtimer_nsleep_wakeup);
 
 	return alarmtimer_do_nsleep(&alarm, exp, type);
 }
@@ -784,7 +802,7 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 	if (!capable(CAP_WAKE_ALARM))
 		return -EPERM;
 
-	alarm_init(&alarm, type, alarmtimer_nsleep_wakeup);
+	alarm_init_on_stack(&alarm, type, alarmtimer_nsleep_wakeup);
 
 	exp = timespec64_to_ktime(*tsreq);
 	/* Convert (if necessary) to absolute time */
