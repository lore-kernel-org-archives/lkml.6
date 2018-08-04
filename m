Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A0EC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B28D217BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B28D217BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbeHDPG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 11:06:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726753AbeHDPG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 11:06:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 37F7E4074452;
        Sat,  4 Aug 2018 13:05:48 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9562D215670D;
        Sat,  4 Aug 2018 13:05:46 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 14/20] perf annotate: Pass struct annotation_options to map_symbol__annotation_dump
Date:   Sat,  4 Aug 2018 15:05:15 +0200
Message-Id: <20180804130521.11408-15-jolsa@kernel.org>
In-Reply-To: <20180804130521.11408-1-jolsa@kernel.org>
References: <20180804130521.11408-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Sat, 04 Aug 2018 13:05:48 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Sat, 04 Aug 2018 13:05:48 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing struct annotation_options to map_symbol__annotation_dump,
to carry on and pass the percent_type value.

Link: http://lkml.kernel.org/n/tip-5toohgdkgpk3vn6zebusr3bb@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/ui/browsers/annotate.c |  4 +--
 tools/perf/util/annotate.c        | 42 +++++++++++++++++--------------
 tools/perf/util/annotate.h        |  6 +++--
 3 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 81876c3923d2..cfe611c28987 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -115,7 +115,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 	if (!browser->navkeypressed)
 		ops.width += 1;
 
-	annotation_line__write(al, notes, &ops);
+	annotation_line__write(al, notes, &ops, ab->opts);
 
 	if (ops.current_entry)
 		ab->selection = al;
@@ -783,7 +783,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			continue;
 		}
 		case 'P':
-			map_symbol__annotation_dump(ms, evsel);
+			map_symbol__annotation_dump(ms, evsel, browser->opts);
 			continue;
 		case 't':
 			if (notes->options->show_total_period) {
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 2b06476c79c2..850958bb613a 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2156,10 +2156,11 @@ static void FILE__write_graph(void *fp, int graph)
 	fputs(s, fp);
 }
 
