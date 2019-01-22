Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318D1C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF58D20844
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfAVKK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:10:29 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33713 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfAVKK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:10:29 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0MA9vv32905985
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 22 Jan 2019 02:09:57 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0MA9v302905982;
        Tue, 22 Jan 2019 02:09:57 -0800
Date:   Tue, 22 Jan 2019 02:09:57 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rasmus Villemoes <tipbot@zytor.com>
Message-ID: <tip-49b8e2beceda79ae25938faf68fad0ad62534852@git.kernel.org>
Cc:     acme@redhat.com, peterz@infradead.org, jolsa@kernel.org,
        hpa@zytor.com, namhyung@kernel.org, mingo@kernel.org,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de
Reply-To: alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, peterz@infradead.org, acme@redhat.com,
          jolsa@kernel.org, namhyung@kernel.org, hpa@zytor.com,
          linux@rasmusvillemoes.dk, mingo@kernel.org
In-Reply-To: <20181102230624.20064-1-linux@rasmusvillemoes.dk>
References: <20181102230624.20064-1-linux@rasmusvillemoes.dk>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Replace automatic const char[]
 variables by statics
Git-Commit-ID: 49b8e2beceda79ae25938faf68fad0ad62534852
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  49b8e2beceda79ae25938faf68fad0ad62534852
Gitweb:     https://git.kernel.org/tip/49b8e2beceda79ae25938faf68fad0ad62534852
Author:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
AuthorDate: Sat, 3 Nov 2018 00:06:23 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 21 Jan 2019 15:15:57 -0300

perf tools: Replace automatic const char[] variables by statics

An automatic const char[] variable gets initialized at runtime, just
like any other automatic variable. For long strings, that uses a lot of
stack and wastes time building the string; e.g. for the "No %s
allocation events..." case one has:

  444516:       48 b8 4e 6f 20 25 73 20 61 6c   movabs $0x6c61207325206f4e,%rax # "No %s al"
  ...
  444674:       48 89 45 80                     mov    %rax,-0x80(%rbp)
  444678:       48 b8 6c 6f 63 61 74 69 6f 6e   movabs $0x6e6f697461636f6c,%rax # "location"
  444682:       48 89 45 88                     mov    %rax,-0x78(%rbp)
  444686:       48 b8 20 65 76 65 6e 74 73 20   movabs $0x2073746e65766520,%rax # " events "
  444690:       66 44 89 55 c4                  mov    %r10w,-0x3c(%rbp)
  444695:       48 89 45 90                     mov    %rax,-0x70(%rbp)
  444699:       48 b8 66 6f 75 6e 64 2e 20 20   movabs $0x20202e646e756f66,%rax

Make them all static so that the compiler just references objects in .rodata.

Committer testing:

Ok, using dwarves's codiff tool:

    $ codiff --functions /tmp/perf.before ~/bin/perf
  builtin-sched.c:
    cmd_sched                 |  -48
   1 function changed, 48 bytes removed, diff: -48

  builtin-report.c:
    cmd_report                |  -32
   1 function changed, 32 bytes removed, diff: -32

  builtin-kmem.c:
    cmd_kmem                  |  -64
    build_alloc_func_list     |  -50
   2 functions changed, 114 bytes removed, diff: -114

  builtin-c2c.c:
    perf_c2c__report          | -390
   1 function changed, 390 bytes removed, diff: -390

  ui/browsers/header.c:
    tui__header_window        | -104
   1 function changed, 104 bytes removed, diff: -104

  /home/acme/bin/perf:
   9 functions changed, 688 bytes removed, diff: -688

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20181102230624.20064-1-linux@rasmusvillemoes.dk
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c        | 4 ++--
 tools/perf/builtin-kmem.c       | 4 ++--
 tools/perf/builtin-report.c     | 6 +++---
 tools/perf/builtin-sched.c      | 2 +-
 tools/perf/ui/browsers/header.c | 2 +-
 tools/perf/ui/browsers/hists.c  | 4 ++--
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index d340d2e42776..f2863496dede 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2343,7 +2343,7 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
 	struct c2c_cacheline_browser *cl_browser;
 	struct hist_browser *browser;
 	int key = -1;
-	const char help[] =
+	static const char help[] =
 	" ENTER         Toggle callchains (if present) \n"
 	" n             Toggle Node details info \n"
 	" s             Toggle full length of symbol and source line columns \n"
