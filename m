Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225Dri6f+yZpWLG4jTCXfrx6xHIKy3+5OudJiNX3Q1wHq5ybfpX75F0mT5jvBuL5IDKsSmhA
ARC-Seal: i=1; a=rsa-sha256; t=1518707979; cv=none;
        d=google.com; s=arc-20160816;
        b=t/EIA5uwr+6uyOuZWunLkSlG3VjxFzueIiPYJjnyf5FZwJtCa3vtYmedIPMXdC5w6o
         dpCYW4FBpl1oVA5LIT2/3l21nfAu06tXOBpeGbmWUj684Pg5GKYy6+amJp8p2xglr4JV
         +opKSUPlcMV6xeE8rvcWluAJ6vLSYXdbIBE2opAz2QXoFp26LE+oXXxRJhF+tQBF1My0
         Ln2oqNoytaWkEEwf80sf51ZUulXddWnHU5ZoQcpXP0iKd8GZdDP7pWrUejEWpVU+twg2
         GC6BIqDaiDKCy8PA8+ytbl4HIZcLUJqbrDaRO+WGYW6EvlOPv8y6eUyzUJ4GDVmnj40X
         4GuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AjYlxcs4qYI0hJGhy35933oZcTC+igBXTK6OjXTlja0=;
        b=sTlArtFfIF1BUFjRzAIkaD/KWuEbE2FK7/tCZjZ/zxFdAaXOFUjgbmYc/HrrM2PRa+
         F+7ITmciQLXydduu/08ShHTR1t8z9oJBSwCpbrD0mucNMxo88qFg5Ocy9rt548bii5Xw
         Pf1UiA8bgndw/mFNF8piN7Z8OD7WfBiVw0Hqxe+LCbE2JhQDeZCWDGn3v1ruh8XIl4FO
         rh3ezbrI8s+GQPetOgMxoZl6t6H8FOQnmRLQyZR6djvbh3HdFUV61VgkFq67pAh9e9XJ
         UT9gY1fv/XzsWk2nzxHihBreyeuephPqxn6l56u+dzo6Ejr2ZAJJLdpHxJILfiBRI/oC
         HedQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Biggers <ebiggers3@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <john.stultz@linaro.org>
Subject: [PATCH 3.18 14/45] posix-timer: Properly check sigevent->sigev_notify
Date: Thu, 15 Feb 2018 16:17:05 +0100
Message-Id: <20180215144118.882107122@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480739009494259?=
X-GMAIL-MSGID: =?utf-8?q?1592480739009494259?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit cef31d9af908243421258f1df35a4a644604efbe upstream.

timer_create() specifies via sigevent->sigev_notify the signal delivery for
the new timer. The valid modes are SIGEV_NONE, SIGEV_SIGNAL, SIGEV_THREAD
and (SIGEV_SIGNAL | SIGEV_THREAD_ID).

The sanity check in good_sigevent() is only checking the valid combination
for the SIGEV_THREAD_ID bit, i.e. SIGEV_SIGNAL, but if SIGEV_THREAD_ID is
not set it accepts any random value.

This has no real effects on the posix timer and signal delivery code, but
it affects show_timer() which handles the output of /proc/$PID/timers. That
function uses a string array to pretty print sigev_notify. The access to
that array has no bound checks, so random sigev_notify cause access beyond
the array bounds.

Add proper checks for the valid notify modes and remove the SIGEV_THREAD_ID
masking from various code pathes as SIGEV_NONE can never be set in
combination with SIGEV_THREAD_ID.

Reported-by: Eric Biggers <ebiggers3@gmail.com>
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Reported-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/time/posix-timers.c |   34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -500,17 +500,22 @@ static struct pid *good_sigevent(sigeven
 {
 	struct task_struct *rtn = current->group_leader;
 
-	if ((event->sigev_notify & SIGEV_THREAD_ID ) &&
-		(!(rtn = find_task_by_vpid(event->sigev_notify_thread_id)) ||
-		 !same_thread_group(rtn, current) ||
-		 (event->sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_SIGNAL))
+	switch (event->sigev_notify) {
+	case SIGEV_SIGNAL | SIGEV_THREAD_ID:
+		rtn = find_task_by_vpid(event->sigev_notify_thread_id);
+		if (!rtn || !same_thread_group(rtn, current))
+			return NULL;
+		/* FALLTHRU */
+	case SIGEV_SIGNAL:
+	case SIGEV_THREAD:
+		if (event->sigev_signo <= 0 || event->sigev_signo > SIGRTMAX)
+			return NULL;
+		/* FALLTHRU */
+	case SIGEV_NONE:
+		return task_pid(rtn);
+	default:
 		return NULL;
-
-	if (((event->sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE) &&
-	    ((event->sigev_signo <= 0) || (event->sigev_signo > SIGRTMAX)))
-		return NULL;
-
-	return task_pid(rtn);
+	}
 }
 
 void posix_timers_register_clock(const clockid_t clock_id,
@@ -738,8 +743,7 @@ common_timer_get(struct k_itimer *timr,
 	/* interval timer ? */
 	if (iv.tv64)
 		cur_setting->it_interval = ktime_to_timespec(iv);
-	else if (!hrtimer_active(timer) &&
-		 (timr->it_sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE)
+	else if (!hrtimer_active(timer) && timr->it_sigev_notify != SIGEV_NONE)
 		return;
 
 	now = timer->base->get_time();
@@ -750,7 +754,7 @@ common_timer_get(struct k_itimer *timr,
 	 * expiry is > now.
 	 */
 	if (iv.tv64 && (timr->it_requeue_pending & REQUEUE_PENDING ||
-	    (timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE))
+			timr->it_sigev_notify == SIGEV_NONE))
 		timr->it_overrun += (unsigned int) hrtimer_forward(timer, now, iv);
 
 	remaining = ktime_sub(hrtimer_get_expires(timer), now);
@@ -760,7 +764,7 @@ common_timer_get(struct k_itimer *timr,
 		 * A single shot SIGEV_NONE timer must return 0, when
 		 * it is expired !
 		 */
-		if ((timr->it_sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE)
+		if (timr->it_sigev_notify != SIGEV_NONE)
 			cur_setting->it_value.tv_nsec = 1;
 	} else
 		cur_setting->it_value = ktime_to_timespec(remaining);
@@ -858,7 +862,7 @@ common_timer_set(struct k_itimer *timr,
 	timr->it.real.interval = timespec_to_ktime(new_setting->it_interval);
 
 	/* SIGEV_NONE timers are not queued ! See common_timer_get */
-	if (((timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE)) {
+	if (timr->it_sigev_notify == SIGEV_NONE) {
 		/* Setup correct expiry time for relative timers */
 		if (mode == HRTIMER_MODE_REL) {
 			hrtimer_add_expires(timer, timer->base->get_time());