-static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp)
+static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp,
+				     struct annotation_options *opts)
 {
 	struct annotation *notes = symbol__annotation(sym);
-	struct annotation_write_ops ops = {
+	struct annotation_write_ops wops = {
 		.first_line		 = true,
 		.obj			 = fp,
 		.set_color		 = FILE__set_color,
@@ -2173,15 +2174,16 @@ static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp)
 	list_for_each_entry(al, &notes->src->source, node) {
 		if (annotation_line__filter(al, notes))
 			continue;
-		annotation_line__write(al, notes, &ops);
+		annotation_line__write(al, notes, &wops, opts);
 		fputc('\n', fp);
-		ops.first_line = false;
+		wops.first_line = false;
 	}
 
 	return 0;
 }
 
-int map_symbol__annotation_dump(struct map_symbol *ms, struct perf_evsel *evsel)
+int map_symbol__annotation_dump(struct map_symbol *ms, struct perf_evsel *evsel,
+				struct annotation_options *opts)
 {
 	const char *ev_name = perf_evsel__name(evsel);
 	char buf[1024];
@@ -2203,7 +2205,7 @@ int map_symbol__annotation_dump(struct map_symbol *ms, struct perf_evsel *evsel)
 
 	fprintf(fp, "%s() %s\nEvent: %s\n\n",
 		ms->sym->name, ms->map->dso->long_name, ev_name);
-	symbol__annotate_fprintf2(ms->sym, fp);
+	symbol__annotate_fprintf2(ms->sym, fp, opts);
 
 	fclose(fp);
 	err = 0;
@@ -2433,7 +2435,7 @@ int symbol__tty_annotate2(struct symbol *sym, struct map *map,
 
 	hists__scnprintf_title(hists, buf, sizeof(buf));
 	fprintf(stdout, "%s\n%s() %s\n", buf, sym->name, dso->long_name);
-	symbol__annotate_fprintf2(sym, stdout);
+	symbol__annotate_fprintf2(sym, stdout, opts);
 
 	annotated_source__purge(symbol__annotation(sym)->src);
 
@@ -2472,7 +2474,8 @@ bool ui__has_annotation(void)
 
 
 static double annotation_line__max_percent(struct annotation_line *al,
-					   struct annotation *notes)
+					   struct annotation *notes,
+					   unsigned int percent_type)
 {
 	double percent_max = 0.0;
 	int i;
@@ -2481,7 +2484,7 @@ static double annotation_line__max_percent(struct annotation_line *al,
 		double percent;
 
 		percent = annotation_data__percent(&al->data[i],
-						   PERCENT_HITS_LOCAL);
+						   percent_type);
 
 		if (percent > percent_max)
 			percent_max = percent;
@@ -2523,7 +2526,7 @@ static void disasm_line__write(struct disasm_line *dl, struct annotation *notes,
 
 static void __annotation_line__write(struct annotation_line *al, struct annotation *notes,
 				     bool first_line, bool current_entry, bool change_color, int width,
-				     void *obj,
+				     void *obj, unsigned int percent_type,
 				     int  (*obj__set_color)(void *obj, int color),
 				     void (*obj__set_percent_color)(void *obj, double percent, bool current),
 				     int  (*obj__set_jumps_percent_color)(void *obj, int nr, bool current),
@@ -2531,7 +2534,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 				     void (*obj__write_graph)(void *obj, int graph))
 
 {
-	double percent_max = annotation_line__max_percent(al, notes);
+	double percent_max = annotation_line__max_percent(al, notes, percent_type);
 	int pcnt_width = annotation__pcnt_width(notes),
 	    cycles_width = annotation__cycles_width(notes);
 	bool show_title = false;
@@ -2552,8 +2555,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 		for (i = 0; i < notes->nr_events; i++) {
 			double percent;
 
-			percent = annotation_data__percent(&al->data[i],
-							   PERCENT_HITS_LOCAL);
+			percent = annotation_data__percent(&al->data[i], percent_type);
 
 			obj__set_percent_color(obj, percent, current_entry);
 			if (notes->options->show_total_period) {
@@ -2680,13 +2682,15 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 }
 
 void annotation_line__write(struct annotation_line *al, struct annotation *notes,
-			    struct annotation_write_ops *ops)
+			    struct annotation_write_ops *wops,
+			    struct annotation_options *opts)
 {
-	__annotation_line__write(al, notes, ops->first_line, ops->current_entry,
-				 ops->change_color, ops->width, ops->obj,
-				 ops->set_color, ops->set_percent_color,
-				 ops->set_jumps_percent_color, ops->printf,
-				 ops->write_graph);
+	__annotation_line__write(al, notes, wops->first_line, wops->current_entry,
+				 wops->change_color, wops->width, wops->obj,
+				 opts->percent_type,
+				 wops->set_color, wops->set_percent_color,
+				 wops->set_jumps_percent_color, wops->printf,
+				 wops->write_graph);
 }
 
 int symbol__annotate2(struct symbol *sym, struct map *map, struct perf_evsel *evsel,
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 145dec845f33..3d4579e68d28 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -185,7 +185,8 @@ struct annotation_write_ops {
 };
 
 void annotation_line__write(struct annotation_line *al, struct annotation *notes,
-			    struct annotation_write_ops *ops);
+			    struct annotation_write_ops *ops,
+			    struct annotation_options *opts);
 
 int __annotation__scnprintf_samples_period(struct annotation *notes,
 					   char *bf, size_t size,
@@ -351,7 +352,8 @@ void symbol__annotate_zero_histogram(struct symbol *sym, int evidx);
 void symbol__annotate_decay_histogram(struct symbol *sym, int evidx);
 void annotated_source__purge(struct annotated_source *as);
 
-int map_symbol__annotation_dump(struct map_symbol *ms, struct perf_evsel *evsel);
+int map_symbol__annotation_dump(struct map_symbol *ms, struct perf_evsel *evsel,
+				struct annotation_options *opts);
 
 bool ui__has_annotation(void);
 
-- 
2.17.1

