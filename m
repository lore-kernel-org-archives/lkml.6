Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/TEmE5ODHS1sD5UfBQ3zwl8TQlELyZyAzt/IkZbbo582GV2NnrbZDhR0DcOrmbkcQVnugq
ARC-Seal: i=1; a=rsa-sha256; t=1524653072; cv=none;
        d=google.com; s=arc-20160816;
        b=l5CijPs3rCWB6AKx8KbSCHu6kU4sEltsYpu32F4yprptlXrOspygHdvtM0kpwLWLw1
         62cBTyRHd9NkkAfoawPYNgeQc7t4A8sWvqsFL/RTfEbfG3qe5iYXkjfy3eG7CGNUDnre
         DhWUaj5PNmg21Ze5DRu9yx/L0jZtmSpnF8cPIpOsBfr0LTksffJdNUcZRKU3TGDHDyHq
         Pr+GXwhsCIg5y5RnV6tXlgCmetDQZmzZBsspRffl8nFBIq7UQ5e6KX+0dfDaE3bIE2tv
         6mClBuyhT+iO/x4ZPaHQWWKE8rOtNmdW8q+UEOsb8PC+RKyd9AF4LlGCK66molqBhUDJ
         Vqtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LYVDZXTWBC0vPAVqkzld5cX1HWMYdYv4k9kPajXJOoE=;
        b=bgogiQHdrUxFne/z+G7fv1Kq21+tpwqAgXchJhdIc6C9M6Uz/Ama8TqxqNXGkqT1fl
         8iI+7IOWVWCuuBg7g35X/a2xCX+bZB/YoqBjxpjGEBQGevJ8391FYQxdtGCdM6N93zAI
         NX0OPC11Fofdr4Mw8ZyxcRAtgUma4+OeiNlvREJ24Ez9Io85US7ZpJBpjgMWnMqcf+CM
         yRZl65w8dbNeI6BKHfm7Bf2NWjeqbkLAgk1lI1HUSlteIXYlPBPO5fKmPtIFM7WaZQvX
         xP0sGPxTsxtDQN3EiSSH4chBeqZShR4cXeOTZZtscwTJ9U8dhWT4rXM9z4pWNtF1gzac
         J0Tw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+a3e0726462b2e346a31d@syzkaller.appspotmail.com,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <john.stultz@linaro.org>,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH 4.14 173/183] alarmtimer: Init nanosleep alarm timer on stack
Date: Wed, 25 Apr 2018 12:36:33 +0200
Message-Id: <20180425103249.465305078@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598713968044165236?=
X-GMAIL-MSGID: =?utf-8?q?1598714620302524197?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit bd03143007eb9b03a7f2316c677780561b68ba2a upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/time/alarmtimer.c |   34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -326,6 +326,17 @@ static int alarmtimer_resume(struct devi
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
@@ -335,13 +346,9 @@ static int alarmtimer_resume(struct devi
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
 
@@ -719,6 +726,8 @@ static int alarmtimer_do_nsleep(struct a
 
 	__set_current_state(TASK_RUNNING);
 
+	destroy_hrtimer_on_stack(&alarm->timer);
+
 	if (!alarm->data)
 		return 0;
 
@@ -740,6 +749,15 @@ static int alarmtimer_do_nsleep(struct a
 	return -ERESTART_RESTARTBLOCK;
 }
 
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
  * alarm_timer_nsleep_restart - restartblock alarmtimer nsleep
  * @restart: ptr to restart block
@@ -752,7 +770,7 @@ static long __sched alarm_timer_nsleep_r
 	ktime_t exp = restart->nanosleep.expires;
 	struct alarm alarm;
 
-	alarm_init(&alarm, type, alarmtimer_nsleep_wakeup);
+	alarm_init_on_stack(&alarm, type, alarmtimer_nsleep_wakeup);
 
 	return alarmtimer_do_nsleep(&alarm, exp, type);
 }
@@ -784,7 +802,7 @@ static int alarm_timer_nsleep(const cloc
 	if (!capable(CAP_WAKE_ALARM))
 		return -EPERM;
 
-	alarm_init(&alarm, type, alarmtimer_nsleep_wakeup);
+	alarm_init_on_stack(&alarm, type, alarmtimer_nsleep_wakeup);
 
 	exp = timespec64_to_ktime(*tsreq);
 	/* Convert (if necessary) to absolute time */
