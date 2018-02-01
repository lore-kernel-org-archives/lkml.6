Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbeBAIib (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 03:38:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37472 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751910AbeBAIiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 03:38:23 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 2/3] perf record: Fix period option handling
Date: Thu,  1 Feb 2018 09:38:11 +0100
Message-Id: <20180201083812.11359-3-jolsa@kernel.org>
In-Reply-To: <20180201083812.11359-1-jolsa@kernel.org>
References: <20180201083812.11359-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan reported we don't unset PERIOD sample type
when --no-period is specified. Adding the unset
check and reset PERIOD if --no-period is specified.

Reported-by: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/n/tip-b89ggszz9x26hm7ztor29b0s@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c |  3 ++-
 tools/perf/perf.h           |  1 +
 tools/perf/util/evsel.c     | 11 ++++++++---
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f251e824edac..907267206973 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1566,7 +1566,8 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN_SET('T', "timestamp", &record.opts.sample_time,
 			&record.opts.sample_time_set,
 			"Record the sample timestamps"),
-	OPT_BOOLEAN('P', "period", &record.opts.period, "Record the sample period"),
+	OPT_BOOLEAN_SET('P', "period", &record.opts.period, &record.opts.period_set,
+			"Record the sample period"),
 	OPT_BOOLEAN('n', "no-samples", &record.opts.no_samples,
 		    "don't sample"),
 	OPT_BOOLEAN_SET('N', "no-buildid-cache", &record.no_buildid_cache,
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 2357f4ccc9c7..cfe46236a5e5 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -50,6 +50,7 @@ struct record_opts {
 	bool	     sample_time_set;
 	bool	     sample_cpu;
 	bool	     period;
+	bool	     period_set;
 	bool	     running_time;
 	bool	     full_auxtrace;
 	bool	     auxtrace_snapshot_mode;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f2f2eaafde6d..ff359c9ece2e 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -971,9 +971,6 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 	if (target__has_cpu(&opts->target) || opts->sample_cpu)
 		perf_evsel__set_sample_bit(evsel, CPU);
 
-	if (opts->period)
-		perf_evsel__set_sample_bit(evsel, PERIOD);
-
 	/*
 	 * When the user explicitly disabled time don't force it here.
 	 */
@@ -1075,6 +1072,14 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 	apply_config_terms(evsel, opts, track);
 
 	evsel->ignore_missing_thread = opts->ignore_missing_thread;
+
+	/* The --period option takes the precedence. */
+	if (opts->period_set) {
+		if (opts->period)
+			perf_evsel__set_sample_bit(evsel, PERIOD);
+		else
+			perf_evsel__reset_sample_bit(evsel, PERIOD);
+	}
 }
 
 static int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
-- 
2.13.6
