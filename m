Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB6FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FBA20C01
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XADwoXr/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbfBZOyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:54:41 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38241 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbfBZOyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:54:38 -0500
Received: by mail-lj1-f193.google.com with SMTP id j19so11024133ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 06:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cHcnRnu2FIgTWtisqlvCscC0vHLrnc1MItOKTfTvXoU=;
        b=XADwoXr/kyyiMCzb9CS6DjwET0munxhbMQIwQFME2w8OCXzBvaWMH170NRncocFNPW
         X3IwkYXquWtD2FqzjNypn1QvdA7rhC0Sg2pfd2tAB07t2GK1sz4eeSlPq1ZSMerouLB/
         yL8xYGa3C8T1+P97PJKc85J9n3JhT1JffBZg2gW80U8pJoFeRkcqssL4pm6zAMO2NeE+
         yW0k2bLLZTbWiRsTJBgR0SZMbYTMLrLTASulOBpc7SS6P+0jyFj3qeCrkahnJLbwzeXv
         xrqwjvn5VSxFLH+8WtQk+CDKV2LnJKl/bQFJ2FpE6XkLYTYAMtvFOu6hw1idcP0G7FXW
         w8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cHcnRnu2FIgTWtisqlvCscC0vHLrnc1MItOKTfTvXoU=;
        b=MLOFfqQJ1LYXJmDJYF4q80YkiZbMU3OkuAwe1ygMPjTJVIKWZeGvnHemtwa88zdDT8
         8jVK0XsPTZG5AclvGifjN5tYyfLk5OdT3IbJwy5Wo1TSgJ8RAt4u7agqSFASv2S4epAT
         p8WROSMIfmi3T+sVw+sM3gxIchK21C+5lvdG4V38EYd0RZjWkSYmMENrueCICVBDfE3l
         9AvwEmTef+nXGjNO/wtgvPMVVCPN0p/3RcTQp5dKIVDXY1jvWbzubKEvsGrAoHVt8qy4
         TDLr4/6tgY9eaHM7ZqBlCr23dTeUgcR3yLIWS/TCWI0umWRKbJ3YX6cxCDqlhmQgenvm
         3Jpg==
X-Gm-Message-State: AHQUAuaEg2p4jug49u2r1Q+1UePsX2ESf6SiiOntMEkY0vtmipruXZFG
        3s2q/YwrrYaIvU/R/sbQzEjzzw==
X-Google-Smtp-Source: AHgI3IauEHmxkM6+fHc/XlZ7fBCCsrlb0JVEuV8nYLBMNV+/1LXzmHXaNCoZrVoDUKDl+bDaD0aZRg==
X-Received: by 2002:a2e:6c09:: with SMTP id h9mr13631068ljc.139.1551192875997;
        Tue, 26 Feb 2019 06:54:35 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id t11sm2206554ljj.92.2019.02.26.06.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 06:54:35 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 3/8] time: tick-sched: Provide helpers to get the next timer expiration
Date:   Tue, 26 Feb 2019 15:54:10 +0100
Message-Id: <20190226145415.19411-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190226145415.19411-1-ulf.hansson@linaro.org>
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>

In the power control path with the interrupts disabled, cpuidle governors
calls tick_nohz_get_sleep_length() to get the duration until the next timer
expires.

This is not always convenient when going forward, as the duration is a
relative time to "now". To make it more flexible, let's instead provide two
new functions tick_nohz_get_next_timer|hrtimer(), which provides the actual
time for when the next timer is about to expire. The computation of the
duration can then be done by the caller.

For now, leave tick_nohz_get_sleep_length() as is. When users of it has
converted to the new APIs, then we can remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
[Ulf: Clarified information in changelog]
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v11:
	- New patch, replace "timer: Export next wakeup time of a CPU" from v10.

