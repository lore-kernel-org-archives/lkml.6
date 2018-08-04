Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BEEC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1CA217BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1CA217BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbeHDPGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 11:06:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727980AbeHDPGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 11:06:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D6D32407049F;
        Sat,  4 Aug 2018 13:05:30 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F69B215670D;
        Sat,  4 Aug 2018 13:05:29 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 04/20] perf annotate: Rename struct annotation_line::samples* to data*
Date:   Sat,  4 Aug 2018 15:05:05 +0200
Message-Id: <20180804130521.11408-5-jolsa@kernel.org>
In-Reply-To: <20180804130521.11408-1-jolsa@kernel.org>
References: <20180804130521.11408-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Sat, 04 Aug 2018 13:05:31 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Sat, 04 Aug 2018 13:05:31 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name 'samples*' is little confusing because we have
nested 'struct sym_hist_entry' under annotation_line struct,
which holds 'nr_samples' as well.

Also the holding struct name is 'annotation_data' so the
'data' name fits better.

Link: http://lkml.kernel.org/n/tip-l4r03qp9b76ay98dlzgf6z2c@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/ui/browsers/annotate.c | 10 +++---
 tools/perf/util/annotate.c        | 52 +++++++++++++++----------------
 tools/perf/util/annotate.h        |  4 +--
 3 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index d264916d2648..d648d1e153f3 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -227,10 +227,10 @@ static int disasm__cmp(struct annotation_line *a, struct annotation_line *b)
 {
 	int i;
 
-	for (i = 0; i < a->samples_nr; i++) {
-		if (a->samples[i].percent == b->samples[i].percent)
+	for (i = 0; i < a->data_nr; i++) {
+		if (a->data[i].percent == b->data[i].percent)
 			continue;
-		return a->samples[i].percent < b->samples[i].percent;
+		return a->data[i].percent < b->data[i].percent;
 	}
 	return 0;
 }
@@ -314,8 +314,8 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 			continue;
 		}
 
