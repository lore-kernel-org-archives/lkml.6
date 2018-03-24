Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753380AbeCXUEm (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 16:04:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753349AbeCXUEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 16:04:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF3821839
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
Subject: [PATCH 31/44] perf annotate: Move the default annotate options to the library
Date: Sat, 24 Mar 2018 17:01:58 -0300
Message-Id: <20180324200211.21326-32-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180324200211.21326-1-acme@kernel.org>
References: <20180324200211.21326-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

One more thing that goes from the TUI code to be used more widely,
for instance it'll affect the default options used by:

  perf annotate --stdio2

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-0nsz0dm0akdbo30vgja2a10e@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c     |  2 ++
 tools/perf/builtin-report.c       |  1 +
 tools/perf/builtin-top.c          |  2 ++
 tools/perf/ui/browser.c           |  2 --
 tools/perf/ui/browser.h           |  1 -
 tools/perf/ui/browsers/annotate.c | 67 +--------------------------------------
 tools/perf/util/annotate.c        | 62 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/annotate.h        |  4 +++
 8 files changed, 72 insertions(+), 69 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index e03f9bea9303..fd5aac3fd949 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -572,6 +572,8 @@ int cmd_annotate(int argc, const char **argv)
 	if (ret < 0)
 		goto out_delete;
 
+	annotation_config__init();
+
 	symbol_conf.try_vmlinux_path = true;
 
 	ret = symbol__init(&annotate.session->header.env);
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 91da12975642..1a82f38671a8 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1340,6 +1340,7 @@ int cmd_report(int argc, const char **argv)
 			symbol_conf.priv_size += sizeof(u32);
 			symbol_conf.sort_by_name = true;
 		}
+		annotation_config__init();
 	}
 
 	if (symbol__init(&session->header.env) < 0)
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 113c298ed38b..f39bd60d2708 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1493,6 +1493,8 @@ int cmd_top(int argc, const char **argv)
 	if (status < 0)
 		goto out_delete_evlist;
 
+	annotation_config__init();
+
 	symbol_conf.try_vmlinux_path = (symbol_conf.vmlinux_name == NULL);
 	if (symbol__init(NULL) < 0)
 		return -1;
diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index 33c30325885f..9f6ce29b83b4 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -784,6 +784,4 @@ void ui_browser__init(void)
 		struct ui_browser_colorset *c = &ui_browser__colorsets[i++];
 		sltt_set_color(c->colorset, c->name, c->fg, c->bg);
 	}
-
-	annotate_browser__init();
 }
