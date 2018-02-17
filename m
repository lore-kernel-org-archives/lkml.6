Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751300AbeBQLdZ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:33:25 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42563 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbeBQLdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:33:24 -0500
Date: Sat, 17 Feb 2018 03:23:03 -0800
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-ad52b8cb4886f572b147b02f4c59a648bbf05f9c@git.kernel.org>
Cc: namhyung@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org, ak@linux.intel.com,
        dsahern@gmail.com, eranian@google.com,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        tglx@linutronix.de, hpa@zytor.com, jolsa@redhat.com
Reply-To: ak@linux.intel.com, dsahern@gmail.com, peterz@infradead.org,
        mingo@kernel.org, jolsa@redhat.com, hpa@zytor.com, tglx@linutronix.de,
        acme@redhat.com, eranian@google.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, namhyung@kernel.org
In-Reply-To: <20180209092734.GB20449@krava>
References: <20180209092734.GB20449@krava>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf report: Add support to display group output
 for non group events
Git-Commit-ID: ad52b8cb4886f572b147b02f4c59a648bbf05f9c
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

Commit-ID:  ad52b8cb4886f572b147b02f4c59a648bbf05f9c
Gitweb:     https://git.kernel.org/tip/ad52b8cb4886f572b147b02f4c59a648bbf05f9c
Author:     Jiri Olsa <jolsa@redhat.com>
AuthorDate: Fri, 9 Feb 2018 10:27:34 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 10:09:24 -0300

perf report: Add support to display group output for non group events

Add support to display group output for if non grouped events are
detected and user forces --group option. Now for non-group events
recorded like:

  $ perf record -e 'cycles,instructions' ls

you can still get group output by using --group option
in report:

  $ perf report --group --stdio
  ...
  #         Overhead  Command  Shared Object     Symbol
  # ................  .......  ................  ......................
  #
      17.67%   0.00%  ls       libc-2.25.so      [.] _IO_do_write@@GLIB
      15.59%  25.94%  ls       ls                [.] calculate_columns
      15.41%  31.35%  ls       libc-2.25.so      [.] __strcoll_l
  ...

Committer note:

We should improve on this by making sure that the first line states that
this is not a group, but since the user doesn't have to force group view
when really using grouped events (e.g. '{cycles,instructions}'), the
user better know what is being done...

Requested-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Stephane Eranian <eranian@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180209092734.GB20449@krava
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt | 3 ++-
 tools/perf/builtin-report.c              | 6 +++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 907e505..a76b871 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -354,7 +354,8 @@ OPTIONS
         Path to objdump binary.
 
 --group::
-	Show event group information together.
+	Show event group information together. It forces group output also
+	if there are no groups defined in data file.
 
 --demangle::
 	Demangle symbol names to human readable form. It's enabled by default,
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 8ef7166..1eedb18 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -938,6 +938,7 @@ int cmd_report(int argc, const char **argv)
 		"perf report [<options>]",
 		NULL
 	};
+	bool group_set = false;
 	struct report report = {
 		.tool = {
 			.sample		 = process_sample_event,
@@ -1057,7 +1058,7 @@ int cmd_report(int argc, const char **argv)
 		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
 	OPT_BOOLEAN(0, "show-total-period", &symbol_conf.show_total_period,
 		    "Show a column with the sum of periods"),
-	OPT_BOOLEAN(0, "group", &symbol_conf.event_group,
+	OPT_BOOLEAN_SET(0, "group", &symbol_conf.event_group, &group_set,
 		    "Show event group information together"),
 	OPT_CALLBACK_NOOPT('b', "branch-stack", &branch_mode, "",
 		    "use branch records for per branch histogram filling",
@@ -1174,6 +1175,9 @@ repeat:
 	has_br_stack = perf_header__has_feat(&session->header,
 					     HEADER_BRANCH_STACK);
 
+	if (group_set && !session->evlist->nr_groups)
+		perf_evlist__set_leader(session->evlist);
+
 	if (itrace_synth_opts.last_branch)
 		has_br_stack = true;
 
