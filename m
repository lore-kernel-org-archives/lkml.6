Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs9M94Co8chyH2UD3xJYa8c+3Qz+fo2GYIAw617CvgC/8o8BpbmG6fIxZbR+1JMjEf9egEO
ARC-Seal: i=1; a=rsa-sha256; t=1519981152; cv=none;
        d=google.com; s=arc-20160816;
        b=GA81TRJp2CMiuAl+6EEeYBxVVdmmfbpg44mkEAziAfj8xuI84JI63MS7PlZqTIzJhQ
         BQ1nZm2QcLRQc9N+b65ANO9vovO2y1wSV+mZnL8l+VajxC/NLbBteLOJ7ci1yCn329r+
         ar524qCkrXD8uFeE3w9SUv4wOxCGcVW9qimuxowr/B9zsvyo7vmGVQWQmx2/HNSvU+J4
         w6UrSrNsdlFJj/SJ5MwC4T6Fvw9HkDMHzVaGb5F7ViAFhqqHzd79Fy2aRUiC4bbLmO+6
         U+6DcLV0xYNllroGuuJzFjA9WJOK39Bha/KngElp1Qobsms+qaz/lUjgqmHm07rL5KSk
         D/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LXfmTl4f+f5F74Ci3E3BdJtjGnSpH5lAQ3OBCkW1v2s=;
        b=Wi2MRBcTdWTBVjO5iFOiVA6aj/LCbCW2SkWpi3zqurmNERwehQKnRTwhUc8kbpxKX2
         LJIDPMz58RmNzeKR62LgkVhvynXnGRzbHHdw6tFa4DxRWCZzTY7QaX0t032DCUmva4vo
         pKB3gFOlzviauYGcfUHOHkBeIPjhT2yX0wir0074vhaKetOLnisOPsmgLkDfGzRRwaRy
         9jRp92i/TVdcSyXkkfwCisO73I+mBpw/mD64a30oyt+LT9McVW9zqKoJPglyou0GgdRF
         g/5Zebk9mXTk/M2w7Db49TOy35VyKcfjtiFC+MJ8Lsfln0YyG7avJnvtKkQdWpTjSLiY
         Jjrw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Christoph Hellwig <hch@lst.de>,
	John Stultz <john.stultz@linaro.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	keescook@chromium.org,
	Ingo Molnar <mingo@kernel.org>,
	Mike Galbraith <efault@gmx.de>
Subject: [PATCH 4.14 001/115] hrtimer: Ensure POSIX compliance (relative CLOCK_REALTIME hrtimers)
Date: Fri,  2 Mar 2018 09:50:04 +0100
Message-Id: <20180302084503.914423210@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815313705142995?=
X-GMAIL-MSGID: =?utf-8?q?1593815757031118663?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anna-Maria Gleixner <anna-maria@linutronix.de>

commit 48d0c9becc7f3c66874c100c126459a9da0fdced upstream.

The POSIX specification defines that relative CLOCK_REALTIME timers are not
affected by clock modifications. Those timers have to use CLOCK_MONOTONIC
to ensure POSIX compliance.

The introduction of the additional HRTIMER_MODE_PINNED mode broke this
requirement for pinned timers.

There is no user space visible impact because user space timers are not
using pinned mode, but for consistency reasons this needs to be fixed.

Check whether the mode has the HRTIMER_MODE_REL bit set instead of
comparing with HRTIMER_MODE_ABS.

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: keescook@chromium.org
Fixes: 597d0275736d ("timers: Framework for identifying pinned timers")
Link: http://lkml.kernel.org/r/20171221104205.7269-7-anna-maria@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Mike Galbraith <efault@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/time/hrtimer.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1106,7 +1106,12 @@ static void __hrtimer_init(struct hrtime
 
 	cpu_base = raw_cpu_ptr(&hrtimer_bases);
 
-	if (clock_id == CLOCK_REALTIME && mode != HRTIMER_MODE_ABS)
+	/*
+	 * POSIX magic: Relative CLOCK_REALTIME timers are not affected by
+	 * clock modifications, so they needs to become CLOCK_MONOTONIC to
+	 * ensure POSIX compliance.
+	 */
+	if (clock_id == CLOCK_REALTIME && mode & HRTIMER_MODE_REL)
 		clock_id = CLOCK_MONOTONIC;
 
 	base = hrtimer_clockid_to_base(clock_id);
