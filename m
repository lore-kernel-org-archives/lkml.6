Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3738DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1AF20C01
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n7uIvug2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbfBZOyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:54:44 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33688 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbfBZOym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:54:42 -0500
Received: by mail-lj1-f196.google.com with SMTP id z7so10843911lji.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 06:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7Kl3KIsTbVNnLIJETkqUkswPckk4QEkcaiOEMLrmE0U=;
        b=n7uIvug2vs/kr0RJhQcdk7BSHrob5nvRXyL0xNSxYnHFnnMKjuMDRuby6EvZhP8bIQ
         sEYAZFh2urn9DNVCLN5raj4+lCcuGxSZHrQSdsISgzZi+LnkU7Y9EAiAT0yLLDsNv/91
         yJK71O7bWyCWWNnL5495Puaw0fpepx6aL4venBxoepro1Y72A1ytEOBcfjDqI48F+zmU
         Oh1P6GO0N+LiCwNlB7ssEj9oyJ9A9Oa1ROLwtEV+BbUuGmXb+kMWjx22hoV7q+XLdaOA
         3CjmUKkM6RiMFGcf6nXNVb/hmr2vZCCmETUMiDFJ59GXm/VtpI8sEPIBPKj33vsL/sPW
         sPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7Kl3KIsTbVNnLIJETkqUkswPckk4QEkcaiOEMLrmE0U=;
        b=eoix9fNX8uyk+mwyJ1Le9+tpjxw2kjhFTx64ldCzqsmJgazZ7xLH7VyKPnwq16V5um
         qpCMH0cWJn7sg2BXW2//gj8wGuW9KXNvzFGDqU27/HQeWZA70JtTkHH4bmLsK+5W9sfF
         n6yjn47KcnCG9xopgLpKg1FV3rIp/4THm0Vc1n1W2tY9bf2S1KgkBYONgtz8MNiTAwYI
         qZ5kDMc8QkxEPPUP9/5gmqfLr7MrWcVprvl8xWomusZlLO1I9ku9lqxBMGSyvoFbEd/W
         KYb9IxYUVNmz8rKaXixXxUCjQhGPqFkaaJOE/AWAcfRQ6qcwvP2CuY7ZSzR13mhua45K
         M62Q==
X-Gm-Message-State: AHQUAuaY5vWn4Ssksa0g7NyJm4JdVwJWU3vIrprBjETYSoqizaHIZY5O
        b1Z69HyPbdzSAZnzcL0FZDmAnA==
X-Google-Smtp-Source: AHgI3IatimNXxbZ0UlAUMjP41vSG7rroGtk09LV0giyDGyOxLDbucKAoH6kRcU7fitCx8KE+Ma61NQ==
X-Received: by 2002:a2e:4285:: with SMTP id h5mr13819746ljf.32.1551192880350;
        Tue, 26 Feb 2019 06:54:40 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id t11sm2206554ljj.92.2019.02.26.06.54.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 06:54:39 -0800 (PST)
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
Subject: [PATCH v11 6/8] time: tick-sched: Remove tick_nohz_get_sleep_length()
Date:   Tue, 26 Feb 2019 15:54:13 +0100
Message-Id: <20190226145415.19411-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190226145415.19411-1-ulf.hansson@linaro.org>
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>

There are no longer any users of tick_nohz_get_sleep_length(), so let's
drop it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
[Ulf: Clarified information in changelog]
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v11:
	- New patch.

---
 include/linux/tick.h     |  6 ------
 kernel/time/tick-sched.c | 39 ---------------------------------------
 2 files changed, 45 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 5b10a0e4acbb..1a0158736072 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -124,7 +124,6 @@ extern void tick_nohz_idle_enter(void);
 extern void tick_nohz_idle_exit(void);
 extern void tick_nohz_irq_exit(void);
 extern bool tick_nohz_idle_got_tick(void);
-extern ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next);
 extern ktime_t tick_nohz_get_next_timer(void);
 extern unsigned long tick_nohz_get_idle_calls(void);
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
@@ -153,11 +152,6 @@ static inline ktime_t tick_nohz_get_next_timer(void)
 	return tick_nohz_get_next_hrtimer();
 }
 
-static inline ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
-{
-	*delta_next = TICK_NSEC;
-	return *delta_next;
-}
 static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
 static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
 
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 9966be665074..a376c7db26ce 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1088,45 +1088,6 @@ ktime_t tick_nohz_get_next_timer(void)
 	return min_t(u64, next_hrtimer, next_timer);
 }
 
-/**
- * tick_nohz_get_sleep_length - return the expected length of the current sleep
- * @delta_next: duration until the next event if the tick cannot be stopped
- *
- * Called from power state control code with interrupts disabled
- */
-ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
-{
-	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
-	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
-	int cpu = smp_processor_id();
-	/*
-	 * The idle entry time is expected to be a sufficient approximation of
-	 * the current time at this point.
-	 */
-	ktime_t now = ts->idle_entrytime;
-	ktime_t next_event;
-
-	WARN_ON_ONCE(!ts->inidle);
-
-	*delta_next = ktime_sub(dev->next_event, now);
-
-	if (!can_stop_idle_tick(cpu, ts))
-		return *delta_next;
-
-	next_event = tick_nohz_next_event(ts, cpu);
-	if (!next_event)
-		return *delta_next;
-
-	/*
-	 * If the next highres timer to expire is earlier than next_event, the
-	 * idle governor needs to know that.
-	 */
-	next_event = min_t(u64, next_event,
-			   hrtimer_next_event_without(&ts->sched_timer));
-
-	return ktime_sub(next_event, now);
-}
-
 /**
  * tick_nohz_get_idle_calls_cpu - return the current idle calls counter value
  * for a particular CPU.
-- 
2.17.1