---
 include/linux/tick.h     |  7 +++++
 kernel/time/tick-sched.c | 68 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 55388ab45fd4..5b10a0e4acbb 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -111,6 +111,8 @@ enum tick_dep_bits {
 #define TICK_DEP_MASK_SCHED		(1 << TICK_DEP_BIT_SCHED)
 #define TICK_DEP_MASK_CLOCK_UNSTABLE	(1 << TICK_DEP_BIT_CLOCK_UNSTABLE)
 
+extern ktime_t tick_nohz_get_next_hrtimer(void);
+
 #ifdef CONFIG_NO_HZ_COMMON
 extern bool tick_nohz_enabled;
 extern bool tick_nohz_tick_stopped(void);
@@ -123,6 +125,7 @@ extern void tick_nohz_idle_exit(void);
 extern void tick_nohz_irq_exit(void);
 extern bool tick_nohz_idle_got_tick(void);
 extern ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next);
+extern ktime_t tick_nohz_get_next_timer(void);
 extern unsigned long tick_nohz_get_idle_calls(void);
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
@@ -145,6 +148,10 @@ static inline void tick_nohz_idle_restart_tick(void) { }
 static inline void tick_nohz_idle_enter(void) { }
 static inline void tick_nohz_idle_exit(void) { }
 static inline bool tick_nohz_idle_got_tick(void) { return false; }
+static inline ktime_t tick_nohz_get_next_timer(void)
+{
+	return tick_nohz_get_next_hrtimer();
+}
 
 static inline ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 {
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 6fa52cd6df0b..9966be665074 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -443,6 +443,20 @@ void __init tick_nohz_init(void)
 }
 #endif
 
+/**
+ * tick_nohz_get_next_hrtimer - return the expected deadline for the
+ * next hrtimer
+ *
+ * Called from power state control code with interrupts disabled
+ *
+ * Returns a ktime_t based value giving the next deadline for the tick
+ * or an earlier hrtimer
+ */
+ktime_t tick_nohz_get_next_hrtimer(void)
+{
+	return __this_cpu_read(tick_cpu_device.evtdev)->next_event;
+}
+
 /*
  * NOHZ - aka dynamic tick functionality
  */
@@ -918,7 +932,7 @@ static void __tick_nohz_idle_stop_tick(struct tick_sched *ts)
 	int cpu = smp_processor_id();
 
 	/*
-	 * If tick_nohz_get_sleep_length() ran tick_nohz_next_event(), the
+	 * If tick_nohz_get_next_timer() ran tick_nohz_next_event(), the
 	 * tick timer expiration time is known already.
 	 */
 	if (ts->timer_expires_base)
@@ -1022,6 +1036,58 @@ bool tick_nohz_idle_got_tick(void)
 	return false;
 }
 
+/**
+ * tick_nohz_get_next_timer - return the earliest timer deadline
+ *
+ * Called from power state control code with interrupts disabled
+ *
+ * Returns a ktime_t based value giving the earliest timer
+ */
+ktime_t tick_nohz_get_next_timer(void)
+{
+
+	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
+	ktime_t next_tick, next_timer, next_hrtimer;
+	int cpu = smp_processor_id();
+
+	/*
+	 * Actually the function returns the next hrtimer which can
+	 * be the next tick or another hrtimer expiring before the tick.
+	 */
+	next_tick = tick_nohz_get_next_hrtimer();
+
+	/*
+	 * If we can not stop the tick, then in any case the next
+	 * timer is the earliest one expiring with the hrtimer.
+	 */
+	if (!can_stop_idle_tick(cpu, ts))
+		return next_tick;
+
+	/*
+	 * Get the next low resolution timer led by the hrtimer. If
+	 * there is no timer in this case, then we can rely on the
+	 * hrtimer next event only coming from the call above.
+	 */
+	next_timer = tick_nohz_next_event(ts, cpu);
+	if (!next_timer)
+		return next_tick;
+
+	/*
+	 * This function will return the next timer after the
+	 * sched_timer aka the tick. We know there is another hrtimer
+	 * because the tick_nohz_next_event() returned a non zero
+	 * deadline and we need a tick to make the lowres to expire.
+	 */
+	next_hrtimer = hrtimer_next_event_without(&ts->sched_timer);
+
+	/*
+	 * At this point, we have the next lowres timer and the next
+	 * hrtimer which is not the tick. We need to figure out which
+	 * one expires first.
+	 */
+	return min_t(u64, next_hrtimer, next_timer);
+}
+
 /**
  * tick_nohz_get_sleep_length - return the expected length of the current sleep
  * @delta_next: duration until the next event if the tick cannot be stopped
-- 
2.17.1

