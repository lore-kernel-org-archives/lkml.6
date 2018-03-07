Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754208AbeCGI0f (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 03:26:35 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42535 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbeCGI0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 03:26:32 -0500
Date: Wed, 7 Mar 2018 00:26:11 -0800
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-cfacbabd1d9c35d2a179650b2911f17a8d8620b8@git.kernel.org>
Cc: jolsa@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
        namhyung@kernel.org, hpa@zytor.com, alexander.shishkin@linux.intel.com,
        acme@redhat.com, tglx@linutronix.de, dsahern@gmail.com,
        mingo@kernel.org
Reply-To: mingo@kernel.org, dsahern@gmail.com,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        acme@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, namhyung@kernel.org, peterz@infradead.org
In-Reply-To: <20180302161354.30192-1-jolsa@kernel.org>
References: <20180302161354.30192-1-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf record: Fix crash in pipe mode
Git-Commit-ID: cfacbabd1d9c35d2a179650b2911f17a8d8620b8
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

Commit-ID:  cfacbabd1d9c35d2a179650b2911f17a8d8620b8
Gitweb:     https://git.kernel.org/tip/cfacbabd1d9c35d2a179650b2911f17a8d8620b8
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 2 Mar 2018 17:13:54 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Mar 2018 11:52:41 -0300

perf record: Fix crash in pipe mode

Currently we can crash perf record when running in pipe mode, like:

  $ perf record ls | perf report
  # To display the perf.data header info, please use --header/--header-only options.
  #
  perf: Segmentation fault
  Error:
  The - file has no samples!

The callstack of the crash is:

    0x0000000000515242 in perf_event__synthesize_event_update_name
  3513            ev = event_update_event__new(len + 1, PERF_EVENT_UPDATE__NAME, evsel->id[0]);
  (gdb) bt
  #0  0x0000000000515242 in perf_event__synthesize_event_update_name
  #1  0x00000000005158a4 in perf_event__synthesize_extra_attr
  #2  0x0000000000443347 in record__synthesize
  #3  0x00000000004438e3 in __cmd_record
  #4  0x000000000044514e in cmd_record
  #5  0x00000000004cbc95 in run_builtin
  #6  0x00000000004cbf02 in handle_internal_command
  #7  0x00000000004cc054 in run_argv
  #8  0x00000000004cc422 in main

The reason of the crash is that the evsel does not have ids array
allocated and the pipe's synthesize code tries to access it.

We don't force evsel ids allocation when we have single event, because
it's not needed. However we need it when we are in pipe mode even for
single event as a key for evsel update event.

Fixing this by forcing evsel ids allocation event for single event, when
we are in pipe mode.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180302161354.30192-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 9 +++++++++
 tools/perf/perf.h           | 1 +
 tools/perf/util/record.c    | 8 ++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index bf4ca749d1ac..a217623fec2e 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -881,6 +881,15 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		}
 	}
 
+	/*
+	 * If we have just single event and are sending data
+	 * through pipe, we need to force the ids allocation,
+	 * because we synthesize event name through the pipe
+	 * and need the id for that.
+	 */
+	if (data->is_pipe && rec->evlist->nr_entries == 1)
+		rec->opts.sample_id = true;
+
 	if (record__open(rec) != 0) {
 		err = -1;
 		goto out_child;
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index cfe46236a5e5..57b9b342d533 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -61,6 +61,7 @@ struct record_opts {
 	bool	     tail_synthesize;
 	bool	     overwrite;
 	bool	     ignore_missing_thread;
+	bool	     sample_id;
 	unsigned int freq;
 	unsigned int mmap_pages;
 	unsigned int auxtrace_mmap_pages;
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 1e97937b03a9..6f09e4962dad 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -137,6 +137,7 @@ void perf_evlist__config(struct perf_evlist *evlist, struct record_opts *opts,
 	struct perf_evsel *evsel;
 	bool use_sample_identifier = false;
 	bool use_comm_exec;
+	bool sample_id = opts->sample_id;
 
 	/*
 	 * Set the evsel leader links before we configure attributes,
@@ -163,8 +164,7 @@ void perf_evlist__config(struct perf_evlist *evlist, struct record_opts *opts,
 		 * match the id.
 		 */
 		use_sample_identifier = perf_can_sample_identifier();
-		evlist__for_each_entry(evlist, evsel)
-			perf_evsel__set_sample_id(evsel, use_sample_identifier);
+		sample_id = true;
 	} else if (evlist->nr_entries > 1) {
 		struct perf_evsel *first = perf_evlist__first(evlist);
 
@@ -174,6 +174,10 @@ void perf_evlist__config(struct perf_evlist *evlist, struct record_opts *opts,
 			use_sample_identifier = perf_can_sample_identifier();
 			break;
 		}
+		sample_id = true;
+	}
+
+	if (sample_id) {
 		evlist__for_each_entry(evlist, evsel)
 			perf_evsel__set_sample_id(evsel, use_sample_identifier);
 	}
