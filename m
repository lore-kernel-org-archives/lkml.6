Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89ED5C169D4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B902213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CxUDChM/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B902213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbeK3Ex0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:53:26 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39219 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730751AbeK3ExZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:53:25 -0500
Received: by mail-lf1-f65.google.com with SMTP id n18so2100490lfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=We8CaGvJmbhYNYzrL7xua655X98bhiXXYfxMtnIUbcg=;
        b=CxUDChM/RBvhrA31XzUsCNP+4FezP+eXEflQmQnd54XH4DLPYar6y05JtbZh1VkOR9
         SkqR/CZFgNzntsxd4Oe81r1RyldMKKKEpGM2IwKlpysWwwEyVbXW691jkPCx5rLzQP/r
         x2cpT4wVVole1llA1ynH/xIBV8qW3U8BBRoCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=We8CaGvJmbhYNYzrL7xua655X98bhiXXYfxMtnIUbcg=;
        b=nBUgFg/RBPXNFnfQ5w38riUbZkpWEs9rAq7XeBZ3JFYhOFUYSxTMk6cTXR0DgH6mt4
         wRUZWxS7Hcc2KxY5+Z4dd9cm1HOpMhuX9ZArmgtj/UFi7rFmiCzV12iwJxRrGsNEIj2+
         HgIzg6cA/AiTanoVLwjfzU8LFwXPBtSaAcaYwi4sw1mFKMDfDXwcoC90BvGybAEIeSMU
         P3Bk3aOMHQtEKutCWmy7dmUwQIC2AddD8Qu0Nl+iwd48aOSGNRw++UCnzH3eF9eh794A
         XpHRXLnX76+L2FqXf9m9wlWQbyduuXD4i3tcLTyKBN++03SitI7XWNGorKI64GfGzQLo
         YKgg==
X-Gm-Message-State: AA+aEWY4nT36VzCXNxY8W5J2mA19bN41b/iw4r4N7vVJ/QHpFjmNY5aA
        8ZwjALgiKcFZOumvJPFPfuG8qA==
X-Google-Smtp-Source: AFSGD/X5ijktJZyrJe4NVc5D4Xj3iZjspHtp3e2YPqQ10kRYH3SesOqeSLOZT9YaqgkfpSVEiZRWsQ==
X-Received: by 2002:a19:6806:: with SMTP id d6mr1607974lfc.48.1543513633779;
        Thu, 29 Nov 2018 09:47:13 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:47:13 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lina Iyer <lina.iyer@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v10 03/27] timer: Export next wakeup time of a CPU
Date:   Thu, 29 Nov 2018 18:46:36 +0100
Message-Id: <20181129174700.16585-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lina Iyer <lina.iyer@linaro.org>

Knowing the sleep duration of CPUs, is known to be needed while selecting
the most energy efficient idle state for a CPU or a group of CPUs.

However, to be able to compute the sleep duration, we need to know at what
time the next expected wakeup is for the CPU. Therefore, let's export this
information via a new function, tick_nohz_get_next_wakeup(). Following
changes make use of it.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- Updated function header of tick_nohz_get_next_wakeup().

---
 include/linux/tick.h     |  8 ++++++++
 kernel/time/tick-sched.c | 13 +++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 55388ab45fd4..e48f6b26b425 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -125,6 +125,7 @@ extern bool tick_nohz_idle_got_tick(void);
 extern ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next);
 extern unsigned long tick_nohz_get_idle_calls(void);
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
+extern ktime_t tick_nohz_get_next_wakeup(int cpu);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
 extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
 
@@ -151,6 +152,13 @@ static inline ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 	*delta_next = TICK_NSEC;
 	return *delta_next;
 }
+
+static inline ktime_t tick_nohz_get_next_wakeup(int cpu)
+{
+	/* Next wake up is the tick period, assume it starts now */
+	return ktime_add(ktime_get(), TICK_NSEC);
+}
+
 static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
 static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
 
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 69e673b88474..7a9166506503 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1089,6 +1089,19 @@ unsigned long tick_nohz_get_idle_calls(void)
 	return ts->idle_calls;
 }
 
+/**
+ * tick_nohz_get_next_wakeup - return the next wake up of the CPU
+ * @cpu: the particular CPU to get next wake up for
+ *
+ * Called for idle CPUs only.
+ */
+ktime_t tick_nohz_get_next_wakeup(int cpu)
+{
+	struct clock_event_device *dev = per_cpu(tick_cpu_device.evtdev, cpu);
+
+	return dev->next_event;
+}
+
 static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
 {
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
-- 
2.17.1

