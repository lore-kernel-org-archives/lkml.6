Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165192AbeE1NGJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:06:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163789AbeE1Kw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:52:26 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 216/496] perf record: Fix crash in pipe mode
Date: Mon, 28 May 2018 12:00:01 +0200
Message-Id: <20180528100329.030788184@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit ad46e48c65fa1f204fa29eaff1b91174d314a94b ]

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
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180302161354.30192-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/builtin-record.c |    9 +++++++++
 tools/perf/perf.h           |    1 +
 tools/perf/util/record.c    |    8 ++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -926,6 +926,15 @@ static int __cmd_record(struct record *r
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
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -137,6 +137,7 @@ void perf_evlist__config(struct perf_evl
 	struct perf_evsel *evsel;
 	bool use_sample_identifier = false;
 	bool use_comm_exec;
+	bool sample_id = opts->sample_id;
 
 	/*
 	 * Set the evsel leader links before we configure attributes,
@@ -163,8 +164,7 @@ void perf_evlist__config(struct perf_evl
 		 * match the id.
 		 */
 		use_sample_identifier = perf_can_sample_identifier();
-		evlist__for_each_entry(evlist, evsel)
-			perf_evsel__set_sample_id(evsel, use_sample_identifier);
+		sample_id = true;
 	} else if (evlist->nr_entries > 1) {
 		struct perf_evsel *first = perf_evlist__first(evlist);
 
@@ -174,6 +174,10 @@ void perf_evlist__config(struct perf_evl
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
