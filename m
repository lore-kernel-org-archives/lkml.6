Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753094AbeCXUDd (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 16:03:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753074AbeCXUDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 16:03:30 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED982178B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 10/44] perf annotate: Move pcnt_with() to the annotation library
Date: Sat, 24 Mar 2018 17:01:37 -0300
Message-Id: <20180324200211.21326-11-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180324200211.21326-1-acme@kernel.org>
References: <20180324200211.21326-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Out of the TUI code, since now all it touches is what is in 'struct
annotation'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-kh5bbbgd7l4agv9oc5hnw0ui@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 14 +++-----------
 tools/perf/util/annotate.h        |  5 +++++
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index b20e0ae72466..3b030ee4505f 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -96,13 +96,6 @@ static int annotate_browser__set_jumps_percent_color(struct annotate_browser *br
 	 return ui_browser__set_color(&browser->b, color);
 }
 
-static int annotate_browser__pcnt_width(struct annotate_browser *ab)
-{
-	struct map_symbol *ms = ab->b.priv;
-	struct annotation *notes = symbol__annotation(ms->sym);
-	return (notes->options->show_total_period ? 12 : 7) * notes->nr_events;
-}
-
 static void disasm_line__write(struct disasm_line *dl, struct ui_browser *browser,
 			       char *bf, size_t size)
 {
@@ -145,7 +138,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 			     (!current_entry || (browser->use_navkeypressed &&
 					         !browser->navkeypressed)));
 	int width = browser->width, printed;
-	int i, pcnt_width = annotate_browser__pcnt_width(ab),
+	int i, pcnt_width = annotation__pcnt_width(notes),
 	       cycles_width = annotation__cycles_width(notes);
 	double percent_max = 0.0;
 	char bf[256];
@@ -310,7 +303,7 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 	struct map_symbol *ms = ab->b.priv;
 	struct symbol *sym = ms->sym;
 	struct annotation *notes = symbol__annotation(sym);
-	u8 pcnt_width = annotate_browser__pcnt_width(ab);
+	u8 pcnt_width = annotation__pcnt_width(notes);
 	int width;
 
 	/* PLT symbols contain external offsets */
@@ -375,11 +368,10 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 
 static unsigned int annotate_browser__refresh(struct ui_browser *browser)
 {
-	struct annotate_browser *ab = container_of(browser, struct annotate_browser, b);
 	struct map_symbol *ms = browser->priv;
 	struct annotation *notes = symbol__annotation(ms->sym);
 	int ret = ui_browser__list_head_refresh(browser);
-	int pcnt_width = annotate_browser__pcnt_width(ab);
+	int pcnt_width = annotation__pcnt_width(notes);
 
 	if (notes->options->jump_arrows)
 		annotate_browser__draw_current_jump(browser);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 5936605b5dac..17cd5d274fe5 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -176,6 +176,11 @@ static inline int annotation__cycles_width(struct annotation *notes)
 	return notes->have_cycles ? ANNOTATION__IPC_WIDTH + ANNOTATION__CYCLES_WIDTH : 0;
 }
 
+static inline int annotation__pcnt_width(struct annotation *notes)
+{
+	return (notes->options->show_total_period ? 12 : 7) * notes->nr_events;
+}
+
 void annotation__compute_ipc(struct annotation *notes, size_t size);
 
 static inline struct sym_hist *annotation__histogram(struct annotation *notes, int idx)
-- 
2.14.3
