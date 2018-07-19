Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E25FC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 19:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF2520684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 19:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AW51IzMX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF2520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387712AbeGST5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 15:57:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35542 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732746AbeGST5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 15:57:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6-v6so4612991pgv.2;
        Thu, 19 Jul 2018 12:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g3/xKXqLInvNCzXmb/llZ8VVNlajgzwddRZa7znaoBg=;
        b=AW51IzMXpZSj2t7/RLiqDlVfxUUW9IREcGW0SAMEtKhkRGX755aaHBicKhr/jaCKzH
         Mw/m1wfeGKwP5FWGHdRrzm0dbphIrB1sBfdFr6yGx8QY52BSosD9iV4S/e/z38UdZCn3
         xVil+BkCr28F+glYfZxyKS6NOQmtZo3r4K9eJgrtbCqx1UWhONNSk5F71xpoKVFX5ka8
         FhL62BEeo/qgaU9xBQwCVB6Hkm7IBlGr/eUKfK6hPxB9QmMstBkJFefzmoMvodFm4xOB
         OeaF69Oe2UlTHIOJ6J0MfJSfuVyak36fJrYCxGeQs1vJZm3IaqDZZnHDZfwA3k39JO/N
         HAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g3/xKXqLInvNCzXmb/llZ8VVNlajgzwddRZa7znaoBg=;
        b=oVFHRmB8iT/GXbRxqirFV3AKH5TbX2X1a231bObpaxwEbKwnbSQHLl5KQ1fTCHxH5Q
         WvCPu0sfqCrAFPgaL364ul9lIBWzPZZCJ94PcHQG91g8iWDG2z/bnfK7fRxkXhm201cM
         8XbAH5sQLH353A//2es8mOMd7rqwql1aVw2WasInm9ZbkefObs04WPBtbjKy0loeOcCU
         edtqs9xJREbGqlTZI79JkfVShwyhmlCMY/tNS2NErjU9HSuJA85tdGot0R8VvRux7LZA
         9Z2A8e79MA2NhiBNUPTh9t+fW/YJVt4OwVMFSn11SnXGwKmoAWXPgHj6i0swKG1+RN/i
         jWWQ==
X-Gm-Message-State: AOUpUlEbxpRys4Cjpwk8jsMZ+kwWXkcyzPb4vIouPUfUjcbRrcXjMxxD
        qxjKaXV9dvuQXpEoVw8lchK93HsXy/w=
X-Google-Smtp-Source: AAOMgpf1Ygp6FLqKGaq2fo/x+buo88G/bmfMzqTif+ZY5TywWISClr4V08+jQp0iKHt5VJB8jm6hSw==
X-Received: by 2002:a62:ccd0:: with SMTP id j77-v6mr10719832pfk.22.1532027591185;
        Thu, 19 Jul 2018 12:13:11 -0700 (PDT)
Received: from tw-172-25-29-199.office.twttr.net ([8.25.197.27])
        by smtp.gmail.com with ESMTPSA id t69-v6sm2656912pfj.7.2018.07.19.12.13.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 12:13:10 -0700 (PDT)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, stable@vger.kernel.org
Subject: [PATCH v2] perf/core: fix a possible deadlock scenario
Date:   Thu, 19 Jul 2018 12:12:53 -0700
Message-Id: <20180719191253.3843-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180719132834.GF18667@krava>
References: <20180719132834.GF18667@krava>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hrtimer_cancel() busy-waits for the hrtimer callback to stop,
pretty much like del_timer_sync(). This creates a possible deadlock
scenario where we hold a spinlock before calling hrtimer_cancel()
while in trying to acquire the same spinlock in the callback.

This kind of deadlock is already known and is catchable by lockdep,
like for del_timer_sync(), we can add lockdep annotations. However,
it is still missing for hrtimer_cancel(). (I have a WIP patch to make
it complete for hrtimer_cancel() but it breaks booting.)

And there is such a deadlock scenario in kernel/events/core.c too,
well actually, it is a simpler version: the hrtimer callback waits
for itself to finish on the same CPU! It sounds stupid but it is
not obvious at all, it hides very deeply in the perf event code:

cpu_clock_event_init():
  perf_swevent_init_hrtimer():
    hwc->hrtimer.function = perf_swevent_hrtimer;

