Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E98C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 21:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E225208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 21:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E225208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbeKLGyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:54:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeKLGyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:54:18 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B1EE7307D913;
        Sun, 11 Nov 2018 21:04:38 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-16.brq.redhat.com [10.40.204.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C57E55C20B;
        Sun, 11 Nov 2018 21:04:35 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Andi Kleen <andi@firstfloor.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 2/3] perf/cputime: Fix idle time on NO_HZ config
Date:   Sun, 11 Nov 2018 22:04:25 +0100
Message-Id: <20181111210426.28712-3-jolsa@kernel.org>
In-Reply-To: <20181111210426.28712-1-jolsa@kernel.org>
References: <20181111210426.28712-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Sun, 11 Nov 2018 21:04:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case there's NO_HZ enabled we won't get proper numbers
for idle counter if the tick is disabled on the cpu.

Making up for it by counting the idle counter value if
the tick is stopped, which will keep the counter number
updated at the time it is read.

Link: http://lkml.kernel.org/n/tip-rw8kylf86mkfv60blwu5iyqr@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/tick.h     |  1 +
 kernel/events/cputime.c  | 25 ++++++++++++++++++++++++-
 kernel/time/tick-sched.c | 11 +++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 55388ab45fd4..17aaaae18a3c 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -125,6 +125,7 @@ extern bool tick_nohz_idle_got_tick(void);
 extern ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next);
 extern unsigned long tick_nohz_get_idle_calls(void);
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
+extern unsigned long tick_nohz_get_idle_jiffies_cpu(int cpu);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
 extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
 
diff --git a/kernel/events/cputime.c b/kernel/events/cputime.c
index efad24543f13..c49e73713263 100644
--- a/kernel/events/cputime.c
+++ b/kernel/events/cputime.c
@@ -1,6 +1,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/sched.h>
 #include <linux/perf_event.h>
+#include <linux/tick.h>
 
 enum perf_cputime_id {
 	PERF_CPUTIME_USER,
@@ -102,11 +103,33 @@ static const struct attribute_group *cputime_attr_groups[] = {
 	NULL,
 };
 
+#ifdef CONFIG_NO_HZ_COMMON
+static u64 idle_fix(int cpu)
+{
+	u64 ticks;
+
+	if (!tick_nohz_tick_stopped_cpu(cpu))
+		return 0;
+
+	ticks = jiffies - tick_nohz_get_idle_jiffies_cpu(cpu);
+	return ticks * TICK_NSEC;
+}
+#else
+static u64 idle_fix(int cpu)
+{
+	return 0;
+}
+#endif
+
 static u64 cputime_read_counter(struct perf_event *event)
 {
 	int cpu = event->oncpu;
+	u64 val = kcpustat_cpu(cpu).cpustat[event->hw.config];
+
+	if (event->hw.config == PERF_CPUTIME_IDLE)
+		val += idle_fix(cpu);
 
-	return kcpustat_cpu(cpu).cpustat[event->hw.config];
+	return val;
 }
 
 static void perf_cputime_update(struct perf_event *event)
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 69e673b88474..c5df46e3c9f5 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1077,6 +1077,17 @@ unsigned long tick_nohz_get_idle_calls_cpu(int cpu)
 	return ts->idle_calls;
 }
 
+/**
+ * tick_nohz_get_idle_jiffies_cpu - return the current idle jiffies counter value
+ * for a particular CPU.
+ */
+unsigned long tick_nohz_get_idle_jiffies_cpu(int cpu)
+{
+	struct tick_sched *ts = tick_get_tick_sched(cpu);
+
+	return ts->idle_jiffies;
+}
+
 /**
  * tick_nohz_get_idle_calls - return the current idle calls counter value
  *
-- 
2.17.2

