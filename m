Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49REWiVR1Mg0wC0TwHQpOaYSgNIkcqpCOIXqdRviYJ96N1HKXQMoGVwbM1bDOMBGTfh4Ssq
ARC-Seal: i=1; a=rsa-sha256; t=1523472564; cv=none;
        d=google.com; s=arc-20160816;
        b=MRWVbVRnN7urJqNST0JgZgRttNAVIdqVYc/D62GDplvGJI+SqjOhleokRTFseAYaGm
         kkYHYKO4KNLoLZWHYEEhvRnfvkfZHs8H027WpepE++aJ9QXj7a9HsrWcs6UMQMVTkHsG
         35Kmc12T2tgsSLyZdpE5tcRLxZBf8K6OWDMNROYyU2yuufJJ+J+eAjufWhaK8e3GEhmT
         OE1k2wXYm0ZiBGwLzR2LrneNXyRuweNbKy5EJ6nq0jeJL55P2IeLT3RV4cxsHPknMuR2
         OnjkyxdfH4vWqnGg1pIG+35tRx3BNOkdBXrGv/m53kHLktOAugUluciM+9iyZA87W26W
         Gtag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BbM9hsqOcwRylpDwPAHAysKPUMneK03aaGkEI0TAGDA=;
        b=IvW2SSrdCRROoHv+YRazzapexD5Y4WgsXDJcJy1z830u8zgoWwj6w0GOYt+8LlasWU
         wwFQeV40zF8tBH4Q0z/Ds4xCo6R3pULbLp+FUuDeOGXgstD+tEuNfHnfi1DUmF6BppqI
         zgVlNr+g+pNGnXqxBDOKYWGTS96QfZh4rCQD7rb7F4qMVJtdicwXx5+d2GUJ8XEOE20b
         o8X9PwbibHPDk1BVAR2ujf5rifp02B9BuREbrvwN7PTAFPaPQzweLxOL4ojZHnTHZa2s
         Dh2F6HpOp94Fw2KEV2TZpRJS/I5/2AEX3YHIjhvDXQjM3dVOVTbr41DRYX33MfLQbZkW
         jKuA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephane Eranian <eranian@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vince Weaver <vince@deater.net>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 130/190] perf/core: Correct event creation with PERF_FORMAT_GROUP
Date: Wed, 11 Apr 2018 20:36:16 +0200
Message-Id: <20180411183559.831292963@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476252641342543?=
X-GMAIL-MSGID: =?utf-8?q?1597476767874004704?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>


[ Upstream commit ba5213ae6b88fb170c4771fef6553f759c7d8cdd ]

Andi was asking about PERF_FORMAT_GROUP vs inherited events, which led
to the discovery of a bug from commit:

  3dab77fb1bf8 ("perf: Rework/fix the whole read vs group stuff")

 -       PERF_SAMPLE_GROUP                       = 1U << 4,
 +       PERF_SAMPLE_READ                        = 1U << 4,

 -       if (attr->inherit && (attr->sample_type & PERF_SAMPLE_GROUP))
 +       if (attr->inherit && (attr->read_format & PERF_FORMAT_GROUP))

is a clear fail :/

While this changes user visible behaviour; it was previously possible
to create an inherited event with PERF_SAMPLE_READ; this is deemed
acceptible because its results were always incorrect.

Reported-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vince@deater.net>
Fixes:  3dab77fb1bf8 ("perf: Rework/fix the whole read vs group stuff")
Link: http://lkml.kernel.org/r/20170530094512.dy2nljns2uq7qa3j@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/events/core.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5271,9 +5271,6 @@ static void perf_output_read_one(struct
 	__output_copy(handle, values, n * sizeof(u64));
 }
 
-/*
- * XXX PERF_FORMAT_GROUP vs inherited events seems difficult.
- */
 static void perf_output_read_group(struct perf_output_handle *handle,
 			    struct perf_event *event,
 			    u64 enabled, u64 running)
@@ -5318,6 +5315,13 @@ static void perf_output_read_group(struc
 #define PERF_FORMAT_TOTAL_TIMES (PERF_FORMAT_TOTAL_TIME_ENABLED|\
 				 PERF_FORMAT_TOTAL_TIME_RUNNING)
 
+/*
+ * XXX PERF_SAMPLE_READ vs inherited events seems difficult.
+ *
+ * The problem is that its both hard and excessively expensive to iterate the
+ * child list, not to mention that its impossible to IPI the children running
+ * on another CPU, from interrupt/NMI context.
+ */
 static void perf_output_read(struct perf_output_handle *handle,
 			     struct perf_event *event)
 {
@@ -7958,9 +7962,10 @@ perf_event_alloc(struct perf_event_attr
 	local64_set(&hwc->period_left, hwc->sample_period);
 
 	/*
-	 * we currently do not support PERF_FORMAT_GROUP on inherited events
+	 * We currently do not support PERF_SAMPLE_READ on inherited events.
+	 * See perf_output_read().
 	 */
-	if (attr->inherit && (attr->read_format & PERF_FORMAT_GROUP))
+	if (attr->inherit && (attr->sample_type & PERF_SAMPLE_READ))
 		goto err_ns;
 
 	if (!has_branch_stack(event))