perf_swevent_hrtimer():
  __perf_event_overflow():
    __perf_event_account_interrupt():
      perf_adjust_period():
        pmu->stop():
        cpu_clock_event_stop():
          perf_swevent_cancel():
            hrtimer_cancel()

Getting stuck in an hrtimer is a disaster:

Interrupts are disabled for hrtimer_interrupt(), this means other
interrupt handling is blocked too, notably the IPI handler, especially
when smp_call_function_*() waits for their callbacks synchronously.
This is probably why we saw hundreds of soft lockup's inside
smp_call_function_single(), given how widely they are used in kernel.
Ironically, perf event code uses synchronous smp_call_function_single()
heavily too.

The fix is not easy. To minimize the impact, ideally we should just
avoid busy waiting when it is called within the hrtimer callback on
the same CPU, there is no reason to wait for itself to finish anyway.
Probably it doesn't even need to cancel itself either since it will
restart by pmu->start() later. There are two possible fixes here:

1. Modify hrtimer API to detect if a hrtimer callback is running
on the same CPU now. It does not look pretty to adjust it only
for this special case though.

2. Passing some information from perf_swevent_hrtimer() down to
perf_swevent_cancel().

So I pick the latter approach, it is nicer and straightforward.

Note, Jiri pointed out that the swevent pmu does not triger NMI and
this timer will never be touched in NMI context, so we don't race
with NMI handler here.

Fixes: abd50713944c ("perf: Reimplement frequency driven sampling")
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 include/linux/perf_event.h |  3 +++
 kernel/events/core.c       | 43 +++++++++++++++++++++++++++----------------
 2 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1fa12887ec02..aab39b8aa720 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -310,6 +310,9 @@ struct pmu {
 #define PERF_EF_START	0x01		/* start the counter when adding    */
 #define PERF_EF_RELOAD	0x02		/* reload the counter when starting */
 #define PERF_EF_UPDATE	0x04		/* update the counter when stopping */
+#define PERF_EF_NO_WAIT	0x08		/* do not wait when stopping, for
+					 * example, waiting for a timer
+					 */
 
 	/*
 	 * Adds/Removes a counter to/from the PMU, can be done inside a
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8f0434a9951a..f15832346b35 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3555,7 +3555,8 @@ do {					\
 static DEFINE_PER_CPU(int, perf_throttled_count);
 static DEFINE_PER_CPU(u64, perf_throttled_seq);
 
-static void perf_adjust_period(struct perf_event *event, u64 nsec, u64 count, bool disable)
+static void perf_adjust_period(struct perf_event *event, u64 nsec, u64 count,
+			       bool disable, bool nowait)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	s64 period, sample_period;
@@ -3574,8 +3575,13 @@ static void perf_adjust_period(struct perf_event *event, u64 nsec, u64 count, bo
 	hwc->sample_period = sample_period;
 
 	if (local64_read(&hwc->period_left) > 8*sample_period) {
-		if (disable)
-			event->pmu->stop(event, PERF_EF_UPDATE);
+		if (disable) {
+			int flags = PERF_EF_UPDATE;
+
+			if (nowait)
+				flags |= PERF_EF_NO_WAIT;
+			event->pmu->stop(event, flags);
+		}
 
 		local64_set(&hwc->period_left, 0);
 
@@ -3645,7 +3651,7 @@ static void perf_adjust_freq_unthr_context(struct perf_event_context *ctx,
 		 * twice.
 		 */
 		if (delta > 0)
-			perf_adjust_period(event, period, delta, false);
+			perf_adjust_period(event, period, delta, false, false);
 
 		event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
 	next:
@@ -7681,7 +7687,8 @@ static void perf_log_itrace_start(struct perf_event *event)
 }
 
 static int
-__perf_event_account_interrupt(struct perf_event *event, int throttle)
+__perf_event_account_interrupt(struct perf_event *event, int throttle,
+			       bool nowait)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	int ret = 0;
@@ -7710,7 +7717,8 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
 		hwc->freq_time_stamp = now;
 
 		if (delta > 0 && delta < 2*TICK_NSEC)
