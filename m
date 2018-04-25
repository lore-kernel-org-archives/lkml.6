Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+GMtGv8fzuwr+cQprNMz+23rmTzoGu5XpxywU7GXtk1bJOrd/zyczMrnXqAGmPMzd2AEDD
ARC-Seal: i=1; a=rsa-sha256; t=1524652798; cv=none;
        d=google.com; s=arc-20160816;
        b=m81B8I4HCH50y/skVQQEdoCnT0Zdc9udz9JI8eVpusThnDmRjhz6qKYJJMWwLLHs2Z
         yj+C7cqMURc1pNmn1a1Mtzd6x8lrtWeLVeC51KbudbV+OE2PE6n3V7gtmvkCQyvHvxY+
         8bhGlWUlfcYXSRHH54RtpC1IBivb6oo/RUdB7bK6alIemXMmL5oJ02eb/V03YGsli+3k
         0UYe2BPfl2aNHcQD9q8fN8CpMLyFZxn0bh3G0XT3Lpg2x3zFqtgroQAuHxMdztk2fcEa
         AxQ/Yuyq8X5tysr2wWm78fMY5Vw8lLNgYmgecS+8iHyHGE1QL6Yo1k2iPBd2zzQm5Ack
         bOzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KomG6AnnwelZY/GG9fvyi6Fc7ItI6vMUL1SFt0760t8=;
        b=iEqC3ttRwsqxd2U8aOFAVzrwCWQX3a4EtKprhFcy0IM6sBR2Y0izku9emuSXVfdBPj
         jkMEUfTzjR7WlXKFsF3Q932k5StJP1/MmJ3IzD3B5nD2tgHTZHnlGVAEhg5HXMSfO1I2
         KvNYd3tRqZbcNsV2XShpITMY3rgUiTLpXto8r4XsecaDp1NKc1KSdzIru4xVqMStU749
         OFx9xOnE2cKEA59IGCbnQXmZax4SKIlMjr8Yxp+rCJpNph3EKeSHA6zovra18MpsuuDu
         e94jtTm/8g2hYKb9EjV3iZOMVYSvg4Fx8XYGtnXLuU+6frXz6ScB0IBb2knEatOw/WRW
         Socg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
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
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 026/183] tracing/hrtimer: Fix tracing bugs by taking all clock bases and modes into account
Date: Wed, 25 Apr 2018 12:34:06 +0200
Message-Id: <20180425103243.656527951@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714333232345554?=
X-GMAIL-MSGID: =?utf-8?q?1598714333232345554?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -136,6 +136,20 @@ DEFINE_EVENT(timer_class, timer_cancel,
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
@@ -162,10 +176,8 @@ TRACE_EVENT(hrtimer_init,
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
