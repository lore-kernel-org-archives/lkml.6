Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeCMGWo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 02:22:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:52838 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752096AbeCMGWl (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 02:22:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,464,1515484800";
   d="scan'208";a="25162194"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 4/4] perf annotate: Enable the '--tui-dump' mode
Date: Tue, 13 Mar 2018 22:16:54 +0800
Message-Id: <1520950614-22082-5-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520950614-22082-1-git-send-email-yao.jin@linux.intel.com>
References: <1520950614-22082-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It creates a new option '--tui-dump' in perf annotate command line.

With this option, for example, the perf annotate output:

$ perf annotate compute_flag --tui-dump

Percent  IPC Cycle

                        Disassembly of section .text:

                        0000000000400640 <compute_flag>:
                        compute_flag():
                        volatile int count;
                        static unsigned int s_randseed;

                        __attribute__((noinline))
                        int compute_flag()
                        {
 23.00  1.16              sub    $0x8,%rsp
                                int i;

                                i = rand() % 2;
 23.06  1.16     1        callq  rand@plt

                                return i;
 27.01  3.38              mov    %eax,%edx
                        }
        3.38              add    $0x8,%rsp
                        {
                                int i;

                                i = rand() % 2;

                                return i;
        3.38              shr    $0x1f,%edx
        3.38              add    %edx,%eax
        3.38              and    $0x1,%eax
        3.38              sub    %edx,%eax
                        }
 26.93  3.38     2        retq

Compared to TUI output,

$ perf annotate compute_flag

       │                Disassembly of section .text:
       │
       │                0000000000400640 <compute_flag>
       │                compute_flag():
       │                volatile int count;
       │                static unsigned int s_randseed;
       │
       │                __attribute__((noinline))
       │                int compute_flag()
       │                {
 23.00 │1.16              sub    $0x8,%rsp
       │                        int i;
       │
       │                        i = rand() % 2;
 23.06 │1.16     1      → callq  rand@plt
       │
       │                        return i;
 27.01 │3.38              mov    %eax,%edx
       │                }
       │3.38              add    $0x8,%rsp
       │                {
       │                        int i;
       │
       │                        i = rand() % 2;
       │
       │                        return i;
       │3.38              shr    $0x1f,%edx
       │3.38              add    %edx,%eax
       │3.38              and    $0x1,%eax
       │3.38              sub    %edx,%eax
       │                }
 26.93 │3.38     2      ← retq

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-annotate.txt |  3 +++
 tools/perf/builtin-annotate.c              | 12 ++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index 292809c3..d52ae47 100644
--- a/tools/perf/Documentation/perf-annotate.txt
+++ b/tools/perf/Documentation/perf-annotate.txt
@@ -83,6 +83,9 @@ OPTIONS
 
 --gtk:: Use the GTK interface.
 
+--tui-dump: Use the TUI interface. The TUI output is dumped to stdio
+	    interface.
+
 -C::
 --cpu=<cpu>:: Only report samples for the list of CPUs provided. Multiple CPUs can
 	be provided as a comma-separated list with no space: 0,1. Ranges of
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 8ba8e2c..5110160 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -41,6 +41,7 @@ struct perf_annotate {
 	struct perf_tool tool;
 	struct perf_session *session;
 	bool	   use_tui, use_stdio, use_gtk;
+	bool	   tui_dump;
 	bool	   full_paths;
 	bool	   print_line;
 	bool	   skip_missing;
@@ -334,7 +335,10 @@ static void hists__find_annotations(struct hists *hists,
 			/* skip missing symbols */
 			nd = rb_next(nd);
 		} else if (use_browser == 1) {
-			key = hist_entry__tui_annotate(he, evsel, NULL, false);
+			key = hist_entry__tui_annotate(he, evsel, NULL,
+						       ann->tui_dump);
+			if (ann->tui_dump)
+				return;
 
 			switch (key) {
 			case -1:
@@ -486,6 +490,7 @@ int cmd_annotate(int argc, const char **argv)
 		    "dump raw trace in ASCII"),
 	OPT_BOOLEAN(0, "gtk", &annotate.use_gtk, "Use the GTK interface"),
 	OPT_BOOLEAN(0, "tui", &annotate.use_tui, "Use the TUI interface"),
+	OPT_BOOLEAN(0, "tui-dump", &annotate.tui_dump, "Dump TUI content"),
 	OPT_BOOLEAN(0, "stdio", &annotate.use_stdio, "Use the stdio interface"),
 	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
 		   "file", "vmlinux pathname"),
@@ -576,7 +581,10 @@ int cmd_annotate(int argc, const char **argv)
 	else if (annotate.use_gtk)
 		use_browser = 2;
 
-	setup_browser(true, false);
+	if (annotate.tui_dump)
+		use_browser = 1;
+
+	setup_browser(true, annotate.tui_dump);
 
 	if (use_browser == 1 && annotate.has_br_stack) {
 		sort__mode = SORT_MODE__BRANCH;
-- 
2.7.4
