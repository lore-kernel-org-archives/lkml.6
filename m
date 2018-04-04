Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755397AbeDDCYA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 22:24:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755340AbeDDCXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 22:23:54 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D682133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 15/17] perf annotate browser: Show extra title line with event information
Date: Tue,  3 Apr 2018 23:21:56 -0300
Message-Id: <20180404022158.12190-16-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180404022158.12190-1-acme@kernel.org>
References: <20180404022158.12190-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.3
