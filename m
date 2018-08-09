Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9E6C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AAF214FF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYuCly9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37AAF214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733003AbeHIR0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:26:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732116AbeHIR0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:26:10 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E76B21EA3;
        Thu,  9 Aug 2018 15:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826852;
        bh=Y50RUVLJPLyLXy+LOAifMKJPnLTrA5advTGlQcALngU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oYuCly9WMK0DD5u0quWYyJSLbTOM/fW5mtc2sP6jX0jzATNWUcL7fuROC9+z6HLpk
         Qjed9K+3J6fMVVOqI76R0PCH2xkL8vz8BTczwItAFuqKFRDOdTkwVFCWK0MXITvuy3
         IEaUfQPj6QpmCulMSlk8yYX6HuvQQlUIpOXiaksM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 28/44] perf annotate: Add support to toggle percent type
Date:   Thu,  9 Aug 2018 11:58:06 -0300
Message-Id: <20180809145822.21391-29-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add new key bindings to toggle percent type/base in annotation UI browser:

 'p' to switch between local and global percent type
 'b' to switch between hits and perdio percent base

Add the following help messages to the UI browser '?' window:

  ...
  p             Toggle percent type [local/global]
  b             Toggle percent base [period/hits]
  ...

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-17-jolsa@kernel.org
[ Moved percent_type to be the last arg to sym_title(), its an arg to what is being formmated (buf, size) ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 52 ++++++++++++++++++++++++++++++++++++---
 tools/perf/util/annotate.h        | 16 ++++++++++++
 2 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 2a3a34d450d5..1d00e5ec7906 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <sys/ttydefaults.h>
+#include <asm/bug.h>
 
 struct disasm_line_samples {
 	double		      percent;
@@ -383,9 +384,10 @@ static void ui_browser__init_asm_mode(struct ui_browser *browser)
 #define SYM_TITLE_MAX_SIZE (PATH_MAX + 64)
 
 static int sym_title(struct symbol *sym, struct map *map, char *title,
-		     size_t sz)
+		     size_t sz, int percent_type)
 {
-	return snprintf(title, sz, "%s  %s", sym->name, map->dso->long_name);
+	return snprintf(title, sz, "%s  %s [Percent: %s]", sym->name, map->dso->long_name,
+			percent_type_str(percent_type));
 }
 
 /*
@@ -423,7 +425,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 
 	pthread_mutex_unlock(&notes->lock);
 	symbol__tui_annotate(dl->ops.target.sym, ms->map, evsel, hbt, browser->opts);
-	sym_title(ms->sym, ms->map, title, sizeof(title));
+	sym_title(ms->sym, ms->map, title, sizeof(title), browser->opts->percent_type);
 	ui_browser__show_title(&browser->b, title);
 	return true;
 }
@@ -598,6 +600,7 @@ bool annotate_browser__continue_search_reverse(struct annotate_browser *browser,
 
 static int annotate_browser__show(struct ui_browser *browser, char *title, const char *help)
 {
+	struct annotate_browser *ab = container_of(browser, struct annotate_browser, b);
 	struct map_symbol *ms = browser->priv;
 	struct symbol *sym = ms->sym;
 	char symbol_dso[SYM_TITLE_MAX_SIZE];
@@ -605,7 +608,7 @@ static int annotate_browser__show(struct ui_browser *browser, char *title, const
 	if (ui_browser__show(browser, title, help) < 0)
 		return -1;
 
-	sym_title(sym, ms->map, symbol_dso, sizeof(symbol_dso));
+	sym_title(sym, ms->map, symbol_dso, sizeof(symbol_dso), ab->opts->percent_type);
 
 	ui_browser__gotorc_title(browser, 0, 0);
 	ui_browser__set_color(browser, HE_COLORSET_ROOT);
@@ -613,6 +616,39 @@ static int annotate_browser__show(struct ui_browser *browser, char *title, const
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
@@ -703,6 +739,8 @@ static int annotate_browser__run(struct annotate_browser *browser,
 		"k             Toggle line numbers\n"
 		"P             Print to [symbol_name].annotation file.\n"
 		"r             Run available scripts\n"
+		"p             Toggle percent type [local/global]\n"
+		"b             Toggle percent base [period/hits]\n"
 		"?             Search string backwards\n");
 			continue;
 		case 'r':
@@ -802,6 +840,12 @@ static int annotate_browser__run(struct annotate_browser *browser,
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
2.14.4

