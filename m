Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753588AbeDDFf4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 01:35:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44211 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbeDDFfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 01:35:54 -0400
Date: Tue, 3 Apr 2018 22:35:42 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ezccyxld50wtwyt66np6aomo@git.kernel.org>
Cc: acme@redhat.com, mingo@kernel.org, mliska@suse.cz, wangnan0@huawei.com,
        adrian.hunter@intel.com, namhyung@kernel.org, hpa@zytor.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, dsahern@gmail.com, tglx@linutronix.de
Reply-To: mingo@kernel.org, acme@redhat.com, wangnan0@huawei.com,
        adrian.hunter@intel.com, mliska@suse.cz, jolsa@kernel.org,
        namhyung@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, dsahern@gmail.com,
        linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate browser: Show extra title line with
 event information
Git-Commit-ID: 6920e2854e9a16226ca57199d48fd6b68819f6d5
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

Commit-ID:  6920e2854e9a16226ca57199d48fd6b68819f6d5
Gitweb:     https://git.kernel.org/tip/6920e2854e9a16226ca57199d48fd6b68819f6d5
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 2 Apr 2018 16:18:45 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 3 Apr 2018 15:23:11 -0300

perf annotate browser: Show extra title line with event information

So at the top we'll have two lines, like this, from 'perf report':

  # perf report --group --ignore-vmlinux
=====================================================================================================
Samples: 46  of events 'cycles', 4000 Hz, Event count (approx.): 5154895
_raw_spin_lock_irqsave  /proc/kcore
Percent              │      nop
                     │      push   %rbx
  0.00  14.29   0.00 │      pushfq
  9.09   0.00   0.00 │      pop    %rax
  9.09   0.00  20.00 │      nop
                     │      mov    %rax,%rbx
                     │      cli
  4.55   7.14   0.00 │      nop
                     │      xor    %eax,%eax
                     │      mov    $0x1,%edx
                     │      lock   cmpxchg %edx,(%rdi)
 77.27  78.57  70.00 │      test   %eax,%eax
                     │    ↓ jne    2b
                     │      mov    %rbx,%rax
  0.00   0.00  10.00 │      pop    %rbx
                     │    ← retq
                     │2b:   mov    %eax,%esi
                     │    → callq  queued_spin_lock_slowpath
                     │      mov    %rbx,%rax
                     │      pop    %rbx
Press 'h' for help on│key bindings
=====================================================================================================

 9.09 + 9.09 + 4.55 + 77.27 = 100
14.29 + 7.14 + 78.57 = 100
20 + 70 + 10 = 100

We can do the math by using 't' to toggle from 'percent' to nr

=====================================================================================================
Samples: 46  of events 'cycles', 4000 Hz, Event count (approx.): 5154895
_raw_spin_lock_irqsave  /proc/kcore
Period                              │      nop
                                    │      push   %rbx
          0       79273           0 │      pushfq
     190455           0           0 │      pop    %rax
     198038           0        3045 │      nop
                                    │      mov    %rax,%rbx
                                    │      cli
     217233       32562           0 │      nop
                                    │      xor    %eax,%eax
                                    │      mov    $0x1,%edx
                                    │      lock   cmpxchg %edx,(%rdi)
    3421649      979174       28273 │      test   %eax,%eax
                                    │    ↓ jne    2b
                                    │      mov    %rbx,%rax
          0           0        5193 │      pop    %rbx
                                    │    ← retq
                                    │2b:   mov    %eax,%esi
                                    │    → callq  queued_spin_lock_slowpath
                                    │      mov    %rbx,%rax
                                    │      pop    %rbx
Press 'h' for help on│key bindings
=====================================================================================================

79273 + 190455 + 198038 + 3045 + 217233 + 32562 + 3421649 + 979174 + 28273 + 5193 = 5154895

Or number of samples:

