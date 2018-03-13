Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752170AbeCMGWj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 02:22:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:52838 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752096AbeCMGWh (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 02:22:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,464,1515484800";
   d="scan'208";a="25162178"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 2/4] perf browser: bypass ui_init if in tui dump mode
Date: Tue, 13 Mar 2018 22:16:52 +0800
Message-Id: <1520950614-22082-3-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520950614-22082-1-git-send-email-yao.jin@linux.intel.com>
References: <1520950614-22082-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We create a tui dump mode in previous patch. In tui dump mode, the output
is written to stdio. We need to bypass ui_init() in setup_browser().

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-annotate.c | 2 +-
 tools/perf/builtin-c2c.c      | 2 +-
 tools/perf/builtin-report.c   | 2 +-
 tools/perf/builtin-top.c      | 2 +-
 tools/perf/ui/setup.c         | 9 +++++++--
 tools/perf/ui/ui.h            | 2 +-
 6 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index ead6ae4..2db5b50 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -576,7 +576,7 @@ int cmd_annotate(int argc, const char **argv)
 	else if (annotate.use_gtk)
 		use_browser = 2;
 
-	setup_browser(true);
+	setup_browser(true, false);
 
 	if (use_browser == 1 && annotate.has_br_stack) {
 		sort__mode = SORT_MODE__BRANCH;
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 98d243f..6abc13b 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2618,7 +2618,7 @@ static int perf_c2c__report(int argc, const char **argv)
 	else
 		use_browser = 1;
 
-	setup_browser(false);
+	setup_browser(false, false);
 
 	err = perf_session__process_events(session);
 	if (err) {
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 971ccba..99277b7 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1261,7 +1261,7 @@ int cmd_report(int argc, const char **argv)
 	}
 
 	if (strcmp(input_name, "-") != 0)
-		setup_browser(true);
+		setup_browser(true, false);
 	else
 		use_browser = 0;
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 0a26b56..b7db01a 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1430,7 +1430,7 @@ int cmd_top(int argc, const char **argv)
 	else if (top.use_tui)
 		use_browser = 1;
 
-	setup_browser(false);
+	setup_browser(false, false);
 
 	if (setup_sorting(top.evlist) < 0) {
 		if (sort_order)
diff --git a/tools/perf/ui/setup.c b/tools/perf/ui/setup.c
index 44fe824..8219b2e 100644
--- a/tools/perf/ui/setup.c
+++ b/tools/perf/ui/setup.c
@@ -73,9 +73,9 @@ int stdio__config_color(const struct option *opt __maybe_unused,
 	return 0;
 }
 
-void setup_browser(bool fallback_to_pager)
+void setup_browser(bool fallback_to_pager, bool tui_dump)
 {
-	if (use_browser < 2 && (!isatty(1) || dump_trace))
+	if (use_browser < 2 && (!isatty(1) || dump_trace) && !tui_dump)
 		use_browser = 0;
 
 	/* default to TUI */
@@ -92,6 +92,11 @@ void setup_browser(bool fallback_to_pager)
 		/* fall through */
 	case 1:
 		use_browser = 1;
+		if (tui_dump) {
+			setup_pager();
+			break;
+		}
+
 		if (ui__init() == 0)
 			break;
 		/* fall through */
diff --git a/tools/perf/ui/ui.h b/tools/perf/ui/ui.h
index 9b6fdf0..020a85b 100644
--- a/tools/perf/ui/ui.h
+++ b/tools/perf/ui/ui.h
@@ -11,7 +11,7 @@ extern void *perf_gtk_handle;
 
 extern int use_browser;
 
-void setup_browser(bool fallback_to_pager);
+void setup_browser(bool fallback_to_pager, bool tui_dump);
 void exit_browser(bool wait_for_ok);
 
 #ifdef HAVE_SLANG_SUPPORT
-- 
2.7.4