-		for (i = 0; i < pos->al.samples_nr; i++) {
-			struct annotation_data *sample = &pos->al.samples[i];
+		for (i = 0; i < pos->al.data_nr; i++) {
+			struct annotation_data *sample = &pos->al.data[i];
 
 			if (max_percent < sample->percent)
 				max_percent = sample->percent;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 0d40cee13f6b..e4cb8963db1a 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1108,7 +1108,7 @@ annotation_line__new(struct annotate_args *args, size_t privsize)
 	if (perf_evsel__is_group_event(evsel))
 		nr = evsel->nr_members;
 
-	size += sizeof(al->samples[0]) * nr;
+	size += sizeof(al->data[0]) * nr;
 
 	al = zalloc(size);
 	if (al) {
@@ -1117,7 +1117,7 @@ annotation_line__new(struct annotate_args *args, size_t privsize)
 		al->offset     = args->offset;
 		al->line       = strdup(args->line);
 		al->line_nr    = args->line_nr;
-		al->samples_nr = nr;
+		al->data_nr    = nr;
 	}
 
 	return al;
@@ -1309,15 +1309,15 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 		const char *color;
 		struct annotation *notes = symbol__annotation(sym);
 
-		for (i = 0; i < al->samples_nr; i++) {
-			struct annotation_data *sample = &al->samples[i];
+		for (i = 0; i < al->data_nr; i++) {
+			struct annotation_data *sample = &al->data[i];
 
 			if (sample->percent > max_percent)
 				max_percent = sample->percent;
 		}
 
-		if (al->samples_nr > nr_percent)
-			nr_percent = al->samples_nr;
+		if (al->data_nr > nr_percent)
+			nr_percent = al->data_nr;
 
 		if (max_percent < min_pcnt)
 			return -1;
@@ -1351,7 +1351,7 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 		}
 
 		for (i = 0; i < nr_percent; i++) {
-			struct annotation_data *sample = &al->samples[i];
+			struct annotation_data *sample = &al->data[i];
 
 			color = get_percent_color(sample->percent);
 
@@ -1788,12 +1788,12 @@ static void annotation__calc_percent(struct annotation *notes,
 		next = annotation_line__next(al, &notes->src->source);
 		end  = next ? next->offset : len;
 
-		for (i = 0; i < al->samples_nr; i++) {
+		for (i = 0; i < al->data_nr; i++) {
 			struct annotation_data *sample;
 			struct sym_hist *hist;
 
 			hist   = annotation__histogram(notes, evsel->idx + i);
-			sample = &al->samples[i];
+			sample = &al->data[i];
 
 			calc_percent(hist, sample, al->offset, end);
 		}
@@ -1859,8 +1859,8 @@ static void insert_source_line(struct rb_root *root, struct annotation_line *al)
 
 		ret = strcmp(iter->path, al->path);
 		if (ret == 0) {
-			for (i = 0; i < al->samples_nr; i++)
-				iter->samples[i].percent_sum += al->samples[i].percent;
+			for (i = 0; i < al->data_nr; i++)
+				iter->data[i].percent_sum += al->data[i].percent;
 			return;
 		}
 
@@ -1870,8 +1870,8 @@ static void insert_source_line(struct rb_root *root, struct annotation_line *al)
 			p = &(*p)->rb_right;
 	}
 
-	for (i = 0; i < al->samples_nr; i++)
-		al->samples[i].percent_sum = al->samples[i].percent;
+	for (i = 0; i < al->data_nr; i++)
+		al->data[i].percent_sum = al->data[i].percent;
 
 	rb_link_node(&al->rb_node, parent, p);
 	rb_insert_color(&al->rb_node, root);
@@ -1881,10 +1881,10 @@ static int cmp_source_line(struct annotation_line *a, struct annotation_line *b)
 {
 	int i;
 
-	for (i = 0; i < a->samples_nr; i++) {
-		if (a->samples[i].percent_sum == b->samples[i].percent_sum)
+	for (i = 0; i < a->data_nr; i++) {
+		if (a->data[i].percent_sum == b->data[i].percent_sum)
 			continue;
-		return a->samples[i].percent_sum > b->samples[i].percent_sum;
+		return a->data[i].percent_sum > b->data[i].percent_sum;
 	}
 
 	return 0;
@@ -1949,8 +1949,8 @@ static void print_summary(struct rb_root *root, const char *filename)
 		int i;
 
 		al = rb_entry(node, struct annotation_line, rb_node);
-		for (i = 0; i < al->samples_nr; i++) {
-			percent = al->samples[i].percent_sum;
+		for (i = 0; i < al->data_nr; i++) {
+			percent = al->data[i].percent_sum;
 			color = get_percent_color(percent);
 			color_fprintf(stdout, color, " %7.2f", percent);
 
@@ -2355,10 +2355,10 @@ static void annotation__calc_lines(struct annotation *notes, struct map *map,
 		double percent_max = 0.0;
 		int i;
 
-		for (i = 0; i < al->samples_nr; i++) {
+		for (i = 0; i < al->data_nr; i++) {
 			struct annotation_data *sample;
 
-			sample = &al->samples[i];
+			sample = &al->data[i];
 
 			if (sample->percent > percent_max)
 				percent_max = sample->percent;
@@ -2448,8 +2448,8 @@ static double annotation_line__max_percent(struct annotation_line *al,
 	int i;
 
 	for (i = 0; i < notes->nr_events; i++) {
-		if (al->samples[i].percent > percent_max)
-			percent_max = al->samples[i].percent;
+		if (al->data[i].percent > percent_max)
+			percent_max = al->data[i].percent;
 	}
 
 	return percent_max;
@@ -2515,15 +2515,15 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 		int i;
 
 		for (i = 0; i < notes->nr_events; i++) {
-			obj__set_percent_color(obj, al->samples[i].percent, current_entry);
+			obj__set_percent_color(obj, al->data[i].percent, current_entry);
 			if (notes->options->show_total_period) {
-				obj__printf(obj, "%11" PRIu64 " ", al->samples[i].he.period);
+				obj__printf(obj, "%11" PRIu64 " ", al->data[i].he.period);
 			} else if (notes->options->show_nr_samples) {
 				obj__printf(obj, "%6" PRIu64 " ",
-						   al->samples[i].he.nr_samples);
+						   al->data[i].he.nr_samples);
 			} else {
 				obj__printf(obj, "%6.2f ",
-						   al->samples[i].percent);
+						   al->data[i].percent);
 			}
 		}
 	} else {
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index d06f14c656c6..58aa14c55bab 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -122,8 +122,8 @@ struct annotation_line {
 	char			*path;
 	u32			 idx;
 	int			 idx_asm;
-	int			 samples_nr;
-	struct annotation_data	 samples[0];
+	int			 data_nr;
+	struct annotation_data	 data[0];
 };
 
 struct disasm_line {
-- 
2.17.1