-			perf_adjust_period(event, delta, hwc->last_period, true);
+			perf_adjust_period(event, delta, hwc->last_period, true,
+					   nowait);
 	}
 
 	return ret;
@@ -7718,7 +7726,7 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
 
 int perf_event_account_interrupt(struct perf_event *event)
 {
-	return __perf_event_account_interrupt(event, 1);
+	return __perf_event_account_interrupt(event, 1, false);
 }
 
 /*
@@ -7727,7 +7735,7 @@ int perf_event_account_interrupt(struct perf_event *event)
 
 static int __perf_event_overflow(struct perf_event *event,
 				   int throttle, struct perf_sample_data *data,
-				   struct pt_regs *regs)
+				   struct pt_regs *regs, bool nowait)
 {
 	int events = atomic_read(&event->event_limit);
 	int ret = 0;
@@ -7739,7 +7747,7 @@ static int __perf_event_overflow(struct perf_event *event,
 	if (unlikely(!is_sampling_event(event)))
 		return 0;
 
-	ret = __perf_event_account_interrupt(event, throttle);
+	ret = __perf_event_account_interrupt(event, throttle, nowait);
 
 	/*
 	 * XXX event_limit might not quite work as expected on inherited
@@ -7768,7 +7776,7 @@ int perf_event_overflow(struct perf_event *event,
 			  struct perf_sample_data *data,
 			  struct pt_regs *regs)
 {
-	return __perf_event_overflow(event, 1, data, regs);
+	return __perf_event_overflow(event, 1, data, regs, true);
 }
 
 /*
@@ -7831,7 +7839,7 @@ static void perf_swevent_overflow(struct perf_event *event, u64 overflow,
 
 	for (; overflow; overflow--) {
 		if (__perf_event_overflow(event, throttle,
-					    data, regs)) {
+					    data, regs, false)) {
 			/*
 			 * We inhibit the overflow from happening when
 			 * hwc->interrupts == MAX_INTERRUPTS.
@@ -9110,7 +9118,7 @@ static enum hrtimer_restart perf_swevent_hrtimer(struct hrtimer *hrtimer)
 
 	if (regs && !perf_exclude_event(event, regs)) {
 		if (!(event->attr.exclude_idle && is_idle_task(current)))
-			if (__perf_event_overflow(event, 1, &data, regs))
+			if (__perf_event_overflow(event, 1, &data, regs, true))
 				ret = HRTIMER_NORESTART;
 	}
 
@@ -9141,7 +9149,7 @@ static void perf_swevent_start_hrtimer(struct perf_event *event)
 		      HRTIMER_MODE_REL_PINNED);
 }
 
-static void perf_swevent_cancel_hrtimer(struct perf_event *event)
+static void perf_swevent_cancel_hrtimer(struct perf_event *event, bool sync)
 {
 	struct hw_perf_event *hwc = &event->hw;
 
@@ -9149,7 +9157,10 @@ static void perf_swevent_cancel_hrtimer(struct perf_event *event)
 		ktime_t remaining = hrtimer_get_remaining(&hwc->hrtimer);
 		local64_set(&hwc->period_left, ktime_to_ns(remaining));
 
-		hrtimer_cancel(&hwc->hrtimer);
+		if (sync)
+			hrtimer_cancel(&hwc->hrtimer);
+		else
+			hrtimer_try_to_cancel(&hwc->hrtimer);
 	}
 }
 
@@ -9200,7 +9211,7 @@ static void cpu_clock_event_start(struct perf_event *event, int flags)
 
 static void cpu_clock_event_stop(struct perf_event *event, int flags)
 {
-	perf_swevent_cancel_hrtimer(event);
+	perf_swevent_cancel_hrtimer(event, flags & PERF_EF_NO_WAIT);
 	cpu_clock_event_update(event);
 }
 
@@ -9277,7 +9288,7 @@ static void task_clock_event_start(struct perf_event *event, int flags)
 
 static void task_clock_event_stop(struct perf_event *event, int flags)
 {
-	perf_swevent_cancel_hrtimer(event);
+	perf_swevent_cancel_hrtimer(event, flags & PERF_EF_NO_WAIT);
 	task_clock_event_update(event, event->ctx->time);
 }
 
-- 
2.14.4

