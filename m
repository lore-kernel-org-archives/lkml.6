Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752123AbeBEVlE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 16:41:04 -0500
Received: from terminus.zytor.com ([65.50.211.136]:35461 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752555AbeBEVkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 16:40:52 -0500
Date: Mon, 5 Feb 2018 13:36:26 -0800
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-f290aa1ffa45ed7e37599840878b4dae68269ee1@git.kernel.org>
Cc: jolsa@kernel.org, namhyung@kernel.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, peterz@infradead.org, tglx@linutronix.de,
        acme@redhat.com, mingo@kernel.org, alexander.shishkin@linux.intel.com,
        dsahern@gmail.com, eranian@google.com, ak@linux.intel.com
Reply-To: tglx@linutronix.de, namhyung@kernel.org, jolsa@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        eranian@google.com, ak@linux.intel.com, mingo@kernel.org,
        acme@redhat.com, dsahern@gmail.com, alexander.shishkin@linux.intel.com
In-Reply-To: <20180201083812.11359-3-jolsa@kernel.org>
References: <20180201083812.11359-3-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf record: Fix period option handling
Git-Commit-ID: f290aa1ffa45ed7e37599840878b4dae68269ee1
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f290aa1ffa45ed7e37599840878b4dae68269ee1
Gitweb:     https://git.kernel.org/tip/f290aa1ffa45ed7e37599840878b4dae68269ee1
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 1 Feb 2018 09:38:11 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Feb 2018 12:18:28 -0300

perf record: Fix period option handling

Stephan reported we don't unset PERIOD sample type when --no-period is
specified. Adding the unset check and reset PERIOD if --no-period is
specified.

Committer notes:

Check the sample_type, it shouldn't have PERF_SAMPLE_PERIOD there when
--no-period is used.

Before:

  # perf record --no-period sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.018 MB perf.data (7 samples) ]
  # perf evlist -v
  cycles:ppp: size: 112, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|PERIOD, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1
  #

After:

[root@jouet ~]# perf record --no-period sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.019 MB perf.data (17 samples) ]
[root@jouet ~]# perf evlist -v
cycles:ppp: size: 112, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1
[root@jouet ~]#

Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Stephane Eranian <eranian@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180201083812.11359-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c |  3 ++-
 tools/perf/perf.h           |  1 +
 tools/perf/util/evsel.c     | 11 ++++++++---
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 65681a1..bf4ca74 100644
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
index 2357f4cc..cfe4623 100644
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
index f2f2eaa..ff359c9 100644
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
