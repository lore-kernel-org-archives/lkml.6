Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbeFERwQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:52:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752769AbeFERwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:52:11 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 30/46] perf sched: Use sched->show_callchain where appropriate
Date: Tue,  5 Jun 2018 14:50:14 -0300
Message-Id: <20180605175030.32549-31-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Instead of using symbol_conf.use_callchain, reducing its usage a bit
more.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-edgwb1b2mpbrdeg0w64wp7ms@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-sched.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 97f9e755e8e6..cbf39dab19c1 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2143,7 +2143,7 @@ static void save_task_callchain(struct perf_sched *sched,
 		return;
 	}
 
-	if (!symbol_conf.use_callchain || sample->callchain == NULL)
+	if (!sched->show_callchain || sample->callchain == NULL)
 		return;
 
 	if (thread__resolve_callchain(thread, cursor, evsel, sample,
@@ -2271,10 +2271,11 @@ static struct thread *get_idle_thread(int cpu)
 	return idle_threads[cpu];
 }
 
-static void save_idle_callchain(struct idle_thread_runtime *itr,
+static void save_idle_callchain(struct perf_sched *sched,
+				struct idle_thread_runtime *itr,
 				struct perf_sample *sample)
 {
-	if (!symbol_conf.use_callchain || sample->callchain == NULL)
+	if (!sched->show_callchain || sample->callchain == NULL)
 		return;
 
 	callchain_cursor__copy(&itr->cursor, &callchain_cursor);
@@ -2320,7 +2321,7 @@ static struct thread *timehist_get_thread(struct perf_sched *sched,
 
 			/* copy task callchain when entering to idle */
 			if (perf_evsel__intval(evsel, sample, "next_pid") == 0)
-				save_idle_callchain(itr, sample);
+				save_idle_callchain(sched, itr, sample);
 		}
 	}
 
@@ -2849,7 +2850,7 @@ static void timehist_print_summary(struct perf_sched *sched,
 			printf("    CPU %2d idle entire time window\n", i);
 	}
 
-	if (sched->idle_hist && symbol_conf.use_callchain) {
+	if (sched->idle_hist && sched->show_callchain) {
 		callchain_param.mode  = CHAIN_FOLDED;
 		callchain_param.value = CCVAL_PERIOD;
 
-- 
2.14.3