@@ -2424,7 +2424,7 @@ static int perf_c2c__hists_browse(struct hists *hists)
 {
 	struct hist_browser *browser;
 	int key = -1;
-	const char help[] =
+	static const char help[] =
 	" d             Display cacheline details \n"
 	" ENTER         Toggle callchains (if present) \n"
 	" q             Quit \n";
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index b63bca4b0c2a..088705c167bf 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -334,7 +334,7 @@ static int build_alloc_func_list(void)
 	struct alloc_func *func;
 	struct machine *machine = &kmem_session->machines.host;
 	regex_t alloc_func_regex;
-	const char pattern[] = "^_?_?(alloc|get_free|get_zeroed)_pages?";
+	static const char pattern[] = "^_?_?(alloc|get_free|get_zeroed)_pages?";
 
 	ret = regcomp(&alloc_func_regex, pattern, REG_EXTENDED);
 	if (ret) {
@@ -1924,7 +1924,7 @@ int cmd_kmem(int argc, const char **argv)
 		NULL
 	};
 	struct perf_session *session;
-	const char errmsg[] = "No %s allocation events found.  Have you run 'perf kmem record --%s'?\n";
+	static const char errmsg[] = "No %s allocation events found.  Have you run 'perf kmem record --%s'?\n";
 	int ret = perf_config(kmem_config, NULL);
 
 	if (ret)
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 4958095be4fc..794a0de5ac1d 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -956,9 +956,9 @@ int cmd_report(int argc, const char **argv)
 	int branch_mode = -1;
 	bool branch_call_mode = false;
 #define CALLCHAIN_DEFAULT_OPT  "graph,0.5,caller,function,percent"
-	const char report_callchain_help[] = "Display call graph (stack chain/backtrace):\n\n"
-					     CALLCHAIN_REPORT_HELP
-					     "\n\t\t\t\tDefault: " CALLCHAIN_DEFAULT_OPT;
+	static const char report_callchain_help[] = "Display call graph (stack chain/backtrace):\n\n"
+						    CALLCHAIN_REPORT_HELP
+						    "\n\t\t\t\tDefault: " CALLCHAIN_DEFAULT_OPT;
 	char callchain_default_opt[] = CALLCHAIN_DEFAULT_OPT;
 	const char * const report_usage[] = {
 		"perf report [<options>]",
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index cbf39dab19c1..2e0f0c65964a 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3336,7 +3336,7 @@ static int __cmd_record(int argc, const char **argv)
 
 int cmd_sched(int argc, const char **argv)
 {
-	const char default_sort_order[] = "avg, max, switch, runtime";
+	static const char default_sort_order[] = "avg, max, switch, runtime";
 	struct perf_sched sched = {
 		.tool = {
 			.sample		 = perf_sched__process_tracepoint_sample,
diff --git a/tools/perf/ui/browsers/header.c b/tools/perf/ui/browsers/header.c
index d75492189acb..5aeb663dd184 100644
--- a/tools/perf/ui/browsers/header.c
+++ b/tools/perf/ui/browsers/header.c
@@ -35,7 +35,7 @@ static int list_menu__run(struct ui_browser *menu)
 {
 	int key;
 	unsigned long offset;
-	const char help[] =
+	static const char help[] =
 	"h/?/F1        Show this window\n"
 	"UP/DOWN/PGUP\n"
 	"PGDN/SPACE\n"
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index ffac1d54a3d4..b32f505a7608 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2748,7 +2748,7 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
 	"S             Zoom into current Processor Socket\n"		\
 
 	/* help messages are sorted by lexical order of the hotkey */
-	const char report_help[] = HIST_BROWSER_HELP_COMMON
+	static const char report_help[] = HIST_BROWSER_HELP_COMMON
 	"i             Show header information\n"
 	"P             Print histograms to perf.hist.N\n"
 	"r             Run available scripts\n"
@@ -2756,7 +2756,7 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
 	"t             Zoom into current Thread\n"
 	"V             Verbose (DSO names in callchains, etc)\n"
 	"/             Filter symbol by name";
-	const char top_help[] = HIST_BROWSER_HELP_COMMON
+	static const char top_help[] = HIST_BROWSER_HELP_COMMON
 	"P             Print histograms to perf.hist.N\n"
 	"t             Zoom into current Thread\n"
 	"V             Verbose (DSO names in callchains, etc)\n"
