Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091A2C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4456214FF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuxf2LQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4456214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732974AbeHIRZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:25:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732116AbeHIRZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:25:58 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1977221D62;
        Thu,  9 Aug 2018 15:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826840;
        bh=KMN7Tmz6wPQn1tgViVL9DuWnrrzC/tMo2LHgwHIS9Gk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cuxf2LQ+bXDcnO2pDrQCPRYlb6pT75cVnOpmT7dVPrw7QagRBAwtNaZHUTxpRFf1o
         65QAoZDAQLGPxTpt6065X4R63YqSo5irkS4tzrlEN5AVBEw/+2WC4agQYBoEsXmB+M
         BFNMxNBgyW0P4VrsqXKQnP8CC8Nl2EaOx5ORHblw=
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
Subject: [PATCH 26/44] perf annotate: Pass 'struct annotation_options' to map_symbol__annotation_dump()
Date:   Thu,  9 Aug 2018 11:58:04 -0300
Message-Id: <20180809145822.21391-27-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Pass 'struct annotation_options' to map_symbol__annotation_dump(), to
carry on and pass the percent_type value.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-15-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c |  4 ++--
 tools/perf/util/annotate.c        | 42 +++++++++++++++++++++------------------
 tools/perf/util/annotate.h        |  6 ++++--
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
2.14.4

