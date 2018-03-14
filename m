Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752252AbeCNQ7U (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:59:20 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33764 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751914AbeCNQ7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:59:14 -0400
X-Google-Smtp-Source: AG47ELta2xPQQqOJ4ft2qVMM/qrfsr9FGkw9wauIscYNQrkxUVDFxvnwmS4WS3QxkP0Jby2ISTjrwQ==
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 06/25] timer: Export next wakeup time of a CPU
Date: Wed, 14 Mar 2018 17:58:16 +0100
Message-Id: <1521046715-30683-7-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
References: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
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
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/tick.h     | 10 ++++++++++
 kernel/time/tick-sched.c | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 7cc3592..e51cf2c 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -120,6 +120,7 @@ extern void tick_nohz_irq_exit(void);
 extern ktime_t tick_nohz_get_sleep_length(void);
 extern unsigned long tick_nohz_get_idle_calls(void);
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
+extern ktime_t tick_nohz_get_next_wakeup(int cpu);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
 extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
 #else /* !CONFIG_NO_HZ_COMMON */
@@ -132,6 +133,15 @@ static inline ktime_t tick_nohz_get_sleep_length(void)
 {
 	return NSEC_PER_SEC / HZ;
 }
+
+static inline ktime_t tick_nohz_get_next_wakeup(int cpu)
+{
+	ktime_t len = NSEC_PER_SEC/HZ;
+
+	/* Next wake up is the tick period, assume it starts now */
+	return ktime_add(len, ktime_get());
+}
+
 static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
 static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
 #endif /* !CONFIG_NO_HZ_COMMON */
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 29a5733..da1bff3 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1025,6 +1025,17 @@ unsigned long tick_nohz_get_idle_calls(void)
 	return ts->idle_calls;
 }
 
+/**
+ * tick_nohz_get_next_wakeup - return the next wake up of the CPU
+ */
+ktime_t tick_nohz_get_next_wakeup(int cpu)
+{
+	struct clock_event_device *dev =
+			per_cpu(tick_cpu_device.evtdev, cpu);
+
+	return dev->next_event;
+}
+
 static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
 {
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
-- 
2.7.4
