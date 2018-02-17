Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751092AbeBQLaU (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:30:20 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42155 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751065AbeBQLaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:30:18 -0500
Date: Sat, 17 Feb 2018 03:19:56 -0800
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-3233b37a71c794e25a0a794185df8d6abd9f277e@git.kernel.org>
Cc: acme@redhat.com, tglx@linutronix.de, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, peterz@infradead.org,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        mingo@kernel.org, dsahern@gmail.com
Reply-To: namhyung@kernel.org, peterz@infradead.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, tglx@linutronix.de,
        acme@redhat.com, dsahern@gmail.com, mingo@kernel.org,
        alexander.shishkin@linux.intel.com
In-Reply-To: <20180206181813.10943-4-jolsa@kernel.org>
References: <20180206181813.10943-4-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf script: Add --show-round-event to display
 PERF_RECORD_FINISHED_ROUND
Git-Commit-ID: 3233b37a71c794e25a0a794185df8d6abd9f277e
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

Commit-ID:  3233b37a71c794e25a0a794185df8d6abd9f277e
Gitweb:     https://git.kernel.org/tip/3233b37a71c794e25a0a794185df8d6abd9f277e
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Tue, 6 Feb 2018 19:17:59 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 10:09:23 -0300

perf script: Add --show-round-event to display PERF_RECORD_FINISHED_ROUND

Adding --show-round-event to display PERF_RECORD_FINISHED_ROUND events
like:

  # perf script --show-round-events 2>/dev/null
               yes  8591 [002] 124177.397597:         18         cpu/mem-stores/P: ff...
               yes  8591 [002] 124177.397615:          1 cpu/mem-loads,ldlat=30/P: ff...
  PERF_RECORD_FINISHED_ROUND
              perf 10380 [001] 124177.397622:          6 cpu/mem-loads,ldlat=30/P: ff...
  PERF_RECORD_FINISHED_ROUND
           swapper     0 [000] 124177.400518:         88         cpu/mem-stores/P: ff...
           swapper     0 [000] 124177.400521:         88         cpu/mem-stores/P: ff...

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180206181813.10943-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-script.txt |  3 +++
 tools/perf/builtin-script.c              | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 7730c1d..36ec025 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -303,6 +303,9 @@ OPTIONS
 --show-lost-events
 	Display lost events i.e. events of type PERF_RECORD_LOST.
 
+--show-round-events
+	Display finished round events i.e. events of type PERF_RECORD_FINISHED_ROUND.
+
 --demangle::
 	Demangle symbol names to human readable form. It's enabled by default,
 	disable with --no-demangle.
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index ab19a6e..cce926a 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1489,6 +1489,7 @@ struct perf_script {
 	bool			show_switch_events;
 	bool			show_namespace_events;
 	bool			show_lost_events;
+	bool			show_round_events;
 	bool			allocated;
 	bool			per_event_dump;
 	struct cpu_map		*cpus;
@@ -2104,6 +2105,16 @@ process_lost_event(struct perf_tool *tool,
 	return 0;
 }
 
+static int
+process_finished_round_event(struct perf_tool *tool __maybe_unused,
+			     union perf_event *event,
+			     struct ordered_events *oe __maybe_unused)
+
+{
+	perf_event__fprintf(event, stdout);
+	return 0;
+}
+
 static void sig_handler(int sig __maybe_unused)
 {
 	session_done = 1;
@@ -2200,6 +2211,10 @@ static int __cmd_script(struct perf_script *script)
 		script->tool.namespaces = process_namespaces_event;
 	if (script->show_lost_events)
 		script->tool.lost = process_lost_event;
+	if (script->show_round_events) {
+		script->tool.ordered_events = false;
+		script->tool.finished_round = process_finished_round_event;
+	}
 
 	if (perf_script__setup_per_event_dump(script)) {
 		pr_err("Couldn't create the per event dump files\n");
@@ -3139,6 +3154,8 @@ int cmd_script(int argc, const char **argv)
 		    "Show namespace events (if recorded)"),
 	OPT_BOOLEAN('\0', "show-lost-events", &script.show_lost_events,
 		    "Show lost events (if recorded)"),
+	OPT_BOOLEAN('\0', "show-round-events", &script.show_round_events,
+		    "Show round events (if recorded)"),
 	OPT_BOOLEAN('\0', "per-event-dump", &script.per_event_dump,
 		    "Dump trace output to files named by the monitored events"),
 	OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do it"),
