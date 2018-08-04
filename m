Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A2CC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE5F217FE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE5F217FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732124AbeHDPGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 11:06:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47470 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726753AbeHDPGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 11:06:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D277B8197021;
        Sat,  4 Aug 2018 13:05:51 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3AD12215670D;
        Sat,  4 Aug 2018 13:05:50 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 16/20] perf annotate: Add support to togle percent type
Date:   Sat,  4 Aug 2018 15:05:17 +0200
Message-Id: <20180804130521.11408-17-jolsa@kernel.org>
In-Reply-To: <20180804130521.11408-1-jolsa@kernel.org>
References: <20180804130521.11408-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sat, 04 Aug 2018 13:05:51 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sat, 04 Aug 2018 13:05:51 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding new key bindings to togle percent type/base
in annotation UI browser:

 'p' to switch between local and global percent type
 'b' to switch between hits and perdio percent base

Adding following help messages to the UI browser '?' window:

  ...
  p             Toggle percent type [local/global]
  b             Toggle percent base [period/hits]
  ...

Link: http://lkml.kernel.org/n/tip-4czhcopnki8vn6pzbdl5k437@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/ui/browsers/annotate.c | 57 ++++++++++++++++++++++++++++---
 tools/perf/util/annotate.h        | 16 +++++++++
 2 files changed, 68 insertions(+), 5 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 2a3a34d450d5..11ce40f9c241 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <sys/ttydefaults.h>
+#include <asm/bug.h>
 
 struct disasm_line_samples {
 	double		      percent;
@@ -382,10 +383,13 @@ static void ui_browser__init_asm_mode(struct ui_browser *browser)
 
 #define SYM_TITLE_MAX_SIZE (PATH_MAX + 64)
 
-static int sym_title(struct symbol *sym, struct map *map, char *title,
-		     size_t sz)
+static int
+sym_title(struct symbol *sym, struct map *map, unsigned int percent_type,
+	  char *title, size_t sz)
 {
-	return snprintf(title, sz, "%s  %s", sym->name, map->dso->long_name);
+	return snprintf(title, sz, "%s  %s [Percent: %s]",
+			sym->name, map->dso->long_name,
+			percent_type_str(percent_type));
 }
 
 /*
@@ -423,7 +427,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 
 	pthread_mutex_unlock(&notes->lock);
 	symbol__tui_annotate(dl->ops.target.sym, ms->map, evsel, hbt, browser->opts);
-	sym_title(ms->sym, ms->map, title, sizeof(title));
+	sym_title(ms->sym, ms->map, browser->opts->percent_type, title, sizeof(title));
 	ui_browser__show_title(&browser->b, title);
 	return true;
 }
@@ -598,6 +602,7 @@ bool annotate_browser__continue_search_reverse(struct annotate_browser *browser,
 
 static int annotate_browser__show(struct ui_browser *browser, char *title, const char *help)
 {
+	struct annotate_browser *ab = container_of(browser, struct annotate_browser, b);
 	struct map_symbol *ms = browser->priv;
 	struct symbol *sym = ms->sym;
 	char symbol_dso[SYM_TITLE_MAX_SIZE];
@@ -605,7 +610,8 @@ static int annotate_browser__show(struct ui_browser *browser, char *title, const
 	if (ui_browser__show(browser, title, help) < 0)
 		return -1;
 
-	sym_title(sym, ms->map, symbol_dso, sizeof(symbol_dso));
+	sym_title(sym, ms->map, ab->opts->percent_type,
+		  symbol_dso, sizeof(symbol_dso));
 
 	ui_browser__gotorc_title(browser, 0, 0);
 	ui_browser__set_color(browser, HE_COLORSET_ROOT);
@@ -613,6 +619,39 @@ static int annotate_browser__show(struct ui_browser *browser, char *title, const
 	return 0;
 }
 
+static void
+switch_percent_type(struct annotation_options *opts, bool base)
+{
+	switch (opts->percent_type) {
+	case PERCENT_HITS_LOCAL:
+		if (base)
+			opts->percent_type = PERCENT_PERIOD_LOCAL;
+		else
+			opts->percent_type = PERCENT_HITS_GLOBAL;
+		break;
+	case PERCENT_HITS_GLOBAL:
+		if (base)
+			opts->percent_type = PERCENT_PERIOD_GLOBAL;
+		else
+			opts->percent_type = PERCENT_HITS_LOCAL;
+		break;
+	case PERCENT_PERIOD_LOCAL:
+		if (base)
+			opts->percent_type = PERCENT_HITS_LOCAL;
+		else
+			opts->percent_type = PERCENT_PERIOD_GLOBAL;
+		break;
+	case PERCENT_PERIOD_GLOBAL:
+		if (base)
+			opts->percent_type = PERCENT_HITS_GLOBAL;
+		else
+			opts->percent_type = PERCENT_PERIOD_LOCAL;
+		break;
+	default:
+		WARN_ON(1);
+	}
+}
+
 static int annotate_browser__run(struct annotate_browser *browser,
 				 struct perf_evsel *evsel,
 				 struct hist_browser_timer *hbt)
@@ -703,6 +742,8 @@ static int annotate_browser__run(struct annotate_browser *browser,
 		"k             Toggle line numbers\n"
 		"P             Print to [symbol_name].annotation file.\n"
 		"r             Run available scripts\n"
+		"p             Toggle percent type [local/global]\n"
+		"b             Toggle percent base [period/hits]\n"
 		"?             Search string backwards\n");
 			continue;
 		case 'r':
@@ -802,6 +843,12 @@ static int annotate_browser__run(struct annotate_browser *browser,
 				notes->options->show_minmax_cycle = true;
 			annotation__update_column_widths(notes);
 			continue;
+		case 'p':
+		case 'b':
+			switch_percent_type(browser->opts, key == 'b');
+			hists__scnprintf_title(hists, title, sizeof(title));
+			annotate_browser__show(&browser->b, title, help);
+			continue;
 		case K_LEFT:
 		case K_ESC:
 		case 'q':
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 3d4579e68d28..760a6678edff 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -11,6 +11,7 @@
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include <pthread.h>
+#include <asm/bug.h>
 
 struct ins_ops;
 
@@ -149,6 +150,21 @@ static inline double annotation_data__percent(struct annotation_data *data,
 	return which < PERCENT_MAX ? data->percent[which] : -1;
 }
 
+static inline const char *percent_type_str(unsigned int type)
+{
+	static const char *str[PERCENT_MAX] = {
+		"local hits",
+		"global hits",
+		"local period",
+		"global period",
+	};
+
+	if (WARN_ON(type >= PERCENT_MAX))
+		return "N/A";
+
+	return str[type];
+}
+
 static inline struct disasm_line *disasm_line(struct annotation_line *al)
 {
 	return al ? container_of(al, struct disasm_line, al) : NULL;
-- 
2.17.1

