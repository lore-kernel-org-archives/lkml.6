Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E1AC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1632421878
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1632421878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeHROhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:37:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56635 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeHROhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:37:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBTPZi1286073
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:29:25 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBTPbT1286070;
        Sat, 18 Aug 2018 04:29:25 -0700
Date:   Sat, 18 Aug 2018 04:29:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-6d9f0c2d5ef7568c29fa5927748c4915a9c7760a@git.kernel.org>
Cc:     eranian@google.com, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, dsahern@gmail.com, mingo@kernel.org,
        hpa@zytor.com, peterz@infradead.org, acme@redhat.com,
        jolsa@kernel.org, namhyung@kernel.org, linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          eranian@google.com, alexander.shishkin@linux.intel.com,
          dsahern@gmail.com, linux-kernel@vger.kernel.org,
          peterz@infradead.org, jolsa@kernel.org, namhyung@kernel.org,
          acme@redhat.com
In-Reply-To: <20180804130521.11408-9-jolsa@kernel.org>
References: <20180804130521.11408-9-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Switch struct
 annotation_data::percent to array
Git-Commit-ID: 6d9f0c2d5ef7568c29fa5927748c4915a9c7760a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6d9f0c2d5ef7568c29fa5927748c4915a9c7760a
Gitweb:     https://git.kernel.org/tip/6d9f0c2d5ef7568c29fa5927748c4915a9c7760a
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sat, 4 Aug 2018 15:05:09 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 8 Aug 2018 15:55:48 -0300

perf annotate: Switch struct annotation_data::percent to array

So we can hold multiple percent values for annotation line.

The first member of this array is current local hits percent value
(PERCENT_HITS_LOCAL index), so no functional change is expected.