=====================================================================================================
ooSamples: 46  of events 'cycles', 4000 Hz, Event count (approx.): 5154895
_raw_spin_lock_irqsave  /proc/kcore
Samples              │      nop
                     │      push   %rbx
     0      2      0 │      pushfq
     2      0      0 │      pop    %rax
     2      0      2 │      nop
                     │      mov    %rax,%rbx
                     │      cli
     1      1      0 │      nop
                     │      xor    %eax,%eax
                     │      mov    $0x1,%edx
                     │      lock   cmpxchg %edx,(%rdi)
    17     11      7 │      test   %eax,%eax
                     │    ↓ jne    2b
                     │      mov    %rbx,%rax
     0      0      1 │      pop    %rbx
                     │    ← retq
                     │2b:   mov    %eax,%esi
                     │    → callq  queued_spin_lock_slowpath
                     │      mov    %rbx,%rax
                     │      pop    %rbx
Press 'h' for help on key bindings
=====================================================================================================

2 + 2 + 2 + 2 + 1 + 1 + 17 + 11 + 7 + 1 = 46

Suggested-by: Martin Liška <mliska@suse.cz>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=196935
Link: https://lkml.kernel.org/n/tip-ezccyxld50wtwyt66np6aomo@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index c02fb437ac8e..78bcd220f1b6 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -592,21 +592,40 @@ bool annotate_browser__continue_search_reverse(struct annotate_browser *browser,
 	return __annotate_browser__search_reverse(browser);
 }
 
+static int annotate_browser__show(struct ui_browser *browser, char *title, const char *help)
+{
+	struct map_symbol *ms = browser->priv;
+	struct symbol *sym = ms->sym;
+	char symbol_dso[SYM_TITLE_MAX_SIZE];
+
+	if (ui_browser__show(browser, title, help) < 0)
+		return -1;
+
+	sym_title(sym, ms->map, symbol_dso, sizeof(symbol_dso));
+
+	ui_browser__gotorc_title(browser, 0, 0);
+	ui_browser__set_color(browser, HE_COLORSET_ROOT);
+	ui_browser__write_nstring(browser, symbol_dso, browser->width + 1);
+	return 0;
+}
+
 static int annotate_browser__run(struct annotate_browser *browser,
 				 struct perf_evsel *evsel,
 				 struct hist_browser_timer *hbt)
 {
 	struct rb_node *nd = NULL;
+	struct hists *hists = evsel__hists(evsel);
 	struct map_symbol *ms = browser->b.priv;
 	struct symbol *sym = ms->sym;
 	struct annotation *notes = symbol__annotation(ms->sym);
 	const char *help = "Press 'h' for help on key bindings";
 	int delay_secs = hbt ? hbt->refresh : 0;
+	char title[256];
 	int key;
-	char title[SYM_TITLE_MAX_SIZE];
 
-	sym_title(sym, ms->map, title, sizeof(title));
-	if (ui_browser__show(&browser->b, title, help) < 0)
+	annotation__scnprintf_samples_period(notes, title, sizeof(title), evsel);
+
+	if (annotate_browser__show(&browser->b, title, help) < 0)
 		return -1;
 
 	annotate_browser__calc_percent(browser, evsel);
@@ -637,8 +656,11 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			if (hbt)
 				hbt->timer(hbt->arg);
 
-			if (delay_secs != 0)
+			if (delay_secs != 0) {
 				symbol__annotate_decay_histogram(sym, evsel->idx);
+				hists__scnprintf_title(hists, title, sizeof(title));
+				annotate_browser__show(&browser->b, title, help);
+			}
 			continue;
 		case K_TAB:
 			if (nd != NULL) {
@@ -812,6 +834,7 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 			.seek	 = ui_browser__list_head_seek,
 			.write	 = annotate_browser__write,
 			.filter  = disasm_line__filter,
+			.extra_title_lines = 1, /* for hists__scnprintf_title() */
 			.priv	 = &ms,
 			.use_navkeypressed = true,
 		},
