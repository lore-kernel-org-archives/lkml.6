Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id u0azK/xcGFvkJAAAmS7hNA
	; Wed, 06 Jun 2018 22:16:17 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E53866089E; Wed,  6 Jun 2018 22:16:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6CA3A605BD;
	Wed,  6 Jun 2018 22:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6CA3A605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752997AbeFFWQO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 18:16:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752854AbeFFWPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 18:15:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0F4A3407574B;
        Wed,  6 Jun 2018 22:15:42 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-89.brq.redhat.com [10.40.204.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1AABF2026DEF;
        Wed,  6 Jun 2018 22:15:39 +0000 (UTC)
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Andi Kleen <andi@firstfloor.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 09/10] perf/cputime: Don't stop idle tick if there's live cputime event
Date: Thu,  7 Jun 2018 00:15:12 +0200
Message-Id: <20180606221513.11302-10-jolsa@kernel.org>
In-Reply-To: <20180606221513.11302-1-jolsa@kernel.org>
References: <20180606221513.11302-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 06 Jun 2018 22:15:42 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 06 Jun 2018 22:15:42 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable stopping of the idle tick when having live cputime
event. When the tick is disabled, the idle counts are out
of date until next tick/update and perf cputime PMU provides
misleading counts.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/perf_event.h |  1 +
 kernel/events/cputime.c    | 13 +++++++++++++
 kernel/time/tick-sched.c   |  4 ++++
 3 files changed, 18 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index aa9eaab370be..ba61d2f9602a 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1407,4 +1407,5 @@ int perf_event_exit_cpu(unsigned int cpu);
 #define perf_event_exit_cpu	NULL
 #endif
 
+bool has_cputime_event(int cpu);
 #endif /* _LINUX_PERF_EVENT_H */
diff --git a/kernel/events/cputime.c b/kernel/events/cputime.c
index efad24543f13..32d3cde0047e 100644
--- a/kernel/events/cputime.c
+++ b/kernel/events/cputime.c
@@ -1,6 +1,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/sched.h>
 #include <linux/perf_event.h>
+#include <linux/tick.h>
 
 enum perf_cputime_id {
 	PERF_CPUTIME_USER,
@@ -16,6 +17,13 @@ enum perf_cputime_id {
 	PERF_CPUTIME_MAX,
 };
 
+static DEFINE_PER_CPU(int, has_cputime);
+
+bool has_cputime_event(int cpu)
+{
+	return per_cpu(has_cputime, cpu) != 0;
+}
+
 static enum cpu_usage_stat map[PERF_CPUTIME_MAX] = {
 	[PERF_CPUTIME_USER]		= CPUTIME_USER,
 	[PERF_CPUTIME_NICE]		= CPUTIME_NICE,
@@ -143,12 +151,17 @@ static int cputime_event_add(struct perf_event *event, int flags)
 	if (flags & PERF_EF_START)
 		cputime_event_start(event, flags);
 
+	if (event->hw.config == PERF_CPUTIME_IDLE)
+		tick_nohz_idle_restart_tick();
+
+	this_cpu_inc(has_cputime);
 	return 0;
 }
 
 static void cputime_event_del(struct perf_event *event, int flags)
 {
 	cputime_event_stop(event, PERF_EF_UPDATE);
+	this_cpu_dec(has_cputime);
 }
 
 static void perf_cputime_read(struct perf_event *event)
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index da9455a6b42b..1c105bc2a92e 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -28,6 +28,7 @@
 #include <linux/posix-timers.h>
 #include <linux/context_tracking.h>
 #include <linux/mm.h>
+#include <linux/perf_event.h>
 
 #include <asm/irq_regs.h>
 
@@ -912,6 +913,9 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 			return false;
 	}
 
+	if (has_cputime_event(cpu))
+		return false;
+
 	return true;
 }
 
-- 
2.13.6