Adding annotation_data__percent function to return requested percent
value from struct annotation_data.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c |  9 ++++---
 tools/perf/util/annotate.c        | 57 ++++++++++++++++++++++++++-------------
 tools/perf/util/annotate.h        | 13 ++++++++-
 3 files changed, 56 insertions(+), 23 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index d648d1e153f3..81876c3923d2 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -315,10 +315,13 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 		}
 
 		for (i = 0; i < pos->al.data_nr; i++) {
-			struct annotation_data *sample = &pos->al.data[i];
+			double percent;
 
-			if (max_percent < sample->percent)
-				max_percent = sample->percent;
+			percent = annotation_data__percent(&pos->al.data[i],
+							   PERCENT_HITS_LOCAL);
+
+			if (max_percent < percent)
+				max_percent = percent;
 		}
 
 		if (max_percent < 0.01 && pos->al.ipc == 0) {
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 34d4bb73aa84..074adb2a831e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1310,10 +1310,13 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 		struct annotation *notes = symbol__annotation(sym);
 
 		for (i = 0; i < al->data_nr; i++) {
-			struct annotation_data *data = &al->data[i];
+			double percent;
+
+			percent = annotation_data__percent(&al->data[i],
+							   PERCENT_HITS_LOCAL);
 
-			if (data->percent > max_percent)
-				max_percent = data->percent;
+			if (percent > max_percent)
+				max_percent = percent;
 		}
 
 		if (al->data_nr > nr_percent)
@@ -1352,8 +1355,10 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 
 		for (i = 0; i < nr_percent; i++) {
 			struct annotation_data *data = &al->data[i];
+			double percent;
 
-			color = get_percent_color(data->percent);
+			percent = annotation_data__percent(data, PERCENT_HITS_LOCAL);
+			color = get_percent_color(percent);
 
 			if (symbol_conf.show_total_period)
 				color_fprintf(stdout, color, " %11" PRIu64,
@@ -1362,7 +1367,7 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 				color_fprintf(stdout, color, " %7" PRIu64,
 					      data->he.nr_samples);
 			else
-				color_fprintf(stdout, color, " %7.2f", data->percent);
+				color_fprintf(stdout, color, " %7.2f", percent);
 		}
 
 		printf(" : ");
@@ -1769,7 +1774,7 @@ static void calc_percent(struct sym_hist *sym_hist,
 	if (sym_hist->nr_samples) {
 		data->he.period     = period;
 		data->he.nr_samples = hits;
-		data->percent = 100.0 * hits / sym_hist->nr_samples;
+		data->percent[PERCENT_HITS_LOCAL] = 100.0 * hits / sym_hist->nr_samples;
 	}
 }
 
@@ -1862,8 +1867,10 @@ static void insert_source_line(struct rb_root *root, struct annotation_line *al)
 
 		ret = strcmp(iter->path, al->path);
 		if (ret == 0) {
-			for (i = 0; i < al->data_nr; i++)
-				iter->data[i].percent_sum += al->data[i].percent;
+			for (i = 0; i < al->data_nr; i++) {
+				iter->data[i].percent_sum += annotation_data__percent(&al->data[i],
+										      PERCENT_HITS_LOCAL);
+			}
 			return;
 		}
 
@@ -1873,8 +1880,10 @@ static void insert_source_line(struct rb_root *root, struct annotation_line *al)
 			p = &(*p)->rb_right;
 	}
 
-	for (i = 0; i < al->data_nr; i++)
-		al->data[i].percent_sum = al->data[i].percent;
+	for (i = 0; i < al->data_nr; i++) {
+		al->data[i].percent_sum = annotation_data__percent(&al->data[i],
+								   PERCENT_HITS_LOCAL);
+	}
 
 	rb_link_node(&al->rb_node, parent, p);
 	rb_insert_color(&al->rb_node, root);
@@ -2359,12 +2368,13 @@ static void annotation__calc_lines(struct annotation *notes, struct map *map,
 		int i;
 
 		for (i = 0; i < al->data_nr; i++) {
-			struct annotation_data *data;
+			double percent;
 
-			data = &al->data[i];
+			percent = annotation_data__percent(&al->data[i],
+							   PERCENT_HITS_LOCAL);
 
-			if (data->percent > percent_max)
-				percent_max = data->percent;
+			if (percent > percent_max)
+				percent_max = percent;
 		}
 
 		if (percent_max <= 0.5)
@@ -2451,8 +2461,13 @@ static double annotation_line__max_percent(struct annotation_line *al,
 	int i;
 
 	for (i = 0; i < notes->nr_events; i++) {
-		if (al->data[i].percent > percent_max)
-			percent_max = al->data[i].percent;
+		double percent;
+
+		percent = annotation_data__percent(&al->data[i],
+						   PERCENT_HITS_LOCAL);
+
+		if (percent > percent_max)
+			percent_max = percent;
 	}
 
 	return percent_max;
@@ -2518,15 +2533,19 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 		int i;
 
 		for (i = 0; i < notes->nr_events; i++) {
-			obj__set_percent_color(obj, al->data[i].percent, current_entry);
+			double percent;
+
+			percent = annotation_data__percent(&al->data[i],
+							   PERCENT_HITS_LOCAL);
+
+			obj__set_percent_color(obj, percent, current_entry);
 			if (notes->options->show_total_period) {
 				obj__printf(obj, "%11" PRIu64 " ", al->data[i].he.period);
 			} else if (notes->options->show_nr_samples) {
 				obj__printf(obj, "%6" PRIu64 " ",
 						   al->data[i].he.nr_samples);
 			} else {
-				obj__printf(obj, "%6.2f ",
-						   al->data[i].percent);
+				obj__printf(obj, "%6.2f ", percent);
 			}
 		}
 	} else {
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 58aa14c55bab..0afbf8075fca 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -101,8 +101,13 @@ struct sym_hist_entry {
 	u64		period;
 };
 
+enum {
+	PERCENT_HITS_LOCAL,
+	PERCENT_MAX,
+};
+
 struct annotation_data {
-	double			 percent;
+	double			 percent[PERCENT_MAX];
 	double			 percent_sum;
 	struct sym_hist_entry	 he;
 };
@@ -134,6 +139,12 @@ struct disasm_line {
 	struct annotation_line	 al;
 };
 
+static inline double annotation_data__percent(struct annotation_data *data,
+					      unsigned int which)
+{
+	return which < PERCENT_MAX ? data->percent[which] : -1;
+}
+
 static inline struct disasm_line *disasm_line(struct annotation_line *al)
 {
 	return al ? container_of(al, struct disasm_line, al) : NULL;