diff --git a/tools/perf/ui/browser.h b/tools/perf/ui/browser.h
index 9e69c6a43514..70057178ee34 100644
--- a/tools/perf/ui/browser.h
+++ b/tools/perf/ui/browser.h
@@ -79,5 +79,4 @@ void ui_browser__list_head_seek(struct ui_browser *browser, off_t offset, int wh
 unsigned int ui_browser__list_head_refresh(struct ui_browser *browser);
 
 void ui_browser__init(void);
-void annotate_browser__init(void);
 #endif /* _PERF_UI_BROWSER_H_ */
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 74a26f4e9b06..916f237c1df8 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -9,7 +9,6 @@
 #include "../../util/sort.h"
 #include "../../util/symbol.h"
 #include "../../util/evsel.h"
-#include "../../util/config.h"
 #include "../../util/evlist.h"
 #include <inttypes.h>
 #include <pthread.h>
@@ -22,11 +21,6 @@ struct disasm_line_samples {
 	struct sym_hist_entry he;
 };
 
-static struct annotation_options annotate_browser__opts = {
-	.use_offset	= true,
-	.jump_arrows	= true,
-};
-
 struct arch;
 
 struct annotate_browser {
@@ -773,12 +767,6 @@ static int annotate_browser__run(struct annotate_browser *browser,
 int map_symbol__tui_annotate(struct map_symbol *ms, struct perf_evsel *evsel,
 			     struct hist_browser_timer *hbt)
 {
-	/* Set default value for show_total_period and show_nr_samples  */
-	annotate_browser__opts.show_total_period =
-		symbol_conf.show_total_period;
-	annotate_browser__opts.show_nr_samples =
-		symbol_conf.show_nr_samples;
-
 	return symbol__tui_annotate(ms->sym, ms->map, evsel, hbt);
 }
 
@@ -819,7 +807,7 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 	if (map->dso->annotate_warned)
 		return -1;
 
-	err = symbol__annotate2(sym, map, evsel, &annotate_browser__opts, &browser.arch);
+	err = symbol__annotate2(sym, map, evsel, &annotation__default_options, &browser.arch);
 	if (err) {
 		char msg[BUFSIZ];
 		symbol__strerror_disassemble(sym, map, err, msg, sizeof(msg));
@@ -845,56 +833,3 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 	zfree(&notes->offsets);
 	return ret;
 }
-
-#define ANNOTATE_CFG(n) \
-	{ .name = #n, .value = &annotate_browser__opts.n, }
-
-/*
- * Keep the entries sorted, they are bsearch'ed
- */
-static struct annotate_config {
-	const char *name;
-	bool *value;
-} annotate__configs[] = {
-	ANNOTATE_CFG(hide_src_code),
-	ANNOTATE_CFG(jump_arrows),
-	ANNOTATE_CFG(show_linenr),
-	ANNOTATE_CFG(show_nr_jumps),
-	ANNOTATE_CFG(show_nr_samples),
-	ANNOTATE_CFG(show_total_period),
-	ANNOTATE_CFG(use_offset),
-};
-
-#undef ANNOTATE_CFG
-
-static int annotate_config__cmp(const void *name, const void *cfgp)
-{
-	const struct annotate_config *cfg = cfgp;
-
-	return strcmp(name, cfg->name);
-}
-
-static int annotate__config(const char *var, const char *value,
-			    void *data __maybe_unused)
-{
-	struct annotate_config *cfg;
-	const char *name;
-
-	if (!strstarts(var, "annotate."))
-		return 0;
-
-	name = var + 9;
-	cfg = bsearch(name, annotate__configs, ARRAY_SIZE(annotate__configs),
-		      sizeof(struct annotate_config), annotate_config__cmp);
-
-	if (cfg == NULL)
-		ui__warning("%s variable unknown, ignoring...", var);
-	else
-		*cfg->value = perf_config_bool(name, value);
-	return 0;
-}
-
-void annotate_browser__init(void)
-{
-	perf_config(annotate__config, NULL);
-}
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 98cf3e5380bc..cfa641bc1df6 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -14,6 +14,7 @@
 #include "sort.h"
 #include "build-id.h"
 #include "color.h"
+#include "config.h"
 #include "cache.h"
 #include "symbol.h"
 #include "debug.h"
@@ -41,6 +42,11 @@
 
 #include "sane_ctype.h"
 
+struct annotation_options annotation__default_options = {
+	.use_offset     = true,
+	.jump_arrows    = true,
+};
+
 const char 	*disassembler_style;
 const char	*objdump_path;
 static regex_t	 file_lineno;
@@ -2500,3 +2506,59 @@ int symbol__annotate2(struct symbol *sym, struct map *map, struct perf_evsel *ev
 	zfree(&notes->offsets);
 	return -1;
 }
+
+#define ANNOTATION__CFG(n) \
+	{ .name = #n, .value = &annotation__default_options.n, }
+
+/*
+ * Keep the entries sorted, they are bsearch'ed
+ */
+static struct annotation_config {
+	const char *name;
+	bool *value;
+} annotation__configs[] = {
+	ANNOTATION__CFG(hide_src_code),
+	ANNOTATION__CFG(jump_arrows),
+	ANNOTATION__CFG(show_linenr),
+	ANNOTATION__CFG(show_nr_jumps),
+	ANNOTATION__CFG(show_nr_samples),
+	ANNOTATION__CFG(show_total_period),
+	ANNOTATION__CFG(use_offset),
+};
+
+#undef ANNOTATION__CFG
+
+static int annotation_config__cmp(const void *name, const void *cfgp)
+{
+	const struct annotation_config *cfg = cfgp;
+
+	return strcmp(name, cfg->name);
+}
+
+static int annotation__config(const char *var, const char *value,
+			    void *data __maybe_unused)
+{
+	struct annotation_config *cfg;
+	const char *name;
+
+	if (!strstarts(var, "annotate."))
+		return 0;
+
+	name = var + 9;
+	cfg = bsearch(name, annotation__configs, ARRAY_SIZE(annotation__configs),
+		      sizeof(struct annotation_config), annotation_config__cmp);
+
+	if (cfg == NULL)
+		pr_debug("%s variable unknown, ignoring...", var);
+	else
+		*cfg->value = perf_config_bool(name, value);
+	return 0;
+}
+
+void annotation_config__init(void)
+{
+	perf_config(annotation__config, NULL);
+
+	annotation__default_options.show_total_period = symbol_conf.show_total_period;
+	annotation__default_options.show_nr_samples   = symbol_conf.show_nr_samples;
+}
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index cf32cbc87930..3faa58045b22 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -71,6 +71,8 @@ struct annotation_options {
 	     show_total_period;
 };
 
+extern struct annotation_options annotation__default_options;
+
 struct annotation;
 
 struct sym_hist_entry {
@@ -313,4 +315,6 @@ static inline int symbol__tui_annotate(struct symbol *sym __maybe_unused,
 
 extern const char	*disassembler_style;
 
+void annotation_config__init(void);
+
 #endif	/* __PERF_ANNOTATE_H */
-- 
2.14.3
