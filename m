Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966116AbeE1KPK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:15:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936741AbeE1KO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:14:59 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>, John Stultz <john.stultz@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, keescook@chromium.org,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 023/268] tracing/hrtimer: Fix tracing bugs by taking all clock bases and modes into account
Date: Mon, 28 May 2018 11:59:57 +0200
Message-Id: <20180528100204.715331358@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anna-Maria Gleixner <anna-maria@linutronix.de>

[ Upstream commit 91633eed73a3ac37aaece5c8c1f93a18bae616a9 ]

So far only CLOCK_MONOTONIC and CLOCK_REALTIME were taken into account as
well as HRTIMER_MODE_ABS/REL in the hrtimer_init tracepoint. The query for
detecting the ABS or REL timer modes is not valid anymore, it got broken
by the introduction of HRTIMER_MODE_PINNED.

HRTIMER_MODE_PINNED is not evaluated in the hrtimer_init() call, but for the
sake of completeness print all given modes.

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: keescook@chromium.org
Link: http://lkml.kernel.org/r/20171221104205.7269-9-anna-maria@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/trace/events/timer.h |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -125,6 +125,20 @@ DEFINE_EVENT(timer_class, timer_cancel,
 	TP_ARGS(timer)
 );
 
+#define decode_clockid(type)						\
+	__print_symbolic(type,						\
+		{ CLOCK_REALTIME,	"CLOCK_REALTIME"	},	\
+		{ CLOCK_MONOTONIC,	"CLOCK_MONOTONIC"	},	\
+		{ CLOCK_BOOTTIME,	"CLOCK_BOOTTIME"	},	\
+		{ CLOCK_TAI,		"CLOCK_TAI"		})
+
+#define decode_hrtimer_mode(mode)					\
+	__print_symbolic(mode,						\
+		{ HRTIMER_MODE_ABS,		"ABS"		},	\
+		{ HRTIMER_MODE_REL,		"REL"		},	\
+		{ HRTIMER_MODE_ABS_PINNED,	"ABS|PINNED"	},	\
+		{ HRTIMER_MODE_REL_PINNED,	"REL|PINNED"	})
+
 /**
  * hrtimer_init - called when the hrtimer is initialized
  * @hrtimer:	pointer to struct hrtimer
@@ -151,10 +165,8 @@ TRACE_EVENT(hrtimer_init,
 	),
 
 	TP_printk("hrtimer=%p clockid=%s mode=%s", __entry->hrtimer,
-		  __entry->clockid == CLOCK_REALTIME ?
-			"CLOCK_REALTIME" : "CLOCK_MONOTONIC",
-		  __entry->mode == HRTIMER_MODE_ABS ?
-			"HRTIMER_MODE_ABS" : "HRTIMER_MODE_REL")
+		  decode_clockid(__entry->clockid),
+		  decode_hrtimer_mode(__entry->mode))
 );
 
 /**
